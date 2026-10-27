// scripts\mp\common\powerups\naughty_nice.gsc  (hash_4c7c86ee32e29f1a.gscc) (size: 1957 Bytes / 0x7a5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd4688e4d (3563621965)
// size ...... 1957 (0x7a5)
// includes .. 3   (offset: 0x701)
// strings ... 4   (offset: 0x719)
// dev strs .. 7   (offset: 0x751)
// exports ... 10  (offset: 0x3b1)
// cseg ...... 0x8a + 0x327 (0x3b1)
// imports ... 15  (offset: 0x541)
// animtree1 . 0   (offset: 0x7a5)
// animtree2 . 0   (offset: 0x7a5)
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\mp\common\powerups\powerups;

#namespace naughty_nice;

// Namespace naughty_nice
// Params 0, eflags: 0x1
// Checksum 0xfd8983ad, Offset: 0xa8
// Size: 0x9
function autoexec main()
{
    init_naughty_nice();
}

// Namespace naughty_nice
// Params 0
// Checksum 0xaaaf9243, Offset: 0xb9
// Size: 0x35
function init_naughty_nice()
{
    powerups::register_powerup( "naughty_nice", &function_f265a1321964bfbb );
    powerups::register_powerup( "naughty", &grab_naughty );
    powerups::register_powerup( "nice", &grab_nice );
}

/#

    // Namespace naughty_nice
    // Params 0, eflags: 0x4
    // Checksum 0x6e85010a, Offset: 0xf6
    // Size: 0x19, Type: dev
    function private post_main_naughty_nice()
    {
        assert( isdefined( level.var_b76d1ff442b64065 ), "<dev string:x24>" );
    }

#/

// Namespace naughty_nice
// Params 2
// Checksum 0x4ce6c749, Offset: 0x117
// Size: 0x3a
function function_f265a1321964bfbb( str_powerup, ent_powerup )
{
    if ( randomint( 100 ) < 65 )
    {
        function_e117a79da1e45047( self, str_powerup, ent_powerup );
        return;
    }
    
    function_a48520426af5930c( self, str_powerup, ent_powerup );
}

// Namespace naughty_nice
// Params 2
// Checksum 0x3f549f09, Offset: 0x159
// Size: 0x20
function grab_naughty( str_powerup, ent_powerup )
{
    function_a48520426af5930c( self, str_powerup, ent_powerup );
}

// Namespace naughty_nice
// Params 2
// Checksum 0x7d15710f, Offset: 0x181
// Size: 0x20
function grab_nice( str_powerup, ent_powerup )
{
    function_e117a79da1e45047( self, str_powerup, ent_powerup );
}

// Namespace naughty_nice
// Params 3, eflags: 0x4
// Checksum 0xebe42c3c, Offset: 0x1a9
// Size: 0x10f
function private function_e117a79da1e45047( var_f68dba34cd3fc5b5, str_powerup, ent_powerup )
{
    /#
        iprintlnbold( "<dev string:x5d>" );
    #/
    
    assert( isdefined( level.naughty_nice_funcs[ "<dev string:x62>" ] ), "<dev string:x67>" );
    a_players = powerups::get_powerup_players( str_powerup );
    
    foreach ( player in a_players )
    {
        player thread powerups_cpmp::function_52318afc13635e7c( str_powerup );
    }
    
    var_1c648b526b53529d = { #ent_powerup:ent_powerup, #str_powerup:str_powerup, #var_f68dba34cd3fc5b5:var_f68dba34cd3fc5b5 };
    self thread [[ level.naughty_nice_funcs[ "nice" ] ]]( self, var_1c648b526b53529d );
}

// Namespace naughty_nice
// Params 3, eflags: 0xc
// Checksum 0xd43f56aa, Offset: 0x2c0
// Size: 0xa4
function private function_a48520426af5930c( var_f68dba34cd3fc5b5, str_powerup, ent_powerup )
{
    self notify( #"hash_fd65ed7a27c792c0" );
    self endon( #"hash_fd65ed7a27c792c0" );
    
    /#
        iprintlnbold( "<dev string:xa5>" );
    #/
    
    assert( isdefined( level.naughty_nice_funcs[ "<dev string:xad>" ] ), "<dev string:xb5>" );
    var_1c648b526b53529d = { #ent_powerup:ent_powerup, #str_powerup:str_powerup, #var_f68dba34cd3fc5b5:var_f68dba34cd3fc5b5 };
    self thread [[ level.naughty_nice_funcs[ "naughty" ] ]]( self, var_1c648b526b53529d );
}

// Namespace naughty_nice
// Params 2
// Checksum 0xead99588, Offset: 0x36c
// Size: 0x45
function set_naughty( str_powerup, var_31688a0f3073df86 )
{
    self notify( #"hash_21c816e061e62f08" );
    self endon( #"hash_21c816e061e62f08" );
    thread powerups_cpmp::function_52318afc13635e7c( str_powerup, var_31688a0f3073df86 );
    utility::waittill_any_timeout( var_31688a0f3073df86, "end_naughty" );
}

