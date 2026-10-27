// script_25f64b14bea02408  (hash_25f64b14bea02408.gscc) (size: 3460 Bytes / 0xd84 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x48dc41e1 (1222394337)
// size ...... 3460 (0xd84)
// includes .. 2   (offset: 0xbdc)
// strings ... 33  (offset: 0xbec)
// dev strs .. 1   (offset: 0xd78)
// exports ... 10  (offset: 0x89c)
// cseg ...... 0x49a + 0x402 (0x89c)
// imports ... 13  (offset: 0xa2c)
// animtree1 . 0   (offset: 0xd84)
// animtree2 . 0   (offset: 0xd84)
#using script_26f456dbdf9aa216;
#using scripts\anim\dialogue;

#namespace clear_lkp;

// Namespace clear_lkp
// Params 1
// Checksum 0x120bf51, Offset: 0x4b8
// Size: 0xb6
function getfunction( funcid )
{
    switch ( funcid )
    {
        case #"hash_f4ef887f81fa60d9":
            return &function_389783bac1e5cfce;
        case #"hash_47b3d8e9cd6ccd4a":
            return &function_323d874e6bdc218b;
        case #"hash_871307852fe531bf":
            return &function_f2b49cf03a71061e;
        case #"hash_4bc3c13aae411fc":
            return &function_77665c010b74bf65;
        case #"hash_bf509799ad09e3fb":
            return &function_b4c8cc8d02ad0b95;
        case #"hash_cfc7861edb6bdc95":
            return &function_dabb6663ba0a5177;
        case #"hash_bb5cf3d8738e8519":
            return &playdialog;
        case #"hash_80804c8d4d60b774":
            return &namespace_f9e15975f25db152::function_f5f982ce9e32c830;
    }
    
    assertmsg( "<dev string:x24>" + funcid );
}

// Namespace clear_lkp
// Params 1
// Checksum 0xb25a29d1, Offset: 0x576
// Size: 0x21
function function_b4c8cc8d02ad0b95( interactionid )
{
    self.battlechatterallowed = 0;
    self.var_21435b7177552b48 = 1;
}

// Namespace clear_lkp
// Params 1
// Checksum 0xeaf2cd80, Offset: 0x59f
// Size: 0x36
function function_dabb6663ba0a5177( interactionid )
{
    self.battlechatterallowed = 1;
    self.balwayscoverexposed = 1;
    self.var_21435b7177552b48 = 0;
    self.lastenemysightpos = undefined;
}

// Namespace clear_lkp
// Params 1
// Checksum 0x5ad2b44d, Offset: 0x5dd
// Size: 0x1b
function function_389783bac1e5cfce( statename )
{
    thread function_79d562486b0c13e3( statename, randomfloat( 2 ) );
}

// Namespace clear_lkp
// Params 1
// Checksum 0x463ceca3, Offset: 0x600
// Size: 0x16
function function_323d874e6bdc218b( statename )
{
    self.balwayscoverexposed = 0;
}

// Namespace clear_lkp
// Params 1
// Checksum 0xfc372074, Offset: 0x61e
// Size: 0x29
function function_f2b49cf03a71061e( statename )
{
    assert( isdefined( self.stealth ) );
    self.var_39f0918bb658b9f7 = 1;
}

// Namespace clear_lkp
// Params 1
// Checksum 0xc51077d, Offset: 0x64f
// Size: 0x28
function function_77665c010b74bf65( statename )
{
    assert( isdefined( self.stealth ) );
    self.var_39f0918bb658b9f7 = 0;
}

// Namespace clear_lkp
// Params 2
// Checksum 0xcf375418, Offset: 0x67f
// Size: 0x46
function function_79d562486b0c13e3( statename, t )
{
    self endon( #"death" );
    self endon( #"lkp_user_removed" );
    self endon( statename + "_bseq_finished" );
    wait t;
    self.balwayscoverexposed = 1;
}

// Namespace clear_lkp
// Params 2
// Checksum 0xdc098d05, Offset: 0x6cd
// Size: 0x1cf
function playdialog( statename, params )
{
    assert( params.size == 1 );
    dialog = params[ 0 ];
    
    if ( dialog == "hold_fire_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_hold_fire_order" );
        return;
    }
    
    if ( dialog == "where_is_he_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_target_location_ask" );
        return;
    }
    
    if ( dialog == "he_was_just_here_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_target_lost_generic" );
        return;
    }
    
    if ( dialog == "3_1_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_3_1_generic" );
        return;
    }
    
    if ( dialog == "move_in_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_check_last_known_order" );
        return;
    }
    
    if ( dialog == "everyone_else_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_everyone_else_generic" );
        return;
    }
    
    if ( dialog == "hold_position_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_hold_position_order" );
        return;
    }
    
    if ( dialog == "checkin_it_out_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_checking_last_known_reply" );
        return;
    }
    
    if ( dialog == "area_is_clear_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_area_clear_inform" );
        return;
    }
    
    if ( dialog == "he_is_gone_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_enemy_gone_inform" );
        return;
    }
    
    if ( dialog == "he_is_close_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_target_near_inform" );
        return;
    }
    
    if ( dialog == "split_up_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_start_search_order" );
        return;
    }
    
    if ( dialog == "cover_me_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_order_ally_coverme" );
        return;
    }
    
    if ( dialog == "covering_fire_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_inform_self_covering_ally" );
        return;
    }
    
    if ( dialog == "harris_is_moving_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_inform_self_covering_ally_harris" );
        return;
    }
    
    if ( dialog == "i_will_cover_you_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_inform_self_covering_you" );
    }
}

