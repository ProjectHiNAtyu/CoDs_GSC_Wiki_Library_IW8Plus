// scripts\autotests\mp\autotests_utility_video.gsc  (hash_410be767a7cf83aa.gscc) (size: 4358 Bytes / 0x1106 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa55aec85 (2774199429)
// size ...... 4358 (0x1106)
// includes .. 7   (offset: 0xf8a)
// strings ... 19  (offset: 0xfc2)
// dev strs .. 3   (offset: 0x10e2)
// exports ... 8   (offset: 0xa9e)
// cseg ...... 0x204 + 0x89a (0xa9e)
// imports ... 30  (offset: 0xbde)
// animtree1 . 0   (offset: 0x1106)
// animtree2 . 0   (offset: 0x1106)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\operator;

#namespace autotests_utility_video;

// Namespace autotests_utility_video
// Params 0
// Checksum 0xa69a66e3, Offset: 0x222
// Size: 0xfc
function function_5826175e5df28fd8()
{
    autotests::set_dvar( @"hash_edd37bf430a00f26", 1 );
    autotests::set_dvar( @"hash_5fdf364fef6ac4d0", 1 );
    autotests::set_dvar( @"scr_autopilot_hud", 0 );
    autotests::set_dvar( @"br_minplayers", 10 );
    autotests::set_dvar( @"hash_b11f030e3dc6e3ff", 0 );
    autotests::set_dvar( @"hash_d95f6cfac74fa872", 1 );
    function_3abe1f9532a7887b( "devSetOmnvar ui_hide_minimap 1" );
    level.autotests.test_runtime.disable_hud_prints = 1;
    function_3abe1f9532a7887b( "set cg_drawAutotestResultPanel 0" );
    function_3abe1f9532a7887b( "exec demo.cfg" );
    autotests::function_5c8c87763724c132();
    player = autotests_utility_player::get_player();
    
    if ( game_utility::getmapname() == "mp_saw_cleanroom" )
    {
        player setplayerangles( ( 0, 180, 0 ) );
        player test_setorigin( ( -3309, -2047, 58 ) );
    }
}

// Namespace autotests_utility_video
// Params 0
// Checksum 0xc23d446b, Offset: 0x326
// Size: 0x20
function function_2bddeed61c9c1561()
{
    function_3abe1f9532a7887b( "exec demo_undo.cfg" );
    function_3abe1f9532a7887b( "devSetOmnvar ui_hide_minimap 0" );
    function_3abe1f9532a7887b( "set cg_drawAutotestResultPanel 1" );
}

// Namespace autotests_utility_video
// Params 1
// Checksum 0x79b83403, Offset: 0x34e
// Size: 0x15
function test_setorigin( origin )
{
    autotests_utility_player::set_player_position( origin );
}

// Namespace autotests_utility_video
// Params 1
// Checksum 0xbb96b5ff, Offset: 0x36b
// Size: 0x8d
function function_2083bbbdfedfe07e( bundle )
{
    foreach ( player in level.players )
    {
        function_bdc5139799504032( player, function_d9074e744fa5c825( bundle ) );
    }
}

// Namespace autotests_utility_video
// Params 1
// Checksum 0x84139ad6, Offset: 0x400
// Size: 0x43
function function_fa5160f0e09f8bf9( bundle )
{
    skin = function_d9074e744fa5c825( bundle );
    
    if ( !isdefined( skin ) )
    {
        iprintlnbold( "No fixed skin found for project: " + autotests_utility::function_2da7d4694fda2fdd() );
        return;
    }
    
    function_bdc5139799504032( self, skin );
}

// Namespace autotests_utility_video
// Params 1
// Checksum 0x440187ec, Offset: 0x44b
// Size: 0x5e
function function_d9074e744fa5c825( bundle )
{
    if ( isbrgamemode() )
    {
        assert( bundle.var_4d4f91f132dc769d, "<dev string:x24>" );
        return bundle.var_4d4f91f132dc769d;
    }
    
    assert( bundle.fixedoperatorskin, "<dev string:x57>" );
    return bundle.fixedoperatorskin;
}

// Namespace autotests_utility_video
// Params 2
// Checksum 0xd567a992, Offset: 0x4b1
// Size: 0x5ed
function function_bdc5139799504032( player, skin )
{
    assert( isxhashasset( skin ), "<dev string:x87>" );
    operator = operator::function_30f20ce375c4ee40( skin );
    
    if ( !isdefined( operator ) )
    {
        iprintlnbold( "Can't get operatorRef asset for skin: " + skin + "\n" );
        return;
    }
    
    player operator::createoperatorcustomization( operator, skin );
    player utility::callsharedfunc( #"bodysize", #"hash_9199843bbf95cbf8" );
    gender = operator::getoperatorgender( operator );
    clothtype = operator::function_b1788ccf1b3c0ae9( skin );
    geartype = operator::function_d633420b529828e8( skin );
    player player::_setsuit( player.operatorcustomization.suit, 1 );
    
    if ( isdefined( player.operatorcustomization.reactiveoperator ) && player.operatorcustomization.reactiveoperator != "" )
    {
        player function_184d7ec010cfaa92( player.operatorcustomization.reactiveoperator );
    }
    
    player notify( #"set_operator" );
    
    if ( gender == "female" )
    {
        player setclientgender( "female" );
        player.operatorcustomization.gender = "female";
    }
    else
    {
        player setclientgender( "" );
        player.operatorcustomization.gender = "male";
    }
    
    if ( player.operatorcustomization.skinref == "nova_eastern_champions" )
    {
        player setentitysoundcontext( "gender", "gasmask_female" );
        player.operatorcustomization.gender = "female";
    }
    
    if ( player.operatorcustomization.skinref == "gromsko_western_weedlove" )
    {
        player setentitysoundcontext( "gender", "bongmask_male" );
        player.operatorcustomization.gender = "male";
    }
    
    if ( player.operatorcustomization.skinref == "jup_mp_oscar_19_skin" )
    {
        player setentitysoundcontext( "gender", "bongmask_male" );
        player.operatorcustomization.gender = "male";
    }
    
    if ( isdefined( clothtype ) && clothtype != "" )
    {
        if ( player.operatorcustomization.clothtype == clothtype )
        {
        }
        
        if ( !isdefined( player.operatorcustomization ) )
        {
            player.operatorcustomization = "";
        }
        
        if ( !isdefined( player.operatorcustomization.clothtype ) )
        {
            player.operatorcustomization.clothtype = "";
        }
        
        if ( isdefined( player.operatorcustomization.clothtype ) && player.operatorcustomization.clothtype != clothtype )
        {
            player.operatorcustomization.clothtype = clothtype;
            
            foreach ( _player in level.players )
            {
                _player setclothtype( getxhash( clothtype ) );
            }
        }
    }
    else
    {
        foreach ( _player in level.players )
        {
            _player setclothtype( #"vestlight" );
        }
    }
    
    if ( isdefined( geartype ) && geartype != "" )
    {
        if ( player.operatorcustomization.geartype == geartype )
        {
        }
        
        if ( !isdefined( player.operatorcustomization ) )
        {
            player.operatorcustomization = "";
        }
        
        if ( !isdefined( player.operatorcustomization.geartype ) )
        {
            player.operatorcustomization.geartype = "";
        }
        
        if ( isdefined( player.operatorcustomization.geartype ) && player.operatorcustomization.geartype != geartype )
        {
            player.operatorcustomization.geartype = geartype;
            
            foreach ( _player in level.players )
            {
                _player setgeartype( getxhash( geartype ) );
            }
        }
    }
    else
    {
        foreach ( _player in level.players )
        {
            _player setgeartype( #"millghtgr" );
        }
    }
    
    player function_223c4fc6696d52a7();
}

