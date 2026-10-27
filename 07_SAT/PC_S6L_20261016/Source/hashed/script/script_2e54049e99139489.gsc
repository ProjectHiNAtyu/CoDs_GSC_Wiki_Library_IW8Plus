// script_2e54049e99139489  (hash_2e54049e99139489.gscc) (size: 686 Bytes / 0x2ae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd8c07f8c (3636494220)
// size ...... 686 (0x2ae)
// includes .. 1   (offset: 0x2a6)
// strings ... 0   (offset: 0x2ae)
// dev strs .. 0   (offset: 0x2ae)
// exports ... 2   (offset: 0x192)
// cseg ...... 0x58 + 0x13a (0x192)
// imports ... 7   (offset: 0x1e2)
// animtree1 . 0   (offset: 0x2ae)
// animtree2 . 0   (offset: 0x2ae)
#using scripts\common\utility;

#namespace spawn_scriptable;

// Namespace spawn_scriptable
// Params 1
// Checksum 0x9113254e, Offset: 0x76
// Size: 0x11c
function execute( params )
{
    scriptable = params.scriptable;
    vector_right = anglestoright( self.angles ) * params.spawndirection.x;
    var_e3eb0afdf490177f = anglestoforward( self.angles ) * params.spawndirection.y;
    vector_up = anglestoup( self.angles ) * params.spawndirection.z;
    spawn_vector = vector_right + var_e3eb0afdf490177f + vector_up;
    spawn_target_position = utility::drop_to_ground( self.origin + spawn_vector, 1 );
    spawn_target_position = getclosestpointonnavmesh( spawn_target_position );
    spawn_payload = params.payload ?? calcscriptablepayloadgravityarc( self.origin, spawn_target_position );
    spawnscriptable( scriptable, spawn_target_position, self.angles, undefined, spawn_payload );
}

