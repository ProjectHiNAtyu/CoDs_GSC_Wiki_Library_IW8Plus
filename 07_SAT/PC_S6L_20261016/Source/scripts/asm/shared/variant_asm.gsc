// scripts\asm\shared\variant_asm.gsc  (hash_7ff3a914e6c698c5.gscc) (size: 2483 Bytes / 0x9b3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc0cf4160 (3234808160)
// size ...... 2483 (0x9b3)
// includes .. 1   (offset: 0x8ef)
// strings ... 7   (offset: 0x8f7)
// dev strs .. 5   (offset: 0x977)
// exports ... 8   (offset: 0x667)
// cseg ...... 0xa3 + 0x5c4 (0x667)
// imports ... 11  (offset: 0x7a7)
// animtree1 . 0   (offset: 0x9b3)
// animtree2 . 0   (offset: 0x9b3)
#using scripts\asm\asm;

#namespace variant_asm;

// Namespace variant_asm
// Params 3
// Checksum 0xb13e02bc, Offset: 0xc1
// Size: 0x13c
function register_anim_variant( var_6acc7b81b5df3dd9, var_1616407d0365b9a0, on_complete_fn )
{
    if ( !isdefined( level.variant_type_max ) )
    {
        level.variant_type_max = [];
    }
    
    if ( !isdefined( level.variant_type_selector ) )
    {
        level.variant_type_selector = [];
    }
    
    if ( !isdefined( level.variant_type_on_complete ) )
    {
        level.variant_type_on_complete = [];
    }
    
    if ( !isdefined( level.variant_type_max[ self.animsetname ] ) )
    {
        level.variant_type_max[ self.animsetname ] = [];
    }
    
    if ( !isdefined( level.variant_type_selector[ self.animsetname ] ) )
    {
        level.variant_type_selector[ self.animsetname ] = [];
    }
    
    assert( !isdefined( level.variant_type_max[ self.animsetname ][ var_6acc7b81b5df3dd9 ] ), "<dev string:x24>" + self.animsetname + "<dev string:x36>" + var_6acc7b81b5df3dd9 + "<dev string:x44>" );
    level.variant_type_max[ self.animsetname ][ var_6acc7b81b5df3dd9 ] = [];
    level.variant_type_selector[ self.animsetname ][ var_6acc7b81b5df3dd9 ] = var_1616407d0365b9a0;
    level.variant_type_on_complete[ self.animsetname ][ var_6acc7b81b5df3dd9 ] = on_complete_fn;
}

// Namespace variant_asm
// Params 3
// Checksum 0xaef6384e, Offset: 0x205
// Size: 0xb6
function function_6ffb0fbe59bdcb82( var_6acc7b81b5df3dd9, var_b3cd70a4a22de3b1, var_4c8642135a7c6289 )
{
    assert( isdefined( level.variant_type_max[ self.animsetname ] ) );
    
    if ( !isdefined( level.variant_type_max[ self.animsetname ][ var_6acc7b81b5df3dd9 ] ) )
    {
        level.variant_type_max[ self.animsetname ][ var_6acc7b81b5df3dd9 ] = [];
    }
    
    index = level.variant_type_max[ self.animsetname ][ var_6acc7b81b5df3dd9 ].size;
    var_b3cd70a4a22de3b1.var_4c8642135a7c6289 = var_4c8642135a7c6289;
    level.variant_type_max[ self.animsetname ][ var_6acc7b81b5df3dd9 ][ index ] = var_b3cd70a4a22de3b1;
}

// Namespace variant_asm
// Params 1
// Checksum 0xa7acdbc9, Offset: 0x2c3
// Size: 0x1a
function function_1f4998dd94d74b28( var_6acc7b81b5df3dd9 )
{
    self.var_220d1e77e1ea21ee[ var_6acc7b81b5df3dd9 ] = [];
}

// Namespace variant_asm
// Params 1
// Checksum 0x467e6ca1, Offset: 0x2e5
// Size: 0x237
function function_1e9b4a2fe400d128( var_6acc7b81b5df3dd9 )
{
    function_1f4998dd94d74b28( var_6acc7b81b5df3dd9 );
    self.var_220d1e77e1ea21ee[ var_6acc7b81b5df3dd9 ][ "alias" ] = "";
    animset = self.animsetname;
    
    if ( !( isdefined( level.variant_type_max[ self.animsetname ] ) && isdefined( level.variant_type_max[ self.animsetname ] ) ) )
    {
        animset = self findoverridearchetype( "default" );
    }
    
    assert( isdefined( level.variant_type_max[ animset ][ var_6acc7b81b5df3dd9 ] ) );
    assert( isdefined( level.variant_type_selector[ animset ][ var_6acc7b81b5df3dd9 ] ) );
    
    foreach ( variant_type in level.variant_type_max[ animset ][ var_6acc7b81b5df3dd9 ] )
    {
        alias = [[ level.variant_type_selector[ animset ][ var_6acc7b81b5df3dd9 ] ]]( variant_type );
        
        if ( isdefined( alias ) )
        {
            self.var_220d1e77e1ea21ee[ var_6acc7b81b5df3dd9 ][ "alias" ] = alias;
            
            if ( isdefined( variant_type.var_4c8642135a7c6289 ) )
            {
                variant_index = randomint( variant_type.var_4c8642135a7c6289 );
                self.var_220d1e77e1ea21ee[ var_6acc7b81b5df3dd9 ][ "variant_index" ] = variant_index;
                self.var_220d1e77e1ea21ee[ var_6acc7b81b5df3dd9 ][ "alias" ] = self.var_220d1e77e1ea21ee[ var_6acc7b81b5df3dd9 ][ "alias" ] + "_v" + ( variant_index < 10 ? "0" : "" ) + string( variant_index );
            }
            
            if ( isdefined( level.variant_type_on_complete[ animset ][ var_6acc7b81b5df3dd9 ] ) )
            {
                self [[ level.variant_type_on_complete[ animset ][ var_6acc7b81b5df3dd9 ] ]]( self.var_220d1e77e1ea21ee[ var_6acc7b81b5df3dd9 ][ "alias" ] );
            }
            
            return self.var_220d1e77e1ea21ee[ var_6acc7b81b5df3dd9 ][ "alias" ];
        }
    }
    
    assertmsg( "<dev string:x58>" + var_6acc7b81b5df3dd9 );
    return "failed_anim_variant";
}

// Namespace variant_asm
// Params 3
// Checksum 0xa2cc39e2, Offset: 0x525
// Size: 0x66
function function_e1be2607c10431a8( asmname, statename, params )
{
    var_6acc7b81b5df3dd9 = params;
    
    if ( !isdefined( self.var_220d1e77e1ea21ee[ var_6acc7b81b5df3dd9 ][ "alias" ] ) )
    {
        function_1e9b4a2fe400d128( var_6acc7b81b5df3dd9 );
    }
    
    return asm::asm_lookupanimfromalias( statename, self.var_220d1e77e1ea21ee[ var_6acc7b81b5df3dd9 ][ "alias" ] );
}

// Namespace variant_asm
// Params 3
// Checksum 0x5bf46b4, Offset: 0x594
// Size: 0x61
function function_fc41ef48ceb7504( asmname, statename, params )
{
    var_6acc7b81b5df3dd9 = params;
    assert( isdefined( self.var_220d1e77e1ea21ee[ var_6acc7b81b5df3dd9 ][ "<dev string:x9f>" ] ) );
    return asm::asm_lookupanimfromalias( statename, self.var_220d1e77e1ea21ee[ var_6acc7b81b5df3dd9 ][ "alias" ] );
}

// Namespace variant_asm
// Params 3
// Checksum 0x368dcfae, Offset: 0x5fe
// Size: 0x68
function function_17a1e2617269a304( asmname, statename, params )
{
    var_6acc7b81b5df3dd9 = params;
    
    if ( !isdefined( self.var_220d1e77e1ea21ee[ var_6acc7b81b5df3dd9 ][ "alias" ] ) )
    {
        return asm::asm_chooseanim( asmname, statename, undefined );
    }
    
    return asm::asm_lookupanimfromalias( statename, self.var_220d1e77e1ea21ee[ var_6acc7b81b5df3dd9 ][ "alias" ] );
}

