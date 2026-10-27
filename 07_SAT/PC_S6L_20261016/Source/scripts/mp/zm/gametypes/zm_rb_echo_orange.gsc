// scripts\mp\zm\gametypes\zm_rb_echo_orange.gsc  (hash_1b03201910ca208d.gscc) (size: 9491 Bytes / 0x2513 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x431704d6 (1125582038)
// size ...... 9491 (0x2513)
// includes .. 6   (offset: 0x2297)
// strings ... 39  (offset: 0x22c7)
// dev strs .. 4   (offset: 0x24e3)
// exports ... 34  (offset: 0x15b3)
// cseg ...... 0x2ce + 0x12e5 (0x15b3)
// imports ... 66  (offset: 0x1b03)
// animtree1 . 0   (offset: 0x2513)
// animtree2 . 0   (offset: 0x2513)
#using script_7a4449de12f6946e;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\zm\systems\zm_vo;

#namespace zm_rb_echo_orange;

// Namespace zm_rb_echo_orange
// Params 0, eflags: 0x5
// Checksum 0x28d332fa, Offset: 0x2ec
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_rb_echo_orange", undefined, &pre_main, undefined );
}

// Namespace zm_rb_echo_orange
// Params 0, eflags: 0x4
// Checksum 0x458ada25, Offset: 0x30d
// Size: 0x28
function private pre_main()
{
    if ( !function_71f346cd7ddd0613() || !getdvarint( @"hash_4d0a6f6852a2b04e", 0 ) )
    {
        return;
    }
    
    level thread init();
}

// Namespace zm_rb_echo_orange
// Params 0, eflags: 0x4
// Checksum 0x4fc70544, Offset: 0x33d
// Size: 0xe, Type: bool
function private function_71f346cd7ddd0613()
{
    return game_utility::getgametype() == "zm_rb_echo";
}

// Namespace zm_rb_echo_orange
// Params 0
// Checksum 0x798e5c77, Offset: 0x354
// Size: 0x34c
function init()
{
    level utility::flag_wait( "zm_rb_echo_pre_main_complete" );
    
    if ( isdefined( level.var_2a3c021066cd248c ) )
    {
        return;
    }
    
    level.var_2a3c021066cd248c = { #pumpkin_scale:1, #pumpkin_angle_offset:( 0, 90, 0 ), #pumpkin_offset:( 0, 0, 42 ), #pumpkin_sound:#"hash_b226085ccd008067", #pumpkin_vfx:loadfxasset( "vfx_t10_gameplay_zm_gobblegum_halloween_chunk" ), #pumpkin_model:%"hash_73a8391835f62dd5", #var_8577f333d67e8dda:level.var_23378cc637cedbd7, #var_32ed759017b27818:0, #var_932e2daf0891a572:[], #var_2ef641871fae55bc:[], #var_9be26354e6f958b0:[] };
    level.var_2a3c021066cd248c.var_932e2daf0891a572[ "rarity_upgrade" ] = 100;
    level.var_2a3c021066cd248c.var_932e2daf0891a572[ "pap1" ] = 100;
    level.var_2a3c021066cd248c.var_932e2daf0891a572[ "pap2" ] = 90;
    level.var_2a3c021066cd248c.var_932e2daf0891a572[ "pap3" ] = 80;
    level.var_2a3c021066cd248c.var_932e2daf0891a572[ "pap4" ] = 70;
    level.var_2a3c021066cd248c.var_932e2daf0891a572[ "ammo_mod" ] = 50;
    level.var_2a3c021066cd248c.var_932e2daf0891a572[ "wonder_weapon" ] = 30;
    level.var_2a3c021066cd248c.var_932e2daf0891a572[ "perk" ] = 200;
    level.var_2a3c021066cd248c.var_932e2daf0891a572[ "essence" ] = 0;
    level.var_2a3c021066cd248c.var_932e2daf0891a572[ "field_upgrade" ] = 50;
    level.var_2a3c021066cd248c.var_932e2daf0891a572[ "armor_upgrade" ] = 100;
    level.var_2a3c021066cd248c.var_932e2daf0891a572[ "golden_armor" ] = 50;
    level.var_2a3c021066cd248c.var_932e2daf0891a572[ "augment" ] = 200;
    level.var_23378cc637cedbd7 = &function_6aa0b361f8fd693f;
    level callback::add( "on_zombie_ai_spawned", &function_7eabdff32de6e3e7 );
    level utility::callsharedfunc( #"zm_rb_echo_event", #"register_provider", { #var_1ada6fc7442ee783:&function_153fad2a6fe76783, #var_a3bc3d09d69c9c6b:&function_a3bc3d09d69c9c6b, #get_display_name:&get_display_name, #var_f3a5e6cbc419005e:&function_f3a5e6cbc419005e, #get_sign_config:&get_sign_config, #get_debug_rewards:&get_debug_rewards, #var_9ed3cff4a938b546:&function_9ed3cff4a938b546, #var_f481b13005658611:&function_620aa88b9febcb41, #var_c79c923e01fbe78c:&function_c79c923e01fbe78c, #var_c6fba96d642a7b92:&is_pumpkin_index, #is_event_reward:&is_pumpkin_reward, #var_375848ddb8abe1df:&function_375848ddb8abe1df, #is_enabled:&is_enabled } );
    level utility::registersharedfunc( #"zm_rb_echo", #"intro_sequence", &intro_sequence );
}

// Namespace zm_rb_echo_orange
// Params 1, eflags: 0x4
// Checksum 0xe6846e70, Offset: 0x6a8
// Size: 0x4b
function private function_6aa0b361f8fd693f( var_66cc4d3d21a0ce0d )
{
    if ( var_66cc4d3d21a0ce0d == "all_hallows_eve" )
    {
        return 0;
    }
    
    if ( isdefined( level.var_2a3c021066cd248c.var_8577f333d67e8dda ) )
    {
        return self [[ level.var_2a3c021066cd248c.var_8577f333d67e8dda ]]( var_66cc4d3d21a0ce0d );
    }
    
    return 1;
}

// Namespace zm_rb_echo_orange
// Params 1, eflags: 0x4
// Checksum 0xf070d316, Offset: 0x6fc
// Size: 0x95
function private function_7eabdff32de6e3e7( params )
{
    if ( level utility::flag( "playing_game_over_scene" ) )
    {
        return;
    }
    
    if ( issubstr( self.subclass, "zombie_base" ) )
    {
        if ( isdefined( self.hatmodel ) )
        {
            self detach( self.hatmodel );
            self.hatmodel = undefined;
        }
        
        waitframe();
        self attach( "c_t10_zmb_zombie_jack_o_lantern_head", "j_head" );
        utility::function_7c10ea82c1e305b8( "bgb_all_hallows_eve", "jacko_eye_glow_on" );
        self.var_8ac1f467353c2a1f = 1;
        callback::add( "on_zombie_ai_damaged", &function_14aab2a0808fb454 );
    }
}

// Namespace zm_rb_echo_orange
// Params 1, eflags: 0x4
// Checksum 0x9b931d16, Offset: 0x799
// Size: 0x62
function private function_14aab2a0808fb454( params )
{
    if ( params.shitloc == "head" || params.shitloc == "neck" || params.shitloc == "helmet" )
    {
        callback::remove( "on_zombie_ai_damaged", &function_14aab2a0808fb454 );
        zm_bgb_all_hallows_eve::pop_chunks();
    }
}

// Namespace zm_rb_echo_orange
// Params 0
// Checksum 0x5da642b8, Offset: 0x803
// Size: 0xc, Type: bool
function is_enabled()
{
    return isdefined( level.var_2a3c021066cd248c );
}

// Namespace zm_rb_echo_orange
// Params 0
// Checksum 0x6495bea0, Offset: 0x818
// Size: 0x15
function function_a3bc3d09d69c9c6b()
{
    return level.var_2a3c021066cd248c.var_932e2daf0891a572;
}

// Namespace zm_rb_echo_orange
// Params 0
// Checksum 0x5ef55c3c, Offset: 0x836
// Size: 0x46
function intro_sequence()
{
    var_1b2bf0b02863a521 = [ #"hash_220a126c84170a91", #"hash_e6149101decdaa4" ];
    str_vo_alias = var_1b2bf0b02863a521[ randomint( var_1b2bf0b02863a521.size ) ];
    level namespace_c0b4f2882c9d100f::vo_say_announcer( str_vo_alias );
}

// Namespace zm_rb_echo_orange
// Params 1
// Checksum 0x8e536c4f, Offset: 0x884
// Size: 0x24, Type: bool
function is_pumpkin_reward( var_c56b6ee6272e1ddf )
{
    return isdefined( var_c56b6ee6272e1ddf ) && var_c56b6ee6272e1ddf.type == "pumpkin";
}

// Namespace zm_rb_echo_orange
// Params 2
// Checksum 0x8e72405, Offset: 0x8b1
// Size: 0x33
function function_9ed3cff4a938b546( e_scriptable, var_c56b6ee6272e1ddf )
{
    if ( !is_pumpkin_reward( var_c56b6ee6272e1ddf ) )
    {
        return;
    }
    
    e_scriptable setscriptablepartstate( "event_vfx", "orange" );
}

// Namespace zm_rb_echo_orange
// Params 1
// Checksum 0xc2c5e415, Offset: 0x8ec
// Size: 0x10e
function function_375848ddb8abe1df( var_e988b54247727114 )
{
    if ( !is_enabled() )
    {
        return;
    }
    
    level.var_2a3c021066cd248c.var_9be26354e6f958b0 = [];
    level.var_2a3c021066cd248c.var_2ef641871fae55bc = [];
    level.var_2a3c021066cd248c.var_32ed759017b27818 = randomint( 100 ) < 25;
    a_available_indices = [];
    
    for ( i = 0; i < var_e988b54247727114 ; i++ )
    {
        a_available_indices[ a_available_indices.size ] = i;
    }
    
    a_available_indices = arrayrandomize( a_available_indices );
    
    if ( level.var_2a3c021066cd248c.var_32ed759017b27818 )
    {
        level.var_2a3c021066cd248c.var_9be26354e6f958b0 = a_available_indices;
    }
    else
    {
        level.var_2a3c021066cd248c.var_9be26354e6f958b0[ level.var_2a3c021066cd248c.var_9be26354e6f958b0.size ] = a_available_indices[ 0 ];
    }
    
    /#
        iprintlnbold( "<dev string:x24>" + level.var_2a3c021066cd248c.var_9be26354e6f958b0 );
    #/
}

// Namespace zm_rb_echo_orange
// Params 0
// Checksum 0x7d0dedba, Offset: 0xa02
// Size: 0x1f, Type: bool
function function_c79c923e01fbe78c()
{
    return is_enabled() && level.var_2a3c021066cd248c.var_32ed759017b27818;
}

// Namespace zm_rb_echo_orange
// Params 1
// Checksum 0xb72d893f, Offset: 0xa2a
// Size: 0x2f, Type: bool
function is_pumpkin_index( n_index )
{
    return is_enabled() && arraycontains( level.var_2a3c021066cd248c.var_9be26354e6f958b0, n_index );
}

// Namespace zm_rb_echo_orange
// Params 1
// Checksum 0x2e237e27, Offset: 0xa62
// Size: 0x137
function function_620aa88b9febcb41( player )
{
    if ( level.var_2a3c021066cd248c.var_32ed759017b27818 )
    {
        var_b21381d2422a875e = player getentitynumber();
        s_rarity = level.var_2a3c021066cd248c.var_2ef641871fae55bc[ var_b21381d2422a875e ];
        
        if ( !isdefined( s_rarity ) )
        {
            s_rarity = select_rarity();
            level.var_2a3c021066cd248c.var_2ef641871fae55bc[ var_b21381d2422a875e ] = s_rarity;
        }
    }
    else
    {
        s_rarity = select_rarity();
    }
    
    n_reward_count = function_a685dfc301695dfe( s_rarity.id );
    var_1c19212c95ddf9a8 = function_893bdd10b38fdef6( player, n_reward_count );
    var_c56b6ee6272e1ddf = { #var_1c19212c95ddf9a8:var_1c19212c95ddf9a8, #rarity:s_rarity.glow, #pumpkin_rarity:s_rarity.id, #type:"pumpkin" };
    
    /#
        iprintlnbold( "<dev string:x4a>" + player.name + "<dev string:x5f>" + s_rarity.id + "<dev string:x62>" + var_1c19212c95ddf9a8.size );
    #/
    
    return var_c56b6ee6272e1ddf;
}

// Namespace zm_rb_echo_orange
// Params 0
// Checksum 0x7fb1f829, Offset: 0xba2
// Size: 0x73
function get_sign_config()
{
    return { #var_2023057124245de3:level.var_2a3c021066cd248c.pumpkin_scale, #var_e45619251daac78e:level.var_2a3c021066cd248c.pumpkin_angle_offset, #v_offset:level.var_2a3c021066cd248c.pumpkin_offset, #model:level.var_2a3c021066cd248c.pumpkin_model };
}

// Namespace zm_rb_echo_orange
// Params 1
// Checksum 0xf8bb7d5c, Offset: 0xc1e
// Size: 0x11
function get_display_name( var_c56b6ee6272e1ddf )
{
    return "Halloween Pumpkin";
}

// Namespace zm_rb_echo_orange
// Params 1
// Checksum 0x4e2ec871, Offset: 0xc38
// Size: 0x4b
function get_debug_rewards( player )
{
    if ( !is_enabled() )
    {
        return;
    }
    
    return [ function_b455eb94035dd58d( player, "rare" ), function_b455eb94035dd58d( player, "epic" ), function_b455eb94035dd58d( player, "legendary" ) ];
}

// Namespace zm_rb_echo_orange
// Params 1
// Checksum 0xd7d25c51, Offset: 0xc8c
// Size: 0xf1
function function_f3a5e6cbc419005e( var_c56b6ee6272e1ddf )
{
    switch ( var_c56b6ee6272e1ddf.pumpkin_rarity )
    {
        case #"hash_95068103fe897bc8":
            str_title = &"hash_7d39ce22fb81a68a";
            var_ed466fad37317edc = &"hash_2ff91d246b7594c3";
            break;
        case #"hash_d6c98e710a88aa4a":
            str_title = &"hash_55c236fb5678d188";
            var_ed466fad37317edc = &"hash_2836c5d50381afa7";
            break;
        case #"hash_209fa8900070d83d":
        default:
            str_title = &"hash_207d80760ad49feb";
            var_ed466fad37317edc = &"hash_22e722719e03e852";
            break;
    }
    
    return { #icon:"ui_icon_zm_hallowseve_loot", #description:var_ed466fad37317edc, #title:str_title, #string:&"hash_7dc114b459c8ebcf", #type:"HINT_BUTTON" };
}

// Namespace zm_rb_echo_orange
// Params 1
// Checksum 0xd75982ac, Offset: 0xd86
// Size: 0x26
function function_cd5e28eebfb3f96d( str_type )
{
    return utility::callsharedfunc( #"zm_rb_echo_event", #"build_reward", str_type );
}

// Namespace zm_rb_echo_orange
// Params 2
// Checksum 0x4ad125e4, Offset: 0xdb5
// Size: 0x38
function function_a53945115176fdd3( var_8b05c0691aa5983a, var_31c77814d3f874c3 = [] )
{
    return utility::callsharedfunc( #"zm_rb_echo_event", #"select_reward", var_8b05c0691aa5983a, var_31c77814d3f874c3 );
}

// Namespace zm_rb_echo_orange
// Params 1
// Checksum 0xf42ce610, Offset: 0xdf6
// Size: 0x26
function function_4877e7447d2575d1( var_c56b6ee6272e1ddf )
{
    return utility::callsharedfunc( #"zm_rb_echo_event", #"hash_ab3bff0597479fbb", var_c56b6ee6272e1ddf );
}

// Namespace zm_rb_echo_orange
// Params 1
// Checksum 0xc63389c7, Offset: 0xe25
// Size: 0x27
function function_324589b28789c7eb( var_c56b6ee6272e1ddf )
{
    utility::callsharedfunc( #"zm_rb_echo_event", #"grant_reward", var_c56b6ee6272e1ddf );
}

// Namespace zm_rb_echo_orange
// Params 2
// Checksum 0x76d1f80d, Offset: 0xe54
// Size: 0x22e
function function_153fad2a6fe76783( player, var_c56b6ee6272e1ddf )
{
    playfx( level.var_2a3c021066cd248c.pumpkin_vfx, player.origin + ( 0, 0, 48 ) );
    player playsound( level.var_2a3c021066cd248c.pumpkin_sound );
    var_5f9eefa525d7099a = [ #"hash_4603eb6c98d7e4f0", #"hash_76cdf0105935a89d", #"hash_220a0f6c84170578", #"hash_e614c101decdfbd" ];
    var_361490a13591851a = utility::array_random( var_5f9eefa525d7099a );
    player namespace_c0b4f2882c9d100f::vo_say_announcer( var_361490a13591851a, undefined, undefined, undefined, [ player ] );
    
    /#
        player iprintlnbold( &"hash_671156967d4ac568" );
    #/
    
    var_6726bc9119eb7c78 = [];
    var_7406aae653bfe64d = [];
    var_240f07b0f2198818 = [];
    var_df767e9be42d4ed = [];
    
    foreach ( s_original_reward in var_c56b6ee6272e1ddf.var_1c19212c95ddf9a8 )
    {
        function_71e43372ffc8623c( s_original_reward, var_240f07b0f2198818, var_df767e9be42d4ed );
    }
    
    for ( n_reward_index = 0; n_reward_index < var_c56b6ee6272e1ddf.var_1c19212c95ddf9a8.size ; n_reward_index++ )
    {
        s_echo_reward = var_c56b6ee6272e1ddf.var_1c19212c95ddf9a8[ n_reward_index ];
        
        if ( !player function_4877e7447d2575d1( s_echo_reward ) )
        {
            var_c4c6346a2cb769a2 = arraycombine( var_6726bc9119eb7c78, var_240f07b0f2198818 );
            var_89cfd531d9540b3b = arraycombine( var_7406aae653bfe64d, var_df767e9be42d4ed );
            s_echo_reward = player function_a53945115176fdd3( var_c4c6346a2cb769a2, var_89cfd531d9540b3b );
            
            if ( !isdefined( s_echo_reward ) )
            {
                s_echo_reward = player function_cd5e28eebfb3f96d( "essence" );
            }
        }
        
        if ( isdefined( s_echo_reward ) )
        {
            player function_324589b28789c7eb( s_echo_reward );
            function_71e43372ffc8623c( s_echo_reward, var_6726bc9119eb7c78, var_7406aae653bfe64d );
        }
        
        wait 0.5;
    }
}

// Namespace zm_rb_echo_orange
// Params 0, eflags: 0x4
// Checksum 0x3e159cf5, Offset: 0x108a
// Size: 0x9b
function private select_rarity()
{
    a_rarities = [ { #glow:"blue", #weight:45, #id:"rare" }, { #glow:"purple", #weight:35, #id:"epic" }, { #glow:"orange", #weight:20, #id:"legendary" } ];
    return weighted_random( a_rarities );
}

// Namespace zm_rb_echo_orange
// Params 1, eflags: 0x4
// Checksum 0x89e5348c, Offset: 0x112e
// Size: 0x4f
function private function_a685dfc301695dfe( var_aaf4abd69ed1ce9d )
{
    switch ( var_aaf4abd69ed1ce9d )
    {
        case #"hash_95068103fe897bc8":
            return 2;
        case #"hash_d6c98e710a88aa4a":
            return 3;
        case #"hash_209fa8900070d83d":
        default:
            return 1;
    }
}

// Namespace zm_rb_echo_orange
// Params 2, eflags: 0x4
// Checksum 0x2b74de1d, Offset: 0x1185
// Size: 0xa5
function private function_893bdd10b38fdef6( player, n_reward_count )
{
    var_1c19212c95ddf9a8 = [];
    var_8b05c0691aa5983a = [];
    var_31c77814d3f874c3 = [];
    
    for ( i = 0; i < n_reward_count ; i++ )
    {
        s_echo_reward = player function_a53945115176fdd3( var_8b05c0691aa5983a, var_31c77814d3f874c3 );
        
        if ( isdefined( s_echo_reward ) )
        {
            var_1c19212c95ddf9a8[ var_1c19212c95ddf9a8.size ] = s_echo_reward;
            function_71e43372ffc8623c( s_echo_reward, var_8b05c0691aa5983a, var_31c77814d3f874c3 );
            continue;
        }
        
        var_eda958c436f0ee80 = player function_cd5e28eebfb3f96d( "essence" );
        
        if ( isdefined( var_eda958c436f0ee80 ) )
        {
            var_1c19212c95ddf9a8[ var_1c19212c95ddf9a8.size ] = var_eda958c436f0ee80;
        }
    }
    
    return var_1c19212c95ddf9a8;
}

// Namespace zm_rb_echo_orange
// Params 1, eflags: 0x4
// Checksum 0xad416eba, Offset: 0x1233
// Size: 0x39, Type: bool
function private function_cd10abab2da7c9f3( var_c56b6ee6272e1ddf )
{
    return isdefined( var_c56b6ee6272e1ddf ) && ( var_c56b6ee6272e1ddf.type == "perk" || var_c56b6ee6272e1ddf.type == "augment" );
}

// Namespace zm_rb_echo_orange
// Params 3, eflags: 0x4
// Checksum 0x679419a7, Offset: 0x1275
// Size: 0x139
function private function_71e43372ffc8623c( var_c56b6ee6272e1ddf, var_8b05c0691aa5983a, var_31c77814d3f874c3 )
{
    if ( !isdefined( var_c56b6ee6272e1ddf ) )
    {
        return;
    }
    
    if ( function_cd10abab2da7c9f3( var_c56b6ee6272e1ddf ) )
    {
        var_31c77814d3f874c3[ var_31c77814d3f874c3.size ] = { #data:var_c56b6ee6272e1ddf.data, #type:var_c56b6ee6272e1ddf.type };
        return;
    }
    
    if ( !isdefined( var_c56b6ee6272e1ddf.config_index ) )
    {
        return;
    }
    
    if ( var_c56b6ee6272e1ddf.type == "armor_upgrade" || var_c56b6ee6272e1ddf.type == "golden_armor" )
    {
        for ( i = 0; i < level.var_f6902967d180948a.size ; i++ )
        {
            if ( level.var_f6902967d180948a[ i ].type != "armor_upgrade" && level.var_f6902967d180948a[ i ].type != "golden_armor" )
            {
                continue;
            }
            
            if ( !arraycontains( var_8b05c0691aa5983a, i ) )
            {
                var_8b05c0691aa5983a[ var_8b05c0691aa5983a.size ] = i;
            }
        }
        
        return;
    }
    
    if ( !arraycontains( var_8b05c0691aa5983a, var_c56b6ee6272e1ddf.config_index ) )
    {
        var_8b05c0691aa5983a[ var_8b05c0691aa5983a.size ] = var_c56b6ee6272e1ddf.config_index;
    }
}

// Namespace zm_rb_echo_orange
// Params 2, eflags: 0x4
// Checksum 0x4197bddf, Offset: 0x13b6
// Size: 0x72
function private function_b455eb94035dd58d( player, var_aaf4abd69ed1ce9d )
{
    n_reward_count = function_a685dfc301695dfe( var_aaf4abd69ed1ce9d );
    var_1c19212c95ddf9a8 = function_893bdd10b38fdef6( player, n_reward_count );
    return { #var_1c19212c95ddf9a8:var_1c19212c95ddf9a8, #rarity:function_6d9734e8659af51c( var_aaf4abd69ed1ce9d ), #pumpkin_rarity:var_aaf4abd69ed1ce9d, #type:"pumpkin" };
}

// Namespace zm_rb_echo_orange
// Params 1, eflags: 0x4
// Checksum 0x33c54902, Offset: 0x1431
// Size: 0x58
function private function_6d9734e8659af51c( var_aaf4abd69ed1ce9d )
{
    switch ( var_aaf4abd69ed1ce9d )
    {
        case #"hash_95068103fe897bc8":
            return "purple";
        case #"hash_d6c98e710a88aa4a":
            return "orange";
        case #"hash_209fa8900070d83d":
        default:
            return "blue";
    }
}

// Namespace zm_rb_echo_orange
// Params 1, eflags: 0x4
// Checksum 0x94fa94de, Offset: 0x1491
// Size: 0x121
function private weighted_random( a_entries )
{
    n_total_weight = 0;
    
    foreach ( var_49a8cba96c1f4bac in a_entries )
    {
        n_total_weight += var_49a8cba96c1f4bac.weight;
    }
    
    n_roll = randomint( n_total_weight );
    
    foreach ( var_49a8cba96c1f4bac in a_entries )
    {
        n_roll -= var_49a8cba96c1f4bac.weight;
        
        if ( n_roll < 0 )
        {
            return var_49a8cba96c1f4bac;
        }
    }
    
    return a_entries[ a_entries.size - 1 ];
}

