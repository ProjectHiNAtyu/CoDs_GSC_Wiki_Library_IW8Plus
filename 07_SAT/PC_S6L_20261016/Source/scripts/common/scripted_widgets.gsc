// scripts\common\scripted_widgets.gsc  (hash_372042ba4c85a452.gscc) (size: 75832 Bytes / 0x12838 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3db3b349 (1035187017)
// size ...... 75832 (0x12838)
// includes .. 3   (offset: 0x11b00)
// strings ... 48  (offset: 0x11b18)
// dev strs .. 129 (offset: 0x11f08)
// exports ... 182 (offset: 0xd974)
// cseg ...... 0x4f2 + 0xd482 (0xd974)
// imports ... 216 (offset: 0xf5e4)
// animtree1 . 0   (offset: 0x12838)
// animtree2 . 0   (offset: 0x12838)
#using scripts\common\devgui;
#using scripts\common\ui;
#using scripts\common\utility;

#namespace scripted_widgets;

// Namespace scripted_widgets
// Params 0, eflags: 0x4
// Checksum 0xf94f2a3d, Offset: 0x510
// Size: 0x49
function private function_1d678e943064d3c5()
{
    assert( isplayer( self ), "<dev string:x24>" );
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    assert( isdefined( level.scripted_widgets ), "<dev string:x10a>" );
    return isplayer( self );
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x9f0d0d54, Offset: 0x562
// Size: 0x28
function private normalize_asset_name( widget_name )
{
    if ( !isxhashasset( widget_name ) )
    {
        return hashcat( %"scriptedwidget:", widget_name );
    }
    
    return widget_name;
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0xfa76f7f3, Offset: 0x593
// Size: 0x1f
function private normalize_xhash( name )
{
    if ( !isxhash( name ) )
    {
        return getxhash( name );
    }
    
    return name;
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x96bf382c, Offset: 0x5bb
// Size: 0x1c
function private function_b2e49ff7cbc3fc1c( field )
{
    if ( !isdefined( field ) )
    {
        return;
    }
    
    return normalize_xhash( field );
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0xd8e7bb8a, Offset: 0x5e0
// Size: 0x1c
function private function_2ae2122ff77c7780( group_name )
{
    if ( !isdefined( group_name ) )
    {
        return;
    }
    
    return normalize_xhash( group_name );
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0xc093605c, Offset: 0x605
// Size: 0x14
function private function_c49c05628e6f2d4d( value )
{
    return "" + value;
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x25e04c21, Offset: 0x622
// Size: 0x138
function private function_f8c3ba20ce9d047c( collection )
{
    keys = [];
    sort_lookup = [];
    sort_values = [];
    
    if ( !isdefined( collection ) )
    {
        return keys;
    }
    
    foreach ( key, _ in collection )
    {
        if ( key == "__ordered_keys" )
        {
            continue;
        }
        
        sort_value = function_c49c05628e6f2d4d( key );
        sort_lookup[ sort_value ] = key;
        sort_values[ sort_values.size ] = sort_value;
    }
    
    sort_values = arraysort( sort_values );
    
    foreach ( _, sort_value in sort_values )
    {
        keys[ keys.size ] = sort_lookup[ sort_value ];
    }
    
    return keys;
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0xfd0eea8c, Offset: 0x763
// Size: 0x2cf
function private function_64834a051ef008e7( archetype_data )
{
    mappings = [];
    
    if ( !isdefined( archetype_data.asset_reference_mappings ) )
    {
        return mappings;
    }
    
    mapping_keys = function_f8c3ba20ce9d047c( archetype_data.asset_reference_mappings );
    
    for ( mapping_index = 0; mapping_index < mapping_keys.size ; mapping_index++ )
    {
        mapping_key = mapping_keys[ mapping_index ];
        mapping_data = archetype_data.asset_reference_mappings[ mapping_key ];
        mapping_name = mapping_data.mapping_name ?? mapping_key;
        
        if ( !isdefined( mapping_name ) || mapping_name == "" )
        {
            continue;
        }
        
        mapping = { #var_22ba2c5cf75665a7:0, #variant_count:0, #variants_by_type:[], #variants:[], #name:mapping_name };
        
        if ( isdefined( mapping_data.variants ) )
        {
            variant_keys = function_f8c3ba20ce9d047c( mapping_data.variants );
            
            for ( variant_index = 0; variant_index < variant_keys.size ; variant_index++ )
            {
                variant_key = variant_keys[ variant_index ];
                variant_data = mapping_data.variants[ variant_key ];
                asset_reference_type = variant_data.asset_reference_type ?? variant_key;
                
                if ( !isdefined( asset_reference_type ) || asset_reference_type == "" )
                {
                    continue;
                }
                
                variant = { #field_mappings:[], #type_index:variant_index + 1, #asset_reference_type:asset_reference_type };
                
                if ( isdefined( variant_data.field_mappings ) )
                {
                    var_cb015e54fc85ca24 = function_f8c3ba20ce9d047c( variant_data.field_mappings );
                    
                    for ( var_1ec942560f8bf9bc = 0; var_1ec942560f8bf9bc < var_cb015e54fc85ca24.size ; var_1ec942560f8bf9bc++ )
                    {
                        var_dd671395bfe1513f = var_cb015e54fc85ca24[ var_1ec942560f8bf9bc ];
                        field_mapping = variant_data.field_mappings[ var_dd671395bfe1513f ];
                        projected_field = field_mapping.projected_field ?? var_dd671395bfe1513f;
                        
                        if ( projected_field )
                        {
                            variant.field_mappings[ projected_field ] = { #source_field:field_mapping.source_field };
                        }
                    }
                }
                
                mapping.variants[ variant.type_index ] = variant;
                mapping.variants_by_type[ asset_reference_type ] = variant;
                mapping.variant_count = variant.type_index;
            }
        }
        
        if ( mapping.variant_count > 0 )
        {
            mapping.var_22ba2c5cf75665a7 = 65535;
        }
        
        mappings[ mapping_name ] = mapping;
    }
    
    return mappings;
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0xd359a890, Offset: 0xa3b
// Size: 0x97
function private function_3951b77e6bcd509c( asset_reference_type )
{
    var_dfd1a6ce0f779cf2 = level.scripted_widgets.var_dfd1a6ce0f779cf2;
    
    if ( isdefined( var_dfd1a6ce0f779cf2[ asset_reference_type ] ) )
    {
        cached = var_dfd1a6ce0f779cf2[ asset_reference_type ];
        
        if ( cached == #"" )
        {
            return;
        }
        
        return cached;
    }
    
    ncs_xhash = getxhash( "scriptbundle_" + asset_reference_type );
    ncs_type_id = function_b1f871bbaa4a1bc0( ncs_xhash );
    
    if ( isdefined( ncs_type_id ) )
    {
        var_dfd1a6ce0f779cf2[ asset_reference_type ] = ncs_xhash;
        return ncs_xhash;
    }
    
    var_dfd1a6ce0f779cf2[ asset_reference_type ] = #"";
}

// Namespace scripted_widgets
// Params 4, eflags: 0x4
// Checksum 0xe46182da, Offset: 0xadb
// Size: 0xd0
function private function_d86cf49b58819f29( asset_reference_type, value, field_name, var_ec8ce643b74e5e5f )
{
    if ( isstring( value ) )
    {
        value = getxhashasset( asset_reference_type + ":" + value );
    }
    else if ( !isxhashasset( value ) )
    {
        return value;
    }
    
    ncs_type = function_3951b77e6bcd509c( asset_reference_type );
    ncs_type = ncs_type ?? #"hash_817f89efc1cd4c23";
    asset_index = function_43b5ed5a14a56573( ncs_type, value );
    assert( isdefined( asset_index ), "<dev string:x148>" + function_886d6ce36915ff2c( field_name ) + "<dev string:x178>" + getxhashsourcename( var_ec8ce643b74e5e5f ) + "<dev string:x192>" + getxhashsourcename( value ) + "<dev string:x1a2>" );
    
    if ( isdefined( asset_index ) )
    {
        return ( asset_index + 1 );
    }
    
    return asset_index;
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0xb5e6a1a, Offset: 0xbb4
// Size: 0x30
function private function_886d6ce36915ff2c( field )
{
    field = function_b2e49ff7cbc3fc1c( field );
    
    /#
        if ( isdefined( field ) )
        {
            return getxhashsourcename( field );
        }
    #/
    
    return field ?? "";
}

// Namespace scripted_widgets
// Params 4, eflags: 0x4
// Checksum 0xd27edde2, Offset: 0xbed
// Size: 0x380
function private function_1969bbce2ecdd7a6( value, field_data, field_name, var_ec8ce643b74e5e5f )
{
    asset_reference_mapping = field_data.asset_reference_mapping;
    
    if ( isdefined( asset_reference_mapping ) )
    {
        asset_reference_type = undefined;
        asset_reference_value = undefined;
        
        if ( isstring( value ) || isxhashasset( value ) )
        {
            if ( asset_reference_mapping.variant_count == 1 && isdefined( asset_reference_mapping.variants[ 1 ] ) )
            {
                asset_reference_type = asset_reference_mapping.variants[ 1 ].asset_reference_type;
                asset_reference_value = value;
            }
            else if ( isstring( value ) )
            {
                for ( variant_index = 1; variant_index <= asset_reference_mapping.variant_count ; variant_index++ )
                {
                    variant = asset_reference_mapping.variants[ variant_index ];
                    
                    if ( !isdefined( variant ) )
                    {
                        continue;
                    }
                    
                    asset_index = function_d86cf49b58819f29( variant.asset_reference_type, value, field_name, var_ec8ce643b74e5e5f );
                    
                    if ( isdefined( asset_index ) )
                    {
                        return ( variant.type_index * ( asset_reference_mapping.var_22ba2c5cf75665a7 + 1 ) + asset_index );
                    }
                }
                
                return value;
            }
            else
            {
                for ( variant_index = 1; variant_index <= asset_reference_mapping.variant_count ; variant_index++ )
                {
                    variant = asset_reference_mapping.variants[ variant_index ];
                    
                    if ( !isdefined( variant ) )
                    {
                        continue;
                    }
                    
                    ncs_type = function_3951b77e6bcd509c( variant.asset_reference_type );
                    
                    if ( isdefined( ncs_type ) )
                    {
                        asset_index = function_43b5ed5a14a56573( ncs_type, value );
                        
                        if ( isdefined( asset_index ) )
                        {
                            return ( variant.type_index * ( asset_reference_mapping.var_22ba2c5cf75665a7 + 1 ) + asset_index + 1 );
                        }
                    }
                }
                
                asset_index = function_43b5ed5a14a56573( #"hash_817f89efc1cd4c23", value );
                
                if ( isdefined( asset_index ) )
                {
                    return ( asset_index + 1 );
                }
                
                return value;
            }
        }
        else if ( isdefined( value.asset_ref ) || isdefined( value.asset_type ) || isdefined( value.asset_reference_type ) )
        {
            asset_reference_type = value.asset_type;
            
            if ( !isdefined( asset_reference_type ) )
            {
                asset_reference_type = value.asset_reference_type;
            }
            
            asset_reference_value = value.asset_ref;
        }
        else
        {
            return value;
        }
        
        if ( !isdefined( asset_reference_type ) && asset_reference_mapping.variant_count == 1 && isdefined( asset_reference_mapping.variants[ 1 ] ) )
        {
            asset_reference_type = asset_reference_mapping.variants[ 1 ].asset_reference_type;
        }
        
        if ( !isdefined( asset_reference_value ) || isstring( asset_reference_value ) && asset_reference_value == "" )
        {
            return 0;
        }
        
        variant = isdefined( asset_reference_type ) ? asset_reference_mapping.variants_by_type[ asset_reference_type ] : undefined;
        assert( isdefined( variant ), "<dev string:x1a5>" + asset_reference_type + "<dev string:x1ca>" + function_886d6ce36915ff2c( field_name ) + "<dev string:x178>" + getxhashsourcename( var_ec8ce643b74e5e5f ) + "<dev string:x1a2>" );
        
        if ( !isdefined( variant ) )
        {
            return value;
        }
        
        asset_index = function_d86cf49b58819f29( asset_reference_type, asset_reference_value, field_name, var_ec8ce643b74e5e5f );
        
        if ( isdefined( asset_index ) )
        {
            if ( asset_reference_mapping.variant_count == 1 )
            {
                return asset_index;
            }
            
            return ( variant.type_index * ( asset_reference_mapping.var_22ba2c5cf75665a7 + 1 ) + asset_index );
        }
        
        return asset_index;
    }
    
    asset_reference_type = field_data.asset_reference_type;
    
    if ( !isdefined( asset_reference_type ) )
    {
        return value;
    }
    
    return function_d86cf49b58819f29( asset_reference_type, value, field_name, var_ec8ce643b74e5e5f );
}

// Namespace scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0x93a567d2, Offset: 0xf76
// Size: 0x22
function private get_anchored_ref( anchor_ent, widget_ref )
{
    return tolower( widget_ref ) + anchor_ent getentitynumber();
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x89b7a42b, Offset: 0xfa1
// Size: 0x64
function private get_archetype_data( widget_type )
{
    data = level.scripted_widgets;
    return data.widget_types[ widget_type ].archetype ? data.archetypes[ data.widget_types[ widget_type ].archetype ] : undefined;
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x160e1948, Offset: 0x100e
// Size: 0x44, Type: bool
function private get_widget_data_layout( widget_type )
{
    data = level.scripted_widgets;
    return data.widget_types[ widget_type ].data_layout ?? get_archetype_data( widget_type );
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x16ce6882, Offset: 0x105b
// Size: 0x142
function private function_3b09c895dc8c4774( field_data )
{
    cloned_field_data = { #mask:field_data.mask, #shift:field_data.shift, #step_increment:field_data.step_increment, #max_value:field_data.max_value, #min_value:field_data.min_value, #bits:field_data.bits };
    
    if ( isdefined( field_data.expanded_data_omnvar ) )
    {
        cloned_field_data.expanded_data_omnvar = field_data.expanded_data_omnvar;
        cloned_field_data.var_d1d990df30825593 = field_data.var_d1d990df30825593;
    }
    
    if ( isdefined( field_data.asset_reference_type ) )
    {
        cloned_field_data.asset_reference_type = field_data.asset_reference_type;
    }
    
    if ( isdefined( field_data.var_ce2b404a6842803d ) )
    {
        cloned_field_data.var_ce2b404a6842803d = field_data.var_ce2b404a6842803d;
    }
    
    if ( isdefined( field_data.asset_reference_mapping ) )
    {
        cloned_field_data.asset_reference_mapping = field_data.asset_reference_mapping;
    }
    
    return cloned_field_data;
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x31d344ec, Offset: 0x11a6
// Size: 0x172
function private function_c47a6d5ae657f524( field_groups )
{
    cloned_groups = [];
    
    if ( !isdefined( field_groups ) )
    {
        return cloned_groups;
    }
    
    foreach ( group_name, group_data in field_groups )
    {
        cloned_groups[ group_name ] = { #fields:[], #count:group_data.count };
        
        for ( group_index = 0; group_index < group_data.count ; group_index++ )
        {
            cloned_groups[ group_name ].fields[ group_index ] = [];
            
            foreach ( field_name, field_data in group_data.fields[ group_index ] )
            {
                cloned_groups[ group_name ].fields[ group_index ][ field_name ] = function_3b09c895dc8c4774( field_data );
            }
        }
    }
    
    return cloned_groups;
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0xf288c5e6, Offset: 0x1321
// Size: 0x3b7
function private function_7a925e75f8174403( data_layout )
{
    var_ce2c3c2e107514d0 = data_layout.var_ce2c3c2e107514d0 ?? 0;
    var_181fa8d67027a351 = -1;
    
    if ( var_ce2c3c2e107514d0 > 0 )
    {
        var_181fa8d67027a351 = data_layout.var_dcab5b5545e553c4;
    }
    
    pack_state = { #var_bdfd8ec86136a614:32, #var_181fa8d67027a351:var_181fa8d67027a351, #var_ce2c3c2e107514d0:var_ce2c3c2e107514d0, #shift:0 };
    
    if ( pack_state.var_ce2c3c2e107514d0 > 0 )
    {
        pack_state.var_bdfd8ec86136a614 = level.scripted_widgets.var_5efe4ada2f42ba2f[ pack_state.var_181fa8d67027a351 ].bits;
        final_set_index = pack_state.var_ce2c3c2e107514d0 - 1;
        final_omnvar_name = level.scripted_widgets.var_5efe4ada2f42ba2f[ pack_state.var_181fa8d67027a351 ].name;
    }
    else
    {
        final_set_index = undefined;
        final_omnvar_name = undefined;
    }
    
    foreach ( _, field_data in data_layout.fields )
    {
        if ( !isdefined( final_set_index ) )
        {
            if ( !isdefined( field_data.var_d1d990df30825593 ) )
            {
                pack_state.shift = max( pack_state.shift, field_data.shift + field_data.bits );
            }
            
            continue;
        }
        
        if ( field_data.var_d1d990df30825593 == final_set_index && field_data.expanded_data_omnvar == final_omnvar_name )
        {
            pack_state.shift = max( pack_state.shift, field_data.shift + field_data.bits );
        }
    }
    
    foreach ( _, group_data in data_layout.field_groups )
    {
        for ( group_index = 0; group_index < group_data.count ; group_index++ )
        {
            foreach ( _, field_data in group_data.fields[ group_index ] )
            {
                if ( !isdefined( final_set_index ) )
                {
                    if ( !isdefined( field_data.var_d1d990df30825593 ) )
                    {
                        pack_state.shift = max( pack_state.shift, field_data.shift + field_data.bits );
                    }
                    
                    continue;
                }
                
                if ( field_data.var_d1d990df30825593 == final_set_index && field_data.expanded_data_omnvar == final_omnvar_name )
                {
                    pack_state.shift = max( pack_state.shift, field_data.shift + field_data.bits );
                }
            }
        }
    }
    
    return pack_state;
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x2869b4d0, Offset: 0x16e1
// Size: 0x22
function private function_3da86c67b8f46b84( reference )
{
    return getxhash( "interact_flags_" + getxhashhexname( normalize_xhash( reference ) ) );
}

// Namespace scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0x4252b045, Offset: 0x170c
// Size: 0x571
function private function_440ebf83a736e17f( widget_type, widget_data )
{
    data = level.scripted_widgets;
    widget_struct = data.widget_types[ widget_type ];
    base_layout = widget_struct.archetype ? data.archetypes[ widget_struct.archetype ] : undefined;
    var_4ee02ada7cd2e025 = 0;
    
    if ( isdefined( widget_data.interactions ) )
    {
        foreach ( interaction in widget_data.interactions )
        {
            if ( interaction.var_4077f60906440889 )
            {
                var_4ee02ada7cd2e025 = 1;
                break;
            }
        }
    }
    
    if ( !isdefined( base_layout ) && !var_4ee02ada7cd2e025 )
    {
        return;
    }
    
    if ( !var_4ee02ada7cd2e025 )
    {
        return base_layout;
    }
    
    data_layout = { #field_groups:[], #fields:[] };
    
    if ( isdefined( base_layout ) )
    {
        if ( isdefined( base_layout.asset_reference_mappings ) )
        {
            data_layout.asset_reference_mappings = base_layout.asset_reference_mappings;
        }
        
        foreach ( field_name, field_data in base_layout.fields )
        {
            data_layout.fields[ field_name ] = function_3b09c895dc8c4774( field_data );
        }
        
        data_layout.field_groups = function_c47a6d5ae657f524( base_layout.field_groups );
        
        if ( isdefined( base_layout.var_ce2c3c2e107514d0 ) )
        {
            data_layout.var_ce2c3c2e107514d0 = base_layout.var_ce2c3c2e107514d0;
            data_layout.var_dcab5b5545e553c4 = base_layout.var_dcab5b5545e553c4;
        }
    }
    
    widget_struct.var_b2b22461873975c1 = [];
    pack_state = function_7a925e75f8174403( data_layout );
    var_5efe4ada2f42ba2f = level.scripted_widgets.var_5efe4ada2f42ba2f;
    
    foreach ( interaction_index, interaction in widget_data.interactions )
    {
        if ( !interaction.var_4077f60906440889 )
        {
            continue;
        }
        
        assert( isdefined( interaction.reference ) && interaction.reference != #"", "<dev string:x1d8>" + getxhashsourcename( widget_type ) + "<dev string:x1a2>" );
        
        if ( !isdefined( interaction.reference ) || interaction.reference == #"" )
        {
            continue;
        }
        
        bits = 2;
        
        while ( bits + pack_state.shift > pack_state.var_bdfd8ec86136a614 )
        {
            pack_state.shift = 0;
            pack_state.var_181fa8d67027a351 = ( pack_state.var_181fa8d67027a351 + 1 ) % var_5efe4ada2f42ba2f.size;
            pack_state.var_bdfd8ec86136a614 = var_5efe4ada2f42ba2f[ pack_state.var_181fa8d67027a351 ].bits;
            
            if ( pack_state.var_181fa8d67027a351 == 0 )
            {
                pack_state.var_ce2c3c2e107514d0++;
            }
        }
        
        reference = normalize_xhash( interaction.reference );
        field_name = function_3da86c67b8f46b84( reference );
        field_data = { #mask:( 1 << bits ) - 1 << pack_state.shift, #shift:pack_state.shift, #step_increment:1, #max_value:3, #min_value:0, #bits:bits };
        
        if ( pack_state.var_ce2c3c2e107514d0 > 0 )
        {
            field_data.expanded_data_omnvar = var_5efe4ada2f42ba2f[ pack_state.var_181fa8d67027a351 ].name;
            field_data.var_d1d990df30825593 = pack_state.var_ce2c3c2e107514d0 - 1;
            data_layout.var_ce2c3c2e107514d0 = pack_state.var_ce2c3c2e107514d0;
            data_layout.var_dcab5b5545e553c4 = pack_state.var_181fa8d67027a351;
            data.var_85cc405a98ca4c14 = 1;
        }
        
        data_layout.fields[ field_name ] = field_data;
        widget_struct.var_b2b22461873975c1[ reference ] = { #index:interaction_index, #field:field_name };
        pack_state.shift += bits;
    }
    
    return data_layout;
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0xd594d69f, Offset: 0x1c86
// Size: 0x3c
function private function_8d8fc3f61711bc6d( widget_type )
{
    data_layout = get_widget_data_layout( widget_type );
    return 1 + ( isdefined( data_layout ) ? data_layout.var_ce2c3c2e107514d0 ?? 0 : 0 );
}

// Namespace scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0xc1393c4b, Offset: 0x1ccb
// Size: 0x58, Type: bool
function private is_chain_available( seed_index, expanded_count )
{
    test_index = seed_index;
    
    for ( j = 0; j < expanded_count ; j++ )
    {
        test_index = function_31acd2506afda85( test_index );
        
        if ( self.var_be61ad67e9b09fb[ test_index ] )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace scripted_widgets
// Params 5, eflags: 0x4
// Checksum 0x8442c9d8, Offset: 0x1d2c
// Size: 0xc6
function private function_fe3e55d975ec3042( map_info_bundle, game_type_bundle, game_mode_bundle, project_bundle, field )
{
    if ( isdefined( map_info_bundle ) && map_info_bundle.field > 0 )
    {
        return map_info_bundle.field;
    }
    else if ( isdefined( game_type_bundle ) && game_type_bundle.field > 0 )
    {
        return game_type_bundle.field;
    }
    else if ( isdefined( game_mode_bundle ) && game_mode_bundle.field > 0 )
    {
        return game_mode_bundle.field;
    }
    else if ( isdefined( project_bundle ) && project_bundle.field > 0 )
    {
        return project_bundle.field;
    }
    
    return 0;
}

// Namespace scripted_widgets/scripted_widgets_init
// Params 0, eflags: 0x24
// Checksum 0x18e8e03f, Offset: 0x1dfb
// Size: 0x144
function private event_handler[scripted_widgets_init] function_acc2a4009ebbc33f()
{
    if ( !isdefined( level.scripted_widgets ) )
    {
        level.scripted_widgets = {};
    }
    
    if ( !isdefined( level.scripted_widgets.var_5efe4ada2f42ba2f ) )
    {
        level.scripted_widgets.var_5efe4ada2f42ba2f = [ { #bits:32, #name:"data_" }, { #bits:32, #name:"position_" }, { #bits:32, #name:"hud_" }, { #bits:32, #name:"time_" } ];
    }
    
    level.scripted_widgets.var_85cc405a98ca4c14 = 0;
    init_from_scriptbundles();
    ui::lui_registercallback( "scripted_widget_closed", &closed );
    ui::lui_registercallback( "scripted_widget_interaction", &interaction );
    ui::lui_registercallback( "scripted_widget_streamed", &streamed );
    ui::lui_registercallback( "scripted_widget_message", &message );
    level utility::flag_set( "scripted_widgets_initialized" );
    
    /#
        if ( getdvarint( @"hash_e1b0d2c82cc27c11", 0 ) )
        {
            level thread devgui_setup();
        }
    #/
}

// Namespace scripted_widgets
// Params 0, eflags: 0x4
// Checksum 0x2d8382eb, Offset: 0x1f47
// Size: 0xefd
function private init_from_scriptbundles()
{
    scripted_widgets = getscriptbundlenames( "scriptedwidget" );
    archetypes = getscriptbundlenames( "scriptedwidgetarchetype" );
    anchors = getscriptbundlenames( "scriptedwidgetanchorsettings" );
    data = level.scripted_widgets;
    data.widget_types = [];
    data.widget_type_indices = [];
    data.anchor_types = [];
    data.archetypes = [];
    data.list_widget_data = {};
    data.streamer_hints = [];
    data.streamed_widgets = [];
    data.var_dfd1a6ce0f779cf2 = [];
    project_bundle = getprojectscriptbundle();
    game_mode_bundle = getgamemodescriptbundle();
    game_type_bundle = getgametypescriptbundle();
    map_info_bundle = getactivemapinfobundle();
    
    if ( !isdefined( map_info_bundle ) )
    {
        map_info_bundle = getmapinfobundle( getdvar( @"ui_mapname" ) );
    }
    
    if ( isdefined( map_info_bundle ) && map_info_bundle.scriptedwidgetsmax > 0 )
    {
        data.max_widgets = map_info_bundle.scriptedwidgetsmax;
    }
    else if ( isdefined( game_type_bundle ) && game_type_bundle.scriptedwidgetsmax > 0 )
    {
        data.max_widgets = game_type_bundle.scriptedwidgetsmax;
    }
    else if ( isdefined( game_mode_bundle ) && game_mode_bundle.scriptedwidgetsmax > 0 )
    {
        data.max_widgets = game_mode_bundle.scriptedwidgetsmax;
    }
    else if ( isdefined( project_bundle ) && project_bundle.scriptedwidgetsmax > 0 )
    {
        data.max_widgets = project_bundle.scriptedwidgetsmax;
    }
    
    var_3c987bf0b168c33f = 0;
    
    if ( isdefined( map_info_bundle ) && map_info_bundle.var_53ba99430790c622 > 0 )
    {
        var_3c987bf0b168c33f = map_info_bundle.var_53ba99430790c622;
    }
    else if ( isdefined( game_type_bundle ) && game_type_bundle.var_53ba99430790c622 > 0 )
    {
        var_3c987bf0b168c33f = game_type_bundle.var_53ba99430790c622;
    }
    else if ( isdefined( game_mode_bundle ) && game_mode_bundle.var_53ba99430790c622 > 0 )
    {
        var_3c987bf0b168c33f = game_mode_bundle.var_53ba99430790c622;
    }
    else if ( isdefined( project_bundle ) && project_bundle.var_53ba99430790c622 > 0 )
    {
        var_3c987bf0b168c33f = project_bundle.var_53ba99430790c622;
    }
    
    if ( isdefined( archetypes ) )
    {
        var_2dc3906d7d3f59af = level.scripted_widgets.var_5efe4ada2f42ba2f;
        
        foreach ( archetype in archetypes )
        {
            archetype_data = getscriptbundle( archetype );
            
            if ( isdefined( archetype_data ) && !isdefined( data.archetypes[ archetype ] ) )
            {
                asset_reference_mappings = function_64834a051ef008e7( archetype_data );
                data.archetypes[ archetype ] = { #asset_reference_mappings:asset_reference_mappings, #field_groups:[], #fields:[] };
                var_92a539adc9798e42 = [];
                
                foreach ( field, field_data in archetype_data.fields )
                {
                    field = function_b2e49ff7cbc3fc1c( field );
                    
                    if ( field_data.datasource_only )
                    {
                        continue;
                    }
                    
                    asset_reference_type = field_data.asset_reference_type;
                    var_ce2b404a6842803d = field_data.asset_reference_mapping;
                    asset_reference_mapping = var_ce2b404a6842803d ? asset_reference_mappings[ var_ce2b404a6842803d ] : undefined;
                    
                    if ( isdefined( asset_reference_mapping ) )
                    {
                        asset_reference_type = undefined;
                    }
                    
                    var_92a539adc9798e42[ field ] = { #asset_reference_mapping:asset_reference_mapping, #var_ce2b404a6842803d:var_ce2b404a6842803d, #asset_reference_type:asset_reference_type, #step_increment:field_data.step_increment ?? 0, #max_value:field_data.max_value ?? 0, #min_value:field_data.min_value ?? 0 };
                }
                
                var_a3f64e3a27de8cae = [];
                
                if ( isdefined( archetype_data.fieldgroups ) )
                {
                    foreach ( group_name, group_data in archetype_data.fieldgroups )
                    {
                        group_name = function_2ae2122ff77c7780( group_name );
                        group_count = group_data.count ?? 1;
                        data.archetypes[ archetype ].field_groups[ group_name ] = { #fields:[], #count:group_count };
                        
                        for ( group_index = 0; group_index < group_count ; group_index++ )
                        {
                            data.archetypes[ archetype ].field_groups[ group_name ].fields[ group_index ] = [];
                        }
                        
                        var_a3f64e3a27de8cae[ group_name ] = [];
                        
                        foreach ( group_field, group_field_data in group_data.fields )
                        {
                            group_field = function_b2e49ff7cbc3fc1c( group_field );
                            
                            if ( group_field_data.datasource_only )
                            {
                                continue;
                            }
                            
                            var_f23d43340e5645ad = group_field_data.asset_reference_type;
                            var_3b0d4c0fc9cbaed = group_field_data.asset_reference_mapping;
                            var_11c16f088d15c7a5 = var_3b0d4c0fc9cbaed ? asset_reference_mappings[ var_3b0d4c0fc9cbaed ] : undefined;
                            
                            if ( isdefined( var_11c16f088d15c7a5 ) )
                            {
                                var_f23d43340e5645ad = undefined;
                            }
                            
                            var_a3f64e3a27de8cae[ group_name ][ group_field ] = { #asset_reference_mapping:var_11c16f088d15c7a5, #var_ce2b404a6842803d:var_3b0d4c0fc9cbaed, #asset_reference_type:var_f23d43340e5645ad, #step_increment:group_field_data.step_increment ?? 0, #max_value:group_field_data.max_value ?? 0, #min_value:group_field_data.min_value ?? 0 };
                        }
                    }
                }
                
                packing_order = function_c3219b74350b07ad( archetype );
                
                /#
                    if ( getdvarint( @"hash_8c3631c954c9e749", 0 ) != 0 )
                    {
                        println( "<dev string:x231>" + getxhashsourcename( archetype ) );
                        
                        foreach ( slot in packing_order )
                        {
                            if ( isdefined( slot.group_name ) )
                            {
                                println( "<dev string:x260>" + getxhashsourcename( slot.group_name ) + "<dev string:x269>" + slot.group_index + "<dev string:x26b>" + getxhashsourcename( slot.field ) + "<dev string:x274>" + slot.bits );
                                continue;
                            }
                            
                            println( "<dev string:x27b>" + getxhashsourcename( slot.field ) + "<dev string:x274>" + slot.bits );
                        }
                    }
                #/
                
                shift = 0;
                var_181fa8d67027a351 = -1;
                var_ce2c3c2e107514d0 = 0;
                var_bdfd8ec86136a614 = 32;
                
                foreach ( slot in packing_order )
                {
                    bits = slot.bits;
                    
                    while ( bits + shift > var_bdfd8ec86136a614 )
                    {
                        shift = 0;
                        var_181fa8d67027a351 = ( var_181fa8d67027a351 + 1 ) % var_2dc3906d7d3f59af.size;
                        var_bdfd8ec86136a614 = var_2dc3906d7d3f59af[ var_181fa8d67027a351 ].bits;
                        
                        if ( var_181fa8d67027a351 == 0 )
                        {
                            var_ce2c3c2e107514d0++;
                        }
                    }
                    
                    if ( isdefined( slot.group_name ) )
                    {
                        meta = var_a3f64e3a27de8cae[ slot.group_name ][ slot.field ];
                    }
                    else
                    {
                        meta = var_92a539adc9798e42[ slot.field ];
                    }
                    
                    packed_field_data = { #mask:( 1 << bits ) - 1 << shift, #shift:shift, #step_increment:meta.step_increment, #max_value:meta.max_value, #min_value:meta.min_value, #bits:bits };
                    
                    if ( isdefined( meta.asset_reference_type ) )
                    {
                        packed_field_data.asset_reference_type = meta.asset_reference_type;
                    }
                    
                    if ( isdefined( meta.var_ce2b404a6842803d ) )
                    {
                        packed_field_data.var_ce2b404a6842803d = meta.var_ce2b404a6842803d;
                    }
                    
                    if ( isdefined( meta.asset_reference_mapping ) )
                    {
                        packed_field_data.asset_reference_mapping = meta.asset_reference_mapping;
                    }
                    
                    if ( var_ce2c3c2e107514d0 > 0 )
                    {
                        packed_field_data.expanded_data_omnvar = var_2dc3906d7d3f59af[ var_181fa8d67027a351 ].name;
                        packed_field_data.var_d1d990df30825593 = var_ce2c3c2e107514d0 - 1;
                    }
                    
                    if ( isdefined( slot.group_name ) )
                    {
                        data.archetypes[ archetype ].field_groups[ slot.group_name ].fields[ slot.group_index ][ slot.field ] = packed_field_data;
                    }
                    else
                    {
                        data.archetypes[ archetype ].fields[ slot.field ] = packed_field_data;
                    }
                    
                    shift += bits;
                }
                
                if ( var_ce2c3c2e107514d0 > 0 )
                {
                    data.archetypes[ archetype ].var_ce2c3c2e107514d0 = var_ce2c3c2e107514d0;
                    data.archetypes[ archetype ].var_dcab5b5545e553c4 = var_181fa8d67027a351;
                    data.var_85cc405a98ca4c14 = 1;
                }
            }
        }
    }
    
    if ( isdefined( anchors ) )
    {
        sorted_anchors = tablesort( anchors );
        
        foreach ( index in sorted_anchors )
        {
            anchor = anchors[ index ];
            anchor_data = getscriptbundle( anchor );
            
            if ( isdefined( anchor_data ) && !isdefined( data.anchor_types[ anchor ] ) )
            {
                data.anchor_types[ anchor ] = data.anchor_types.size;
            }
        }
    }
    
    if ( isdefined( scripted_widgets ) )
    {
        sorted_widgets = tablesort( scripted_widgets );
        
        /#
            if ( getdvarint( @"hash_8c3631c954c9e749", 0 ) != 0 )
            {
                println( "<dev string:x284>" );
            }
        #/
        
        foreach ( index in sorted_widgets )
        {
            widget = scripted_widgets[ index ];
            function_f3389690c9a25255( widget );
        }
    }
    
    if ( var_3c987bf0b168c33f > 0 )
    {
        data.list_widget_data.max_items = var_3c987bf0b168c33f;
        data.list_widget_data.num_groups = ceil( data.list_widget_data.max_items / 8 );
        data.list_widget_data.group_mask = 0;
        data.list_widget_data.group_shift = 0;
        
        if ( data.list_widget_data.num_groups > 1 )
        {
            data.list_widget_data.group_mask = 8;
            data.list_widget_data.group_shift = int( 28 );
        }
    }
    
    if ( isdefined( data.max_widgets ) )
    {
        data.omnvar_names = [];
        
        for ( i = 0; i < data.max_widgets ; i++ )
        {
            data.omnvar_names[ i ] = [];
            data.omnvar_names[ i ][ "type_" ] = "ui_scripted_widget_" + "type_" + i;
            data.omnvar_names[ i ][ "param_" ] = "ui_scripted_widget_" + "param_" + i;
            data.omnvar_names[ i ][ "data_" ] = "ui_scripted_widget_" + "data_" + i;
            data.omnvar_names[ i ][ "state_" ] = "ui_scripted_widget_" + "state_" + i;
            data.omnvar_names[ i ][ "time_" ] = "ui_scripted_widget_" + "time_" + i;
            data.omnvar_names[ i ][ "position_" ] = "ui_scripted_widget_" + "position_" + i;
            data.omnvar_names[ i ][ "ent_" ] = "ui_scripted_widget_" + "ent_" + i;
            data.omnvar_names[ i ][ "hud_" ] = "ui_scripted_widget_" + "hud_" + i;
        }
    }
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0xc9962344, Offset: 0x2e4c
// Size: 0xdd
function private get_misc_data( misc_data_array )
{
    array = [];
    
    if ( isdefined( misc_data_array ) )
    {
        var_81e3bc2dbb19be97 = arraysort( getarraykeys( misc_data_array ) );
        
        foreach ( misc_data_index, misc_data_key in var_81e3bc2dbb19be97 )
        {
            value = get_property_value( misc_data_array[ misc_data_key ] );
            
            if ( isdefined( value ) )
            {
                array[ misc_data_key ] = { #index:misc_data_index, #value:value, #key:misc_data_key };
            }
        }
    }
    
    return array;
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0xaabc79aa, Offset: 0x2f32
// Size: 0xadf
function private function_f3389690c9a25255( widget )
{
    data = level.scripted_widgets;
    
    if ( !isxhashasset( widget ) )
    {
        widget = hashcat( %"scriptedwidget:", widget );
    }
    
    widget_data = getscriptbundle( widget );
    
    if ( isdefined( widget_data ) && !isdefined( data.widget_types[ widget ] ) )
    {
        widget_struct = {};
        data.widget_types[ widget ] = widget_struct;
        data.streamer_hints[ widget ] = [];
        data.streamed_widgets[ widget ] = [];
        widget_struct.index = data.widget_types.size;
        data.widget_type_indices[ widget_struct.index ] = widget;
        
        /#
            if ( getdvarint( @"hash_8c3631c954c9e749", 0 ) != 0 )
            {
                println( getxhashsourcename( widget ) + "<dev string:x2a2>" + getxhashhexname( widget ) + "<dev string:x2a2>" + widget_struct.index );
            }
        #/
        
        if ( isdefined( widget_data.archetype ) )
        {
            widget_struct.archetype = widget_data.archetype;
        }
        
        widget_struct.parameters = [];
        
        if ( isdefined( widget_data.parameters ) )
        {
            sorted_parameters = arraysort( getarraykeys( widget_data.parameters ) );
            
            if ( arraycontains( sorted_parameters, #"default" ) )
            {
                sorted_parameters = arrayremove( sorted_parameters, #"default" );
                arrayinsert( sorted_parameters, #"default", 0 );
            }
            
            foreach ( param_index, param_key in sorted_parameters )
            {
                widget_struct.parameters[ param_key ] = param_index;
            }
        }
        
        widget_struct.states = [];
        
        if ( isdefined( widget_data.states ) )
        {
            sorted_states = arraysort( getarraykeys( widget_data.states ) );
            
            if ( arraycontains( sorted_states, #"default" ) )
            {
                sorted_states = arrayremove( sorted_states, #"default" );
                arrayinsert( sorted_states, #"default", 0 );
            }
            
            foreach ( state_index, state_key in sorted_states )
            {
                widget_struct.states[ state_key ] = state_index;
            }
        }
        
        widget_struct.data_templates = [];
        widget_struct.data_tags = [];
        widget_struct.data_sets = widget_data.datasets;
        
        foreach ( data_set_name, data_set in widget_struct.data_sets )
        {
            if ( isdefined( data_set.template ) && data_set.template != #"none" )
            {
                if ( !isdefined( widget_struct.data_templates[ data_set.template ] ) )
                {
                    widget_struct.data_templates[ data_set.template ] = [];
                }
                
                widget_struct.data_templates[ data_set.template ][ data_set_name ] = data_set;
            }
            
            foreach ( tag, _ in data_set.tags )
            {
                if ( !isdefined( widget_struct.data_tags[ tag ] ) )
                {
                    widget_struct.data_tags[ tag ] = [];
                }
                
                widget_struct.data_tags[ tag ][ data_set_name ] = data_set;
            }
        }
        
        widget_struct.children = [];
        
        if ( isdefined( widget_data.children ) )
        {
            sorted_children = arraysort( getarraykeys( widget_data.children ) );
            
            foreach ( child_index, child_key in sorted_children )
            {
                child = widget_data.children[ child_key ];
                
                if ( child )
                {
                    child_struct = { #child_index:child_index, #widgets:[], #omnvar_sets:[] };
                    widget_struct.children[ child_key ] = child_struct;
                    
                    foreach ( omnvar_set_key, omnvar_set in child.omnvarsets )
                    {
                        if ( omnvar_set_key )
                        {
                            omnvar_set_struct = { #omnvars:[], #set_num:omnvar_set.setnum };
                            child_struct.omnvar_sets[ omnvar_set_key ] = omnvar_set_struct;
                            
                            foreach ( omnvar_ref, omnvar_data in omnvar_set.omnvars )
                            {
                                omnvar_data = omnvar_data.variant_object;
                                omnvar_set_struct.omnvars[ omnvar_ref ] = { #max_value:omnvar_data.maxvalue ?? 0, #min_value:omnvar_data.minvalue ?? 0, #default_value:omnvar_data.value ?? 0, #name:omnvar_data.name };
                            }
                            
                            omnvar_set_struct.misc_data = get_misc_data( omnvar_set.miscdata );
                        }
                    }
                    
                    child_widget_index = 1;
                    
                    foreach ( child_widget_key, child_widget in child.widgets )
                    {
                        if ( isdefined( child_widget ) )
                        {
                            child_struct.widgets[ child_widget_key ] = { #widget:child_widget.scriptedwidget, #index:child_widget_index };
                            child_widget_index++;
                        }
                    }
                    
                    widget_struct.children[ child_key ].misc_data = get_misc_data( child.miscdata );
                }
            }
        }
        
        widget_struct.interactions = [];
        
        if ( widget_data.interactions.size > 0 )
        {
            foreach ( index, interaction in widget_data.interactions )
            {
                if ( interaction.script_notify )
                {
                    widget_struct.interactions[ getxhash( "" + index ) ] = interaction.script_notify;
                }
            }
        }
        
        widget_struct.server_messages = [];
        
        if ( widget_data.servermessages.size > 0 )
        {
            sorted_messages = arraysort( getarraykeys( widget_data.servermessages ) );
            
            foreach ( index, key in sorted_messages )
            {
                widget_struct.server_messages[ index ] = widget_data.servermessages[ key ].script_notify;
            }
        }
        
        widget_struct.data_layout = function_440ebf83a736e17f( widget, widget_data );
        widget_struct.var_e53acc1cfc72fdf8 = [];
        
        if ( widget_data.assets.size > 0 )
        {
            foreach ( asset in widget_data.assets )
            {
                if ( asset.variant_object.type == "SoundBankTransientProperty" && asset.variant_object.value != "" )
                {
                    widget_struct.var_e53acc1cfc72fdf8[ widget_struct.var_e53acc1cfc72fdf8.size ] = strtok( asset.variant_object.value, "." )[ 0 ];
                }
            }
        }
    }
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x944b5315, Offset: 0x3a19
// Size: 0xe1
function get_child_widget_asset_name( widget_name, child_name, child_widget_name )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    
    if ( !isxhashasset( widget_name ) )
    {
        widget_name = hashcat( %"scriptedwidget:", widget_name );
    }
    
    if ( !isxhash( child_name ) )
    {
        child_name = getxhash( child_name );
    }
    
    if ( !isxhash( child_widget_name ) )
    {
        child_widget_name = getxhash( child_widget_name );
    }
    
    if ( isdefined( level.scripted_widgets.widget_types[ widget_name ].children[ child_name ].widgets[ child_widget_name ] ) )
    {
        return level.scripted_widgets.widget_types[ widget_name ].children[ child_name ].widgets[ child_widget_name ].widget;
    }
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x6d1dc4f, Offset: 0x3b03
// Size: 0xe1
function get_child_widget_index( widget_name, child_name, child_widget_name )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    
    if ( !isxhashasset( widget_name ) )
    {
        widget_name = hashcat( %"scriptedwidget:", widget_name );
    }
    
    if ( !isxhash( child_name ) )
    {
        child_name = getxhash( child_name );
    }
    
    if ( !isxhash( child_widget_name ) )
    {
        child_widget_name = getxhash( child_widget_name );
    }
    
    if ( isdefined( level.scripted_widgets.widget_types[ widget_name ].children[ child_name ].widgets[ child_widget_name ] ) )
    {
        return level.scripted_widgets.widget_types[ widget_name ].children[ child_name ].widgets[ child_widget_name ].index;
    }
}

// Namespace scripted_widgets
// Params 3
// Checksum 0xad5a3b64, Offset: 0x3bed
// Size: 0x107
function function_ff22f22466b7c225( widget_name, child_name, omnvar_set_name )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    
    if ( !isxhashasset( widget_name ) )
    {
        widget_name = hashcat( %"scriptedwidget:", widget_name );
    }
    
    if ( !isxhash( child_name ) )
    {
        child_name = getxhash( child_name );
    }
    
    if ( isdefined( omnvar_set_name ) )
    {
        if ( !isxhash( omnvar_set_name ) )
        {
            omnvar_set_name = getxhash( omnvar_set_name );
        }
    }
    
    if ( isdefined( level.scripted_widgets.widget_types[ widget_name ].children[ child_name ] ) )
    {
        if ( isdefined( omnvar_set_name ) )
        {
            return level.scripted_widgets.widget_types[ widget_name ].children[ child_name ].omnvar_sets[ omnvar_set_name ];
        }
        
        return level.scripted_widgets.widget_types[ widget_name ].children[ child_name ].omnvar_sets;
    }
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x86fcb16c, Offset: 0x3cfd
// Size: 0x4b
function function_d0e2238a41650c33( widget_name, child_name, omnvar_set_name )
{
    omnvar_set_data = function_ff22f22466b7c225( widget_name, child_name, omnvar_set_name );
    
    if ( isdefined( omnvar_set_data ) )
    {
        return ( omnvar_set_data.set_num ?? 1 );
    }
}

// Namespace scripted_widgets
// Params 4
// Checksum 0x64881204, Offset: 0x3d51
// Size: 0x8f
function function_73c35dc22a35edd7( widget_name, child_name, omnvar_set_name, omnvar_name )
{
    omnvar_set_data = function_ff22f22466b7c225( widget_name, child_name, omnvar_set_name );
    
    if ( isdefined( omnvar_set_data ) && ( isarray( omnvar_set_data ) || isdefined( omnvar_set_data.omnvars ) ) )
    {
        if ( isarray( omnvar_set_data ) )
        {
            return omnvar_set_data;
        }
        
        if ( omnvar_name )
        {
            return omnvar_set_data.omnvars[ omnvar_name ];
        }
        
        return omnvar_set_data.omnvars;
    }
}

// Namespace scripted_widgets
// Params 4
// Checksum 0xd5d24584, Offset: 0x3de9
// Size: 0x88
function function_3d9325242830d8f2( widget_name, child_name, omnvar_set_name, misc_property )
{
    omnvar_set_data = function_ff22f22466b7c225( widget_name, child_name, omnvar_set_name );
    
    if ( isdefined( omnvar_set_data ) && isdefined( omnvar_set_data.misc_data ) )
    {
        if ( isdefined( misc_property ) )
        {
            if ( !isxhash( misc_property ) )
            {
                misc_property = getxhash( misc_property );
            }
            
            return omnvar_set_data.misc_data[ misc_property ];
        }
        
        return omnvar_set_data.misc_data;
    }
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x3c948787, Offset: 0x3e7a
// Size: 0x115
function get_child_misc_data( widget_name, child_name, misc_property )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    
    if ( !isxhashasset( widget_name ) )
    {
        widget_name = hashcat( %"scriptedwidget:", widget_name );
    }
    
    if ( !isxhash( child_name ) )
    {
        child_name = getxhash( child_name );
    }
    
    if ( isdefined( level.scripted_widgets.widget_types[ widget_name ].children[ child_name ].misc_data ) )
    {
        if ( isdefined( misc_property ) )
        {
            if ( !isxhash( misc_property ) )
            {
                misc_property = getxhash( misc_property );
            }
            
            return level.scripted_widgets.widget_types[ widget_name ].children[ child_name ].misc_data[ misc_property ].value;
        }
        
        return level.scripted_widgets.widget_types[ widget_name ].children[ child_name ].misc_data;
    }
}

// Namespace scripted_widgets
// Params 2
// Checksum 0xa64adf6c, Offset: 0x3f98
// Size: 0xb3
function get_data_set( widget_name, data_set_name )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    
    if ( !isxhashasset( widget_name ) )
    {
        widget_name = hashcat( %"scriptedwidget:", widget_name );
    }
    
    if ( !isxhash( data_set_name ) )
    {
        data_set_name = getxhash( data_set_name );
    }
    
    widget_data = level.scripted_widgets.widget_types[ widget_name ];
    assert( isdefined( widget_data ), "<dev string:x2a6>" + getxhashsourcename( widget_name ) + "<dev string:x2b4>" );
    
    if ( !isdefined( widget_data ) )
    {
        return;
    }
    
    return widget_data.data_sets[ data_set_name ];
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x29623df7, Offset: 0x4054
// Size: 0x109
function get_data_set_data( widget_name, data_set_name, property_name )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    
    if ( !isxhashasset( widget_name ) )
    {
        widget_name = hashcat( %"scriptedwidget:", widget_name );
    }
    
    if ( !isxhash( data_set_name ) )
    {
        data_set_name = getxhash( data_set_name );
    }
    
    widget_data = level.scripted_widgets.widget_types[ widget_name ];
    assert( isdefined( widget_data ), "<dev string:x2a6>" + getxhashsourcename( widget_name ) + "<dev string:x2b4>" );
    
    if ( !isdefined( widget_data ) || !isdefined( widget_data.data_sets[ data_set_name ] ) )
    {
        return;
    }
    
    data = widget_data.data_sets[ data_set_name ].data;
    
    if ( isdefined( property_name ) )
    {
        if ( !isxhash( property_name ) )
        {
            property_name = getxhash( property_name );
        }
        
        return get_property_value( data[ property_name ] );
    }
    
    return data;
}

// Namespace scripted_widgets
// Params 2
// Checksum 0x30cccce6, Offset: 0x4166
// Size: 0xb3
function get_data_set_templates( widget_name, template )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    
    if ( !isxhashasset( widget_name ) )
    {
        widget_name = hashcat( %"scriptedwidget:", widget_name );
    }
    
    if ( !isxhash( template ) )
    {
        template = getxhash( template );
    }
    
    widget_data = level.scripted_widgets.widget_types[ widget_name ];
    assert( isdefined( widget_data ), "<dev string:x2a6>" + getxhashsourcename( widget_name ) + "<dev string:x2b4>" );
    
    if ( !isdefined( widget_data ) )
    {
        return;
    }
    
    return widget_data.data_templates[ template ];
}

// Namespace scripted_widgets
// Params 2
// Checksum 0xbac6ed40, Offset: 0x4222
// Size: 0xb3
function function_95d2742614441f0c( widget_name, tag )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    
    if ( !isxhashasset( widget_name ) )
    {
        widget_name = hashcat( %"scriptedwidget:", widget_name );
    }
    
    if ( !isxhash( tag ) )
    {
        tag = getxhash( tag );
    }
    
    widget_data = level.scripted_widgets.widget_types[ widget_name ];
    assert( isdefined( widget_data ), "<dev string:x2a6>" + getxhashsourcename( widget_name ) + "<dev string:x2b4>" );
    
    if ( !isdefined( widget_data ) )
    {
        return;
    }
    
    return widget_data.data_tags[ tag ];
}

// Namespace scripted_widgets
// Params 1
// Checksum 0x3ebd356, Offset: 0x42de
// Size: 0x3a7
function get_property_value( property )
{
    if ( !isdefined( property.variant_object ) )
    {
        return;
    }
    
    value = undefined;
    flags = undefined;
    
    switch ( property.variant_object.type )
    {
        case #"hash_120af2941803a2b":
            value = property.variant_object.value ?? 0;
            break;
        case #"hash_455ccc950900cae8":
            value = property.variant_object.value ?? 0;
            break;
        case #"hash_87ced1a3afbc3ba1":
            value = property.variant_object.value ?? #;
            break;
        case #"hash_8ef77f2da495e04f":
            value = property.variant_object.value ?? %"";
            break;
        case #"hash_25635f2a80ce6a01":
            value = property.variant_object.value ?? "0 0 0 0";
            break;
        case #"hash_9ce7ad58b9823a18":
            value = ( property.variant_object.x ?? 0, property.variant_object.y ?? 0, 0 );
            break;
        case #"hash_10697103af7d0577":
            value = ( property.variant_object.x ?? 0, property.variant_object.y ?? 0, property.variant_object.z ?? 0 );
            break;
        case #"hash_c276b9a9063829a2":
            value = property.variant_object.value ?? %"";
            break;
        case #"hash_5b9df8c05b775dc0":
            value = property.variant_object.value ?? 0;
            break;
        case #"hash_2c88da9ecd91c3e6":
        case #"hash_379c3f7bd8753e3d":
        case #"hash_53529861c93a2fb8":
        case #"hash_57f62dbc71f03b6d":
        case #"hash_87567a1d14026ad9":
        case #"hash_c5bf22aa3f203667":
        case #"hash_feddb7e37b672d56":
            value = property.variant_object.value ?? "";
            break;
        case #"hash_16b83b9ec085937d":
            value = property.variant_object.value ?? 0;
            flags = property.variant_object.flags ?? [];
            
            if ( isdefined( flags ) && flags.size > 0 )
            {
                value = { #flags:flags, #value:value };
            }
            
            break;
        case #"hash_51e48c9620f065c0":
            value = property.variant_object.properties ?? {};
            break;
        case #"hash_a314b3e0559a00dd":
            value = { #key:property.variant_object.key ?? "", #enum:property.variant_object.enum ?? "" };
            break;
    }
    
    return value;
}

// Namespace scripted_widgets
// Params 4, eflags: 0x4
// Checksum 0x5c3d4de1, Offset: 0x468e
// Size: 0x1bd
function private function_7f01d134d1bb56ee( widget_ref, widget_type, omnvar_name, expanded_data )
{
    data = level.scripted_widgets;
    widget_type_data = data.widget_types[ widget_type ];
    widget_data = getscriptbundle( widget_type );
    
    if ( !isdefined( widget_data ) || !isdefined( widget_data.interactions ) || !isdefined( widget_type_data.var_b2b22461873975c1 ) )
    {
        return;
    }
    
    var_c88c1b30f5986683 = [];
    var_e24340bed9a3a230 = 0;
    
    foreach ( interaction in widget_data.interactions )
    {
        if ( interaction.var_4077f60906440889 && interaction.disabled && isdefined( interaction.reference ) && interaction.reference != #"" )
        {
            reference = normalize_xhash( interaction.reference );
            
            if ( isdefined( widget_type_data.var_b2b22461873975c1[ reference ] ) )
            {
                var_c88c1b30f5986683[ widget_type_data.var_b2b22461873975c1[ reference ].field ] = 2;
                var_e24340bed9a3a230 = 1;
            }
        }
    }
    
    if ( var_e24340bed9a3a230 )
    {
        function_8cf5fd538d9951dd( widget_type, omnvar_name, var_c88c1b30f5986683, undefined, expanded_data, 1 );
    }
}

// Namespace scripted_widgets
// Params 5
// Checksum 0x70f8efe6, Offset: 0x4853
// Size: 0x4d5, Type: bool
function create( widget_ref, widget_type, widget_struct, stream_and_wait, var_536711e101433266 = 10 )
{
    if ( !function_1d678e943064d3c5() )
    {
        return false;
    }
    
    data = level.scripted_widgets;
    widget_ref = tolower( widget_ref );
    
    if ( !isxhashasset( widget_type ) )
    {
        widget_type = hashcat( %"scriptedwidget:", widget_type );
    }
    
    if ( !isdefined( data.widget_types[ widget_type ] ) )
    {
        assertmsg( "<dev string:x2c6>" + getxhashsourcename( widget_type ) + "<dev string:x2ee>" );
        return false;
    }
    
    if ( is_active( widget_ref ) )
    {
        assertmsg( "<dev string:x38f>" + widget_ref + "<dev string:x3af>" );
        return false;
    }
    
    if ( stream_and_wait && !is_streamed( widget_type ) )
    {
        self notify( "scripted_widget_streaming_started_" + widget_ref );
        self endon( #"death_or_disconnect" );
        self endon( "scripted_widget_destroyed_" + widget_ref );
        self endon( "scripted_widget_cancelled_" + widget_ref );
        self endon( "scripted_widget_streaming_started_" + widget_ref );
        thread function_6cb8b5584723528d( widget_ref, widget_type );
        add_streamer_hint( widget_ref, widget_type );
        
        /#
            start_time = gettime();
        #/
        
        if ( var_536711e101433266 > 0 )
        {
            utility::waittill_notify_or_timeout( "scripted_widget_streamed_" + data.widget_types[ widget_type ].index, var_536711e101433266 );
        }
        else
        {
            self waittill( "scripted_widget_streamed_" + data.widget_types[ widget_type ].index );
        }
        
        println( "<dev string:x3d4>" + widget_ref + "<dev string:x2a2>" + gettime() - start_time );
    }
    
    index = reserve( widget_ref, widget_type );
    
    if ( isdefined( index ) )
    {
        if ( isdefined( widget_struct ) )
        {
            if ( isdefined( widget_struct.param ) )
            {
                function_bfa6932336246cd5( widget_struct.param, data.omnvar_names[ index ][ "param_" ], data.widget_types[ widget_type ].parameters );
            }
            
            if ( isdefined( widget_struct.data ) )
            {
                function_bfa6932336246cd5( widget_struct.data, data.omnvar_names[ index ][ "data_" ] );
            }
            
            if ( isdefined( widget_struct.state ) )
            {
                function_bfa6932336246cd5( widget_struct.state, data.omnvar_names[ index ][ "state_" ], data.widget_types[ widget_type ].states );
            }
            
            if ( isent( widget_struct.ent ) )
            {
                assert( isdefined( widget_struct.anchor_type ), "<dev string:x3f9>" );
                anchor_to_ent( widget_ref, widget_struct.ent, widget_struct.anchor_type );
            }
            
            if ( isdefined( widget_struct.position ) )
            {
                set_position( widget_ref, widget_struct.position.left, widget_struct.position.top, widget_struct.position.horizontal_anchor, widget_struct.position.vertical_anchor, widget_struct.position.use_safe_area );
            }
            
            if ( isdefined( widget_struct.remove_on_death ) )
            {
                set_remove_on_death( widget_ref, widget_struct.remove_on_death );
            }
            
            hud_priority = widget_struct.priority ?? 0;
            hud_under_hud = widget_struct.under_hud ?? 0;
            var_47c4fe77ad698cdb = widget_struct.var_59e2ff60bf69c885 ?? 0;
            var_9cd38043ae62aede = !hud_under_hud && isdefined( widget_struct.over_everything ) ? widget_struct.over_everything : 0;
            packed_hud = hud_priority + ( hud_under_hud << 3 ) + ( var_47c4fe77ad698cdb << 4 ) + ( var_9cd38043ae62aede << 5 );
            function_bfa6932336246cd5( packed_hud, data.omnvar_names[ index ][ "hud_" ] );
        }
        
        expanded_data = self.active_scripted_widgets[ widget_ref ].expanded_data;
        function_7f01d134d1bb56ee( widget_ref, widget_type, data.omnvar_names[ index ][ "data_" ], expanded_data );
        self setclientomnvar( data.omnvar_names[ index ][ "type_" ], data.widget_types[ widget_type ].index );
        
        if ( stream_and_wait )
        {
            self notify( "scripted_widget_created_" + widget_ref );
        }
        
        return true;
    }
    else
    {
        assertmsg( "<dev string:x44a>" );
    }
    
    return false;
}

// Namespace scripted_widgets
// Params 1
// Checksum 0x4102bcde, Offset: 0x4d31
// Size: 0x18e
function function_652736891a41e948( widget_prefix )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    assert( isdefined( level.scripted_widgets ), "<dev string:x483>" );
    assert( isdefined( widget_prefix ), "<dev string:x4de>" );
    widget = function_8871b3ec93b79cd0( widget_prefix, getdvar( @"g_mapname" ) );
    
    if ( isdefined( widget ) )
    {
        return widget;
    }
    
    widget = function_8871b3ec93b79cd0( widget_prefix, [ getprojectname(), level.gametype ] );
    
    if ( isdefined( widget ) )
    {
        return widget;
    }
    
    mode = "mp";
    
    if ( utility::issp() )
    {
        mode = "sp";
    }
    
    widget = function_8871b3ec93b79cd0( widget_prefix, [ getprojectname(), mode ] );
    
    if ( isdefined( widget ) )
    {
        return widget;
    }
    
    widget = function_8871b3ec93b79cd0( widget_prefix, getprojectname() );
    
    if ( isdefined( widget ) )
    {
        return widget;
    }
    
    if ( isdefined( level.gametype ) )
    {
        widget = function_8871b3ec93b79cd0( widget_prefix, level.gametype );
        
        if ( isdefined( widget ) )
        {
            return widget;
        }
    }
    
    widget = function_8871b3ec93b79cd0( widget_prefix, mode );
    
    if ( isdefined( widget ) )
    {
        return widget;
    }
    
    if ( type_exists( widget_prefix ) )
    {
        return hashcat( %"scriptedwidget:", widget_prefix );
    }
    
    /#
        if ( getdvarint( @"hash_8c3631c954c9e749", 0 ) != 0 )
        {
            println( "<dev string:x526>" + widget_prefix + "<dev string:x1a2>" );
            assertmsg( "<dev string:x526>" + widget_prefix + "<dev string:x55b>" );
        }
    #/
}

// Namespace scripted_widgets
// Params 2
// Checksum 0x64c37ffb, Offset: 0x4ec8
// Size: 0x11c
function function_8871b3ec93b79cd0( widget_prefix, params )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    assert( isdefined( level.scripted_widgets ), "<dev string:x483>" );
    assert( isdefined( widget_prefix ), "<dev string:x4de>" );
    assert( isdefined( params ) && ( isstring( params ) || isarray( params ) ), "<dev string:x5bd>" );
    scripted_widget_name = "";
    
    if ( isstring( params ) )
    {
        scripted_widget_name = widget_prefix + "_" + params;
    }
    else if ( isarray( params ) )
    {
        for ( i = 0; i < params.size ; i++ )
        {
            if ( !isdefined( params[ i ] ) )
            {
                return;
            }
            
            scripted_widget_name += params[ i ];
            
            if ( i + 1 < params.size )
            {
                scripted_widget_name += "_";
            }
        }
        
        scripted_widget_name = widget_prefix + "_" + scripted_widget_name;
    }
    else
    {
        scripted_widget_name = widget_prefix;
    }
    
    if ( type_exists( scripted_widget_name ) )
    {
        return hashcat( %"scriptedwidget:", scripted_widget_name );
    }
}

// Namespace scripted_widgets
// Params 1
// Checksum 0x9c466292, Offset: 0x4fed
// Size: 0x64, Type: bool
function type_exists( widget_type )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    
    if ( !isxhashasset( widget_type ) )
    {
        widget_type = hashcat( %"scriptedwidget:", widget_type );
    }
    
    return isdefined( level.scripted_widgets ) && isdefined( level.scripted_widgets.widget_types[ widget_type ] );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0xf372e6d4, Offset: 0x505a
// Size: 0x139
function get_param_property( widget_asset, param_name, property_name )
{
    assert( isdefined( level.scripted_widgets ), "<dev string:x63d>" );
    
    if ( !isxhashasset( widget_asset ) )
    {
        widget_asset = hashcat( %"scriptedwidget:", widget_asset );
    }
    
    widget_data = getscriptbundle( widget_asset );
    
    if ( !isxhash( param_name ) )
    {
        param_name = getxhash( param_name );
    }
    
    if ( isdefined( widget_data.parameters[ param_name ] ) )
    {
        if ( !isxhash( property_name ) )
        {
            property_name = getxhash( property_name );
        }
        
        foreach ( property in widget_data.parameters[ param_name ].properties )
        {
            if ( property.variant_object.property == property_name )
            {
                return get_property_value( property );
            }
        }
    }
}

// Namespace scripted_widgets
// Params 2
// Checksum 0x996e23d3, Offset: 0x519c
// Size: 0x94
function get_param_index( widget_asset, param_name )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    assert( isdefined( level.scripted_widgets ), "<dev string:x483>" );
    
    if ( !isxhashasset( widget_asset ) )
    {
        widget_asset = hashcat( %"scriptedwidget:", widget_asset );
    }
    
    if ( !isxhash( param_name ) )
    {
        param_name = getxhash( param_name );
    }
    
    return level.scripted_widgets.widget_types[ widget_asset ].parameters[ param_name ];
}

// Namespace scripted_widgets
// Params 1
// Checksum 0xe98f8cd6, Offset: 0x5239
// Size: 0x77
function get_params( widget_asset )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    assert( isdefined( level.scripted_widgets ), "<dev string:x483>" );
    
    if ( !isxhashasset( widget_asset ) )
    {
        widget_asset = hashcat( %"scriptedwidget:", widget_asset );
    }
    
    return level.scripted_widgets.widget_types[ widget_asset ].parameters;
}

// Namespace scripted_widgets
// Params 4, eflags: 0x4
// Checksum 0x197e522d, Offset: 0x52b9
// Size: 0x16f
function private function_d9b22346e3419eac( widget_ref, omnvar_suffix, omnvar_override, time_omnvar_override )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    var_7c024f75324ab27d = {};
    data = level.scripted_widgets;
    
    if ( isdefined( omnvar_override ) )
    {
        if ( !isxhashasset( widget_ref ) )
        {
            widget_ref = hashcat( %"scriptedwidget:", widget_ref );
        }
        
        var_7c024f75324ab27d.omnvar = omnvar_override;
        var_7c024f75324ab27d.type = widget_ref;
        var_7c024f75324ab27d.time_omnvar = time_omnvar_override;
        assert( isdefined( data.widget_types[ widget_ref ] ) );
    }
    else
    {
        widget_ref = tolower( widget_ref );
        
        if ( !is_active( widget_ref ) )
        {
            return;
        }
        
        active_widget = self.active_scripted_widgets[ widget_ref ];
        var_7c024f75324ab27d.omnvar = data.omnvar_names[ active_widget.index ][ omnvar_suffix ];
        var_7c024f75324ab27d.type = active_widget.widget_type;
        var_7c024f75324ab27d.time_omnvar = data.omnvar_names[ active_widget.index ][ "time_" ];
        var_7c024f75324ab27d.expanded_data = active_widget.expanded_data;
    }
    
    return var_7c024f75324ab27d;
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x5749f5fe, Offset: 0x5431
// Size: 0x93
function set_param( widget_ref, param_ref, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "param_", omnvar_override );
    
    if ( isdefined( data ) )
    {
        parameters = level.scripted_widgets.widget_types[ data.type ].parameters;
        function_bfa6932336246cd5( param_ref, data.omnvar, parameters );
    }
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x219bfb4e, Offset: 0x54cc
// Size: 0x5e
function set_data( widget_ref, data_val, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "data_", omnvar_override );
    
    if ( isdefined( data ) )
    {
        function_bfa6932336246cd5( data_val, data.omnvar );
    }
}

// Namespace scripted_widgets
// Params 2
// Checksum 0x424284a0, Offset: 0x5532
// Size: 0x94
function get_state_index( widget_asset, state_name )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    assert( isdefined( level.scripted_widgets ), "<dev string:x693>" );
    
    if ( !isxhashasset( widget_asset ) )
    {
        widget_asset = hashcat( %"scriptedwidget:", widget_asset );
    }
    
    if ( !isxhash( state_name ) )
    {
        state_name = getxhash( state_name );
    }
    
    return level.scripted_widgets.widget_types[ widget_asset ].states[ state_name ];
}

// Namespace scripted_widgets
// Params 3
// Checksum 0xd97d1d81, Offset: 0x55cf
// Size: 0x93
function set_state( widget_ref, state, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "state_", omnvar_override );
    
    if ( isdefined( data ) )
    {
        states = level.scripted_widgets.widget_types[ data.type ].states;
        function_bfa6932336246cd5( state, data.omnvar, states );
    }
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x38215afe, Offset: 0x566a
// Size: 0x1e7
function anchor_to_ent( widget_ref, anchor_ent, anchor_type )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    widget_ref = tolower( widget_ref );
    
    if ( !is_active( widget_ref ) )
    {
        return;
    }
    
    anchor_type = hashcat( %"scriptedwidgetanchorsettings:", anchor_type );
    data = level.scripted_widgets;
    assert( isdefined( data.anchor_types[ anchor_type ] ), "<dev string:x6ee>" + getxhashsourcename( anchor_type ) + "<dev string:x6fb>" );
    
    if ( !isdefined( self.var_ee7b3c5755530a30 ) )
    {
        self.var_ee7b3c5755530a30 = [];
    }
    
    ent_num = anchor_ent getentitynumber();
    
    if ( !isdefined( self.var_ee7b3c5755530a30[ ent_num ] ) )
    {
        self.var_ee7b3c5755530a30[ ent_num ] = [];
    }
    
    active_widget = self.active_scripted_widgets[ widget_ref ];
    
    if ( isdefined( active_widget.ent_num ) )
    {
        self.var_ee7b3c5755530a30[ active_widget.ent_num ][ widget_ref ] = undefined;
        
        if ( self.var_ee7b3c5755530a30[ active_widget.ent_num ].size == 0 )
        {
            self.var_ee7b3c5755530a30[ active_widget.ent_num ] = undefined;
            self notify( "_automatic_remove_anchored_widget_" + active_widget.ent_num );
        }
    }
    
    active_widget.ent_num = ent_num;
    self.var_ee7b3c5755530a30[ ent_num ][ widget_ref ] = active_widget.index;
    ent_omnvar = data.omnvar_names[ active_widget.index ][ "ent_" ];
    self setclientomnvar( ent_omnvar, anchor_ent );
    function_bfa6932336246cd5( data.anchor_types[ anchor_type ], data.omnvar_names[ active_widget.index ][ "position_" ] );
    thread function_bbf3c75a748aaf3f( anchor_ent );
}

// Namespace scripted_widgets
// Params 2
// Checksum 0xe6e4ed6, Offset: 0x5859
// Size: 0x56
function set_remove_on_death( widget_ref, should_remove_on_death = 1 )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    widget_ref = tolower( widget_ref );
    
    if ( !is_active( widget_ref ) )
    {
        return;
    }
    
    self.active_scripted_widgets[ widget_ref ].remove_on_death = should_remove_on_death;
}

// Namespace scripted_widgets
// Params 7
// Checksum 0x991b5bd4, Offset: 0x58b7
// Size: 0x2cf
function set_position( widget_ref, x_pos, y_pos, horizontal_anchor, vertical_anchor, use_safe_area, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "position_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    if ( !isdefined( use_safe_area ) )
    {
        use_safe_area = 1;
    }
    
    x_pos = int( x_pos );
    y_pos = int( y_pos );
    
    switch ( horizontal_anchor )
    {
        case 0:
            assert( x_pos >= -63 && x_pos <= 1984, "<dev string:x797>" + -63 + "<dev string:x7da>" + 1984 + "<dev string:x7e0>" );
            x_pos -= -63;
            break;
        case 1:
        case 3:
            assert( x_pos >= -1023 && x_pos <= 1024, "<dev string:x797>" + -1023 + "<dev string:x7da>" + 1024 + "<dev string:x7f4>" );
            x_pos -= -1023;
            break;
        case 2:
            assert( x_pos >= -1984 && x_pos <= 63, "<dev string:x797>" + -1984 + "<dev string:x7da>" + 63 + "<dev string:x80a>" );
            x_pos += 1984;
            break;
    }
    
    switch ( vertical_anchor )
    {
        case 0:
            assert( y_pos >= -483 && y_pos <= 1564, "<dev string:x81f>" + -483 + "<dev string:x7da>" + 1564 + "<dev string:x862>" );
            y_pos -= -483;
            break;
        case 1:
        case 3:
            assert( y_pos >= -1023 && y_pos <= 1024, "<dev string:x81f>" + -1023 + "<dev string:x7da>" + 1024 + "<dev string:x875>" );
            y_pos -= -1023;
            break;
        case 2:
            assert( y_pos >= -1564 && y_pos <= 483, "<dev string:x81f>" + -1564 + "<dev string:x7da>" + 483 + "<dev string:x88b>" );
            y_pos += 1564;
            break;
    }
    
    y_bits = y_pos << 11;
    horizontal_anchor_bits = horizontal_anchor << 22;
    vertical_anchor_bits = vertical_anchor << 24;
    var_47e2e298af451186 = ( use_safe_area ? 1 : 0 ) << 26;
    packed_position = x_pos + y_bits + horizontal_anchor_bits + vertical_anchor_bits + var_47e2e298af451186;
    self setclientomnvar( data.omnvar, packed_position );
}

// Namespace scripted_widgets
// Params 1
// Checksum 0xed689242, Offset: 0x5b8e
// Size: 0x5a
function anchor_horizontal( datatype )
{
    if ( !isdefined( datatype ) )
    {
        return 0;
    }
    
    switch ( datatype )
    {
        case #"hash_a653d8ebf51ebac4":
            return 1;
        case #"hash_5b6fb3c943bab625":
            return 2;
        case #"hash_175a301ae8d1236a":
            return 3;
        default:
            return 0;
    }
}

// Namespace scripted_widgets
// Params 1
// Checksum 0x1d6d4a82, Offset: 0x5bf0
// Size: 0x5a
function anchor_vertical( datatype )
{
    if ( !isdefined( datatype ) )
    {
        return 0;
    }
    
    switch ( datatype )
    {
        case #"hash_4fdc8686e8ea358":
            return 1;
        case #"hash_62df33229372c36a":
            return 2;
        case #"hash_175a301ae8d1236a":
            return 3;
        default:
            return 0;
    }
}

// Namespace scripted_widgets
// Params 3
// Checksum 0xa1f75ba, Offset: 0x5c52
// Size: 0x185
function get_position( widget_ref, var_9ef663aa73529ba0, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "position_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    position_data = self getclientomnvar( data.omnvar );
    x_pos = ( position_data & 2047 ) >> 0;
    y_pos = ( position_data & 2047 ) >> 11;
    horizontal_anchor = ( position_data & 3 ) >> 22;
    vertical_anchor = ( position_data & 3 ) >> 24;
    
    switch ( horizontal_anchor )
    {
        case 0:
            x_pos += -63;
            break;
        case 1:
        case 3:
            x_pos += -1023;
            break;
        case 2:
            x_pos -= 1984;
            break;
    }
    
    switch ( vertical_anchor )
    {
        case 0:
            y_pos += -483;
            break;
        case 1:
        case 3:
            y_pos += -1023;
            break;
        case 2:
            y_pos -= 1564;
            break;
    }
    
    if ( var_9ef663aa73529ba0 )
    {
        x_pos = ( x_pos - -63 ) / 2047;
        y_pos = ( y_pos - -483 ) / 2047;
    }
    
    return ( x_pos, y_pos, 0 );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0xe34a425d, Offset: 0x5de0
// Size: 0x8c
function set_priority( widget_ref, priority, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    if ( isdefined( omnvar_override ) )
    {
        self setclientomnvar( omnvar_override, priority );
    }
    
    data = function_d9b22346e3419eac( widget_ref, "hud_" );
    
    if ( isdefined( data ) )
    {
        hud_values = self getclientomnvar( data.omnvar );
        hud_values |= priority << 0;
        self setclientomnvar( data.omnvar, hud_values );
    }
}

// Namespace scripted_widgets
// Params 5
// Checksum 0xda4c61f3, Offset: 0x5e74
// Size: 0x96
function function_dd7a63eea5bde0dc( widget_ref, field_values, no_timestamp, omnvar_override, time_omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "data_", omnvar_override, time_omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    function_8cf5fd538d9951dd( data.type, data.omnvar, field_values, data.time_omnvar, data.expanded_data, no_timestamp );
}

// Namespace scripted_widgets
// Params 4
// Checksum 0xc815bd7b, Offset: 0x5f12
// Size: 0x80
function function_f15c5dfb6c0f57c7( widget_ref, field, value, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    function_fd763dfab121ebdc( data.type, data.omnvar, field, value, data.expanded_data );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x1da2a503, Offset: 0x5f9a
// Size: 0xb3
function function_a1e7466f6ab50dd7( widget_ref, field, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    value = function_36ff92d61c415b99( data.type, data.omnvar, [ field ], data.expanded_data );
    function_fd763dfab121ebdc( data.type, data.omnvar, field, !value[ field ], data.expanded_data );
}

// Namespace scripted_widgets
// Params 6, eflags: 0x4
// Checksum 0xedd49cfb, Offset: 0x6055
// Size: 0xf5
function private function_7a9327e41ffb64b2( widget_type, omnvar, expanded_data, interaction_reference, mask, enabled )
{
    widget_type_data = level.scripted_widgets.widget_types[ widget_type ];
    interaction_reference = normalize_xhash( interaction_reference );
    var_b2b22461873975c1 = widget_type_data.var_b2b22461873975c1;
    
    if ( !isdefined( var_b2b22461873975c1 ) || !isdefined( var_b2b22461873975c1[ interaction_reference ] ) )
    {
        return;
    }
    
    field_name = var_b2b22461873975c1[ interaction_reference ].field;
    field_values = function_36ff92d61c415b99( widget_type, omnvar, [ field_name ], expanded_data );
    current_value = field_values[ field_name ] ?? 0;
    
    if ( enabled )
    {
        current_value |= mask;
    }
    else
    {
        current_value &= ~mask;
    }
    
    function_fd763dfab121ebdc( widget_type, omnvar, field_name, current_value, expanded_data );
}

// Namespace scripted_widgets
// Params 5, eflags: 0x4
// Checksum 0x2e62ffc2, Offset: 0x6152
// Size: 0x164
function private set_interaction_toggle_state( widget_ref, interaction_reference, omnvar_override, mask, enabled )
{
    data = function_d9b22346e3419eac( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    widget_type_data = level.scripted_widgets.widget_types[ data.type ];
    
    if ( !isdefined( widget_type_data ) || !isdefined( widget_type_data.var_b2b22461873975c1 ) )
    {
        return;
    }
    
    if ( isdefined( interaction_reference ) )
    {
        function_7a9327e41ffb64b2( data.type, data.omnvar, data.expanded_data, interaction_reference, mask, enabled );
        return;
    }
    
    foreach ( reference, _ in widget_type_data.var_b2b22461873975c1 )
    {
        function_7a9327e41ffb64b2( data.type, data.omnvar, data.expanded_data, reference, mask, enabled );
    }
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x2b2b505e, Offset: 0x62be
// Size: 0x38
function function_17cb4d316aab4821( widget_ref, interaction_reference, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    set_interaction_toggle_state( widget_ref, interaction_reference, omnvar_override, 1, 1 );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0xc0c13e83, Offset: 0x62fe
// Size: 0x37
function function_981da8ea23741d2c( widget_ref, interaction_reference, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    set_interaction_toggle_state( widget_ref, interaction_reference, omnvar_override, 1, 0 );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x70bb5f6c, Offset: 0x633d
// Size: 0x38
function disable_interaction( widget_ref, interaction_reference, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    set_interaction_toggle_state( widget_ref, interaction_reference, omnvar_override, 2, 1 );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x565a8df4, Offset: 0x637d
// Size: 0x37
function enable_interaction( widget_ref, interaction_reference, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    set_interaction_toggle_state( widget_ref, interaction_reference, omnvar_override, 2, 0 );
}

// Namespace scripted_widgets
// Params 6
// Checksum 0xec38d89a, Offset: 0x63bc
// Size: 0x93
function archetype_set_progress( widget_ref, current_pct, target_pct, time, omnvar_override, time_omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    function_a5884eba814ff4a9( data.type, data.omnvar, current_pct, target_pct, time, data.time_omnvar );
}

// Namespace scripted_widgets
// Params 5
// Checksum 0x5200db0e, Offset: 0x6457
// Size: 0x89
function function_1f64ed5f88c8ce49( widget_ref, current_pct, bool, omnvar_override, time_omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    function_edbb7fcd923a5f0e( data.type, data.omnvar, current_pct, bool, data.time_omnvar );
}

// Namespace scripted_widgets
// Params 5
// Checksum 0xdb768fb, Offset: 0x64e8
// Size: 0x89
function function_cd5be9aeaf7e4e4f( widget_ref, current_pct, current_alpha, omnvar_override, time_omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    function_8addc2ad9b69713a( data.type, data.omnvar, current_pct, current_alpha, data.time_omnvar );
}

// Namespace scripted_widgets
// Params 6
// Checksum 0x5de36d99, Offset: 0x6579
// Size: 0x93
function archetype_set_count( widget_ref, count, max_count, time, omnvar_override, time_omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    function_50729a8ba609355( data.type, data.omnvar, count, max_count, time, data.time_omnvar );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x619dba4, Offset: 0x6614
// Size: 0x5f
function set_timestamp( widget_ref, timestamp, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "time_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    self setclientomnvar( data.omnvar, timestamp );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x4ee3aca4, Offset: 0x667b
// Size: 0x75
function function_1cbc8727b7beb808( widget_ref, fields, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    return function_36ff92d61c415b99( data.type, data.omnvar, fields, data.expanded_data );
}

// Namespace scripted_widgets
// Params 2
// Checksum 0x4959353, Offset: 0x66f9
// Size: 0x100
function function_e7a2cd21db9131ee( widget_type, field )
{
    data = level.scripted_widgets;
    
    if ( !isxhashasset( widget_type ) )
    {
        widget_type = hashcat( %"scriptedwidget:", widget_type );
    }
    
    if ( !data.widget_types[ widget_type ] )
    {
        return;
    }
    
    data_layout = get_widget_data_layout( widget_type );
    field = function_b2e49ff7cbc3fc1c( field );
    assert( isdefined( data_layout ), "<dev string:x8a1>" + getxhashsourcename( widget_type ) + "<dev string:x8ba>" );
    assert( isdefined( data_layout.fields[ field ] ), "<dev string:x911>" + function_886d6ce36915ff2c( field ) + "<dev string:x925>" + getxhashsourcename( widget_type ) + "<dev string:x948>" );
    
    if ( isdefined( data_layout ) && isdefined( data_layout.fields[ field ] ) )
    {
        return data_layout.fields[ field ].max_value;
    }
}

// Namespace scripted_widgets
// Params 2
// Checksum 0x4959353, Offset: 0x6802
// Size: 0x100
function function_542bdf561be928a8( widget_type, field )
{
    data = level.scripted_widgets;
    
    if ( !isxhashasset( widget_type ) )
    {
        widget_type = hashcat( %"scriptedwidget:", widget_type );
    }
    
    if ( !data.widget_types[ widget_type ] )
    {
        return;
    }
    
    data_layout = get_widget_data_layout( widget_type );
    field = function_b2e49ff7cbc3fc1c( field );
    assert( isdefined( data_layout ), "<dev string:x8a1>" + getxhashsourcename( widget_type ) + "<dev string:x8ba>" );
    assert( isdefined( data_layout.fields[ field ] ), "<dev string:x911>" + function_886d6ce36915ff2c( field ) + "<dev string:x925>" + getxhashsourcename( widget_type ) + "<dev string:x948>" );
    
    if ( isdefined( data_layout ) && isdefined( data_layout.fields[ field ] ) )
    {
        return data_layout.fields[ field ].min_value;
    }
}

// Namespace scripted_widgets
// Params 2
// Checksum 0xdd7de173, Offset: 0x690b
// Size: 0xa5
function function_912e21a45abeae9d( widget_type, group_name )
{
    data = level.scripted_widgets;
    
    if ( !isxhashasset( widget_type ) )
    {
        widget_type = hashcat( %"scriptedwidget:", widget_type );
    }
    
    if ( !data.widget_types[ widget_type ] )
    {
        return;
    }
    
    data_layout = get_widget_data_layout( widget_type );
    group_name = function_2ae2122ff77c7780( group_name );
    
    if ( isdefined( data_layout ) && isdefined( data_layout.field_groups[ group_name ] ) )
    {
        return data_layout.field_groups[ group_name ].count;
    }
}

// Namespace scripted_widgets
// Params 5
// Checksum 0x5a5643c7, Offset: 0x69b9
// Size: 0x89
function function_3e6cbbc3bb6b0544( widget_ref, group_name, group_index, fields, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    return function_be250f1771083c75( data.type, data.omnvar, group_name, group_index, fields, data.expanded_data );
}

// Namespace scripted_widgets
// Params 5
// Checksum 0xda8babac, Offset: 0x6a4b
// Size: 0x5a
function function_a35100072b1349df( widget_ref, group_name, group_index, field, omnvar_override )
{
    values = function_3e6cbbc3bb6b0544( widget_ref, group_name, group_index, [ field ], omnvar_override );
    
    if ( isdefined( values ) )
    {
        return values[ field ];
    }
}

// Namespace scripted_widgets
// Params 7
// Checksum 0xcef98e90, Offset: 0x6aae
// Size: 0xaa
function function_decde18d77492c18( widget_ref, group_name, group_index, field_values, no_timestamp, omnvar_override, time_omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "data_", omnvar_override, time_omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    function_a546790e875abe29( data.type, data.omnvar, group_name, group_index, field_values, data.time_omnvar, data.expanded_data, no_timestamp );
}

// Namespace scripted_widgets
// Params 6
// Checksum 0x7ca69167, Offset: 0x6b60
// Size: 0x95
function function_c6ee2f72d660fbfb( widget_ref, group_name, group_index, field, value, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    function_a0966a869e7a7a40( data.type, data.omnvar, group_name, group_index, field, value, data.expanded_data );
}

// Namespace scripted_widgets
// Params 1
// Checksum 0x6142cd8a, Offset: 0x6bfd
// Size: 0x8b
function destroy( widget_ref )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    widget_ref = tolower( widget_ref );
    
    if ( !is_active( widget_ref ) )
    {
        self notify( "scripted_widget_cancelled_" + widget_ref );
        return;
    }
    
    index = release( widget_ref );
    
    if ( isdefined( index ) )
    {
        omnvarname = level.scripted_widgets.omnvar_names[ index ][ "type_" ];
        self setclientomnvar( omnvarname, 0 );
        self notify( "scripted_widget_destroyed_" + widget_ref );
    }
}

// Namespace scripted_widgets
// Params 1
// Checksum 0xbe89f03f, Offset: 0x6c90
// Size: 0x82, Type: bool
function is_active( widget_ref )
{
    if ( !function_1d678e943064d3c5() )
    {
        return false;
    }
    
    widget_ref = tolower( widget_ref );
    
    if ( !isdefined( self.active_scripted_widgets[ widget_ref ] ) )
    {
        return false;
    }
    
    index = get_active_index( widget_ref );
    
    if ( isdefined( index ) )
    {
        omnvarname = level.scripted_widgets.omnvar_names[ index ][ "type_" ];
        
        if ( !self function_5c766d1d0140b86( omnvarname ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace scripted_widgets
// Params 1
// Checksum 0x16fb71a9, Offset: 0x6d1b
// Size: 0x46
function get_active_index( widget_ref )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    widget_ref = tolower( widget_ref );
    
    if ( isdefined( self.active_scripted_widgets[ widget_ref ] ) )
    {
        return self.active_scripted_widgets[ widget_ref ].index;
    }
}

// Namespace scripted_widgets
// Params 1
// Checksum 0x154106ac, Offset: 0x6d6a
// Size: 0x111, Type: bool
function available( widget_type )
{
    if ( !function_1d678e943064d3c5() )
    {
        return false;
    }
    
    if ( !isdefined( self.var_6dfd888d8d61534b ) )
    {
        return true;
    }
    
    available_count = self.var_6dfd888d8d61534b.size;
    
    if ( available_count == 0 )
    {
        return false;
    }
    
    if ( isdefined( widget_type ) )
    {
        data = level.scripted_widgets;
        
        if ( !isxhashasset( widget_type ) )
        {
            widget_type = hashcat( %"scriptedwidget:", widget_type );
        }
        
        if ( !isdefined( data.widget_types[ widget_type ] ) )
        {
            return false;
        }
        
        data_layout = get_widget_data_layout( widget_type );
        required = function_8d8fc3f61711bc6d( widget_type );
        
        if ( available_count < required )
        {
            return false;
        }
        
        if ( required > 1 )
        {
            for ( i = self.var_6dfd888d8d61534b.size - 1; i >= 0 ; i-- )
            {
                if ( is_chain_available( self.var_6dfd888d8d61534b[ i ], data_layout.var_ce2c3c2e107514d0 ) )
                {
                    return true;
                }
            }
            
            return false;
        }
    }
    
    return true;
}

// Namespace scripted_widgets
// Params 2
// Checksum 0x36ae4dac, Offset: 0x6e84
// Size: 0x1ec
function add_streamer_hint( widget_ref, widget_type )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    data = level.scripted_widgets;
    
    if ( !isxhashasset( widget_type ) )
    {
        widget_type = hashcat( %"scriptedwidget:", widget_type );
    }
    
    widget_index = data.widget_types[ widget_type ].index - 1;
    streaming_omnvar = "ui_scripted_widget_streamer_hint_" + int( widget_index / 32 );
    streaming_bit = widget_index % 32;
    
    if ( utility::issharedfuncdefined( #"snd", #"transient_load" ) )
    {
        streaming_widgets = self getclientomnvar( streaming_omnvar );
        
        if ( !( streaming_widgets & 1 << streaming_bit ) )
        {
            foreach ( sound_bank in data.widget_types[ widget_type ].var_e53acc1cfc72fdf8 )
            {
                utility::callsharedfunc( #"snd", #"transient_load", sound_bank );
            }
        }
    }
    
    guid = utility::callsharedfunc( #"player", #"getPlayerGuid", self );
    
    if ( !isdefined( data.streamer_hints[ widget_type ][ guid ] ) )
    {
        data.streamer_hints[ widget_type ][ guid ] = [];
    }
    
    data.streamer_hints[ widget_type ][ guid ][ widget_ref ] = 1;
    thread function_2150cae686222406();
    self function_47457b9ec007482e( streaming_omnvar, streaming_bit, 1, 1 );
}

// Namespace scripted_widgets
// Params 2
// Checksum 0x92b90b4f, Offset: 0x7078
// Size: 0x1f0
function remove_streamer_hint( widget_ref, widget_type )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    data = level.scripted_widgets;
    
    if ( !isxhashasset( widget_type ) )
    {
        widget_type = hashcat( %"scriptedwidget:", widget_type );
    }
    
    guid = utility::callsharedfunc( #"player", #"getPlayerGuid", self );
    
    if ( !isdefined( data.streamer_hints[ widget_type ][ guid ] ) )
    {
        return;
    }
    
    data.streamer_hints[ widget_type ][ guid ][ widget_ref ] = undefined;
    
    if ( data.streamer_hints[ widget_type ][ guid ].size == 0 )
    {
        widget_index = data.widget_types[ widget_type ].index - 1;
        streaming_omnvar = "ui_scripted_widget_streamer_hint_" + int( widget_index / 32 );
        streaming_bit = widget_index % 32;
        self function_47457b9ec007482e( streaming_omnvar, streaming_bit, 1, 0 );
        data.streamed_widgets[ widget_type ][ guid ] = undefined;
        
        if ( data.streamed_widgets[ widget_type ].size == 0 && utility::issharedfuncdefined( #"snd", #"transient_unload" ) )
        {
            foreach ( sound_bank in data.widget_types[ widget_type ].var_e53acc1cfc72fdf8 )
            {
                utility::callsharedfunc( #"snd", #"transient_unload", sound_bank );
            }
        }
    }
}

// Namespace scripted_widgets
// Params 2
// Checksum 0xf122dac, Offset: 0x7270
// Size: 0x42
function function_6cb8b5584723528d( widget_ref, widget_type )
{
    self endon( #"death_or_disconnect" );
    utility::waittill_any( "scripted_widget_destroyed_" + widget_ref, "scripted_widget_cancelled_" + widget_ref );
    remove_streamer_hint( widget_ref, widget_type );
}

// Namespace scripted_widgets
// Params 2
// Checksum 0x58aa268a, Offset: 0x72ba
// Size: 0x93
function has_streamer_hint( widget_ref, widget_type )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    data = level.scripted_widgets;
    
    if ( !isxhashasset( widget_type ) )
    {
        widget_type = hashcat( %"scriptedwidget:", widget_type );
    }
    
    guid = utility::callsharedfunc( #"player", #"getPlayerGuid", self );
    return data.streamer_hints[ widget_type ][ guid ][ widget_ref ];
}

// Namespace scripted_widgets
// Params 1
// Checksum 0x527cb958, Offset: 0x7356
// Size: 0x88
function is_streamed( widget_type )
{
    assert( level utility::flag( "<dev string:x40>" ), "<dev string:x5d>" );
    data = level.scripted_widgets;
    
    if ( !isxhashasset( widget_type ) )
    {
        widget_type = hashcat( %"scriptedwidget:", widget_type );
    }
    
    guid = utility::callsharedfunc( #"player", #"getPlayerGuid", self );
    return data.streamed_widgets[ widget_type ][ guid ];
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x4f0709ab, Offset: 0x73e7
// Size: 0x63
function list_create( list_ref, widget_type, list_items )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    create( list_ref, widget_type );
    self.active_scripted_widgets[ list_ref ].list = [];
    
    if ( isdefined( list_items ) )
    {
        list_add_items( list_ref, list_items );
    }
}

// Namespace scripted_widgets
// Params 1
// Checksum 0xa23e679b, Offset: 0x7452
// Size: 0x31
function list_destroy( list_ref )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    function_4fee8f875eb183d6( list_ref );
    destroy( list_ref );
}

// Namespace scripted_widgets
// Params 4
// Checksum 0x7574f467, Offset: 0x748b
// Size: 0x50
function function_2ac0ab23c4b54848( list_ref, item_ref, item_type, add_to_front )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    items = [];
    items[ item_ref ] = item_type;
    list_add_items( list_ref, items, add_to_front );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x5bde9d6b, Offset: 0x74e3
// Size: 0x116
function list_add_items( list_ref, list_items, add_to_front )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    items = [];
    omnvars = [];
    
    foreach ( item_ref, item_type in list_items )
    {
        if ( !isxhashasset( item_type ) )
        {
            item_type = hashcat( %"scriptedwidget:", item_type );
        }
        
        omnvar_index = function_a458685a0fe51f5b( list_ref, tolower( item_ref ), item_type );
        assert( isdefined( omnvar_index ), "<dev string:x95b>" );
        
        if ( isdefined( omnvar_index ) )
        {
            items[ items.size ] = item_type;
            omnvars[ omnvars.size ] = omnvar_index;
        }
    }
    
    function_d317df8268207da7( list_ref, items, omnvars, add_to_front );
}

// Namespace scripted_widgets
// Params 2
// Checksum 0x1aaa1e28, Offset: 0x7601
// Size: 0x12a
function function_aaa5a6a57bedba5( list_ref, items )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    assert( self.active_scripted_widgets[ list_ref ].list.size == items.size, "<dev string:x9c5>" );
    self.active_scripted_widgets[ list_ref ].list = [];
    
    foreach ( index, item_ref in items )
    {
        item_data = function_2f27a9ff0f33aec2( list_ref, item_ref );
        assert( isdefined( item_data ), "<dev string:xa09>" + item_ref + "<dev string:xa53>" );
        self.active_scripted_widgets[ list_ref ].list[ index ] = item_data.omnvar_index;
    }
    
    list_update( list_ref );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x17f1f869, Offset: 0x7733
// Size: 0x1ad
function function_a8a42f8e8aa0dd3f( list_ref, var_dbecadc8e4358e6f, var_dbecaec8e43590a2 )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    item_data_1 = function_2f27a9ff0f33aec2( list_ref, var_dbecadc8e4358e6f );
    item_data_2 = function_2f27a9ff0f33aec2( list_ref, var_dbecaec8e43590a2 );
    assert( isdefined( item_data_1 ), "<dev string:xa55>" + var_dbecadc8e4358e6f + "<dev string:xa75>" );
    assert( isdefined( item_data_2 ), "<dev string:xa55>" + var_dbecaec8e43590a2 + "<dev string:xa75>" );
    index_1 = undefined;
    index_2 = undefined;
    var_68b7a7e4dab2533e = item_data_1.omnvar_index;
    var_68b7a6e4dab2510b = item_data_2.omnvar_index;
    
    foreach ( index, omnvar_index in self.active_scripted_widgets[ list_ref ].list )
    {
        if ( omnvar_index == var_68b7a7e4dab2533e )
        {
            index_1 = index;
        }
        
        if ( omnvar_index == var_68b7a6e4dab2510b )
        {
            index_2 = index;
        }
    }
    
    self.active_scripted_widgets[ list_ref ].list[ index_1 ] = item_data_2.omnvar_index;
    self.active_scripted_widgets[ list_ref ].list[ index_2 ] = item_data_1.omnvar_index;
    list_update( list_ref );
}

// Namespace scripted_widgets
// Params 2
// Checksum 0x408fce11, Offset: 0x78e8
// Size: 0x10d
function function_52d561531715279a( list_ref, shift_amount )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    list_size = self.active_scripted_widgets[ list_ref ].list.size;
    assert( list_size >= abs( shift_amount ), "<dev string:xa92>" + list_ref + "<dev string:xaad>" + shift_amount + "<dev string:xab3>" + list_size + "<dev string:xabe>" );
    shift_index = shift_amount;
    
    if ( shift_amount < 0 )
    {
        shift_index += list_size;
    }
    
    temp_array_1 = utility::array_slice( self.active_scripted_widgets[ list_ref ].list, 0, shift_index );
    temp_array_2 = utility::array_slice( self.active_scripted_widgets[ list_ref ].list, shift_index, list_size );
    self.active_scripted_widgets[ list_ref ].list = arraycombine( temp_array_2, temp_array_1 );
    list_update( list_ref );
}

// Namespace scripted_widgets
// Params 1
// Checksum 0x3d6688a9, Offset: 0x79fd
// Size: 0x59
function function_b282113fe68755d0( list_ref )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    self.active_scripted_widgets[ list_ref ].list = arrayreverse( self.active_scripted_widgets[ list_ref ].list );
    list_update( list_ref );
}

// Namespace scripted_widgets
// Params 4
// Checksum 0x68b7baf7, Offset: 0x7a5e
// Size: 0x110
function function_428b263004632f8( widget_ref, horizontal_alignment, vertical_alignment, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    data = function_d9b22346e3419eac( widget_ref, "data_", omnvar_override );
    
    if ( !isdefined( data ) )
    {
        return;
    }
    
    alignment = "";
    
    switch ( vertical_alignment )
    {
        case 0:
            alignment = "Top";
            break;
        case 1:
            alignment = "Middle";
            break;
        case 2:
            alignment = "Bottom";
            break;
    }
    
    switch ( horizontal_alignment )
    {
        case 0:
            alignment += "Left";
            break;
        case 1:
            alignment += "Center";
            break;
        case 2:
            alignment += "Right";
            break;
    }
    
    set_state( widget_ref, alignment, omnvar_override );
}

// Namespace scripted_widgets
// Params 1
// Checksum 0x503d64cf, Offset: 0x7b76
// Size: 0x52
function function_c1fe9df9ef716658( list_ref )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    assert( isdefined( self.var_719fa429bc4b04c9[ list_ref ] ), "<dev string:xad7>" + list_ref + "<dev string:xb03>" );
    return getarraykeys( self.var_719fa429bc4b04c9[ list_ref ] );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x4e138aac, Offset: 0x7bd1
// Size: 0x3b
function list_remove_item( list_ref, item_ref, var_8c114fad49678203 )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    function_c0e477fe094206d8( list_ref, [ item_ref ], var_8c114fad49678203 );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x6516eb2e, Offset: 0x7c14
// Size: 0x102
function function_c0e477fe094206d8( list_ref, list_items, var_8c114fad49678203 )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    
    if ( !is_active( list_ref ) )
    {
        return;
    }
    
    omnvars = [];
    
    foreach ( item_ref in list_items )
    {
        item_ref = tolower( item_ref );
        omnvar_index = function_88d3c9d93e19c10e( list_ref, item_ref );
        
        if ( isdefined( omnvar_index ) )
        {
            omnvars[ omnvars.size - 1 ] = omnvar_index;
        }
    }
    
    function_f3a75089f979a140( list_ref, omnvars );
    
    if ( var_8c114fad49678203 && !function_38614c24de8c7b52( list_ref ) )
    {
        list_destroy( list_ref );
    }
}

// Namespace scripted_widgets
// Params 1
// Checksum 0x73c3eb88, Offset: 0x7d1e
// Size: 0x57
function function_8ea01fb9860ffa54( list_ref )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    
    if ( !is_active( list_ref ) )
    {
        return;
    }
    
    function_4fee8f875eb183d6( list_ref );
    self.active_scripted_widgets[ list_ref ].list = [];
    set_data( list_ref, 0 );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0xab73babe, Offset: 0x7d7d
// Size: 0xd4
function function_ca1923c3c73e56c5( list_ref, item_ref, param )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    item_data = function_2f27a9ff0f33aec2( list_ref, item_ref );
    
    if ( isdefined( item_data ) )
    {
        data = level.scripted_widgets;
        group = self.active_scripted_widgets[ list_ref ].group;
        omnvar = function_7366ccbab2fde2f1( group, item_data.omnvar_index, "param_" );
        function_bfa6932336246cd5( param, omnvar, data.widget_types[ item_data.widget_type ].parameters );
    }
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x254752c1, Offset: 0x7e59
// Size: 0xd4
function function_12e7d25479e189f9( list_ref, item_ref, state )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    item_data = function_2f27a9ff0f33aec2( list_ref, item_ref );
    
    if ( isdefined( item_data ) )
    {
        data = level.scripted_widgets;
        group = self.active_scripted_widgets[ list_ref ].group;
        omnvar = function_7366ccbab2fde2f1( group, item_data.omnvar_index, "state_" );
        function_bfa6932336246cd5( state, omnvar, data.widget_types[ item_data.widget_type ].states );
    }
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x1ef8aef0, Offset: 0x7f35
// Size: 0xa0
function function_9a104400ea8bd68c( list_ref, item_ref, data_val )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    item_data = function_2f27a9ff0f33aec2( list_ref, item_ref );
    
    if ( isdefined( item_data ) )
    {
        group = self.active_scripted_widgets[ list_ref ].group;
        omnvar = function_7366ccbab2fde2f1( group, item_data.omnvar_index, "data_" );
        function_bfa6932336246cd5( data_val, omnvar );
    }
}

// Namespace scripted_widgets
// Params 4
// Checksum 0x851108ca, Offset: 0x7fdd
// Size: 0xe0
function function_7d1f65dbcfbe74ef( list_ref, item_ref, field_values, no_timestamp )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    item_data = function_2f27a9ff0f33aec2( list_ref, item_ref );
    
    if ( isdefined( item_data ) )
    {
        group = self.active_scripted_widgets[ list_ref ].group;
        omnvar = function_7366ccbab2fde2f1( group, item_data.omnvar_index, "data_" );
        time_omnvar = undefined;
        
        if ( !no_timestamp )
        {
            time_omnvar = function_7366ccbab2fde2f1( group, item_data.omnvar_index, "time_" );
        }
        
        function_8cf5fd538d9951dd( item_data.widget_type, omnvar, field_values, time_omnvar );
    }
}

// Namespace scripted_widgets
// Params 4
// Checksum 0x3755ecf1, Offset: 0x80c5
// Size: 0xb5
function function_97f1566c9c555e26( list_ref, item_ref, field, value )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    item_data = function_2f27a9ff0f33aec2( list_ref, item_ref );
    
    if ( isdefined( item_data ) )
    {
        group = self.active_scripted_widgets[ list_ref ].group;
        omnvar = function_7366ccbab2fde2f1( group, item_data.omnvar_index, "data_" );
        function_fd763dfab121ebdc( item_data.widget_type, omnvar, field, value );
    }
}

// Namespace scripted_widgets
// Params 5
// Checksum 0x36fea7cf, Offset: 0x8182
// Size: 0xe3
function function_e2c109f190bf2b53( list_ref, item_ref, current_pct, target_pct, time )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    item_data = function_2f27a9ff0f33aec2( list_ref, item_ref );
    
    if ( isdefined( item_data ) )
    {
        group = self.active_scripted_widgets[ list_ref ].group;
        omnvar = function_7366ccbab2fde2f1( group, item_data.omnvar_index, "data_" );
        time_omnvar = function_7366ccbab2fde2f1( group, item_data.omnvar_index, "time_" );
        function_a5884eba814ff4a9( item_data.widget_type, omnvar, current_pct, target_pct, time, time_omnvar );
    }
}

// Namespace scripted_widgets
// Params 5
// Checksum 0xe5473f81, Offset: 0x826d
// Size: 0xe3
function function_8ccaeb7568eb91ff( list_ref, item_ref, count, max_count, time )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    item_data = function_2f27a9ff0f33aec2( list_ref, item_ref );
    
    if ( isdefined( item_data ) )
    {
        group = self.active_scripted_widgets[ list_ref ].group;
        omnvar = function_7366ccbab2fde2f1( group, item_data.omnvar_index, "data_" );
        time_omnvar = function_7366ccbab2fde2f1( group, item_data.omnvar_index, "time_" );
        function_50729a8ba609355( item_data.widget_type, omnvar, count, max_count, time, time_omnvar );
    }
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x32dfb41a, Offset: 0x8358
// Size: 0xa0
function function_dca70380626a41a4( list_ref, item_ref, timestamp )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    item_data = function_2f27a9ff0f33aec2( list_ref, item_ref );
    
    if ( isdefined( item_data ) )
    {
        group = self.active_scripted_widgets[ list_ref ].group;
        omnvar = function_7366ccbab2fde2f1( group, item_data.omnvar_index, "time_" );
        function_bfa6932336246cd5( timestamp, omnvar );
    }
}

// Namespace scripted_widgets
// Params 2
// Checksum 0x5d1aa5ad, Offset: 0x8400
// Size: 0x40, Type: bool
function function_be2e1c2559f8f915( list_ref, item_ref )
{
    if ( !function_1d678e943064d3c5() )
    {
        return false;
    }
    
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    return isdefined( self.var_719fa429bc4b04c9[ list_ref ][ item_ref ] );
}

// Namespace scripted_widgets
// Params 1
// Checksum 0xc637480, Offset: 0x8449
// Size: 0x40, Type: bool
function function_38614c24de8c7b52( list_ref )
{
    if ( !function_1d678e943064d3c5() )
    {
        return false;
    }
    
    list_ref = tolower( list_ref );
    return isdefined( self.var_719fa429bc4b04c9[ list_ref ] ) && self.var_719fa429bc4b04c9[ list_ref ].size > 0;
}

// Namespace scripted_widgets
// Params 2
// Checksum 0xfa6e4101, Offset: 0x8492
// Size: 0x5b
function function_186afd5afa926606( list_ref, item_ref )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    list_ref = tolower( list_ref );
    item_ref = tolower( item_ref );
    
    if ( isdefined( self.var_719fa429bc4b04c9[ list_ref ][ item_ref ] ) )
    {
        return self.var_719fa429bc4b04c9[ list_ref ][ item_ref ].omnvar_index;
    }
}

// Namespace scripted_widgets
// Params 5
// Checksum 0x2e52adfb, Offset: 0x84f6
// Size: 0x79
function anchored_add( anchor_ent, widget_ref, widget_type, anchor_type, widget_struct )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    
    if ( !isdefined( widget_struct ) )
    {
        widget_struct = {};
    }
    
    widget_struct.ent = anchor_ent;
    widget_struct.anchor_type = anchor_type;
    create( widget_ref, widget_type, widget_struct );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0xd7f4f661, Offset: 0x8577
// Size: 0x42
function anchored_set_param( anchor_ent, widget_ref, param )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    set_param( widget_ref, param );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0xf19eea2a, Offset: 0x85c1
// Size: 0x42
function anchored_set_data( anchor_ent, widget_ref, data )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    set_data( widget_ref, data );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0xd7f4f661, Offset: 0x860b
// Size: 0x42
function anchored_set_state( anchor_ent, widget_ref, state )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    set_state( widget_ref, state );
}

// Namespace scripted_widgets
// Params 4
// Checksum 0xcfc4b5b8, Offset: 0x8655
// Size: 0x4b
function function_d90ce8e5dfc9ce81( anchor_ent, widget_ref, field_values, omnvar_override )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    return function_1cbc8727b7beb808( widget_ref, field_values, omnvar_override );
}

// Namespace scripted_widgets
// Params 4
// Checksum 0xcfc4b583, Offset: 0x86a9
// Size: 0x4c
function function_f67a7797f3301a25( anchor_ent, widget_ref, field_values, no_timestamp )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    function_dd7a63eea5bde0dc( widget_ref, field_values, no_timestamp );
}

// Namespace scripted_widgets
// Params 5
// Checksum 0x5941a8e9, Offset: 0x86fd
// Size: 0x57
function function_4976cb462af2e961( anchor_ent, widget_ref, current_pct, target_pct, time )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    archetype_set_progress( widget_ref, current_pct, target_pct, time );
}

// Namespace scripted_widgets
// Params 4
// Checksum 0x6d1a9a66, Offset: 0x875c
// Size: 0x4c
function function_74a4e8eebcc55bd6( anchor_ent, widget_ref, current_pct, bool )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    function_1f64ed5f88c8ce49( widget_ref, current_pct, bool );
}

// Namespace scripted_widgets
// Params 4
// Checksum 0xbdd852be, Offset: 0x87b0
// Size: 0x4c
function function_8fe0abaf9b6c7602( anchor_ent, widget_ref, current_pct, current_alpha )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    function_cd5be9aeaf7e4e4f( widget_ref, current_pct, current_alpha );
}

// Namespace scripted_widgets
// Params 3
// Checksum 0x12b9dc6a, Offset: 0x8804
// Size: 0x42
function function_f0c014afded8b6c6( anchor_ent, widget_ref, timestamp )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    widget_ref = tolower( widget_ref ) + anchor_ent getentitynumber();
    set_timestamp( widget_ref, timestamp );
}

// Namespace scripted_widgets
// Params 2
// Checksum 0x9ffa60dc, Offset: 0x884e
// Size: 0x47
function anchored_remove( anchor_ent, widget_ref )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    ent_num = anchor_ent getentitynumber();
    widget_ref = tolower( widget_ref ) + ent_num;
    anchored_release( widget_ref, ent_num );
}

// Namespace scripted_widgets
// Params 1
// Checksum 0xd5292544, Offset: 0x889d
// Size: 0x24
function anchored_remove_all( anchor_ent )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    function_fc9b148df14cfcf8( anchor_ent getentitynumber() );
}

// Namespace scripted_widgets
// Params 2
// Checksum 0x9f1f7dc9, Offset: 0x88c9
// Size: 0x4c
function anchored_is_active( anchor_ent, widget_ref )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    ent_num = anchor_ent getentitynumber();
    widget_ref = tolower( widget_ref ) + ent_num;
    return isdefined( self.var_ee7b3c5755530a30[ ent_num ][ widget_ref ] );
}

// Namespace scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0x29edddfc, Offset: 0x891e
// Size: 0x82
function private anchored_release( widget_ref, ent_num )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    if ( isdefined( self.var_ee7b3c5755530a30[ ent_num ] ) )
    {
        if ( isdefined( self.var_ee7b3c5755530a30[ ent_num ][ widget_ref ] ) )
        {
            destroy( widget_ref );
        }
        
        self.var_ee7b3c5755530a30[ ent_num ][ widget_ref ] = undefined;
        
        if ( self.var_ee7b3c5755530a30[ ent_num ].size == 0 )
        {
            self.var_ee7b3c5755530a30[ ent_num ] = undefined;
            self notify( "_automatic_remove_anchored_widget_" + ent_num );
        }
    }
}

// Namespace scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0xbfe36e1a, Offset: 0x89a8
// Size: 0x12e
function private function_fc9b148df14cfcf8( ent_num, reason )
{
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    if ( isdefined( self.var_ee7b3c5755530a30[ ent_num ] ) )
    {
        reasonisdeath = reason == "death";
        
        foreach ( widget_ref, index in self.var_ee7b3c5755530a30[ ent_num ] )
        {
            if ( !is_active( widget_ref ) )
            {
                continue;
            }
            
            active_widget = self.active_scripted_widgets[ widget_ref ];
            var_de8e73fd262d9236 = active_widget.remove_on_death ?? 1;
            
            if ( reasonisdeath && !var_de8e73fd262d9236 )
            {
                active_widget.ent_num = undefined;
                continue;
            }
            
            destroy( widget_ref );
        }
        
        self.var_ee7b3c5755530a30[ ent_num ] = undefined;
        self notify( "_automatic_remove_anchored_widget_" + ent_num );
    }
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x9aee9e0d, Offset: 0x8ade
// Size: 0x73
function private function_bbf3c75a748aaf3f( ent )
{
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    ent_num = ent getentitynumber();
    self notify( "_automatic_remove_anchored_widget_" + ent_num );
    self endon( "_automatic_remove_anchored_widget_" + ent_num );
    msg = ent utility::waittill_any_return( "death", "disconnect", "deleted" );
    thread function_fc9b148df14cfcf8( ent_num, msg );
}

// Namespace scripted_widgets
// Params 5, eflags: 0x4
// Checksum 0x5a84e9e3, Offset: 0x8b59
// Size: 0xfe
function private function_d308b6632639bde9( value, archetype, field, packed_value, clear )
{
    data = level.scripted_widgets.archetypes;
    field = function_b2e49ff7cbc3fc1c( field );
    assert( isdefined( data[ archetype ] ), "<dev string:xb1e>" + getxhashsourcename( archetype ) + "<dev string:xb63>" );
    assert( isdefined( data[ archetype ].fields[ field ] ), "<dev string:xb7b>" + getxhashsourcename( archetype ) + "<dev string:xbc0>" + function_886d6ce36915ff2c( field ) + "<dev string:x2b4>" );
    
    if ( !isdefined( data[ archetype ] ) || !isdefined( data[ archetype ].fields[ field ] ) )
    {
        return packed_value;
    }
    
    return function_1b5b0f6775409812( value, data[ archetype ].fields[ field ], function_b2e49ff7cbc3fc1c( field ), archetype, packed_value, clear );
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x52a0195f, Offset: 0x8c60
// Size: 0x6d
function private function_a6ef1a5eb9da56b0( widget_type )
{
    data = level.scripted_widgets;
    
    if ( !isdefined( data.widget_types[ widget_type ] ) || !isdefined( data.widget_types[ widget_type ].archetype ) )
    {
        return widget_type;
    }
    
    return data.widget_types[ widget_type ].archetype;
}

// Namespace scripted_widgets
// Params 6, eflags: 0x4
// Checksum 0x38ad40eb, Offset: 0x8cd6
// Size: 0x147
function private function_1b5b0f6775409812( value, field_data, field_label, var_ec8ce643b74e5e5f, packed_value, clear )
{
    if ( value > field_data.max_value )
    {
        assert( "<dev string:xbcf>" + getxhashsourcename( var_ec8ce643b74e5e5f ) + "<dev string:xbf2>" + field_label + "<dev string:xbfd>" + value + "<dev string:xc14>" + field_data.max_value + "<dev string:xc25>" );
        value = field_data.max_value;
    }
    
    if ( value < field_data.min_value )
    {
        assert( "<dev string:xc3f>" + getxhashsourcename( var_ec8ce643b74e5e5f ) + "<dev string:xbf2>" + field_label + "<dev string:xbfd>" + value + "<dev string:xc62>" + field_data.min_value + "<dev string:xc73>" );
        value = field_data.min_value;
    }
    
    value = int( ( value - field_data.min_value ) / field_data.step_increment + 0.5 );
    
    if ( clear )
    {
        packed_value &= ~field_data.mask;
    }
    
    packed_value |= value << field_data.shift;
    return packed_value;
}

// Namespace scripted_widgets
// Params 3, eflags: 0x4
// Checksum 0x9a800a77, Offset: 0x8e26
// Size: 0xdf
function private function_55e6f33e16677046( value, archetype, field )
{
    data = level.scripted_widgets.archetypes;
    field = function_b2e49ff7cbc3fc1c( field );
    assert( isdefined( data[ archetype ] ), "<dev string:xb1e>" + getxhashsourcename( archetype ) + "<dev string:xb63>" );
    assert( isdefined( data[ archetype ].fields[ field ] ), "<dev string:xb7b>" + getxhashsourcename( archetype ) + "<dev string:xbc0>" + function_886d6ce36915ff2c( field ) + "<dev string:x2b4>" );
    
    if ( !isdefined( data[ archetype ] ) || !isdefined( data[ archetype ].fields[ field ] ) )
    {
        return 0;
    }
    
    return function_f9af076e19de7563( value, data[ archetype ].fields[ field ] );
}

// Namespace scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0x61267dfa, Offset: 0x8f0e
// Size: 0x53
function private function_f9af076e19de7563( value, field_data )
{
    value = ( value & field_data.mask ) >> field_data.shift;
    value *= field_data.step_increment;
    value += field_data.min_value;
    return value;
}

// Namespace scripted_widgets
// Params 6, eflags: 0x4
// Checksum 0x63e31f56, Offset: 0x8f6a
// Size: 0x540
function private function_8cf5fd538d9951dd( widget_type, omnvar, field_values, time_omnvar, expanded_data, no_timestamp )
{
    data = level.scripted_widgets;
    assert( isdefined( data.widget_types[ widget_type ] ), "<dev string:x2a6>" + getxhashsourcename( widget_type ) + "<dev string:x2b4>" );
    
    if ( !isdefined( data.widget_types[ widget_type ] ) )
    {
        return;
    }
    
    var_ec8ce643b74e5e5f = function_a6ef1a5eb9da56b0( widget_type );
    data_layout = get_widget_data_layout( widget_type );
    
    if ( !isdefined( data_layout ) )
    {
        return;
    }
    
    fields = data_layout.fields;
    field_groups = data_layout.field_groups;
    packed_values = [];
    packed_values[ omnvar ] = 0;
    
    if ( expanded_data )
    {
        foreach ( expanded_data_struct in expanded_data )
        {
            foreach ( expanded_omnvar in expanded_data_struct.omnvars )
            {
                packed_values[ expanded_omnvar ] = 0;
            }
        }
    }
    
    foreach ( field, value in field_values )
    {
        normalized_field = function_b2e49ff7cbc3fc1c( field );
        
        if ( isdefined( fields[ normalized_field ] ) )
        {
            value = function_1969bbce2ecdd7a6( value, fields[ normalized_field ], normalized_field, var_ec8ce643b74e5e5f );
            
            if ( !isdefined( value ) )
            {
                continue;
            }
            
            value = clamp( value, 0, fields[ normalized_field ].max_value );
            omnvar_name = omnvar;
            
            if ( isdefined( fields[ normalized_field ].var_d1d990df30825593 ) )
            {
                omnvar_name = expanded_data[ fields[ normalized_field ].var_d1d990df30825593 ].omnvars[ fields[ normalized_field ].expanded_data_omnvar ];
            }
            
            packed_values[ omnvar_name ] = function_1b5b0f6775409812( value, fields[ normalized_field ], function_b2e49ff7cbc3fc1c( normalized_field ), var_ec8ce643b74e5e5f, packed_values[ omnvar_name ] );
            continue;
        }
        
        normalized_group = function_2ae2122ff77c7780( field );
        
        if ( !isdefined( field_groups[ normalized_group ] ) || !isarray( value ) )
        {
            continue;
        }
        
        foreach ( group_index, group_field_values in value )
        {
            if ( !isdefined( field_groups[ normalized_group ].fields[ group_index ] ) )
            {
                continue;
            }
            
            group_fields = field_groups[ normalized_group ].fields[ group_index ];
            
            foreach ( group_field, group_value in group_field_values )
            {
                var_99482c2d199a22d0 = function_b2e49ff7cbc3fc1c( group_field );
                
                if ( !isdefined( group_fields[ var_99482c2d199a22d0 ] ) )
                {
                    continue;
                }
                
                field_data = group_fields[ var_99482c2d199a22d0 ];
                group_value = function_1969bbce2ecdd7a6( group_value, field_data, var_99482c2d199a22d0, var_ec8ce643b74e5e5f );
                
                if ( !isdefined( group_value ) )
                {
                    continue;
                }
                
                omnvar_name = omnvar;
                
                if ( expanded_data && isdefined( field_data.var_d1d990df30825593 ) )
                {
                    omnvar_name = expanded_data[ field_data.var_d1d990df30825593 ].omnvars[ field_data.expanded_data_omnvar ];
                }
                
                packed_values[ omnvar_name ] = function_1b5b0f6775409812( group_value, field_data, function_b2e49ff7cbc3fc1c( var_99482c2d199a22d0 ), var_ec8ce643b74e5e5f, packed_values[ omnvar_name ] );
            }
        }
    }
    
    foreach ( omnvar_name, packed_value in packed_values )
    {
        self setclientomnvar( omnvar_name, packed_value );
    }
    
    if ( !no_timestamp && isdefined( time_omnvar ) )
    {
        self setclientomnvar( time_omnvar, gettime() );
    }
}

// Namespace scripted_widgets
// Params 5, eflags: 0x4
// Checksum 0x183ecc48, Offset: 0x94b2
// Size: 0x1b6
function private function_fd763dfab121ebdc( widget_type, omnvar, field, value, expanded_data )
{
    data = level.scripted_widgets;
    assert( isdefined( data.widget_types[ widget_type ] ), "<dev string:x2a6>" + getxhashsourcename( widget_type ) + "<dev string:x2b4>" );
    
    if ( !isdefined( data.widget_types[ widget_type ] ) )
    {
        return;
    }
    
    var_ec8ce643b74e5e5f = function_a6ef1a5eb9da56b0( widget_type );
    data_layout = get_widget_data_layout( widget_type );
    
    if ( !isdefined( data_layout ) )
    {
        return;
    }
    
    fields = data_layout.fields;
    field = function_b2e49ff7cbc3fc1c( field );
    assert( isdefined( fields[ field ] ), "<dev string:xc8d>" + function_886d6ce36915ff2c( field ) + "<dev string:xc95>" + getxhashsourcename( var_ec8ce643b74e5e5f ) + "<dev string:x1a2>" );
    
    if ( !isdefined( fields[ field ] ) )
    {
        return;
    }
    
    if ( expanded_data && isdefined( fields[ field ].var_d1d990df30825593 ) )
    {
        omnvar = expanded_data[ fields[ field ].var_d1d990df30825593 ].omnvars[ fields[ field ].expanded_data_omnvar ];
    }
    
    packed_value = self getclientomnvar( omnvar );
    value = function_1969bbce2ecdd7a6( value, fields[ field ], field, var_ec8ce643b74e5e5f );
    
    if ( !isdefined( value ) )
    {
        return;
    }
    
    value = clamp( value, 0, fields[ field ].max_value );
    packed_value = function_1b5b0f6775409812( value, fields[ field ], function_b2e49ff7cbc3fc1c( field ), var_ec8ce643b74e5e5f, packed_value, 1 );
    self setclientomnvar( omnvar, packed_value );
}

// Namespace scripted_widgets
// Params 4, eflags: 0x4
// Checksum 0x95c9bf0f, Offset: 0x9670
// Size: 0x2ef
function private function_36ff92d61c415b99( widget_type, omnvar, fields, expanded_data )
{
    data = level.scripted_widgets;
    assert( isdefined( data.widget_types[ widget_type ] ), "<dev string:x2a6>" + getxhashsourcename( widget_type ) + "<dev string:x2b4>" );
    
    if ( !isdefined( data.widget_types[ widget_type ] ) )
    {
        return [];
    }
    
    var_ec8ce643b74e5e5f = function_a6ef1a5eb9da56b0( widget_type );
    data_layout = get_widget_data_layout( widget_type );
    
    if ( !isdefined( data_layout ) )
    {
        return [];
    }
    
    archetype_fields = data_layout.fields;
    
    if ( !isdefined( fields ) )
    {
        fields = getarraykeys( archetype_fields );
    }
    
    values = [];
    values[ omnvar ] = self getclientomnvar( omnvar );
    
    if ( expanded_data )
    {
        foreach ( expanded_data_struct in expanded_data )
        {
            foreach ( expanded_omnvar in expanded_data_struct.omnvars )
            {
                values[ expanded_omnvar ] = self getclientomnvar( expanded_omnvar );
            }
        }
    }
    
    field_values = [];
    
    foreach ( field in fields )
    {
        normalized_field = function_b2e49ff7cbc3fc1c( field );
        assert( isdefined( archetype_fields[ normalized_field ] ), "<dev string:xc8d>" + function_886d6ce36915ff2c( normalized_field ) + "<dev string:xc95>" + getxhashsourcename( var_ec8ce643b74e5e5f ) + "<dev string:x1a2>" );
        
        if ( !isdefined( archetype_fields[ normalized_field ] ) )
        {
            continue;
        }
        
        field_data = archetype_fields[ normalized_field ];
        
        if ( isdefined( field_data.var_d1d990df30825593 ) )
        {
            omnvar_name = expanded_data[ field_data.var_d1d990df30825593 ].omnvars[ field_data.expanded_data_omnvar ];
        }
        else
        {
            omnvar_name = omnvar;
        }
        
        field_values[ field ] = function_f9af076e19de7563( values[ omnvar_name ], field_data );
    }
    
    return field_values;
}

// Namespace scripted_widgets
// Params 8, eflags: 0x4
// Checksum 0x2b0ff47d, Offset: 0x9968
// Size: 0x391
function private function_a546790e875abe29( widget_type, omnvar, group_name, group_index, field_values, time_omnvar, expanded_data, no_timestamp )
{
    data = level.scripted_widgets;
    
    if ( !isdefined( data.widget_types[ widget_type ] ) )
    {
        return;
    }
    
    var_ec8ce643b74e5e5f = function_a6ef1a5eb9da56b0( widget_type );
    data_layout = get_widget_data_layout( widget_type );
    group_name = function_2ae2122ff77c7780( group_name );
    
    if ( !isdefined( data_layout ) || !isdefined( data_layout.field_groups[ group_name ] ) || !isdefined( data_layout.field_groups[ group_name ].fields[ group_index ] ) )
    {
        return;
    }
    
    group_fields = data_layout.field_groups[ group_name ].fields[ group_index ];
    packed_values = [];
    packed_values[ omnvar ] = self getclientomnvar( omnvar );
    
    if ( expanded_data )
    {
        foreach ( expanded_data_struct in expanded_data )
        {
            foreach ( expanded_omnvar in expanded_data_struct.omnvars )
            {
                packed_values[ expanded_omnvar ] = self getclientomnvar( expanded_omnvar );
            }
        }
    }
    
    foreach ( field, value in field_values )
    {
        normalized_field = function_b2e49ff7cbc3fc1c( field );
        
        if ( !isdefined( group_fields[ normalized_field ] ) )
        {
            continue;
        }
        
        field_data = group_fields[ normalized_field ];
        value = function_1969bbce2ecdd7a6( value, field_data, normalized_field, var_ec8ce643b74e5e5f );
        
        if ( !isdefined( value ) )
        {
            continue;
        }
        
        omnvar_name = omnvar;
        
        if ( expanded_data && isdefined( field_data.var_d1d990df30825593 ) )
        {
            omnvar_name = expanded_data[ field_data.var_d1d990df30825593 ].omnvars[ field_data.expanded_data_omnvar ];
        }
        
        packed_values[ omnvar_name ] = function_1b5b0f6775409812( value, field_data, function_b2e49ff7cbc3fc1c( normalized_field ), var_ec8ce643b74e5e5f, packed_values[ omnvar_name ], 1 );
    }
    
    foreach ( omnvar_name, packed_value in packed_values )
    {
        self setclientomnvar( omnvar_name, packed_value );
    }
    
    if ( !no_timestamp && isdefined( time_omnvar ) )
    {
        self setclientomnvar( time_omnvar, gettime() );
    }
}

// Namespace scripted_widgets
// Params 7, eflags: 0x4
// Checksum 0x82b74289, Offset: 0x9d01
// Size: 0x19d
function private function_a0966a869e7a7a40( widget_type, omnvar, group_name, group_index, field, value, expanded_data )
{
    data = level.scripted_widgets;
    
    if ( !isdefined( data.widget_types[ widget_type ] ) )
    {
        return;
    }
    
    var_ec8ce643b74e5e5f = function_a6ef1a5eb9da56b0( widget_type );
    data_layout = get_widget_data_layout( widget_type );
    group_name = function_2ae2122ff77c7780( group_name );
    field = function_b2e49ff7cbc3fc1c( field );
    
    if ( !isdefined( data_layout ) || !isdefined( data_layout.field_groups[ group_name ] ) || !isdefined( data_layout.field_groups[ group_name ].fields[ group_index ] ) )
    {
        return;
    }
    
    group_fields = data_layout.field_groups[ group_name ].fields[ group_index ];
    
    if ( !isdefined( group_fields[ field ] ) )
    {
        return;
    }
    
    field_data = group_fields[ field ];
    
    if ( expanded_data && isdefined( field_data.var_d1d990df30825593 ) )
    {
        omnvar = expanded_data[ field_data.var_d1d990df30825593 ].omnvars[ field_data.expanded_data_omnvar ];
    }
    
    packed_value = self getclientomnvar( omnvar );
    value = function_1969bbce2ecdd7a6( value, field_data, field, var_ec8ce643b74e5e5f );
    
    if ( !isdefined( value ) )
    {
        return;
    }
    
    packed_value = function_1b5b0f6775409812( value, field_data, function_b2e49ff7cbc3fc1c( field ), var_ec8ce643b74e5e5f, packed_value, 1 );
    self setclientomnvar( omnvar, packed_value );
}

// Namespace scripted_widgets
// Params 6, eflags: 0x4
// Checksum 0x60bb2ee6, Offset: 0x9ea6
// Size: 0x2df
function private function_be250f1771083c75( widget_type, omnvar, group_name, group_index, fields, expanded_data )
{
    data = level.scripted_widgets;
    
    if ( !isdefined( data.widget_types[ widget_type ] ) )
    {
        return [];
    }
    
    data_layout = get_widget_data_layout( widget_type );
    group_name = function_2ae2122ff77c7780( group_name );
    
    if ( !isdefined( data_layout ) || !isdefined( data_layout.field_groups[ group_name ] ) || !isdefined( data_layout.field_groups[ group_name ].fields[ group_index ] ) )
    {
        return [];
    }
    
    group_fields = data_layout.field_groups[ group_name ].fields[ group_index ];
    
    if ( !isdefined( fields ) )
    {
        fields = getarraykeys( group_fields );
    }
    
    values = [];
    values[ omnvar ] = self getclientomnvar( omnvar );
    
    if ( expanded_data )
    {
        foreach ( expanded_data_struct in expanded_data )
        {
            foreach ( expanded_omnvar in expanded_data_struct.omnvars )
            {
                values[ expanded_omnvar ] = self getclientomnvar( expanded_omnvar );
            }
        }
    }
    
    field_values = [];
    
    foreach ( field in fields )
    {
        normalized_field = function_b2e49ff7cbc3fc1c( field );
        
        if ( !isdefined( group_fields[ normalized_field ] ) )
        {
            continue;
        }
        
        field_data = group_fields[ normalized_field ];
        
        if ( isdefined( field_data.var_d1d990df30825593 ) )
        {
            omnvar_name = expanded_data[ field_data.var_d1d990df30825593 ].omnvars[ field_data.expanded_data_omnvar ];
        }
        else
        {
            omnvar_name = omnvar;
        }
        
        field_values[ field ] = function_f9af076e19de7563( values[ omnvar_name ], field_data );
    }
    
    return field_values;
}

// Namespace scripted_widgets
// Params 6, eflags: 0x4
// Checksum 0x57634208, Offset: 0xa18e
// Size: 0x1da
function private function_a5884eba814ff4a9( widget_type, omnvar, current_pct, target_pct, time, time_omnvar )
{
    data = level.scripted_widgets;
    widget_archetypes = level.scripted_widgets.archetypes;
    archetype = %"hash_30fb60496773b970";
    assert( isdefined( data.widget_types[ widget_type ] ) && data.widget_types[ widget_type ].archetype == archetype, "<dev string:x2a6>" + getxhashsourcename( widget_type ) + "<dev string:xcc5>" + getxhashsourcename( archetype ) + "<dev string:xcd2>" );
    
    if ( !isdefined( data.widget_types[ widget_type ] ) || data.widget_types[ widget_type ].archetype != archetype )
    {
        return;
    }
    
    current_pct_field = #"current_pct";
    target_pct_field = #"target_pct";
    time_field = #"time";
    current_pct = clamp( current_pct, 0, widget_archetypes[ archetype ].fields[ current_pct_field ].max_value );
    target_pct = clamp( target_pct, 0, widget_archetypes[ archetype ].fields[ target_pct_field ].max_value );
    packed_value = 0;
    packed_value = function_d308b6632639bde9( current_pct, archetype, current_pct_field, packed_value );
    packed_value = function_d308b6632639bde9( target_pct, archetype, target_pct_field, packed_value );
    packed_value = function_d308b6632639bde9( time, archetype, time_field, packed_value );
    self setclientomnvar( omnvar, packed_value );
    self setclientomnvar( time_omnvar, gettime() );
}

// Namespace scripted_widgets
// Params 5, eflags: 0x4
// Checksum 0x335178d7, Offset: 0xa370
// Size: 0x189
function private function_edbb7fcd923a5f0e( widget_type, omnvar, current_pct, bool, time_omnvar )
{
    data = level.scripted_widgets;
    widget_archetypes = level.scripted_widgets.archetypes;
    archetype = %"hash_5f97da188cc7b7e5";
    assert( isdefined( data.widget_types[ widget_type ] ) && data.widget_types[ widget_type ].archetype == archetype, "<dev string:x2a6>" + getxhashsourcename( widget_type ) + "<dev string:xcc5>" + getxhashsourcename( archetype ) + "<dev string:xcd2>" );
    
    if ( !isdefined( data.widget_types[ widget_type ] ) || data.widget_types[ widget_type ].archetype != archetype )
    {
        return;
    }
    
    current_pct_field = #"current_pct";
    bool_field = #"bool";
    current_pct = clamp( current_pct, 0, widget_archetypes[ archetype ].fields[ current_pct_field ].max_value );
    packed_value = 0;
    packed_value = function_d308b6632639bde9( current_pct, archetype, current_pct_field, packed_value );
    packed_value = function_d308b6632639bde9( bool, archetype, bool_field, packed_value );
    self setclientomnvar( omnvar, packed_value );
    self setclientomnvar( time_omnvar, gettime() );
}

// Namespace scripted_widgets
// Params 5, eflags: 0x4
// Checksum 0x97a71645, Offset: 0xa501
// Size: 0x1b0
function private function_8addc2ad9b69713a( widget_type, omnvar, current_pct, current_alpha, time_omnvar )
{
    data = level.scripted_widgets;
    widget_archetypes = level.scripted_widgets.archetypes;
    archetype = %"hash_11e4e971f1764713";
    assert( isdefined( data.widget_types[ widget_type ] ) && data.widget_types[ widget_type ].archetype == archetype, "<dev string:x2a6>" + getxhashsourcename( widget_type ) + "<dev string:xcc5>" + getxhashsourcename( archetype ) + "<dev string:xcd2>" );
    
    if ( !isdefined( data.widget_types[ widget_type ] ) || data.widget_types[ widget_type ].archetype != archetype )
    {
        return;
    }
    
    current_pct_field = #"current_pct";
    current_alpha_field = #"current_alpha";
    current_pct = clamp( current_pct, 0, widget_archetypes[ archetype ].fields[ current_pct_field ].max_value );
    current_alpha = clamp( current_alpha, 0, widget_archetypes[ archetype ].fields[ current_alpha_field ].max_value );
    packed_value = 0;
    packed_value = function_d308b6632639bde9( current_pct, archetype, current_pct_field, packed_value );
    packed_value = function_d308b6632639bde9( current_alpha, archetype, current_alpha_field, packed_value );
    self setclientomnvar( omnvar, packed_value );
    self setclientomnvar( time_omnvar, gettime() );
}

// Namespace scripted_widgets
// Params 6, eflags: 0x4
// Checksum 0xe089e033, Offset: 0xa6b9
// Size: 0x1fd
function private function_50729a8ba609355( widget_type, omnvar, count, max_count, time, time_omnvar )
{
    data = level.scripted_widgets;
    widget_archetypes = level.scripted_widgets.archetypes;
    archetype = %"hash_4be23b86080cdcf6";
    assert( isdefined( data.widget_types[ widget_type ] ) && data.widget_types[ widget_type ].archetype == archetype, "<dev string:x2a6>" + getxhashsourcename( widget_type ) + "<dev string:xcc5>" + getxhashsourcename( archetype ) + "<dev string:xcd2>" );
    
    if ( !isdefined( data.widget_types[ widget_type ] ) || data.widget_types[ widget_type ].archetype != archetype )
    {
        return;
    }
    
    count_field = #"count";
    max_count_field = #"max_count";
    count = clamp( count, 0, widget_archetypes[ archetype ].fields[ count_field ].max_value );
    
    if ( isdefined( max_count ) )
    {
        max_count = clamp( max_count, 0, widget_archetypes[ archetype ].fields[ max_count_field ].max_value );
    }
    else
    {
        max_count = 0;
    }
    
    if ( !isdefined( time ) )
    {
        time = 0;
    }
    
    packed_value = 0;
    packed_value = function_d308b6632639bde9( count, archetype, "count", packed_value );
    packed_value = function_d308b6632639bde9( max_count, archetype, "max_count", packed_value );
    packed_value = function_d308b6632639bde9( time, archetype, "time", packed_value );
    self setclientomnvar( omnvar, packed_value );
    
    if ( time > 0 && isdefined( time_omnvar ) )
    {
        self setclientomnvar( time_omnvar, gettime() );
    }
}

// Namespace scripted_widgets
// Params 5, eflags: 0x4
// Checksum 0x55852873, Offset: 0xa8be
// Size: 0x9d
function private function_bfa6932336246cd5( value, omnvar, ref_table, mask, shift )
{
    if ( !isint( value ) && isdefined( ref_table ) )
    {
        if ( !isxhash( value ) )
        {
            value = getxhash( value );
        }
        
        value = ref_table[ value ];
    }
    
    if ( isint( value ) )
    {
        if ( isdefined( shift ) )
        {
            value <<= shift;
        }
        
        if ( isdefined( mask ) )
        {
            omnvar_value = self getclientomnvar( omnvar );
            omnvar_value &= ~mask;
            value |= omnvar_value;
        }
        
        self setclientomnvar( omnvar, value );
    }
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x56f3c0a8, Offset: 0xa963
// Size: 0x25
function private function_31acd2506afda85( current_index )
{
    return ( current_index + 1 ) % level.scripted_widgets.max_widgets;
}

// Namespace scripted_widgets
// Params 3, eflags: 0x4
// Checksum 0x68820d47, Offset: 0xa991
// Size: 0x345
function private function_60aa03122dfc9861( widget_ref, widget_type, data_layout )
{
    assert( isplayer( self ), "<dev string:xce5>" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    for ( i = self.var_6dfd888d8d61534b.size - 1; i >= 0 ; i-- )
    {
        index = self.var_6dfd888d8d61534b[ i ];
        
        if ( is_chain_available( index, data_layout.var_ce2c3c2e107514d0 ) )
        {
            self.var_be61ad67e9b09fb[ index ] = 1;
            self.var_6dfd888d8d61534b = arrayremove( self.var_6dfd888d8d61534b, index );
            reset_omnvars( index );
            chain_index = index;
            var_2dc3906d7d3f59af = level.scripted_widgets.var_5efe4ada2f42ba2f;
            omnvar_names = level.scripted_widgets.omnvar_names;
            expanded_data = [];
            
            for ( j = 0; j < data_layout.var_ce2c3c2e107514d0 ; j++ )
            {
                chain_index = function_31acd2506afda85( chain_index );
                self.var_be61ad67e9b09fb[ chain_index ] = 1;
                self.var_6dfd888d8d61534b = arrayremove( self.var_6dfd888d8d61534b, chain_index );
                reset_omnvars( chain_index, 1 );
                expanded_data[ j ] = { #omnvars:[], #index:chain_index };
                
                if ( j < data_layout.var_ce2c3c2e107514d0 - 1 )
                {
                    foreach ( expanded_omnvar in var_2dc3906d7d3f59af )
                    {
                        expanded_data[ j ].omnvars[ expanded_omnvar.name ] = omnvar_names[ chain_index ][ expanded_omnvar.name ];
                    }
                    
                    continue;
                }
                
                foreach ( expanded_index, expanded_omnvar in var_2dc3906d7d3f59af )
                {
                    if ( expanded_index > data_layout.var_dcab5b5545e553c4 )
                    {
                        break;
                    }
                    
                    expanded_data[ j ].omnvars[ expanded_omnvar.name ] = omnvar_names[ chain_index ][ expanded_omnvar.name ];
                }
            }
            
            self.active_scripted_widgets[ widget_ref ] = { #expanded_data:expanded_data, #widget_type:widget_type, #index:index };
            self.var_caf8874bd35dda24[ index ] = widget_ref;
            return index;
        }
    }
    
    assertmsg( "<dev string:xd29>" + data_layout.var_ce2c3c2e107514d0 + "<dev string:xd3c>" + widget_ref + "<dev string:xd71>" + getxhashsourcename( widget_type ) + "<dev string:xd7d>" );
}

// Namespace scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0x7e16fbd5, Offset: 0xacdf
// Size: 0x1ac
function private reserve( widget_ref, widget_type )
{
    data = level.scripted_widgets;
    index = undefined;
    assert( isplayer( self ), "<dev string:xce5>" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_6dfd888d8d61534b ) )
    {
        self.var_6dfd888d8d61534b = [];
        
        for ( i = 0; i < data.max_widgets ; i++ )
        {
            self.var_6dfd888d8d61534b[ i ] = data.max_widgets - 1 - i;
        }
    }
    
    if ( !isdefined( self.var_be61ad67e9b09fb ) )
    {
        self.var_be61ad67e9b09fb = [];
    }
    
    if ( !isdefined( self.active_scripted_widgets ) )
    {
        self.active_scripted_widgets = [];
    }
    
    if ( !isdefined( self.var_caf8874bd35dda24 ) )
    {
        self.var_caf8874bd35dda24 = [];
    }
    
    data_layout = get_widget_data_layout( widget_type );
    
    if ( self.var_6dfd888d8d61534b.size > 0 )
    {
        if ( ( istrue( data_layout.var_ce2c3c2e107514d0 ) ?? 0 ) > 0 )
        {
            index = function_60aa03122dfc9861( widget_ref, widget_type, data_layout );
        }
        else
        {
            index = self.var_6dfd888d8d61534b[ self.var_6dfd888d8d61534b.size - 1 ];
            self.var_6dfd888d8d61534b[ self.var_6dfd888d8d61534b.size - 1 ] = undefined;
            self.var_be61ad67e9b09fb[ index ] = 1;
            self.active_scripted_widgets[ widget_ref ] = { #widget_type:widget_type, #index:index };
            self.var_caf8874bd35dda24[ index ] = widget_ref;
            reset_omnvars( index );
        }
    }
    
    return index;
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x7f06b5ee, Offset: 0xae94
// Size: 0xa6
function private insert_index_sorted( index )
{
    size = self.var_6dfd888d8d61534b.size;
    
    for ( i = size - 1; i >= 0 ; i-- )
    {
        if ( self.var_6dfd888d8d61534b[ i ] > index )
        {
            arrayinsert( self.var_6dfd888d8d61534b, index, i + 1 );
            return;
        }
        
        if ( self.var_6dfd888d8d61534b[ i ] == index )
        {
            assertmsg( "<dev string:xda6>" + index + "<dev string:xdb7>" );
            return;
        }
    }
    
    arrayinsert( self.var_6dfd888d8d61534b, index, 0 );
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x98133903, Offset: 0xaf42
// Size: 0x1c9
function private release( widget_ref )
{
    data = level.scripted_widgets;
    indices = [];
    assert( isplayer( self ), "<dev string:xce5>" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( isdefined( self.active_scripted_widgets[ widget_ref ] ) )
    {
        indices[ 0 ] = self.active_scripted_widgets[ widget_ref ].index;
        
        foreach ( expanded_data in self.active_scripted_widgets[ widget_ref ].expanded_data ?? [] )
        {
            indices[ indices.size ] = expanded_data.index;
        }
    }
    
    foreach ( index in indices )
    {
        self.var_be61ad67e9b09fb[ index ] = undefined;
        
        if ( data.var_85cc405a98ca4c14 )
        {
            insert_index_sorted( index );
            continue;
        }
        
        self.var_6dfd888d8d61534b[ self.var_6dfd888d8d61534b.size ] = index;
    }
    
    self.active_scripted_widgets[ widget_ref ] = undefined;
    
    if ( isdefined( indices[ 0 ] ) )
    {
        self.var_caf8874bd35dda24[ indices[ 0 ] ] = undefined;
    }
    
    return indices[ 0 ];
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x14d24acf, Offset: 0xb114
// Size: 0x40
function private closed( index )
{
    if ( isdefined( self.var_caf8874bd35dda24 ) )
    {
        widget_ref = self.var_caf8874bd35dda24[ index ];
        
        if ( isdefined( widget_ref ) )
        {
            thread destroy( widget_ref );
        }
    }
}

// Namespace scripted_widgets
// Params 0, eflags: 0xc
// Checksum 0xea2cea56, Offset: 0xb15c
// Size: 0xa7
function private function_1eb6d41879e5a72e()
{
    self notify( #"hash_27f5119a37b6ca48" );
    self endon( #"hash_27f5119a37b6ca48" );
    self endon( #"death_or_disconnect" );
    waittillframeend();
    
    foreach ( interaction, count in self.scripted_widget_interactions )
    {
        self notify( interaction, count );
    }
    
    self.scripted_widget_interactions = undefined;
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x4bdb7d54, Offset: 0xb20b
// Size: 0xd2
function private interaction( value )
{
    data = level.scripted_widgets;
    widget_index = value >> 6;
    interaction_index = getxhash( "" + ( value & 63 ) );
    widget_type = data.widget_type_indices[ widget_index ];
    interaction = widget_type ? data.widget_types[ widget_type ].interactions[ interaction_index ] : undefined;
    
    if ( interaction )
    {
        if ( !isdefined( self.scripted_widget_interactions ) )
        {
            self.scripted_widget_interactions = [];
            thread function_1eb6d41879e5a72e();
        }
        
        self.scripted_widget_interactions[ interaction ] = ( self.scripted_widget_interactions[ interaction ] ?? 0 ) + 1;
    }
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0xbed5a787, Offset: 0xb2e5
// Size: 0x7f
function private streamed( value )
{
    data = level.scripted_widgets;
    widget = data.widget_type_indices[ value ];
    
    if ( widget )
    {
        guid = utility::callsharedfunc( #"player", #"getPlayerGuid", self );
        data.streamed_widgets[ widget ][ guid ] = 1;
    }
    
    self notify( "scripted_widget_streamed_" + value );
}

// Namespace scripted_widgets
// Params 0, eflags: 0xc
// Checksum 0x1ed6b671, Offset: 0xb36c
// Size: 0x154
function private function_2150cae686222406()
{
    self notify( #"hash_e3ff88c3296af89f" );
    self endon( #"hash_e3ff88c3296af89f" );
    
    if ( !function_1d678e943064d3c5() )
    {
        return;
    }
    
    guid = utility::callsharedfunc( #"player", #"getPlayerGuid", self );
    self waittill( #"disconnect" );
    data = level.scripted_widgets;
    
    foreach ( streamer_hint in data.streamer_hints )
    {
        streamer_hint[ guid ] = undefined;
    }
    
    foreach ( streamed_widget in data.streamed_widgets )
    {
        streamed_widget[ guid ] = undefined;
    }
}

// Namespace scripted_widgets
// Params 0, eflags: 0xc
// Checksum 0x6f02f72e, Offset: 0xb4c8
// Size: 0xa7
function private function_b5649d1020610d2f()
{
    self notify( #"hash_9bc72316672cdacd" );
    self endon( #"hash_9bc72316672cdacd" );
    self endon( #"death_or_disconnect" );
    waittillframeend();
    
    foreach ( message, payload in self.scripted_widget_messages )
    {
        self notify( message, payload );
    }
    
    self.scripted_widget_messages = undefined;
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0xabbe7453, Offset: 0xb577
// Size: 0x13c
function private message( value )
{
    data = level.scripted_widgets;
    widget_index = value & 127;
    message_index = value >> 7 & 31;
    payload = value >> 12;
    widget = data.widget_type_indices[ widget_index ];
    
    if ( !isdefined( widget ) || !isdefined( data.widget_types[ widget ] ) || !isdefined( data.widget_types[ widget ].server_messages ) )
    {
        return;
    }
    
    if ( data.widget_types[ widget ].server_messages[ message_index ] )
    {
        if ( !isdefined( self.scripted_widget_messages ) )
        {
            self.scripted_widget_messages = [];
            thread function_b5649d1020610d2f();
        }
        
        message = data.widget_types[ widget ].server_messages[ message_index ];
        
        if ( !isdefined( self.scripted_widget_messages[ message ] ) )
        {
            self.scripted_widget_messages[ message ] = [];
        }
        
        self.scripted_widget_messages[ message ][ self.scripted_widget_messages[ message ].size ] = payload;
    }
}

// Namespace scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0x6d0391b4, Offset: 0xb6bb
// Size: 0x1ab
function private reset_omnvars( index, var_4cb43a842e3c096f )
{
    data = level.scripted_widgets;
    
    if ( var_4cb43a842e3c096f )
    {
        foreach ( expanded_omnvar in data.var_5efe4ada2f42ba2f )
        {
            self setclientomnvar( data.omnvar_names[ index ][ expanded_omnvar.name ], 0 );
        }
        
        return;
    }
    
    omnvar_names = data.omnvar_names[ index ];
    type_omnvar = omnvar_names[ "type_" ];
    param_omnvar = omnvar_names[ "param_" ];
    data_omnvar = omnvar_names[ "data_" ];
    state_omnvar = omnvar_names[ "state_" ];
    time_omnvar = omnvar_names[ "time_" ];
    position_omnvar = omnvar_names[ "position_" ];
    ent_omnvar = omnvar_names[ "ent_" ];
    hud_omnvar = omnvar_names[ "hud_" ];
    self setclientomnvar( type_omnvar, 0 );
    self setclientomnvar( param_omnvar, 0 );
    self setclientomnvar( data_omnvar, 0 );
    self setclientomnvar( state_omnvar, 0 );
    self setclientomnvar( time_omnvar, 0 );
    self setclientomnvar( position_omnvar, 0 );
    self setclientomnvar( ent_omnvar, undefined );
    self setclientomnvar( hud_omnvar, 0 );
}

// Namespace scripted_widgets
// Params 3, eflags: 0x4
// Checksum 0x8e55409f, Offset: 0xb86e
// Size: 0x258
function private function_a458685a0fe51f5b( list_ref, item_ref, widget_type )
{
    data = level.scripted_widgets.list_widget_data;
    omnvar_index = undefined;
    
    if ( !isdefined( self.var_6346b0c87b140939 ) )
    {
        self.var_6346b0c87b140939 = [];
        var_9bbaa5db8eb4e926 = 8;
        
        if ( data.num_groups > 1 )
        {
            var_9bbaa5db8eb4e926 -= 1;
        }
        
        for ( i = 0; i < data.max_items ; i++ )
        {
            group = int( floor( i / var_9bbaa5db8eb4e926 ) );
            index = i % var_9bbaa5db8eb4e926;
            
            if ( !isdefined( self.var_6346b0c87b140939[ group ] ) )
            {
                self.var_6346b0c87b140939[ group ] = [];
            }
            
            self.var_6346b0c87b140939[ group ][ index ] = index + 1;
        }
    }
    
    if ( !isdefined( self.var_719fa429bc4b04c9 ) )
    {
        self.var_719fa429bc4b04c9 = [];
    }
    
    if ( !isdefined( self.active_scripted_widgets[ list_ref ].group ) )
    {
        best_group = undefined;
        best_group_size = 0;
        
        for ( i = 0; i < data.num_groups ; i++ )
        {
            group_size = self.var_6346b0c87b140939[ i ].size;
            
            if ( group_size > best_group_size )
            {
                best_group = i;
                best_group_size = group_size;
            }
        }
        
        if ( !isdefined( best_group ) )
        {
            return;
        }
        
        function_1d476225d6bf06ad( list_ref, best_group );
    }
    
    group = self.active_scripted_widgets[ list_ref ].group;
    array_index = self.var_6346b0c87b140939[ group ].size - 1;
    
    if ( array_index >= 0 )
    {
        omnvar_index = self.var_6346b0c87b140939[ group ][ array_index ];
        self.var_6346b0c87b140939[ group ][ array_index ] = undefined;
        
        if ( !isdefined( self.var_719fa429bc4b04c9[ list_ref ] ) )
        {
            self.var_719fa429bc4b04c9[ list_ref ] = [];
        }
        
        self.var_719fa429bc4b04c9[ list_ref ][ item_ref ] = {};
        self.var_719fa429bc4b04c9[ list_ref ][ item_ref ].omnvar_index = omnvar_index;
        self.var_719fa429bc4b04c9[ list_ref ][ item_ref ].widget_type = widget_type;
        function_9e1b0866ab895c8f( group, omnvar_index );
    }
    
    return omnvar_index;
}

// Namespace scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0x787e34d6, Offset: 0xbacf
// Size: 0xd1
function private function_1d476225d6bf06ad( list_ref, group_index )
{
    group_mask = level.scripted_widgets.list_widget_data.group_mask;
    group_shift = level.scripted_widgets.list_widget_data.group_shift;
    
    if ( isdefined( group_mask ) && isdefined( group_shift ) )
    {
        omnvar = level.scripted_widgets.omnvar_names[ self.active_scripted_widgets[ list_ref ].index ][ "data_" ];
        function_bfa6932336246cd5( group_index, omnvar, undefined, group_mask, group_shift );
    }
    
    self.active_scripted_widgets[ list_ref ].group = group_index;
}

// Namespace scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0xd99a0d72, Offset: 0xbba8
// Size: 0xbe
function private function_88d3c9d93e19c10e( list_ref, item_ref )
{
    omnvar_index = undefined;
    
    if ( isdefined( self.var_719fa429bc4b04c9[ list_ref ][ item_ref ] ) )
    {
        omnvar_index = self.var_719fa429bc4b04c9[ list_ref ][ item_ref ].omnvar_index;
        
        if ( isdefined( omnvar_index ) )
        {
            group = self.active_scripted_widgets[ list_ref ].group;
            self.var_6346b0c87b140939[ group ][ self.var_6346b0c87b140939[ group ].size ] = omnvar_index;
            self.var_719fa429bc4b04c9[ list_ref ][ item_ref ] = undefined;
            
            if ( self.var_719fa429bc4b04c9[ list_ref ].size == 0 )
            {
                self.var_719fa429bc4b04c9[ list_ref ] = undefined;
            }
        }
    }
    
    return omnvar_index;
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0x1198338, Offset: 0xbc6f
// Size: 0xf3
function private function_4fee8f875eb183d6( list_ref )
{
    if ( isdefined( self.var_719fa429bc4b04c9[ list_ref ] ) )
    {
        if ( self.var_719fa429bc4b04c9[ list_ref ].size > 0 )
        {
            group = self.active_scripted_widgets[ list_ref ].group;
            
            foreach ( item_data in self.var_719fa429bc4b04c9[ list_ref ] )
            {
                self.var_6346b0c87b140939[ group ][ self.var_6346b0c87b140939[ group ].size ] = item_data.omnvar_index;
            }
        }
        
        self.var_719fa429bc4b04c9[ list_ref ] = undefined;
    }
}

// Namespace scripted_widgets
// Params 4, eflags: 0x4
// Checksum 0x5a1d3b64, Offset: 0xbd6a
// Size: 0x168
function private function_d317df8268207da7( list_ref, items, omnvars, add_to_front )
{
    if ( add_to_front )
    {
        self.active_scripted_widgets[ list_ref ].list = arraycombine( omnvars, self.active_scripted_widgets[ list_ref ].list );
    }
    else
    {
        self.active_scripted_widgets[ list_ref ].list = arraycombine( self.active_scripted_widgets[ list_ref ].list, omnvars );
    }
    
    data = level.scripted_widgets;
    
    foreach ( index, item in items )
    {
        type_omnvar = function_7366ccbab2fde2f1( self.active_scripted_widgets[ list_ref ].group, omnvars[ index ], "type_" );
        self setclientomnvar( type_omnvar, data.widget_types[ item ].index );
    }
    
    list_update( list_ref );
}

// Namespace scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0x745754, Offset: 0xbeda
// Size: 0x50
function private function_f3a75089f979a140( list_ref, items )
{
    self.active_scripted_widgets[ list_ref ].list = arrayremove( self.active_scripted_widgets[ list_ref ].list, items );
    list_update( list_ref );
}

// Namespace scripted_widgets
// Params 1, eflags: 0x4
// Checksum 0xa6768823, Offset: 0xbf32
// Size: 0xe0
function private list_update( list_ref )
{
    max_items = 8;
    value = 0;
    
    if ( level.scripted_widgets.list_widget_data.num_groups > 1 )
    {
        max_items -= 1;
        value = self.active_scripted_widgets[ list_ref ].group << level.scripted_widgets.list_widget_data.group_shift;
    }
    
    list = self.active_scripted_widgets[ list_ref ].list;
    
    for ( i = 0; i < max_items ; i++ )
    {
        if ( isdefined( list[ i ] ) )
        {
            value |= list[ i ] << 4 * i;
        }
    }
    
    set_data( list_ref, value );
}

// Namespace scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0x6f54d68a, Offset: 0xc01a
// Size: 0xc7
function private function_9e1b0866ab895c8f( group, omnvar_index )
{
    omnvar_index = function_c6644d96d2e4a47e( group, omnvar_index );
    type_omnvar = "ui_scripted_list_item_" + "type_" + omnvar_index;
    param_omnvar = "ui_scripted_list_item_" + "param_" + omnvar_index;
    data_omnvar = "ui_scripted_list_item_" + "data_" + omnvar_index;
    state_omnvar = "ui_scripted_list_item_" + "state_" + omnvar_index;
    time_omnvar = "ui_scripted_list_item_" + "time_" + omnvar_index;
    self setclientomnvar( type_omnvar, 0 );
    self setclientomnvar( param_omnvar, 0 );
    self setclientomnvar( data_omnvar, 0 );
    self setclientomnvar( state_omnvar, 0 );
    self setclientomnvar( time_omnvar, 0 );
}

// Namespace scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0x28adb673, Offset: 0xc0e9
// Size: 0x1c
function private function_c6644d96d2e4a47e( group, index )
{
    return index + group * 8;
}

// Namespace scripted_widgets
// Params 3, eflags: 0x4
// Checksum 0x601f4fa7, Offset: 0xc10e
// Size: 0x34
function private function_7366ccbab2fde2f1( group, omnvar_index, omnvar_suffix )
{
    omnvar_index = function_c6644d96d2e4a47e( group, omnvar_index );
    return "ui_scripted_list_item_" + omnvar_suffix + omnvar_index;
}

// Namespace scripted_widgets
// Params 2, eflags: 0x4
// Checksum 0x734a0879, Offset: 0xc14b
// Size: 0x36
function private function_2f27a9ff0f33aec2( list_ref, item_ref )
{
    if ( isdefined( self.var_719fa429bc4b04c9[ list_ref ][ item_ref ] ) )
    {
        return self.var_719fa429bc4b04c9[ list_ref ][ item_ref ];
    }
}

/#

    // Namespace scripted_widgets
    // Params 0, eflags: 0x4
    // Checksum 0xe2bd8b, Offset: 0xc18a
    // Size: 0xf1, Type: dev
    function private devgui_setup()
    {
        if ( isdefined( level.player ) )
        {
            level.player thread devgui_setup_on_player();
            return;
        }
        
        player_limit = 32;
        
        if ( isdefined( level.players ) )
        {
            foreach ( index, player in level.players )
            {
                if ( index > player_limit )
                {
                    break;
                }
                
                player thread devgui_setup_on_player();
            }
        }
        
        while ( true )
        {
            level waittill( #"connected", player );
            
            if ( level.players.size <= player_limit )
            {
                player thread devgui_setup_on_player();
            }
        }
    }

    // Namespace scripted_widgets
    // Params 0, eflags: 0x4
    // Checksum 0xb643e5ef, Offset: 0xc283
    // Size: 0x32f, Type: dev
    function private devgui_setup_on_player()
    {
        if ( isbot( self ) )
        {
            return;
        }
        
        player_name = self.name ?? "<dev string:xe18>";
        cleanup_all_path = "<dev string:xe19>" + ( player_name == "<dev string:xe18>" ? "<dev string:xe18>" : player_name + "<dev string:xe2e>" );
        devgui::function_9082edeb5db93280( cleanup_all_path );
        devgui::function_cd4e263c1f3018ae( "<dev string:xe30>", "<dev string:xe48>" + player_name, &function_bdaf95f84e4e966f, 0 );
        devgui::function_77df7fe7dd273e10();
        
        foreach ( widget_asset, widget_data in level.scripted_widgets.widget_types )
        {
            widget_name = strtok( getxhashsourcename( widget_asset ), "<dev string:xe55>" )[ 1 ];
            
            if ( isdefined( widget_name ) )
            {
                devgui::function_9082edeb5db93280( "<dev string:xe19>" + ( player_name == "<dev string:xe18>" ? player_name : player_name + "<dev string:xe2e>" ) + widget_name + "<dev string:xe2e>" );
                devgui::function_cd4e263c1f3018ae( "<dev string:xe57>", "<dev string:xe63>" + widget_name + "<dev string:xe70>" + player_name, &devgui_setup_debug, 0 );
                devgui::function_cd4e263c1f3018ae( "<dev string:xe72>", "<dev string:xe80>" + widget_name + "<dev string:xe70>" + player_name, &function_99c5ca7f698db79b, 0 );
                devgui::function_cd4e263c1f3018ae( "<dev string:xe8f>", "<dev string:xe96>" + widget_name + "<dev string:xe70>" + player_name, &devgui_create, 0 );
                
                foreach ( param_name, param_index in widget_data.parameters )
                {
                    param_name = getxhashsourcename( param_name );
                    devgui::function_cd4e263c1f3018ae( "<dev string:xe9e>" + param_name, param_name + "<dev string:xe70>" + widget_name + "<dev string:xe70>" + param_name + "<dev string:xe70>" + player_name, &devgui_set_param, 0 );
                }
                
                foreach ( state_name, state_index in widget_data.states )
                {
                    state_name = getxhashsourcename( state_name );
                    devgui::function_cd4e263c1f3018ae( "<dev string:xeaa>" + state_name, state_name + "<dev string:xe70>" + widget_name + "<dev string:xe70>" + state_name + "<dev string:xe70>" + player_name, &devgui_set_state, 0 );
                }
                
                devgui::function_cd4e263c1f3018ae( "<dev string:xeb2>", "<dev string:xeba>" + widget_name + "<dev string:xe70>" + player_name, &devgui_destroy, 0 );
                devgui::function_77df7fe7dd273e10();
            }
        }
    }

    // Namespace scripted_widgets
    // Params 1, eflags: 0x4
    // Checksum 0x3bb7e868, Offset: 0xc5ba
    // Size: 0x459, Type: dev
    function private devgui_setup_debug( params )
    {
        widget_name = params[ 0 ];
        player_name = params[ 1 ] ?? "<dev string:xe18>";
        
        if ( !isdefined( level.scripted_widgets.devgui_initialized ) )
        {
            level.scripted_widgets.devgui_initialized = [];
        }
        
        setup_key = widget_name + ( player_name == "<dev string:xe18>" ? "<dev string:xe18>" : "<dev string:xec3>" + player_name );
        
        if ( isdefined( level.scripted_widgets.devgui_initialized[ setup_key ] ) )
        {
            return;
        }
        
        level.scripted_widgets.devgui_initialized[ setup_key ] = 1;
        widget_data = level.scripted_widgets.widget_types[ hashcat( %"scriptedwidget:", widget_name ) ];
        suffix = player_name == "<dev string:xe18>" ? "<dev string:xe18>" : "<dev string:xec3>" + player_name;
        devgui::function_9082edeb5db93280( "<dev string:xe19>" + ( player_name == "<dev string:xe18>" ? player_name : player_name + "<dev string:xe2e>" ) + widget_name + "<dev string:xe2e>" );
        
        if ( isdefined( widget_data.archetype ) && isdefined( level.scripted_widgets.archetypes[ widget_data.archetype ] ) )
        {
            foreach ( field, field_data in level.scripted_widgets.archetypes[ widget_data.archetype ].fields )
            {
                dvar_name = widget_name + "<dev string:xec3>" + field + suffix;
                
                if ( field_data.step_increment < 1 )
                {
                    setdevdvarifuninitialized( hashcat( @"debug_", dvar_name ), 0, 0, field_data.max_value );
                }
                else
                {
                    setdevdvarifuninitialized( hashcat( @"debug_", dvar_name ), 0, 0, int( field_data.max_value ) );
                }
                
                devgui::add_devgui_dvar( "<dev string:xec5>" + field, "<dev string:xed0>" + dvar_name );
            }
        }
        
        dvar_name = widget_name + "<dev string:xed7>" + suffix;
        setdevdvarifuninitialized( hashcat( @"debug_", dvar_name ), 0, -63, 1984 );
        devgui::add_devgui_dvar( "<dev string:xee3>", "<dev string:xed0>" + dvar_name );
        dvar_name = widget_name + "<dev string:xeee>" + suffix;
        setdevdvarifuninitialized( hashcat( @"debug_", dvar_name ), 0, -483, 1564 );
        devgui::add_devgui_dvar( "<dev string:xefa>", "<dev string:xed0>" + dvar_name );
        dvar_name = widget_name + "<dev string:xf05>" + suffix;
        setdevdvarifuninitialized( hashcat( @"debug_", dvar_name ), 1, 0, 3 );
        devgui::add_devgui_dvar( "<dev string:xf18>", "<dev string:xed0>" + dvar_name );
        dvar_name = widget_name + "<dev string:xf33>" + suffix;
        setdevdvarifuninitialized( hashcat( @"debug_", dvar_name ), 1, 0, 3 );
        devgui::add_devgui_dvar( "<dev string:xf46>", "<dev string:xed0>" + dvar_name );
        dvar_name = widget_name + "<dev string:xf5f>" + suffix;
        setdevdvarifuninitialized( hashcat( @"debug_", dvar_name ), 1 );
        devgui::add_devgui_dvar( "<dev string:xf72>", "<dev string:xed0>" + dvar_name );
        dvar_name = widget_name + "<dev string:xf89>" + suffix;
        setdevdvarifuninitialized( hashcat( @"debug_", dvar_name ), 0 );
        devgui::add_devgui_dvar( "<dev string:xf94>", "<dev string:xed0>" + dvar_name );
        dvar_name = widget_name + "<dev string:xfa4>" + suffix;
        setdevdvarifuninitialized( hashcat( @"debug_", dvar_name ), 0 );
        devgui::add_devgui_dvar( "<dev string:xfb5>", "<dev string:xed0>" + dvar_name );
        dvar_name = widget_name + "<dev string:xfcb>" + suffix;
        setdevdvarifuninitialized( hashcat( @"debug_", dvar_name ), 0 );
        devgui::add_devgui_dvar( "<dev string:xfe6>", "<dev string:xed0>" + dvar_name );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace scripted_widgets
    // Params 1, eflags: 0x4
    // Checksum 0x4481399d, Offset: 0xca1b
    // Size: 0x327, Type: dev
    function private function_99c5ca7f698db79b( params )
    {
        widget_name = params[ 0 ];
        player_name = params[ 1 ] ?? "<dev string:xe18>";
        suffix = player_name == "<dev string:xe18>" ? "<dev string:xe18>" : "<dev string:xec3>" + player_name;
        devgui::function_9082edeb5db93280( "<dev string:xe19>" + ( player_name == "<dev string:xe18>" ? player_name : player_name + "<dev string:xe2e>" ) + widget_name + "<dev string:xe2e>" );
        widget_data = level.scripted_widgets.widget_types[ hashcat( %"scriptedwidget:", widget_name ) ];
        
        if ( isdefined( widget_data.archetype ) && isdefined( level.scripted_widgets.archetypes[ widget_data.archetype ] ) )
        {
            foreach ( field, field_data in level.scripted_widgets.archetypes[ widget_data.archetype ].fields )
            {
                dvar_name = widget_name + "<dev string:xec3>" + field + suffix;
                deregisterdvar( hashcat( @"debug_", dvar_name ) );
            }
        }
        
        dvar_name = widget_name + "<dev string:xed7>" + suffix;
        deregisterdvar( hashcat( @"debug_", dvar_name ) );
        dvar_name = widget_name + "<dev string:xeee>" + suffix;
        deregisterdvar( hashcat( @"debug_", dvar_name ) );
        dvar_name = widget_name + "<dev string:xf05>" + suffix;
        deregisterdvar( hashcat( @"debug_", dvar_name ) );
        dvar_name = widget_name + "<dev string:xf33>" + suffix;
        deregisterdvar( hashcat( @"debug_", dvar_name ) );
        dvar_name = widget_name + "<dev string:xf5f>" + suffix;
        deregisterdvar( hashcat( @"debug_", dvar_name ) );
        dvar_name = widget_name + "<dev string:xf89>" + suffix;
        deregisterdvar( hashcat( @"debug_", dvar_name ) );
        dvar_name = widget_name + "<dev string:xfa4>" + suffix;
        deregisterdvar( hashcat( @"debug_", dvar_name ) );
        dvar_name = widget_name + "<dev string:xfcb>" + suffix;
        deregisterdvar( hashcat( @"debug_", dvar_name ) );
        devgui::remove_devgui_menu( "<dev string:x1006>" );
        devgui::remove_devgui_menu( "<dev string:x1010>" );
        devgui::remove_devgui_menu( "<dev string:x1019>" );
        
        if ( isdefined( level.scripted_widgets.devgui_initialized ) )
        {
            setup_key = widget_name + ( player_name == "<dev string:xe18>" ? "<dev string:xe18>" : "<dev string:xec3>" + player_name );
            level.scripted_widgets.devgui_initialized[ setup_key ] = undefined;
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace scripted_widgets
    // Params 1, eflags: 0x4
    // Checksum 0xd2c2c612, Offset: 0xcd4a
    // Size: 0xd4, Type: dev
    function private function_bdaf95f84e4e966f( params )
    {
        player_name = params[ 0 ] ?? "<dev string:xe18>";
        
        foreach ( widget_asset, widget_data in level.scripted_widgets.widget_types )
        {
            widget_name = strtok( getxhashsourcename( widget_asset ), "<dev string:xe55>" )[ 1 ];
            
            if ( isdefined( widget_name ) )
            {
                function_99c5ca7f698db79b( [ widget_name, player_name ] );
            }
        }
    }

    // Namespace scripted_widgets
    // Params 1, eflags: 0x4
    // Checksum 0xde2252a3, Offset: 0xce26
    // Size: 0xa5, Type: dev
    function private devgui_get_player( player_name )
    {
        if ( player_name )
        {
            foreach ( player in level.players )
            {
                if ( player.name == player_name )
                {
                    return player;
                }
            }
            
            return;
        }
        
        return level.player;
    }

    // Namespace scripted_widgets
    // Params 2, eflags: 0x4
    // Checksum 0x5d0b2a07, Offset: 0xced3
    // Size: 0x3f2, Type: dev
    function private devgui_update( widget_ref, widget_type )
    {
        self endon( #"death_or_disconnect" );
        self endon( "<dev string:x101f>" + widget_ref );
        player = self;
        widget_data = level.scripted_widgets.widget_types[ hashcat( %"scriptedwidget:", widget_type ) ];
        dvar_x = widget_type + "<dev string:xed7>";
        dvar_y = widget_type + "<dev string:xeee>";
        dvar_h_anchor = widget_type + "<dev string:xf05>";
        dvar_v_anchor = widget_type + "<dev string:xf33>";
        dvar_safearea = widget_type + "<dev string:xf5f>";
        
        if ( isdefined( player.name ) )
        {
            dvar_x = dvar_x + "<dev string:xec3>" + player.name;
            dvar_y = dvar_y + "<dev string:xec3>" + player.name;
            dvar_h_anchor = dvar_h_anchor + "<dev string:xec3>" + player.name;
            dvar_v_anchor = dvar_v_anchor + "<dev string:xec3>" + player.name;
            dvar_safearea = dvar_safearea + "<dev string:xec3>" + player.name;
        }
        
        dvar_x = hashcat( @"debug_", dvar_x );
        dvar_y = hashcat( @"debug_", dvar_y );
        dvar_h_anchor = hashcat( @"debug_", dvar_h_anchor );
        dvar_v_anchor = hashcat( @"debug_", dvar_v_anchor );
        dvar_safearea = hashcat( @"debug_", dvar_safearea );
        field_dvars = [];
        
        if ( isdefined( widget_data.archetype ) && isdefined( level.scripted_widgets.archetypes[ widget_data.archetype ] ) )
        {
            foreach ( field, field_data in level.scripted_widgets.archetypes[ widget_data.archetype ].fields )
            {
                dvar_name = widget_type + "<dev string:xec3>" + field;
                
                if ( isdefined( player.name ) )
                {
                    dvar_name = dvar_name + "<dev string:xec3>" + player.name;
                }
                
                field_dvars[ field ] = hashcat( @"debug_", dvar_name );
            }
        }
        
        while ( true )
        {
            x_pos = getdvarint( dvar_x, 0 );
            y_pos = getdvarint( dvar_y, 0 );
            h_anchor = getdvarint( dvar_h_anchor, 1 );
            v_anchor = getdvarint( dvar_v_anchor, 1 );
            safe_area = getdvarint( dvar_safearea, 1 );
            player set_position( widget_ref, x_pos, y_pos, h_anchor, v_anchor, safe_area != 0 );
            
            if ( isdefined( widget_data.archetype ) && isdefined( level.scripted_widgets.archetypes[ widget_data.archetype ] ) )
            {
                foreach ( field, field_data in level.scripted_widgets.archetypes[ widget_data.archetype ].fields )
                {
                    field_value = getdvarfloat( field_dvars[ field ], 0 );
                    player function_f15c5dfb6c0f57c7( widget_ref, field, field_value );
                }
            }
            
            waitframe();
        }
    }

    // Namespace scripted_widgets
    // Params 1, eflags: 0x4
    // Checksum 0x5f263d73, Offset: 0xd2cd
    // Size: 0x4f7, Type: dev
    function private devgui_create( params )
    {
        player = devgui_get_player( params[ 1 ] );
        
        if ( isdefined( player ) )
        {
            widget_type = params[ 0 ];
            widget_ref = "<dev string:x103a>" + widget_type;
            dvar_under_hud = widget_type + "<dev string:xf89>";
            var_a9a6ff07743ec116 = widget_type + "<dev string:xfa4>";
            var_c45ca422c7d3afe3 = widget_type + "<dev string:xfcb>";
            dvar_x = widget_type + "<dev string:xed7>";
            dvar_y = widget_type + "<dev string:xeee>";
            dvar_h_anchor = widget_type + "<dev string:xf05>";
            dvar_v_anchor = widget_type + "<dev string:xf33>";
            dvar_safearea = widget_type + "<dev string:xf5f>";
            dvar_param = widget_type + "<dev string:x1042>";
            dvar_state = widget_type + "<dev string:x1049>";
            
            if ( isdefined( player.name ) )
            {
                dvar_under_hud = dvar_under_hud + "<dev string:xec3>" + player.name;
                var_a9a6ff07743ec116 = var_a9a6ff07743ec116 + "<dev string:xec3>" + player.name;
                var_c45ca422c7d3afe3 = var_c45ca422c7d3afe3 + "<dev string:xec3>" + player.name;
                dvar_x = dvar_x + "<dev string:xec3>" + player.name;
                dvar_y = dvar_y + "<dev string:xec3>" + player.name;
                dvar_h_anchor = dvar_h_anchor + "<dev string:xec3>" + player.name;
                dvar_v_anchor = dvar_v_anchor + "<dev string:xec3>" + player.name;
                dvar_safearea = dvar_safearea + "<dev string:xec3>" + player.name;
                dvar_param = dvar_param + "<dev string:xec3>" + player.name;
                dvar_state = dvar_state + "<dev string:xec3>" + player.name;
            }
            
            under_hud = getdvarint( hashcat( @"debug_", dvar_under_hud ), 0 );
            over_everything = getdvarint( hashcat( @"debug_", var_a9a6ff07743ec116 ), 0 );
            var_59e2ff60bf69c885 = getdvarint( hashcat( @"debug_", var_c45ca422c7d3afe3 ), 0 );
            player create( widget_ref, widget_type, { #var_59e2ff60bf69c885:var_59e2ff60bf69c885, #over_everything:over_everything, #under_hud:under_hud } );
            x_pos = getdvarint( hashcat( @"debug_", dvar_x ), 0 );
            y_pos = getdvarint( hashcat( @"debug_", dvar_y ), 0 );
            h_anchor = getdvarint( hashcat( @"debug_", dvar_h_anchor ), 1 );
            v_anchor = getdvarint( hashcat( @"debug_", dvar_v_anchor ), 1 );
            safe_area = getdvarint( hashcat( @"debug_", dvar_safearea ), 1 );
            player set_position( widget_ref, x_pos, y_pos, h_anchor, v_anchor, safe_area != 0 );
            parameter = getdvar( hashcat( @"debug_", dvar_param ), "<dev string:xe18>" );
            
            if ( parameter != "<dev string:xe18>" )
            {
                player set_param( widget_ref, parameter );
            }
            
            state = getdvar( hashcat( @"debug_", dvar_state ), "<dev string:xe18>" );
            
            if ( state != "<dev string:xe18>" )
            {
                player set_state( widget_ref, state );
            }
            
            widget_data = level.scripted_widgets.widget_types[ hashcat( %"scriptedwidget:", widget_type ) ];
            
            if ( isdefined( widget_data.archetype ) && isdefined( level.scripted_widgets.archetypes[ widget_data.archetype ] ) )
            {
                foreach ( field, field_data in level.scripted_widgets.archetypes[ widget_data.archetype ].fields )
                {
                    dvar_name = widget_type + "<dev string:xec3>" + field;
                    
                    if ( isdefined( player.name ) )
                    {
                        dvar_name = dvar_name + "<dev string:xec3>" + player.name;
                    }
                    
                    field_value = getdvarfloat( hashcat( @"debug_", dvar_name ), 0 );
                    player function_f15c5dfb6c0f57c7( widget_ref, field, field_value );
                }
            }
            
            player set_timestamp( widget_ref, gettime() );
            player thread devgui_update( widget_ref, widget_type );
        }
    }

    // Namespace scripted_widgets
    // Params 1, eflags: 0x4
    // Checksum 0xe9c52e9a, Offset: 0xd7cc
    // Size: 0xa8, Type: dev
    function private devgui_set_param( params )
    {
        player = devgui_get_player( params[ 2 ] );
        
        if ( isdefined( player ) )
        {
            widget_ref = "<dev string:x103a>" + params[ 0 ];
            
            if ( player is_active( widget_ref ) )
            {
                player set_param( widget_ref, params[ 1 ] );
            }
            
            dvar_name = params[ 0 ] + "<dev string:x1042>";
            
            if ( isdefined( player.name ) )
            {
                dvar_name = dvar_name + "<dev string:xec3>" + player.name;
            }
            
            setdevdvar( hashcat( @"debug_", dvar_name ), params[ 1 ] );
        }
    }

    // Namespace scripted_widgets
    // Params 1, eflags: 0x4
    // Checksum 0xe9c52e9a, Offset: 0xd87c
    // Size: 0xa8, Type: dev
    function private devgui_set_state( params )
    {
        player = devgui_get_player( params[ 2 ] );
        
        if ( isdefined( player ) )
        {
            widget_ref = "<dev string:x103a>" + params[ 0 ];
            
            if ( player is_active( widget_ref ) )
            {
                player set_state( widget_ref, params[ 1 ] );
            }
            
            dvar_name = params[ 0 ] + "<dev string:x1049>";
            
            if ( isdefined( player.name ) )
            {
                dvar_name = dvar_name + "<dev string:xec3>" + player.name;
            }
            
            setdevdvar( hashcat( @"debug_", dvar_name ), params[ 1 ] );
        }
    }

    // Namespace scripted_widgets
    // Params 1, eflags: 0x4
    // Checksum 0xa22d506, Offset: 0xd92c
    // Size: 0x48, Type: dev
    function private devgui_destroy( params )
    {
        player = devgui_get_player( params[ 1 ] );
        
        if ( isdefined( player ) )
        {
            widget_ref = "<dev string:x103a>" + params[ 0 ];
            player destroy( widget_ref );
        }
    }

#/
