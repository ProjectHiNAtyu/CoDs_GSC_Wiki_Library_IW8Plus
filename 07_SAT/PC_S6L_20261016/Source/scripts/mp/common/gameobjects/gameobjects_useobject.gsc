// scripts\mp\common\gameobjects\gameobjects_useobject.gsc  (hash_094d7222697ed098.gscc) (size: 2652 Bytes / 0xa5c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe708c1c3 (3876110787)
// size ...... 2652 (0xa5c)
// includes .. 2   (offset: 0x978)
// strings ... 6   (offset: 0x988)
// dev strs .. 8   (offset: 0x9e8)
// exports ... 9   (offset: 0x680)
// cseg ...... 0xba + 0x5c6 (0x680)
// imports ... 14  (offset: 0x7e8)
// animtree1 . 0   (offset: 0xa5c)
// animtree2 . 0   (offset: 0xa5c)
#using scripts\common\system;
#using scripts\mp\common\gameobjects\gameobjects_common;

#namespace gameobjects_useobject;

// Namespace gameobjects_useobject
// Params 1
// Checksum 0xbdc41ed6, Offset: 0xd8
// Size: 0xaa
function function_b2cb272607367f31( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_use_object" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_use_object" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_use_object" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return game_object.var_daaa29ac3e7ee276;
}

// Namespace gameobjects_useobject
// Params 1
// Checksum 0x5d6bee5c, Offset: 0x18b
// Size: 0xab, Type: bool
function is_used( game_object )
{
    if ( !istrue( game_object.type_hash == #"gameobject_type_use_object" ) )
    {
        assertmsg( "<dev string:x24>" + "<dev string:x33>" + #"gameobject_type_use_object" + "<dev string:x57>" + "<dev string:x59>" + game_object.name_hash + "<dev string:x68>" );
        logstring( "[GAME OBJECT] " + "ASSERT: " + "Expects game object to by of type '" + #"gameobject_type_use_object" + "'" + " { name_hash: " + game_object.name_hash + " }" );
    }
    
    return istrue( game_object.used );
}

// Namespace gameobjects_useobject
// Params 0, eflags: 0x5
// Checksum 0x3c70a0b5, Offset: 0x23f
// Size: 0x42
function private autoexec __autoexec__()
{
    if ( isdefined( level.gametypebundle.var_ae100eea97c7fcc7[ #"hash_14bb716c4b77c45a" ] ) )
    {
        system::register( #"hash_ff96cbf0d939f5d6", #"gameobjects_common", &function_a53b566f98941da2, undefined );
    }
}

// Namespace gameobjects_useobject
// Params 0, eflags: 0x4
// Checksum 0x83087fe9, Offset: 0x289
// Size: 0xb9
function private function_a53b566f98941da2()
{
    [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_use_object", #"hash_aa89afe9cb4cc4a2", &function_76428e1a864b2a0b );
    [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_use_object", #"hash_b9c66d4b9cc93bfb", &function_ba29802e138b29fc );
    [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_use_object", #"hash_3f6e412bf6d9eee0", &function_6bfea8a5a1055c3f );
    
    /#
        [[ level.game_objects.var_cce4fabe8192a953 ]]( #"gameobject_type_use_object", #"hash_8fb85d546a6d8844", &function_93a99be6fc27258b );
    #/
}

// Namespace gameobjects_useobject
// Params 2, eflags: 0x4
// Checksum 0x122f8ee9, Offset: 0x34a
// Size: 0x58
function private function_76428e1a864b2a0b( game_object, var_24290c36e2cab388 )
{
    if ( var_24290c36e2cab388.game_object_definition.usableproperties.enable )
    {
        game_object.usable_properties = var_24290c36e2cab388.game_object_definition.usableproperties;
    }
}

// Namespace gameobjects_useobject
// Params 2, eflags: 0x4
// Checksum 0x565f92ab, Offset: 0x3aa
// Size: 0x55, Type: bool
function private function_ba29802e138b29fc( game_object, player )
{
    if ( !gameobjects_common::is_activated( game_object ) )
    {
        return false;
    }
    
    if ( gameobjects_common::is_in_use( game_object ) && !gameobjects_common::function_6057f2c78ba2b3a2( game_object, player ) )
    {
        return !game_object.usable_properties.exclusiveuse;
    }
    
    return true;
}

// Namespace gameobjects_useobject
// Params 2, eflags: 0x4
// Checksum 0x2c36eabd, Offset: 0x408
// Size: 0x1c9
function private function_6bfea8a5a1055c3f( game_object, update_struct )
{
    update_struct.var_536395db3d80fedb = #"hash_bb332da19f9944df";
    player_count = 0;
    players_using = gameobjects_common::get_players_using( game_object );
    
    foreach ( var_c68e9f43ed9cc918, players in players_using )
    {
        if ( players.size > player_count )
        {
            update_struct.var_536395db3d80fedb = var_c68e9f43ed9cc918;
            player_count = players.size;
            continue;
        }
        
        if ( players.size == player_count )
        {
            update_struct.var_536395db3d80fedb = #"hash_a1360b18943e920";
        }
    }
    
    if ( update_struct.var_536395db3d80fedb == #"hash_bb332da19f9944df" || update_struct.var_536395db3d80fedb == #"hash_a1360b18943e920" )
    {
        update_struct.progress = 0;
        update_struct.status = #"hash_64b95fcceb630072";
        return;
    }
    
    if ( game_object.use_time_seconds == 0 )
    {
        update_struct.status = #"hash_6b016a28066286ff";
        return;
    }
    
    update_struct.progress += level.framedurationseconds * update_struct.use_time_scalar;
    
    if ( update_struct.progress >= 1 )
    {
        update_struct.progress = 0;
        update_struct.status = #"hash_6b016a28066286ff";
    }
}

/#

    // Namespace gameobjects_useobject
    // Params 2, eflags: 0x4
    // Checksum 0x7009c786, Offset: 0x5d9
    // Size: 0xa7, Type: dev
    function private function_93a99be6fc27258b( game_object, update_struct )
    {
        /#
            if ( !isdefined( game_object.debug_update_struct ) )
            {
                game_object.debug_update_struct = {};
            }
            
            if ( !isdefined( game_object.debug_update_struct.strings ) )
            {
                game_object.debug_update_struct.strings = [];
            }
            
            game_object.debug_update_struct.strings[ game_object.debug_update_struct.strings.size ] = toupper( "<dev string:x6b>" ) + "<dev string:x70>" + "<dev string:x73>";
        #/
    }

#/
