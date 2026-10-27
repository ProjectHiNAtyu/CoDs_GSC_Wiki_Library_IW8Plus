// script_1cf5d9457347aa39  (hash_1cf5d9457347aa39.gscc) (size: 729 Bytes / 0x2d9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7ddb6c33 (2111532083)
// size ...... 729 (0x2d9)
// includes .. 2   (offset: 0x2b1)
// strings ... 2   (offset: 0x2c1)
// dev strs .. 0   (offset: 0x2d9)
// exports ... 4   (offset: 0x169)
// cseg ...... 0x93 + 0xd6 (0x169)
// imports ... 6   (offset: 0x209)
// animtree1 . 0   (offset: 0x2d9)
// animtree2 . 0   (offset: 0x2d9)
#using script_53651341190c5aab;
#using scripts\common\utility;

#namespace squad_movement;

// Namespace squad_movement
// Params 1
// Checksum 0xc30ab2a9, Offset: 0xb1
// Size: 0x42
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_dab0d83df51da4d":
            return &onuserinit;
        case #"hash_722d767fd6d40f56":
            return &onuserterminate;
    }
    
    return interaction_common::function_d4be89b1cf3d4993( funcid );
}

// Namespace squad_movement
// Params 1
// Checksum 0xfdf66650, Offset: 0xfc
// Size: 0xc
function onuserinit( interactionid )
{
    
}

// Namespace squad_movement
// Params 1
// Checksum 0xfd73c43e, Offset: 0x110
// Size: 0x59
function onuserterminate( interactionid )
{
    var_1c4b32ab1bec160c = utility::is_dead_or_dying( self );
    tag = self function_2e50bdd9495d2b8c();
    var_8ddb810836e488a1 = tag == "leader";
    
    if ( var_8ddb810836e488a1 && var_1c4b32ab1bec160c )
    {
        function_dd518df9ee8d217c( interactionid, "leader_death", 1 );
    }
}

