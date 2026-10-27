// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_clocks.gsc  (hash_661a0c1bf7752e06.gscc) (size: 5568 Bytes / 0x15c0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9d7244be (2641511614)
// size ...... 5568 (0x15c0)
// includes .. 9   (offset: 0x1454)
// strings ... 18  (offset: 0x149c)
// dev strs .. 2   (offset: 0x15a8)
// exports ... 11  (offset: 0xc2c)
// cseg ...... 0x201 + 0xa2b (0xc2c)
// imports ... 54  (offset: 0xde4)
// animtree1 . 0   (offset: 0x15c0)
// animtree2 . 0   (offset: 0x15c0)
#using scripts\asm\asm;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_ruby_ee_clocks;

// Namespace zm_sat_ruby_ee_clocks
// Params 0, eflags: 0x5
// Checksum 0x9d0ae2eb, Offset: 0x21f
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"ruby_ee_clocks", #"zm_quest", &function_ce1a4037eec2b93b, &function_65839db0bc8f4ed8 );
}

// Namespace zm_sat_ruby_ee_clocks
// Params 0, eflags: 0x4
// Checksum 0x151955db, Offset: 0x24c
// Size: 0x78
function private function_ce1a4037eec2b93b()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    level.ruby_ee_clocks = zm_quest::get_quest( #"ruby_ee_clocks" );
    level.ruby_ee_clocks.n_ticking = 0;
    zm_quest::register_quest_step( #"ruby_ee_clocks", #"hash_b99d6113c80a4b38", &function_baf7bb051564facb, &complete_clocks );
}

// Namespace zm_sat_ruby_ee_clocks
// Params 0, eflags: 0x4
// Checksum 0x18543b4f, Offset: 0x2cc
// Size: 0x48
function private function_65839db0bc8f4ed8()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"ruby_ee_clocks" );
    level thread function_913768573ef1a0c4();
}

// Namespace zm_sat_ruby_ee_clocks
// Params 2, eflags: 0x4
// Checksum 0xf93e4fb5, Offset: 0x31c
// Size: 0x2e
function private function_baf7bb051564facb( b_skipped, b_save_restored )
{
    scriptable::scriptable_adddamagedcallback( &function_69ef87c28e315389 );
    level utility::flag_wait( "ruby_ee_all_ticking" );
}

// Namespace zm_sat_ruby_ee_clocks
// Params 11, eflags: 0x4
// Checksum 0xf809928f, Offset: 0x352
// Size: 0xdf
function private function_69ef87c28e315389( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( level utility::flag( "ruby_ee_all_ticking" ) || level utility::flag( "ruby_ee_tick_wait" ) )
    {
        return;
    }
    
    if ( instance.type == "sat_zm_ruby_ee_grandfather_clock" && instance getscriptablepartstate( "anim" ) == "off" && isplayer( eattacker ) && smeansofdeath == "MOD_MELEE" )
    {
        instance setscriptablepartstate( "anim", "on" );
        instance thread function_a7af19ece58300d4();
    }
}

// Namespace zm_sat_ruby_ee_clocks
// Params 0, eflags: 0xc
// Checksum 0x344eb2fe, Offset: 0x439
// Size: 0x94
function private function_a7af19ece58300d4()
{
    self notify( #"hash_657971d7700453c5" );
    self endon( #"hash_657971d7700453c5" );
    level.ruby_ee_clocks.n_ticking++;
    
    if ( level.ruby_ee_clocks.n_ticking == 5 && !level utility::flag( "ruby_ee_all_ticking" ) )
    {
        level thread function_ca178db299ba8605();
    }
    
    wait 60;
    level utility::flag_waitopen( "ruby_ee_all_ticking" );
    level.ruby_ee_clocks.n_ticking--;
    self setscriptablepartstate( "anim", "off" );
}

// Namespace zm_sat_ruby_ee_clocks
// Params 2, eflags: 0x4
// Checksum 0x6dd7a7a9, Offset: 0x4d5
// Size: 0x24
function private complete_clocks( b_skipped, b_save_restored )
{
    /#
        if ( b_skipped )
        {
            function_ca178db299ba8605();
        }
    #/
}

// Namespace zm_sat_ruby_ee_clocks
// Params 0, eflags: 0x4
// Checksum 0x51eae0d5, Offset: 0x501
// Size: 0x4cf
function private function_ca178db299ba8605()
{
    level utility::flag_set( "ruby_ee_all_ticking" );
    level utility::flag_set( "ruby_ee_tick_wait" );
    
    if ( isdefined( level.var_4a75d6f667fe29b1 ) && isdefined( level.var_d10ffa3495170564 ) )
    {
        level.var_4a75d6f667fe29b1 = 0;
        level.var_d10ffa3495170564 = 1;
    }
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    a_clocks = getentitylessscriptablearray( "scriptable_sat_zm_ruby_ee_grandfather_clock", #classname );
    
    foreach ( clock in a_clocks )
    {
        clock setscriptablepartstate( "anim", "on_time_warp" );
    }
    
    foreach ( player in level.players )
    {
        if ( !player is_on_mars() )
        {
            pbgpostfxbundlestart( player, %"sat_time_warp" );
            player playsoundtoplayer( "evt_ruby_ee_grandfather_clock_time_warping", player, player );
        }
    }
    
    var_dd40cf6520d59892 = gettime() + utility::function_4b74c15943231980( 60 );
    f_rate = 0;
    var_b29ee84ff1629531 = 0.0166667;
    
    while ( gettime() < var_dd40cf6520d59892 )
    {
        f_rate += var_b29ee84ff1629531;
        var_27d11395809a8019 = min( 0.75, max( f_rate, 0.1 ) );
        function_d8b75b0a6f35296d( var_27d11395809a8019 );
        function_8480c01544182a46( var_27d11395809a8019 );
        physics_setgravityragdollscalar( var_27d11395809a8019 );
        function_61bb4aaaa2e5a524( var_27d11395809a8019 );
        a_ai = getaiarray();
        
        foreach ( ai in a_ai )
        {
            if ( isalive( ai ) && !ai is_on_mars() )
            {
                ai asm::function_d82cb83c9c260d49( min( 1, var_27d11395809a8019 ) );
                ai asm::function_24133a663bba593c();
            }
        }
        
        var_62c6c055eb53531b = gettime() >= var_dd40cf6520d59892 - 10000;
        
        foreach ( player in level.players )
        {
            if ( !player is_on_mars() )
            {
                if ( var_62c6c055eb53531b )
                {
                    player playsoundtoplayer( "ui_ruby_ee_grandfather_timer_countdown_10", player );
                    continue;
                }
                
                player playsoundtoplayer( "ui_ruby_ee_grandfather_timer_countdown", player );
            }
        }
        
        wait 1;
    }
    
    a_ai = getaiarray();
    
    foreach ( ai in a_ai )
    {
        if ( isalive( ai ) && !ai is_on_mars() )
        {
            ai asm::function_d82cb83c9c260d49( 1 );
            ai asm::function_24133a663bba593c();
        }
    }
    
    function_d8b75b0a6f35296d( 1 );
    function_8480c01544182a46( 1 );
    physics_setgravityragdollscalar( 1 );
    function_61bb4aaaa2e5a524( 1 );
    
    foreach ( player in level.players )
    {
        pbgpostfxbundleend( player, %"sat_time_warp" );
    }
    
    level utility::flag_clear( "ruby_ee_all_ticking" );
    
    if ( isdefined( level.var_4a75d6f667fe29b1 ) && isdefined( level.var_d10ffa3495170564 ) )
    {
        level.var_4a75d6f667fe29b1 = 1;
        level.var_d10ffa3495170564 = 0;
    }
    
    level waittill( #"on_round_end" );
    level utility::flag_clear( "ruby_ee_tick_wait" );
}

// Namespace zm_sat_ruby_ee_clocks
// Params 0, eflags: 0x4
// Checksum 0xea9afddb, Offset: 0x9d8
// Size: 0x5a, Type: bool
function private is_on_mars()
{
    if ( !isalive( self ) )
    {
        return false;
    }
    
    var_8c4fe62d01999d1e = zone_manager::function_90e5c3e2272b0130( self.origin );
    
    if ( !var_8c4fe62d01999d1e )
    {
        return false;
    }
    
    var_4cdafb4532dd9de4 = zone_manager::function_2bcd755aabfd3cad( var_8c4fe62d01999d1e );
    
    if ( var_4cdafb4532dd9de4 && issubstr( var_4cdafb4532dd9de4, "temple" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_ruby_ee_clocks
// Params 0
// Checksum 0xaf196d67, Offset: 0xa3b
// Size: 0x1f1
function function_913768573ef1a0c4()
{
    self notify( #"hash_41e6edb79798576f" );
    self endon( #"hash_41e6edb79798576f" );
    level utility::flag_wait_any( "open_mars_portal", "survival_map_setup_finished" );
    wait 45;
    s_face = utility::getstruct( "ruby_ee_pareidolia" );
    
    if ( !s_face )
    {
        s_face = spawnstruct();
        s_face.origin = ( 1971, -40765, -11739 );
    }
    
    while ( s_face )
    {
        foreach ( player in level.players )
        {
            if ( player playerads() == 1 && player is_on_mars() && player zm_utility::is_player_facing( s_face.origin, -1, 5 ) )
            {
                var_38092e54c3f9b623 = [ player ];
                
                foreach ( martian in level.players )
                {
                    if ( martian != player && martian is_on_mars() )
                    {
                        var_38092e54c3f9b623[ var_38092e54c3f9b623.size ] = martian;
                    }
                }
                
                level musicbank_utility::function_5aca66c390aa347d( var_38092e54c3f9b623, #"hash_f0e2f2a496a29a28" );
                
                /#
                    iprintlnbold( "<dev string:x31>" );
                #/
                
                wait 370;
                level waittill( #"on_round_end" );
                level waittill( #"on_round_end" );
                break;
            }
        }
        
        wait 2;
    }
}

