// scripts\mp\zm\ztron\ztron_ftue.gsc  (hash_5fd8b25d8184394a.gscc) (size: 3446 Bytes / 0xd76 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xca454f23 (3393539875)
// size ...... 3446 (0xd76)
// includes .. 2   (offset: 0xcd6)
// strings ... 9   (offset: 0xce6)
// dev strs .. 0   (offset: 0xd76)
// exports ... 12  (offset: 0x806)
// cseg ...... 0x125 + 0x6e1 (0x806)
// imports ... 24  (offset: 0x9e6)
// animtree1 . 0   (offset: 0xd76)
// animtree2 . 0   (offset: 0xd76)
#using script_31ee2a173f3499b7;
#using scripts\common\utility;

#namespace ztron_ftue;

// Namespace ztron_ftue
// Params 0
// Checksum 0xe72ad35, Offset: 0x143
// Size: 0x28
function main()
{
    if ( ftue_is_enabled() )
    {
        ftue_init( "ftuetiplist:ftuetips_list_ztron" );
        thread function_3d9cf9aacfd9cbd();
        return;
    }
    
    thread function_7f61aca43ae4ba3d();
}

// Namespace ztron_ftue
// Params 0
// Checksum 0x58baa300, Offset: 0x173
// Size: 0x13, Type: bool
function ftue_is_enabled()
{
    return getdvarint( @"hash_c0e1c1320b98600e", 1 ) != 0;
}

// Namespace ztron_ftue
// Params 1
// Checksum 0xfa187bd1, Offset: 0x18f
// Size: 0x127
function ftue_init( var_3b581115eee4dfcc )
{
    if ( ftue_is_enabled() )
    {
        ftuetips_list_bundle = getscriptbundle( var_3b581115eee4dfcc );
        
        if ( isdefined( ftuetips_list_bundle ) )
        {
            level.ztron.ftuetips_table = [];
            index = 1;
            
            foreach ( bundle in ftuetips_list_bundle.ftuetips_list )
            {
                ftuetip_ref = bundle.ref;
                
                if ( isdefined( ftuetip_ref ) )
                {
                    tip = spawnstruct();
                    tip.id = index;
                    tip.bundle = bundle.bundle;
                    level.ztron.ftuetips_table[ ftuetip_ref ] = tip;
                }
                
                index++;
            }
        }
    }
}

// Namespace ztron_ftue
// Params 1
// Checksum 0x12c84336, Offset: 0x2be
// Size: 0x3a
function function_1df8dc2d38255079( tip_ref )
{
    id = level.ztron.ftuetips_table[ tip_ref ].id;
    return id;
}

// Namespace ztron_ftue
// Params 0
// Checksum 0xa751e7bd, Offset: 0x301
// Size: 0x133
function function_3d9cf9aacfd9cbd()
{
    level endon( #"ztron_game_is_over", #"hash_4fa5e390364ace2d" );
    level waittill( #"round_about_to_start" );
    ztron_ui::function_4eb411ba146450();
    profilestart();
    level ztron_ui::function_f5177e090dadd8f4( 2 );
    profilestop();
    level waittill( #"round_begin_warm_up" );
    level utility::flag_set( "ztron_round_paused" );
    level thread function_90a4d78d220fb52e();
    level waittill( #"hash_adf86b4395737606" );
    
    if ( level.ztron.blitzmode )
    {
        ztron_ui::function_37aad40e39a9fdfe( "blitz_mode" );
    }
    else if ( level.ztron.var_371903e5801e0e08 )
    {
        ztron_ui::function_37aad40e39a9fdfe( "causal_mode" );
    }
    else if ( level.ztron.var_95d8c7a469393957 )
    {
        ztron_ui::function_37aad40e39a9fdfe( "hardcore_mode" );
    }
    else
    {
        ztron_ui::function_37aad40e39a9fdfe( "standard_mode" );
    }
    
    wait 4;
    level notify( #"hash_c1b1475af2f47aa3" );
    
    if ( !level utility::flag( "ztron_advanced_start_process" ) )
    {
        level utility::flag_clear( "ztron_round_paused" );
    }
    
    ztron_ui::function_559d7c88c3ffd811();
    
    if ( level.ztron.gobblegumsenabled )
    {
        level ztron_ui::function_f5177e090dadd8f4( 0 );
    }
}

// Namespace ztron_ftue
// Params 0
// Checksum 0x55df7131, Offset: 0x43c
// Size: 0x11e
function function_7f61aca43ae4ba3d()
{
    level endon( #"ztron_game_is_over", #"hash_4fa5e390364ace2d" );
    level waittill( #"round_about_to_start" );
    ztron_ui::function_4eb411ba146450();
    profilestart();
    level ztron_ui::function_f5177e090dadd8f4( 2 );
    profilestop();
    level waittill( #"round_begin_warm_up" );
    level utility::flag_set( "ztron_round_paused" );
    
    if ( level.ztron.blitzmode )
    {
        ztron_ui::function_37aad40e39a9fdfe( "blitz_mode" );
    }
    else if ( level.ztron.var_371903e5801e0e08 )
    {
        ztron_ui::function_37aad40e39a9fdfe( "causal_mode" );
    }
    else if ( level.ztron.var_95d8c7a469393957 )
    {
        ztron_ui::function_37aad40e39a9fdfe( "hardcore_mode" );
    }
    else
    {
        ztron_ui::function_37aad40e39a9fdfe( "standard_mode" );
    }
    
    wait 4;
    level notify( #"hash_c1b1475af2f47aa3" );
    
    if ( !level utility::flag( "ztron_advanced_start_process" ) )
    {
        level utility::flag_clear( "ztron_round_paused" );
    }
    
    ztron_ui::function_559d7c88c3ffd811();
    
    if ( level.ztron.gobblegumsenabled )
    {
        level ztron_ui::function_f5177e090dadd8f4( 0 );
    }
}

// Namespace ztron_ftue
// Params 1
// Checksum 0x52fa84e5, Offset: 0x562
// Size: 0x3e
function ftue_game_start( var_b18dfd7fdcc10474 )
{
    level endon( #"hash_adf86b4395737606" );
    self endon( #"disconnect" );
    function_8f935160f3920faf( #"hash_d12af44056656ca0" );
    wait 8;
    ftue_clear();
}

// Namespace ztron_ftue
// Params 1
// Checksum 0xb3111050, Offset: 0x5a8
// Size: 0x2d
function function_8f935160f3920faf( var_b18dfd7fdcc10474 )
{
    var_859be58e4d410d87 = function_1df8dc2d38255079( var_b18dfd7fdcc10474 );
    self setclientomnvar( "ui_ztron_ftue_widget_index", var_859be58e4d410d87 );
}

// Namespace ztron_ftue
// Params 0
// Checksum 0xf43959f0, Offset: 0x5dd
// Size: 0xe
function ftue_clear()
{
    self setclientomnvar( "ui_ztron_ftue_widget_index", 0 );
}

// Namespace ztron_ftue
// Params 0
// Checksum 0xfef4f27, Offset: 0x5f3
// Size: 0x19d
function function_90a4d78d220fb52e()
{
    level endon( #"ztron_game_is_over" );
    
    if ( !isdefined( level.ztron.var_2a5be2400018b522 ) )
    {
        level.ztron.var_2a5be2400018b522 = 0;
    }
    
    if ( level.ztron.roundnumber == 1 )
    {
        foreach ( player in level.players )
        {
            player thread function_f93fbe96547045f4();
        }
    }
    
    ftuestarttime = gettime();
    
    while ( true )
    {
        if ( level.ztron.var_2a5be2400018b522 >= level.players.size )
        {
            break;
        }
        
        currenttime = gettime();
        
        if ( currenttime - ftuestarttime >= 10000 )
        {
            break;
        }
        
        waitframe();
    }
    
    foreach ( player in level.players )
    {
        player ftue_clear();
    }
    
    level notify( #"hash_adf86b4395737606" );
}

// Namespace ztron_ftue
// Params 0
// Checksum 0x3c9e7799, Offset: 0x798
// Size: 0x6e
function function_f93fbe96547045f4()
{
    level endon( #"hash_adf86b4395737606" );
    self endon( #"disconnect" );
    thread ftue_game_start();
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message );
        
        if ( !isdefined( message ) )
        {
            continue;
        }
        
        if ( message == "ztron_ftue_disabled" )
        {
            level.ztron.var_2a5be2400018b522++;
            break;
        }
    }
}

