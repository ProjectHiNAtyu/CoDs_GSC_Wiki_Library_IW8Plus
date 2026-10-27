// scripts\common\ai\aitypes\zombie_abom\zombie_abom_metabones.gsc  (hash_70d8465ce4eb470b.gscc) (size: 2730 Bytes / 0xaaa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x17e0be89 (400604809)
// size ...... 2730 (0xaaa)
// includes .. 4   (offset: 0x9d6)
// strings ... 10  (offset: 0x9f6)
// dev strs .. 2   (offset: 0xa8e)
// exports ... 10  (offset: 0x5c6)
// cseg ...... 0xe2 + 0x4e4 (0x5c6)
// imports ... 22  (offset: 0x756)
// animtree1 . 0   (offset: 0xaaa)
// animtree2 . 0   (offset: 0xaaa)
#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\metabone;
#using scripts\common\utility;

#namespace zombie_abom_metabones;

// Namespace zombie_abom_metabones
// Params 0, eflags: 0x1
// Checksum 0xab84c98, Offset: 0x100
// Size: 0xbd
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_abom";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
    level.var_2aeaf66762db8e14 = [];
    level.var_2aeaf66762db8e14[ "head_le" ] = 0;
    level.var_2aeaf66762db8e14[ "head_mid" ] = 1;
    level.var_2aeaf66762db8e14[ "head_ri" ] = 2;
    level.var_93e6be4b24339ce4 = [];
    level.var_93e6be4b24339ce4[ 0 ] = "head_le";
    level.var_93e6be4b24339ce4[ 1 ] = "head_mid";
    level.var_93e6be4b24339ce4[ 2 ] = "head_ri";
    utility::registersharedfunc( #"zombie_abom_metabones", #"hash_7dd1871877d05ca4", &is_head_alive );
}

// Namespace zombie_abom_metabones
// Params 1, eflags: 0x4
// Checksum 0xa2cbbc5d, Offset: 0x1c5
// Size: 0x1e
function private on_metabone_destroyed( params )
{
    _on_metabone_destroyed( params.metabone_name );
}

// Namespace zombie_abom_metabones
// Params 1, eflags: 0x4
// Checksum 0xd33d2908, Offset: 0x1eb
// Size: 0xb9
function private _on_metabone_destroyed( metabone_name )
{
    if ( self getscriptablehaspart( metabone_name ) )
    {
        self setscriptablepartstate( metabone_name, "destroyed" );
        metabone::set_metabone_state( metabone_name, "destroyed" );
        asm::function_7256f5ba459c840b( "head_destroyed_in" );
        self notify( "head_destroyed_" + level.var_2aeaf66762db8e14[ metabone_name ] );
        var_c652e1dbebef1dfa = get_heads_alive( self );
        params = spawnstruct();
        params.metabone_name = metabone_name;
        params.var_c652e1dbebef1dfa = var_c652e1dbebef1dfa;
        callback::callback( "head_destroyed", params );
        update_head_health( var_c652e1dbebef1dfa );
        return;
    }
    
    assertmsg( "<dev string:x24>" + metabone_name );
}

// Namespace zombie_abom_metabones
// Params 1
// Checksum 0x2582fb36, Offset: 0x2ac
// Size: 0x139
function update_head_health( var_c652e1dbebef1dfa = get_heads_alive( self ) )
{
    if ( var_c652e1dbebef1dfa.size == 2 )
    {
        foreach ( var_cc62445e986357e6 in var_c652e1dbebef1dfa )
        {
            metabone::function_dbe4a2c3b0797294( var_cc62445e986357e6, self.maxhealth * 0.15, "open" );
        }
        
        return;
    }
    
    if ( var_c652e1dbebef1dfa.size == 1 )
    {
        foreach ( var_cc62445e986357e6 in var_c652e1dbebef1dfa )
        {
            metabone::set_metabone_health( var_cc62445e986357e6, self.health, "open" );
        }
        
        return;
    }
    
    self.killondamage = 1;
}

// Namespace zombie_abom_metabones
// Params 1
// Checksum 0x7439c04, Offset: 0x3ed
// Size: 0x5d
function get_heads_alive( entity )
{
    var_ef2f9f9d21019043 = [];
    
    for ( var_e8b483d049d7276b = 0; var_e8b483d049d7276b <= 2 ; var_e8b483d049d7276b++ )
    {
        if ( is_head_alive( entity, var_e8b483d049d7276b ) )
        {
            metabone = level.var_93e6be4b24339ce4[ var_e8b483d049d7276b ];
            var_ef2f9f9d21019043[ var_ef2f9f9d21019043.size ] = metabone;
        }
    }
    
    return var_ef2f9f9d21019043;
}

// Namespace zombie_abom_metabones
// Params 1
// Checksum 0x28633701, Offset: 0x453
// Size: 0x47
function function_621da7a4dc0c0695( entity )
{
    var_ef2f9f9d21019043 = [];
    
    for ( var_e8b483d049d7276b = 0; var_e8b483d049d7276b <= 2 ; var_e8b483d049d7276b++ )
    {
        if ( is_head_alive( entity, var_e8b483d049d7276b ) )
        {
            var_ef2f9f9d21019043[ var_ef2f9f9d21019043.size ] = var_e8b483d049d7276b;
        }
    }
    
    return var_ef2f9f9d21019043;
}

// Namespace zombie_abom_metabones
// Params 2
// Checksum 0xa31e5ea3, Offset: 0x4a3
// Size: 0x56, Type: bool
function is_head_alive( entity, var_e8b483d049d7276b )
{
    assert( var_e8b483d049d7276b >= 0 && var_e8b483d049d7276b <= 2, "<dev string:x4f>" );
    metabone = level.var_93e6be4b24339ce4[ var_e8b483d049d7276b ];
    return entity metabone::get_metabone_state_name( metabone ) != "destroyed";
}

// Namespace zombie_abom_metabones
// Params 3
// Checksum 0xf9511138, Offset: 0x502
// Size: 0x98
function set_head_open_state( entity, var_e8b483d049d7276b, is_open )
{
    assert( var_e8b483d049d7276b >= 0 && var_e8b483d049d7276b <= 2, "<dev string:x4f>" );
    metabone_state = is_open ? "open" : "closed";
    
    if ( !is_head_alive( entity, var_e8b483d049d7276b ) )
    {
        metabone_state = "destroyed";
    }
    
    entity metabone::set_metabone_active( level.var_93e6be4b24339ce4[ var_e8b483d049d7276b ], istrue( is_open ) );
    entity metabone::set_metabone_state( level.var_93e6be4b24339ce4[ var_e8b483d049d7276b ], metabone_state );
}

// Namespace zombie_abom_metabones
// Params 1
// Checksum 0x84d3a280, Offset: 0x5a2
// Size: 0x23
function function_316f556358b6282b( metabone_name )
{
    if ( self getscriptablehaspart( metabone_name ) )
    {
        return level.var_2aeaf66762db8e14[ metabone_name ];
    }
}

