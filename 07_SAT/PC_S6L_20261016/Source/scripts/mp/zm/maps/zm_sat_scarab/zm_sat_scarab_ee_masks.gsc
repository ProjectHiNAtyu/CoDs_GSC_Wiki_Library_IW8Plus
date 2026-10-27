// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ee_masks.gsc  (hash_58ee1ed454d66da8.gscc) (size: 24783 Bytes / 0x60cf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbde33c17 (3185785879)
// size ...... 24783 (0x60cf)
// includes .. 22  (offset: 0x5b3b)
// strings ... 67  (offset: 0x5beb)
// dev strs .. 6   (offset: 0x6087)
// exports ... 50  (offset: 0x3b77)
// cseg ...... 0x5a7 + 0x35d0 (0x3b77)
// imports ... 197 (offset: 0x4347)
// animtree1 . 0   (offset: 0x60cf)
// animtree2 . 0   (offset: 0x60cf)
#using script_16ea1b94f0f381b3;
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\shared\zombie\zombie_dismemberment;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\status_effects\status_effects;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\armor;
#using scripts\mp\loot\common_item;
#using scripts\mp\player_banter;
#using scripts\mp\zm\systems\zm_armor;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_scarab_ee_masks;

// Namespace zm_sat_scarab_ee_masks
// Params 0, eflags: 0x5
// Checksum 0x9ec87c97, Offset: 0x5c5
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_sat_scarab_ee_masks", undefined, undefined, &init );
}

// Namespace zm_sat_scarab_ee_masks
// Params 0
// Checksum 0x1994a67, Offset: 0x5e6
// Size: 0x3cb
function init()
{
    if ( !getdvarint( @"hash_1339f37dad46cdfd", 0 ) )
    {
        return;
    }
    
    level utility::flag_wait_all( "zm_quest_initialized", "scriptables_ready", "doorbuy_init_complete" );
    level.scarab_ee_masks = spawnstruct();
    level.scarab_ee_masks.var_c72c979b2dbc4e94 = [];
    level utility::registersharedfunc( #"scarab_ee_masks", #"hash_f9027848f45b0e57", &function_8029992d67c074e8 );
    var_2b6982932b3afba3 = zm_quest::get_quest_relaxed( #"hash_cf9b2fa99529bc3c" );
    
    if ( var_2b6982932b3afba3 )
    {
        level utility::registersharedfunc( #"zmloot_scarab_hose_ee_mask", #"hash_2e22b6be73e28e05", &function_cd4515ffecd6e464 );
        level utility::registersharedfunc( #"zmloot_scarab_hose_ee_mask", #"onuse", &function_59c26eb1b9cd1b0e );
        level.scarab_ee_masks.var_c72c979b2dbc4e94[ "zmloot_scarab_hose_ee_mask" ] = &function_be5e932592c69d4e;
    }
    
    var_b0aaf5e5ec45115b = zm_quest::get_quest_relaxed( #"hash_ee671a1fa81f1a29" );
    
    if ( var_b0aaf5e5ec45115b )
    {
        level utility::registersharedfunc( #"zmloot_scarab_grp_ee_mask", #"hash_2e22b6be73e28e05", &function_cd4515ffecd6e464 );
        level utility::registersharedfunc( #"zmloot_scarab_grp_ee_mask", #"onuse", &function_59c26eb1b9cd1b0e );
        level.scarab_ee_masks.var_c72c979b2dbc4e94[ "zmloot_scarab_grp_ee_mask" ] = &function_a4dbbca8a7645b28;
    }
    
    scarab_twins_ee = zm_quest::get_quest_relaxed( #"scarab_twins_ee" );
    
    if ( scarab_twins_ee )
    {
        level utility::registersharedfunc( #"zmloot_scarab_twins_ee_mask", #"hash_2e22b6be73e28e05", &function_cd4515ffecd6e464 );
        level utility::registersharedfunc( #"zmloot_scarab_twins_ee_mask", #"onuse", &function_59c26eb1b9cd1b0e );
        level.scarab_ee_masks.var_c72c979b2dbc4e94[ "zmloot_scarab_twins_ee_mask" ] = &twins_ee_mask_ability;
    }
    
    level utility::registersharedfunc( #"zmloot_scarab_loom_ride_ee_mask", #"hash_2e22b6be73e28e05", &function_cd4515ffecd6e464 );
    level utility::registersharedfunc( #"zmloot_scarab_loom_ride_ee_mask", #"onuse", &function_59c26eb1b9cd1b0e );
    level.scarab_ee_masks.var_c72c979b2dbc4e94[ "zmloot_scarab_loom_ride_ee_mask" ] = &function_4fc9f4c779ae989;
    callback::add( #"hash_61bdb5dfdbcf747f", &on_player_emote );
    callback::add( #"player_death", &on_player_death );
    callback::add( #"player_disconnect", &on_player_disconnect );
    callback::add( "on_ride_loom", &on_ride_loom );
    level.var_aa557d3b178667ae = [ "zmloot_scarab_loom_ride_ee_mask":4, "zmloot_scarab_grp_ee_mask":3, "zmloot_scarab_twins_ee_mask":2, "zmloot_scarab_hose_ee_mask":1 ];
    level.scarab_ee_masks.spawned_masks = [];
    level.scarab_ee_masks.spawned_masks[ "zmloot_scarab_hose_ee_mask" ] = 0;
    level.scarab_ee_masks.spawned_masks[ "zmloot_scarab_twins_ee_mask" ] = 0;
    level.scarab_ee_masks.spawned_masks[ "zmloot_scarab_grp_ee_mask" ] = 0;
    level.scarab_ee_masks.spawned_masks[ "zmloot_scarab_loom_ride_ee_mask" ] = 0;
    common_item::function_c7bbbfcefe78f798( "zmloot_scarab_hose_ee_mask", &function_6358a5db1c2da0e3 );
    common_item::function_c7bbbfcefe78f798( "zmloot_scarab_twins_ee_mask", &function_3ff7c33100522163 );
    common_item::function_c7bbbfcefe78f798( "zmloot_scarab_grp_ee_mask", &function_3823cac320101d09 );
    common_item::function_c7bbbfcefe78f798( "zmloot_scarab_loom_ride_ee_mask", &function_da60aa5dd216f5a8 );
    level.mask_pedestals = getentarray( "scarab_ee_mask_pedestal", "targetname" );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_9ff9bf7b3d029f7e", &function_208e6a667e0cc7eb );
    scene::function_85b13b837056bc8b( &function_242c89ca96990d82 );
    scene::function_53de0775d8452750( &function_6cabf9faa15342f7 );
    
    /#
        level thread function_13875aa3cfb64545();
    #/
}

// Namespace zm_sat_scarab_ee_masks
// Params 1
// Checksum 0x76a7ac93, Offset: 0x9b9
// Size: 0xe3
function on_player_emote( params )
{
    self endon( #"death_or_disconnect" );
    
    while ( !self isemoteactive() && !self function_985124b0e1e74f2e() )
    {
        waitframe();
    }
    
    if ( !self.mask_ee.var_536177437db76a1f.third_person )
    {
        if ( self.mask_ee.var_536177437db76a1f )
        {
            self.mask_ee.var_536177437db76a1f show();
        }
        
        while ( self isemoteactive() || self function_985124b0e1e74f2e() )
        {
            waitframe();
        }
        
        if ( self.mask_ee.var_536177437db76a1f && !self.mask_ee.var_536177437db76a1f.third_person )
        {
            self.mask_ee.var_536177437db76a1f hide();
        }
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 0
// Checksum 0x95b882a2, Offset: 0xaa4
// Size: 0xd7
function function_242c89ca96990d82()
{
    scene_players = scene::function_5fe163f439457bd0();
    
    foreach ( player in scene_players )
    {
        if ( player.mask_ee.var_536177437db76a1f )
        {
            player.var_242c89ca96990d82 = 1;
            player.mask_ee.var_536177437db76a1f hide();
            player.mask_ee.var_536177437db76a1f hidefromplayer( player );
        }
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 0
// Checksum 0xd392d457, Offset: 0xb83
// Size: 0x113
function function_6cabf9faa15342f7()
{
    scene_players = scene::function_5fe163f439457bd0();
    
    foreach ( player in scene_players )
    {
        if ( player.mask_ee.var_536177437db76a1f )
        {
            player.var_242c89ca96990d82 = undefined;
            player.mask_ee.var_536177437db76a1f show();
            player.mask_ee.var_536177437db76a1f showtoplayer( player );
            
            if ( !player.mask_ee.var_536177437db76a1f.third_person )
            {
                player.mask_ee.var_536177437db76a1f hidefromplayer( player );
            }
        }
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 1
// Checksum 0xd0dec7f, Offset: 0xc9e
// Size: 0x33
function function_6358a5db1c2da0e3( params )
{
    level.scarab_ee_masks.spawned_masks[ "zmloot_scarab_hose_ee_mask" ] = 1;
    self.disable_dragged = 1;
}

// Namespace zm_sat_scarab_ee_masks
// Params 1
// Checksum 0xdbbd27c6, Offset: 0xcd9
// Size: 0x33
function function_3ff7c33100522163( params )
{
    level.scarab_ee_masks.spawned_masks[ "zmloot_scarab_twins_ee_mask" ] = 1;
    self.disable_dragged = 1;
}

// Namespace zm_sat_scarab_ee_masks
// Params 1
// Checksum 0x3048e2a8, Offset: 0xd14
// Size: 0x33
function function_3823cac320101d09( params )
{
    level.scarab_ee_masks.spawned_masks[ "zmloot_scarab_grp_ee_mask" ] = 1;
    self.disable_dragged = 1;
}

// Namespace zm_sat_scarab_ee_masks
// Params 1
// Checksum 0xd1d2f491, Offset: 0xd4f
// Size: 0x33
function function_da60aa5dd216f5a8( params )
{
    level.scarab_ee_masks.spawned_masks[ "zmloot_scarab_loom_ride_ee_mask" ] = 1;
    self.disable_dragged = 1;
}

// Namespace zm_sat_scarab_ee_masks
// Params 4
// Checksum 0x7e174aed, Offset: 0xd8a
// Size: 0x6d, Type: bool
function function_cd4515ffecd6e464( itembundle, item, autouse, var_51e0c31d31f04b31 )
{
    if ( isdefined( self ) && self.interactions_disabled )
    {
        return false;
    }
    
    if ( !zm_player::function_f37cfdf04b932a03( self ) )
    {
        return false;
    }
    
    if ( !item )
    {
        return false;
    }
    
    if ( self.mask_ee.var_73e37bf886655ce7 == itembundle )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_scarab_ee_masks
// Params 4, eflags: 0x4
// Checksum 0xaaec45fc, Offset: 0xe00
// Size: 0x527
function private function_59c26eb1b9cd1b0e( itembundle, item, autouse, var_981c264073bf1154 )
{
    level endon( #"game_ended" );
    
    if ( !arraycontains( [ "zmloot_scarab_hose_ee_mask", "zmloot_scarab_twins_ee_mask", "zmloot_scarab_grp_ee_mask", "zmloot_scarab_loom_ride_ee_mask" ], itembundle.ref ) )
    {
        return;
    }
    
    self.scarab_ee_mask_id = level.var_aa557d3b178667ae[ itembundle.ref ];
    
    if ( !isdefined( self.mask_ee ) )
    {
        self.mask_ee = spawnstruct();
    }
    
    if ( !isdefined( self.mask_ee.var_f6d4d287c24a9cdf ) )
    {
        self.mask_ee.var_f6d4d287c24a9cdf = [];
    }
    
    if ( self.mask_ee.var_73e37bf886655ce7 == itembundle )
    {
        return;
    }
    
    if ( self.mask_ee.var_73e37bf886655ce7 )
    {
        self.mask_ee.var_b2a6177426a92fea = self.mask_ee.var_73e37bf886655ce7;
        
        if ( self.mask_ee.var_536177437db76a1f )
        {
            self.mask_ee.var_536177437db76a1f delete();
        }
        
        the_pedestal = 0;
        
        foreach ( pedestal in level.mask_pedestals )
        {
            if ( pedestal.script_noteworthy == self.mask_ee.var_73e37bf886655ce7.ref )
            {
                the_pedestal = pedestal;
                break;
            }
        }
        
        if ( the_pedestal )
        {
            the_pedestal function_9966a4b0003d61b5( self.mask_ee.var_73e37bf886655ce7, self.mask_ee.var_73e37bf886655ce7.ref );
        }
        else
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
            var_bbd7d44950a15fc = common_item::function_61c2c0251e742ffd( self.mask_ee.var_73e37bf886655ce7, undefined, spawnoptions );
            var_bbd7d44950a15fc.disable_dragged = 1;
        }
        
        level utility::flag_clear( var_bbd7d44950a15fc.type + "_worn" );
        utility::ent_flag_clear( var_bbd7d44950a15fc.type + "_worn" );
        self notify( #"mask_removed" );
    }
    
    self prestreamasset( "model", itembundle.worldmodel );
    spawnoptions = function_a266026c6dc0aee4( itembundle.ref );
    mask = utility::spawn_model( itembundle.worldmodel, undefined, undefined, undefined, spawnoptions.scale );
    mask notsolid();
    mask linkto( self, spawnoptions.tag, spawnoptions.orgoffset, spawnoptions.organgles );
    mask function_7207895b28c71c79( 1 );
    mask hudoutlineenable( "outline_depth_trans_transparent_visible" );
    
    foreach ( player in level.players )
    {
        if ( player != self )
        {
            mask showtoplayer( player );
        }
    }
    
    if ( self getcamerathirdperson() )
    {
        mask showtoplayer( self );
        mask.third_person = 1;
    }
    else
    {
        mask hidefromplayer( self );
        mask.third_person = 0;
    }
    
    thread function_2138597b31f236d3( mask );
    self.mask_ee.var_73e37bf886655ce7 = itembundle;
    self.mask_ee.var_536177437db76a1f = mask;
    level utility::flag_set( itembundle.ref + "_earned" );
    level utility::flag_set( itembundle.ref + "_worn" );
    utility::ent_flag_set( itembundle.ref + "_worn" );
    var_c4d81242b1597e07 = function_cbf15a8c68637bcf( itembundle.ref );
    
    if ( var_c4d81242b1597e07 )
    {
        self.mask_ee.var_f6d4d287c24a9cdf[ itembundle.ref ] = 1;
        thread function_ee75973a58b4aaf3( itembundle.ref );
    }
    
    f_mask_ability = level.scarab_ee_masks.var_c72c979b2dbc4e94[ itembundle.ref ];
    self thread [[ f_mask_ability ]]( itembundle, item, autouse, var_981c264073bf1154 );
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0x4
// Checksum 0x865e861d, Offset: 0x132f
// Size: 0x23, Type: bool
function private function_cbf15a8c68637bcf( maskref )
{
    return !self.mask_ee.var_f6d4d287c24a9cdf[ maskref ];
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0x4
// Checksum 0xf4b3f0d1, Offset: 0x135b
// Size: 0x5d
function private function_ee75973a58b4aaf3( maskref )
{
    var_8984c1f1eeea88ec = function_d8b90db8d5d11b68( maskref );
    
    if ( !isalive( self ) || self.mask_ee.var_73e37bf886655ce7.ref != maskref )
    {
        return;
    }
    
    player_banter::play_banter_vo( var_8984c1f1eeea88ec, [ self ] );
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0x4
// Checksum 0xb68756a8, Offset: 0x13c0
// Size: 0x60
function private function_d8b90db8d5d11b68( maskref )
{
    if ( maskref == "zmloot_scarab_hose_ee_mask" )
    {
        return #"hash_c993bcd052ca91b7";
    }
    
    if ( maskref == "zmloot_scarab_twins_ee_mask" )
    {
        return #"hash_b6e912a5ed738902";
    }
    
    if ( maskref == "zmloot_scarab_grp_ee_mask" )
    {
        return #"hash_480dbe8daaa80f05";
    }
    
    if ( maskref == "zmloot_scarab_loom_ride_ee_mask" )
    {
        return #"hash_9e5a51317bb81344";
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0x4
// Checksum 0xc6b54137, Offset: 0x1429
// Size: 0x1a0
function private function_a266026c6dc0aee4( maskref )
{
    spawnoptions = {};
    
    if ( maskref == "zmloot_scarab_hose_ee_mask" )
    {
        spawnoptions.scale = 1.1;
        spawnoptions.tag = "j_head";
        spawnoptions.orgoffset = ( 1.1, -1, 0.25 );
        spawnoptions.organgles = ( 0, 0, 0 );
    }
    else if ( maskref == "zmloot_scarab_grp_ee_mask" )
    {
        spawnoptions.scale = 0.5;
        spawnoptions.tag = "j_head";
        spawnoptions.orgoffset = ( -6, 6, 0 );
        spawnoptions.organgles = ( 0, 0, 0 );
    }
    else if ( maskref == "zmloot_scarab_loom_ride_ee_mask" )
    {
        spawnoptions.scale = 1.5;
        spawnoptions.tag = "j_head";
        spawnoptions.orgoffset = ( 11, 1.5, 0 );
        spawnoptions.organgles = ( 0, 0, 0 );
    }
    else if ( maskref == "zmloot_scarab_twins_ee_mask" )
    {
        spawnoptions.scale = 1.1;
        spawnoptions.tag = "j_head";
        spawnoptions.orgoffset = ( 1.1, -1, 0.25 );
        spawnoptions.organgles = ( 0, 0, 0 );
    }
    
    return spawnoptions;
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0xc
// Checksum 0x4be579d6, Offset: 0x15d2
// Size: 0xb3
function private function_2138597b31f236d3( mask )
{
    self notify( #"hash_d9202d47a87e5173" );
    self endon( #"hash_d9202d47a87e5173" );
    self endon( #"death_or_disconnect", #"mask_removed" );
    
    while ( true )
    {
        if ( self.var_242c89ca96990d82 || self isplayingxcam() || utility::ent_flag( "scene_active" ) )
        {
            waitframe();
            continue;
        }
        
        if ( self function_eb1c5f16d7237597() )
        {
            mask hidefromplayer( self );
        }
        else if ( self getcamerathirdperson() )
        {
            mask showtoplayer( self );
            mask.third_person = 1;
        }
        else
        {
            mask.third_person = 0;
            mask hidefromplayer( self );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 4, eflags: 0x4
// Checksum 0x2a05d5bf, Offset: 0x168d
// Size: 0xb2
function private function_be5e932592c69d4e( itembundle, item, autouse, var_981c264073bf1154 )
{
    level endon( #"game_ended" );
    thread function_f69c1ce45fdcd43d( itembundle, item, autouse, var_981c264073bf1154 );
    
    if ( !level._effect[ "scarab_ee_masks_domain_expansion" ] && !level._effect[ "scarab_ee_masks_domain_expansion_bounds" ] )
    {
        level._effect[ "scarab_ee_masks_domain_expansion" ] = loadfxasset( "vfx_sat_levels_zm_scarab_ee_masks_domain_expansion" );
        level._effect[ "scarab_ee_masks_domain_expansion_bounds" ] = loadfxasset( "vfx_sat_levels_zm_scarab_ee_domain_expansion_bounds" );
        level._effect[ "scarab_ee_masks_domain_expansion_proj_kill" ] = loadfxasset( "vfx_sat_firefly_aether_shroud_torso_3p_purple" );
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 4, eflags: 0xc
// Checksum 0x4d3331ca, Offset: 0x1747
// Size: 0x360
function private function_f69c1ce45fdcd43d( itembundle, item, autouse, var_981c264073bf1154 )
{
    self notify( #"hash_f7ba8af894e4053d" );
    self endon( #"hash_f7ba8af894e4053d" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.mask_ee.var_c8ac7c301731cadf = gettime();
    self.mask_ee.var_c269289d98fec4d3 = 10;
    self.mask_ee.var_a5f4c33c42ff709b = gettime();
    self.mask_ee.var_faee80a8dad2f6e6 = 0;
    wasonground = function_bfe98d949f05eaff();
    
    do
    {
        wait 0.1;
        timenow = gettime();
        isonground = function_bfe98d949f05eaff();
        
        if ( isonground && !wasonground )
        {
            self.mask_ee.var_faee80a8dad2f6e6 = timenow + 1;
        }
        
        wasonground = isonground;
        
        if ( timenow <= self.mask_ee.var_faee80a8dad2f6e6 )
        {
            continue;
        }
        
        if ( function_4ef2fe2a5398b858() )
        {
            self.mask_ee.var_a5f4c33c42ff709b = timenow;
            continue;
        }
        
        if ( self.mask_ee.var_c269289d98fec4d3 )
        {
            if ( !level utility::time_has_passed( self.mask_ee.var_c8ac7c301731cadf, self.mask_ee.var_c269289d98fec4d3 ) )
            {
                continue;
            }
        }
        else if ( !level utility::time_has_passed( self.mask_ee.var_c8ac7c301731cadf, 60 ) )
        {
            continue;
        }
        
        if ( !function_d960bde2539c3bf9() )
        {
            continue;
        }
        
        if ( !level utility::time_has_passed( self.mask_ee.var_a5f4c33c42ff709b, 3 ) )
        {
            timeleft = 3 - ( timenow - self.mask_ee.var_a5f4c33c42ff709b ) * 0.001;
            
            /#
                iprintln( "<dev string:x24>" + timeleft );
            #/
            
            continue;
        }
        
        if ( level.scarab_pap_quest.var_405ba86a0a3065d9 && level.scarab_pap_quest.var_405ba86a0a3065d9 utility::ent_flag( "is_in_lowering_sequence" ) && distancesquared( self.origin, level.scarab_pap_quest.var_405ba86a0a3065d9.origin ) <= squared( 525 ) )
        {
            /#
                level thread utility::draw_circle( level.scarab_pap_quest.var_405ba86a0a3065d9.origin, 525, ( 0, 0, 0 ), 1, 1, 100 );
            #/
            
            continue;
        }
        
        if ( self.mask_ee.var_c269289d98fec4d3 )
        {
            self.mask_ee.var_c269289d98fec4d3 = undefined;
        }
        
        self.mask_ee.var_c8ac7c301731cadf = timenow;
        thread function_48a59c3c2f5c9709( timenow );
    }
    while ( utility::ent_flag( itembundle.ref + "_worn" ) && self.mask_ee.var_73e37bf886655ce7.ref == "zmloot_scarab_hose_ee_mask" );
}

// Namespace zm_sat_scarab_ee_masks
// Params 0, eflags: 0x4
// Checksum 0xa323026e, Offset: 0x1aaf
// Size: 0x25, Type: bool
function private function_bfe98d949f05eaff()
{
    return self isonground() || vehicle::is_in_vehicle( 1 ) || self isonladder() || self isswimming();
}

// Namespace zm_sat_scarab_ee_masks
// Params 0, eflags: 0x4
// Checksum 0xe83d160, Offset: 0x1add
// Size: 0x6a, Type: bool
function private function_4ef2fe2a5398b858()
{
    if ( self issprintsliding() )
    {
        return true;
    }
    
    if ( !self isonground() || self isdiving() )
    {
        return true;
    }
    
    if ( self isremotecontrolling() )
    {
        return ( self function_fadc0f718a6cfc84() || self flydownbuttonpressed() || self function_840406ca91ace7b8() != ( 0, 0, 0 ) );
    }
    
    if ( self getnormalizedmovement() != ( 0, 0, 0 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_scarab_ee_masks
// Params 0, eflags: 0x4
// Checksum 0x2fd7bead, Offset: 0x1b50
// Size: 0x76, Type: bool
function private function_d960bde2539c3bf9()
{
    if ( !zm_player::function_f37cfdf04b932a03( self, undefined, 1 ) )
    {
        return false;
    }
    
    if ( self isnoclip() || self isufo() )
    {
        return false;
    }
    
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( self isonascender() )
    {
        return false;
    }
    
    if ( self isjumping() )
    {
        return false;
    }
    
    if ( !function_bfe98d949f05eaff() )
    {
        return false;
    }
    
    if ( self islaststandinvulnerable() )
    {
        return false;
    }
    
    vehicle = vehicle::get_vehicle();
    
    if ( isdefined( vehicle ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0x4
// Checksum 0xa1f58847, Offset: 0x1bcf
// Size: 0x409
function private function_48a59c3c2f5c9709( var_c8ac7c301731cadf )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( self.mask_ee.var_73e37bf886655ce7.ref != "zmloot_scarab_hose_ee_mask" )
    {
        return;
    }
    
    e_fx_tag = utility::spawn_model( "tag_origin", self gettagorigin( "tag_origin" ), self.angles );
    e_fx_tag playsoundonmovingent( #"hash_95075184eb401f0a" );
    e_fx_tag thread utility::play_loop_sound_on_entity( #"hash_b1a19591ce8feec", ( 0, 0, 20 ) );
    playfxontag( utility::getfx( "scarab_ee_masks_domain_expansion" ), e_fx_tag, "tag_origin" );
    playfxontag( utility::getfx( "scarab_ee_masks_domain_expansion_bounds" ), e_fx_tag, "tag_origin" );
    e_fx_tag thread function_9147eac76f0680e4( self, var_c8ac7c301731cadf );
    var_ef7ea34bb57c2cff = self.var_bba1e16138d312c8;
    self.var_bba1e16138d312c8 = &override_armor_damage;
    var_79364e3d44d3b80d = self.var_a48163c16d11e1b1;
    self.var_a48163c16d11e1b1 = &function_a01280595b8b126f;
    is_playing_loop_sound = 0;
    
    /#
        level thread utility::draw_circle( e_fx_tag.origin, 190, ( 0, 0, 0 ), 1, 1, 500 );
    #/
    
    while ( e_fx_tag )
    {
        wait 0.1;
        
        if ( !e_fx_tag )
        {
            break;
        }
        
        var_c83b287028a279f9 = distancesquared( self.origin, e_fx_tag.origin );
        
        if ( var_c83b287028a279f9 > 36100 )
        {
            e_fx_tag thread function_5ccf2d3e03ebc350( self );
            break;
        }
        
        if ( self.armorhealth < self.maxarmorhealth )
        {
            var_12454f0b928bc1d6 = armor::getarmorhealth();
            var_575fa5fcfb8b6b1c = level.zombie_augments[ #"juggernog_shielded" ].var_840d64e41ac5801a ?? 8;
            var_12454f0b928bc1d6 += var_575fa5fcfb8b6b1c;
            armor::setarmorhealth( var_12454f0b928bc1d6 );
            
            if ( self.var_9ef5dcd22c39f926 )
            {
                thread zm_armor::function_ea0fcb86e1a69395();
            }
            
            if ( !is_playing_loop_sound )
            {
                is_playing_loop_sound = 1;
                thread utility::play_loop_sound_on_entity( "evt_scarab_mask_skull_heal_lp", ( 0, 0, 64 ) );
            }
        }
        else
        {
            is_playing_loop_sound = 0;
            self notify( "stop sound" + "evt_scarab_mask_skull_heal_lp" );
        }
        
        foreach ( zombieprojectile in level.grenades )
        {
            if ( !isdefined( zombieprojectile ) || zombieprojectile.exploding )
            {
                continue;
            }
            
            var_d406ef2303b98fd6 = distancesquared( zombieprojectile.origin, e_fx_tag.origin );
            
            if ( var_d406ef2303b98fd6 > 40000 )
            {
                continue;
            }
            
            var_ff9ae945684e153a = !zombieprojectile.owner && zombieprojectile.classname == "grenade" ? getmissileowner( zombieprojectile ) : zombieprojectile.owner;
            
            if ( isplayer( var_ff9ae945684e153a ) )
            {
                continue;
            }
            
            if ( var_ff9ae945684e153a.team != zm_utility::get_zombie_team() )
            {
                continue;
            }
            
            zombieprojectile setcandamage( 0 );
            zombieprojectile.exploding = 1;
            zombieprojectile stopsounds();
            var_e412fdd77e29ef3f = utility::spawn_model( "tag_origin", zombieprojectile.origin, zombieprojectile.angles );
            playfxontag( utility::getfx( "scarab_ee_masks_domain_expansion_proj_kill" ), var_e412fdd77e29ef3f, "tag_origin" );
            var_e412fdd77e29ef3f thread utility::delete_after_delay( 0.5 );
            zombieprojectile delete();
        }
    }
    
    self.var_bba1e16138d312c8 = var_ef7ea34bb57c2cff;
    self.var_a48163c16d11e1b1 = var_79364e3d44d3b80d;
    is_playing_loop_sound = 0;
    self notify( "stop sound" + "evt_scarab_mask_skull_heal_lp" );
}

// Namespace zm_sat_scarab_ee_masks
// Params 4, eflags: 0x4
// Checksum 0x8000d7ea, Offset: 0x1fe0
// Size: 0x2f
function private override_armor_damage( damage, attacker, means_of_death, absorbed_damage )
{
    return damage * 0.8;
}

// Namespace zm_sat_scarab_ee_masks
// Params 3, eflags: 0x4
// Checksum 0xb16350e, Offset: 0x2018
// Size: 0x26
function private function_a01280595b8b126f( damage, eattacker, smeansofdeath )
{
    return damage * 0.5;
}

// Namespace zm_sat_scarab_ee_masks
// Params 2, eflags: 0x4
// Checksum 0x6eac9a97, Offset: 0x2047
// Size: 0x29c
function private function_9147eac76f0680e4( player, var_c8ac7c301731cadf )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    currentround = zm_utility::get_round_number();
    var_633489ee645e852b = int( namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", currentround ) );
    var_e71a91736918de1b = var_633489ee645e852b;
    var_1743d7de6d5bd6bf = 0;
    var_a8dbffa306ec9e71 = 40;
    var_ed0d0651a82b76e3 = var_a8dbffa306ec9e71 * 0.25;
    var_4454dfeae7294a9 = zm_round_spawning::function_f8f9048f8658271c();
    
    while ( !level utility::time_has_passed( var_c8ac7c301731cadf, 10 ) && var_1743d7de6d5bd6bf < var_a8dbffa306ec9e71 )
    {
        var_40465bf1f7337a23 = getaiarrayinradius( self.origin, 190 );
        var_bc29a9fa1201b0a0 = player.origin ?? self.origin;
        var_cd7f665bf1755878 = utility::get_array_of_closest( var_bc29a9fa1201b0a0, var_40465bf1f7337a23 );
        
        foreach ( zombie in var_cd7f665bf1755878 )
        {
            if ( !level zm_utility::is_active_zombie( zombie ) )
            {
                continue;
            }
            
            if ( zombie.aicategory == "boss" || zombie.aicategory == "hvt" )
            {
                continue;
            }
            
            if ( zombie status_effects::function_fa35fc2723e956eb( "burn", "domain_expansion" ) )
            {
                continue;
            }
            
            if ( zombie.var_65de3f7c461c1611 && zombie val::get( "ignoreall" ) )
            {
                continue;
            }
            
            if ( var_4454dfeae7294a9 > 0 && var_1743d7de6d5bd6bf >= var_4454dfeae7294a9 - 1 )
            {
                continue;
            }
            
            if ( var_1743d7de6d5bd6bf >= var_ed0d0651a82b76e3 )
            {
                var_7dff4eed3b9fde2c = var_633489ee645e852b * 0.75;
                var_a77a7baed79d52a2 = var_7dff4eed3b9fde2c / 5;
            }
            else if ( var_1743d7de6d5bd6bf >= var_ed0d0651a82b76e3 * 0.5 )
            {
                var_a77a7baed79d52a2 = var_e71a91736918de1b / 5;
            }
            else
            {
                var_a77a7baed79d52a2 = var_e71a91736918de1b;
            }
            
            eattacker = isalive( player ) ? player : self;
            zombie thread effect_burn::burn( 5, var_a77a7baed79d52a2, 1, eattacker, "domain_expansion", undefined, undefined, "purple_fire", 1, undefined, 1 );
            zombie playloopsound( "evt_scarab_mask_skull_burning_lp" );
            var_1743d7de6d5bd6bf++;
            
            if ( var_1743d7de6d5bd6bf >= var_a8dbffa306ec9e71 )
            {
                break;
            }
        }
        
        waitframe();
    }
    
    thread function_5ccf2d3e03ebc350( player );
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0x4
// Checksum 0xbd2ab270, Offset: 0x22eb
// Size: 0x270
function private function_5ccf2d3e03ebc350( player )
{
    stopfxontag( utility::getfx( "scarab_ee_masks_domain_expansion" ), self, "tag_origin" );
    stopfxontag( utility::getfx( "scarab_ee_masks_domain_expansion_bounds" ), self, "tag_origin" );
    thread utility::delete_after_delay( 1 );
    var_4454dfeae7294a9 = zm_round_spawning::function_f8f9048f8658271c();
    var_3de11b9b30112a0d = 0;
    var_677ba767edf628a = getaiarrayinradius( self.origin, 142 );
    
    foreach ( zombie in var_677ba767edf628a )
    {
        if ( !level zm_utility::is_active_zombie( zombie ) )
        {
            continue;
        }
        
        if ( zombie.aicategory == "elite" || zombie.aicategory == "boss" || zombie.aicategory == "hvt" )
        {
            continue;
        }
        
        if ( zombie.var_65de3f7c461c1611 && zombie val::get( "ignoreall" ) )
        {
            continue;
        }
        
        if ( var_4454dfeae7294a9 > 0 && var_3de11b9b30112a0d >= var_4454dfeae7294a9 - 1 )
        {
            continue;
        }
        
        var_3de11b9b30112a0d++;
        zombie thread function_5bbe1675085316ab( player );
    }
    
    var_40465bf1f7337a23 = getaiarrayinradius( self.origin, 238 );
    
    foreach ( zombie in var_40465bf1f7337a23 )
    {
        if ( !level zm_utility::is_active_zombie( zombie ) )
        {
            continue;
        }
        
        if ( zombie.aicategory == "boss" || zombie.aicategory == "hvt" )
        {
            continue;
        }
        
        if ( zombie.var_fe24d9e9f6bab2d4 )
        {
            continue;
        }
        
        zombie thread zombie_stun::stun_ai( 3 );
        zombie utility::function_32b24db3127bff40( "burned_purple", "burned_on" );
        zombie utility::delaythread( 3, &utility::function_32b24db3127bff40, "burned_purple", "burned_on" );
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0x4
// Checksum 0x2f07e0e5, Offset: 0x2563
// Size: 0xda
function private function_5bbe1675085316ab( player )
{
    self endon( #"death" );
    self.nuked = 1;
    self.no_powerups = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.full_gib = 1;
    self.var_65522105f3bdca37 = 1;
    self.var_fe24d9e9f6bab2d4 = 1;
    zombie_stun::stun_ai( 100 );
    utility::function_32b24db3127bff40( "burned_purple", "burned_on" );
    wait randomfloatrange( 0.5, 1 );
    
    if ( isalive( self ) && !self.magic_bullet_shield && !val::get( "damageshield" ) )
    {
        self dodamage( self.health, self.origin, player, undefined, "MOD_ELEMENTAL_FIRE", level.weaponnone, "none", undefined, 536936448 );
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 4, eflags: 0x4
// Checksum 0x96005aba, Offset: 0x2645
// Size: 0x27
function private function_a4dbbca8a7645b28( itembundle, item, autouse, var_981c264073bf1154 )
{
    
}

// Namespace zm_sat_scarab_ee_masks
// Params 4, eflags: 0x4
// Checksum 0xac97950b, Offset: 0x2674
// Size: 0x8a
function private twins_ee_mask_ability( itembundle, item, autouse, var_981c264073bf1154 )
{
    if ( !isdefined( self.mask_ee.var_847fe40d015151bb ) )
    {
        self.mask_ee.var_847fe40d015151bb = 0;
    }
    
    if ( !level callback::exists( #"on_ai_killed", &function_25835a577e3cfb99 ) )
    {
        level callback::add( #"on_ai_killed", &function_25835a577e3cfb99 );
    }
    
    thread twins_ee_mask_watcher( itembundle );
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0xc
// Checksum 0xa88f7808, Offset: 0x2706
// Size: 0x77
function private twins_ee_mask_watcher( itembundle )
{
    self notify( #"hash_22c15c31f8971d25" );
    self endon( #"hash_22c15c31f8971d25" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self waittill( #"mask_removed" );
    
    if ( level callback::exists( #"on_ai_killed", &function_25835a577e3cfb99 ) )
    {
        level callback::remove( #"on_ai_killed", &function_25835a577e3cfb99 );
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0x4
// Checksum 0xceac2df6, Offset: 0x2785
// Size: 0x5f
function private function_25835a577e3cfb99( params )
{
    if ( !isplayer( params.eattacker ) )
    {
        return;
    }
    
    player = params.eattacker;
    
    if ( self.var_fb70d1836134a225 )
    {
        level thread twins_ee_mask_trigger( player, self.origin, self.var_5f0553e4f7ab47f7 );
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 3, eflags: 0x4
// Checksum 0x9553e429, Offset: 0x27ec
// Size: 0x65a
function private twins_ee_mask_trigger( player, v_kill_origin, var_f9a4774628fedae0 = 0 )
{
    level endon( #"game_ended" );
    player.mask_ee.var_847fe40d015151bb = gettime();
    self.var_fb70d1836134a225 = undefined;
    self.var_5f0553e4f7ab47f7 = undefined;
    s_scene = spawnstruct();
    s_scene.origin = v_kill_origin;
    var_c2914619b3afef50 = vectornormalize( player.origin - v_kill_origin );
    s_scene.angles = ( 0, vectortoangles( var_c2914619b3afef50 )[ 1 ], 0 );
    playfx( utility::getfx( "twins_ee_spawn" ), s_scene.origin );
    lightning_fx = spawnscriptable( %"ammomod_proc_deadwire_lightning_strike", s_scene.origin );
    playsoundatpos( s_scene.origin + ( 0, 0, 75 ), #"hash_f55d02ed9cf27f90" );
    a_nearby_players = getplayersinradius( s_scene.origin, 500 );
    
    foreach ( nearby_player in a_nearby_players )
    {
        nearby_player playrumbleonentity( "damage_light" );
        nearby_player earthquakeforplayer( 0.5, 0.75, s_scene.origin, 500 );
    }
    
    a_nearby = getaiarrayinradius( s_scene.origin, 60 );
    
    foreach ( zombie in a_nearby )
    {
        if ( !level zm_utility::is_active_zombie( zombie ) )
        {
            continue;
        }
        
        if ( zombie.aicategory == "boss" || zombie.aicategory == "hvt" || zombie.aicategory == "elite" || zombie.aicategory == "special" )
        {
            continue;
        }
        
        zombie thread twins_ee_mask_kill_zombie( player );
        waitframe();
    }
    
    s_scene thread scene::play( undefined, "dance_idle", "sat_cin_zm_vig_fly_sisters_dance" );
    s_scene.var_fe9ebcd9161bbae8 = s_scene scene::get_entities();
    
    foreach ( mdl in s_scene.var_fe9ebcd9161bbae8 )
    {
        mdl.var_2fc3a5fb762afb6e = 1;
        mdl utility::function_7c10ea82c1e305b8( "reveal", "invisible" );
        mdl utility::function_7c10ea82c1e305b8( "reveal", "reveal_in" );
        mdl castshadows();
    }
    
    wait 0.2;
    a_zombies = getaiarrayinradius( s_scene.origin, 275 );
    a_zombies = utility::get_array_of_closest( s_scene.origin, a_zombies );
    a_valid_zombies = [];
    
    foreach ( zombie in a_zombies )
    {
        if ( !level zm_utility::is_active_zombie( zombie ) )
        {
            continue;
        }
        
        if ( zombie.aicategory == "boss" || zombie.aicategory == "hvt" || zombie.aicategory == "elite" || zombie.aicategory == "special" )
        {
            continue;
        }
        
        a_valid_zombies[ a_valid_zombies.size ] = zombie;
        
        if ( a_valid_zombies.size >= 12 )
        {
            break;
        }
    }
    
    if ( var_f9a4774628fedae0 )
    {
        level utility::delaythread( 0.6, &function_8dec968223f4f8ee, player, s_scene.var_fe9ebcd9161bbae8 );
    }
    
    foreach ( zombie in a_valid_zombies )
    {
        zombie thread function_7905b4dc09852f6d( player, s_scene.origin );
        wait randomfloatrange( 0.05, 0.15 );
    }
    
    wait 0.75;
    
    foreach ( mdl in s_scene.var_fe9ebcd9161bbae8 )
    {
        mdl utility::function_7c10ea82c1e305b8( "reveal", "reveal_out" );
        mdl dontcastshadows();
    }
    
    wait 3;
    
    foreach ( mdl in s_scene.var_fe9ebcd9161bbae8 )
    {
        mdl delete();
    }
    
    s_scene scene::stop();
    
    if ( lightning_fx )
    {
        lightning_fx freescriptable();
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 2, eflags: 0x4
// Checksum 0x39fc770a, Offset: 0x2e4e
// Size: 0x269
function private function_7905b4dc09852f6d( player, var_7e3ef9239e5b0313 )
{
    level endon( #"game_ended" );
    self.no_powerups = 1;
    self.var_a13bed1ac47e1b2c = 1;
    
    if ( isalive( self ) && !self.magic_bullet_shield && !val::get( "damageshield" ) )
    {
        val::set( "ww_quest_a_p", "damage", 0 );
        utility::function_32b24db3127bff40( "scarab_mask_ee", "twins_mask_on" );
        
        if ( utility::callsharedfunc( #"ai", #"hash_eeabeb442ca0054", "disciple_injection_grabbed" ) )
        {
            thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "disciple_injection_grabbed", "grabbed_end", self.origin, self.angles, undefined, 1 );
            wait 0.15;
        }
        
        var_eabf46d6bd414c00 = utility::spawn_model( "tag_origin", self.origin, self.angles );
        self linkto( var_eabf46d6bd414c00, "tag_origin" );
        var_eabf46d6bd414c00 moveto( var_eabf46d6bd414c00.origin + ( 0, 0, 30 ), 1, 0.4 );
        wait 1;
        
        if ( !isalive( self ) )
        {
            return;
        }
        
        self unlink();
        
        if ( var_eabf46d6bd414c00 )
        {
            var_eabf46d6bd414c00 delete();
        }
        
        var_f367f9d3b8965d26 = self.origin;
        
        if ( zombie_dismemberment::is_dismemberment_allowed( "head" ) )
        {
            zombie_dismemberment::dismember_limb( 1, undefined, "head" );
        }
        
        self kill();
        var_24ed309d808c077a = self getcorpseentity();
        
        if ( var_24ed309d808c077a )
        {
            v_dir = var_f367f9d3b8965d26 - var_7e3ef9239e5b0313;
            v_dir = ( v_dir[ 0 ], v_dir[ 1 ], 0 );
            v_dir = vectornormalize( v_dir );
            var_3a08540ddb5890a9 = randomintrange( 6000, 10000 );
            launchx = v_dir[ 0 ] * var_3a08540ddb5890a9 + randomintrange( -800, 800 );
            launchy = v_dir[ 1 ] * var_3a08540ddb5890a9 + randomintrange( -800, 800 );
            launchz = randomintrange( 6000, 9000 );
            var_24ed309d808c077a startragdollfromimpact( "torso_lower", ( launchx, launchy, launchz ) );
        }
        
        if ( !isalive( self ) && isplayer( player ) )
        {
            params = spawnstruct();
            params.scoreevent = #"zombie_kia_mask";
            player callback::callback( "zombie_score_event", params );
        }
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0x4
// Checksum 0x58ea3066, Offset: 0x30bf
// Size: 0xda
function private twins_ee_mask_kill_zombie( player )
{
    self.nuked = 1;
    self.no_powerups = 1;
    self.var_a13bed1ac47e1b2c = 1;
    self.full_gib = 1;
    self.var_65522105f3bdca37 = 1;
    
    if ( zombie_dismemberment::is_dismemberment_allowed( "head" ) )
    {
        zombie_dismemberment::dismember_limb( 1, undefined, "head" );
    }
    
    wait 0.15;
    
    if ( isalive( self ) && !self.magic_bullet_shield && !val::get( "damageshield" ) )
    {
        self kill();
        
        if ( !isalive( self ) && isplayer( player ) )
        {
            params = spawnstruct();
            params.scoreevent = #"zombie_kia_mask";
            player callback::callback( "zombie_score_event", params );
        }
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0x4
// Checksum 0x2711a3e3, Offset: 0x31a1
// Size: 0x7b, Type: bool
function private function_d1c7e6fd3014be37( player )
{
    if ( !isalive( player ) )
    {
        return false;
    }
    
    if ( !utility::percent_chance( 50 ) )
    {
        return false;
    }
    
    if ( !isdefined( player.mask_ee.var_7be1cad029c59a9a ) )
    {
        player.mask_ee.var_7be1cad029c59a9a = 0;
    }
    
    if ( !level utility::time_has_passed( player.mask_ee.var_7be1cad029c59a9a, 120 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_scarab_ee_masks
// Params 2, eflags: 0x4
// Checksum 0x79487a66, Offset: 0x3225
// Size: 0x62
function private function_8dec968223f4f8ee( player, var_fe9ebcd9161bbae8 )
{
    player.mask_ee.var_7be1cad029c59a9a = gettime();
    
    if ( utility::cointoss() )
    {
        var_fe9ebcd9161bbae8[ 0 ] thread dialogue::say( #"hash_b28e50ef9b2ee459" );
        return;
    }
    
    var_fe9ebcd9161bbae8[ 1 ] thread dialogue::say( #"hash_5ee739a323e20512" );
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0x4
// Checksum 0xaedbec73, Offset: 0x328f
// Size: 0x77, Type: bool
function private function_27ae098dd3b2a437( player )
{
    if ( player.mask_ee.var_73e37bf886655ce7.ref != "zmloot_scarab_twins_ee_mask" )
    {
        return false;
    }
    
    if ( !level utility::time_has_passed( player.mask_ee.var_847fe40d015151bb, getdvarint( @"twins_ee_mask_cooldown", 120 ) ) )
    {
        return false;
    }
    
    if ( !utility::percent_chance( 20 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0x4
// Checksum 0xce700ba2, Offset: 0x330f
// Size: 0xc9, Type: bool
function private function_8029992d67c074e8( params )
{
    player = params.eattacker;
    
    if ( !isplayer( player ) || !params.biscritical || self.aicategory != "normal" )
    {
        return true;
    }
    
    if ( params.smeansofdeath == "MOD_GRENADE_SPLASH" || params.smeansofdeath == "MOD_EXPLOSIVE" || params.smeansofdeath == "MOD_MELEE" )
    {
        return true;
    }
    
    if ( !function_27ae098dd3b2a437( player ) )
    {
        return true;
    }
    
    self.var_fb70d1836134a225 = 1;
    
    if ( !function_d1c7e6fd3014be37( player ) )
    {
        return true;
    }
    
    self.var_5f0553e4f7ab47f7 = 1;
    return false;
}

// Namespace zm_sat_scarab_ee_masks
// Params 4, eflags: 0x4
// Checksum 0x3881cb19, Offset: 0x33e1
// Size: 0x3a
function private function_4fc9f4c779ae989( itembundle, item, autouse, var_981c264073bf1154 )
{
    thread function_c3bfb7557f083cbc();
    zombie_utils::function_dfae6a5bd222c586( &function_89c0f32f87519a07 );
}

// Namespace zm_sat_scarab_ee_masks
// Params 0, eflags: 0x4
// Checksum 0xdab44df4, Offset: 0x3423
// Size: 0x2f
function private function_c3bfb7557f083cbc()
{
    self endon( #"disconnected" );
    utility::waittill_any( "mask_removed", "death" );
    
    if ( self )
    {
        zombie_utils::function_10c0c35c21e3ed9d( &function_89c0f32f87519a07 );
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0x4
// Checksum 0xdb2c4a89, Offset: 0x345a
// Size: 0x7d
function private function_89c0f32f87519a07( params )
{
    damage = params.idamage ?? 0;
    
    if ( isplayer( params.eattacker ) )
    {
        if ( params.biscritical && ( self.subclass == "zombie_loom" || self.subclass == "zombie_loom_minion" ) )
        {
            damage = int( damage * 1.5 );
        }
    }
    
    return damage;
}

// Namespace zm_sat_scarab_ee_masks
// Params 0, eflags: 0x4
// Checksum 0x135b3ca0, Offset: 0x34e0
// Size: 0x202
function private function_58393cd8ef668279()
{
    if ( self.mask_ee.var_73e37bf886655ce7 )
    {
        self.mask_ee.var_b2a6177426a92fea = self.mask_ee.var_73e37bf886655ce7;
        
        if ( self.mask_ee.var_536177437db76a1f )
        {
            self.mask_ee.var_536177437db76a1f delete();
        }
        
        the_pedestal = 0;
        
        foreach ( pedestal in level.mask_pedestals )
        {
            if ( pedestal.script_noteworthy == self.mask_ee.var_73e37bf886655ce7.ref )
            {
                the_pedestal = pedestal;
                break;
            }
        }
        
        if ( the_pedestal )
        {
            the_pedestal function_9966a4b0003d61b5( self.mask_ee.var_73e37bf886655ce7, self.mask_ee.var_73e37bf886655ce7.ref );
        }
        else
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
            var_bbd7d44950a15fc = common_item::function_61c2c0251e742ffd( self.mask_ee.var_73e37bf886655ce7, undefined, spawnoptions );
            var_bbd7d44950a15fc.disable_dragged = 1;
        }
        
        level utility::flag_clear( var_bbd7d44950a15fc.type + "_worn" );
        utility::ent_flag_clear( var_bbd7d44950a15fc.type + "_worn" );
        self notify( #"mask_removed" );
        self.mask_ee.var_73e37bf886655ce7 = undefined;
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0x4
// Checksum 0x91a84d6f, Offset: 0x36ea
// Size: 0x13
function private on_player_death( params )
{
    function_58393cd8ef668279();
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0x4
// Checksum 0x4d0fb906, Offset: 0x3705
// Size: 0x13
function private on_player_disconnect( params )
{
    function_58393cd8ef668279();
}

// Namespace zm_sat_scarab_ee_masks
// Params 2
// Checksum 0xaff0d239, Offset: 0x3720
// Size: 0x175
function function_9966a4b0003d61b5( mask, ref = "none" )
{
    x_offset = 0;
    z_offset = 0;
    angles_offset = ( 0, 0, 0 );
    
    switch ( ref )
    {
        case #"hash_6d7a7c0d4b7602a7":
            z_offset = 32;
            x_offset = -2;
            angles_offset = ( 0, -90, 0 );
            break;
        case #"hash_51a2edfbee05bdb5":
            z_offset = 32;
            x_offset = -2;
            angles_offset = ( 0, 90, 0 );
            break;
        case #"hash_94213e23c1c2bc15":
            z_offset = 26;
            break;
        case #"hash_9865b9ac4258261a":
            z_offset = 36;
            break;
        case #"hash_db653a4972b3c13b":
            z_offset = 0;
            break;
        default:
            z_offset = 0;
            break;
    }
    
    spawn_origin = ( self.origin[ 0 ] + x_offset, self.origin[ 1 ], self.origin[ 2 ] + z_offset );
    spawnoptions = common_item::function_bc5ff2958b71a708( spawn_origin, self.angles + angles_offset );
    spawnoptions.var_fd47e835523b473f = 1;
    item = common_item::function_61c2c0251e742ffd( mask, undefined, spawnoptions );
    item.disable_dragged = 1;
    return item;
}

// Namespace zm_sat_scarab_ee_masks
// Params 1, eflags: 0x4
// Checksum 0x7086117c, Offset: 0x389e
// Size: 0x3a
function private on_ride_loom( params )
{
    if ( !self.var_7b7afedd2e59d610 )
    {
        self.var_7b7afedd2e59d610 = 1;
        player_banter::play_banter_vo( #"hash_c6050a812e98ed37", [ self ] );
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 0
// Checksum 0xb379aac0, Offset: 0x38e0
// Size: 0x127
function debug_spawn_masks()
{
    foreach ( pedestal in level.mask_pedestals )
    {
        if ( pedestal.script_noteworthy == "zmloot_scarab_hose_ee_mask" )
        {
            pedestal function_9966a4b0003d61b5( %"hash_23072e51581351dc", "zmloot_scarab_hose_ee_mask" );
            continue;
        }
        
        if ( pedestal.script_noteworthy == "zmloot_scarab_twins_ee_mask" )
        {
            pedestal function_9966a4b0003d61b5( %"hash_6ddbae43b1c907d8", "zmloot_scarab_twins_ee_mask" );
            continue;
        }
        
        if ( pedestal.script_noteworthy == "zmloot_scarab_grp_ee_mask" )
        {
            pedestal function_9966a4b0003d61b5( %"hash_47c51773059c4144", "zmloot_scarab_grp_ee_mask" );
            continue;
        }
        
        if ( pedestal.script_noteworthy == "zmloot_scarab_loom_ride_ee_mask" )
        {
            pedestal function_9966a4b0003d61b5( %"hash_505813c990ca9a5b", "zmloot_scarab_loom_ride_ee_mask" );
        }
    }
}

// Namespace zm_sat_scarab_ee_masks
// Params 1
// Checksum 0xac20f6a0, Offset: 0x3a0f
// Size: 0x11c
function function_208e6a667e0cc7eb( params )
{
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( ( level.players[ 0 ].origin[ 0 ], level.players[ 0 ].origin[ 1 ], level.players[ 0 ].origin[ 2 ] + 64 ), level.players[ 0 ].angles );
    spawnoptions.var_fd47e835523b473f = 1;
    item = common_item::function_61c2c0251e742ffd( %"hash_23072e51581351dc", undefined, spawnoptions );
    item.disable_dragged = 1;
    item = common_item::function_61c2c0251e742ffd( %"hash_6ddbae43b1c907d8", undefined, spawnoptions );
    item.disable_dragged = 1;
    item = common_item::function_61c2c0251e742ffd( %"hash_47c51773059c4144", undefined, spawnoptions );
    item.disable_dragged = 1;
    item = common_item::function_61c2c0251e742ffd( %"hash_505813c990ca9a5b", undefined, spawnoptions );
    item.disable_dragged = 1;
}

/#

    // Namespace zm_sat_scarab_ee_masks
    // Params 0
    // Checksum 0xa56acd33, Offset: 0x3b33
    // Size: 0x44, Type: dev
    function function_13875aa3cfb64545()
    {
        devgui::function_9082edeb5db93280( "<dev string:x45>" );
        devgui::add_devgui_func( "<dev string:x58>", "<dev string:x64>", &debug_spawn_masks );
        devgui::add_devgui_func( "<dev string:x76>", "<dev string:x95>", &function_208e6a667e0cc7eb );
        devgui::function_77df7fe7dd273e10();
    }

#/
