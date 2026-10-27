// script_266a2d1f7d0c5191  (hash_266a2d1f7d0c5191.gscc) (size: 4823 Bytes / 0x12d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9d993368 (2644063080)
// size ...... 4823 (0x12d7)
// includes .. 5   (offset: 0x120f)
// strings ... 9   (offset: 0x1237)
// dev strs .. 0   (offset: 0x12d7)
// exports ... 25  (offset: 0x867)
// cseg ...... 0x159 + 0x70e (0x867)
// imports ... 47  (offset: 0xc4f)
// animtree1 . 0   (offset: 0x12d7)
// animtree2 . 0   (offset: 0x12d7)
#using scripts\common\utility;
#using scripts\mp\ftue\utility\ftue_firing;
#using scripts\mp\ftue\utility\ftue_movement;
#using scripts\mp\ftue\utility\ftue_objectives;
#using scripts\mp\ftue\utility\ftue_tip;

#namespace ftue_poc;

// Namespace ftue_poc
// Params 1
// Checksum 0x5e688c9c, Offset: 0x177
// Size: 0x1f
function function_c92e220a410e8a8f( firingtargets )
{
    function_50806c82c6d788a1();
    wait 2;
    thread function_5549c884e3eab5ce( firingtargets );
}

// Namespace ftue_poc
// Params 0
// Checksum 0xec02ad59, Offset: 0x19e
// Size: 0xbc
function function_50806c82c6d788a1()
{
    utility::flag_init( "ftue_player_walked" );
    utility::flag_init( "ftue_player_sprinted" );
    utility::flag_init( "ftue_player_tactial_sprinted" );
    utility::flag_init( "ftue_player_auto_sprinted" );
    utility::flag_init( "ftue_player_moved_camera" );
    utility::flag_init( "ftue_player_moved_camera_and_walked" );
    utility::flag_init( "ftue_player_gas_minimap" );
    thread ftue_movement::function_4aa68cd6002c229( getdvarint( @"hash_ee469d27e4289247", 2 ) );
    thread ftue_movement::function_18c7b96a7a2afacd();
    thread ftue_movement::function_9563a8eb6d150b80();
    thread ftue_movement::function_716b247f4427a04e();
    thread ftue_movement::function_a5f2a55c67641492( getdvarint( @"hash_662138da96c93838", 90 ) );
    thread ftue_movement::function_7277ffd13b9163be( getdvarint( @"hash_23cd75bde42da8fa", 2 ), getdvarint( @"hash_687f1b162dc45a02", 90 ) );
}

// Namespace ftue_poc
// Params 1
// Checksum 0xf6f50cc3, Offset: 0x262
// Size: 0x19c
function function_5549c884e3eab5ce( firingtargets )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"ftue_completed" );
    function_61203f537040b84e( getdvarint( @"hash_d97115f3374e6f10", 2 ), &function_db46e61b4a5b96e3, &function_8a72bbe7f029df76 );
    utility::flag_wait( "ftue_player_walked" );
    ftue_tip::function_953a5a3682bc5957();
    function_44d94df93b2bb477( getdvarint( @"hash_6ecd83ec95c61773", 2 ), &function_9cb46b51076b7d5c, &function_8ecab05a6c47ffb5 );
    utility::flag_wait( "ftue_player_sprinted" );
    ftue_tip::function_953a5a3682bc5957();
    function_aaf270ccbb3047d2( getdvarint( @"hash_c211b7f4a4014a19", 2 ), &function_540e4ead79e757bb, &function_8169022fa2f59336 );
    utility::flag_wait( "ftue_player_tactial_sprinted" );
    ftue_tip::function_953a5a3682bc5957();
    function_de4b9a0be04ea7fc( getdvarint( @"hash_ac9065e141511f57", 2 ), &function_377f40dcc9c6e519, &function_7c77165743d7fa5c );
    utility::flag_wait( "ftue_player_auto_sprinted" );
    ftue_tip::function_953a5a3682bc5957();
    function_38810c43ad5512f9( getdvarint( @"hash_25b38d4a50722d1a", 2 ), &function_c03c3a0ea616a0ae, &function_f1cc08f6b65be507 );
    utility::flag_wait( "ftue_player_moved_camera" );
    ftue_tip::function_953a5a3682bc5957();
    function_a9da423ccb2a437a( getdvarint( @"hash_ee37365ae1bbdbb6", 2 ), &function_684d244dd122c852, &function_1f04fe5260692e63 );
    utility::flag_wait( "ftue_player_moved_camera_and_walked" );
    ftue_tip::function_953a5a3682bc5957();
    function_1b82c90944d9c3ca( firingtargets );
    utility::flag_wait( "ftue_player_fired" );
    ftue_tip::function_953a5a3682bc5957();
    ftue_tip::function_c9cca7ed21647155( #"hash_832d3da8b0e1bea7", 5 );
    self notify( #"ftue_completed" );
}

// Namespace ftue_poc
// Params 3
// Checksum 0xab9b2338, Offset: 0x406
// Size: 0x29
function function_61203f537040b84e( var_5a276fdbbd8bcce9, positivecallback, negativecallback )
{
    thread ftue_movement::function_33e1f59dca0ce78c( var_5a276fdbbd8bcce9, positivecallback, negativecallback );
}

// Namespace ftue_poc
// Params 1
// Checksum 0x91404d85, Offset: 0x437
// Size: 0x18
function function_db46e61b4a5b96e3( player )
{
    utility::flag_set( "ftue_player_walked" );
}

// Namespace ftue_poc
// Params 1
// Checksum 0x3ff5b82c, Offset: 0x457
// Size: 0x20
function function_8a72bbe7f029df76( player )
{
    player ftue_tip::function_c9cca7ed21647155( #"walktip", 5 );
}

// Namespace ftue_poc
// Params 3
// Checksum 0x695da832, Offset: 0x47f
// Size: 0x29
function function_44d94df93b2bb477( var_5a276fdbbd8bcce9, positivecallback, negativecallback )
{
    thread ftue_movement::function_3d0087e7aee586e0( var_5a276fdbbd8bcce9, positivecallback, negativecallback );
}

// Namespace ftue_poc
// Params 1
// Checksum 0xfab206f1, Offset: 0x4b0
// Size: 0x18
function function_9cb46b51076b7d5c( player )
{
    utility::flag_set( "ftue_player_sprinted" );
}

// Namespace ftue_poc
// Params 1
// Checksum 0xae46d0c3, Offset: 0x4d0
// Size: 0x20
function function_8ecab05a6c47ffb5( player )
{
    player ftue_tip::function_c9cca7ed21647155( #"sprinttip", 5 );
}

// Namespace ftue_poc
// Params 3
// Checksum 0xd57fe716, Offset: 0x4f8
// Size: 0x29
function function_aaf270ccbb3047d2( var_5a276fdbbd8bcce9, positivecallback, negativecallback )
{
    thread ftue_movement::function_9d2bda1b7767ca1( var_5a276fdbbd8bcce9, positivecallback, negativecallback );
}

// Namespace ftue_poc
// Params 1
// Checksum 0x2efdbd1c, Offset: 0x529
// Size: 0x20
function function_8169022fa2f59336( player )
{
    player ftue_tip::function_c9cca7ed21647155( #"tacticalsprinttip", 5 );
}

// Namespace ftue_poc
// Params 1
// Checksum 0x20f0fe57, Offset: 0x551
// Size: 0x18
function function_540e4ead79e757bb( player )
{
    utility::flag_set( "ftue_player_tactial_sprinted" );
}

// Namespace ftue_poc
// Params 3
// Checksum 0x2b8f3605, Offset: 0x571
// Size: 0x29
function function_de4b9a0be04ea7fc( var_5a276fdbbd8bcce9, positivecallback, negativecallback )
{
    thread ftue_movement::function_dbcf1c53667ddeef( var_5a276fdbbd8bcce9, positivecallback, negativecallback );
}

// Namespace ftue_poc
// Params 1
// Checksum 0xc5e476c3, Offset: 0x5a2
// Size: 0x20
function function_7c77165743d7fa5c( player )
{
    player ftue_tip::function_c9cca7ed21647155( #"autosprinttip", 5 );
}

// Namespace ftue_poc
// Params 1
// Checksum 0xce3d4b71, Offset: 0x5ca
// Size: 0x18
function function_377f40dcc9c6e519( player )
{
    utility::flag_set( "ftue_player_auto_sprinted" );
}

// Namespace ftue_poc
// Params 3
// Checksum 0xb9a3eb67, Offset: 0x5ea
// Size: 0x29
function function_38810c43ad5512f9( var_5a276fdbbd8bcce9, positivecallback, negativecallback )
{
    thread ftue_movement::function_6fe8b7f4243724ac( var_5a276fdbbd8bcce9, positivecallback, negativecallback );
}

// Namespace ftue_poc
// Params 1
// Checksum 0xfe10be31, Offset: 0x61b
// Size: 0x20
function function_f1cc08f6b65be507( player )
{
    player ftue_tip::function_c9cca7ed21647155( #"movecameratip", 5 );
}

// Namespace ftue_poc
// Params 1
// Checksum 0xf000e296, Offset: 0x643
// Size: 0x18
function function_c03c3a0ea616a0ae( player )
{
    utility::flag_set( "ftue_player_moved_camera" );
}

// Namespace ftue_poc
// Params 3
// Checksum 0x2cb8badb, Offset: 0x663
// Size: 0x29
function function_a9da423ccb2a437a( var_5a276fdbbd8bcce9, positivecallback, negativecallback )
{
    thread ftue_movement::function_f7f64787506e2978( var_5a276fdbbd8bcce9, positivecallback, negativecallback );
}

// Namespace ftue_poc
// Params 1
// Checksum 0x88a6d23, Offset: 0x694
// Size: 0x20
function function_1f04fe5260692e63( player )
{
    player ftue_tip::function_c9cca7ed21647155( #"movecameraandwalktip", 5 );
}

// Namespace ftue_poc
// Params 1
// Checksum 0x3bd4b1e0, Offset: 0x6bc
// Size: 0x18
function function_684d244dd122c852( player )
{
    utility::flag_set( "ftue_player_moved_camera_and_walked" );
}

// Namespace ftue_poc
// Params 1
// Checksum 0x853b213e, Offset: 0x6dc
// Size: 0xac
function function_1b82c90944d9c3ca( firingtargets )
{
    ftue_tip::function_c9cca7ed21647155( #"hash_fb30dff35889cbbf", 5 );
    self.targetcount = firingtargets.size;
    
    foreach ( target in firingtargets )
    {
        target function_c16e954c6341c4d8( self, 0, &function_342b865bb10cd30d );
        target setcandamage( 1 );
    }
}

// Namespace ftue_poc
// Params 3
// Checksum 0x10b1230f, Offset: 0x790
// Size: 0x60
function function_c16e954c6341c4d8( player, useads, damagecallback )
{
    objectivelabel = useads ? &"ftue_mobile/shoot_ads_test" : &"ftue_mobile/shoot_test";
    ftue_objectives::function_86cc57c1dfabee84( self, objectivelabel, "icon_waypoint_objective_general", 5 );
    ftue_firing::function_dc79f33e8ed5962e( player, useads, damagecallback );
}

// Namespace ftue_poc
// Params 1
// Checksum 0xc20e967, Offset: 0x7f8
// Size: 0x6f
function function_342b865bb10cd30d( player )
{
    if ( !isdefined( player.firedshots ) )
    {
        player.firedshots = 0;
    }
    
    ftue_objectives::function_ed97408344737f10( self );
    player.firedshots += 1;
    
    if ( player.firedshots == player.targetcount )
    {
        utility::flag_set( "ftue_player_fired" );
    }
}

