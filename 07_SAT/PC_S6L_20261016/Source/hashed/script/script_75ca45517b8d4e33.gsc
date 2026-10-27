// script_75ca45517b8d4e33  (hash_75ca45517b8d4e33.gscc) (size: 4315 Bytes / 0x10db / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfe35433b (4264903483)
// size ...... 4315 (0x10db)
// includes .. 7   (offset: 0xfe7)
// strings ... 12  (offset: 0x101f)
// dev strs .. 0   (offset: 0x10db)
// exports ... 13  (offset: 0x9d7)
// cseg ...... 0x149 + 0x88e (0x9d7)
// imports ... 34  (offset: 0xbdf)
// animtree1 . 0   (offset: 0x10db)
// animtree2 . 0   (offset: 0x10db)
#using script_35efc59124dbb5db;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;

#namespace namespace_b57d3f6e99f615fe;

// Namespace namespace_b57d3f6e99f615fe
// Params 0
// Checksum 0xb471dc1, Offset: 0x167
// Size: 0x59
function init()
{
    level.mantis_ww_quest.var_1e5d963acb8a335e.sink = utility::getent_or_struct( "ww_quest_step_3_sink", "script_noteworthy" );
    level.mantis_ww_quest.var_1e5d963acb8a335e.acid_pool = getentitylessscriptablearray( "sat_zm_mantis_ww_acid_pool" )[ 0 ];
}

// Namespace namespace_b57d3f6e99f615fe
// Params 2
// Checksum 0x74811551, Offset: 0x1c8
// Size: 0x5b
function execute( skipped, save_restored )
{
    scriptable::scriptable_addusedcallback( &function_df74413d53562f6f );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"mantis_ww_quest", #"sulfur_poured" ) )
    {
        function_53645fc953b499f();
    }
    
    utility::flag_wait( "ww_acid_picked_up" );
}

// Namespace namespace_b57d3f6e99f615fe
// Params 2
// Checksum 0xf6e696d1, Offset: 0x22b
// Size: 0xcd
function cleanup( skipped, save_restored )
{
    quest_data = level.mantis_ww_quest.var_1e5d963acb8a335e;
    
    if ( !quest_data.acid_pool.var_86bdefcb655274be )
    {
        quest_data.acid_pool setscriptablepartstate( "effects", "explosion" );
        quest_data.acid_pool.var_86bdefcb655274be = 1;
    }
    
    utility::flag_set( "ww_sulfur_poured" );
    utility::flag_set( "ww_acid_picked_up" );
    function_14c31e4891bb354f();
    
    if ( !level callback::exists( #"player_connect", &function_89050b7ee119175c ) )
    {
        level callback::add( #"player_connect", &function_89050b7ee119175c );
    }
}

// Namespace namespace_b57d3f6e99f615fe
// Params 6
// Checksum 0x85c234b3, Offset: 0x300
// Size: 0x101
function function_df74413d53562f6f( instance, part, state, player, bautouse, usestring )
{
    if ( instance.type != "sat_zm_mantis_ww_acid_pool" )
    {
        return;
    }
    
    if ( !instance.var_86bdefcb655274be && zm_quest::function_6b5f09e88a4edfce( #"mantis_instruments", 0, #"sat_zm_quest_mantis_wwq_acid", player ) )
    {
        function_53645fc953b499f();
        player thread zm_vo::function_8c1a12974bd11f01( #"hash_a719f0fa00a82a3d", #"bc_flavor_player_positive" );
    }
    else if ( instance.var_86bdefcb655274be && isdefined( player.var_7c67ffa2457cf1ee ) && player.var_7c67ffa2457cf1ee < 3 )
    {
        player function_d57aeecd47d1ad33();
        utility::flag_set( "ww_acid_picked_up" );
        playsoundatpos( instance.origin, "evt_zm_mantis_wwq_sulfur_fill" );
    }
    
    wait 0.3;
}

// Namespace namespace_b57d3f6e99f615fe
// Params 0, eflags: 0x4
// Checksum 0x41fdaf15, Offset: 0x409
// Size: 0xdc
function private function_53645fc953b499f()
{
    quest_data = level.mantis_ww_quest.var_1e5d963acb8a335e;
    acid_pool = quest_data.acid_pool;
    acid_pool setscriptablepartstate( "effects", "explosion" );
    acid_pool.var_86bdefcb655274be = 1;
    function_14c31e4891bb354f();
    utility::flag_set( "ww_sulfur_poured" );
    zm_quest::function_4eefe6de31f5ddab( #"mantis_ww_quest", #"sulfur_poured", 1 );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level.mantis_ww_quest.var_1e5d963acb8a335e.acid_pool setscriptablepartstate( "base", "usable_hint_fill" );
        level.mantis_ww_quest.var_1e5d963acb8a335e.acid_pool childthread function_f30e42baf7e182c6();
    }
}

// Namespace namespace_b57d3f6e99f615fe
// Params 0, eflags: 0x4
// Checksum 0x706915bc, Offset: 0x4ed
// Size: 0x9c
function private function_14c31e4891bb354f()
{
    while ( level.players.size == 0 )
    {
        wait 1;
    }
    
    utility::flag_wait( "ww_sulfur_picked_up" );
    
    foreach ( player in level.players )
    {
        player function_89050b7ee119175c();
    }
}

// Namespace namespace_b57d3f6e99f615fe
// Params 1, eflags: 0x4
// Checksum 0xd0a6353c, Offset: 0x591
// Size: 0x78
function private function_89050b7ee119175c( params )
{
    if ( isdefined( self.var_7c67ffa2457cf1ee ) )
    {
        return;
    }
    
    if ( zm_save::function_fcccc3d2a616b1c7() )
    {
        zm_save::function_1f44a48caae2acbf();
    }
    
    self.var_7c67ffa2457cf1ee = zm_quest::function_73720cdf21c3cfd7( #"mantis_ww_quest", #"hash_23c57b64f11e763f" ) ?? 0;
    zm_quest::function_b57dfe9625966b0b( #"mantis_instruments", 0, #"sat_zm_quest_mantis_wwq_acid", self.var_7c67ffa2457cf1ee + 2, 1, self );
}

// Namespace namespace_b57d3f6e99f615fe
// Params 0, eflags: 0x4
// Checksum 0x82acf252, Offset: 0x611
// Size: 0x91
function private function_d57aeecd47d1ad33()
{
    if ( !self.var_d5f09e73c34cf057 )
    {
        zm_quest::show_splash_item_picked_up( #"mantis_instruments", #"sat_zm_quest_mantis_wwq_acid", 5, self );
        self.var_d5f09e73c34cf057 = 1;
    }
    
    self.var_7c67ffa2457cf1ee = 3;
    zm_quest::function_b57dfe9625966b0b( #"mantis_instruments", 0, #"sat_zm_quest_mantis_wwq_acid", self.var_7c67ffa2457cf1ee + 2, 1, self );
    zm_quest::function_4eefe6de31f5ddab( #"mantis_ww_quest", #"hash_23c57b64f11e763f", 3 );
    level notify( #"player_refilled_acid_vial" );
}

// Namespace namespace_b57d3f6e99f615fe
// Params 0
// Checksum 0x9f8bbbf4, Offset: 0x6aa
// Size: 0x81, Type: bool
function function_2bad0ababb88dbd9()
{
    foreach ( player in level.players )
    {
        if ( player function_f167bbe7c6c0876a() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_b57d3f6e99f615fe
// Params 0
// Checksum 0xff8dcacd, Offset: 0x734
// Size: 0x14, Type: bool
function function_f167bbe7c6c0876a()
{
    if ( self.var_7c67ffa2457cf1ee > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_b57d3f6e99f615fe
// Params 0
// Checksum 0x923adc24, Offset: 0x751
// Size: 0x1b8, Type: bool
function function_bcdd8958faa3f63b()
{
    if ( zm_quest::is_quest_step_complete( #"mantis_ww_quest", #"hash_6e4be9ca1c6f94c" ) )
    {
        return false;
    }
    
    self endon( #"hash_2c4eefaf7e2b24b6" );
    quest_data = level.mantis_ww_quest.var_1e5d963acb8a335e;
    
    if ( !utility::flag( "ww_sulfur_poured" ) )
    {
        thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_76163d5d9aa4ef55", 1 );
        namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.sink.origin, "wwq_mark_sink", 30, 1, { #timetravel_step:{ #future:#"hash_13c1630bcde247b6", #past:#"hash_5d0e2eca82d48d3d" }, #var_7be076c9078045aa:#"hash_76163d5d9aa4ef55" } );
        utility::flag_wait( "ww_sulfur_poured" );
    }
    
    namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
    
    if ( !utility::flag( "ww_acid_picked_up" ) )
    {
        thread zm_quest::update_guidance( undefined, #"hash_4670d9548e1da722", #"hash_76163c5d9aa4eda2", 1 );
        namespace_a7211835085600d5::add_objective_mark( #"hash_4670d9548e1da722", quest_data.sink.origin, "wwq_mark_sink", 30, 1, { #timetravel_step:{ #future:#"hash_13c1630bcde247b6", #past:#"hash_5d0e2eca82d48d3d" }, #var_7be076c9078045aa:#"hash_76163c5d9aa4eda2" } );
        utility::flag_wait( "ww_acid_picked_up" );
    }
    
    namespace_a7211835085600d5::clear_objective_marks( #"hash_4670d9548e1da722" );
    return true;
}

// Namespace namespace_b57d3f6e99f615fe
// Params 0, eflags: 0xc
// Checksum 0x6928d6ca, Offset: 0x912
// Size: 0xc5
function private function_f30e42baf7e182c6()
{
    self notify( #"hash_93032152ed29dbfe" );
    self endon( #"hash_93032152ed29dbfe" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player.var_7c67ffa2457cf1ee == 3 )
            {
                self disablescriptableplayeruse( player );
                continue;
            }
            
            self enablescriptableplayeruse( player );
        }
        
        wait 1;
    }
}

