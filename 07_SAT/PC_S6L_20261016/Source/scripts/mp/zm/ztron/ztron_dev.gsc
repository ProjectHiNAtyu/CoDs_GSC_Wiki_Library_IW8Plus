// scripts\mp\zm\ztron\ztron_dev.gsc  (hash_109eecf951a8092b.gscc) (size: 35792 Bytes / 0x8bd0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x30d341b5 (819151285)
// size ...... 35792 (0x8bd0)
// includes .. 20  (offset: 0x7ff8)
// strings ... 82  (offset: 0x8098)
// dev strs .. 151 (offset: 0x84bc)
// exports ... 88  (offset: 0x58a8)
// cseg ...... 0x6cf + 0x51d9 (0x58a8)
// imports ... 199 (offset: 0x6668)
// animtree1 . 0   (offset: 0x8bd0)
// animtree2 . 0   (offset: 0x8bd0)
#using script_31ee2a173f3499b7;
#using script_3f7d19e011d97209;
#using script_4478f81b31480314;
#using script_5441a11286579ddc;
#using script_75994df35243cb2a;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_meta_progression;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_save;
#using scripts\mp\zm\ztron\ztron_score;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_weather;

#namespace ztron_dev;

// Namespace ztron_dev
// Params 0
// Checksum 0x5d6686f3, Offset: 0x6ed
// Size: 0x10b
function init_delayed()
{
    /#
        level endon( #"ztron_game_is_over" );
        
        while ( !isdefined( level.ztron.itemdef.itemdata ) || level.ztron.itemdef.itemdata.size == 0 )
        {
            wait 1;
        }
        
        level.ztron.dev.var_40361780fc8f1b5b = 15;
        bgb_machine::function_5805a592897cb161();
        
        if ( getdvarint( @"hash_964c354b854bfe35", 0 ) == 1 )
        {
            function_fd32519ef573aa4f();
        }
        
        if ( getdvarint( @"hash_964c354b854bfe35", 0 ) == 2 )
        {
            function_a192c327fc9c81ad();
        }
        
        if ( getdvarint( @"hash_91f7ddac1b597b1e", 0 ) == 1 )
        {
            function_bf1d7710e857cb90();
        }
        
        if ( getdvarint( @"hash_f90acc2e461808b0", 0 ) == 1 )
        {
            kingall();
        }
        
        if ( getdvarint( @"hash_cb7aeac255197494", 0 ) == 1 )
        {
            function_7b7c416a44f981c2();
        }
    #/
}

// Namespace ztron_dev
// Params 0
// Checksum 0x29abaf7b, Offset: 0x800
// Size: 0xa5
function init()
{
    init_devoptions();
    level thread init_delayed();
    level.ztron.dev = spawnstruct();
    level.ztron.dev.var_fd17659ef5557a41 = 0;
    level.ztron.dev.var_76d2e7c5f5a9d35f = 0;
    level.ztron.dev.itemSpawn = [];
    level.ztron.dev.var_9944015295c3734e = 0;
}

// Namespace ztron_dev
// Params 0
// Checksum 0xb3be69c6, Offset: 0x8ad
// Size: 0xe
function function_47cbd5df551f1727()
{
    level notify( #"trigger_papaback_intro" );
}

// Namespace ztron_dev
// Params 0
// Checksum 0xf00f707a, Offset: 0x8c3
// Size: 0x175
function function_27008415855a59ae()
{
    self notify( #"hash_70c59aeaa6daaffa" );
    self endon( #"hash_70c59aeaa6daaffa" );
    
    /#
        if ( level.ztron.dev.var_9ac93c89e872a0cc )
        {
            level.ztron.dev.var_9ac93c89e872a0cc = 0;
            return;
        }
        
        level.ztron.dev.var_9ac93c89e872a0cc = 1;
        color = ( 0.6, 1, 0.6 );
        
        while ( true )
        {
            var_e73998aabc093e78 = ztron_util::function_cdd411b0cc1f9d80();
            
            if ( var_e73998aabc093e78.size <= 0 )
            {
                waitframe();
                continue;
            }
            
            me = level.players[ 0 ];
            
            foreach ( ene in var_e73998aabc093e78 )
            {
                start = ene.origin;
                end = me.origin;
                line( start, end, color );
                sphere( start, 10, color );
            }
            
            waitframe();
        }
    #/
}

// Namespace ztron_dev
// Params 0
// Checksum 0x886f4260, Offset: 0xa40
// Size: 0x166
function function_c3db35e665239f40()
{
    self notify( #"hash_ff073ca57c551e3d" );
    self endon( #"hash_ff073ca57c551e3d" );
    
    /#
        if ( level.ztron.dev.var_dc2e868390e6bbfe )
        {
            level.ztron.dev.var_dc2e868390e6bbfe = 0;
            return;
        }
        
        level.ztron.dev.var_dc2e868390e6bbfe = 1;
        defaultcolor = ( 0, 0, 0 );
        
        while ( true )
        {
            if ( level.players.size <= 1 )
            {
                waitframe();
                continue;
            }
            
            me = level.players[ 0 ];
            
            for ( i = 1; i < level.players.size ; i++ )
            {
                p = level.players[ i ];
                color = p.ztron.colorrgb;
                
                if ( !isdefined( color ) )
                {
                    color = defaultcolor;
                }
                
                start = p.origin;
                end = me.origin;
                line( start, end, color );
                sphere( start, 10, color );
            }
            
            waitframe();
        }
    #/
}

// Namespace ztron_dev
// Params 0
// Checksum 0x932ef829, Offset: 0xbae
// Size: 0x1e
function infiniteround()
{
    setdvar( @"hash_1aafaa210ed87b63", !getdvarint( @"hash_1aafaa210ed87b63" ) );
}

// Namespace ztron_dev
// Params 0
// Checksum 0x7c53cfc0, Offset: 0xbd4
// Size: 0x68c
function init_devoptions()
{
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x37>", "<dev string:x53>", &debug_cutscene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x63>", "<dev string:x88>", &debug_cutscene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x9b>", "<dev string:xc0>", &debug_cutscene );
        devgui::function_cd4e263c1f3018ae( "<dev string:xd3>", "<dev string:x107>", &debug_cutscene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x11b>", "<dev string:x14d>", &debug_cutscene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x15f>", "<dev string:x184>", &debug_cutscene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x197>", "<dev string:x1c8>", &debug_cutscene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1d9>", "<dev string:x1e9>", &debug_cutscene );
        devgui::function_cd4e263c1f3018ae( "<dev string:x203>", "<dev string:x215>", &debug_cutscene );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x231>" );
        devgui::add_devgui_func( "<dev string:x245>", "<dev string:x24d>", &kingme );
        devgui::add_devgui_func( "<dev string:x25f>", "<dev string:x26c>", &function_fd32519ef573aa4f );
        devgui::add_devgui_func( "<dev string:x283>", "<dev string:x294>", &function_a192c327fc9c81ad );
        devgui::add_devgui_func( "<dev string:x2ae>", "<dev string:x2ba>", &pauseround );
        devgui::add_devgui_func( "<dev string:x2d1>", "<dev string:x2e2>", &spawn_ai_catalog );
        devgui::add_devgui_func( "<dev string:x2fe>", "<dev string:x308>", &function_bfd488d68d6ff0f9 );
        devgui::add_devgui_func( "<dev string:x31d>", "<dev string:x32a>", &function_99482b53a0687926 );
        devgui::add_devgui_func( "<dev string:x340>", "<dev string:x349>", &doendgame );
        devgui::add_devgui_func( "<dev string:x35d>", "<dev string:x366>", &poptips );
        devgui::add_devgui_func( "<dev string:x37a>", "<dev string:x385>", &function_47cbd5df551f1727 );
        devgui::add_devgui_func( "<dev string:x39b>", "<dev string:x3a9>", &function_27008415855a59ae );
        devgui::add_devgui_func( "<dev string:x3c1>", "<dev string:x3cf>", &function_c3db35e665239f40 );
        devgui::add_devgui_func( "<dev string:x3e7>", "<dev string:x3f7>", &infiniteround );
        devgui::add_devgui_func( "<dev string:x409>", "<dev string:x41c>", &basicstats );
        devgui::add_devgui_func( "<dev string:x433>", "<dev string:x452>", &function_7b7c416a44f981c2 );
        devgui::add_devgui_func( "<dev string:x46e>", "<dev string:x487>", &enemystats );
        devgui::add_devgui_func( "<dev string:x49e>", "<dev string:x4c0>", &function_92b3e330e09dc5 );
        devgui::add_devgui_func( "<dev string:x4de>", "<dev string:x4ee>", &function_22de72a13196d580 );
        devgui::add_devgui_func( "<dev string:x502>", "<dev string:x516>", &function_edab9d8f6a8327fc );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x52e>" );
        devgui::add_devgui_func( "<dev string:x54d>", "<dev string:x55f>", &function_bf1d7710e857cb90 );
        devgui::add_devgui_func( "<dev string:x574>", "<dev string:x588>", &function_76ebaa87b84005dd );
        devgui::add_devgui_func( "<dev string:x5a9>", "<dev string:x5bf>", &function_7a0c4b6582716d55 );
        devgui::add_devgui_func( "<dev string:x5e2>", "<dev string:x5f6>", &function_1569c20c8b61aa40 );
        devgui::add_devgui_func( "<dev string:x617>", "<dev string:x62c>", &function_e7cd52edb863bedf );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x64e>" );
        devgui::add_devgui_func( "<dev string:x65c>", "<dev string:x666>", &function_7e3fe1444542e1a4 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x676>" );
        devgui::add_devgui_func( "<dev string:x689>", "<dev string:x691>", &function_49bc88f97323838b );
        devgui::add_devgui_func( "<dev string:x69f>", "<dev string:x6a7>", &function_49bc87f973238158 );
        devgui::add_devgui_func( "<dev string:x6b5>", "<dev string:x6bd>", &function_49bc8ef9732390bd );
        devgui::add_devgui_func( "<dev string:x6cb>", "<dev string:x6d7>", &function_9fd6829ba7fb8969 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x6e9>" );
        devgui::add_devgui_func( "<dev string:x704>", "<dev string:x707>", &function_84c0a6466e397e1 );
        devgui::add_devgui_func( "<dev string:x71a>", "<dev string:x71d>", &function_a9fdb3662aee654 );
        devgui::add_devgui_func( "<dev string:x730>", "<dev string:x733>", &function_94979da61a0b5bff );
        devgui::add_devgui_func( "<dev string:x746>", "<dev string:x749>", &function_93fca4ed48a1de2 );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x75c>" );
        devgui::add_devgui_func( "<dev string:x773>", "<dev string:x780>", &function_cab9aee8c8516f8d );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x793>" );
        devgui::add_devgui_func( "<dev string:x7a3>", "<dev string:x7af>", &superclear );
        devgui::add_devgui_func( "<dev string:x7c5>", "<dev string:x7d0>", &superpower );
        devgui::add_devgui_func( "<dev string:x7e6>", "<dev string:x7f2>", &superfrost );
        devgui::add_devgui_func( "<dev string:x804>", "<dev string:x810>", &supertesla );
        devgui::add_devgui_func( "<dev string:x822>", "<dev string:x82d>", &supermp );
        devgui::add_devgui_func( "<dev string:x83f>", "<dev string:x84b>", &superenergymine );
        devgui::add_devgui_func( "<dev string:x85d>", "<dev string:x868>", &function_f06729a3c70ecef7 );
        devgui::add_devgui_func( "<dev string:x87a>", "<dev string:x888>", &superaethershroud );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x89a>" );
        devgui::add_devgui_func( "<dev string:x8af>", "<dev string:x8bb>", &performsave );
        devgui::add_devgui_func( "<dev string:x8cb>", "<dev string:x8da>", &performrestore );
        devgui::add_devgui_func( "<dev string:x8ed>", "<dev string:x8fa>", &performreset );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x90b>" );
        devgui::add_devgui_command( "<dev string:x917>", "<dev string:x92d>" );
        devgui::function_77df7fe7dd273e10();
        
        if ( getdvarint( @"hash_a673ff22938fd83c", 0 ) == 1 )
        {
            devgui::function_9082edeb5db93280( "<dev string:x947>" );
            devgui::add_devgui_func( "<dev string:x956>", "<dev string:x968>", &function_5aef66713f1c5bfb );
            devgui::add_devgui_func( "<dev string:x984>", "<dev string:x991>", &function_2146c1f6ae0f6217 );
            devgui::add_devgui_func( "<dev string:x9a8>", "<dev string:x9b8>", &function_c69c45d42275c1ec );
            devgui::add_devgui_func( "<dev string:x9d2>", "<dev string:x9e7>", &function_483b79b8c67cac28 );
            devgui::add_devgui_func( "<dev string:xa00>", "<dev string:xa14>", &function_e92c9717dd2bf007 );
            devgui::function_77df7fe7dd273e10();
        }
        
        if ( getdvarint( @"hash_855920521a29a8de", 0 ) == 1 )
        {
            devgui::function_9082edeb5db93280( "<dev string:xa2d>" );
            devgui::add_devgui_func( "<dev string:xa3b>", "<dev string:xa4f>", &function_93eb4bdb62d67fae );
            devgui::add_devgui_func( "<dev string:xa64>", "<dev string:xa71>", &function_4137d2ff5b2fa5b1 );
            devgui::add_devgui_func( "<dev string:xa85>", "<dev string:xa94>", &function_ae499de127ed9fb7 );
            devgui::add_devgui_func( "<dev string:xaa3>", "<dev string:xab0>", &function_1e23dbee7462a566 );
            devgui::function_77df7fe7dd273e10();
        }
    #/
}

// Namespace ztron_dev
// Params 0
// Checksum 0x57d95e13, Offset: 0x1268
// Size: 0x31
function function_99482b53a0687926()
{
    level thread ztron_item::function_d0a061baefd87906( level.players[ 0 ].origin + ( 0, 0, 100 ), 100, 128 );
}

// Namespace ztron_dev
// Params 0
// Checksum 0x15925dfb, Offset: 0x12a1
// Size: 0x5d
function function_5aef66713f1c5bfb()
{
    if ( !level.ztron.blitzmode )
    {
        return;
    }
    
    level.ztron.var_ce1978f284e95152 = 0;
    level.ztron.var_501b246c862a128e = 1;
    level notify( #"blitz_threshold_reached" );
    ztron_debug::debugmsg( "DEV: Blitz threshold force-triggered" );
}

// Namespace ztron_dev
// Params 0
// Checksum 0xeed36073, Offset: 0x1306
// Size: 0xb9
function function_2146c1f6ae0f6217()
{
    if ( !level.ztron.blitzmode )
    {
        return;
    }
    
    bossarena = ztron_arena::function_973956bb5a6e60f7( "silverback_arena" );
    
    if ( !isdefined( bossarena ) )
    {
        ztron_debug::debugmsg( "DEV: silverback_arena not found" );
        return;
    }
    
    level.ztron.var_bdbf6cf2011e0b2d = bossarena.id;
    level.ztron.var_ce1978f284e95152 = 0;
    level.ztron.var_501b246c862a128e = 1;
    level notify( #"blitz_threshold_reached" );
    ztron_debug::debugmsg( "DEV: Skipping to boss arena (id " + bossarena.id + ")" );
}

// Namespace ztron_dev
// Params 0
// Checksum 0xc3a1031c, Offset: 0x13c7
// Size: 0x7d
function function_c69c45d42275c1ec()
{
    if ( !level.ztron.blitzmode || !isdefined( level.ztron.var_acd7346203660b39 ) )
    {
        return;
    }
    
    ztron_item::requestspawnitem( level.ztron.var_acd7346203660b39, level.players[ 0 ].origin + ( 0, 0, 50 ), 0 );
    ztron_debug::debugmsg( "DEV: Spawned timepiece at player" );
}

// Namespace ztron_dev
// Params 0
// Checksum 0x9166bdfa, Offset: 0x144c
// Size: 0x2e6
function function_483b79b8c67cac28()
{
    if ( !level.ztron.blitzmode )
    {
        return;
    }
    
    if ( !isdefined( level.ztron.slayer ) || !isdefined( level.ztron.slayer.store ) || !isdefined( level.ztron.slayer.store.items ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player ztron_ui::ztron_fate_upgrade_hide();
    }
    
    candidatepool = [];
    
    for ( tier = 1; tier <= 6 ; tier++ )
    {
        tieritems = level.ztron.slayer.store.items[ tier ];
        
        if ( !isdefined( tieritems ) )
        {
            continue;
        }
        
        foreach ( item in tieritems )
        {
            if ( !isdefined( item.itemref ) )
            {
                continue;
            }
            
            if ( namespace_423c46dff63ec005::function_428f895d3c248ec0( item.itemref ) )
            {
                continue;
            }
            
            candidatepool[ candidatepool.size ] = item;
        }
    }
    
    if ( candidatepool.size == 0 )
    {
        return;
    }
    
    choices = [];
    
    for ( i = 0; i < 3 && candidatepool.size > 0 ; i++ )
    {
        pick = randomint( candidatepool.size );
        choices[ choices.size ] = candidatepool[ pick ];
        candidatepool = arrayremove( candidatepool, candidatepool[ pick ] );
    }
    
    foreach ( player in level.players )
    {
        player ztron_ui::ztron_fate_upgrade_show( choices, 60 );
        player thread function_fe77abecbe21bb10( choices );
    }
    
    ztron_debug::debugmsg( "DEV: Showing " + choices.size + " random roguelike picks (all tiers, excluded filtered)" );
}

// Namespace ztron_dev
// Params 1
// Checksum 0x6a3b39aa, Offset: 0x173a
// Size: 0x86
function function_fe77abecbe21bb10( choices )
{
    self endon( #"disconnect" );
    msg = utility::waittill_any_timeout( 60, "ztron_fate_upgrade_item_chosen" );
    
    if ( msg == "ztron_fate_upgrade_item_chosen" )
    {
        chosenitem = self.ztron.var_a29e0ac675549772;
        
        if ( isdefined( chosenitem ) )
        {
            ztron_slayer::function_e444cf78bd758cb9( chosenitem );
            ztron_debug::debugmsg( "DEV: Awarded " + chosenitem.itemref + " to player" );
        }
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0x184ebf5e, Offset: 0x17c8
// Size: 0x1e0
function function_e92c9717dd2bf007()
{
    if ( !level.ztron.blitzmode )
    {
        return;
    }
    
    if ( level.ztron.var_8e85d8616b745dd3 )
    {
        foreach ( p in level.players )
        {
            p ztron_ui::function_ccc4f097446d1043();
        }
        
        level.ztron.var_8e85d8616b745dd3 = 0;
        ztron_debug::debugmsg( "DEV: Hiding time breakdown" );
        return;
    }
    
    if ( !isdefined( level.ztron.var_c6662bd024bb6e72 ) )
    {
        if ( isdefined( level.ztron.blitzstarttime ) )
        {
            level.ztron.var_c6662bd024bb6e72 = gettime() - level.ztron.blitzstarttime;
        }
        else
        {
            level.ztron.var_c6662bd024bb6e72 = 0;
        }
    }
    
    foreach ( player in level.players )
    {
        player ztron_ui::function_3579c3e1cfd9f4ba();
        player ztron_ui::function_7716b71d0d232366();
    }
    
    ztron_debug::debugmsg( "DEV: Showing time breakdown" );
    level.ztron.var_8e85d8616b745dd3 = 1;
}

// Namespace ztron_dev
// Params 0
// Checksum 0x3123dab4, Offset: 0x19b0
// Size: 0xa9
function function_93eb4bdb62d67fae()
{
    foreach ( player in level.players )
    {
        player namespace_4f98d1d7dc3196d::awardtoken( 1 );
        ztron_debug::debugmsg( "DEV: Awarded 1 token (with toast), total: " + player.ztron.meta.tokens );
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0x4f9c592b, Offset: 0x1a61
// Size: 0xf2
function function_4137d2ff5b2fa5b1()
{
    foreach ( player in level.players )
    {
        player.ztron.meta.tokens += 5;
        player namespace_4f98d1d7dc3196d::function_c2b0649474e1e376();
        player ztron_ui::function_e4c6bb291268e9d5();
        ztron_debug::debugmsg( "DEV: Added 5 tokens, total: " + player.ztron.meta.tokens );
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0x6395eb10, Offset: 0x1b5b
// Size: 0x90
function function_ae499de127ed9fb7()
{
    foreach ( player in level.players )
    {
        player namespace_4f98d1d7dc3196d::function_fce15efedadce8f9();
        player ztron_ui::function_e4c6bb291268e9d5();
        ztron_debug::debugmsg( "DEV: Reset all meta attributes and tokens" );
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0x29692a78, Offset: 0x1bf3
// Size: 0x90
function function_1e23dbee7462a566()
{
    foreach ( player in level.players )
    {
        player namespace_4f98d1d7dc3196d::function_73a3e89c13fc9c2();
        player ztron_ui::function_e4c6bb291268e9d5();
        ztron_debug::debugmsg( "DEV: Maxed all meta attributes" );
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0xe8e0db58, Offset: 0x1c8b
// Size: 0x160
function function_bc6f847f30e30b6c()
{
    self notify( #"hash_364506dddff48d5d" );
    self endon( #"hash_364506dddff48d5d" );
    arena = ztron_arena::function_973956bb5a6e60f7( "island" );
    level thread ztron_arena::changearena( arena.id, 1 );
    level waittill( #"arena_initialized" );
    level.ztron.arena_rounds_left = 1;
    var_bdb94bcd4b8c89bd = level.ztron.blitzmode ? 1 : 4;
    ztron_main::function_2da19957201c6090( arena.id * var_bdb94bcd4b8c89bd + var_bdb94bcd4b8c89bd + level.ztron.game_laps * level.ztron.arenas.size * var_bdb94bcd4b8c89bd );
    
    while ( !level utility::flag( "ztron_round_spawning" ) )
    {
        wait 0.1;
    }
    
    level.ztron.arena_rounds_left = 1;
    level.ztron.var_51b2b203836e3a1d = 0;
    level.ztron.var_efb770b1e9386f4d = 0;
    level notify( #"hash_54d22cbc6baa8cf8" );
    ztron_arena::function_6fc50167bb958c08();
    ztron_util::killallenemies();
    ztron_util::function_494e6b73ea596cc7( 3 );
    ztron_util::function_d54d1c1fe00833d6();
    ztron_weather::setlightstate( 3 );
}

// Namespace ztron_dev
// Params 2
// Checksum 0x69d37be4, Offset: 0x1df3
// Size: 0x1b0
function dointro( name, extra )
{
    self notify( #"hash_e41d676c826fadc2" );
    self endon( #"hash_e41d676c826fadc2" );
    arena = ztron_arena::function_973956bb5a6e60f7( name );
    
    if ( name == "silverback_arena" && extra == "1" )
    {
        arena.var_9fc9518ce94ee645 = 1;
    }
    
    level thread ztron_arena::changearena( arena.id, 1 );
    level waittill( #"arena_initialized" );
    level.ztron.arena_rounds_left = 1;
    var_bdb94bcd4b8c89bd = level.ztron.blitzmode ? 1 : 4;
    ztron_main::function_2da19957201c6090( arena.id * var_bdb94bcd4b8c89bd + var_bdb94bcd4b8c89bd + level.ztron.game_laps * level.ztron.arenas.size * var_bdb94bcd4b8c89bd );
    ztron_arena::function_f2e9dd5fcbd74bd( !level.ztron.var_8b805d05c346798f );
    
    while ( !level utility::flag( "ztron_round_spawning" ) )
    {
        wait 0.1;
    }
    
    level.ztron.arena_rounds_left = 1;
    level.ztron.var_51b2b203836e3a1d = 0;
    level.ztron.var_efb770b1e9386f4d = 0;
    level notify( #"hash_54d22cbc6baa8cf8" );
    ztron_arena::function_6fc50167bb958c08();
    ztron_util::killallenemies();
    ztron_util::function_494e6b73ea596cc7( 3 );
    ztron_util::function_d54d1c1fe00833d6();
    ztron_weather::setlightstate( 3 );
}

// Namespace ztron_dev
// Params 1
// Checksum 0x461ae18c, Offset: 0x1fab
// Size: 0x1b
function debug_cutscene( params )
{
    level thread dointro( params[ 0 ], params[ 1 ] );
}

// Namespace ztron_dev
// Params 0
// Checksum 0x5290fda, Offset: 0x1fce
// Size: 0xa4
function performsave()
{
    foreach ( player in level.players )
    {
        level.ztron.saveservice.sessionsave[ player.name ] = ztron_save::function_a9049320e5338e7f( player );
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0xe392e13a, Offset: 0x207a
// Size: 0x7b
function performrestore()
{
    foreach ( player in level.players )
    {
        player thread ztron_save::function_970f8cd0a0744c21();
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0x35b478d7, Offset: 0x20fd
// Size: 0x7d
function performreset()
{
    foreach ( player in level.players )
    {
        player ztron_player_utility::playerinitialize( 1 );
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0xf6ed9ad8, Offset: 0x2182
// Size: 0x7b
function superclear()
{
    foreach ( player in level.players )
    {
        player ztron_player_utility::function_ee455a0fc54e29fb();
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0xeaf57a6c, Offset: 0x2205
// Size: 0x7b
function superpower()
{
    foreach ( player in level.players )
    {
        player ztron_player_utility::function_21f8005dcd5af7f9();
    }
}

// Namespace ztron_dev
// Params 1
// Checksum 0xe12a2ad0, Offset: 0x2288
// Size: 0x86
function givesuper( superid )
{
    foreach ( player in level.players )
    {
        player ztron_player_utility::function_64952a50eba73135( superid );
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0xcedf22e8, Offset: 0x2316
// Size: 0xe
function supertesla()
{
    givesuper( "super_tesla_storm" );
}

// Namespace ztron_dev
// Params 0
// Checksum 0xfa288a94, Offset: 0x232c
// Size: 0xe
function superfrost()
{
    givesuper( "super_frost_blast" );
}

// Namespace ztron_dev
// Params 0
// Checksum 0xfb81cb75, Offset: 0x2342
// Size: 0xe
function supermp()
{
    givesuper( "super_mary_paris" );
}

// Namespace ztron_dev
// Params 0
// Checksum 0x8f0b3c45, Offset: 0x2358
// Size: 0xe
function superenergymine()
{
    givesuper( "super_energy_mine" );
}

// Namespace ztron_dev
// Params 0
// Checksum 0x601ace35, Offset: 0x236e
// Size: 0xe
function function_f06729a3c70ecef7()
{
    givesuper( "super_dark_flare" );
}

// Namespace ztron_dev
// Params 0
// Checksum 0x23a950f3, Offset: 0x2384
// Size: 0xe
function superaethershroud()
{
    givesuper( "super_aether_shroud" );
}

// Namespace ztron_dev
// Params 0
// Checksum 0xd3a6db53, Offset: 0x239a
// Size: 0xbc
function function_bfd488d68d6ff0f9()
{
    foreach ( player in level.players )
    {
        player.ztron.score.desired_points = 4294967295;
        player.ztron.score.nextextralife = 4294467295;
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0xf389ffaa, Offset: 0x245e
// Size: 0xe
function poptips()
{
    ztron_ui::function_37aad40e39a9fdfe( "hardcore_mode" );
}

// Namespace ztron_dev
// Params 0
// Checksum 0xef13746f, Offset: 0x2474
// Size: 0xf
function doendgame()
{
    level utility::flag_set( "ztron_all_players_dead" );
}

// Namespace ztron_dev
// Params 0
// Checksum 0x1a206d3d, Offset: 0x248b
// Size: 0x1f9
function spawn_ai_catalog()
{
    level utility::flag_set( "ztron_round_paused" );
    ztron_debug::function_7a494955e7b24aa3( 500, 500, "ROUND PAUSED: ON", ( 1, 1, 0 ), 3, 1 );
    level utility::flag_clear( "ztron_round_spawning" );
    wait 0.1;
    ztron_util::killallenemies();
    center = level.ztron.active_arena.center.origin;
    r = 0;
    c = 0;
    spacing = 200;
    enemycount = level.ztron.enemytypes.size;
    sidelen = ceil( sqrt( enemycount ) );
    halfside = int( sidelen / 2 );
    idx = 0;
    
    for ( r = halfside * -1; r <= halfside ; r++ )
    {
        for ( c = halfside * -1; c <= halfside ; c++ )
        {
            if ( idx >= enemycount )
            {
                break;
            }
            
            enemydef = level.ztron.enemytypes[ idx ];
            
            if ( enemydef.boss )
            {
                continue;
            }
            
            position = center + ( r * spacing, c * spacing, 0 );
            ai = ztron_enemy::function_acee91c445fafd29( enemydef, position, undefined, undefined, 1, 1 );
            ai.ignoreall = 1;
            org = utility::spawn_model( "tag_origin", position );
            org thread ztron_util::function_f7544bfa701db406( ai );
            ai linkto( org );
            ai thread ztron_debug::function_cadec874ded26d36( enemydef.name, undefined, undefined, undefined, 9999 );
            ai thread ztron_debug::function_9f9ad9887fd5d1c5();
            ai.var_63c94fe1b2260b34 = 1;
            idx++;
        }
        
        if ( idx >= enemycount )
        {
            break;
        }
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0xe8a91616, Offset: 0x268c
// Size: 0x72
function pauseround()
{
    if ( utility::flag( "ztron_round_paused" ) )
    {
        level utility::flag_clear( "ztron_round_paused" );
        on = "false";
    }
    else
    {
        level utility::flag_set( "ztron_round_paused" );
        ztron_util::killallenemies();
        on = "true";
    }
    
    ztron_debug::function_7a494955e7b24aa3( 500, 500, "ROUND PAUSED: " + on, ( 1, 1, 0 ), 3, 1 );
}

// Namespace ztron_dev
// Params 0
// Checksum 0x812352ad, Offset: 0x2706
// Size: 0xb4
function function_61a8de4c804ac998()
{
    if ( !isdefined( level.ztron.var_a522076b1e316b4d ) )
    {
        level.ztron.var_a522076b1e316b4d = [];
    }
    
    foreach ( enemydef in level.ztron.var_a522076b1e316b4d )
    {
        enemydef.count = 0;
    }
}

// Namespace ztron_dev
// Params 1
// Checksum 0x26bc37a9, Offset: 0x27c2
// Size: 0x13a
function function_e8706d29bfd056a0( enemyname )
{
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        if ( !isdefined( level.ztron.var_a522076b1e316b4d[ enemyname ] ) )
        {
            level.ztron.var_a522076b1e316b4d[ enemyname ] = spawnstruct();
        }
        
        if ( !isdefined( level.ztron.var_a522076b1e316b4d[ enemyname ].count ) )
        {
            level.ztron.var_a522076b1e316b4d[ enemyname ].count = 0;
        }
        
        if ( !isdefined( level.ztron.var_a522076b1e316b4d[ enemyname ].var_db835c39069996f7 ) )
        {
            level.ztron.var_a522076b1e316b4d[ enemyname ].var_db835c39069996f7 = 0;
        }
        
        level.ztron.var_a522076b1e316b4d[ enemyname ].count++;
        level.ztron.var_a522076b1e316b4d[ enemyname ].var_db835c39069996f7++;
        level.ztron.var_a522076b1e316b4d[ enemyname ].name = enemyname;
    }
}

// Namespace ztron_dev
// Params 1
// Checksum 0xcfd2c6c6, Offset: 0x2904
// Size: 0x2f7
function function_c00c98295e41f5b4( alltime = 0 )
{
    self notify( #"hash_9a07ebdfadc29f35" );
    self endon( #"hash_9a07ebdfadc29f35" );
    level endon( #"ztron_game_is_over", #"hash_51bf243a085210ba" );
    
    while ( true )
    {
        waitframe();
        
        if ( !isdefined( level.ztron.var_a522076b1e316b4d ) )
        {
            continue;
        }
        
        anchorx = 1400;
        anchory = 50;
        totalspawned = 0;
        
        foreach ( key in getarraykeys( level.ztron.var_a522076b1e316b4d ) )
        {
            totalspawned += alltime ? level.ztron.var_a522076b1e316b4d[ key ].var_db835c39069996f7 : level.ztron.var_a522076b1e316b4d[ key ].count;
        }
        
        if ( !alltime )
        {
            sorted = function_7243d45b5d82f431( level.ztron.var_a522076b1e316b4d, #count, 1 );
        }
        else
        {
            sorted = function_7243d45b5d82f431( level.ztron.var_a522076b1e316b4d, #var_db835c39069996f7, 1 );
        }
        
        currenty = anchory;
        currenty = function_2a85d656a1ace652( anchorx, currenty, ( alltime ? "ALL-TIME " : "ROUND " ) + "ENEMY STATS", 3 );
        currenty = function_2a85d656a1ace652( anchorx, currenty, "PERCENT      COUNT      NAME", 3 );
        idx = 1;
        
        foreach ( enemydef in sorted )
        {
            percentage = 0;
            count = alltime ? enemydef.var_db835c39069996f7 : enemydef.count;
            
            if ( totalspawned > 0 )
            {
                percentage = count / totalspawned * 100;
                percentage = int( percentage * 10 ) / 10;
            }
            
            text = idx + ") " + percentage + "%              " + count + "               " + enemydef.name;
            currenty = function_2a85d656a1ace652( anchorx, currenty, text, 2 );
            idx++;
        }
    }
}

/#

    // Namespace ztron_dev
    // Params 0
    // Checksum 0x2c775d09, Offset: 0x2c03
    // Size: 0x3b, Type: dev
    function function_edab9d8f6a8327fc()
    {
        if ( getdvarint( @"hash_6d7af5a97a21e4ef", 0 ) >= 1 )
        {
            setdvar( @"hash_3946199aac3e4fab", 0 );
            return;
        }
        
        setdvar( @"hash_3946199aac3e4fab", 1 );
    }

#/

// Namespace ztron_dev
// Params 0
// Checksum 0x3f8b019e, Offset: 0x2c46
// Size: 0x85
function function_22de72a13196d580()
{
    if ( !isdefined( level.ztron.dev.var_920a377c7329feee ) )
    {
        level.ztron.dev.var_920a377c7329feee = 0;
    }
    
    level.ztron.dev.var_920a377c7329feee = !level.ztron.dev.var_920a377c7329feee;
    level thread function_920a377c7329feee();
}

// Namespace ztron_dev
// Params 0
// Checksum 0x67fa7542, Offset: 0x2cd3
// Size: 0x3d
function function_920a377c7329feee()
{
    /#
        if ( !level.ztron.dev.var_920a377c7329feee )
        {
            level notify( #"hash_d264839d1625d6b8" );
            return;
        }
        
        level thread function_56c844d68dbe3629();
    #/
}

// Namespace ztron_dev
// Params 0
// Checksum 0x59b318bd, Offset: 0x2d18
// Size: 0x452
function function_56c844d68dbe3629()
{
    self notify( #"hash_da070886ed3fd56a" );
    self endon( #"hash_da070886ed3fd56a" );
    level endon( #"ztron_game_is_over", #"hash_d264839d1625d6b8" );
    var_bfd56d2dde97cde6 = 0;
    minuteavg = 0;
    var_12693c4016e5badc = 0;
    houravg = 0;
    var_166b1f233a929b39 = [];
    var_16239db1898b8f9f = [];
    
    if ( !isdefined( level.ztron.var_583f8d32fca61676 ) )
    {
        level.ztron.var_583f8d32fca61676 = [];
    }
    
    while ( true )
    {
        waitframe();
        
        if ( !isdefined( level.ztron.gamestarted ) )
        {
            continue;
        }
        
        anchorx = 1400;
        anchory = 50;
        totaltime = 0;
        totaltime = level.ztron.dev.var_c9eec3bd4fb84fe3;
        maxexpected = int( totaltime * 13.3 );
        var_2a728f3d98171fc3 = int( utility::function_6f5d2e1f1ff70482( gettime() - level.ztron.gamestarted ) );
        currenty = anchory;
        currenty = function_2a85d656a1ace652( anchorx, currenty, "XP AWARD STATS", 3 );
        currenty = function_2a85d656a1ace652( anchorx, currenty, "TOTAL GAME TIME: " + var_2a728f3d98171fc3 );
        currenty = function_2a85d656a1ace652( anchorx, currenty, "ACTIVE XP GAME TIME: " + totaltime, undefined, level utility::flag( "ztron_round_spawning" ) ? undefined : ( 1, 0, 0 ) );
        awardxp = [ 0, 0, 0, 0 ];
        idx = 0;
        
        foreach ( player in level.players )
        {
            if ( isbot( player ) )
            {
                continue;
            }
            
            if ( !isdefined( level.ztron.var_583f8d32fca61676[ player.name ] ) )
            {
                level.ztron.var_583f8d32fca61676[ player.name ] = 0;
            }
            
            if ( isdefined( player.ztron.var_2a330d09d47a2e6c[ level.ztron.roundnumber ] ) && ztron_main::function_4da200e9b8d58a3c() == 1 )
            {
                var_f6a97c4e3bbfc7d6 = player.ztron.var_2a330d09d47a2e6c[ level.ztron.roundnumber ];
            }
            else
            {
                xp = player ztron_score::function_9c413f7b3e5eebb8();
                awardxp[ idx ] += xp.awardxp;
                var_f6a97c4e3bbfc7d6 = awardxp[ idx ];
            }
            
            text = " PLAYER[" + player.name + "] Current RoundXP: " + var_f6a97c4e3bbfc7d6;
            currenty = function_2a85d656a1ace652( anchorx, currenty, text, undefined, player.ztron.allowxp ? undefined : ( 1, 0.6, 0 ) );
            
            if ( isdefined( level.ztron.var_583f8d32fca61676[ player.name ] ) )
            {
                totalxp = level.ztron.var_583f8d32fca61676[ player.name ] + awardxp[ idx ];
                text = " TOTAL: " + totalxp;
                houravg = player ztron_score::function_ec39c4ec5e5ffdca();
                text += " AVG XP/HOUR: " + int( houravg );
                currenty = function_2a85d656a1ace652( anchorx, currenty, text );
                
                if ( var_2a728f3d98171fc3 < 3600 && var_2a728f3d98171fc3 > 0 )
                {
                    projectedavg = totalxp / var_2a728f3d98171fc3 / 3600;
                    text = " (PROJECTED AVG XP/HOUR: " + int( projectedavg ) + ")";
                    currenty = function_2a85d656a1ace652( anchorx, currenty, text );
                }
            }
            
            idx++;
        }
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0x79a838d7, Offset: 0x3172
// Size: 0xa4
function function_92b3e330e09dc5()
{
    if ( !isdefined( level.ztron.dev.var_40f505561fb305f2 ) )
    {
        level.ztron.dev.var_40f505561fb305f2 = 0;
    }
    
    level.ztron.dev.var_40f505561fb305f2 = !level.ztron.dev.var_40f505561fb305f2;
    level.ztron.dev.var_737189a81cc87d18 = 0;
    level thread enemystats();
}

// Namespace ztron_dev
// Params 0
// Checksum 0x10f84800, Offset: 0x321e
// Size: 0x98
function enemystats()
{
    /#
        if ( level.ztron.dev.var_737189a81cc87d18 )
        {
            level.ztron.dev.var_737189a81cc87d18 = 0;
            level notify( #"hash_51bf243a085210ba" );
            return;
        }
        
        level.ztron.dev.var_737189a81cc87d18 = 1;
        level thread function_c00c98295e41f5b4( level.ztron.dev.var_40f505561fb305f2 );
    #/
}

// Namespace ztron_dev
// Params 0
// Checksum 0x7622c676, Offset: 0x32be
// Size: 0x701
function function_87283d3e0f8eaa0b()
{
    self notify( #"hash_830ce05228037f0e" );
    self endon( #"hash_830ce05228037f0e" );
    level endon( #"ztron_game_is_over", #"hash_5831312eb5839998" );
    
    if ( !isdefined( level.ztron.dev.var_7d786ddd19dcf4b3 ) )
    {
        level.ztron.dev.var_7d786ddd19dcf4b3 = 0;
    }
    
    if ( !isdefined( level.ztron.dev.curround ) )
    {
        level.ztron.dev.curround = 0;
    }
    
    while ( true )
    {
        if ( isdefined( level.ztron.active_arena ) && ztron_main::function_4da200e9b8d58a3c() == 1 )
        {
            if ( level.ztron.dev.curround != level.ztron.roundnumber )
            {
                level.ztron.dev.curround = level.ztron.roundnumber;
                level.ztron.dev.var_7d786ddd19dcf4b3 = 0;
            }
            
            var_4644e9154126f5d8 = ztron_util::function_cdd411b0cc1f9d80().size;
            
            if ( var_4644e9154126f5d8 > level.ztron.dev.var_7d786ddd19dcf4b3 )
            {
                level.ztron.dev.var_7d786ddd19dcf4b3 = var_4644e9154126f5d8;
            }
            
            allents = getentarray();
            entnum = isdefined( allents ) ? allents.size : 0;
            
            if ( isdefined( level.ztron.var_b275489e2025310b ) && level.ztron.var_b275489e2025310b.size )
            {
                if ( isdefined( level.ztron.var_b275489e2025310b[ level.ztron.game_laps ] ) )
                {
                    var_1f8d77358ed2688b = level.ztron.var_b275489e2025310b[ level.ztron.game_laps ] - level.ztron.game_starttime;
                    timesec = var_1f8d77358ed2688b / 1000;
                    ztron_debug::function_7a494955e7b24aa3( 1400, 560, "PapabackTime: " + timesec + " Game Laps: " + level.ztron.game_laps, ( 1, 1, 0 ), level.framedurationseconds, 3 );
                }
            }
            
            ztron_debug::function_7a494955e7b24aa3( 1400, 600, "Round Number: " + level.ztron.roundnumber, ( 1, 1, 0 ), level.framedurationseconds, 3 );
            
            if ( isdefined( level.ztron.active_arena.var_f3d2bdcb7cafb15b ) )
            {
                ztron_debug::function_7a494955e7b24aa3( 1400, 640, "Number Enemy: " + var_4644e9154126f5d8 + "   High AI Watermark: " + level.ztron.dev.var_7d786ddd19dcf4b3 + "/(" + level.ztron.active_arena.var_f3d2bdcb7cafb15b + ")  GateDelay: " + level.ztron.waitdelay, ( 1, 1, 0 ), level.framedurationseconds, 3 );
            }
            
            ztron_debug::function_7a494955e7b24aa3( 1400, 680, "Enemy Speed: " + level.ztron.zombie_base_speed, ( 1, 1, 0 ), level.framedurationseconds, 3 );
            ztron_debug::function_7a494955e7b24aa3( 1400, 720, "Enemy Base Health: " + level.ztron.var_f1569c16a29ffcbf, ( 1, 1, 0 ), level.framedurationseconds, 3 );
            ztron_debug::function_7a494955e7b24aa3( 1400, 760, "AntiKite Score: " + level.ztron.var_316dc0679575bf4d, level.ztron.var_316dc0679575bf4d >= 15 ? ( 1, 0, 0 ) : ( 1, 1, 0 ), level.framedurationseconds, 3 );
            ztron_debug::function_7a494955e7b24aa3( 1400, 800, "Entity Count: " + entnum, ( 1, 1, 0 ), level.framedurationseconds, 3 );
            ztron_debug::function_7a494955e7b24aa3( 1400, 840, "Gates Open: " + function_bf2900742ef6e3ea(), ( 1, 1, 0 ), level.framedurationseconds, 3 );
            y = 880;
            
            if ( !level.ztron.var_477ba2c6e6ba2820 )
            {
                ztron_debug::function_7a494955e7b24aa3( 1400, 880, "MIN Kill Count: " + level.ztron.curkillcount + "(" + level.ztron.var_efb770b1e9386f4d + ")", ( 1, 1, 0 ), level.framedurationseconds, 3 );
                ztron_debug::function_7a494955e7b24aa3( 1400, 920, "MIN Round Time: (" + level.ztron.var_51b2b203836e3a1d + "/" + level.ztron.var_e839340c881d4d4d + ")", ( 1, 1, 0 ), level.framedurationseconds, 3 );
                y = 1000;
            }
            
            foreach ( player in level.players )
            {
                ztron_debug::function_7a494955e7b24aa3( 1400, y, player.name + " enemy count: " + player.ztron.load + ( player.inlaststand ? " [LASTSTAND]" : " " ) + ( player.ignoreme ? " [IGNOREME]" : " " ) + ( player.ztron.campactive ? " [CAMPER]" : " " ), ( 1, 1, 0 ), level.framedurationseconds, 3 );
                y += 40;
            }
        }
        
        waitframe();
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0xe6ba3ff5, Offset: 0x39c7
// Size: 0x9f
function function_bf2900742ef6e3ea()
{
    var_e648f45ad613cd19 = ztron_arena::function_21c084afaad504ad();
    var_9cadfc7253035d4 = "";
    
    foreach ( gate in var_e648f45ad613cd19 )
    {
        var_9cadfc7253035d4 += ztron_arena::function_3f9984ab3a243167( gate ) + " ";
    }
    
    return var_9cadfc7253035d4;
}

// Namespace ztron_dev
// Params 0
// Checksum 0xc5bb3648, Offset: 0x3a6f
// Size: 0x115
function function_9483990e6e104710()
{
    self notify( #"hash_7fc05fd2e0f4f77f" );
    self endon( #"hash_7fc05fd2e0f4f77f" );
    level endon( #"ztron_game_is_over", #"hash_b67d55d94d8bfa88" );
    y = 50;
    
    while ( true )
    {
        if ( isdefined( level.ztron.active_arena ) && ztron_main::function_4da200e9b8d58a3c() == 1 )
        {
            ztron_debug::function_7a494955e7b24aa3( 1400, y, "Round Number: " + level.ztron.roundnumber, ( 1, 1, 0 ), level.framedurationseconds, 3 );
            ztron_debug::function_7a494955e7b24aa3( 1400, y + 40, "Round " + level.ztron.roundnumber + " enemy count: " + level.ztron.var_e07e459726c5c945[ level.ztron.roundnumber ], ( 1, 1, 0 ), level.framedurationseconds, 3 );
        }
        
        waitframe();
    }
}

// Namespace ztron_dev
// Params 5
// Checksum 0x74fe880c, Offset: 0x3b8c
// Size: 0x6d
function function_2a85d656a1ace652( x, y, text, scale = 1, color = ( 1, 1, 1 ) )
{
    ztron_debug::function_7a494955e7b24aa3( x, y, text, color, level.framedurationseconds, scale );
    return y + 20 * scale;
}

// Namespace ztron_dev
// Params 0
// Checksum 0xa272f6d5, Offset: 0x3c02
// Size: 0x2ed
function itemstats_internal()
{
    self notify( #"hash_db852df5a84dd318" );
    self endon( #"hash_db852df5a84dd318" );
    level endon( #"ztron_game_is_over", #"hash_a9aba5334d4c00a1" );
    anchorx = 1400;
    anchory = 50;
    
    while ( true )
    {
        waitframe();
        sorted = arraysort( level.ztron.itemdef.itemdata, undefined, &function_e337ed452f2d064e );
        currenty = anchory;
        currenty = function_2a85d656a1ace652( anchorx, currenty, "ITEM STATS", 3 );
        currenty = function_2a85d656a1ace652( anchorx, currenty, "PERCENT\tCOUNT\tNAME\tMIN ROUND\tLAST ROUNDTCOOL DOWN", 3 );
        idx = 1;
        total = 0;
        totalitems = 0;
        
        foreach ( item in sorted )
        {
            if ( !isdefined( item.typeflag ) || !( level.ztron.dev.var_40361780fc8f1b5b & item.typeflag ) )
            {
                continue;
            }
            
            total++;
            totalitems += item.count;
        }
        
        foreach ( item in sorted )
        {
            if ( !isdefined( item.typeflag ) || !( level.ztron.dev.var_40361780fc8f1b5b & item.typeflag ) )
            {
                continue;
            }
            
            percentage = 0;
            
            if ( totalitems > 0 )
            {
                percentage = item.count / totalitems * 100;
                percentage = int( percentage * 10 ) / 10;
            }
            
            text = idx + ")\t" + percentage + "%\t" + item.count + "\t" + item.ref + "\t" + item.var_8b8dc2f3047eeb5c + "\t" + item.var_da70ec7bd68f8687 + "\t(" + item.cooldown + ")";
            currenty = function_2a85d656a1ace652( anchorx, currenty, text, 2 );
            idx++;
        }
    }
}

/#

    // Namespace ztron_dev
    // Params 0
    // Checksum 0xb6ff6022, Offset: 0x3ef7
    // Size: 0x7b, Type: dev
    function basicstats()
    {
        if ( level.ztron.dev.var_75a1122534a233e )
        {
            level.ztron.dev.var_75a1122534a233e = 0;
            level notify( #"hash_5831312eb5839998" );
            return;
        }
        
        level.ztron.dev.var_75a1122534a233e = 1;
        level thread function_87283d3e0f8eaa0b();
    }

    // Namespace ztron_dev
    // Params 0
    // Checksum 0x451a52cd, Offset: 0x3f7a
    // Size: 0x7b, Type: dev
    function function_7b7c416a44f981c2()
    {
        if ( level.ztron.dev.var_77f20cbf0b598425 )
        {
            level.ztron.dev.var_77f20cbf0b598425 = 0;
            level notify( #"hash_b67d55d94d8bfa88" );
            return;
        }
        
        level.ztron.dev.var_77f20cbf0b598425 = 1;
        level thread function_9483990e6e104710();
    }

#/

// Namespace ztron_dev
// Params 2
// Checksum 0xd9fef3ac, Offset: 0x3ffd
// Size: 0xb1, Type: bool
function function_e337ed452f2d064e( lhs, rhs )
{
    var_3194e7327c148a72 = ( lhs.count > rhs.count ? 2 : 0 ) + ( lhs.minround < rhs.minround ? 1 : 0 );
    var_711175336662bcc8 = ( rhs.count > lhs.count ? 2 : 0 ) + ( rhs.minround < lhs.minround ? 1 : 0 );
    return var_3194e7327c148a72 > var_711175336662bcc8;
}

/#

    // Namespace ztron_dev
    // Params 0
    // Checksum 0xe6f90688, Offset: 0x40b7
    // Size: 0x9b, Type: dev
    function function_bf1d7710e857cb90()
    {
        if ( level.ztron.dev.var_76d2e7c5f5a9d35f )
        {
            level.ztron.dev.var_76d2e7c5f5a9d35f = 0;
            level notify( #"hash_a9aba5334d4c00a1" );
            return;
        }
        
        level.ztron.dev.var_76d2e7c5f5a9d35f = 1;
        level.ztron.dev.var_40361780fc8f1b5b = 15;
        level thread itemstats_internal();
    }

#/

// Namespace ztron_dev
// Params 0
// Checksum 0xd7afe811, Offset: 0x415a
// Size: 0x21
function function_76ebaa87b84005dd()
{
    InvalidOpCode( 0x5e, 1, level.ztron.dev.var_40361780fc8f1b5b );
    // Unknown operator ( 0x5e, t11, Black Ops 7 )
}

// Namespace ztron_dev
// Params 0
// Checksum 0x23eae5b3, Offset: 0x41a2
// Size: 0x21
function function_7a0c4b6582716d55()
{
    InvalidOpCode( 0x5e, 2, level.ztron.dev.var_40361780fc8f1b5b );
    // Unknown operator ( 0x5e, t11, Black Ops 7 )
}

// Namespace ztron_dev
// Params 0
// Checksum 0x5b703fa3, Offset: 0x41ea
// Size: 0x21
function function_1569c20c8b61aa40()
{
    InvalidOpCode( 0x5e, 4, level.ztron.dev.var_40361780fc8f1b5b );
    // Unknown operator ( 0x5e, t11, Black Ops 7 )
}

// Namespace ztron_dev
// Params 0
// Checksum 0x4f7b7be1, Offset: 0x4232
// Size: 0x21
function function_e7cd52edb863bedf()
{
    InvalidOpCode( 0x5e, 8, level.ztron.dev.var_40361780fc8f1b5b );
    // Unknown operator ( 0x5e, t11, Black Ops 7 )
}

// Namespace ztron_dev
// Params 0
// Checksum 0x7da8c080, Offset: 0x427a
// Size: 0xcd
function function_c7c80230c9a85()
{
    self notify( #"hash_30c946eccd017c38" );
    self endon( #"hash_30c946eccd017c38" );
    level endon( #"ztron_game_is_over" );
    self endon( #"hash_59b92a2b53992257" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        if ( self.ztron.score.lives <= 3 )
        {
            ztron_score::givelives( 9 );
        }
        
        if ( self.ztron.score.bombs <= 1 )
        {
            namespace_a6a7fe92789f4ad9::function_8cab6adef8e1bef2( 9 );
        }
        
        if ( self.ztron.score.var_59f1f1595961cbe <= 1 )
        {
            namespace_33e886a9a5b55137::function_992dffefa33a9534( 9 );
        }
        
        wait 1;
    }
}

// Namespace ztron_dev
// Params 1
// Checksum 0x415d9e88, Offset: 0x434f
// Size: 0xf8
function kingme( force = 0 )
{
    /#
        level endon( #"ztron_game_is_over" );
        
        foreach ( player in level.players )
        {
            if ( force || !player.ztron.kingme )
            {
                player.ztron.kingme = 1;
                player thread function_c7c80230c9a85();
                continue;
            }
            
            player.ztron.kingme = undefined;
            player notify( #"hash_59b92a2b53992257" );
        }
    #/
}

// Namespace ztron_dev
// Params 0
// Checksum 0x5f3572b2, Offset: 0x444f
// Size: 0xb7
function kingall()
{
    while ( !isdefined( level.players ) || level.players.size == 0 )
    {
        wait 1;
    }
    
    level.ztron.kingme = 1;
    
    foreach ( player in level.players )
    {
        player kingme( 1 );
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0xb2169282, Offset: 0x450e
// Size: 0x75
function function_9fd6829ba7fb8969()
{
    if ( level.players.size > 1 )
    {
        valid = [];
        
        for ( i = 1; i < level.players.size ; i++ )
        {
            if ( isdefined( level.players[ i ] ) )
            {
                valid[ valid.size ] = level.players[ i ] getentitynumber();
            }
        }
        
        kick( valid[ randomint( valid.size ) ] );
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0x30580f05, Offset: 0x458b
// Size: 0xd3
function function_a192c327fc9c81ad()
{
    self notify( #"hash_721e7c69426a6762" );
    self endon( #"hash_721e7c69426a6762" );
    setdvar( @"hash_15753dcd4cbf487", 1 );
    
    /#
        if ( level.ztron.dev.var_fd17659ef5557a41 )
        {
            ztron_debug::debugmsg( "<dev string:xabd>" );
            level.ztron.dev.var_fd17659ef5557a41 = 0;
            level notify( #"hash_12d79bc0fed4ee5a" );
        }
        else
        {
            ztron_debug::debugmsg( "<dev string:xad4>" );
            level.ztron.dev.var_fd17659ef5557a41 = 1;
            level thread function_31efe2395a073871();
            level thread kingall();
        }
        
        setdvar( @"bot_disableallai", 1 );
    #/
}

// Namespace ztron_dev
// Params 0, eflags: 0xc
// Checksum 0x716b6d12, Offset: 0x4666
// Size: 0xd9
function private function_6fafa7970dc99ff0()
{
    self notify( #"hash_9d142cc8852276bb" );
    self endon( #"hash_9d142cc8852276bb" );
    
    while ( level.ztron.dev.var_fd17659ef5557a41 )
    {
        waitframe();
        
        if ( !level.ztron || !level.ztron.var_8a9067aa4cd65369 )
        {
            continue;
        }
        
        room = level.ztron.var_8a9067aa4cd65369;
        
        switch ( room.type )
        {
            case #"hash_9cbfc152ded8c43":
                level function_707062c377f5e8fe( room );
                break;
            case #"hash_39f2e38de2fe6593":
                level function_8f86fdb70ba67ac6( room );
                break;
            default:
                break;
        }
    }
}

// Namespace ztron_dev
// Params 1, eflags: 0x4
// Checksum 0xe44aee2d, Offset: 0x4747
// Size: 0x1d8
function private function_707062c377f5e8fe( room )
{
    if ( !isdefined( room.roomtrigger ) )
    {
        return;
    }
    
    if ( room.roomtrigger function_b0b72d20769d0233() )
    {
        level.ztron.dev.var_a10d64d38e39316e = 1;
    }
    
    if ( !isdefined( level.ztron.dev.var_738ee1290aa3b222 ) )
    {
        level.ztron.dev.var_738ee1290aa3b222 = 0;
        level childthread function_aebc985a6e71b5f4();
    }
    
    level.ztron.dev.var_738ee1290aa3b222 += level.framedurationseconds;
    
    if ( level.ztron.dev.var_738ee1290aa3b222 <= randomintrange( int( 60 ), int( 120 ) ) )
    {
        return;
    }
    
    level notify( #"hash_e937c19bfb7cb725" );
    
    if ( level.ztron.dev.var_a10d64d38e39316e )
    {
        playerindex = randomint( level.players.size );
        p = level.players[ playerindex ];
        
        if ( isdefined( p ) )
        {
            p ztron_util::teleport_player( room.roomtrigger.origin, p.angles );
        }
        
        level.ztron.dev.var_738ee1290aa3b222 /= 2;
    }
}

// Namespace ztron_dev
// Params 0, eflags: 0xc
// Checksum 0x3b956f49, Offset: 0x4927
// Size: 0x61
function private function_aebc985a6e71b5f4()
{
    self notify( #"hash_78553bcf998ae22f" );
    self endon( #"hash_78553bcf998ae22f" );
    level waittill( #"bonus_room_expired" );
    level.ztron.dev.var_738ee1290aa3b222 = undefined;
    level.ztron.dev.var_a10d64d38e39316e = undefined;
}

// Namespace ztron_dev
// Params 1, eflags: 0x4
// Checksum 0x8378513f, Offset: 0x4990
// Size: 0x1b8
function private function_8f86fdb70ba67ac6( room )
{
    if ( !isdefined( level.ztron.dev.var_5debe7840028c366 ) )
    {
        level.ztron.dev.var_5debe7840028c366 = 0;
        level childthread function_6f690421427ed2e8();
        wait 5;
        return;
    }
    
    level.ztron.dev.var_5debe7840028c366 += level.framedurationseconds;
    
    if ( level.ztron.dev.var_5debe7840028c366 < 1 )
    {
        return;
    }
    
    level.ztron.dev.var_5debe7840028c366 = 0;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.ztron.racingbooster ) && randomint( 100 ) < 60 )
        {
            player notify( #"ztron_racing_input_booster" );
        }
        
        if ( isdefined( player.ztron.lapscount ) && randomint( 100 ) < 8 )
        {
            level notify( #"hash_80159d2dceecdcaa", player );
        }
    }
}

// Namespace ztron_dev
// Params 0, eflags: 0xc
// Checksum 0x48cc6391, Offset: 0x4b50
// Size: 0x44
function private function_6f690421427ed2e8()
{
    self notify( #"hash_4627fdb738182b28" );
    self endon( #"hash_4627fdb738182b28" );
    level waittill( #"bonus_room_expired" );
    level.ztron.dev.var_5debe7840028c366 = undefined;
}

// Namespace ztron_dev
// Params 0, eflags: 0x4
// Checksum 0xa2c4cb7b, Offset: 0x4b9c
// Size: 0xb8
function private function_cc56d9501f53e78d()
{
    if ( !level.ztron.active_arena )
    {
        return;
    }
    
    switch ( level.ztron.active_arena.name )
    {
        case #"hash_f6a69f4bf9bd072":
            trigger = ztron_util::function_95ca81ff822c3de4( "ritual_shaft_trigger", #targetname );
            
            if ( trigger && trigger function_b0b72d20769d0233() && trigger.isdisabled == 0 )
            {
                trigger notify( #"trigger", level.players[ 0 ] );
            }
            
            wait 2;
            break;
        default:
            break;
    }
}

// Namespace ztron_dev
// Params 0
// Checksum 0xcaa99c64, Offset: 0x4c5c
// Size: 0x623
function function_31efe2395a073871()
{
    self notify( #"hash_c1f199ee6ada2f39" );
    self endon( #"hash_c1f199ee6ada2f39" );
    
    /#
        level endon( #"hash_12d79bc0fed4ee5a", #"ztron_game_is_over" );
        
        while ( level.players.size == 0 || !level.ztron.game_running )
        {
            wait 1;
        }
        
        wait 5;
        lowwait = 1;
        highwait = 2;
        var_c1a0e3a07964238c = 26;
        var_92eb74a055fbcd12 = 15;
        level childthread function_6fafa7970dc99ff0();
        
        while ( level.ztron.dev.var_fd17659ef5557a41 )
        {
            waitframe();
            
            if ( isdefined( level.ztron.slayer.var_41aef428e6e941da ) )
            {
                wait 5;
                
                if ( isdefined( level.ztron.slayer.var_41aef428e6e941da ) )
                {
                    level.players[ 0 ] setorigin( level.ztron.slayer.var_41aef428e6e941da.origin, 1 );
                }
            }
            
            if ( level.ztron.var_9cb1ea9ce77759 || isdefined( level.ztron.var_3678ff7453f3c5cf ) )
            {
                continue;
            }
            
            if ( level.ztron.active_arena.openexits.size > 0 )
            {
                wait 8;
                
                if ( level.ztron.var_9cb1ea9ce77759 || isdefined( level.ztron.var_3678ff7453f3c5cf ) )
                {
                    continue;
                }
                
                if ( level.ztron.active_arena.openexits.size > 0 )
                {
                    exit = level.ztron.active_arena.openexits[ randomint( level.ztron.active_arena.openexits.size ) ];
                    
                    if ( isdefined( exit ) )
                    {
                        exit notify( #"trigger", level.players[ 0 ] );
                    }
                }
            }
            else if ( isdefined( level.ztron.active_arena.teleportertrigger ) )
            {
                level notify( #"ztron_teleporter_taken" );
            }
            else
            {
                function_cc56d9501f53e78d();
            }
            
            if ( !( getdvarint( @"hash_517fccfd38c46a0", 0 ) >= 1 ) )
            {
                if ( level.players.size < 4 && !isdefined( level.ztron.var_8a9067aa4cd65369 ) )
                {
                    if ( randomint( 100 ) < var_c1a0e3a07964238c )
                    {
                        howmany = 4 - level.players.size;
                        toadd = randomint( howmany ) + 1;
                        bots::spawn_bots( toadd, "<dev string:xaea>" );
                        wait 1;
                        
                        foreach ( player in level.players )
                        {
                            if ( isbot( player ) )
                            {
                                player.ztron.vehicleblocked = 1;
                                
                                if ( level.ztron.kingme && !player.ztron.kingme )
                                {
                                    player thread kingme( 1 );
                                }
                            }
                        }
                        
                        if ( level.currentclientmatchdataid >= 190 )
                        {
                            level.currentclientmatchdataid = 10;
                        }
                    }
                }
                
                if ( level.players.size > 1 )
                {
                    time = gettime();
                    
                    if ( randomint( 100 ) < var_92eb74a055fbcd12 )
                    {
                        valid = [];
                        
                        for ( i = 1; i < level.players.size ; i++ )
                        {
                            if ( isdefined( level.players[ i ] ) && time > level.players[ i ].birthtime + 15000 )
                            {
                                valid[ valid.size ] = level.players[ i ] getentitynumber();
                            }
                        }
                        
                        if ( valid.size != 0 )
                        {
                            var_e7a586e546b18833 = randomint( valid.size ) + 1;
                            
                            if ( var_e7a586e546b18833 > 0 )
                            {
                                ztron_debug::debugmsg( "<dev string:xaf1>" + var_e7a586e546b18833 + "<dev string:xafb>" );
                                
                                for ( i = 0; i < var_e7a586e546b18833 ; i++ )
                                {
                                    ztron_debug::debugmsg( "<dev string:xb01>" + valid[ i ] );
                                    kick( valid[ i ] );
                                }
                            }
                        }
                    }
                }
            }
            
            foreach ( player in level.players )
            {
                if ( player isufo() )
                {
                    continue;
                }
                
                if ( !isdefined( player.ztron.color ) )
                {
                    continue;
                }
                
                roll = randomint( 100 );
                
                if ( roll <= 6 )
                {
                    player.ztron.var_5c7b8be5ec856295 = 1;
                    ztron_debug::debugmsg( "<dev string:xb0f>" + player.ztron.color + "<dev string:xb18>" + player.ztron.score.bombs );
                }
                
                player thread function_4e0d4df061f0d52b();
            }
            
            wait randomfloatrange( lowwait, highwait );
            
            while ( level utility::flag( "<dev string:xb39>" ) )
            {
                wait 0.25;
            }
        }
    #/
}

/#

    // Namespace ztron_dev
    // Params 0
    // Checksum 0x5bfc4b77, Offset: 0x5287
    // Size: 0xab, Type: dev
    function function_fd32519ef573aa4f()
    {
        if ( level.ztron.dev.var_fd17659ef5557a41 )
        {
            ztron_debug::debugmsg( "<dev string:xb4c>" );
            level.ztron.dev.var_fd17659ef5557a41 = 0;
            level notify( #"hash_12d79bc0fed4ee5a" );
        }
        else
        {
            ztron_debug::debugmsg( "<dev string:xb5e>" );
            level.ztron.dev.var_fd17659ef5557a41 = 1;
            level thread function_31efe2395a073871();
            level thread kingall();
        }
        
        setdvar( @"bot_disableallai", 1 );
    }

#/

// Namespace ztron_dev
// Params 0
// Checksum 0xc6fc5ac0, Offset: 0x533a
// Size: 0x194
function function_4e0d4df061f0d52b()
{
    self notify( #"hash_da555b3f2586ff3" );
    self endon( #"hash_da555b3f2586ff3" );
    self endon( #"disconnect" );
    level endon( #"hash_12d79bc0fed4ee5a", #"ztron_game_is_over" );
    boostchain = 0;
    
    if ( self isufo() || self isnoclip() )
    {
        self.ztron.forceboost = 0;
        wait 1;
        return;
    }
    
    if ( randomint( 100 ) > 50 )
    {
        var_45c91b497d932ac9 = undefined;
        
        if ( level.ztron.itemdef.spawneditems.size > 0 )
        {
            var_45c91b497d932ac9 = level.ztron.itemdef.spawneditems[ randomint( level.ztron.itemdef.spawneditems.size ) ];
        }
        
        if ( isdefined( var_45c91b497d932ac9 ) )
        {
            function_5980f12381ac8e59( var_45c91b497d932ac9.origin );
        }
        
        return;
    }
    
    if ( boostchain == 0 )
    {
    }
    
    for ( boostchain = randomint( 7 ) + 1; boostchain ; boostchain-- )
    {
        if ( self isufo() || self isnoclip() )
        {
            break;
        }
        
        self.ztron.forceboost = 1;
        
        if ( self.ztron.var_40578ab5a6caa4dd )
        {
            self notify( #"ztron_boost" );
        }
        
        angles = ( 0, randomint( 360 ), 0 );
        self setplayerangles( angles );
        wait 0.5;
    }
}

// Namespace ztron_dev
// Params 1
// Checksum 0xbafdc3bc, Offset: 0x54d6
// Size: 0x162
function function_5980f12381ac8e59( origintarget )
{
    self notify( #"hash_25c61df4cbb1b83" );
    self endon( #"hash_25c61df4cbb1b83" );
    self endon( #"disconnect" );
    wait randomfloatrange( 0.1, 1 );
    
    if ( self isufo() || self isnoclip() )
    {
        return;
    }
    
    level thread ztron_debug::draw_circle( origintarget + ( 0, 0, 20 ), 30, self.ztron.colorrgb, 1, 1 );
    level thread ztron_debug::drawline( self.origin + ( 0, 0, 20 ), origintarget + ( 0, 0, 20 ), 1, self.ztron.colorrgb );
    yaw = ztron_util::getyaw2d( origintarget, self.origin );
    angles = ( 0, yaw, 0 );
    self setplayerangles( angles );
    self.ztron.forceboost = 1;
    
    if ( self.ztron.var_40578ab5a6caa4dd )
    {
        self notify( #"ztron_boost" );
    }
    
    ztron_debug::debugmsg( "Bot is boosting at target origin:" + origintarget + ".  Boosts Left:" + self.ztron.score.var_59f1f1595961cbe );
}

// Namespace ztron_dev
// Params 1, eflags: 0x4
// Checksum 0xfab0d17e, Offset: 0x5640
// Size: 0x9f
function private function_60996593320c0322( var_c7f34dfc716dbe14 )
{
    var_145a360d76775048 = var_c7f34dfc716dbe14 - 1;
    
    foreach ( p in level.players )
    {
        if ( p.sessionuimemberindex == var_145a360d76775048 )
        {
            return p;
        }
    }
}

// Namespace ztron_dev
// Params 0, eflags: 0x4
// Checksum 0x91abb329, Offset: 0x56e7
// Size: 0x20
function private function_7e3fe1444542e1a4()
{
    if ( level.players.size < 4 )
    {
        bots::spawn_bots( 1, "allies" );
    }
}

// Namespace ztron_dev
// Params 1, eflags: 0x4
// Checksum 0xacb6ade9, Offset: 0x570f
// Size: 0x30
function private function_7ba509da0203a401( playerindex )
{
    p = function_60996593320c0322( playerindex );
    
    if ( p )
    {
        kick( p getentitynumber() );
    }
}

// Namespace ztron_dev
// Params 0, eflags: 0x4
// Checksum 0xf90f39f1, Offset: 0x5747
// Size: 0xb
function private function_49bc88f97323838b()
{
    function_7ba509da0203a401( 2 );
}

// Namespace ztron_dev
// Params 0, eflags: 0x4
// Checksum 0x8e080966, Offset: 0x575a
// Size: 0xb
function private function_49bc87f973238158()
{
    function_7ba509da0203a401( 3 );
}

// Namespace ztron_dev
// Params 0, eflags: 0x4
// Checksum 0x106c9cc2, Offset: 0x576d
// Size: 0xb
function private function_49bc8ef9732390bd()
{
    function_7ba509da0203a401( 4 );
}

// Namespace ztron_dev
// Params 1, eflags: 0x4
// Checksum 0x6e797d58, Offset: 0x5780
// Size: 0x32
function private function_2b07fb83ff61cd78( var_c7f34dfc716dbe14 )
{
    p = function_60996593320c0322( var_c7f34dfc716dbe14 );
    
    if ( p )
    {
        p notify( #"ztron_racing_input_booster" );
    }
}

// Namespace ztron_dev
// Params 0, eflags: 0x4
// Checksum 0x63fff4d2, Offset: 0x57ba
// Size: 0xb
function private function_84c0a6466e397e1()
{
    function_2b07fb83ff61cd78( 1 );
}

// Namespace ztron_dev
// Params 0, eflags: 0x4
// Checksum 0xfa1d92d0, Offset: 0x57cd
// Size: 0xb
function private function_a9fdb3662aee654()
{
    function_2b07fb83ff61cd78( 2 );
}

// Namespace ztron_dev
// Params 0, eflags: 0x4
// Checksum 0x3b934d11, Offset: 0x57e0
// Size: 0xb
function private function_94979da61a0b5bff()
{
    function_2b07fb83ff61cd78( 3 );
}

// Namespace ztron_dev
// Params 0, eflags: 0x4
// Checksum 0x12a85895, Offset: 0x57f3
// Size: 0xb
function private function_93fca4ed48a1de2()
{
    function_2b07fb83ff61cd78( 4 );
}

// Namespace ztron_dev
// Params 0, eflags: 0x4
// Checksum 0x928cabc2, Offset: 0x5806
// Size: 0xa2
function private function_cab9aee8c8516f8d()
{
    targetplayer = level.players[ 0 ];
    
    foreach ( player in level.players )
    {
        if ( player != targetplayer )
        {
            player thread ztron_util::teleport_player( targetplayer.origin );
        }
    }
}

