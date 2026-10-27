// scripts\common\ai\aitypes\zombie_deathworm\zombie_deathworm_metabones.gsc  (hash_60caa4e06d6c0591.gscc) (size: 6302 Bytes / 0x189e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4396be22 (1133952546)
// size ...... 6302 (0x189e)
// includes .. 3   (offset: 0x15e2)
// strings ... 27  (offset: 0x15fa)
// dev strs .. 19  (offset: 0x17aa)
// exports ... 14  (offset: 0xe46)
// cseg ...... 0x1f3 + 0xc53 (0xe46)
// imports ... 46  (offset: 0x1076)
// animtree1 . 0   (offset: 0x189e)
// animtree2 . 0   (offset: 0x189e)
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;

#namespace zombie_deathworm;

// Namespace zombie_deathworm
// Params 0, eflags: 0x1
// Checksum 0x462ede64, Offset: 0x211
// Size: 0x21
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_deathworm";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
}

// Namespace zombie_deathworm
// Params 0
// Checksum 0x884e01d7, Offset: 0x23a
// Size: 0x199
function init_metabones()
{
    metabone::function_b68bd9932f284448( &function_5caad8e61a9a77e7 );
    metabones_def = metabone::get_metabones_def( self.metabones.bundle_name );
    metabone::set_metabone_state( "gill_bottom_le", "open" );
    metabone::set_metabone_state( "gill_middle_le", "open" );
    metabone::set_metabone_state( "gill_top_le", "open" );
    metabone::set_metabone_state( "gill_bottom_ri", "open" );
    metabone::set_metabone_state( "gill_middle_ri", "open" );
    metabone::set_metabone_state( "gill_top_ri", "open" );
    self.var_55e1606d1eb021c5 = metabone::get_metabone_maxhealth( "gill_bottom_le", "open" );
    self.var_93ebdd9a70f80dee = [];
    self.var_93ebdd9a70f80dee[ 0 ] = metabones_def.var_2972332beaa5b174[ "gill_bottom_le" ].tags[ 0 ].tagname;
    self.var_93ebdd9a70f80dee[ 1 ] = metabones_def.var_2972332beaa5b174[ "gill_middle_le" ].tags[ 0 ].tagname;
    self.var_93ebdd9a70f80dee[ 2 ] = metabones_def.var_2972332beaa5b174[ "gill_top_le" ].tags[ 0 ].tagname;
    self.var_f0034ba493438077 = [ "bottom", "middle", "top" ];
    self function_786bb6aa1b76c7ee( "can_gill_destroyed_end_time", 0 );
    
    /#
        init_metabones_devgui();
        thread function_92bd62e610644fd();
    #/
}

// Namespace zombie_deathworm
// Params 0
// Checksum 0x47907fc1, Offset: 0x3db
// Size: 0xcc
function function_8e9c938af5a3d49a()
{
    var_af5e1b5a5210e86f = [ "gill_bottom_le", "gill_middle_le", "gill_top_le", "gill_bottom_ri", "gill_middle_ri", "gill_top_ri" ];
    var_768ce7b09d4f9ca1 = [];
    
    foreach ( var_dc342e0ce4689ca6 in var_af5e1b5a5210e86f )
    {
        if ( !metabone::is_metabone_destroyed( var_dc342e0ce4689ca6 ) )
        {
            var_768ce7b09d4f9ca1[ var_768ce7b09d4f9ca1.size ] = var_dc342e0ce4689ca6;
        }
    }
    
    return var_768ce7b09d4f9ca1;
}

// Namespace zombie_deathworm
// Params 1, eflags: 0x4
// Checksum 0xf727baaf, Offset: 0x4b0
// Size: 0x461
function private function_5caad8e61a9a77e7( dmgstruct )
{
    result_metabone_name = undefined;
    
    if ( dmgstruct.shitloc == "soft" )
    {
        var_12390b5b5c927239 = [ self gettagorigin( self.var_93ebdd9a70f80dee[ 0 ] ), self gettagorigin( self.var_93ebdd9a70f80dee[ 1 ] ), self gettagorigin( self.var_93ebdd9a70f80dee[ 2 ] ) ];
        var_3c9f14680f174676 = dmgstruct.vpoint;
        closest_tag_index = 0;
        var_dfd86a0d65928fd4 = -1;
        
        for ( tag_index = 0; tag_index < var_12390b5b5c927239.size ; tag_index++ )
        {
            dist_sq = distancesquared( var_3c9f14680f174676, var_12390b5b5c927239[ tag_index ] );
            
            if ( var_dfd86a0d65928fd4 == -1 || dist_sq < var_dfd86a0d65928fd4 )
            {
                closest_tag_index = tag_index;
                var_dfd86a0d65928fd4 = dist_sq;
            }
        }
        
        tag_angles = self gettagangles( self.var_93ebdd9a70f80dee[ closest_tag_index ] );
        tag_forward = anglestoforward( tag_angles );
        v_right = anglestoright( tag_angles );
        var_12390b5b5c927239[ closest_tag_index ] -= tag_forward * getdvarfloat( @"hash_19d1b5077a7fb997", 50 );
        var_46e09ad37214f422 = var_3c9f14680f174676 - var_12390b5b5c927239[ closest_tag_index ];
        var_ea218604e481d57b = vectordot( tag_forward, var_46e09ad37214f422 );
        var_856d2f11f6610b15 = vectordot( v_right, var_46e09ad37214f422 );
        damage_dist_threshold = undefined;
        var_4a9133346e46d733 = 90;
        
        switch ( closest_tag_index )
        {
            case 0:
                damage_dist_threshold = 27;
                break;
            case 1:
                damage_dist_threshold = 50;
                break;
            case 2:
                damage_dist_threshold = 85;
                break;
        }
        
        var_4ede0279ffdb41e5 = 0;
        
        if ( isdefined( dmgstruct.eattacker ) )
        {
            var_4ede0279ffdb41e5 = distance2d( dmgstruct.eattacker.origin, var_12390b5b5c927239[ closest_tag_index ] );
            var_2603d361d6fa987a = 0;
            damage_dist_threshold *= 1 - clamp( var_2603d361d6fa987a, 0, 1 ) * 0.8;
        }
        
        b_on_side = abs( var_856d2f11f6610b15 ) > var_4a9133346e46d733;
        
        if ( b_on_side )
        {
            b_on_right = utility::sign( var_856d2f11f6610b15 ) > 0;
            hit_armor = 0;
            metabone_location = self.var_f0034ba493438077[ closest_tag_index ];
            gill_metabone = "gill_" + metabone_location + ( b_on_right ? "_ri" : "_le" );
            armor_metabone = "plate_" + metabone_location + "_armor" + ( b_on_right ? "_ri" : "_le" );
            
            if ( !metabone::is_metabone_destroyed( armor_metabone ) )
            {
                if ( var_ea218604e481d57b > damage_dist_threshold )
                {
                    hit_armor = 1;
                }
            }
            
            if ( metabone::is_metabone_destroyed( gill_metabone ) )
            {
                gill_metabone = undefined;
            }
            
            result_metabone_name = hit_armor ? armor_metabone : gill_metabone;
        }
        
        /#
            if ( function_4c82f56a24e71c70() )
            {
                var_4c1f6677b29f33c2 = isdefined( result_metabone_name ) ? ( 0.5, 0.5, 0 ) : ( 0.2, 0.5, 0.5 );
                projected_pos = var_12390b5b5c927239[ closest_tag_index ] + tag_forward * var_ea218604e481d57b;
                sphere( projected_pos, 10, var_4c1f6677b29f33c2 );
                line( projected_pos, var_12390b5b5c927239[ closest_tag_index ], var_4c1f6677b29f33c2, 1 );
                print3d( projected_pos, "<dev string:x24>" + var_ea218604e481d57b + "<dev string:x39>" + damage_dist_threshold, var_4c1f6677b29f33c2 );
                print3d( projected_pos + ( 0, 0, 20 ), "<dev string:x45>" + var_856d2f11f6610b15 + "<dev string:x50>" + var_4a9133346e46d733, var_4c1f6677b29f33c2 );
            }
        #/
    }
    else if ( dmgstruct.shitloc == "head" )
    {
        result_metabone_name = "inner_jaw";
    }
    
    /#
        if ( function_4c82f56a24e71c70() )
        {
            if ( isdefined( dmgstruct.vpoint ) && isdefined( dmgstruct.vdir ) )
            {
                sphere( dmgstruct.vpoint, 10, ( 1, 0, 0 ) );
                line( dmgstruct.vpoint - dmgstruct.vdir * 100, dmgstruct.vpoint, ( 1, 0, 0 ), 1 );
                metabone_print( "<dev string:x5f>" + dmgstruct.shitloc, dmgstruct.vpoint );
            }
        }
    #/
    
    return result_metabone_name;
}

// Namespace zombie_deathworm
// Params 1, eflags: 0x4
// Checksum 0x2e942a55, Offset: 0x91a
// Size: 0x1e
function private on_metabone_destroyed( params )
{
    _on_metabone_destroyed( params.metabone_name );
}

// Namespace zombie_deathworm
// Params 1, eflags: 0x4
// Checksum 0x9321308e, Offset: 0x940
// Size: 0x36
function private _on_metabone_destroyed( metabone_name )
{
    if ( self getscriptablehaspart( metabone_name ) )
    {
        self setscriptablepartstate( metabone_name, "off" );
        self function_786bb6aa1b76c7ee( "can_gill_destroyed_end_time", gettime() + 2000 );
    }
}

// Namespace zombie_deathworm
// Params 1
// Checksum 0xc88ff2d8, Offset: 0x97e
// Size: 0x18e
function function_40598c4a26d847b9( scriptable )
{
    var_af5e1b5a5210e86f = [ "gill_bottom_le", "gill_middle_le", "gill_top_le", "gill_bottom_ri", "gill_middle_ri", "gill_top_ri" ];
    
    foreach ( var_dc342e0ce4689ca6 in var_af5e1b5a5210e86f )
    {
        if ( metabone::is_metabone_destroyed( var_dc342e0ce4689ca6 ) )
        {
            scriptable setscriptablepartstate( var_dc342e0ce4689ca6, "off" );
        }
    }
    
    plates = [ "plate_bottom_armor_le", "plate_middle_armor_le", "plate_top_armor_le", "plate_bottom_armor_ri", "plate_middle_armor_ri", "plate_top_armor_ri" ];
    
    foreach ( plate in plates )
    {
        if ( metabone::is_metabone_destroyed( plate ) )
        {
            scriptable setscriptablepartstate( plate, "off" );
        }
    }
}

/#

    // Namespace zombie_deathworm
    // Params 0, eflags: 0x4
    // Checksum 0x639fb2be, Offset: 0xb14
    // Size: 0x2e, Type: dev
    function private init_metabones_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x66>" );
        devgui::add_devgui_func( "<dev string:x82>", "<dev string:x92>", &toggle_debug_metabones );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_deathworm
    // Params 0, eflags: 0x4
    // Checksum 0x6b379a0b, Offset: 0xb4a
    // Size: 0x1f4, Type: dev
    function private function_92bd62e610644fd()
    {
        self endon( #"death" );
        waitframe();
        
        while ( true )
        {
            metabones_def = metabone::get_metabones_def( self.metabones.bundle_name );
            
            foreach ( metabone in metabones_def.metabones )
            {
                if ( !arraycontains( [ "<dev string:xac>", "<dev string:xbb>", "<dev string:xca>" ], metabone.name ) )
                {
                    continue;
                }
                
                foreach ( tag in metabone.tags )
                {
                    function_313179acf9868913( tag.tagname );
                    tag_name_arr = strtok( tag.tagname, "<dev string:xd6>" );
                    var_32fd2e875511f651 = int( tag_name_arr[ tag_name_arr.size - 1 ] );
                    var_11830e10c407e338 = "<dev string:xd8>" + ( var_32fd2e875511f651 - 1 < 10 ? "<dev string:xe0>" : "<dev string:xe2>" ) + var_32fd2e875511f651 - 1;
                    var_bba0ab57ed460c48 = "<dev string:xd8>" + ( var_32fd2e875511f651 + 1 < 10 ? "<dev string:xe0>" : "<dev string:xe2>" ) + var_32fd2e875511f651 + 1;
                }
            }
            
            waitframe();
        }
    }

    // Namespace zombie_deathworm
    // Params 1, eflags: 0x4
    // Checksum 0xf9222a96, Offset: 0xd46
    // Size: 0x5d, Type: dev
    function private function_313179acf9868913( tagname )
    {
        tag_origin = self gettagorigin( tagname );
        tag_angles = self gettagangles( tagname );
        metabone_print( tagname + "<dev string:xe3>" + tag_angles[ 0 ] + "<dev string:xe7>" + tag_angles[ 1 ] + "<dev string:xe7>" + tag_angles[ 2 ], tag_origin );
    }

    // Namespace zombie_deathworm
    // Params 0, eflags: 0x4
    // Checksum 0x913ad686, Offset: 0xdab
    // Size: 0x16, Type: dev
    function private function_4c82f56a24e71c70()
    {
        return getdvarint( @"deathworm_debug_metabones", 0 ) > 0;
    }

    // Namespace zombie_deathworm
    // Params 0, eflags: 0x4
    // Checksum 0xf5191ecd, Offset: 0xdc9
    // Size: 0x1a, Type: dev
    function private toggle_debug_metabones()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xe9>", @"deathworm_debug_metabones" );
    }

    // Namespace zombie_deathworm
    // Params 2, eflags: 0x4
    // Checksum 0xd887ce2d, Offset: 0xdeb
    // Size: 0x5b, Type: dev
    function private metabone_print( text, pos )
    {
        if ( function_4c82f56a24e71c70() )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:x103>" + text, ( 1, 0, 0 ) );
        }
    }

#/
