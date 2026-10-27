// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_simon.gsc  (hash_5d7a39b20bb114a3.gscc) (size: 10165 Bytes / 0x27b5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe5a148d3 (3852552403)
// size ...... 10165 (0x27b5)
// includes .. 9   (offset: 0x255d)
// strings ... 33  (offset: 0x25a5)
// dev strs .. 0   (offset: 0x27b5)
// exports ... 33  (offset: 0x15f1)
// cseg ...... 0x309 + 0x12e8 (0x15f1)
// imports ... 78  (offset: 0x1b19)
// animtree1 . 0   (offset: 0x27b5)
// animtree2 . 0   (offset: 0x27b5)
#using scripts\common\powerups;
#using scripts\common\status_effects\effect_stun;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\interaction;
#using scripts\mp\pack_a_punch;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_simon_cs;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;

#namespace zm_sat_ruby_ee_simon;

// Namespace zm_sat_ruby_ee_simon
// Params 0, eflags: 0x5
// Checksum 0x81b43e5b, Offset: 0x327
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"ruby_ee_simon", #"zm_quest", &function_a97922e00a94965a, &function_ca4b3897383b426b );
}

// Namespace zm_sat_ruby_ee_simon
// Params 0, eflags: 0x4
// Checksum 0x89b65ff7, Offset: 0x354
// Size: 0x1c8
function private function_a97922e00a94965a()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    level.ruby_ee_simon = zm_quest::get_quest( #"ruby_ee_simon" );
    zm_quest::register_quest_step( #"ruby_ee_simon", #"find_skulls", &setup_find_skulls );
    zm_quest::register_quest_step( #"ruby_ee_simon", #"hash_47a8d4b74bada0e4", &function_5ef5d0ad44d36f99 );
    zm_quest::register_quest_step( #"ruby_ee_simon", #"hash_6fb5672f9fa41086", &function_5c708a219d7a9211, &function_ae6ba54bd1447773 );
    zm_quest::register_quest_step( #"ruby_ee_simon", #"hash_47a8d7b74bada5fd", &function_5ef5cdad44d36900 );
    zm_quest::register_quest_step( #"ruby_ee_simon", #"hash_6fb5662f9fa40ed3", &function_5c7087219d7a8b78, &function_ae6ba64bd14479a6 );
    zm_quest::register_quest_step( #"ruby_ee_simon", #"hash_47a8d6b74bada44a", &function_5ef5cead44d36b33 );
    zm_quest::register_quest_step( #"ruby_ee_simon", #"hash_6fb5652f9fa40d20", &function_5c7088219d7a8dab, &function_ae6ba74bd1447bd9 );
    zm_quest::register_quest_step( #"ruby_ee_simon", #"hash_47a8d1b74bad9bcb", &function_5ef5d3ad44d37632 );
    zm_quest::register_quest_step( #"ruby_ee_simon", #"hash_6fb56c2f9fa41905", &function_5c708d219d7a98aa, &function_ae6ba84bd1447e0c );
    zm_quest::register_quest_step( #"ruby_ee_simon", #"hash_47a8d0b74bad9a18", &function_5ef5d4ad44d37865 );
    zm_quest::register_quest_step( #"ruby_ee_simon", #"hash_6fb56b2f9fa41752", &function_5c708e219d7a9add, &function_ae6ba94bd144803f );
    zm_quest::register_quest_step( #"ruby_ee_simon", #"hash_f24a01d7548516f", &function_640a0a6b41c75bd7 );
    zm_sat_ruby_ee_simon_cs::main();
}

// Namespace zm_sat_ruby_ee_simon
// Params 0, eflags: 0x4
// Checksum 0x463c9833, Offset: 0x524
// Size: 0x40
function private function_ca4b3897383b426b()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"ruby_ee_simon" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0xf492f150, Offset: 0x56c
// Size: 0x34
function private setup_find_skulls( b_skipped, b_save_restored )
{
    level.ruby_ee_simon.var_6eacfbdbfe3f9b61 = utility::getstructarray( "ruby_ee_simon" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0xa9a03f4d, Offset: 0x5a8
// Size: 0x57
function private function_5ef5d0ad44d36f99( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        return;
    }
    
    skull = get_skull_ent( 1 );
    skull function_fd8a994ef8ddf61b();
    interaction::register_scriptable_interact( skull getlinkedscriptableinstance(), &function_e4f169aa6ae8da );
    level utility::flag_wait( "ruby_ee_simon_found_1" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0x190261a6, Offset: 0x607
// Size: 0x31
function private function_5c708a219d7a9211( b_skipped, b_save_restored )
{
    get_skull_ent( 1 ) take_skull();
    level utility::flag_wait( "ruby_ee_simon_placed_1" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0xe8a3d84d, Offset: 0x640
// Size: 0x31
function private function_ae6ba54bd1447773( b_skipped, b_save_restored )
{
    get_skull_ent( 1 ) place_skull();
    level utility::flag_set( "ruby_ee_simon_placed_1" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0xa9a03f4e, Offset: 0x679
// Size: 0x57
function private function_5ef5cdad44d36900( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        return;
    }
    
    skull = get_skull_ent( 2 );
    skull function_fd8a994ef8ddf61b();
    interaction::register_scriptable_interact( skull getlinkedscriptableinstance(), &function_e4f169aa6ae8da );
    level utility::flag_wait( "ruby_ee_simon_found_2" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0x190261a5, Offset: 0x6d8
// Size: 0x31
function private function_5c7087219d7a8b78( b_skipped, b_save_restored )
{
    get_skull_ent( 2 ) take_skull();
    level utility::flag_wait( "ruby_ee_simon_placed_2" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0xe8a3d84e, Offset: 0x711
// Size: 0x31
function private function_ae6ba64bd14479a6( b_skipped, b_save_restored )
{
    get_skull_ent( 2 ) place_skull();
    level utility::flag_set( "ruby_ee_simon_placed_2" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0xa9a03f4f, Offset: 0x74a
// Size: 0x57
function private function_5ef5cead44d36b33( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        return;
    }
    
    skull = get_skull_ent( 3 );
    skull function_fd8a994ef8ddf61b();
    interaction::register_scriptable_interact( skull getlinkedscriptableinstance(), &function_e4f169aa6ae8da );
    level utility::flag_wait( "ruby_ee_simon_found_3" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0x190261a4, Offset: 0x7a9
// Size: 0x31
function private function_5c7088219d7a8dab( b_skipped, b_save_restored )
{
    get_skull_ent( 3 ) take_skull();
    level utility::flag_wait( "ruby_ee_simon_placed_3" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0xe8a3d84f, Offset: 0x7e2
// Size: 0x31
function private function_ae6ba74bd1447bd9( b_skipped, b_save_restored )
{
    get_skull_ent( 3 ) place_skull();
    level utility::flag_set( "ruby_ee_simon_placed_3" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0xa9a03f48, Offset: 0x81b
// Size: 0x57
function private function_5ef5d3ad44d37632( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        return;
    }
    
    skull = get_skull_ent( 4 );
    skull function_fd8a994ef8ddf61b();
    interaction::register_scriptable_interact( skull getlinkedscriptableinstance(), &function_e4f169aa6ae8da );
    level utility::flag_wait( "ruby_ee_simon_found_4" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0x190261a3, Offset: 0x87a
// Size: 0x31
function private function_5c708d219d7a98aa( b_skipped, b_save_restored )
{
    get_skull_ent( 4 ) take_skull();
    level utility::flag_wait( "ruby_ee_simon_placed_4" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0xe8a3d848, Offset: 0x8b3
// Size: 0x31
function private function_ae6ba84bd1447e0c( b_skipped, b_save_restored )
{
    get_skull_ent( 4 ) place_skull();
    level utility::flag_set( "ruby_ee_simon_placed_4" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0xa9a03f49, Offset: 0x8ec
// Size: 0x57
function private function_5ef5d4ad44d37865( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        return;
    }
    
    skull = get_skull_ent( 5 );
    skull function_fd8a994ef8ddf61b();
    interaction::register_scriptable_interact( skull getlinkedscriptableinstance(), &function_e4f169aa6ae8da );
    level utility::flag_wait( "ruby_ee_simon_found_5" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0x190261a2, Offset: 0x94b
// Size: 0x31
function private function_5c708e219d7a9add( b_skipped, b_save_restored )
{
    get_skull_ent( 5 ) take_skull();
    level utility::flag_wait( "ruby_ee_simon_placed_5" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0xe8a3d849, Offset: 0x984
// Size: 0x31
function private function_ae6ba94bd144803f( b_skipped, b_save_restored )
{
    get_skull_ent( 5 ) place_skull();
    level utility::flag_set( "ruby_ee_simon_placed_5" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 1, eflags: 0x4
// Checksum 0x9a047b93, Offset: 0x9bd
// Size: 0xa9
function private get_skull_ent( str_id )
{
    a_skulls = getentarray( "ruby_ee_simon", #targetname );
    
    foreach ( skull in a_skulls )
    {
        if ( skull.script_noteworthy == string( str_id ) )
        {
            return skull;
        }
    }
}

// Namespace zm_sat_ruby_ee_simon
// Params 0, eflags: 0x4
// Checksum 0x3945bae9, Offset: 0xa6e
// Size: 0xc8
function private function_fd8a994ef8ddf61b()
{
    self setcandamage( 1 );
    
    while ( self )
    {
        self waittill( #"damage", iamount, eattacker, vdirection, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon );
        
        if ( isplayer( eattacker ) && objweapon && eattacker pack_a_punch::get_pap_level( objweapon ) )
        {
            self setcandamage( 0 );
            self setscriptablepartstate( "vfx", "on" );
            self setscriptablepartstate( "usable", "on" );
            return;
        }
    }
}

// Namespace zm_sat_ruby_ee_simon
// Params 1, eflags: 0x4
// Checksum 0xa922156e, Offset: 0xb3e
// Size: 0x60
function private function_e4f169aa6ae8da( player )
{
    skull = self function_f911103fc8a0b6e7();
    
    if ( !level utility::flag( "ruby_ee_simon_found_" + skull.script_noteworthy ) )
    {
        player playsoundtoplayer( "uin_zm_common_pickup_item", player );
        level utility::flag_set( "ruby_ee_simon_found_" + skull.script_noteworthy );
    }
}

// Namespace zm_sat_ruby_ee_simon
// Params 0, eflags: 0x4
// Checksum 0x9231d5be, Offset: 0xba6
// Size: 0xfa
function private take_skull()
{
    self setscriptablepartstate( "vfx", "off" );
    self setscriptablepartstate( "usable", "off" );
    self hide();
    var_e22f0b8067281f5f = utility::array_get_first_item( level.ruby_ee_simon.var_6eacfbdbfe3f9b61 );
    level.ruby_ee_simon.var_6eacfbdbfe3f9b61[ 0 ] = undefined;
    function_cdc669dbc8ea2101( level.ruby_ee_simon.var_6eacfbdbfe3f9b61 );
    self.var_e22f0b8067281f5f = var_e22f0b8067281f5f;
    self.origin = var_e22f0b8067281f5f.origin;
    self.angles = var_e22f0b8067281f5f.angles;
    scriptable = self getlinkedscriptableinstance();
    scriptable.var_d8e3b07237845727 = undefined;
    interact = zm_quest::function_91f9590e98d57ff6( var_e22f0b8067281f5f.origin, &function_ebf166af0bacbd86, undefined, "hidden" );
    interact.skull = self;
}

// Namespace zm_sat_ruby_ee_simon
// Params 1, eflags: 0x4
// Checksum 0x20bac737, Offset: 0xca8
// Size: 0x66
function private function_ebf166af0bacbd86( player )
{
    if ( !level utility::flag( "ruby_ee_simon_placed_" + self.skull.script_noteworthy ) )
    {
        player playsoundtoplayer( "evt_item_placed_generic", player );
        level utility::flag_set( "ruby_ee_simon_placed_" + self.skull.script_noteworthy );
    }
    
    waitframe();
    self freescriptable();
}

// Namespace zm_sat_ruby_ee_simon
// Params 0, eflags: 0x4
// Checksum 0x2e415f1e, Offset: 0xd16
// Size: 0x8
function private place_skull()
{
    self show();
}

// Namespace zm_sat_ruby_ee_simon
// Params 2, eflags: 0x4
// Checksum 0xf432ccd7, Offset: 0xd26
// Size: 0x22c
function private function_640a0a6b41c75bd7( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        return;
    }
    
    a_skulls = getentarray( "ruby_ee_simon", #targetname );
    function_887b423538c7749b( a_skulls );
    
    do
    {
        function_58e64533eb116112( a_skulls );
    }
    while ( level utility::flag( "ruby_ee_simon_fail" ) );
    
    var_2d5456699ef764c6 = utility::getstruct( "ruby_ee_simon_reward" ).origin + ( 0, 0, 24 );
    
    foreach ( skull in a_skulls )
    {
        skull playsoundonmovingent( "evt_ruby_ee_skull_final_scream" );
        skull setscriptablepartstate( "vfx", "on" );
        skull moveto( var_2d5456699ef764c6, 3, 2.5 );
        skull vibrate( ( 1, 1, 1 ), 2, 0.1, 3 );
    }
    
    wait 3;
    
    foreach ( player in level.players )
    {
        player playsoundtoplayer( "evt_ee_complete_success_stinger", player );
    }
    
    foreach ( skull in a_skulls )
    {
        skull delete();
    }
    
    powerups::powerup_drop( "free_perk", var_2d5456699ef764c6, -1 );
}

// Namespace zm_sat_ruby_ee_simon
// Params 1, eflags: 0x4
// Checksum 0xf5491880, Offset: 0xf5a
// Size: 0x120
function private function_887b423538c7749b( a_skulls )
{
    foreach ( skull in a_skulls )
    {
        wait randomfloatrange( 0.3, 0.5 );
        skull setscriptablepartstate( "vfx", "on" );
        skull vibrate( ( 1, 1, 1 ), 2, 0.1, 5 );
    }
    
    wait 1;
    
    foreach ( skull in a_skulls )
    {
        skull thread skull_activate();
    }
    
    wait 3;
}

// Namespace zm_sat_ruby_ee_simon
// Params 1, eflags: 0x4
// Checksum 0x225e4cf9, Offset: 0x1082
// Size: 0x1f5
function private function_58e64533eb116112( a_skulls )
{
    level utility::flag_clear( "ruby_ee_simon_fail" );
    level utility::flag_clear( "ruby_ee_simon_restart" );
    
    if ( !isdefined( level.ruby_ee_simon.a_order ) )
    {
        level.ruby_ee_simon.a_order = function_2f23ef2bc25a11f9( a_skulls.size );
    }
    
    for ( i = 0; i < level.ruby_ee_simon.a_order.size ; i++ )
    {
        skull = get_skull_ent( level.ruby_ee_simon.a_order[ i ] );
        skull skull_activate();
    }
    
    foreach ( skull in a_skulls )
    {
        skull setcandamage( 1 );
    }
    
    oldskull = undefined;
    
    for ( i = 0; i < level.ruby_ee_simon.a_order.size ; i++ )
    {
        hitskull = utility::array_any_wait_return( a_skulls, "damage" );
        
        if ( hitskull.script_noteworthy != string( level.ruby_ee_simon.a_order[ i ] ) )
        {
            function_217471ee83e0a95b( a_skulls );
            return;
        }
        
        hitskull playsoundonmovingent( "evt_ruby_ee_skull_scream_pitch_" + hitskull.script_noteworthy );
        hitskull setscriptablepartstate( "vfx", "hit" );
        hitskull vibrate( ( 1, 1, 1 ), 2, 0.1, 2 );
        hitskull setcandamage( 0 );
        
        if ( oldskull )
        {
            oldskull setcandamage( 1 );
        }
        
        oldskull = hitskull;
    }
}

// Namespace zm_sat_ruby_ee_simon
// Params 0, eflags: 0x4
// Checksum 0x34f4f21d, Offset: 0x127f
// Size: 0x169
function private skull_activate()
{
    self setscriptablepartstate( "vfx", "on" );
    self vibrate( ( 1, 1, 1 ), 2, 0.1, 1 );
    wait 0.25;
    self playsoundonmovingent( "evt_ruby_ee_skull_scream_pitch_" + self.script_noteworthy );
    a_ai = getaiarrayinradius( self.origin, 512 );
    
    foreach ( ai in a_ai )
    {
        ai thread effect_stun::stun( "ee_skream", 5 );
    }
    
    self moveto( self.origin + ( 0, 0, 16 ), 0.25, 0.1 );
    wait 0.35;
    self rotateby( ( 0, 360, 0 ), 0.5, 0.1 );
    wait 0.5;
    self moveto( self.origin + ( 0, 0, -16 ), 0.25, 0.1 );
    wait 0.35;
    self setscriptablepartstate( "vfx", "off" );
}

// Namespace zm_sat_ruby_ee_simon
// Params 1, eflags: 0x4
// Checksum 0xe00e76f1, Offset: 0x13f0
// Size: 0xc8
function private function_2f23ef2bc25a11f9( n_skulls )
{
    a_hits = [ 1, 2, 3, 4, 5 ];
    
    while ( a_hits.size < 7 )
    {
        a_hits[ a_hits.size ] = utility::array_random( a_hits );
    }
    
    a_order = [];
    
    for ( n_last_hit = undefined; a_order.size < 7 ; n_last_hit = n_hit )
    {
        var_5a59e4113644766b = 0;
        
        do
        {
            if ( var_5a59e4113644766b > 10 )
            {
                n_hit = randomint( n_skulls ) + 1;
                continue;
            }
            
            n_hit = utility::array_random( a_hits );
            var_5a59e4113644766b++;
        }
        while ( n_hit == n_last_hit );
        
        a_order[ a_order.size ] = n_hit;
        a_hits = utility::function_d751969553a4bddd( a_hits, n_hit );
    }
    
    return a_order;
}

// Namespace zm_sat_ruby_ee_simon
// Params 1, eflags: 0x4
// Checksum 0x49073cf9, Offset: 0x14c1
// Size: 0x10f
function private function_217471ee83e0a95b( a_skulls )
{
    iprintlnbold( "SKULLS SAYS FAILED" );
    level utility::flag_set( "ruby_ee_simon_fail" );
    
    foreach ( skull in a_skulls )
    {
        skull setscriptablepartstate( "vfx", "off" );
        skull vibrate( ( 0, 0, 0 ), 0, 1, 1 );
        skull setcandamage( 0 );
    }
    
    level waittill( #"on_round_end" );
    interact = zm_quest::function_91f9590e98d57ff6( utility::getstruct( "ruby_ee_simon_reward" ).origin, &function_8bd209c62d99079, undefined, "hidden" );
    level utility::flag_wait( "ruby_ee_simon_restart" );
    interact freescriptable();
}

// Namespace zm_sat_ruby_ee_simon
// Params 1, eflags: 0x4
// Checksum 0xdf2bc08c, Offset: 0x15d8
// Size: 0x19
function private function_8bd209c62d99079( player )
{
    level utility::flag_set( "ruby_ee_simon_restart" );
}

