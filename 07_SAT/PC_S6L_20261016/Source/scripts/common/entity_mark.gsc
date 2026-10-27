// scripts\common\entity_mark.gsc  (hash_1e1966d378e8affd.gscc) (size: 2351 Bytes / 0x92f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7dcc347e (2110534782)
// size ...... 2351 (0x92f)
// includes .. 1   (offset: 0x887)
// strings ... 8   (offset: 0x88f)
// dev strs .. 0   (offset: 0x92f)
// exports ... 10  (offset: 0x507)
// cseg ...... 0x122 + 0x3e5 (0x507)
// imports ... 16  (offset: 0x697)
// animtree1 . 0   (offset: 0x92f)
// animtree2 . 0   (offset: 0x92f)
#using scripts\common\values;

#namespace entity_mark;

// Namespace entity_mark
// Params 0, eflags: 0x1
// Checksum 0xa1c4ca98, Offset: 0x140
// Size: 0xb0
function autoexec main()
{
    val::register( "entity_mark_equipment", 0, 0, "$self", &set_entity_mark_equipment, "$value" );
    val::register( "entity_mark_killstreak", 0, 0, "$self", &set_entity_mark_killstreak, "$value" );
    val::register( "entity_mark_air_killstreak", 0, 0, "$self", &set_entity_mark_air_killstreak, "$value" );
    val::register( "entity_mark_origin_equipment", 0, 0, "$self", &set_entity_mark_origin_equipment, "$value" );
    val::register( "entity_mark_origin_killstreak", 0, 0, "$self", &set_entity_mark_origin_killstreak, "$value" );
    val::register( "entity_mark_origin_air_killstreak", 0, 0, "$self", &set_entity_mark_origin_air_killstreak, "$value" );
}

// Namespace entity_mark
// Params 1, eflags: 0x4
// Checksum 0x302b1524, Offset: 0x1f8
// Size: 0x2b
function private set_entity_mark_equipment( radius = 0 )
{
    set_entity_mark( #"equipment", radius, "entity_mark_equipment" );
}

// Namespace entity_mark
// Params 1, eflags: 0x4
// Checksum 0xb5b3ff67, Offset: 0x22b
// Size: 0x2b
function private set_entity_mark_killstreak( radius = 0 )
{
    set_entity_mark( #"killstreak", radius, "entity_mark_killstreak" );
}

// Namespace entity_mark
// Params 1, eflags: 0x4
// Checksum 0x800b0a22, Offset: 0x25e
// Size: 0x2b
function private set_entity_mark_air_killstreak( radius = 0 )
{
    set_entity_mark( #"air_killstreak", radius, "entity_mark_air_killstreak" );
}

// Namespace entity_mark
// Params 3, eflags: 0x4
// Checksum 0x283899a, Offset: 0x291
// Size: 0xd8
function private set_entity_mark( mark_type, mark_distance, value_id )
{
    assert( isplayer( self ) );
    
    if ( !isdefined( mark_type ) )
    {
        return;
    }
    
    active_values = self.values[ value_id ];
    
    foreach ( value in active_values )
    {
        if ( value > mark_distance )
        {
            mark_distance = value;
        }
    }
    
    if ( mark_distance <= 0 )
    {
        self disableentitymarks( mark_type );
        return;
    }
    
    self enableentitymarks( mark_type, mark_distance );
}

// Namespace entity_mark
// Params 1, eflags: 0x4
// Checksum 0xef8f015b, Offset: 0x371
// Size: 0x2b
function private set_entity_mark_origin_equipment( status = 0 )
{
    set_entity_mark_origin( #"equipment", status, "entity_mark_origin_equipment" );
}

// Namespace entity_mark
// Params 1, eflags: 0x4
// Checksum 0x86ef54ab, Offset: 0x3a4
// Size: 0x2b
function private set_entity_mark_origin_killstreak( status = 0 )
{
    set_entity_mark_origin( #"killstreak", status, "entity_mark_origin_killstreak" );
}

// Namespace entity_mark
// Params 1, eflags: 0x4
// Checksum 0xd6da11ba, Offset: 0x3d7
// Size: 0x2b
function private set_entity_mark_origin_air_killstreak( status = 0 )
{
    set_entity_mark_origin( #"air_killstreak", status, "entity_mark_origin_air_killstreak" );
}

// Namespace entity_mark
// Params 3, eflags: 0x4
// Checksum 0xb0aadcdf, Offset: 0x40a
// Size: 0xfd
function private set_entity_mark_origin( mark_type, var_1c139edaf43ca40d, value_id )
{
    assert( isplayer( self ) );
    
    if ( !isdefined( mark_type ) )
    {
        return;
    }
    
    if ( !var_1c139edaf43ca40d )
    {
        active_values = self.values[ value_id ];
        
        foreach ( value in active_values )
        {
            if ( value )
            {
                var_1c139edaf43ca40d = 1;
                break;
            }
        }
    }
    
    origin = ( 0, 0, 0 );
    
    if ( var_1c139edaf43ca40d )
    {
        origin = self.origin;
    }
    
    self function_37097bbe1bca8f6c( mark_type, var_1c139edaf43ca40d );
    self function_3a4525281cf413a2( mark_type, origin );
}

