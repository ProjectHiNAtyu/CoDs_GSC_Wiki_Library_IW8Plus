// script_3b6eb865087dc118  (hash_3b6eb865087dc118.gscc) (size: 14728 Bytes / 0x3988 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb46501aa (3026518442)
// size ...... 14728 (0x3988)
// includes .. 11  (offset: 0x34dc)
// strings ... 40  (offset: 0x3534)
// dev strs .. 32  (offset: 0x37c8)
// exports ... 30  (offset: 0x264c)
// cseg ...... 0x324 + 0x2328 (0x264c)
// imports ... 80  (offset: 0x2afc)
// animtree1 . 0   (offset: 0x3988)
// animtree2 . 0   (offset: 0x3988)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\interaction;
#using scripts\mp\zm\systems\relics\zm_relic_challenges;
#using scripts\mp\zm\systems\relics\zm_relics;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\zm_utility;

#namespace namespace_a6c33b614364964;

// Namespace namespace_a6c33b614364964
// Params 0, eflags: 0x5
// Checksum 0x4f2169da, Offset: 0x342
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_1029a8f5163af82d", undefined, undefined, &init_relics );
}

// Namespace namespace_a6c33b614364964
// Params 0
// Checksum 0xe1b63928, Offset: 0x363
// Size: 0x2b
function init_relics()
{
    if ( !getdvarint( @"hash_70ef86ad43e08120", 0 ) && !level.var_8a98c33a6b47db4a )
    {
        return;
    }
    
    level thread post_init_relics();
}

// Namespace namespace_a6c33b614364964
// Params 0
// Checksum 0xf66d91fb, Offset: 0x396
// Size: 0x2dc
function post_init_relics()
{
    utility::waittill_any_timeout( 5, "create_script_initialized" );
    level.var_39919ce9d7e181ff = utility::getstruct( "relic_warp_loc_1", "script_noteworthy" );
    level.var_a32e584ceb8b4012 = utility::getstruct( "relic_warp_loc_2", "script_noteworthy" );
    level.var_bfe520ab0ebcfc6f = utility::getstruct( "relic_warp_loc_3", "script_noteworthy" );
    level.green_portals = utility::getstructarray( "relic_green_portal", "targetname" );
    level.yellow_portals = utility::getstructarray( "relic_yellow_portal", "targetname" );
    level.red_portals = utility::getstructarray( "relic_red_portal", "targetname" );
    level.var_7f13ceaacec1dc2e = [];
    
    if ( level.green_portals && level.yellow_portals && level.red_portals )
    {
        if ( level.gametypebundle.var_59ebff77b310078 )
        {
            foreach ( index, portal in level.green_portals )
            {
                function_9a0db59ed1b757d4( "easy" + "_" + index, level.green_portals[ index ] );
            }
            
            foreach ( index, portal in level.yellow_portals )
            {
                function_9a0db59ed1b757d4( "medium" + "_" + index, level.yellow_portals[ index ] );
            }
            
            foreach ( index, portal in level.red_portals )
            {
                function_9a0db59ed1b757d4( "hard" + "_" + index, level.red_portals[ index ] );
            }
        }
    }
    
    level callback::add( #"relic_challenge_started", &relic_challenge_started );
    level callback::add( #"relic_challenge_ended", &relic_challenge_ended );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"enable_relic_challenge", &function_e39d6d49c8c1b317 );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_662b3647b6715fe0", &function_cd6ec8d944da6075 );
    
    /#
        level thread init_relic_debug();
    #/
}

// Namespace namespace_a6c33b614364964
// Params 3
// Checksum 0xfefa7fad, Offset: 0x67a
// Size: 0x478
function function_9a0db59ed1b757d4( portal_type, struct, relicname )
{
    if ( !isdefined( struct ) )
    {
        return;
    }
    
    if ( level.var_7f13ceaacec1dc2e[ portal_type ].portal )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player playlocalsound( "evt_relic_mrpeeks_stinger" );
    }
    
    level.var_7f13ceaacec1dc2e[ portal_type ] = {};
    level.var_7f13ceaacec1dc2e[ portal_type ].portal = spawnscriptable( "zm_relic_portals", struct.origin, struct.angles );
    waitframe();
    portal_part = "green_portal";
    reliclist = level.zm_relic_tier_bundles[ "easy" ].relics;
    
    if ( issubstr( portal_type, "easy" ) )
    {
        portal_part = "green_portal";
        reliclist = level.zm_relic_tier_bundles[ "easy" ].relics;
    }
    else if ( issubstr( portal_type, "medium" ) )
    {
        portal_part = "yellow_portal";
        reliclist = level.zm_relic_tier_bundles[ "medium" ].relics;
    }
    else if ( issubstr( portal_type, "hard" ) )
    {
        portal_part = "red_portal";
        reliclist = level.zm_relic_tier_bundles[ "hard" ].relics;
    }
    
    if ( level.gametypebundle.var_59ebff77b310078 )
    {
        relicname = function_ebcf998bf875708c( reliclist, 0 );
    }
    
    if ( !relicname )
    {
        return;
    }
    
    relicbundle = level.zm_relics[ relicname ];
    level.var_7f13ceaacec1dc2e[ portal_type ].portal utility::function_7c10ea82c1e305b8( "vfx", portal_part );
    level.var_7f13ceaacec1dc2e[ portal_type ].portal.on_part = portal_part;
    level.var_7f13ceaacec1dc2e[ portal_type ].portal.portal_type = portal_type;
    level.var_7f13ceaacec1dc2e[ portal_type ].portal.interact = spawnscriptable( "zm_sat_relic_portal_interact", struct.origin, struct.angles );
    interact_scriptable = level.var_7f13ceaacec1dc2e[ portal_type ].portal.interact;
    level.var_7f13ceaacec1dc2e[ portal_type ].portal.interact = interaction::register_scriptable_interact( interact_scriptable, &play_relic_portal );
    level.var_7f13ceaacec1dc2e[ portal_type ].portal.interact utility::function_7c10ea82c1e305b8( "relic_interact", "on_visible" );
    level.var_7f13ceaacec1dc2e[ portal_type ].portal.interact interaction::set_interact_hint_callback( &set_interact_hint );
    level.var_7f13ceaacec1dc2e[ portal_type ].portal.interact.interact_use_range = 55;
    level.var_7f13ceaacec1dc2e[ portal_type ].portal.interact.portal = level.var_7f13ceaacec1dc2e[ portal_type ].portal;
    
    if ( level.gametypebundle.var_59ebff77b310078 )
    {
        level.var_7f13ceaacec1dc2e[ portal_type ].portal.var_aadb7535959da099 = &function_273ae46e243b928;
    }
    
    if ( relicbundle.zmrelicchallenge )
    {
        relicchallengebundle = getscriptbundle( relicbundle.zmrelicchallenge );
    }
    
    function_404ffd9a49c2cc4b( portal_type, relicbundle, relicname, relicchallengebundle, reliclist );
    logstring( "[R_MOD] Relic Portal Spawned " + relicname + " , " + relicbundle.zmrelicchallenge );
    return level.var_7f13ceaacec1dc2e[ portal_type ].portal;
}

// Namespace namespace_a6c33b614364964
// Params 1
// Checksum 0x4c9b6cd9, Offset: 0xafb
// Size: 0x2d9
function play_relic_portal( player )
{
    if ( self.var_df00f5fbf4a6d195 )
    {
        return;
    }
    
    if ( utility::flag( "start_boss_fight" ) )
    {
        return;
    }
    
    if ( player.interactions_disabled )
    {
        return;
    }
    
    portaltype = self.portal_type;
    challengeref = self.var_928a089b815e11df;
    
    if ( utility::issharedfuncdefined( challengeref, #"hash_e042082431a803da" ) )
    {
        if ( utility::callsharedfunc( challengeref, #"hash_e042082431a803da" ) == 0 )
        {
            return;
        }
    }
    
    portal_cinematic = "zm_sat_teleport_vortex_green";
    var_35369f8394bddd73 = "green_vs";
    warp_loc = level.var_39919ce9d7e181ff;
    
    if ( issubstr( self.portal_type, "easy" ) )
    {
        var_35369f8394bddd73 = "green_vs";
        warp_loc = level.var_39919ce9d7e181ff;
        teleport_color = "green";
    }
    else if ( issubstr( self.portal_type, "medium" ) )
    {
        var_35369f8394bddd73 = "yellow_vs";
        warp_loc = level.var_a32e584ceb8b4012;
        teleport_color = "yellow";
    }
    else if ( issubstr( self.portal_type, "hard" ) )
    {
        var_35369f8394bddd73 = "red_vs";
        warp_loc = level.var_bfe520ab0ebcfc6f;
        teleport_color = "red";
    }
    
    var_5489a0edbdfeebfc = level.var_7f13ceaacec1dc2e[ self.portal_type ];
    
    if ( self.relicbundle.zmrelicchallenge && !level.active_relic_challenge )
    {
        if ( level.gametypebundle.var_59ebff77b310078 && self.var_618de9e73de3a48d > 0 )
        {
            level notify( #"restart_round" );
            n_round = self.var_618de9e73de3a48d;
            zm_round_logic::function_68bdb49c82c0f892( n_round );
        }
        
        var_3faf858e79cd17bb = spawnstruct();
        var_3faf858e79cd17bb.init_message = &"hash_368ffead421750f5";
        var_3faf858e79cd17bb.header = &"hash_61740678afe29134";
        var_3faf858e79cd17bb.description = &"zm_sat_r_mod/relics_disabled_trial";
        b_passed = zm_quest::vote_think( player, var_3faf858e79cd17bb );
        
        if ( b_passed && zm_quest::function_f98968f17772726c( 1 ) )
        {
            self.var_df00f5fbf4a6d195 = 1;
            var_5489a0edbdfeebfc.portal zm_relic_challenges::function_f4e21bb3d60470a2( self.var_668c08cad822fb1e, undefined, warp_loc );
        }
        else
        {
            return;
        }
        
        if ( !level.gametypebundle.var_59ebff77b310078 )
        {
            if ( self.portal )
            {
                self.portal freescriptable();
            }
            
            if ( self )
            {
                self freescriptable();
            }
        }
        
        return;
    }
    
    player playsoundtoplayer( #"ui_zm_core_purchase_deny", player );
    self.var_df00f5fbf4a6d195 = 0;
}

// Namespace namespace_a6c33b614364964
// Params 2, eflags: 0x4
// Checksum 0xa812cd5, Offset: 0xddc
// Size: 0x4a
function private function_ebcf998bf875708c( reliclist, index )
{
    var_2153e39e051f5b91 = undefined;
    
    if ( level.gametypebundle.var_59ebff77b310078 )
    {
        var_2153e39e051f5b91 = reliclist[ index ].relicdata;
    }
    
    return var_2153e39e051f5b91;
}

// Namespace namespace_a6c33b614364964
// Params 2
// Checksum 0xf7a5f074, Offset: 0xe2f
// Size: 0x21e
function set_interact_hint( interact, player )
{
    if ( utility::flag( "start_boss_fight" ) )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( interact.var_df00f5fbf4a6d195 )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    hint_data = interact function_1e2d92fa2ad032be( interact, player );
    
    if ( level.gametypebundle.var_59ebff77b310078 && interact.portal )
    {
        player zm_utility::function_6fca5749e8c5007a( interact.portal );
    }
    
    portaltype = interact.portal_type;
    challengeref = interact.var_928a089b815e11df;
    
    if ( utility::issharedfuncdefined( challengeref, #"hash_f50e57484a42476e" ) )
    {
        override_hint_data = utility::callsharedfunc( challengeref, #"hash_f50e57484a42476e" );
        
        if ( override_hint_data )
        {
            return override_hint_data;
        }
    }
    
    return { #interactable:hint_data.interactable, #var_776a268784e089af:hint_data.var_776a268784e089af, #var_492f94db590aab17:hint_data.var_492f94db590aab17, #altbuttoncallout:hint_data.altbuttoncallout, #buttoncallout:hint_data.buttoncallout, #icon:"ui_hud_minimap_teleportation_portal", #var_609f30dc7ba9270:hint_data.var_609f30dc7ba9270, #aux_text:hint_data.aux_text, #description:hint_data.description, #title:hint_data.title, #params:[], #string:hint_data.var_ca8523ea008acd97, #type:hint_data.type };
}

// Namespace namespace_a6c33b614364964
// Params 2, eflags: 0x4
// Checksum 0x5cf51466, Offset: 0x1055
// Size: 0x11d
function private function_1e2d92fa2ad032be( interact, player )
{
    hint_data = {};
    hint_data.type = "HINT_BUTTON";
    hint_data.title = &"zm_sat_r_mod/crucible_desc";
    hint_data.description = interact.var_94c89824a639d812;
    hint_data.buttoncallout = &"zm_sat_r_mod/portalrelic";
    hint_data.interactable = 1;
    
    if ( interact.var_32e452fc519bf7ea )
    {
        hint_data.description = interact.var_32e452fc519bf7ea;
    }
    
    if ( interact.var_1e43d2d2d6b5cb39 )
    {
        hint_data.aux_text = &"zm_sat_r_mod/relics_disabled_trial";
    }
    else
    {
        hint_data.var_609f30dc7ba9270 = &"zm_sat_r_mod/relics_disabled_trial";
    }
    
    if ( level.gametypebundle.var_59ebff77b310078 )
    {
        hint_data.altbuttoncallout = &"zm_sat_r_mod/portalrelic_change_relic";
        hint_data.var_492f94db590aab17 = 1;
    }
    
    return hint_data;
}

// Namespace namespace_a6c33b614364964
// Params 2
// Checksum 0x456343f7, Offset: 0x117b
// Size: 0x1b0
function function_1c0a6e520d0f0cfb( player, var_e78fe14d1a55fee9 )
{
    reliclist = level.var_7f13ceaacec1dc2e[ self.portal_type ].portal.interact.reliclist;
    
    if ( !isdefined( level.var_7f13ceaacec1dc2e[ self.portal_type ].portal.var_7ecffaa11286203d ) )
    {
        level.var_7f13ceaacec1dc2e[ self.portal_type ].portal.var_7ecffaa11286203d = 0;
    }
    
    level.var_7f13ceaacec1dc2e[ self.portal_type ].portal.var_7ecffaa11286203d++;
    
    if ( level.var_7f13ceaacec1dc2e[ self.portal_type ].portal.var_7ecffaa11286203d >= reliclist.size )
    {
        level.var_7f13ceaacec1dc2e[ self.portal_type ].portal.var_7ecffaa11286203d = 0;
    }
    
    var_5ea0dc7889086434 = function_ebcf998bf875708c( reliclist, level.var_7f13ceaacec1dc2e[ self.portal_type ].portal.var_7ecffaa11286203d );
    relicbundle = level.zm_relics[ var_5ea0dc7889086434 ];
    
    if ( relicbundle.zmrelicchallenge )
    {
        relicchallengebundle = getscriptbundle( relicbundle.zmrelicchallenge );
    }
    
    function_404ffd9a49c2cc4b( self.portal_type, relicbundle, var_5ea0dc7889086434, relicchallengebundle, reliclist );
}

// Namespace namespace_a6c33b614364964
// Params 1
// Checksum 0x8e965ab6, Offset: 0x1333
// Size: 0xe, Type: bool
function function_bff3f5da92054d76( interact )
{
    return true;
}

// Namespace namespace_a6c33b614364964
// Params 1
// Checksum 0x89e24414, Offset: 0x134a
// Size: 0x4e
function function_273ae46e243b928( interact )
{
    var_83ed92f76a8975ea = {};
    var_83ed92f76a8975ea.var_b5410045d7e4b8c4 = &function_1c0a6e520d0f0cfb;
    var_83ed92f76a8975ea.var_71dcc241ec928818 = &function_bff3f5da92054d76;
    var_83ed92f76a8975ea.var_8c429812367b06d9 = 0.5;
    return var_83ed92f76a8975ea;
}

// Namespace namespace_a6c33b614364964
// Params 5, eflags: 0x4
// Checksum 0xefdc767d, Offset: 0x13a1
// Size: 0x248
function private function_404ffd9a49c2cc4b( portaltype, relicbundle, relicname, relicchallengebundle, reliclist )
{
    level.var_7f13ceaacec1dc2e[ portaltype ].portal.interact.portal_type = portaltype;
    level.var_7f13ceaacec1dc2e[ portaltype ].portal.interact.relicbundle = relicbundle;
    level.var_7f13ceaacec1dc2e[ portaltype ].portal.interact.var_668c08cad822fb1e = relicname;
    level.var_7f13ceaacec1dc2e[ portaltype ].portal.interact.name = relicbundle.name;
    level.var_7f13ceaacec1dc2e[ portaltype ].portal.interact.var_94c89824a639d812 = relicchallengebundle ? relicchallengebundle.description : undefined;
    level.var_7f13ceaacec1dc2e[ portaltype ].portal.interact.reliclist = reliclist;
    level.var_7f13ceaacec1dc2e[ portaltype ].portal.interact.var_618de9e73de3a48d = relicchallengebundle.var_618de9e73de3a48d;
    level.var_7f13ceaacec1dc2e[ portaltype ].portal.interact.var_32e452fc519bf7ea = relicchallengebundle ? relicchallengebundle.var_b3c2cf901b97d199 : undefined;
    level.var_7f13ceaacec1dc2e[ portaltype ].portal.interact.var_1e43d2d2d6b5cb39 = relicchallengebundle ? relicchallengebundle.var_b50018cd3fb7ca88 : undefined;
    level.var_7f13ceaacec1dc2e[ portaltype ].portal.interact.var_928a089b815e11df = relicchallengebundle ? relicchallengebundle.modifiertype : undefined;
}

// Namespace namespace_a6c33b614364964
// Params 1, eflags: 0x4
// Checksum 0xb1cfbeed, Offset: 0x15f1
// Size: 0xef
function private relic_challenge_started( params )
{
    if ( level.var_7f13ceaacec1dc2e.size > 0 )
    {
        foreach ( struct in level.var_7f13ceaacec1dc2e )
        {
            if ( struct.portal )
            {
                struct.portal utility::function_7c10ea82c1e305b8( "vfx", "off" );
                
                if ( struct.portal.interact )
                {
                    struct.portal.interact.var_df00f5fbf4a6d195 = 1;
                }
            }
        }
    }
}

// Namespace namespace_a6c33b614364964
// Params 1, eflags: 0x4
// Checksum 0x48a152ef, Offset: 0x16e8
// Size: 0x27e
function private relic_challenge_ended( params )
{
    if ( level.var_7f13ceaacec1dc2e.size > 0 )
    {
        foreach ( struct in level.var_7f13ceaacec1dc2e )
        {
            if ( struct.portal && struct.portal.on_part )
            {
                struct.portal utility::function_7c10ea82c1e305b8( "vfx", struct.portal.on_part );
                
                if ( struct.portal.interact )
                {
                    struct.portal.interact.var_df00f5fbf4a6d195 = 0;
                }
            }
        }
    }
    
    if ( !params.var_c5acdbec60b34aab )
    {
        relic_bundle = level.zm_relics[ params.relic_challenge_type ];
        index = relic_bundle.portalindex;
        tier = relic_bundle.tier;
        difficulty = zm_relics::function_d0c08a0a6af33ba3( tier );
        
        switch ( difficulty )
        {
            case #"hash_22ce4003c1e5227b":
                var_5489a0edbdfeebfc = level.green_portals[ index ];
                break;
            case #"hash_c71b112fe04823d6":
                var_5489a0edbdfeebfc = level.yellow_portals[ index ];
                break;
            case #"hash_cc9157548a55043c":
                var_5489a0edbdfeebfc = level.red_portals[ index ];
                break;
            default:
                break;
        }
        
        if ( difficulty && var_5489a0edbdfeebfc )
        {
            portal = function_9a0db59ed1b757d4( difficulty + "_" + index, var_5489a0edbdfeebfc, params.relic_challenge_type );
            
            if ( portal.interact )
            {
                portal.interact.var_df00f5fbf4a6d195 = 1;
            }
            
            portal utility::function_7c10ea82c1e305b8( "vfx", "gray_portal" );
            portal thread function_9dafe62383fe31d9( difficulty );
            return;
        }
        
        assertmsg( "<dev string:x24>" );
    }
}

// Namespace namespace_a6c33b614364964
// Params 1, eflags: 0x4
// Checksum 0xb7a54c3c, Offset: 0x196e
// Size: 0xbf
function private function_9dafe62383fe31d9( portal_difficulty )
{
    level endon( #"game_ended" );
    level waittill( #"on_round_start" );
    
    switch ( portal_difficulty )
    {
        case #"hash_22ce4003c1e5227b":
            color = "green";
            break;
        case #"hash_c71b112fe04823d6":
            color = "yellow";
            break;
        case #"hash_cc9157548a55043c":
            color = "red";
            break;
        default:
            break;
    }
    
    utility::function_7c10ea82c1e305b8( "vfx", color + "_portal" );
    
    if ( self.interact )
    {
        self.interact.var_df00f5fbf4a6d195 = 0;
    }
}

// Namespace namespace_a6c33b614364964
// Params 1
// Checksum 0x2964fd6c, Offset: 0x1a35
// Size: 0x19d
function function_e39d6d49c8c1b317( params )
{
    relic_hash = hashcat( %"relic:", params[ 0 ] );
    relic_bundle = level.zm_relics[ relic_hash ];
    index = level.zm_relics[ relic_hash ].portalindex;
    
    if ( !relic_bundle )
    {
        return;
    }
    
    tier = relic_bundle.tier;
    tiername = "easy" + "_" + index;
    portal = level.green_portals[ index ];
    
    switch ( tier )
    {
        case 1:
            portal = level.green_portals[ index ];
            tiername = "easy" + "_" + index;
            break;
        case 2:
            portal = level.yellow_portals[ index ];
            tiername = "medium" + "_" + index;
            break;
        case 3:
            portal = level.red_portals[ index ];
            tiername = "hard" + "_" + index;
            break;
    }
    
    if ( level.var_7f13ceaacec1dc2e[ tiername ].portal )
    {
        level.var_7f13ceaacec1dc2e[ tiername ].portal freescriptable();
        level.var_7f13ceaacec1dc2e[ tiername ].portal.interact freescriptable();
    }
    
    function_9a0db59ed1b757d4( tiername, portal, relic_hash );
}

// Namespace namespace_a6c33b614364964
// Params 1
// Checksum 0x1822aeb7, Offset: 0x1bda
// Size: 0x259
function function_cd6ec8d944da6075( params )
{
    foreach ( relic_hash, var_2153e39e051f5b91 in level.zm_relics )
    {
        relic_bundle = var_2153e39e051f5b91;
        index = var_2153e39e051f5b91.portalindex;
        
        if ( !relic_bundle )
        {
            continue;
        }
        
        if ( !relic_bundle.zmrelicchallenge )
        {
            continue;
        }
        
        map_name = level.mapname;
        map_name = removesubstr( map_name, "zm_sat_" );
        
        if ( relic_bundle.mapsubstr != map_name )
        {
            continue;
        }
        
        tier = relic_bundle.tier;
        tiername = "easy" + "_" + index;
        portal = level.green_portals[ index ];
        
        switch ( tier )
        {
            case 1:
                portal = level.green_portals[ index ];
                tiername = "easy" + "_" + index;
                break;
            case 2:
                portal = level.yellow_portals[ index ];
                tiername = "medium" + "_" + index;
                break;
            case 3:
                portal = level.red_portals[ index ];
                tiername = "hard" + "_" + index;
                break;
        }
        
        if ( level.var_7f13ceaacec1dc2e[ tiername ].portal )
        {
            level.var_7f13ceaacec1dc2e[ tiername ].portal freescriptable();
            level.var_7f13ceaacec1dc2e[ tiername ].portal.interact freescriptable();
        }
        
        relicbundle = level.zm_relics[ relic_hash ];
        logstring( "[R_MOD] DEBUG Relic Portal Spawned with console callback " + relic_hash + " , " + relicbundle.zmrelicchallenge );
        function_9a0db59ed1b757d4( tiername, portal, relic_hash );
    }
}

/#

    // Namespace namespace_a6c33b614364964
    // Params 0
    // Checksum 0xb859c657, Offset: 0x1e3b
    // Size: 0x3cd, Type: dev
    function init_relic_debug()
    {
        wait 5;
        devgui::function_9082edeb5db93280( "<dev string:x63>" );
        
        foreach ( relic_key, relic_value in level.zm_relic_tier_bundles[ "<dev string:x76>" ].relics )
        {
            if ( isdefined( relic_value.relicdata ) )
            {
                var_ead6cad3657a6923 = getxhashsourcename( relic_value.relicdata );
                var_ead6cad3657a6923 = removesubstr( var_ead6cad3657a6923, "<dev string:x7b>" );
                index = level.zm_relics[ relic_value.relicdata ].portalindex;
                devgui::function_cd4e263c1f3018ae( "<dev string:x82>" + var_ead6cad3657a6923, "<dev string:x96>" + "<dev string:x76>" + "<dev string:xaa>" + var_ead6cad3657a6923 + "<dev string:xaa>" + index, &debug_spawn_portal, 0 );
            }
        }
        
        foreach ( relic_key, relic_value in level.zm_relic_tier_bundles[ "<dev string:xac>" ].relics )
        {
            if ( isdefined( relic_value.relicdata ) )
            {
                var_ead6cad3657a6923 = getxhashsourcename( relic_value.relicdata );
                var_ead6cad3657a6923 = removesubstr( var_ead6cad3657a6923, "<dev string:x7b>" );
                index = level.zm_relics[ relic_value.relicdata ].portalindex;
                devgui::function_cd4e263c1f3018ae( "<dev string:xb3>" + var_ead6cad3657a6923, "<dev string:x96>" + "<dev string:xac>" + "<dev string:xaa>" + var_ead6cad3657a6923 + "<dev string:xaa>" + index, &debug_spawn_portal, 0 );
            }
        }
        
        foreach ( relic_key, relic_value in level.zm_relic_tier_bundles[ "<dev string:xc8>" ].relics )
        {
            if ( isdefined( relic_value.relicdata ) )
            {
                var_ead6cad3657a6923 = getxhashsourcename( relic_value.relicdata );
                var_ead6cad3657a6923 = removesubstr( var_ead6cad3657a6923, "<dev string:x7b>" );
                index = level.zm_relics[ relic_value.relicdata ].portalindex;
                devgui::function_cd4e263c1f3018ae( "<dev string:xcd>" + var_ead6cad3657a6923, "<dev string:x96>" + "<dev string:xc8>" + "<dev string:xaa>" + var_ead6cad3657a6923 + "<dev string:xaa>" + index, &debug_spawn_portal, 0 );
            }
        }
        
        devgui::add_devgui_func( "<dev string:xdf>", "<dev string:xf6>", &function_df0fbabbcab46063 );
        devgui::add_devgui_func( "<dev string:x110>", "<dev string:x127>", &function_df0fbbbbcab46296 );
        devgui::add_devgui_func( "<dev string:x141>", "<dev string:x158>", &function_df0fbcbbcab464c9 );
        devgui::add_devgui_func( "<dev string:x172>", "<dev string:x18a>", &function_408f6592db135340 );
        devgui::add_devgui_func( "<dev string:x1a5>", "<dev string:x1bd>", &function_408f6892db1359d9 );
        devgui::add_devgui_func( "<dev string:x1d8>", "<dev string:x1f0>", &function_408f6792db1357a6 );
        devgui::add_devgui_func( "<dev string:x20b>", "<dev string:x220>", &function_3825f941812ae73f );
        devgui::add_devgui_func( "<dev string:x238>", "<dev string:x24d>", &function_3825fa41812ae972 );
        devgui::add_devgui_func( "<dev string:x265>", "<dev string:x27a>", &function_3825fb41812aeba5 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_a6c33b614364964
    // Params 1
    // Checksum 0x11e02f39, Offset: 0x2210
    // Size: 0x11e, Type: dev
    function function_7f004e0df8400142( warplocation )
    {
        foreach ( player in level.players )
        {
            origin = warplocation.origin;
            angles = warplocation.angles + ( 0, -90, 0 );
            right = anglestoright( warplocation.angles );
            plangles = vectortoangles( right ) + ( 0, 180, 0 );
            var_dfcdb500ce642a84 = origin + anglestoforward( angles ) * 24;
            var_dfcdb500ce642a84 = getgroundposition( var_dfcdb500ce642a84, 16 );
            player setorigin( var_dfcdb500ce642a84 );
            player setplayerangles( plangles );
        }
    }

    // Namespace namespace_a6c33b614364964
    // Params 1
    // Checksum 0xb6d43a32, Offset: 0x2336
    // Size: 0x21, Type: dev
    function function_df0fbabbcab46063( warplocation )
    {
        function_7f004e0df8400142( level.green_portals[ 0 ] );
    }

    // Namespace namespace_a6c33b614364964
    // Params 1
    // Checksum 0x2fdd6b89, Offset: 0x235f
    // Size: 0x22, Type: dev
    function function_df0fbbbbcab46296( warplocation )
    {
        function_7f004e0df8400142( level.green_portals[ 1 ] );
    }

    // Namespace namespace_a6c33b614364964
    // Params 1
    // Checksum 0x58da5b1c, Offset: 0x2389
    // Size: 0x22, Type: dev
    function function_df0fbcbbcab464c9( warplocation )
    {
        function_7f004e0df8400142( level.green_portals[ 2 ] );
    }

    // Namespace namespace_a6c33b614364964
    // Params 1
    // Checksum 0x2a0163a4, Offset: 0x23b3
    // Size: 0x21, Type: dev
    function function_408f6592db135340( warplocation )
    {
        function_7f004e0df8400142( level.yellow_portals[ 0 ] );
    }

    // Namespace namespace_a6c33b614364964
    // Params 1
    // Checksum 0xb308321f, Offset: 0x23dc
    // Size: 0x22, Type: dev
    function function_408f6892db1359d9( warplocation )
    {
        function_7f004e0df8400142( level.yellow_portals[ 1 ] );
    }

    // Namespace namespace_a6c33b614364964
    // Params 1
    // Checksum 0xc40f028a, Offset: 0x2406
    // Size: 0x22, Type: dev
    function function_408f6792db1357a6( warplocation )
    {
        function_7f004e0df8400142( level.yellow_portals[ 2 ] );
    }

    // Namespace namespace_a6c33b614364964
    // Params 1
    // Checksum 0xdad6e0c9, Offset: 0x2430
    // Size: 0x21, Type: dev
    function function_3825f941812ae73f( warplocation )
    {
        function_7f004e0df8400142( level.red_portals[ 0 ] );
    }

    // Namespace namespace_a6c33b614364964
    // Params 1
    // Checksum 0x43dfb172, Offset: 0x2459
    // Size: 0x22, Type: dev
    function function_3825fa41812ae972( warplocation )
    {
        function_7f004e0df8400142( level.red_portals[ 1 ] );
    }

    // Namespace namespace_a6c33b614364964
    // Params 1
    // Checksum 0x34d881e7, Offset: 0x2483
    // Size: 0x22, Type: dev
    function function_3825fb41812aeba5( warplocation )
    {
        function_7f004e0df8400142( level.red_portals[ 2 ] );
    }

    // Namespace namespace_a6c33b614364964
    // Params 1
    // Checksum 0xab122d4a, Offset: 0x24ad
    // Size: 0x19f, Type: dev
    function debug_spawn_portal( params )
    {
        portal = level.green_portals[ int( params[ 2 ] ) ];
        
        switch ( params[ 0 ] )
        {
            case #"hash_22ce4003c1e5227b":
                portal = level.green_portals[ int( params[ 2 ] ) ];
                break;
            case #"hash_c71b112fe04823d6":
                portal = level.yellow_portals[ int( params[ 2 ] ) ];
                break;
            case #"hash_cc9157548a55043c":
                portal = level.red_portals[ int( params[ 2 ] ) ];
                break;
        }
        
        if ( level.var_7f13ceaacec1dc2e[ params[ 0 ] + "<dev string:x292>" + int( params[ 2 ] ) ].portal )
        {
            level.var_7f13ceaacec1dc2e[ params[ 0 ] + "<dev string:x292>" + int( params[ 2 ] ) ].portal freescriptable();
            level.var_7f13ceaacec1dc2e[ params[ 0 ] + "<dev string:x292>" + int( params[ 2 ] ) ].portal.interact freescriptable();
        }
        
        relic_string = "<dev string:x7b>" + params[ 1 ];
        relic_hash = getxhashasset( relic_string );
        relicbundle = level.zm_relics[ relic_hash ];
        logstring( "<dev string:x294>" + relic_hash + "<dev string:x2b8>" + relicbundle.zmrelicchallenge );
        function_9a0db59ed1b757d4( params[ 0 ] + "<dev string:x292>" + int( params[ 2 ] ), portal, relic_hash );
    }

#/
