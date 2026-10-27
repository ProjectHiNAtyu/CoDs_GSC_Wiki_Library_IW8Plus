// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ltm_startroom.gsc  (hash_7ef17c442d76c9b9.gscc) (size: 1952 Bytes / 0x7a0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xafe51589 (2951026057)
// size ...... 1952 (0x7a0)
// includes .. 4   (offset: 0x720)
// strings ... 6   (offset: 0x740)
// dev strs .. 2   (offset: 0x788)
// exports ... 8   (offset: 0x3b0)
// cseg ...... 0x112 + 0x29e (0x3b0)
// imports ... 19  (offset: 0x4f0)
// animtree1 . 0   (offset: 0x7a0)
// animtree2 . 0   (offset: 0x7a0)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\doorbuy;
#using scripts\mp\zm\gametypes\zm_rb_startroom_sat;

#namespace zm_sat_scarab_ltm_startroom;

// Namespace zm_sat_scarab_ltm_startroom
// Params 0, eflags: 0x5
// Checksum 0x1cf450d8, Offset: 0x130
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"zm_rb_startroom_sat_scarab", #"zm_rb_startroom_sat", &pre_main, &post_main );
}

// Namespace zm_sat_scarab_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0xe2cf1e07, Offset: 0x15d
// Size: 0x21
function private pre_main()
{
    if ( !zm_rb_startroom_sat::is_mode_startroom() )
    {
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    function_e03c3a28d693ea59();
}

// Namespace zm_sat_scarab_ltm_startroom
// Params 0, eflags: 0x4
// Checksum 0xa1f9ed5c, Offset: 0x186
// Size: 0x22
function private post_main()
{
    if ( !zm_rb_startroom_sat::is_mode_startroom() )
    {
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x45>" );
    #/
    
    level thread function_35d4896326fa4e79();
}

// Namespace zm_sat_scarab_ltm_startroom
// Params 0
// Checksum 0xe1d9b2da, Offset: 0x1b0
// Size: 0x38
function function_e03c3a28d693ea59()
{
    level utility::flag_set( "only_scarab_phone_visuals" );
    utility::registersharedfunc( #"zombie", #"hash_ba1f273364ecd5ca", &function_78b93332b0cab973 );
    level.var_73a9d94b186eeab5 = 1;
}

// Namespace zm_sat_scarab_ltm_startroom
// Params 0
// Checksum 0x373b163a, Offset: 0x1f0
// Size: 0x4d
function function_35d4896326fa4e79()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "doorbuy_init_complete" );
    function_8a6e905f9cc4fb6a( "doorbuy_safehouse_bedroom_1" );
    function_8a6e905f9cc4fb6a( "doorbuy_safehouse_bedroom_2" );
    level utility::flag_set( "safehouse_bedroom_1_door_bought" );
    level utility::flag_set( "safehouse_bedroom_2_door_bought" );
}

// Namespace zm_sat_scarab_ltm_startroom
// Params 1, eflags: 0x4
// Checksum 0x92b31685, Offset: 0x245
// Size: 0xc5
function private function_8a6e905f9cc4fb6a( str_targetname )
{
    a_doors = getentitylessscriptablearray( str_targetname, #targetname );
    a_doors = arraycombineunique( a_doors, getscriptablearray( str_targetname, #targetname ) );
    a_doors = arraycombineunique( a_doors, getentarray( str_targetname, #targetname ) );
    
    foreach ( door in a_doors )
    {
        door thread doorbuy::function_f3160e450543b4f1();
    }
}

// Namespace zm_sat_scarab_ltm_startroom
// Params 1, eflags: 0x4
// Checksum 0xe9f0e3dc, Offset: 0x312
// Size: 0x9e
function private function_78b93332b0cab973( var_1bbb5557537e2c0c )
{
    foreach ( var_349a0723ed9ac19c in var_1bbb5557537e2c0c )
    {
        if ( utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", var_349a0723ed9ac19c.origin ) )
        {
            return var_349a0723ed9ac19c;
        }
    }
}

