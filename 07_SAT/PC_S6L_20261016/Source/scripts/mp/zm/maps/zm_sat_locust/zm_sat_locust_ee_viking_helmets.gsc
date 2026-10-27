// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_ee_viking_helmets.gsc  (hash_5aa50822d5a27fae.gscc) (size: 29413 Bytes / 0x72e5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x39d66caf (970353839)
// size ...... 29413 (0x72e5)
// includes .. 19  (offset: 0x6da1)
// strings ... 57  (offset: 0x6e39)
// dev strs .. 24  (offset: 0x71c1)
// exports ... 91  (offset: 0x4459)
// cseg ...... 0x51c + 0x3f3d (0x4459)
// imports ... 205 (offset: 0x5291)
// animtree1 . 0   (offset: 0x72e5)
// animtree2 . 0   (offset: 0x72e5)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\subclass_to_aitype_map;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\ammomods\cryofreeze;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_fergus;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\zm_powerups;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_locust_ee_viking_helmets;

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x5
// Checksum 0x1397c7a1, Offset: 0x53a
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"locust_ee_viking_helmets", #"zm_quest", &pre_main, &post_main );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x4
// Checksum 0xcd3246db, Offset: 0x567
// Size: 0x265
function private pre_main()
{
    if ( !getdvarint( @"hash_427ebffc772911dd", 0 ) || isusingmatchrulesdata() && !getmatchrulesdata( "zmData", "sideContentEnabled" ) || !getdvarint( @"hash_687f619ee7ed4723", 1 ) )
    {
        return;
    }
    
    level.viking_helmets = {};
    zm_quest::register_quest_step( #"locust_ee_viking_helmets", #"collect_helmets", &function_7d6d613ab952c071, &function_60062348e78b78d6 );
    zm_quest::register_quest_step( #"locust_ee_viking_helmets", #"hash_eabbf2a5d557394b", &function_7d6d613ab952c071, &function_60062348e78b78d6 );
    zm_quest::register_quest_step( #"locust_ee_viking_helmets", #"fishing_requirements", &function_401039ddb9f83f1, &function_83c8ab698e3c8b5e );
    zm_quest::register_quest_step( #"locust_ee_viking_helmets", #"hash_fc7784e7cbab98f0", &function_401009ddb9f7d58, &function_83c8aa698e3c892b );
    zm_quest::register_quest_step( #"locust_ee_viking_helmets", #"hash_c077c657dc228dbc", &function_401019ddb9f7f8b, &function_83c8a9698e3c86f8 );
    zm_quest::register_quest_step( #"locust_ee_viking_helmets", #"hash_eabbf3a5d5573afe", &function_7d6d5e3ab952b9d8, &function_60062248e78b76a3 );
    zm_quest::register_quest_step( #"locust_ee_viking_helmets", #"hash_6c7535e070b12000", &function_d83b7c9dbb71bb4c, &function_7820966986bcfeef );
    zm_quest::register_quest_step( #"locust_ee_viking_helmets", #"hash_cae50793bacd1cf2", &function_d83b7f9dbb71c1e5, &function_7820976986bd0122 );
    zm_quest::register_quest_step( #"locust_ee_viking_helmets", #"hash_eabbf4a5d5573cb1", &function_7d6d5f3ab952bc0b, &function_60062148e78b7470 );
    zm_quest::register_quest_step( #"locust_ee_viking_helmets", #"hash_97614a87dd1e534f", &function_e963d59dc8feaa07, &function_66f87d6979309cf4 );
    zm_quest::register_quest_step( #"locust_ee_viking_helmets", #"hash_135604eccd97f7c4", &function_e963d69dc8feac3a, &function_66f880697930a38d );
    zm_quest::register_quest_step( #"locust_ee_viking_helmets", #"hash_a3fc4d1e6706df9e", &function_e963d79dc8feae6d, &function_66f87f697930a15a );
    zm_quest::register_quest_step( #"locust_ee_viking_helmets", #"hash_eabbf5a5d5573e64", &function_7d6d643ab952c70a, &function_60062848e78b83d5 );
    zm_quest::register_quest_step( #"locust_ee_viking_helmets", #"blizzard_requirements", &function_31f8869dfe36254a, &function_cc5da069c3749c2d );
    zm_quest::register_quest_step( #"locust_ee_viking_helmets", #"hash_2735a18ead53ba04", &function_31f8859dfe362317, &function_cc5d9d69c3749594 );
    
    /#
        debug_init();
    #/
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x4
// Checksum 0x125735fe, Offset: 0x7d4
// Size: 0x134
function private post_main()
{
    if ( !getdvarint( @"hash_427ebffc772911dd", 0 ) || isusingmatchrulesdata() && !getmatchrulesdata( "zmData", "sideContentEnabled" ) || !getdvarint( @"hash_687f619ee7ed4723", 1 ) )
    {
        return;
    }
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level._effect[ "vernon_fr_blast" ] = loadfxasset( "vfx_sat_levels_zm_locust_ee_snow_frost_splash" );
    function_ea6f2dbd678d0eed();
    level callback::add( "quest_item_used", &on_quest_item_used );
    level callback::add( #"player_disconnect", &on_player_death_or_disconnect );
    level callback::add( #"player_death", &on_player_death_or_disconnect );
    level callback::add( #"frost_protected", &function_ef38fce87aeeecb0 );
    scene::function_85b13b837056bc8b( &function_14ce682629ea8ba8 );
    scene::function_53de0775d8452750( &function_275e0cba0fcffae );
    level callback::add( #"hash_f2c79b44bf002ece", &function_8fee08bed0cdbd0a );
    level callback::add( #"hash_95d2fe8a74e011f8", &function_c4ab2b9f58143912 );
    zm_save::function_1f44a48caae2acbf();
    function_3d03bf3da3f0b656();
    utility::flag_wait( "onStartGameTypeFinished" );
    level thread zm_quest::start_quest( #"locust_ee_viking_helmets" );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x4
// Checksum 0x94a8a951, Offset: 0x910
// Size: 0x129
function private function_ea6f2dbd678d0eed()
{
    helmet_locs = utility::getstructarray( "vi_he_lo" );
    
    foreach ( loc in helmet_locs )
    {
        loc.interact = utility::spawn_tag_origin( loc.origin, loc.angles );
        loc.interact show();
        loc.interact = interaction::register_interact( loc.interact, 60, &function_74493d55828a4008 );
        loc.interact.tag = "0" + loc.script_noteworthy;
        zm_sat_locust_util::function_295a36ef38f5acae( hashcat( #"hash_c32ac4093e90e6da", loc.script_noteworthy, "_collect" ), loc );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x2a7075b4, Offset: 0xa41
// Size: 0x9a
function private function_74493d55828a4008( player )
{
    if ( !player.viking_helmet || player.viking_helmet.tag != self.tag )
    {
        ref = hashcat( #"hash_976b52fe4177cc8e", self.tag, "_pickup" );
        
        if ( zm_sat_locust_util::function_3112dc4740eb8499( ref ) )
        {
            item = zm_sat_locust_util::get_quest_reference( ref );
            item freescriptable();
            function_298ba86edbab58e4();
        }
        
        return;
    }
    
    function_298ba86edbab58e4( player );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1
// Checksum 0x65b1244b, Offset: 0xae3
// Size: 0x162
function function_298ba86edbab58e4( player )
{
    spawn_params = { #spawntype:#"spawn_at_pos", #spawnangles:self.angles, #spawnorigin:self.origin, #asset:hashcat( %"hash_247de291bcbb1b2", self.tag ) };
    item = zm_sat_locust_util::spawn_quest_item( spawn_params );
    item.helmet_loc = self;
    item setscriptablepartstate( #"fx", #"spawn" );
    self setusableenabled( 0 );
    item function_7653c765b6c7b815();
    
    if ( function_eec511e63621dbf3( self ) )
    {
        if ( !self.interact_hint_callback )
        {
            interaction::set_interact_use_callback( &function_f2de5dadf36acca0 );
            interaction::set_interact_hint_callback( &function_8663d8848cd3e4f5 );
        }
        
        utility::delaycall( 1, &setusableenabled, 1 );
        self.helmet = item;
    }
    else
    {
        item utility::delaycall( 1, &function_e203bba36cfb19d0 );
    }
    
    ref = hashcat( #"hash_976b52fe4177cc8e", self.tag, "_pickup" );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( ref ) )
    {
        zm_sat_locust_util::function_222215ce3aef9da1( ref, item );
    }
    else
    {
        zm_sat_locust_util::function_295a36ef38f5acae( ref, item );
    }
    
    if ( player )
    {
        player function_58e4b5b8e3ef8b97();
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x63588a7b, Offset: 0xc4d
// Size: 0x10e
function private on_quest_item_used( params )
{
    scriptable_name = params.bundle.scriptable;
    
    if ( scriptable_name != %"zmloot_sat_locust_quest_vernon_01" && scriptable_name != %"zmloot_sat_locust_quest_vernon_02" && scriptable_name != %"zmloot_sat_locust_quest_vernon_03" && scriptable_name != %"zmloot_sat_locust_quest_vernon_04" )
    {
        return;
    }
    
    zm_sat_locust_util::function_63a23256772ea1b9( params.player );
    
    if ( params.scriptable.helmet_loc )
    {
        params.player function_388059f328ab68f( params.scriptable.helmet_loc.tag );
        params.scriptable.helmet_loc setusableenabled( 1 );
        return;
    }
    
    params.player function_be049f87a535cb47( params.scriptable.tag );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1
// Checksum 0xbf37a9fa, Offset: 0xd63
// Size: 0xb1
function function_be049f87a535cb47( helmet_type )
{
    if ( self.viking_helmet )
    {
        function_bd7ff9fe4999395d();
    }
    
    switch ( helmet_type )
    {
        case #"hash_f98495f6bce2af9a":
            function_6c77f81442c6c875();
            utility::flag_set( "vernon_01_c" );
            break;
        case #"hash_f98494f6bce2ae07":
            function_6c77f51442c6c1dc();
            utility::flag_set( "vernon_02_b" );
            break;
        case #"hash_f98493f6bce2ac74":
            function_6c77f61442c6c40f();
            utility::flag_set( "vernon_03_c" );
            break;
        case #"hash_f98492f6bce2aae1":
            function_6c77f31442c6bd76();
            utility::flag_set( "vernon_04_b" );
            break;
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1
// Checksum 0xbc05031d, Offset: 0xe1c
// Size: 0xb1
function function_388059f328ab68f( helmet_type )
{
    if ( self.viking_helmet )
    {
        function_bd7ff9fe4999395d( 1 );
        helmet_loc = function_a246dcbfe1789959( self.viking_helmet );
        helmet_loc.interact function_298ba86edbab58e4( self );
    }
    
    switch ( helmet_type )
    {
        case #"hash_f98495f6bce2af9a":
            function_6c77f81442c6c875();
            break;
        case #"hash_f98494f6bce2ae07":
            function_6c77f51442c6c1dc();
            break;
        case #"hash_f98493f6bce2ac74":
            function_6c77f61442c6c40f();
            break;
        case #"hash_f98492f6bce2aae1":
            function_6c77f31442c6bd76();
            break;
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1
// Checksum 0x57057582, Offset: 0xed5
// Size: 0x133
function function_bd7ff9fe4999395d( var_c7f8e8205f2e9b74 = 0 )
{
    helmet_type = hashcat( %"hash_247de291bcbb1b2", self.viking_helmet.tag );
    spawn_params = { #spawntype:#"hash_396d489cffb7196b", #spawningent:self, #asset:helmet_type };
    item = zm_sat_locust_util::spawn_quest_item( spawn_params );
    item.tag = self.viking_helmet.tag;
    
    if ( var_c7f8e8205f2e9b74 )
    {
        item freescriptable();
    }
    else
    {
        ref = hashcat( #"hash_976b52fe4177cc8e", self.viking_helmet.tag, "_pickup" );
        
        if ( zm_sat_locust_util::function_3112dc4740eb8499( ref ) )
        {
            zm_sat_locust_util::function_222215ce3aef9da1( ref, item );
        }
        else
        {
            zm_sat_locust_util::function_295a36ef38f5acae( ref, item );
        }
    }
    
    if ( item.tag == "02" )
    {
        level callback::callback( #"hash_9e91383fd1158a63", { #player:self } );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1
// Checksum 0x62445f8e, Offset: 0x1010
// Size: 0x3d
function function_a246dcbfe1789959( helmet )
{
    helmet_loc = zm_sat_locust_util::get_quest_reference( hashcat( #"hash_976b52fe4177cc8e", helmet.tag, "_collect" ) );
    return helmet_loc;
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x8db33db4, Offset: 0x1056
// Size: 0x61
function private on_player_death_or_disconnect( params )
{
    if ( self.viking_helmet )
    {
        helmet_loc = zm_sat_locust_util::get_quest_reference( hashcat( #"hash_976b52fe4177cc8e", self.viking_helmet.tag, "_collect" ) );
        helmet_loc.interact function_298ba86edbab58e4();
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0xba1d0954, Offset: 0x10bf
// Size: 0x24, Type: bool
function private function_eec511e63621dbf3( loc )
{
    if ( loc.tag == "02" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x4
// Checksum 0xd8968838, Offset: 0x10ec
// Size: 0x90
function private function_14ce682629ea8ba8()
{
    foreach ( player in level.players )
    {
        if ( player.viking_helmet )
        {
            player.viking_helmet hide();
        }
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x4
// Checksum 0xf57f61e4, Offset: 0x1184
// Size: 0xdf
function private function_275e0cba0fcffae()
{
    foreach ( player in level.players )
    {
        if ( player.viking_helmet )
        {
            if ( player getcamerathirdperson() )
            {
                player.viking_helmet showtoplayer( player );
                player.viking_helmet.third_person = 1;
                continue;
            }
            
            player.viking_helmet hidefromplayer( player );
            player.viking_helmet.third_person = 0;
        }
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x3c6e240b, Offset: 0x126b
// Size: 0x2db
function private function_8fee08bed0cdbd0a( params )
{
    if ( utility::flag( "vernon_01_a" ) )
    {
        if ( utility::flag( "vernon_01_b" ) )
        {
            if ( utility::flag( "vernon_01_c" ) )
            {
                zm_quest::function_4eefe6de31f5ddab( #"locust_ee_viking_helmets", #"hash_aac59548b6ccf80e", 3 );
            }
            else
            {
                zm_quest::function_4eefe6de31f5ddab( #"locust_ee_viking_helmets", #"hash_aac59548b6ccf80e", 2 );
            }
        }
        else
        {
            zm_quest::function_4eefe6de31f5ddab( #"locust_ee_viking_helmets", #"hash_aac59548b6ccf80e", 1 );
        }
    }
    else
    {
        zm_quest::function_4eefe6de31f5ddab( #"locust_ee_viking_helmets", #"hash_aac59548b6ccf80e", 0 );
        
        if ( level.viking_helmets.helmet_01.items_caught )
        {
            zm_quest::function_4eefe6de31f5ddab( #"locust_ee_viking_helmets", #"fish_caught", level.viking_helmets.helmet_01.items_caught );
        }
        
        if ( level.viking_helmets.helmet_01.zombies_caught )
        {
            zm_quest::function_4eefe6de31f5ddab( #"locust_ee_viking_helmets", #"hash_4ef107b278c2e594", level.viking_helmets.helmet_01.zombies_caught );
        }
    }
    
    if ( utility::flag( "vernon_03_a" ) )
    {
        if ( utility::flag( "vernon_03_b" ) )
        {
            if ( utility::flag( "vernon_03_c" ) )
            {
                zm_quest::function_4eefe6de31f5ddab( #"locust_ee_viking_helmets", #"hash_307a9529c70b3ad4", 3 );
            }
            else
            {
                zm_quest::function_4eefe6de31f5ddab( #"locust_ee_viking_helmets", #"hash_307a9529c70b3ad4", 2 );
            }
        }
        else
        {
            zm_quest::function_4eefe6de31f5ddab( #"locust_ee_viking_helmets", #"hash_307a9529c70b3ad4", 1 );
        }
    }
    
    if ( utility::flag( "vernon_04_a" ) )
    {
        if ( utility::flag( "vernon_04_b" ) )
        {
            zm_quest::function_4eefe6de31f5ddab( #"locust_ee_viking_helmets", #"hash_beb4f2d653b1a301", 2 );
        }
        else
        {
            zm_quest::function_4eefe6de31f5ddab( #"locust_ee_viking_helmets", #"hash_beb4f2d653b1a301", 1 );
        }
        
        return;
    }
    
    if ( level.viking_helmets.helmet_04.primary_kills )
    {
        zm_quest::function_4eefe6de31f5ddab( #"locust_ee_viking_helmets", #"trap_primary_kills", level.viking_helmets.helmet_04.primary_kills );
    }
    
    if ( level.viking_helmets.helmet_04.secondary_kills )
    {
        zm_quest::function_4eefe6de31f5ddab( #"locust_ee_viking_helmets", #"hash_6f02b5a1cc12a835", level.viking_helmets.helmet_04.secondary_kills );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x4
// Checksum 0x5c7c7d98, Offset: 0x154e
// Size: 0x1fe
function private function_3d03bf3da3f0b656()
{
    if ( !zm_save::function_1dda3554974a999e() )
    {
        return;
    }
    
    var_efba4b4bd759c94 = zm_quest::function_73720cdf21c3cfd7( #"locust_ee_viking_helmets", #"hash_aac59548b6ccf80e" );
    
    if ( var_efba4b4bd759c94 > 0 )
    {
        var_8cc9bea2b933ea92 = [ #"fishing_requirements", #"hash_fc7784e7cbab98f0", #"hash_c077c657dc228dbc" ];
        
        for ( i = 0; i < var_efba4b4bd759c94 ; i++ )
        {
            step = var_8cc9bea2b933ea92[ i ];
            
            if ( !zm_quest::is_quest_step_complete( #"locust_ee_viking_helmets", step ) )
            {
                step = zm_quest::get_quest_step( #"locust_ee_viking_helmets", step );
                zm_quest::function_e65609834444650c( step, 1 );
            }
        }
    }
    
    var_b9bfc898a94dab46 = zm_quest::function_73720cdf21c3cfd7( #"locust_ee_viking_helmets", #"hash_307a9529c70b3ad4" );
    
    if ( var_b9bfc898a94dab46 > 0 )
    {
        var_28adf40c17ba98b4 = [ #"hash_97614a87dd1e534f", #"hash_135604eccd97f7c4", #"hash_a3fc4d1e6706df9e" ];
        
        for ( i = 0; i < var_b9bfc898a94dab46 ; i++ )
        {
            step = var_28adf40c17ba98b4[ i ];
            
            if ( !zm_quest::is_quest_step_complete( #"locust_ee_viking_helmets", step ) )
            {
                step = zm_quest::get_quest_step( #"locust_ee_viking_helmets", step );
                zm_quest::function_e65609834444650c( step, 1 );
            }
        }
    }
    
    var_e259d8ba334c69eb = zm_quest::function_73720cdf21c3cfd7( #"locust_ee_viking_helmets", #"hash_beb4f2d653b1a301" );
    
    if ( var_e259d8ba334c69eb > 0 )
    {
        var_4ec09878e99c1cf = [ #"blizzard_requirements", #"hash_2735a18ead53ba04" ];
        
        for ( i = 0; i < var_e259d8ba334c69eb ; i++ )
        {
            step = var_4ec09878e99c1cf[ i ];
            
            if ( !zm_quest::is_quest_step_complete( #"locust_ee_viking_helmets", step ) )
            {
                step = zm_quest::get_quest_step( #"locust_ee_viking_helmets", step );
                zm_quest::function_e65609834444650c( step, 1 );
            }
        }
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x634c2104, Offset: 0x1754
// Size: 0x21
function private function_7d6d603ab952be3e( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0xcea77d27, Offset: 0x177d
// Size: 0x20
function private function_60062448e78b7b09( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x144b1192, Offset: 0x17a5
// Size: 0x21
function private function_7d6d613ab952c071( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0xa11ae55, Offset: 0x17ce
// Size: 0x2c
function private function_60062348e78b78d6( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        utility::flag_set( "vernon_01" );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x4
// Checksum 0xd483f7e6, Offset: 0x1802
// Size: 0xa4
function private function_6c77f81442c6c875()
{
    function_58e4b5b8e3ef8b97();
    self.fergus_data = { #var_9800444961e2dff6:getdvarint( @"hash_6aa32a9c67d36036", 80 ), #var_b715f87dfd5f250a:getdvarint( @"hash_a1422ab7729db00a", 10 ), #var_6d2623f6214ace88:getdvarint( @"hash_eda1a8cb419831e8", 10 ) };
    function_a661a390299f518b( "01" );
    
    if ( !level.viking_helmets.var_85e2461d7a5882e2 )
    {
        level.viking_helmets.var_85e2461d7a5882e2 = 1;
        thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_7c3368f78e5cb173" );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0xe0580f6a, Offset: 0x18ae
// Size: 0x180
function private function_a661a390299f518b( helmet_tag )
{
    switch ( helmet_tag )
    {
        case #"hash_f98495f6bce2af9a":
            model_variation = "sat_zm_locust_helmet_painted_blue_01::sat_zm_locust_helmet_01_wearable";
            break;
        case #"hash_f98494f6bce2ae07":
            model_variation = "sat_zm_locust_helmet_01_wearable";
            break;
        case #"hash_f98493f6bce2ac74":
            model_variation = "sat_zm_locust_helmet_painted_yellow_01::sat_zm_locust_helmet_01_wearable";
            break;
        case #"hash_f98492f6bce2aae1":
            model_variation = "sat_zm_locust_helmet_painted_white_01::sat_zm_locust_helmet_01_wearable";
            break;
    }
    
    hat = utility::spawn_model( model_variation );
    hat notsolid();
    hat linkto( self, "j_head", ( 5, 0, 0 ), ( 180, 90, 90 ) );
    hat function_7207895b28c71c79( 1 );
    hat.tag = helmet_tag;
    self.viking_helmet = hat;
    
    if ( self getcamerathirdperson() )
    {
        self.viking_helmet showtoplayer( self );
        self.viking_helmet.third_person = 1;
    }
    else
    {
        self.viking_helmet hidefromplayer( self );
        self.viking_helmet.third_person = 0;
    }
    
    thread function_2138597b31f236d3();
    callback::add( #"hash_2fc46531ebe36dde", &function_6f686ddc794ab259 );
    callback::add( #"hash_7f9d491bb0ff6a88", &function_20abf99c5530f001 );
    
    /#
        if ( level.viking_helmets.var_5d49aa0407e613d2 )
        {
            hat showtoplayer( self );
        }
    #/
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0xc
// Checksum 0xd1da7d50, Offset: 0x1a36
// Size: 0xff
function private function_2138597b31f236d3()
{
    self notify( #"hash_32f41d10530d955a" );
    self endon( #"hash_32f41d10530d955a" );
    level endon( #"game_ended" );
    self endon( #"disconnect", #"helmet_removed" );
    
    while ( true )
    {
        self waittill( #"hash_79c6d8e931c7139d" );
        
        if ( self.gnome_form.active )
        {
            continue;
        }
        
        if ( self.viking_helmet.third_person )
        {
            self.viking_helmet.third_person = 0;
            wait 0.5;
            self.viking_helmet hidefromplayer( self );
            continue;
        }
        
        if ( self.gnome_form.just_canceled )
        {
            self.gnome_form.just_canceled = 0;
            continue;
        }
        
        self.viking_helmet showtoplayer( self );
        self.viking_helmet.third_person = 1;
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x4
// Checksum 0x8f8f1c7b, Offset: 0x1b3d
// Size: 0xa2
function private function_58e4b5b8e3ef8b97()
{
    self notify( #"helmet_removed" );
    self.fergus_data = undefined;
    self.blizzard_data = undefined;
    self.var_a0d8a447e26145f9 = undefined;
    utility::ent_flag_clear( "blizzard_immune" );
    level callback::callback( #"hash_9e91383fd1158a63", { #player:self } );
    callback::remove( #"hash_2fc46531ebe36dde", &function_6f686ddc794ab259 );
    callback::remove( #"hash_7f9d491bb0ff6a88", &function_20abf99c5530f001 );
    
    if ( self.viking_helmet )
    {
        self.viking_helmet delete();
        self.viking_helmet = undefined;
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0xa83b8bb, Offset: 0x1be7
// Size: 0x277
function private function_401039ddb9f83f1( skipped, save_restored )
{
    loading_save = 0;
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        loading_save = 1;
        squad_size = 1;
    }
    else
    {
        utility::flag_wait( "begin_round_logic" );
        squad_size = level.players.size;
    }
    
    squad_frac = math::lerp_fraction( 1, 4, squad_size );
    var_339027190b10a79 = int( clamp( math::lerp( 10, 20, squad_frac ), 10, 20 ) );
    var_d2ce12f1554a6d3c = int( clamp( math::lerp( 4, 8, squad_frac ), 4, 8 ) );
    
    switch ( squad_size )
    {
        case 1:
            var_339027190b10a79 = getdvarint( @"hash_2967fc1cae8f9547", var_339027190b10a79 );
            var_d2ce12f1554a6d3c = getdvarint( @"hash_d3c529ed1f45240", var_d2ce12f1554a6d3c );
            break;
        case 2:
            var_339027190b10a79 = getdvarint( @"hash_ddcf6bcf254b7130", var_339027190b10a79 );
            var_d2ce12f1554a6d3c = getdvarint( @"hash_82b432c228222431", var_d2ce12f1554a6d3c );
            break;
        case 3:
            var_339027190b10a79 = getdvarint( @"hash_66679f9b005d54e4", var_339027190b10a79 );
            var_d2ce12f1554a6d3c = getdvarint( @"hash_6b01d261dc0a3ee7", var_d2ce12f1554a6d3c );
            break;
        case 4:
            var_339027190b10a79 = getdvarint( @"hash_ab3e2715c4442a0b", var_339027190b10a79 );
            var_d2ce12f1554a6d3c = getdvarint( @"hash_ac327f7e4f1d880", var_d2ce12f1554a6d3c );
            break;
    }
    
    items_caught = ( loading_save ? zm_quest::function_73720cdf21c3cfd7( #"locust_ee_viking_helmets", #"fish_caught" ) : 0 ) ?? 0;
    zombies_caught = ( loading_save ? zm_quest::function_73720cdf21c3cfd7( #"locust_ee_viking_helmets", #"hash_4ef107b278c2e594" ) : 0 ) ?? 0;
    level.viking_helmets.helmet_01 = { #zombies_required:getdvarint( @"hash_eea98fa1bfe7a5ab", var_d2ce12f1554a6d3c ), #zombies_caught:zombies_caught, #items_required:getdvarint( @"hash_d6d798a898b8a544", var_339027190b10a79 ), #items_caught:items_caught };
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level callback::add( "fergus_general_catch_success", &function_1decc4dc1f55b836 );
    level callback::add( #"hash_4063b53825f36952", &function_f63cacc2570b0126 );
    utility::flag_wait( "vernon_01_a" );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x3c32b142, Offset: 0x1e66
// Size: 0x54
function private function_83c8ab698e3c8b5e( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        utility::flag_set( "vernon_01_a" );
    }
    
    level callback::remove( "fergus_general_catch_success", &function_1decc4dc1f55b836 );
    level callback::remove( #"hash_4063b53825f36952", &function_f63cacc2570b0126 );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x48d87d0c, Offset: 0x1ec2
// Size: 0x7e
function private function_1decc4dc1f55b836( params )
{
    if ( params.caught_obj )
    {
        if ( !isdefined( level.viking_helmets.helmet_01.items_caught ) )
        {
            level.viking_helmets.helmet_01.items_caught = 0;
        }
        
        level.viking_helmets.helmet_01.items_caught++;
    }
    
    function_a60894f334b1ee98();
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0xc21b0575, Offset: 0x1f48
// Size: 0x7e
function private function_f63cacc2570b0126( params )
{
    if ( params.zombie )
    {
        if ( !isdefined( level.viking_helmets.helmet_01.zombies_caught ) )
        {
            level.viking_helmets.helmet_01.zombies_caught = 0;
        }
        
        level.viking_helmets.helmet_01.zombies_caught++;
    }
    
    function_a60894f334b1ee98();
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x4
// Checksum 0x1f5d85ff, Offset: 0x1fce
// Size: 0xa8
function private function_a60894f334b1ee98()
{
    item_count_reached = level.viking_helmets.helmet_01.items_caught >= level.viking_helmets.helmet_01.items_required;
    zombie_count_reached = level.viking_helmets.helmet_01.zombies_caught >= level.viking_helmets.helmet_01.zombies_required;
    
    if ( !item_count_reached || !zombie_count_reached )
    {
        return;
    }
    
    utility::flag_set( "vernon_01_a" );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0xa44d603c, Offset: 0x207e
// Size: 0x108
function private function_401009ddb9f7d58( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    level callback::add( "fergus_override_catch_item", &function_c15d2fc11ea5303 );
    var_a6035bc832398943 = [];
    
    foreach ( var_12d72740175e8cac in level.fishing_struct.fishing_holes )
    {
        if ( !var_12d72740175e8cac.guaranteed_loot )
        {
            var_12d72740175e8cac.guaranteed_loot = 1;
            var_a6035bc832398943[ var_a6035bc832398943.size ] = var_12d72740175e8cac;
        }
    }
    
    level.viking_helmets.helmet_01.var_469a6ec42adce65 = var_a6035bc832398943;
    utility::flag_wait( "vernon_01_b" );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x20d88bcf, Offset: 0x218e
// Size: 0x7e
function private function_83c8aa698e3c892b( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        utility::flag_set( "vernon_01_b" );
        
        if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"hash_87fd9e622d15136e" ) )
        {
            helmet_loc = zm_sat_locust_util::get_quest_reference( #"hash_e1ad32fff828300c" );
            helmet_loc.interact function_298ba86edbab58e4();
        }
    }
    
    level callback::remove( "fergus_override_catch_item", &function_c15d2fc11ea5303 );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x59fe3cbb, Offset: 0x2214
// Size: 0xc6, Type: bool
function private function_c15d2fc11ea5303( params )
{
    level thread function_3aa467151ade576a( params );
    
    foreach ( var_12d72740175e8cac in level.viking_helmets.helmet_01.var_469a6ec42adce65 )
    {
        var_12d72740175e8cac.guaranteed_loot = 0;
    }
    
    level.viking_helmets.helmet_01.var_469a6ec42adce65 = undefined;
    return true;
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x21099ec4, Offset: 0x22e3
// Size: 0x1f2
function private function_3aa467151ade576a( params )
{
    var_28b7906f3ff3a2fe = params.fishing_hole_scriptable zm_sat_locust_fergus::function_2cedc06898c83328();
    var_30085f70fc117162 = { #angles:( 0, 0, 0 ), #origin:var_28b7906f3ff3a2fe.origin };
    ai_type = subclass_to_aitype_map::function_427ae77ce1056e01( "zombie_base", [ "stam_zm_sat_locust_olaf" ] );
    params = { #var_30085f70fc117162:var_30085f70fc117162, #spawner_zombie_type:ai_type };
    zm = zm_sat_locust_util::spawn_quest_zombie( params );
    
    if ( !zm )
    {
        var_a6035bc832398943 = [];
        
        foreach ( var_12d72740175e8cac in level.fishing_struct.fishing_holes )
        {
            if ( !var_12d72740175e8cac.guaranteed_loot )
            {
                var_12d72740175e8cac.guaranteed_loot = 1;
                var_a6035bc832398943[ var_a6035bc832398943.size ] = var_12d72740175e8cac;
            }
        }
        
        level.viking_helmets.helmet_01.var_469a6ec42adce65 = var_a6035bc832398943;
        return 0;
    }
    
    hat = utility::spawn_model( "sat_zm_locust_helmet_painted_blue_01::sat_zm_locust_helmet_01_wearable" );
    hat notsolid();
    hat linkto( zm, "j_head", ( 3, -1, 0 ), ( 180, 90, 90 ) );
    hat function_7207895b28c71c79( 1 );
    zm.viking_helmet = hat;
    zm zombie_utils::function_dfae6a5bd222c586( &function_9338dec97eef5171 );
    zm callback::add( "on_zombie_ai_killed", &function_3d25347c885d7697 );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x10e17ef4, Offset: 0x24dd
// Size: 0xfb
function private function_9338dec97eef5171( params )
{
    if ( !isdefined( params.eattacker ) || !isdefined( self ) )
    {
        return 0;
    }
    
    if ( self.viking_helmet && params.biscritical )
    {
        if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"hash_87fd9e622d15136e" ) )
        {
            spawn_params = { #spawntype:#"spawn_from_pos", #fromangles:self.viking_helmet.angles, #fromorigin:self.viking_helmet.origin, #asset:%"zmloot_sat_locust_quest_vernon_01" };
            function_fb5401aec4ce336( spawn_params );
        }
        
        self.viking_helmet delete();
        self.viking_helmet = undefined;
        callback::remove( "on_zombie_ai_killed", &function_3d25347c885d7697 );
        return 0;
    }
    
    return params.idamage;
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x70e77ccb, Offset: 0x25e1
// Size: 0x87
function private function_3d25347c885d7697( params )
{
    if ( self.viking_helmet )
    {
        self.viking_helmet delete();
        self.viking_helmet = undefined;
    }
    
    if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"hash_87fd9e622d15136e" ) )
    {
        spawn_params = { #spawntype:#"hash_396d489cffb7196b", #spawningent:self, #asset:%"zmloot_sat_locust_quest_vernon_01" };
        function_fb5401aec4ce336( spawn_params );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x8e457baf, Offset: 0x2670
// Size: 0x72
function private function_fb5401aec4ce336( spawn_params )
{
    item = zm_sat_locust_util::spawn_quest_item( spawn_params );
    item.tag = "01";
    ref = #"hash_87fd9e622d15136e";
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( ref ) )
    {
        zm_sat_locust_util::function_222215ce3aef9da1( ref, item );
    }
    else
    {
        zm_sat_locust_util::function_295a36ef38f5acae( ref, item );
    }
    
    utility::flag_set( "vernon_01_b" );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0xd93877d, Offset: 0x26ea
// Size: 0x2d
function private function_401019ddb9f7f8b( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( "vernon_01_c" );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x8383b6c7, Offset: 0x271f
// Size: 0x6c
function private function_83c8a9698e3c86f8( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        utility::flag_set( "vernon_01_c" );
        
        if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"hash_87fd9e622d15136e" ) )
        {
            helmet_loc = zm_sat_locust_util::get_quest_reference( #"hash_e1ad32fff828300c" );
            helmet_loc.interact function_298ba86edbab58e4();
        }
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x8d424028, Offset: 0x2793
// Size: 0x21
function private function_7d6d5e3ab952b9d8( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0xa11ae55, Offset: 0x27bc
// Size: 0x2c
function private function_60062248e78b76a3( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        utility::flag_set( "vernon_02" );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x4
// Checksum 0x370b899f, Offset: 0x27f0
// Size: 0x31
function private function_6c77f51442c6c1dc()
{
    function_58e4b5b8e3ef8b97();
    level callback::callback( #"hash_cce1f9ca7f216f81", { #player:self } );
    function_a661a390299f518b( "02" );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0xf0fa660, Offset: 0x2829
// Size: 0x3e
function private function_87b11063ffa335fe( params )
{
    if ( params.player.viking_helmet )
    {
        params.player.viking_helmet hide();
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x820c9e31, Offset: 0x286f
// Size: 0xc0
function private function_7a7785e338b24536( params )
{
    if ( params.player.viking_helmet )
    {
        params.player.viking_helmet show();
        
        if ( !level.viking_helmets.var_5d49aa0407e613d2 && !params.player.viking_helmet.third_person )
        {
            params.player.viking_helmet hidefromplayer( params.player );
            params.player.gnome_form.just_canceled = 1;
        }
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x72ae1c6f, Offset: 0x2937
// Size: 0x26
function private function_8f197bb5b476bc66( params )
{
    level thread function_67ed15677d49f127();
    params.player function_58e4b5b8e3ef8b97();
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x4
// Checksum 0xa1ecda0, Offset: 0x2965
// Size: 0xf2
function private function_67ed15677d49f127()
{
    level endon( #"game_ended" );
    
    if ( level.viking_helmets.helmet_02.var_e755a86d7a5be09a )
    {
        if ( zm_utility::get_round_number() < 100 )
        {
            round_waits = level.viking_helmets.helmet_02.var_57babbaeec3acb1;
        }
        else
        {
            round_waits = level.viking_helmets.helmet_02.var_aa565faacb77bc44;
        }
        
        if ( level.var_6781718da4f78d1c.state === 2 )
        {
            round_waits++;
        }
        
        for ( i = round_waits; i > 0 ; i-- )
        {
            level waittill( #"on_round_start" );
        }
    }
    
    helmet_loc = zm_sat_locust_util::get_quest_reference( #"hash_eb0541e10831f891" );
    helmet_loc.interact function_298ba86edbab58e4();
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x5bbede97, Offset: 0x2a5f
// Size: 0x83
function private function_f2de5dadf36acca0( player )
{
    if ( !player currency::attempt_purchase( "essence", function_b1c2aff21dc45b69(), 1 ) )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        return;
    }
    
    if ( self.helmet )
    {
        zm_sat_locust_util::function_63a23256772ea1b9( player );
        player function_388059f328ab68f( self.tag );
        self setusableenabled( 1 );
        self.helmet freescriptable();
        interaction::set_interact_hint_callback();
        interaction::set_interact_use_callback( &function_74493d55828a4008 );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x97e10149, Offset: 0x2aea
// Size: 0x12f
function private function_8663d8848cd3e4f5( interact, player )
{
    if ( isdefined( player ) && player.interactions_disabled || interact.var_94d1ab5da995e573 )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    hintstring_obj = { #interactable:1, #aux_text:"", #icon_text_value:function_b1c2aff21dc45b69(), #var_776a268784e089af:&"SHARED_HINTSTRINGS/COST_ESSENCE", #icon:"sat_ui_icon_zm_ping_vernon", #buttoncallout:&"SHARED_HINTSTRINGS/HINT_BUY", #description:&"zm_sat_locust/item_vernon_desc_02", #title:&"zm_sat_locust/item_vernon_title_02", #type:"HINT_BUTTON" };
    
    if ( !player currency::can_afford( "essence", function_b1c2aff21dc45b69() ) )
    {
        hintstring_obj.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
        hintstring_obj.interactable = 0;
    }
    
    return hintstring_obj;
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x4
// Checksum 0xe0144f4e, Offset: 0x2c22
// Size: 0x12
function private function_b1c2aff21dc45b69()
{
    return getdvarint( @"hash_7904eea01ce891d0", 8000 );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0xc9c4311, Offset: 0x2c3d
// Size: 0x8a
function private function_d83b7c9dbb71bb4c( skipped, save_restored )
{
    level.viking_helmets.helmet_02 = { #var_aa565faacb77bc44:getdvarint( @"hash_c437e783bf3efa79", 2 ), #var_57babbaeec3acb1:getdvarint( @"hash_ec9ed2ec0ef2514a", 1 ), #var_e755a86d7a5be09a:getdvarint( @"hash_133375defb2e93c6", 1 ) };
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( "vernon_02_a" );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x52eb9957, Offset: 0x2ccf
// Size: 0x2c
function private function_7820966986bcfeef( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        utility::flag_set( "vernon_02_a" );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0xcf37dbc0, Offset: 0x2d03
// Size: 0xfa, Type: bool
function private function_c4ab2b9f58143912( params )
{
    ref = #"hash_e88028b491abfd45";
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( ref ) )
    {
        return true;
    }
    
    spawn_params = { #spawntype:#"spawn_at_pos", #spawnangles:params.angles, #spawnorigin:params.origin, #asset:%"zmloot_sat_locust_quest_vernon_02" };
    helmet = zm_sat_locust_util::spawn_quest_item( spawn_params );
    
    if ( !helmet )
    {
        return false;
    }
    
    helmet.tag = "02";
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( ref ) )
    {
        zm_sat_locust_util::function_222215ce3aef9da1( ref, helmet );
    }
    else
    {
        zm_sat_locust_util::function_295a36ef38f5acae( ref, helmet );
    }
    
    helmet setscriptablepartstate( #"fx", #"spawn" );
    utility::flag_set( "vernon_02_a" );
    return true;
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0xd93877d, Offset: 0x2e06
// Size: 0x2d
function private function_d83b7f9dbb71c1e5( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( "vernon_02_b" );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x72003c2c, Offset: 0x2e3b
// Size: 0xc6
function private function_7820976986bd0122( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        utility::flag_set( "vernon_02_b" );
        utility::flag_set( "ee_wr_step_01" );
        utility::flag_set( "ee_wr_step_02" );
        
        if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"hash_e88028b491abfd45" ) )
        {
            helmet_loc = zm_sat_locust_util::get_quest_reference( #"hash_eb0541e10831f891" );
            helmet_loc.interact function_298ba86edbab58e4();
        }
    }
    
    level callback::add( #"hash_1775b5a01b4f4346", &function_87b11063ffa335fe );
    level callback::add( #"hash_4860b292b1e63c3e", &function_7a7785e338b24536 );
    level callback::add( #"hash_47ee442f8d4a2047", &function_8f197bb5b476bc66 );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0xfa4570be, Offset: 0x2f09
// Size: 0x21
function private function_7d6d5f3ab952bc0b( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0xa11ae55, Offset: 0x2f32
// Size: 0x2c
function private function_60062148e78b7470( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        utility::flag_set( "vernon_03" );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x4
// Checksum 0x78201933, Offset: 0x2f66
// Size: 0x63
function private function_6c77f61442c6c40f()
{
    function_58e4b5b8e3ef8b97();
    function_a661a390299f518b( "03" );
    
    if ( !level.viking_helmets.var_3e13120ced3f8600 )
    {
        level.viking_helmets.var_3e13120ced3f8600 = 1;
        
        if ( !namespace_c0b4f2882c9d100f::is_weaver() )
        {
            utility::delaythread( 1, &namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01, #"hash_fb5d46aba1c8ff8" );
        }
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0xec7e4ef8, Offset: 0x2fd1
// Size: 0xac, Type: bool
function private function_86034bc844c71641( params )
{
    player = params.eattacker;
    
    if ( !isplayer( player ) || player.viking_helmet.tag != "03" || player.var_a0d8a447e26145f9 )
    {
        return false;
    }
    
    if ( utility::percent_chance( level.viking_helmets.helmet_03.var_7825252b68f99ad7 ) )
    {
        player thread function_3db0263fd9f5c8fa();
        
        /#
            iprintlnbold( "<dev string:x37>" );
        #/
        
        player playsoundtoplayer( "evt_ee_viking_helmet_lucky_feedback", player, player );
        return true;
    }
    
    return false;
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x4
// Checksum 0xac7c9007, Offset: 0x3086
// Size: 0x6f
function private function_3db0263fd9f5c8fa()
{
    self endon( #"disconnect" );
    self endon( #"helmet_removed" );
    self.var_a0d8a447e26145f9 = 1;
    
    if ( level.viking_helmets.helmet_03.powerup_cooldown > 0 )
    {
        wait level.viking_helmets.helmet_03.powerup_cooldown;
    }
    
    self.var_a0d8a447e26145f9 = undefined;
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x9a36bae6, Offset: 0x30fd
// Size: 0xa0
function private function_e963d59dc8feaa07( skipped, save_restored )
{
    level.viking_helmets.helmet_03 = { #powerup_cooldown:getdvarint( @"hash_c7b357d8bfa72978", 20 ), #var_7825252b68f99ad7:getdvarint( @"hash_b90e83ee461a994d", 3 ), #var_21c4e52c41bea440:getdvarint( @"hash_3908e3fa0ef3dfa3", 9 ) };
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level callback::add( #"hash_97272c456c65bf4a", &function_1ba08fbd74825fa2 );
    utility::flag_wait( "vernon_03_a" );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x9b70699e, Offset: 0x31a5
// Size: 0x42
function private function_66f87d6979309cf4( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        utility::flag_set( "vernon_03_a" );
    }
    
    level callback::remove( #"hash_97272c456c65bf4a", &function_1ba08fbd74825fa2 );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x29d00397, Offset: 0x31ef
// Size: 0x44
function private function_1ba08fbd74825fa2( params )
{
    if ( params.num_collected >= level.viking_helmets.helmet_03.var_21c4e52c41bea440 )
    {
        utility::flag_set( "vernon_03_a" );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x46a2f34, Offset: 0x323b
// Size: 0x43
function private function_e963d69dc8feac3a( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    level callback::add( #"hash_4fcf8b30a92d6571", &function_ebff6c6fc9ad42a8 );
    utility::flag_wait( "vernon_03_b" );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x1c88e04b, Offset: 0x3286
// Size: 0x6c
function private function_66f880697930a38d( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        utility::flag_set( "vernon_03_b" );
        
        if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"hash_5df18773e7839070" ) )
        {
            helmet_loc = zm_sat_locust_util::get_quest_reference( #"hash_c3d6aabfadb5e59e" );
            helmet_loc.interact function_298ba86edbab58e4();
        }
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x696168a7, Offset: 0x32fa
// Size: 0xee, Type: bool
function private function_ebff6c6fc9ad42a8( params )
{
    ref = #"hash_5df18773e7839070";
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( ref ) )
    {
        return true;
    }
    
    spawn_params = { #spawntype:#"spawn_at_pos", #spawnangles:params.spawn_pos.angles, #spawnorigin:params.spawn_pos.origin, #asset:%"zmloot_sat_locust_quest_vernon_03" };
    item = zm_sat_locust_util::spawn_quest_item( spawn_params );
    item.tag = "03";
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( ref ) )
    {
        zm_sat_locust_util::function_222215ce3aef9da1( ref, item );
    }
    else
    {
        zm_sat_locust_util::function_295a36ef38f5acae( ref, item );
    }
    
    utility::flag_set( "vernon_03_b" );
    return isdefined( item );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0xd93877d, Offset: 0x33f1
// Size: 0x2d
function private function_e963d79dc8feae6d( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( "vernon_03_c" );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0xcd519bfe, Offset: 0x3426
// Size: 0x4e
function private function_66f87f697930a15a( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        utility::flag_set( "vernon_03_c" );
    }
    
    level callback::remove( #"hash_4fcf8b30a92d6571", &function_ebff6c6fc9ad42a8 );
    namespace_c0d2b08434f47155::function_fb99058524336897( &function_86034bc844c71641 );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x6421e51d, Offset: 0x347c
// Size: 0x21
function private function_7d6d643ab952c70a( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0xa11ae55, Offset: 0x34a5
// Size: 0x2c
function private function_60062848e78b83d5( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        utility::flag_set( "vernon_04" );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x4
// Checksum 0x4507e2e5, Offset: 0x34d9
// Size: 0xb2
function private function_6c77f31442c6bd76()
{
    function_58e4b5b8e3ef8b97();
    utility::ent_flag_set( "blizzard_immune" );
    self.blizzard_data = { #helmet_on_cooldown:0 };
    function_a661a390299f518b( "04" );
    thread function_728618c2754c5488();
    
    if ( !isdefined( level.var_f3f3b4d926db02c7 ) || !arraycontains( level.var_f3f3b4d926db02c7, &function_6a05f5dd16eb522d ) )
    {
        level zombie_utils::function_dfae6a5bd222c586( &function_6a05f5dd16eb522d );
    }
    
    if ( !level.viking_helmets.var_b6460839f51a412b )
    {
        level.viking_helmets.var_b6460839f51a412b = 1;
        utility::delaythread( 1, &namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01, #"hash_f9448c6df38380d" );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0xc
// Checksum 0x25687afc, Offset: 0x3593
// Size: 0x75
function private function_728618c2754c5488()
{
    self notify( #"hash_93aa463b077bf969" );
    self endon( #"hash_93aa463b077bf969" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"helmet_removed" );
    
    while ( true )
    {
        if ( self issprintsliding() && !self.blizzard_data.helmet_on_cooldown )
        {
            function_4f9fd70e7c2e5204();
            thread function_f110c068d30c81a8();
        }
        
        waitframe();
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0, eflags: 0x4
// Checksum 0x6092b01f, Offset: 0x3610
// Size: 0x68
function private function_f110c068d30c81a8()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"helmet_removed" );
    self.blizzard_data.helmet_on_cooldown = 1;
    wait 5;
    
    if ( self issprintsliding() )
    {
        while ( self issprintsliding() )
        {
            waitframe();
        }
    }
    
    self.blizzard_data.helmet_on_cooldown = 0;
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0
// Checksum 0xbbb31136, Offset: 0x3680
// Size: 0x206
function function_4f9fd70e7c2e5204()
{
    v_velocity_dir = self getvelocity();
    v_velocity_dir = vectornormalize( v_velocity_dir );
    blast_radius = getdvarint( @"hash_4b9df4104b212bf6", 150 );
    blast_forward = getdvarint( @"hash_8ae12c65c5be47d", 150 );
    v_origin = self gettagorigin( "j_ankle_ri" ) + v_velocity_dir * blast_forward + ( 0, 0, 20 );
    
    /#
        debug::sphere( v_origin, 5, ( 0, 1, 0 ), 2 );
        debug::sphere( v_origin, blast_radius, ( 1, 1, 1 ), 2 );
    #/
    
    playfx( utility::getfx( "vernon_fr_blast" ), v_origin, undefined, anglestoup( self.angles ) );
    self playsound( "evt_ee_viking_helmet_frost_blast", undefined, self );
    a_ai = getaiarrayinradius( v_origin, blast_radius );
    var_6f5c0bece5deb66e = [];
    
    foreach ( ai in a_ai )
    {
        if ( ai.team == self.team || ai.team == "neutral" )
        {
            continue;
        }
        
        var_6f5c0bece5deb66e[ var_6f5c0bece5deb66e.size ] = ai;
    }
    
    for ( i = 0; i < var_6f5c0bece5deb66e.size ; i++ )
    {
        var_4ce3921a39b02032 = var_6f5c0bece5deb66e[ i ];
        
        if ( !isalive( var_4ce3921a39b02032 ) )
        {
            continue;
        }
        
        if ( var_4ce3921a39b02032 utility::ent_flag( "cryofreeze_active" ) || var_4ce3921a39b02032 utility::ent_flag( "frost_blast_active" ) )
        {
            continue;
        }
        
        var_4ce3921a39b02032 cryofreeze::function_78dcfeb8fef113fb( undefined, self, undefined, undefined, var_4ce3921a39b02032.origin, undefined, undefined, undefined, undefined, undefined );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0xee96abd6, Offset: 0x388e
// Size: 0xb8
function private function_6a05f5dd16eb522d( params )
{
    if ( !isplayer( params.eattacker ) )
    {
        return params.idamage;
    }
    
    if ( params.eattacker.viking_helmet.tag != "04" )
    {
        return params.idamage;
    }
    
    if ( !utility::isbulletdamage( params.smeansofdeath ) )
    {
        return params.idamage;
    }
    
    multiplier = function_ab750be10475d8fe( params );
    
    if ( !multiplier )
    {
        return params.idamage;
    }
    
    return roundint( params.idamage * multiplier );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0xf6ed04da, Offset: 0x394f
// Size: 0x69
function private function_ab750be10475d8fe( params )
{
    if ( !isdefined( self.subclass ) )
    {
        return;
    }
    
    switch ( self.subclass )
    {
        case #"hash_554bba6a6908c6dc":
        case #"hash_7e79cb73082c318c":
            return 1.2;
        case #"hash_3347cab8191a68d":
            return 1;
        default:
            return;
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x51fe4921, Offset: 0x39c0
// Size: 0xe, Type: bool
function private function_a8c99173310a08d2( params )
{
    return true;
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x4ae6c70e, Offset: 0x39d7
// Size: 0x26f
function private function_31f8869dfe36254a( skipped, save_restored )
{
    loading_save = 0;
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        loading_save = 1;
        squad_size = 1;
    }
    else
    {
        utility::flag_wait( "begin_round_logic" );
        squad_size = level.players.size;
    }
    
    squad_size = level.players.size;
    squad_frac = math::lerp_fraction( 1, 4, squad_size );
    scaled_primary_kills = int( clamp( math::lerp( 250, 500, squad_frac ), 250, 500 ) );
    var_83a589f822e95ad7 = int( clamp( math::lerp( 50, 100, squad_frac ), 50, 100 ) );
    
    switch ( squad_size )
    {
        case 1:
            scaled_primary_kills = getdvarint( @"hash_7e4fe3c0a933eb51", scaled_primary_kills );
            var_83a589f822e95ad7 = getdvarint( @"hash_cb2435c41e0ef69c", var_83a589f822e95ad7 );
            break;
        case 2:
            scaled_primary_kills = getdvarint( @"hash_f186a0bb1c6dff6e", scaled_primary_kills );
            var_83a589f822e95ad7 = getdvarint( @"hash_67b87bcd21553135", var_83a589f822e95ad7 );
            break;
        case 3:
            scaled_primary_kills = getdvarint( @"hash_f7f5641238d48a3a", scaled_primary_kills );
            var_83a589f822e95ad7 = getdvarint( @"hash_f9e99ee5d58182db", var_83a589f822e95ad7 );
            break;
        case 4:
            scaled_primary_kills = getdvarint( @"hash_e8cc06bc86096669", scaled_primary_kills );
            var_83a589f822e95ad7 = getdvarint( @"hash_776587805886d594", var_83a589f822e95ad7 );
            break;
    }
    
    primary_kills = ( loading_save ? zm_quest::function_73720cdf21c3cfd7( #"locust_ee_viking_helmets", #"trap_primary_kills" ) : 0 ) ?? 0;
    secondary_kills = ( loading_save ? zm_quest::function_73720cdf21c3cfd7( #"locust_ee_viking_helmets", #"hash_6f02b5a1cc12a835" ) : 0 ) ?? 0;
    level.viking_helmets.helmet_04 = { #var_41b88e61aa8c6621:getdvarint( @"hash_d5f9e947639e9587", var_83a589f822e95ad7 ), #secondary_kills:secondary_kills, #primary_kills_req:getdvarint( @"hash_92a79c60e2e7c27a", scaled_primary_kills ), #primary_kills:primary_kills };
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level callback::add( "on_zombie_ai_killed", &function_78286e39aaf190dd );
    utility::flag_wait( "vernon_04_a" );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x6577c93a, Offset: 0x3c4e
// Size: 0x7e
function private function_cc5da069c3749c2d( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        utility::flag_set( "vernon_04_a" );
        
        if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"hash_7d847aed336df4df" ) )
        {
            helmet_loc = zm_sat_locust_util::get_quest_reference( #"hash_5a7c9fa8248c4ebb" );
            helmet_loc.interact function_298ba86edbab58e4();
        }
    }
    
    level callback::remove( "on_zombie_ai_killed", &function_78286e39aaf190dd );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x4afa4cb9, Offset: 0x3cd4
// Size: 0x292
function private function_78286e39aaf190dd( params )
{
    player = params.einflictor.activator;
    
    if ( !player )
    {
        player = isplayer( params.eattacker ) ? params.eattacker : params.einflictor;
    }
    
    primary_kill = params.einflictor.targetname == "trap_attacker";
    secondary_kill = params.einflictor.classname == "worldspawn" && player.var_48fc1f163fceea29 && params.smeansofdeath == "MOD_ELEMENTAL_FIRE" || player.var_48fc1f163fceea29 && self.var_56bb046d7e4c8043;
    
    if ( !( primary_kill || secondary_kill ) )
    {
        return;
    }
    
    if ( primary_kill )
    {
        if ( !isdefined( level.viking_helmets.helmet_04.primary_kills ) )
        {
            level.viking_helmets.helmet_04.primary_kills = 0;
        }
        
        level.viking_helmets.helmet_04.primary_kills++;
    }
    
    if ( secondary_kill )
    {
        if ( self.subclass == "zombie_base_luna" )
        {
            if ( !isdefined( level.viking_helmets.helmet_04.secondary_kills ) )
            {
                level.viking_helmets.helmet_04.secondary_kills = 0;
            }
            
            level.viking_helmets.helmet_04.secondary_kills++;
        }
    }
    
    primary_reached = level.viking_helmets.helmet_04.primary_kills >= level.viking_helmets.helmet_04.primary_kills_req;
    secondary_reached = level.viking_helmets.helmet_04.secondary_kills >= level.viking_helmets.helmet_04.var_41b88e61aa8c6621;
    
    if ( primary_reached && secondary_reached )
    {
        function_9c22e768f943c372( { #from_ent:self } );
        level callback::remove( "on_zombie_ai_killed", &function_78286e39aaf190dd );
        utility::flag_set( "vernon_04_a" );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0xd93877d, Offset: 0x3f6e
// Size: 0x2d
function private function_31f8859dfe362317( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( "vernon_04_b" );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 2, eflags: 0x4
// Checksum 0x52eb9957, Offset: 0x3fa3
// Size: 0x2c
function private function_cc5d9d69c3749594( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        utility::flag_set( "vernon_04_b" );
    }
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0xee8d70ff, Offset: 0x3fd7
// Size: 0xac, Type: bool
function private function_9c22e768f943c372( params )
{
    spawn_params = { #spawntype:#"hash_396d489cffb7196b", #spawningent:params.from_ent, #asset:%"zmloot_sat_locust_quest_vernon_04" };
    item = zm_sat_locust_util::spawn_quest_item( spawn_params );
    item.tag = "04";
    ref = #"hash_7d847aed336df4df";
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( ref ) )
    {
        zm_sat_locust_util::function_222215ce3aef9da1( ref, item );
    }
    else
    {
        zm_sat_locust_util::function_295a36ef38f5acae( ref, item );
    }
    
    return isdefined( item );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0xd1cc96f1, Offset: 0x408c
// Size: 0x35, Type: bool
function private function_ef38fce87aeeecb0( params )
{
    return isplayer( params.player ) && params.player utility::ent_flag( "blizzard_immune" );
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x60e8dba7, Offset: 0x40ca
// Size: 0x1a
function private function_6f686ddc794ab259( params )
{
    self.viking_helmet hide();
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 1, eflags: 0x4
// Checksum 0x203ae5, Offset: 0x40ec
// Size: 0x1a
function private function_20abf99c5530f001( params )
{
    self.viking_helmet show();
}

// Namespace zm_sat_locust_ee_viking_helmets
// Params 0
// Checksum 0x6949395c, Offset: 0x410e
// Size: 0x2
function __debug()
{
    
}

/#

    // Namespace zm_sat_locust_ee_viking_helmets
    // Params 0, eflags: 0x4
    // Checksum 0x221a9e1f, Offset: 0x4118
    // Size: 0xf2, Type: dev
    function private debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x5a>" + getxhashsourcename( #"locust_ee_viking_helmets" ) + "<dev string:x64>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6e>", "<dev string:x82>", &function_6dac44b607e51397 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa3>", "<dev string:xb8>", &debug_spawn_helmet );
        devgui::function_cd4e263c1f3018ae( "<dev string:xda>", "<dev string:xf0>", &function_6dac44b607e51397 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x111>", "<dev string:x128>", &debug_spawn_helmet );
        devgui::function_cd4e263c1f3018ae( "<dev string:x14a>", "<dev string:x15d>", &function_6dac44b607e51397 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x17e>", "<dev string:x192>", &debug_spawn_helmet );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1b4>", "<dev string:x1c9>", &function_6dac44b607e51397 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1ea>", "<dev string:x200>", &debug_spawn_helmet );
        devgui::add_devgui_func( "<dev string:x222>", "<dev string:x23b>", &function_4640f26141acff93 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_locust_ee_viking_helmets
    // Params 1, eflags: 0x4
    // Checksum 0x173ede0c, Offset: 0x4212
    // Size: 0xcf, Type: dev
    function private function_6dac44b607e51397( params )
    {
        switch ( params[ 0 ] )
        {
            case #"hash_f98495f6bce2af9a":
                level.player function_6c77f81442c6c875();
                break;
            case #"hash_f98494f6bce2ae07":
                level.player function_6c77f51442c6c1dc();
                break;
            case #"hash_f98493f6bce2ac74":
                level.player function_6c77f61442c6c40f();
                break;
            case #"hash_f98492f6bce2aae1":
                level.player function_6c77f31442c6bd76();
                break;
        }
        
        item_ref = hashcat( #"hash_976b52fe4177cc8e", params[ 0 ], "<dev string:x26b>" );
        
        if ( zm_sat_locust_util::function_3112dc4740eb8499( item_ref ) )
        {
            zm_sat_locust_util::get_quest_reference( item_ref ) freescriptable();
        }
    }

    // Namespace zm_sat_locust_ee_viking_helmets
    // Params 1, eflags: 0x4
    // Checksum 0x20f83dd0, Offset: 0x42e9
    // Size: 0xbb, Type: dev
    function private debug_spawn_helmet( params )
    {
        spawn_params = { #spawntype:#"hash_396d489cffb7196b", #spawningent:level.player, #asset:hashcat( %"hash_247de291bcbb1b2", params[ 0 ] ) };
        item = zm_sat_locust_util::spawn_quest_item( spawn_params );
        item.tag = params[ 0 ];
        ref = hashcat( #"hash_976b52fe4177cc8e", params[ 0 ], "<dev string:x26b>" );
        
        if ( zm_sat_locust_util::function_3112dc4740eb8499( ref ) )
        {
            zm_sat_locust_util::function_222215ce3aef9da1( ref, item );
            return;
        }
        
        zm_sat_locust_util::function_295a36ef38f5acae( ref, item );
    }

    // Namespace zm_sat_locust_ee_viking_helmets
    // Params 0, eflags: 0x4
    // Checksum 0x78cdb90, Offset: 0x43ac
    // Size: 0xad, Type: dev
    function private function_4640f26141acff93()
    {
        if ( !level.player.viking_helmet )
        {
            iprintlnbold( "<dev string:x273>" );
            return;
        }
        
        if ( level.viking_helmets.var_5d49aa0407e613d2 )
        {
            level.viking_helmets.var_5d49aa0407e613d2 = 0;
            level.player.viking_helmet hidefromplayer( level.player );
            return;
        }
        
        level.viking_helmets.var_5d49aa0407e613d2 = 1;
        level.player.viking_helmet showtoplayer( level.player );
    }

#/
