// script_4592670a60fb0195  (hash_4592670a60fb0195.gscc) (size: 2807 Bytes / 0xaf7)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x962620de (2519081182)
// size ...... 2807 (0xaf7)
// includes .. 0   (offset: 0xac7)
// strings ... 2   (offset: 0xac7)
// dev strs .. 2   (offset: 0xadf)
// exports ... 9   (offset: 0x6d3)
// cseg ...... 0x77 + 0x65c (0x6d3)
// imports ... 22  (offset: 0x83b)
// animtree1 . 0   (offset: 0xaf7)
// animtree2 . 0   (offset: 0xaf7)
#namespace namespace_b3087bd586139a5a;

// Namespace namespace_b3087bd586139a5a
// Params 0
// Checksum 0x60eecb9c, Offset: 0x95
// Size: 0x10a
function function_7b5b0ace3857f472()
{
    level endon( #"exitlevel_called" );
    level waittill( #"prematch_started" );
    var_43b1f284c811b97 = { #var_522523a4482cb7b6:4, #var_d2f5c218da5cd61b:-15000, #n_max_cooldown_s:15, #n_min_cooldown_s:7, #var_31b48cc072e022df:1, #var_8890d6c7ed37d5fb:[], #var_edc85112b1eeb375:[ ( -6475, 15000, 0 ), ( 6475, 15000, 0 ), ( -7475, 15000, 0 ), ( 7475, 15000, 0 ) ], #var_bfa960aa5701ca5b:[], #a_e_movers:getentarray( "near_vista_ocean_mover", #script_noteworthy ) };
    init_mover_set( var_43b1f284c811b97 );
    function_a1b3f06bb1533615( var_43b1f284c811b97 );
    
    while ( true )
    {
        function_8a74d45999119c84( var_43b1f284c811b97 );
        function_23c051e0486710ad( var_43b1f284c811b97 );
        waitframe();
    }
}

// Namespace namespace_b3087bd586139a5a
// Params 1, eflags: 0x4
// Checksum 0xe2c16b89, Offset: 0x1a7
// Size: 0x157
function private init_mover_set( var_4692fc4eb13945c6 )
{
    if ( isdefined( var_4692fc4eb13945c6.a_e_movers ) )
    {
        foreach ( e_mover in var_4692fc4eb13945c6.a_e_movers )
        {
            if ( !isdefined( e_mover.script_parameters ) )
            {
                assertmsg( e_mover.name + "<dev string:x24>" );
            }
            
            var_fb3a9a50c517657e = strtok( e_mover.script_parameters, "," );
            e_mover.starting_origin = e_mover.origin;
            e_mover.n_speed_modifier = isdefined( var_fb3a9a50c517657e[ 0 ] ) ? float( var_fb3a9a50c517657e[ 0 ] ) : 1;
            e_mover.n_z_height_offset = isdefined( var_fb3a9a50c517657e[ 1 ] ) ? float( var_fb3a9a50c517657e[ 1 ] ) : 0;
            e_mover hide();
            e_mover notsolid();
        }
        
        return;
    }
    
    assert( isdefined( var_4692fc4eb13945c6.a_e_movers ), var_4692fc4eb13945c6 + "<dev string:x81>" );
}

// Namespace namespace_b3087bd586139a5a
// Params 1, eflags: 0x4
// Checksum 0x5852c979, Offset: 0x306
// Size: 0xe3
function private function_23c051e0486710ad( var_1cf5d2b3c09ff13b )
{
    foreach ( e_mover in var_1cf5d2b3c09ff13b.var_bfa960aa5701ca5b )
    {
        if ( e_mover.origin[ 1 ] > var_1cf5d2b3c09ff13b.var_d2f5c218da5cd61b )
        {
            e_mover move_mover( var_1cf5d2b3c09ff13b.var_522523a4482cb7b6 );
            continue;
        }
        
        e_mover reset_mover( var_1cf5d2b3c09ff13b.var_bfa960aa5701ca5b );
        var_1cf5d2b3c09ff13b.var_bfa960aa5701ca5b = arrayremove( var_1cf5d2b3c09ff13b.var_bfa960aa5701ca5b, e_mover );
    }
}

// Namespace namespace_b3087bd586139a5a
// Params 1, eflags: 0x4
// Checksum 0xe4128a69, Offset: 0x3f1
// Size: 0x4b
function private function_8a74d45999119c84( var_1cf5d2b3c09ff13b )
{
    if ( var_1cf5d2b3c09ff13b.var_bfa960aa5701ca5b.size < var_1cf5d2b3c09ff13b.var_31b48cc072e022df )
    {
        wait randomintrange( var_1cf5d2b3c09ff13b.n_min_cooldown_s, var_1cf5d2b3c09ff13b.n_max_cooldown_s );
        function_a1b3f06bb1533615( var_1cf5d2b3c09ff13b );
    }
}

// Namespace namespace_b3087bd586139a5a
// Params 1, eflags: 0x4
// Checksum 0xee215ebb, Offset: 0x444
// Size: 0x19d
function private function_a1b3f06bb1533615( var_1cf5d2b3c09ff13b )
{
    if ( var_1cf5d2b3c09ff13b.var_31b48cc072e022df >= var_1cf5d2b3c09ff13b.a_e_movers.size )
    {
        foreach ( e_mover in var_1cf5d2b3c09ff13b.a_e_movers )
        {
            var_1cf5d2b3c09ff13b.var_bfa960aa5701ca5b[ var_1cf5d2b3c09ff13b.var_bfa960aa5701ca5b.size ] = e_mover;
            e_mover function_dd595a1b7456574( var_1cf5d2b3c09ff13b );
            waitframe();
            e_mover show();
        }
        
        return;
    }
    
    while ( var_1cf5d2b3c09ff13b.var_bfa960aa5701ca5b.size < var_1cf5d2b3c09ff13b.var_31b48cc072e022df )
    {
        var_1cf5d2b3c09ff13b.var_bfa960aa5701ca5b = arraycombineunique( var_1cf5d2b3c09ff13b.var_bfa960aa5701ca5b, [ var_1cf5d2b3c09ff13b.a_e_movers[ randomint( var_1cf5d2b3c09ff13b.a_e_movers.size ) ] ] );
    }
    
    foreach ( e_mover in var_1cf5d2b3c09ff13b.var_bfa960aa5701ca5b )
    {
        e_mover function_dd595a1b7456574( var_1cf5d2b3c09ff13b );
        waitframe();
        e_mover show();
    }
}

// Namespace namespace_b3087bd586139a5a
// Params 1, eflags: 0x4
// Checksum 0x8f431bdd, Offset: 0x5e9
// Size: 0x2e
function private move_mover( var_b6e4470f83909016 )
{
    self.origin -= ( 0, var_b6e4470f83909016 * self.n_speed_modifier, 0 );
}

// Namespace namespace_b3087bd586139a5a
// Params 1, eflags: 0x4
// Checksum 0x453cebbe, Offset: 0x61f
// Size: 0x76
function private function_dd595a1b7456574( var_1cf5d2b3c09ff13b )
{
    v_random_vector = [];
    n_random_index = randomint( var_1cf5d2b3c09ff13b.var_edc85112b1eeb375.size );
    
    if ( arraycontains( var_1cf5d2b3c09ff13b.var_8890d6c7ed37d5fb, n_random_index ) )
    {
    }
    
    v_random_vector = var_1cf5d2b3c09ff13b.var_edc85112b1eeb375[ n_random_index ];
    self.origin = ( v_random_vector[ 0 ], v_random_vector[ 1 ], v_random_vector[ 2 ] + self.n_z_height_offset );
}

// Namespace namespace_b3087bd586139a5a
// Params 1, eflags: 0x4
// Checksum 0x347e5c62, Offset: 0x69d
// Size: 0x36
function private reset_mover( var_23ea7575c1e18cc5 )
{
    self flagteleport();
    self.origin = self.starting_origin ?? self.origin;
    self hide();
}

