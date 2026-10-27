// script_3d4d21be240d486c  (hash_3d4d21be240d486c.gscc) (size: 2007 Bytes / 0x7d7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3c44cc45 (1011141701)
// size ...... 2007 (0x7d7)
// includes .. 2   (offset: 0x767)
// strings ... 7   (offset: 0x777)
// dev strs .. 1   (offset: 0x7cb)
// exports ... 10  (offset: 0x45b)
// cseg ...... 0x1ab + 0x2b0 (0x45b)
// imports ... 13  (offset: 0x5eb)
// animtree1 . 0   (offset: 0x7d7)
// animtree2 . 0   (offset: 0x7d7)
#using script_26f456dbdf9aa216;
#using scripts\anim\dialogue;

#namespace clear_lkp_one_member;

// Namespace clear_lkp_one_member
// Params 1
// Checksum 0x57eaf0e1, Offset: 0x1c9
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

// Namespace clear_lkp_one_member
// Params 1
// Checksum 0xe4906661, Offset: 0x287
// Size: 0x21
function function_b4c8cc8d02ad0b95( interactionid )
{
    self.battlechatterallowed = 0;
    self.var_21435b7177552b48 = 1;
}

// Namespace clear_lkp_one_member
// Params 1
// Checksum 0xbc388230, Offset: 0x2b0
// Size: 0x36
function function_dabb6663ba0a5177( interactionid )
{
    self.battlechatterallowed = 1;
    self.balwayscoverexposed = 1;
    self.var_21435b7177552b48 = 0;
    self.lastenemysightpos = undefined;
}

// Namespace clear_lkp_one_member
// Params 1
// Checksum 0xc18fbfd, Offset: 0x2ee
// Size: 0x1b
function function_389783bac1e5cfce( statename )
{
    thread function_79d562486b0c13e3( statename, randomfloat( 2 ) );
}

// Namespace clear_lkp_one_member
// Params 1
// Checksum 0x10f6a313, Offset: 0x311
// Size: 0x16
function function_323d874e6bdc218b( statename )
{
    self.balwayscoverexposed = 0;
}

// Namespace clear_lkp_one_member
// Params 1
// Checksum 0xfabe035d, Offset: 0x32f
// Size: 0x29
function function_f2b49cf03a71061e( statename )
{
    assert( isdefined( self.stealth ) );
    self.var_39f0918bb658b9f7 = 1;
}

// Namespace clear_lkp_one_member
// Params 1
// Checksum 0xad82454, Offset: 0x360
// Size: 0x28
function function_77665c010b74bf65( statename )
{
    assert( isdefined( self.stealth ) );
    self.var_39f0918bb658b9f7 = 0;
}

// Namespace clear_lkp_one_member
// Params 2
// Checksum 0x99fd1ba8, Offset: 0x390
// Size: 0x46
function function_79d562486b0c13e3( statename, t )
{
    self endon( #"death" );
    self endon( #"lkp_user_removed" );
    self endon( statename + "_bseq_finished" );
    wait t;
    self.balwayscoverexposed = 1;
}

// Namespace clear_lkp_one_member
// Params 2
// Checksum 0xc0aa449a, Offset: 0x3de
// Size: 0x7d
function playdialog( statename, params )
{
    assert( params.size == 1 );
    dialog = params[ 0 ];
    
    if ( dialog == "he_was_just_here_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_target_lost_generic" );
        return;
    }
    
    if ( dialog == "checkin_it_out_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_checking_last_known_reply" );
        return;
    }
    
    if ( dialog == "he_is_gone_dialog" )
    {
        dialogue::say( "dx_cbc_usm1_enemy_gone_inform" );
    }
}

