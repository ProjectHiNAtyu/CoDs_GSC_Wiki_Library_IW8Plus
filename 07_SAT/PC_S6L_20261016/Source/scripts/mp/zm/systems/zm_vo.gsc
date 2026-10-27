// scripts\mp\zm\systems\zm_vo.gsc  (hash_640075fcb077c6bc.gscc) (size: 31153 Bytes / 0x79b1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x25f5cc59 (636865625)
// size ...... 31153 (0x79b1)
// includes .. 24  (offset: 0x7391)
// strings ... 48  (offset: 0x7451)
// dev strs .. 61  (offset: 0x76c1)
// exports ... 74  (offset: 0x4db9)
// cseg ...... 0x4d1 + 0x48e8 (0x4db9)
// imports ... 183 (offset: 0x5949)
// animtree1 . 0   (offset: 0x79b1)
// animtree2 . 0   (offset: 0x79b1)
#using script_16ea1b94f0f381b3;
#using scripts\anim\battlechatter;
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\dialogue_speaker;
#using scripts\common\math;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\magicbox;
#using scripts\mp\mp_dialogue;
#using scripts\mp\overlord;
#using scripts\mp\player_banter;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\zm_utility;

#namespace zm_vo;

// Namespace zm_vo
// Params 0, eflags: 0x5
// Checksum 0xa4b793e0, Offset: 0x4ef
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_vo", undefined, &preinit, &function_8e6f42288af40642 );
}

// Namespace zm_vo
// Params 0
// Checksum 0xb65da41, Offset: 0x514
// Size: 0x2c0
function preinit()
{
    level.s_zm_vo = spawnstruct();
    function_55319be40b828f47( #"game_over", level.s_zm_vo.a_str_vo_announcer[ #"game_over" ] ?? level.gametypebundle.var_fdec998a9d32583a ?? #"hash_fd694a011d51b5dc" );
    level.var_e0b31e63f5a29e85 = &zm_overlord_ui_show;
    level.var_8b4ae0e9bea5384c = &function_c29df0727767e729;
    level.var_1c8477e400cdc8c4 = &zm_overlord_ui_show;
    level.var_649ee89b28667c15 = &function_c29df0727767e729;
    level.var_bbe2ae9963c25f75 = [];
    level.var_27d1beb8576f49c4 = 1;
    level.var_34e2903bffd9b28b = 1;
    level.var_ca1a245e2065ebbd = 1;
    level.register_battlechatter_custom_func = &function_ea6b1a6950749adb;
    battlechatter::init_battlechatter();
    mp_dialogue::main();
    level callback::add( #"player_connect", &on_player_connect );
    level callback::add( #"player_damaged", &on_player_damaged );
    level callback::add( #"player_spawned", &on_player_spawned );
    level callback::add( #"player_laststand", &on_player_laststand_enter );
    level callback::add( #"player_laststand_revived", &function_b0f8cce4da821455 );
    level callback::add( #"player_laststand_revive_start", &on_player_revive_start );
    level callback::add( #"on_ai_killed", &function_9238338f068b6568 );
    level callback::add( "on_agent_ai_damaged", &on_agent_ai_damaged );
    level callback::add( "zm_exfil_started", &on_exfil_start );
    level callback::add( "on_pap_machine_purchase", &on_pap_machine_purchased );
    level callback::add( "magicbox_used", &on_magicbox_used );
    level callback::add( "magicbox_purchase", &function_9cece87b28333c16 );
    level callback::add( "on_round_end", &on_round_end );
    level callback::add( "on_gobblegum_used", &on_gobblegum_used );
    level callback::add( #"hash_d558db2dac47d5f7", &function_e498c41fd90a8d6 );
    level callback::add( "on_zipline_attach", &on_zipline_attach );
    level callback::add( "zm_perk_obtained", &on_zm_perk_obtained );
    level callback::add( #"hash_7432621eb6a7f04", &function_aea7873862de6fad );
    level callback::add( #"player_death", &on_player_death );
    level callback::add( "on_turned", &on_turned );
    level callback::add( #"hash_285de7f1c47ba90d", &function_66eebfc0261222f6 );
    scene::function_85b13b837056bc8b( &function_a9ae270d95b3b322 );
    scene::function_53de0775d8452750( &function_2f16d001245d787 );
    
    if ( !isdefined( level.var_15b710391cd54936 ) )
    {
        level.var_15b710391cd54936 = &vo_say_powerups;
    }
    
    /#
        level thread zm_vo_devgui();
    #/
}

/#

    // Namespace zm_vo
    // Params 0
    // Checksum 0xce8f9d92, Offset: 0x7dc
    // Size: 0x30, Type: dev
    function zm_vo_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x2b>", "<dev string:x44>", &function_c412a45ddbb8a7d7, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_vo
    // Params 0, eflags: 0x4
    // Checksum 0xb061de79, Offset: 0x814
    // Size: 0x405, Type: dev
    function private function_c412a45ddbb8a7d7()
    {
        while ( true )
        {
            var_40fbc79658a286a8 = undefined;
            var_5291f8a8abc4dda7 = undefined;
            str_player_banter = undefined;
            var_28d182dbfd6e3007 = undefined;
            var_5fc3ad6fbe6ed844 = undefined;
            var_441b6045cd41bd4f = undefined;
            
            foreach ( player in level.players )
            {
                if ( player overlord::function_2a4336a2a72f769c() )
                {
                    var_40fbc79658a286a8 = getxhashsourcename( player.var_5d3b2a20a597a075.eventref );
                    var_28d182dbfd6e3007 = getxhashsourcename( player.var_3f334ef2f451c86[ player.var_3f334ef2f451c86.size - 1 ] );
                    break;
                }
            }
            
            foreach ( player in level.players )
            {
                if ( player overlord::function_5b9a94f0c7f2bb5b() )
                {
                    var_5291f8a8abc4dda7 = getxhashsourcename( player.var_54025b165a4e02d8.conversationname );
                    var_5fc3ad6fbe6ed844 = getxhashsourcename( player.var_3f334ef2f451c86[ player.var_3f334ef2f451c86.size - 1 ] );
                    break;
                }
            }
            
            if ( isdefined( level.s_player_banter.var_d3b97339fa760067 ) )
            {
                str_player_banter = getxhashsourcename( level.s_player_banter.var_d3b97339fa760067 );
            }
            
            foreach ( player in level.players )
            {
                if ( isdefined( player.var_cb00b5dec3739246 ) )
                {
                    var_441b6045cd41bd4f = getxhashsourcename( player.var_cb00b5dec3739246 );
                    break;
                }
            }
            
            printtoscreen2d( 500, 375, "<dev string:x74>" + ( var_40fbc79658a286a8 ?? "<dev string:x90>" ), isdefined( var_40fbc79658a286a8 ) ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1.5 );
            printtoscreen2d( 500, 400, "<dev string:x95>" + ( var_28d182dbfd6e3007 ?? "<dev string:x90>" ), isdefined( var_28d182dbfd6e3007 ) ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1.5 );
            printtoscreen2d( 500, 425, "<dev string:xb4>" + ( var_5291f8a8abc4dda7 ?? "<dev string:x90>" ), isdefined( var_5291f8a8abc4dda7 ) ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1.5 );
            printtoscreen2d( 500, 450, "<dev string:xd7>" + ( var_5fc3ad6fbe6ed844 ?? "<dev string:x90>" ), isdefined( var_5fc3ad6fbe6ed844 ) ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1.5 );
            printtoscreen2d( 500, 475, "<dev string:xfd>" + ( str_player_banter ?? "<dev string:x90>" ), isdefined( str_player_banter ) ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1.5 );
            printtoscreen2d( 500, 500, "<dev string:x118>" + ( var_441b6045cd41bd4f ?? "<dev string:x90>" ), isdefined( var_441b6045cd41bd4f ) ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1.5 );
            waitframe();
        }
    }

#/

// Namespace zm_vo
// Params 0
// Checksum 0x68af6bbf, Offset: 0xc21
// Size: 0xa6
function function_a9ae270d95b3b322()
{
    if ( utility::flag( "exfil_start" ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player val::set( "zm_vo", "allow_battlechatter_vo", 0 );
    }
    
    overlord::function_2fb527a541b257( 0 );
    player_banter::function_575495aebfd95d01( 1 );
}

// Namespace zm_vo
// Params 0
// Checksum 0xe064934f, Offset: 0xccf
// Size: 0x96
function function_2f16d001245d787()
{
    foreach ( player in level.players )
    {
        player val::reset( "zm_vo", "allow_battlechatter_vo" );
    }
    
    player_banter::function_575495aebfd95d01( 0 );
    overlord::function_2fb527a541b257( 1 );
}

// Namespace zm_vo
// Params 4
// Checksum 0xe7313cea, Offset: 0xd6d
// Size: 0x119
function function_8c1a12974bd11f01( var_8984c1f1eeea88ec, var_1c360473c4174a43, fallback_delay, var_90ab92fc48d46107 = 0 )
{
    if ( !isalive( self ) )
    {
        return 0;
    }
    
    if ( !var_90ab92fc48d46107 )
    {
        foreach ( flag in level.var_bbe2ae9963c25f75 )
        {
            if ( level utility::flag( flag ) )
            {
                return 0;
            }
        }
    }
    
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( player_banter::function_4e1aff6241ebea8() )
    {
        player_banter::function_850de641659a4090();
    }
    
    var_db75d3de862ce072 = player_banter::play_banter_vo( var_8984c1f1eeea88ec, [ self ] );
    
    if ( !var_db75d3de862ce072 && var_1c360473c4174a43 )
    {
        var_db75d3de862ce072 = level battlechatter_mp::trysaylocalsound( self, var_1c360473c4174a43, fallback_delay );
    }
    
    return var_db75d3de862ce072;
}

// Namespace zm_vo
// Params 0
// Checksum 0x8655f22d, Offset: 0xe8f
// Size: 0x25d
function function_ea6b1a6950749adb()
{
    level.var_97d7c13d242bcb15 = &function_e79f0d8041b37c08;
    var_bdcb166b4dec597f = getscriptbundlenames( "battlechatterlist" );
    
    if ( isdefined( level.gamemodebundle.battlechatterlist ) )
    {
        if ( isxhashasset( level.gamemodebundle.battlechatterlist ) )
        {
            var_5ecbf573f88f8958 = level.gamemodebundle.battlechatterlist;
        }
        else
        {
            var_5ecbf573f88f8958 = hashcat( %"hash_1ea8b4cc1ebd1ff5", level.gamemodebundle.battlechatterlist );
        }
    }
    
    foreach ( var_44da61be28eab612 in var_bdcb166b4dec597f )
    {
        if ( var_44da61be28eab612 === var_5ecbf573f88f8958 )
        {
            continue;
        }
        
        s_bundle = getscriptbundle( var_44da61be28eab612 );
        
        if ( isdefined( s_bundle ) )
        {
            foreach ( event in s_bundle.battlechatterevents )
            {
                if ( !isdefined( level.bcinfo[ event.eventname ] ) )
                {
                    battlechatter_mp::function_28c0b45728c50f98( event );
                }
            }
            
            if ( isarray( s_bundle.pingevents ) )
            {
                foreach ( event in s_bundle.pingevents )
                {
                    if ( !isdefined( level.bcinfo[ event.eventname ] ) )
                    {
                        battlechatter_mp::function_28c0b45728c50f98( event );
                    }
                }
            }
        }
    }
    
    level.var_c549dc94926fcc57 = &function_76d0d7d1ca7114b3;
}

// Namespace zm_vo
// Params 1
// Checksum 0x8034fe89, Offset: 0x10f4
// Size: 0xb5, Type: bool
function function_76d0d7d1ca7114b3( soundtype )
{
    if ( soundtype == #"bc_status_inform_on_your_six" )
    {
        return false;
    }
    
    var_c1ee09583a26ff0b = 0;
    
    foreach ( var_7754d41bef2a60a7 in self.bcinfolastsaytimes )
    {
        if ( var_7754d41bef2a60a7 > var_c1ee09583a26ff0b )
        {
            var_c1ee09583a26ff0b = var_7754d41bef2a60a7;
        }
    }
    
    if ( gettime() - var_c1ee09583a26ff0b < 4000 )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_vo
// Params 2
// Checksum 0x36637db2, Offset: 0x11b2
// Size: 0xb98
function function_e79f0d8041b37c08( var_25d80124122c8304, pingindex )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self endon( #"disconnect" );
    
    if ( isdefined( var_25d80124122c8304 ) )
    {
        var_8f61757e9d1e9a0e = var_25d80124122c8304.type ?? var_25d80124122c8304.model;
    }
    
    var_6675b0888e2dbc2 = self function_689a4266a29aac13( pingindex );
    
    if ( function_4c1b7cae739d9840( var_6675b0888e2dbc2 ) && !isent( var_25d80124122c8304 ) )
    {
        var_c8692c885ac9b10d = var_25d80124122c8304 function_f911103fc8a0b6e7();
        
        if ( isagent( var_c8692c885ac9b10d ) )
        {
            agent_entity = var_c8692c885ac9b10d;
        }
    }
    else if ( function_4095a4f8e53eb368( var_6675b0888e2dbc2 ) )
    {
        if ( isagent( var_25d80124122c8304 ) )
        {
            agent_entity = var_25d80124122c8304;
        }
        else if ( isdefined( var_25d80124122c8304 ) && var_25d80124122c8304 vehicle::is_vehicle() )
        {
            vehicle_entity = var_25d80124122c8304;
        }
    }
    
    if ( vehicle_entity )
    {
        return battlechatter_mp::function_694f04feb7ef7c08( #"ping_vehicle_generic_neutral" );
    }
    
    if ( agent_entity )
    {
        /#
            iprintln( "<dev string:x136>" );
        #/
        
        if ( agent_entity.team != self.team )
        {
            if ( agent_entity.subclass == "zombie_hellhound" )
            {
                return battlechatter_mp::function_694f04feb7ef7c08( #"ping_hellhound" );
            }
            else if ( isdefined( agent_entity.aicategory ) )
            {
                a_nearby_zombies = getaiarrayinradius( agent_entity.origin, 700, agent_entity.team );
                
                if ( a_nearby_zombies.size >= 10 )
                {
                    return battlechatter_mp::function_694f04feb7ef7c08( #"hash_f10a2d22ec9323d6" );
                }
                else
                {
                    switch ( agent_entity.aicategory )
                    {
                        case #"hash_84fcf5e68d7230b2":
                            return battlechatter_mp::function_694f04feb7ef7c08( #"hash_92665c161fc68e36" );
                        case #"hash_8c089e813083e510":
                            return battlechatter_mp::function_694f04feb7ef7c08( #"ping_special_elite" );
                        case #"hash_7b0e2f2ed84f34":
                        case #"hash_4e47eb6c32f5b165":
                            return battlechatter_mp::function_694f04feb7ef7c08( #"ping_special_elite" );
                        case #"hash_7e8a002ed096276c":
                            return battlechatter_mp::function_694f04feb7ef7c08( #"ping_boss_zombie" );
                    }
                }
            }
        }
        
        return;
    }
    
    if ( function_4c1b7cae739d9840( var_6675b0888e2dbc2 ) )
    {
        /#
            iprintln( "<dev string:x15a>" );
        #/
        
        itembundlename = common_item::function_33a2c00e46263d99( var_25d80124122c8304 );
        
        if ( isdefined( itembundlename ) )
        {
            itembundle = getscriptbundle( itembundlename );
            
            if ( isdefined( itembundle.pingvo ) )
            {
                return itembundle.pingvo;
            }
        }
        
        if ( isdefined( var_8f61757e9d1e9a0e ) && ( isdefined( var_25d80124122c8304.s_perk_machine ) || isdefined( var_25d80124122c8304.entity.s_perk_machine ) ) )
        {
            str_perk_machine = getxhash( var_8f61757e9d1e9a0e );
            
            switch ( str_perk_machine )
            {
                case #"t10_zm_machine_wunderfizz":
                case #"sat_zm_machine_wunderfizz":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"hash_d840ca3d4a673f21" );
                case #"hash_f6a328ce143de2ef":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"hash_b2442bd713b5c87a" );
                case #"hash_e66b357f2682f1c9":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"ping_perk_machine_death_perception" );
                case #"hash_c260b14b7552b87a":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"ping_perk_machine_elemental_pop" );
                case #"t10_zm_machine_juggernog":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"hash_27a818dfa76ad413" );
                case #"hash_b6dba2aa347575db":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"hash_b542b4c02ee40de8" );
                case #"hash_f9727ded1c8fcf70":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"hash_5bdc975dfd89f980" );
                case #"hash_c914d5f9030824fc":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"hash_5b1ae39f5de3b48c" );
                case #"hash_52b6476596e9a30":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"hash_56ef57884b5ec460" );
                case #"hash_322380755e0309be":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"hash_709621bd391d820e" );
                case #"hash_cf88e3e2fdded047":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"ping_perk_machine_vulture_aid" );
                case #"hash_4034d9dd5bc0ddaa":
                case #"hash_78e52c9c58f828c0":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"hash_a36afac8c79ea1fa" );
                case #"sat_zm_machine_w_mod":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"hash_c2fe9a832c43c42b" );
                case #"sat_zm_machine_z_mod":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"hash_c8eec66ea8257c2e" );
            }
            
            return battlechatter_mp::function_694f04feb7ef7c08( #"hash_c8eec66ea8257c2e" );
        }
        else if ( isdefined( var_8f61757e9d1e9a0e ) && ( issubstr( var_8f61757e9d1e9a0e, "wallbuy" ) || issubstr( var_8f61757e9d1e9a0e, "chalk" ) ) )
        {
            if ( issubstr( var_8f61757e9d1e9a0e, "armor" ) )
            {
                return battlechatter_mp::function_694f04feb7ef7c08( #"ping_loot_armor" );
            }
            
            return battlechatter_mp::function_694f04feb7ef7c08( #"hash_f1a6082d11c9008b" );
        }
        else if ( isdefined( var_8f61757e9d1e9a0e ) && issubstr( var_8f61757e9d1e9a0e, "mystery_box" ) )
        {
            return battlechatter_mp::function_694f04feb7ef7c08( #"ping_mystery_box" );
        }
        else if ( var_25d80124122c8304.entity == level.s_rampage.mdl )
        {
            return battlechatter_mp::function_694f04feb7ef7c08( #"ping_zm_rampage_inducer" );
        }
        else if ( isdefined( var_8f61757e9d1e9a0e ) )
        {
            var_55a29f99a0cef238 = getxhash( var_8f61757e9d1e9a0e );
            
            switch ( var_55a29f99a0cef238 )
            {
                case #"zm_sat_exfil_phone_booth":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"ping_phone" );
                case #"sat_zm_quest_scarab_pap":
                case #"hash_4aabcef697f423a":
                case #"veh_sat_firefly_pluto_pap_part_invisible":
                case #"sat_zm_pap_clean_fxanim":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"ping_pap" );
                case #"hash_58144b4da42af32":
                case #"sat_zm_saw_blade_trap_switch":
                case #"hash_7c816b2bffee837c":
                case #"sat_zm_saw_blade_trap":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"hash_6a266630b539ce53" );
                case #"hash_ff885a55fdd3598":
                case #"sat_zm_ammo_cache":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"ping_ammo_cache" );
                case #"sat_zm_obelisk_tesla_tower_silver_scriptable":
                case #"sat_zm_obelisk_tesla_tower_set_scriptable":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"ping_zm_trial_machine" );
                case #"t10_zm_gobblegum_machine":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"ping_zm_gobblegum_machine" );
                case #"sat_zm_fasttravel_jumppad":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"ping_zm_jump_pad" );
                case #"sat_ascender_zipline_icon_zm":
                    if ( ( utility::cointoss() || getdvarint( @"hash_d205ed9ddf11b78a", 0 ) ) && is_hero_operator() && battlechatter_mp::function_fb3633bb3479f698( #"hash_3c449568413f4815" ) )
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"hash_3c449568413f4815" );
                    }
                    else
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"ping_zipline" );
                    }
                case #"hash_fce30c61cc8c5b1f":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"ping_zm_arsenal" );
                case #"hash_e32ecb08c45488f":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"ping_zm_crafting_table" );
                case #"hash_3a9979de489314ac":
                    if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_9d25ca83e43e614c" ) )
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"hash_9d25ca83e43e614c" );
                    }
                case #"teleport_portal_zm_t10":
                    if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_459d86c13783a22c" ) )
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"hash_459d86c13783a22c" );
                    }
                case #"teleport_portal_zm_t10_red":
                    if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_df519295515da7c" ) )
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"hash_df519295515da7c" );
                    }
                case #"t10_zm_fasttravel_slide_switch":
                    if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_edad429dc67c4876" ) )
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"hash_edad429dc67c4876" );
                    }
                case #"teleport_portal_zm_t10_nofx":
                    if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_f4f2a6e8970bb934" ) )
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"hash_f4f2a6e8970bb934" );
                    }
                case #"teleport_portal_zm_t10_red_topaz":
                    if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_e6b6728925efc30c" ) )
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"hash_e6b6728925efc30c" );
                    }
                case #"hash_65c6f0f0870015e8":
                    if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_9aaa7f2c930abb65" ) )
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"hash_9aaa7f2c930abb65" );
                    }
                case #"aether_elevator_portal":
                    if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_e6b08d05316165b5" ) )
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"hash_e6b08d05316165b5" );
                    }
                case #"fasttravel_zm_t10":
                    if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_b5d6ae01376c095d" ) )
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"hash_b5d6ae01376c095d" );
                    }
                case #"teleport_portal_zm_ruby":
                    if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_26b2364f2476f421" ) )
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"hash_26b2364f2476f421" );
                    }
                case #"sat_zm_interact_locust":
                    if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_5b454106101b250d" ) && ( var_25d80124122c8304.area_type == "enter" || var_25d80124122c8304.area_type == "exit" ) )
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"hash_5b454106101b250d" );
                    }
                    else if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_bf109276ea0f75c3" ) && var_25d80124122c8304.is_robot_tube )
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"hash_bf109276ea0f75c3" );
                    }
                case #"zm_sat_hornet_koinobori":
                    if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_55b09063ff08a79c" ) )
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"hash_55b09063ff08a79c" );
                    }
                case #"ncfd_pedestal_vfx":
                    if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_4e40ddd38e60be9a" ) )
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"hash_4e40ddd38e60be9a" );
                    }
                case #"hash_a29a5904532569af":
                    if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_4d799a5623ce53ea" ) )
                    {
                        return battlechatter_mp::function_694f04feb7ef7c08( #"hash_4d799a5623ce53ea" );
                    }
                case #"zm_sat_firefly_pap_wood_barrier_02_left":
                case #"zm_sat_doorbuy_ping":
                case #"zm_sat_firefly_pap_wood_barrier_01_right":
                case #"cp_mp_doorbuy_minimap_double_door_pingable":
                case #"hash_878a049f29c4cb89":
                case #"hash_ce97194b3427ffa2":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"ping_zm_doorbuy" );
                case #"sat_zm_timetravel_timewarp":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"hash_687f63c9df3a2c9" );
                case #"sat_zm_zombie_virgil_metabone_ping":
                    return battlechatter_mp::function_694f04feb7ef7c08( #"ping_boss_zombie" );
                case #"zm_sat_firefly_garage_player_teleport_station":
                default:
                    return battlechatter_mp::function_694f04feb7ef7c08( #"ping_location_go" );
            }
        }
        
        return;
    }
    
    if ( var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 4 ) )
    {
        return #"hash_fe627f96d984fd11";
    }
    
    if ( var_6675b0888e2dbc2 == function_1bf3a084cfe14025( 6 ) )
    {
        gscobjectiveid = self calloutmarkerping_getgscobjectiveindex( pingindex );
        
        if ( isarray( level.s_zm_exfil.var_c7cfc464905e7bcd ) )
        {
            foreach ( s_exfil in level.s_zm_exfil.var_c7cfc464905e7bcd )
            {
                if ( s_exfil.var_c6883f07ae9a466 == gscobjectiveid )
                {
                    return battlechatter_mp::function_694f04feb7ef7c08( #"ping_phone" );
                }
            }
        }
    }
}

// Namespace zm_vo
// Params 1, eflags: 0x4
// Checksum 0xce7f4939, Offset: 0x1d53
// Size: 0x29
function private zm_overlord_ui_show( var_85f9b34a2668217c )
{
    if ( isplayer( self ) )
    {
        dialogue_speaker::add_for_player( var_85f9b34a2668217c );
        return;
    }
    
    dialogue_speaker::add( var_85f9b34a2668217c );
}

// Namespace zm_vo
// Params 1, eflags: 0x4
// Checksum 0xcbe58f83, Offset: 0x1d84
// Size: 0x29
function private function_c29df0727767e729( var_8f504e21a91cd373 )
{
    if ( isplayer( self ) )
    {
        dialogue_speaker::remove_for_player( var_8f504e21a91cd373 );
        return;
    }
    
    dialogue_speaker::remove( var_8f504e21a91cd373 );
}

// Namespace zm_vo
// Params 0
// Checksum 0x5ef7cfcc, Offset: 0x1db5
// Size: 0x2
function function_8e6f42288af40642()
{
    
}

// Namespace zm_vo
// Params 2
// Checksum 0xd8b8a4d7, Offset: 0x1dbf
// Size: 0x176
function vo_say_powerups( a_players, str_vo_alias )
{
    if ( utility::flag( "skip_powerup_vo" ) || utility::flag( "special_round_vo_active" ) )
    {
        return;
    }
    
    overlord::function_724ca7b94bf1fb66( 1 );
    str_vo_alias = function_157326aa0e824343( self.str_powerup ) ?? str_vo_alias;
    
    if ( !isdefined( level.var_3c999517dff5f961 ) )
    {
        level.var_3c999517dff5f961 = 0;
    }
    
    while ( level.var_3c999517dff5f961 > 0 )
    {
        waitframe();
    }
    
    level.var_3c999517dff5f961++;
    
    foreach ( player in a_players )
    {
        if ( !isdefined( player ) || player utility::ent_flag( "scene_active" ) || player isplayingxcam() )
        {
            continue;
        }
        
        player val::set( "powerup_announcer_vo", "allow_battlechatter_vo", 0 );
        player utility::delaythreadendon( 1.25, "disconnect", &val::reset, "powerup_announcer_vo", "allow_battlechatter_vo" );
        player namespace_9d8e359c3b1041e5::playsoundtoplayersharedfunc( str_vo_alias, player );
    }
    
    wait 1;
    level.var_3c999517dff5f961--;
    
    if ( level.var_3c999517dff5f961 <= 0 )
    {
        overlord::function_724ca7b94bf1fb66( 0 );
    }
}

// Namespace zm_vo
// Params 5
// Checksum 0x53c25307, Offset: 0x1f3d
// Size: 0xe9
function vo_say_announcer( str_vo_alias, delay, priority, timeout, a_players )
{
    if ( !isdefined( str_vo_alias ) )
    {
        return;
    }
    
    overlord::function_29d8b7aaf2aa133a();
    overlord::function_724ca7b94bf1fb66( 1 );
    
    if ( isdefined( a_players ) )
    {
        foreach ( player in a_players )
        {
            player namespace_9d8e359c3b1041e5::playsoundtoplayersharedfunc( str_vo_alias, player );
        }
        
        wait lookupsoundlength( str_vo_alias, 1 ) / 1000;
    }
    else
    {
        level dialogue::say( str_vo_alias, priority, timeout, undefined, delay );
    }
    
    overlord::function_724ca7b94bf1fb66( 0 );
}

// Namespace zm_vo
// Params 2
// Checksum 0xefef2bdc, Offset: 0x202e
// Size: 0x7c
function function_55319be40b828f47( var_8fd3eb7841f45192, var_84c9dd7e50ec65ec )
{
    if ( isstring( var_8fd3eb7841f45192 ) )
    {
        var_8fd3eb7841f45192 = getxhash( var_8fd3eb7841f45192 );
    }
    
    level.s_zm_vo.a_str_vo_announcer[ var_8fd3eb7841f45192 ] = var_84c9dd7e50ec65ec;
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x182>" );
        var_a3fd068127cc93c9 = getxhashsourcename( var_8fd3eb7841f45192 );
        devgui::function_cd4e263c1f3018ae( var_a3fd068127cc93c9, "<dev string:x1a5>" + var_a3fd068127cc93c9, &function_9350c498c333bea7 );
        devgui::function_77df7fe7dd273e10();
    #/
}

/#

    // Namespace zm_vo
    // Params 1
    // Checksum 0xe04f5c0b, Offset: 0x20b2
    // Size: 0x34, Type: dev
    function function_9350c498c333bea7( params )
    {
        var_8fd3eb7841f45192 = params[ 0 ];
        
        if ( isdefined( var_8fd3eb7841f45192 ) )
        {
            level thread vo_say_announcer( function_157326aa0e824343( var_8fd3eb7841f45192 ) );
        }
    }

#/

// Namespace zm_vo
// Params 1
// Checksum 0x7d45ed1, Offset: 0x20ee
// Size: 0x6d
function function_157326aa0e824343( var_8fd3eb7841f45192 )
{
    if ( isstring( var_8fd3eb7841f45192 ) )
    {
        var_8fd3eb7841f45192 = getxhash( var_8fd3eb7841f45192 );
    }
    
    if ( isarray( level.s_zm_vo.a_str_vo_announcer[ var_8fd3eb7841f45192 ] ) )
    {
        return utility::array_random( level.s_zm_vo.a_str_vo_announcer[ var_8fd3eb7841f45192 ] );
    }
    
    return level.s_zm_vo.a_str_vo_announcer[ var_8fd3eb7841f45192 ];
}

// Namespace zm_vo
// Params 0
// Checksum 0x3ee190a7, Offset: 0x2164
// Size: 0x22
function function_8464c50734af5965()
{
    level callback::add( #"zm_mq_quest_complete", &function_c0b0828d1107c141 );
    
    /#
        function_4f8e4f0072eb1938();
    #/
}

/#

    // Namespace zm_vo
    // Params 1
    // Checksum 0xc3930e92, Offset: 0x218e
    // Size: 0x33, Type: dev
    function function_2ebd003f037b5c32( params )
    {
        str_vo_alias = utility::array_random( params );
        
        if ( isdefined( str_vo_alias ) )
        {
            level thread vo_say_announcer( str_vo_alias );
        }
    }

    // Namespace zm_vo
    // Params 0
    // Checksum 0xc3379aab, Offset: 0x21c9
    // Size: 0x212, Type: dev
    function function_4f8e4f0072eb1938()
    {
        devgui::function_9082edeb5db93280( "<dev string:x1c1>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1e2>", "<dev string:x1ec>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x261>", "<dev string:x26b>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2a6>", "<dev string:x2b4>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2ef>", "<dev string:x2fa>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x335>", "<dev string:x33f>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x37a>", "<dev string:x385>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3c0>", "<dev string:x3c5>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x400>", "<dev string:x412>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x44d>", "<dev string:x458>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x493>", "<dev string:x49d>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4d8>", "<dev string:x4e5>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x525>", "<dev string:x536>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x571>", "<dev string:x585>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5c0>", "<dev string:x5c8>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x603>", "<dev string:x612>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x64d>", "<dev string:x664>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x69f>", "<dev string:x6b8>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x6ff>", "<dev string:x718>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x789>", "<dev string:x78e>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7d2>", "<dev string:x7da>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x821>", "<dev string:x82d>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x878>", "<dev string:x87f>", &function_2ebd003f037b5c32 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x8c5>", "<dev string:x8d1>", &function_2ebd003f037b5c32 );
        devgui::function_77df7fe7dd273e10();
    }

#/

// Namespace zm_vo
// Params 2
// Checksum 0xc3103846, Offset: 0x23e3
// Size: 0x191
function function_c0b0828d1107c141( params, b_add_devgui )
{
    function_55319be40b828f47( #"game_over", [ #"hash_6e9994f8e50ccd8f", #"hash_6e9995f8e50ccf42", #"hash_6e9996f8e50cd0f5" ] );
    function_55319be40b828f47( #"full_ammo", #"hash_4c62462c3023f1d6" );
    function_55319be40b828f47( #"double_points", #"hash_4c51252c30154690" );
    function_55319be40b828f47( #"insta_kill", #"hash_4c7d482c303abcf4" );
    function_55319be40b828f47( #"fire_sale", #"hash_4c58302c301b77ef" );
    function_55319be40b828f47( #"full_armor", #"hash_4c62412c3023e957" );
    function_55319be40b828f47( #"nuke", #"hash_4c73482c3032686f" );
    function_55319be40b828f47( #"bonus_points_team", #"hash_4c65292c3025f666" );
    function_55319be40b828f47( #"full_power", #"hash_4c58312c301b79a2" );
    function_55319be40b828f47( #"free_perk", #"hash_4c9c292c305538d6" );
    function_55319be40b828f47( #"eternal_perk", #"hash_c710fde6016ddd76" );
    function_55319be40b828f47( #"player_elimination", [ #"hash_f9d182093bba0d8e", #"hash_f9d181093bba0bdb" ] );
    magicbox::function_193ed9e2a7303c24( #"bunny_sound_mq_completed" );
    
    /#
        if ( b_add_devgui )
        {
            function_4f8e4f0072eb1938();
        }
    #/
}

// Namespace zm_vo
// Params 1
// Checksum 0xa126c3c1, Offset: 0x257c
// Size: 0x41, Type: bool
function is_vo_on_cooldown( var_f4b6d1cabea0bba1 )
{
    if ( getdvarint( @"scr_zm_vo_ignore_cooldown", 0 ) )
    {
        return false;
    }
    
    if ( gettime() < self.s_zm_vo.var_e7ad2f6f6fb50f46[ var_f4b6d1cabea0bba1 ] )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_vo
// Params 2
// Checksum 0xaa4d0480, Offset: 0x25c6
// Size: 0x49
function set_vo_on_cooldown( var_f4b6d1cabea0bba1, n_cooldown_ms )
{
    if ( !isdefined( self.s_zm_vo ) )
    {
        self.s_zm_vo = {};
    }
    
    self.s_zm_vo.var_e7ad2f6f6fb50f46[ var_f4b6d1cabea0bba1 ] = gettime() + n_cooldown_ms;
}

// Namespace zm_vo
// Params 4
// Checksum 0xf759c456, Offset: 0x2617
// Size: 0x76
function function_e8e3ebe31c2c48bb( str_vo_alias, n_cooldown_time_ms = 0, var_f4b6d1cabea0bba1 = str_vo_alias, cooldown_ent = self )
{
    b_success = 0;
    
    if ( !cooldown_ent is_vo_on_cooldown( var_f4b6d1cabea0bba1 ) )
    {
        b_success = dialogue::say( str_vo_alias );
        
        if ( b_success )
        {
            cooldown_ent set_vo_on_cooldown( var_f4b6d1cabea0bba1, n_cooldown_time_ms );
        }
    }
    
    return b_success;
}

// Namespace zm_vo
// Params 1, eflags: 0x4
// Checksum 0xdfe8bfc6, Offset: 0x2696
// Size: 0x5f, Type: bool
function private function_e4b91ef97fc5eb0c( var_f4b6d1cabea0bba1 )
{
    if ( getdvarint( @"scr_zm_vo_ignore_cooldown", 0 ) )
    {
        return false;
    }
    
    if ( gettime() < self.s_zm_vo.var_7e3a2cf03c54cfdf )
    {
        return true;
    }
    
    if ( gettime() < self.s_zm_vo.var_e7ad2f6f6fb50f46[ var_f4b6d1cabea0bba1 ] )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_vo
// Params 6
// Checksum 0x5e01878e, Offset: 0x26fe
// Size: 0x89
function say_battlechatter( var_6910614316cc9571, n_cooldown_time_ms = 4000, var_f4b6d1cabea0bba1 = var_6910614316cc9571, n_delay, var_a1228d7df1024e64, n_chance_override )
{
    b_success = 0;
    
    if ( !function_e4b91ef97fc5eb0c( var_f4b6d1cabea0bba1 ) )
    {
        b_success = battlechatter_mp::trysaylocalsound( self, var_6910614316cc9571, n_delay, undefined, undefined, undefined, undefined, var_a1228d7df1024e64, n_chance_override );
        
        if ( b_success )
        {
            function_2eca337ff0ec3a94( var_f4b6d1cabea0bba1, n_cooldown_time_ms );
        }
    }
    
    return b_success;
}

// Namespace zm_vo
// Params 2, eflags: 0x4
// Checksum 0xc7e218cb, Offset: 0x2790
// Size: 0x85
function private function_2eca337ff0ec3a94( var_f4b6d1cabea0bba1, n_cooldown_ms )
{
    if ( !isdefined( self.s_zm_vo ) )
    {
        self.s_zm_vo = { #var_7e3a2cf03c54cfdf:0, #var_e7ad2f6f6fb50f46:[] };
    }
    
    if ( isdefined( var_f4b6d1cabea0bba1 ) && isdefined( n_cooldown_ms ) )
    {
        self.s_zm_vo.var_e7ad2f6f6fb50f46[ var_f4b6d1cabea0bba1 ] = gettime() + n_cooldown_ms;
    }
    
    self.s_zm_vo.var_7e3a2cf03c54cfdf = gettime() + 4000;
}

// Namespace zm_vo
// Params 1, eflags: 0x4
// Checksum 0xdc1b1be9, Offset: 0x281d
// Size: 0x2a
function private on_player_connect( params )
{
    self.s_zm_vo = { #var_7e3a2cf03c54cfdf:0, #var_e7ad2f6f6fb50f46:[] };
}

// Namespace zm_vo
// Params 1, eflags: 0x4
// Checksum 0xb82c0637, Offset: 0x284f
// Size: 0x58
function private on_player_laststand_enter( params )
{
    self endon( #"disconnect" );
    wait 1;
    
    if ( !level.b_zm_game_over )
    {
        say_battlechatter( #"bc_status_player_last_stand", undefined, undefined, undefined, 1 );
        
        if ( isdefined( level.var_f160fb49d8c92d86 ) )
        {
            level thread [[ level.var_f160fb49d8c92d86 ]]( self );
        }
    }
}

// Namespace zm_vo
// Params 1, eflags: 0x4
// Checksum 0xb6071e35, Offset: 0x28af
// Size: 0x4d
function private on_player_revive_start( params )
{
    reviver = params.reviver;
    
    if ( !isplayer( reviver ) || reviver == self )
    {
        return;
    }
    
    if ( !isdefined( self.var_7a65a0af1a321257 ) )
    {
        self.var_7a65a0af1a321257 = reviver;
    }
}

// Namespace zm_vo
// Params 1, eflags: 0x4
// Checksum 0xfea758fb, Offset: 0x2904
// Size: 0x4f9
function private function_b0f8cce4da821455( params )
{
    reviver = params.reviver;
    
    if ( !isplayer( reviver ) || reviver == self )
    {
        return;
    }
    
    var_4607de743dca5547 = utility::cointoss() || getdvarint( @"hash_d205ed9ddf11b78a", 0 );
    
    if ( is_weaver() )
    {
        if ( var_4607de743dca5547 && battlechatter_mp::function_fb3633bb3479f698( #"hash_12bb17631972610b" ) )
        {
            str_revive = #"hash_12bb17631972610b";
        }
        else
        {
            str_revive = #"bc_status_action_reviving";
        }
    }
    else if ( is_grey() )
    {
        if ( var_4607de743dca5547 && battlechatter_mp::function_fb3633bb3479f698( #"hash_2cf18ea759e7929a" ) )
        {
            str_revive = #"hash_2cf18ea759e7929a";
        }
        else
        {
            str_revive = #"bc_status_action_reviving";
        }
    }
    else if ( is_maya() )
    {
        if ( var_4607de743dca5547 && battlechatter_mp::function_fb3633bb3479f698( #"hash_298600705e485a23" ) )
        {
            str_revive = #"hash_298600705e485a23";
        }
        else
        {
            str_revive = #"bc_status_action_reviving";
        }
    }
    else if ( is_carver() )
    {
        if ( var_4607de743dca5547 && battlechatter_mp::function_fb3633bb3479f698( #"hash_db1d01650153238a" ) )
        {
            str_revive = #"hash_db1d01650153238a";
        }
        else
        {
            str_revive = #"bc_status_action_reviving";
        }
    }
    else if ( is_richtofen() )
    {
        if ( var_4607de743dca5547 && battlechatter_mp::function_fb3633bb3479f698( #"hash_be3a2729d7689499" ) )
        {
            str_revive = #"hash_be3a2729d7689499";
        }
        else
        {
            str_revive = #"bc_status_action_reviving";
        }
    }
    else if ( is_dempsey() )
    {
        if ( var_4607de743dca5547 && battlechatter_mp::function_fb3633bb3479f698( #"hash_de5c78785596cc20" ) )
        {
            str_revive = #"hash_de5c78785596cc20";
        }
        else
        {
            str_revive = #"bc_status_action_reviving";
        }
    }
    else if ( is_takeo() )
    {
        if ( var_4607de743dca5547 && battlechatter_mp::function_fb3633bb3479f698( #"hash_faf99a4ebcad6cf" ) )
        {
            str_revive = #"hash_faf99a4ebcad6cf";
        }
        else
        {
            str_revive = #"bc_status_action_reviving";
        }
    }
    else if ( is_nikolai() )
    {
        if ( var_4607de743dca5547 && battlechatter_mp::function_fb3633bb3479f698( #"hash_bb635f6e8b23b0c8" ) )
        {
            str_revive = #"hash_bb635f6e8b23b0c8";
        }
        else
        {
            str_revive = #"bc_status_action_reviving";
        }
    }
    else
    {
        str_revive = #"bc_status_action_reviving";
    }
    
    if ( reviver is_weaver() )
    {
        if ( var_4607de743dca5547 && battlechatter_mp::function_fb3633bb3479f698( #"hash_1cdbd60dd7762adb" ) )
        {
            var_416dbb47b06df47 = #"hash_1cdbd60dd7762adb";
        }
        else
        {
            var_416dbb47b06df47 = #"bc_status_player_revived";
        }
    }
    else if ( reviver is_grey() )
    {
        if ( var_4607de743dca5547 && battlechatter_mp::function_fb3633bb3479f698( #"hash_2b10a57e243777cc" ) )
        {
            var_416dbb47b06df47 = #"hash_2b10a57e243777cc";
        }
        else
        {
            var_416dbb47b06df47 = #"bc_status_player_revived";
        }
    }
    else if ( reviver is_maya() )
    {
        if ( var_4607de743dca5547 && battlechatter_mp::function_fb3633bb3479f698( #"hash_3b3d167ed9ac2273" ) )
        {
            var_416dbb47b06df47 = #"hash_3b3d167ed9ac2273";
        }
        else
        {
            var_416dbb47b06df47 = #"bc_status_player_revived";
        }
    }
    else if ( reviver is_carver() )
    {
        if ( var_4607de743dca5547 && battlechatter_mp::function_fb3633bb3479f698( #"hash_2a2e48cb51b87ebc" ) )
        {
            var_416dbb47b06df47 = #"hash_2a2e48cb51b87ebc";
        }
        else
        {
            var_416dbb47b06df47 = #"bc_status_player_revived";
        }
    }
    else if ( reviver is_richtofen() )
    {
        if ( var_4607de743dca5547 && battlechatter_mp::function_fb3633bb3479f698( #"hash_5e71f3aabde8a65" ) )
        {
            var_416dbb47b06df47 = #"hash_5e71f3aabde8a65";
        }
        else
        {
            var_416dbb47b06df47 = #"bc_status_player_revived";
        }
    }
    else if ( reviver is_dempsey() )
    {
        if ( var_4607de743dca5547 && battlechatter_mp::function_fb3633bb3479f698( #"hash_2e6cac7356cd7166" ) )
        {
            var_416dbb47b06df47 = #"hash_2e6cac7356cd7166";
        }
        else
        {
            var_416dbb47b06df47 = #"bc_status_player_revived";
        }
    }
    else if ( reviver is_takeo() )
    {
        if ( var_4607de743dca5547 && battlechatter_mp::function_fb3633bb3479f698( #"hash_5a481e1108e32daf" ) )
        {
            var_416dbb47b06df47 = #"hash_5a481e1108e32daf";
        }
        else
        {
            var_416dbb47b06df47 = #"bc_status_player_revived";
        }
    }
    else if ( reviver is_nikolai() )
    {
        if ( var_4607de743dca5547 && battlechatter_mp::function_fb3633bb3479f698( #"hash_68b280795d1896e" ) )
        {
            var_416dbb47b06df47 = #"hash_68b280795d1896e";
        }
        else
        {
            var_416dbb47b06df47 = #"bc_status_player_revived";
        }
    }
    else
    {
        var_416dbb47b06df47 = #"bc_status_player_revived";
    }
    
    if ( isdefined( level.var_e96fb1642242269f ) && [[ level.var_e96fb1642242269f ]]( self, reviver, var_416dbb47b06df47, str_revive ) )
    {
        self.var_7a65a0af1a321257 = undefined;
        return;
    }
    
    if ( battlechatter_mp::function_fb3633bb3479f698( str_revive ) && self.var_7a65a0af1a321257 == reviver )
    {
        b_success = reviver say_battlechatter( str_revive, 15000, #"revived_vo" );
    }
    
    if ( !b_success )
    {
        return;
    }
    
    wait 3;
    
    if ( battlechatter_mp::function_fb3633bb3479f698( var_416dbb47b06df47 ) )
    {
        b_success = say_battlechatter( var_416dbb47b06df47, 15000, #"hash_833e92eeee7a04a4" );
    }
    
    self.var_7a65a0af1a321257 = undefined;
}

// Namespace zm_vo
// Params 1, eflags: 0x4
// Checksum 0x20439310, Offset: 0x2e05
// Size: 0x29
function private on_player_spawned( params )
{
    thread function_66f7ef62bd487d53();
    self.var_7a65a0af1a321257 = undefined;
    self notify( #"hash_e261f61410898d60" );
}

// Namespace zm_vo
// Params 0, eflags: 0xc
// Checksum 0x665aeb97, Offset: 0x2e36
// Size: 0x470
function private function_66f7ef62bd487d53()
{
    self notify( #"hash_8d018abb098d61e9" );
    self endon( #"hash_8d018abb098d61e9" );
    self endon( #"death_or_disconnect" );
    var_46a827761402492a = 10;
    var_8b1aa7fcb59ee32a = 1000;
    
    while ( true )
    {
        b_success = 0;
        a_nearby_ai = getaiarrayinradius( self.origin, 150, level.var_ece703e3d116381c );
        
        if ( a_nearby_ai.size >= var_46a827761402492a )
        {
            n_front = 0;
            n_back = 0;
            
            foreach ( ai in a_nearby_ai )
            {
                if ( ai.enemy === self )
                {
                    if ( math::is_point_in_front( ai.origin ) )
                    {
                        n_front++;
                        continue;
                    }
                    
                    n_back++;
                }
            }
            
            if ( n_front >= 3 && n_back >= 3 && player_can_say_vo() )
            {
                b_success = say_battlechatter( #"hash_8f4d37186019f7d3", 90000, #"hash_b4a56cf11d93e178" );
                
                if ( b_success )
                {
                    wait 4.5;
                }
            }
        }
        
        if ( !b_success )
        {
            wait 1;
            continue;
        }
        
        if ( isdefined( level.var_da39da765644d065 ) )
        {
            if ( isdefined( level.var_6f48cd55dc6feea7 ) )
            {
                level thread [[ level.var_6f48cd55dc6feea7 ]]( self );
            }
            
            wait 1;
            continue;
        }
        
        a_nearby_players = utility::get_array_of_closest( self.origin, level.players, [ self ], undefined, var_8b1aa7fcb59ee32a );
        
        foreach ( other_player in a_nearby_players )
        {
            if ( other_player function_205ccdaddcc68c66( self, var_8b1aa7fcb59ee32a ) )
            {
                b_success = 0;
                
                if ( other_player is_hero_operator() && ( utility::cointoss() || getdvarint( @"hash_d205ed9ddf11b78a", 0 ) ) )
                {
                    if ( is_weaver() && battlechatter_mp::function_fb3633bb3479f698( #"hash_d198da0f714398ed" ) )
                    {
                        b_success = other_player say_battlechatter( #"hash_d198da0f714398ed" );
                    }
                    else if ( is_grey() && battlechatter_mp::function_fb3633bb3479f698( #"hash_2d006a4519bb8202" ) )
                    {
                        b_success = other_player say_battlechatter( #"hash_2d006a4519bb8202" );
                    }
                    else if ( is_maya() && battlechatter_mp::function_fb3633bb3479f698( #"hash_9c50fa283039d365" ) )
                    {
                        b_success = other_player say_battlechatter( #"hash_9c50fa283039d365" );
                    }
                    else if ( is_carver() && battlechatter_mp::function_fb3633bb3479f698( #"hash_121563d024682952" ) )
                    {
                        b_success = other_player say_battlechatter( #"hash_121563d024682952" );
                    }
                    else if ( is_richtofen() && battlechatter_mp::function_fb3633bb3479f698( #"hash_abbc9c6e42792d3" ) )
                    {
                        b_success = other_player say_battlechatter( #"hash_abbc9c6e42792d3" );
                    }
                    else if ( is_dempsey() && battlechatter_mp::function_fb3633bb3479f698( #"hash_3a59f0f0018cf000" ) )
                    {
                        b_success = other_player say_battlechatter( #"hash_3a59f0f0018cf000" );
                    }
                    else if ( is_takeo() && battlechatter_mp::function_fb3633bb3479f698( #"hash_a4a7687ecf2ba7b1" ) )
                    {
                        b_success = other_player say_battlechatter( #"hash_a4a7687ecf2ba7b1" );
                    }
                    else if ( is_nikolai() && battlechatter_mp::function_fb3633bb3479f698( #"hash_d9870fe5d0496ba8" ) )
                    {
                        b_success = other_player say_battlechatter( #"hash_d9870fe5d0496ba8" );
                    }
                    else
                    {
                        b_success = other_player say_battlechatter( #"hash_dcaf8bda34843186" );
                    }
                }
                else
                {
                    b_success = other_player say_battlechatter( #"hash_dcaf8bda34843186" );
                }
                
                if ( getdvarint( @"scr_zm_vo_ignore_cooldown", 0 ) )
                {
                    wait 3;
                    continue;
                }
                
                level thread function_da39da765644d065();
            }
        }
        
        if ( !a_nearby_players.size && isdefined( level.var_fad8884bf9893ddd ) )
        {
            level thread [[ level.var_fad8884bf9893ddd ]]( self );
        }
        
        wait 1;
    }
}

// Namespace zm_vo
// Params 0, eflags: 0x4
// Checksum 0x93bc14cd, Offset: 0x32ae
// Size: 0x26
function private function_da39da765644d065()
{
    level endon( #"game_ended" );
    level.var_da39da765644d065 = 1;
    wait 15;
    level.var_da39da765644d065 = undefined;
}

// Namespace zm_vo
// Params 1, eflags: 0x4
// Checksum 0xa15c1d55, Offset: 0x32dc
// Size: 0x45, Type: bool
function private player_can_say_vo( b_allow_laststand = 0 )
{
    if ( isalive( self ) && self.sessionstate == "playing" && ( !player::isinlaststand( self ) || b_allow_laststand ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_vo
// Params 4, eflags: 0x4
// Checksum 0xd9811391, Offset: 0x332a
// Size: 0xbc, Type: bool
function private function_205ccdaddcc68c66( other_player, var_35e281b749d1e2ce = 1000, var_21b15663c1ebd7fd = 0, v_pos_override )
{
    if ( self === other_player )
    {
        return false;
    }
    
    if ( var_21b15663c1ebd7fd && ( !is_hero_operator() || !other_player is_hero_operator() ) )
    {
        return false;
    }
    
    if ( player_can_say_vo() && other_player player_can_say_vo() && distance( self.origin, other_player.origin ) <= var_35e281b749d1e2ce )
    {
        if ( trace::can_see_origin( v_pos_override ?? other_player geteye(), 0, undefined, [ self, other_player ], 0 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zm_vo
// Params 0
// Checksum 0x90f5f5de, Offset: 0x33ef
// Size: 0x11, Type: bool
function function_5129ab1834cf276b()
{
    if ( function_5600317993be908b() > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_vo
// Params 0
// Checksum 0xac23a39, Offset: 0x3409
// Size: 0xac
function function_5600317993be908b()
{
    var_eee20cb4dd3ba017 = 0;
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && player.sessionstate == "playing" && player is_hero_operator() )
        {
            var_eee20cb4dd3ba017++;
        }
    }
    
    return var_eee20cb4dd3ba017;
}

// Namespace zm_vo
// Params 0
// Checksum 0xd8c590b7, Offset: 0x34be
// Size: 0x1dc
function function_45cca440418fb22b()
{
    if ( level.players.size <= 1 )
    {
        return;
    }
    
    a_alive_players = utility::get_alive_players();
    a_alive_players = arrayrandomize( a_alive_players );
    var_ffe717ed2a5ffae1 = [];
    var_dedf2f2f52bf6272 = 1000;
    
    for ( i = 0; i < a_alive_players.size ; i++ )
    {
        first_player = a_alive_players[ i ];
        
        if ( first_player is_hero_operator() )
        {
            for ( j = i + 1; j < a_alive_players.size ; j++ )
            {
                second_player = a_alive_players[ j ];
                
                if ( second_player is_hero_operator() && !function_5cf61b74062b7a8b( first_player, second_player ) )
                {
                    var_55f7b3d19fbd8c26 = spawnstruct();
                    var_55f7b3d19fbd8c26.a_players = [ first_player, second_player ];
                    var_55f7b3d19fbd8c26.a_player_names = [ first_player function_470ff6ad4f437db1(), second_player function_470ff6ad4f437db1() ];
                    var_55f7b3d19fbd8c26.n_distance = distance( first_player.origin, second_player.origin );
                    
                    if ( var_55f7b3d19fbd8c26.n_distance <= var_dedf2f2f52bf6272 )
                    {
                        var_ffe717ed2a5ffae1[ var_ffe717ed2a5ffae1.size ] = var_55f7b3d19fbd8c26;
                    }
                }
            }
        }
    }
    
    n_closest_distance = var_dedf2f2f52bf6272;
    
    foreach ( var_55f7b3d19fbd8c26 in var_ffe717ed2a5ffae1 )
    {
        if ( var_55f7b3d19fbd8c26.n_distance <= n_closest_distance )
        {
            var_cab0bd887db6f30a = var_55f7b3d19fbd8c26;
            n_closest_distance = var_55f7b3d19fbd8c26.n_distance;
        }
    }
    
    return var_cab0bd887db6f30a;
}

// Namespace zm_vo
// Params 0
// Checksum 0x19980cd0, Offset: 0x36a3
// Size: 0x8f
function function_470ff6ad4f437db1()
{
    if ( is_weaver() )
    {
        return "weaver";
    }
    
    if ( is_maya() )
    {
        return "maya";
    }
    
    if ( is_grey() )
    {
        return "grey";
    }
    
    if ( is_carver() )
    {
        return "carver";
    }
    
    if ( is_richtofen() )
    {
        return "richtofen";
    }
    
    if ( is_dempsey() )
    {
        return "dempsey";
    }
    
    if ( is_takeo() )
    {
        return "takeo";
    }
    
    if ( is_nikolai() )
    {
        return "nikolai";
    }
}

// Namespace zm_vo
// Params 2
// Checksum 0xad6174ec, Offset: 0x373a
// Size: 0x47, Type: bool
function function_5cf61b74062b7a8b( first_player, second_player )
{
    if ( first_player.operatorcustomization.operatorref == second_player.operatorcustomization.operatorref )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_vo
// Params 0
// Checksum 0x15cd4fb4, Offset: 0x378a
// Size: 0x55, Type: bool
function is_hero_operator()
{
    if ( is_weaver() || is_maya() || is_grey() || is_carver() || is_richtofen() || is_dempsey() || is_takeo() || is_nikolai() )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_vo
// Params 0
// Checksum 0xa92c27fb, Offset: 0x37e8
// Size: 0x47, Type: bool
function is_weaver()
{
    if ( self.operatorcustomization.operatorref === %"t10_rus_pl_weaver" || self.operatorcustomization.operatorref === %"sat_rus_pl_weaver" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_vo
// Params 0
// Checksum 0x83d5a90, Offset: 0x3838
// Size: 0x47, Type: bool
function is_maya()
{
    if ( self.operatorcustomization.operatorref === %"t10_phl_pl_maya" || self.operatorcustomization.operatorref === %"sat_phl_pl_maya" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_vo
// Params 0
// Checksum 0x2b1e27b2, Offset: 0x3888
// Size: 0x47, Type: bool
function is_grey()
{
    if ( self.operatorcustomization.operatorref === %"t10_gbr_pl_grey" || self.operatorcustomization.operatorref === %"sat_gbr_pl_grey" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_vo
// Params 0
// Checksum 0x7fe2a64b, Offset: 0x38d8
// Size: 0x47, Type: bool
function is_carver()
{
    if ( self.operatorcustomization.operatorref === %"t10_usa_pl_carver" || self.operatorcustomization.operatorref === %"sat_usa_pl_carver" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_vo
// Params 0
// Checksum 0xe2696bc2, Offset: 0x3928
// Size: 0x26, Type: bool
function is_richtofen()
{
    if ( self.operatorcustomization.operatorref === %"sat_ger_pl_purple" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_vo
// Params 0
// Checksum 0xfbbaa68, Offset: 0x3957
// Size: 0x26, Type: bool
function is_dempsey()
{
    if ( self.operatorcustomization.operatorref === %"sat_usa_pl_amber" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_vo
// Params 0
// Checksum 0xfa6613a8, Offset: 0x3986
// Size: 0x26, Type: bool
function is_takeo()
{
    if ( self.operatorcustomization.operatorref === %"sat_jpn_pl_scarlet" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_vo
// Params 0
// Checksum 0xdb55291e, Offset: 0x39b5
// Size: 0x26, Type: bool
function is_nikolai()
{
    if ( self.operatorcustomization.operatorref === %"sat_rus_pl_magenta" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_vo
// Params 0
// Checksum 0xd8ab5c23, Offset: 0x39e4
// Size: 0x26, Type: bool
function is_tedd()
{
    if ( self.operatorcustomization.operatorref === %"sat_usa_pl_silver" )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_vo
// Params 1
// Checksum 0x1891411b, Offset: 0x3a13
// Size: 0xb4
function get_tedd_players( var_f3e458453d505336 = 0 )
{
    var_23678b38e8a299c4 = [];
    
    foreach ( player in level.players )
    {
        if ( player is_tedd() && ( !var_f3e458453d505336 || isalive( player ) ) )
        {
            var_23678b38e8a299c4[ var_23678b38e8a299c4.size ] = player;
        }
    }
    
    return var_23678b38e8a299c4;
}

// Namespace zm_vo
// Params 1
// Checksum 0xb92f5650, Offset: 0x3ad0
// Size: 0x3e
function on_player_damaged( params )
{
    if ( isalive( self ) && self.sessionstate == "playing" && self.health <= 50 )
    {
        thread function_338fabe32ddd22dc();
    }
}

// Namespace zm_vo
// Params 0, eflags: 0xc
// Checksum 0xaca5a2a, Offset: 0x3b16
// Size: 0x84
function private function_338fabe32ddd22dc()
{
    self notify( #"hash_dee1f44167558427" );
    self endon( #"hash_dee1f44167558427" );
    self endon( #"death_or_disconnect" );
    self endon( #"last_stand_enter" );
    self endon( #"hash_e261f61410898d60" );
    
    while ( isalive( self ) && self.sessionstate == "playing" )
    {
        if ( self.health >= self.maxhealth )
        {
            say_battlechatter( #"bc_flavor_player_closecall" );
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_vo
// Params 1
// Checksum 0x79c2b1e4, Offset: 0x3ba2
// Size: 0x102
function on_agent_ai_damaged( params )
{
    if ( isplayer( params.eattacker ) && params.biscritical && params.smeansofdeath != "MOD_GRENADE_SPLASH" && params.smeansofdeath != "MOD_EXPLOSIVE" && params.smeansofdeath != "MOD_MELEE" && params.idamage >= self.health && params.eattacker player_can_say_vo() && self.aicategory == "normal" )
    {
        if ( level.var_8ac0269a25056b07[ self.subclass ] )
        {
            return;
        }
        
        if ( isdefined( level.var_8f451dc60be8e7a2 ) && !self [[ level.var_8f451dc60be8e7a2 ]]( params ) )
        {
            return;
        }
        
        params.eattacker critical_kill_vo( params.vpoint );
    }
}

// Namespace zm_vo
// Params 1
// Checksum 0xcf177cc5, Offset: 0x3cac
// Size: 0xfa
function function_9238338f068b6568( params )
{
    if ( isplayer( params.eattacker ) )
    {
        if ( params.smeansofdeath === "MOD_MELEE" && params.eattacker player_can_say_vo() && self.aicategory == "normal" )
        {
            if ( params.eattacker is_hero_operator() && battlechatter_mp::function_fb3633bb3479f698( #"hash_bdff618d7762a5b4" ) && ( utility::cointoss() || getdvarint( @"hash_d205ed9ddf11b78a", 0 ) ) )
            {
                b_success = params.eattacker say_battlechatter( #"hash_bdff618d7762a5b4", 60000, #"melee_kill" );
                return;
            }
            
            b_success = params.eattacker say_battlechatter( #"bc_general_kill_zombie_melee", 60000, #"melee_kill" );
        }
    }
}

// Namespace zm_vo
// Params 1, eflags: 0x4
// Checksum 0x734323cb, Offset: 0x3dae
// Size: 0x440
function private critical_kill_vo( v_kill_origin )
{
    self endon( #"disconnect" );
    
    if ( !function_e4b91ef97fc5eb0c( #"critical_kill_vo" ) )
    {
        b_success = 0;
        
        if ( is_hero_operator() && battlechatter_mp::function_fb3633bb3479f698( #"hash_5b6919511550f5a1" ) && ( utility::cointoss() || getdvarint( @"hash_d205ed9ddf11b78a", 0 ) ) )
        {
            b_success = say_battlechatter( #"hash_5b6919511550f5a1", 240000, #"critical_kill_vo" );
        }
        else
        {
            b_success = say_battlechatter( #"bc_general_kill_zombie_critical_kill", 240000, #"critical_kill_vo" );
        }
        
        if ( b_success )
        {
            wait 2.5;
        }
    }
    
    if ( !b_success )
    {
        return;
    }
    
    b_success = 0;
    a_nearby_players = utility::get_array_of_closest( self.origin, level.players, [ self ], undefined, 1000 );
    
    foreach ( other_player in a_nearby_players )
    {
        if ( other_player function_205ccdaddcc68c66( self, 1000 ) || other_player function_205ccdaddcc68c66( self, 1000, undefined, v_kill_origin ) )
        {
            if ( !other_player function_e4b91ef97fc5eb0c( #"hash_910b00bfc371b35" ) )
            {
                if ( other_player is_hero_operator() && ( utility::cointoss() || getdvarint( @"hash_d205ed9ddf11b78a", 0 ) ) )
                {
                    if ( is_weaver() && battlechatter_mp::function_fb3633bb3479f698( #"hash_a1047d1d441d6710" ) )
                    {
                        b_success = other_player say_battlechatter( #"hash_a1047d1d441d6710", 60000, #"hash_910b00bfc371b35" );
                    }
                    else if ( is_grey() && battlechatter_mp::function_fb3633bb3479f698( #"hash_50bc992df5ee3727" ) )
                    {
                        b_success = other_player say_battlechatter( #"hash_50bc992df5ee3727", 60000, #"hash_910b00bfc371b35" );
                    }
                    else if ( is_maya() && battlechatter_mp::function_fb3633bb3479f698( #"hash_32988889dd6b62d8" ) )
                    {
                        b_success = other_player say_battlechatter( #"hash_32988889dd6b62d8", 60000, #"hash_910b00bfc371b35" );
                    }
                    else if ( is_carver() && battlechatter_mp::function_fb3633bb3479f698( #"hash_681f1db17a2edef7" ) )
                    {
                        b_success = other_player say_battlechatter( #"hash_681f1db17a2edef7", 60000, #"hash_910b00bfc371b35" );
                    }
                    else if ( is_richtofen() && battlechatter_mp::function_fb3633bb3479f698( #"hash_6e861e4ed679c8fa" ) )
                    {
                        b_success = other_player say_battlechatter( #"hash_6e861e4ed679c8fa", 60000, #"hash_910b00bfc371b35" );
                    }
                    else if ( is_dempsey() && battlechatter_mp::function_fb3633bb3479f698( #"hash_ff4f6b80584fdbf1" ) )
                    {
                        b_success = other_player say_battlechatter( #"hash_ff4f6b80584fdbf1", 60000, #"hash_910b00bfc371b35" );
                    }
                    else if ( is_takeo() && battlechatter_mp::function_fb3633bb3479f698( #"hash_f18a2f1a8806583c" ) )
                    {
                        b_success = other_player say_battlechatter( #"hash_f18a2f1a8806583c", 60000, #"hash_910b00bfc371b35" );
                    }
                    else if ( is_nikolai() && battlechatter_mp::function_fb3633bb3479f698( #"hash_bb7079235e6b8de9" ) )
                    {
                        b_success = other_player say_battlechatter( #"hash_bb7079235e6b8de9", 60000, #"hash_910b00bfc371b35" );
                    }
                    else
                    {
                        b_success = other_player say_battlechatter( #"hash_be00c9ac3def5e08", 60000, #"hash_910b00bfc371b35" );
                    }
                }
                else
                {
                    b_success = other_player say_battlechatter( #"hash_be00c9ac3def5e08", 60000, #"hash_910b00bfc371b35" );
                }
            }
            
            if ( b_success )
            {
                break;
            }
        }
    }
    
    if ( !b_success && isdefined( level.var_599dcf0ecc48165b ) )
    {
        level thread [[ level.var_599dcf0ecc48165b ]]( self );
        b_success = 1;
    }
    
    if ( !b_success && !a_nearby_players.size && isdefined( level.var_939b7a7022fddd1e ) )
    {
        level thread [[ level.var_939b7a7022fddd1e ]]( self );
    }
}

// Namespace zm_vo
// Params 1
// Checksum 0xad522173, Offset: 0x41f6
// Size: 0xed
function on_exfil_start( params )
{
    var_5a5626a7d4b2feb = params.var_5a5626a7d4b2feb ?? params.s_exfil.activator;
    
    while ( overlord::function_dce0a14273dfa0a8( [ var_5a5626a7d4b2feb ] ) )
    {
        waitframe();
    }
    
    utility::flag_waitopen( "player_banter_playing" );
    
    if ( !isdefined( var_5a5626a7d4b2feb ) )
    {
        level utility::flag_set( "exfil_start_operator_vo_played" );
        return;
    }
    
    if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_748d420d941512fe" ) && ( utility::cointoss() || getdvarint( @"hash_d205ed9ddf11b78a", 0 ) ) )
    {
        var_5a5626a7d4b2feb say_battlechatter( #"hash_748d420d941512fe", undefined, #"exfil_call_in", 4 );
    }
    else
    {
        var_5a5626a7d4b2feb say_battlechatter( #"hash_b39b603ba5e4e6ef", undefined, #"exfil_call_in", 4 );
    }
    
    wait 8;
    level utility::flag_set( "exfil_start_operator_vo_played" );
}

// Namespace zm_vo
// Params 1
// Checksum 0x2d86a205, Offset: 0x42eb
// Size: 0x31
function on_pap_machine_purchased( params )
{
    self endon( #"death_or_disconnect" );
    wait 1.25;
    say_battlechatter( #"hash_2fc2f827b9e17ed4", 10000 );
}

// Namespace zm_vo
// Params 1
// Checksum 0x86e5119e, Offset: 0x4324
// Size: 0x1c
function on_magicbox_used( params )
{
    say_battlechatter( #"hash_2fe1240b33a1bc6d" );
}

// Namespace zm_vo
// Params 2
// Checksum 0x2b5e994c, Offset: 0x4348
// Size: 0x39
function function_65f03bd58b4aa( item_ref, var_2841f0faaa627db3 )
{
    if ( !isdefined( level.var_908b655fc27b96b9 ) )
    {
        level.var_908b655fc27b96b9 = [];
    }
    
    level.var_908b655fc27b96b9[ item_ref ] = var_2841f0faaa627db3;
}

// Namespace zm_vo
// Params 1
// Checksum 0x62abd13d, Offset: 0x4389
// Size: 0x2e4
function function_9cece87b28333c16( params )
{
    if ( !isplayer( self ) || level.var_908b655fc27b96b9[ params.itembundle.ref ] )
    {
        return;
    }
    
    var_916df9ec353c4438 = [ %"hash_79ebfdbcee5a2537", %"hash_464e33fda4f4fb2d", %"hash_10141b4c5be39107", %"hash_58cedef100bfc509", %"hash_61f91f1b57aa6c6b", %"hash_2ec859171f12ba69", %"hash_5bddc348d8568c04", %"hash_8f2a9ef1db2062" ];
    
    if ( params.var_15823e486f78cb79 && is_hero_operator() && player_banter::function_59ab3c2fe1424d34( hashcat( #"hash_538312d7694aa06c", params.itembundle.ref ) ) )
    {
        function_8c1a12974bd11f01( hashcat( #"hash_538312d7694aa06c", params.itembundle.ref ), #"hash_bd22a184ae51e3f3", 1.5 );
        return;
    }
    
    if ( params.var_15823e486f78cb79 && is_hero_operator() && player_banter::function_59ab3c2fe1424d34( #"hash_c7b0e3dc0201efbb" ) )
    {
        function_8c1a12974bd11f01( #"hash_c7b0e3dc0201efbb", #"hash_bd22a184ae51e3f3", 1.5 );
        return;
    }
    
    if ( params.var_4e0aa9a7c35d4dce || isdefined( params.itembundle.lootitemtype ) && arraycontains( var_916df9ec353c4438, params.itembundle.lootitemtype ) )
    {
        say_battlechatter( #"hash_72fb08f469faf94d", undefined, undefined, 1.5 );
        return;
    }
    
    if ( params.itembundle.ref == "t10_pi_p19_raygun" || params.itembundle.ref == "sat_ww_raygun" )
    {
        say_battlechatter( #"hash_e995f6b55ecb536d", undefined, undefined, 1.5 );
        return;
    }
    
    if ( params.itembundle.subtype == "ww" )
    {
        say_battlechatter( #"hash_c0209d447fa27171", undefined, undefined, 1.5 );
        return;
    }
    
    n_current_rarity = item_weapon::function_fb81bd2fe070faa6( self getcurrentweapon() );
    
    if ( params.itembundle.rarity >= n_current_rarity )
    {
        say_battlechatter( #"hash_bd22a184ae51e3f3", undefined, undefined, 1.5 );
        return;
    }
    
    if ( params.itembundle.rarity < n_current_rarity )
    {
        say_battlechatter( #"hash_beb5102e4d2b333f", undefined, undefined, 1.5 );
    }
}

// Namespace zm_vo
// Params 1
// Checksum 0xbea51e14, Offset: 0x4675
// Size: 0x1a0
function on_round_end( params )
{
    self notify( #"hash_c6f7781968f155e3" );
    self endon( #"hash_c6f7781968f155e3" );
    n_round_ended = params.roundnumber ?? zm_utility::get_round_number();
    
    switch ( n_round_ended )
    {
        case 14:
            if ( !utility::flag( "already_selected_round_15_react_vo" ) )
            {
                level notify( #"hash_70a00ba4c00e9339" );
                var_6910614316cc9571 = #"hash_5a4021869f3e1b67";
                level utility::flag_set( "already_selected_round_15_react_vo" );
            }
            
            break;
        case 29:
            var_6910614316cc9571 = #"hash_5f3bc3964771d062";
            break;
        case 49:
            var_6910614316cc9571 = #"hash_fd966ad17bd8658";
            break;
        case 99:
            var_6910614316cc9571 = #"hash_3f14d7da87a78b0c";
            break;
    }
    
    if ( isdefined( var_6910614316cc9571 ) )
    {
        zm_quest::function_8934bb2a9028bdc5();
        a_players = arrayrandomize( level.players );
        
        foreach ( player in a_players )
        {
            if ( player player_can_say_vo() )
            {
                utility::flag_waitopen( "exfil_vo_event_playing" );
                b_success = player say_battlechatter( var_6910614316cc9571, undefined, undefined, 3 );
                return;
            }
        }
    }
}

// Namespace zm_vo
// Params 1
// Checksum 0xe6e0ce38, Offset: 0x481d
// Size: 0x23
function on_gobblegum_used( params )
{
    say_battlechatter( #"hash_fa003b1b941f2b37", undefined, undefined, 1.5 );
}

// Namespace zm_vo
// Params 1
// Checksum 0x234f0de1, Offset: 0x4848
// Size: 0x20
function on_ascender_attach( params )
{
    say_battlechatter( #"hash_5f741931c67451ab", undefined, undefined, 1 );
}

// Namespace zm_vo
// Params 1
// Checksum 0x79ca730e, Offset: 0x4870
// Size: 0x2f
function on_zipline_attach( params )
{
    if ( !params.isvertical )
    {
        say_battlechatter( #"hash_5f741931c67451ab", undefined, undefined, 1 );
    }
}

// Namespace zm_vo
// Params 1
// Checksum 0xc4356c9d, Offset: 0x48a7
// Size: 0x2c
function function_aea7873862de6fad( params )
{
    level thread vo_say_announcer( function_157326aa0e824343( #"eternal_perk" ), undefined, undefined, undefined, [ self ] );
}

// Namespace zm_vo
// Params 1
// Checksum 0x70e23067, Offset: 0x48db
// Size: 0x2e3
function on_zm_perk_obtained( params )
{
    if ( !params.var_b12dc3d14c271171 )
    {
        return;
    }
    
    var_485ee1acddf9abdd = 3.5;
    
    switch ( params.var_ffc1674def575bfa )
    {
        case #"hash_8f7f900f28dfcf96":
            say_battlechatter( #"hash_57167a1e9271c07e", 10000, #"hash_751d4557b710b142", var_485ee1acddf9abdd );
            break;
        case #"hash_f8756efed2ffb6f4":
            say_battlechatter( #"hash_d6603bd0f49a382d", 10000, #"hash_751d4557b710b142", var_485ee1acddf9abdd );
            break;
        case #"hash_d5e621d55a8082dd":
            say_battlechatter( #"hash_392595581d9be4e", 10000, #"hash_751d4557b710b142", var_485ee1acddf9abdd );
            break;
        case #"hash_4485ea5afc8ef4ec":
            say_battlechatter( #"hash_5dd587f08d0ba87", 10000, #"hash_751d4557b710b142", var_485ee1acddf9abdd );
            break;
        case #"hash_ad7ceb3a37ee891c":
            say_battlechatter( #"hash_be7ffb8769cc267c", 10000, #"hash_751d4557b710b142", var_485ee1acddf9abdd );
            break;
        case #"hash_474f00cba8142b0b":
            say_battlechatter( #"hash_cd8f3f3cb3656554", 10000, #"hash_751d4557b710b142", var_485ee1acddf9abdd );
            break;
        case #"hash_47874f94af82bbae":
            say_battlechatter( #"hash_1b0ef79cdafbd878", 10000, #"hash_751d4557b710b142", var_485ee1acddf9abdd );
            break;
        case #"hash_5b88c6956390309e":
            say_battlechatter( #"hash_6ddf1966e12cff54", 10000, #"hash_751d4557b710b142", var_485ee1acddf9abdd );
            break;
        case #"hash_8ce81fd37af3e66b":
            say_battlechatter( #"hash_8dbd18d346bc34fa", 10000, #"hash_751d4557b710b142", var_485ee1acddf9abdd );
            break;
        case #"hash_8b9ba3dfc17ec0a4":
            say_battlechatter( #"hash_a7051f4b81f42723", 10000, #"hash_751d4557b710b142", var_485ee1acddf9abdd );
            break;
        case #"hash_a05b09269a304697":
            say_battlechatter( #"hash_c7e459c40e17877e", 10000, #"hash_751d4557b710b142", var_485ee1acddf9abdd );
            break;
        case #"hash_911728a3d7e223b2":
            say_battlechatter( #"hash_9d86b4ec8280698f", 10000, #"hash_751d4557b710b142", var_485ee1acddf9abdd );
            break;
        case #"hash_903fa971f2027571":
            say_battlechatter( #"hash_79961a839c06c9a3", 10000, #"hash_751d4557b710b142", var_485ee1acddf9abdd );
            break;
        case #"hash_e5e3d5b102e77800":
            say_battlechatter( #"hash_fed26962c35e04ca", 10000, #"hash_751d4557b710b142", var_485ee1acddf9abdd );
            break;
        default:
            say_battlechatter( #"hash_b8474195b0e466b6", 10000, #"hash_751d4557b710b142", var_485ee1acddf9abdd );
            break;
    }
}

// Namespace zm_vo
// Params 1
// Checksum 0xc51a8737, Offset: 0x4bc6
// Size: 0x2e
function function_e498c41fd90a8d6( params )
{
    if ( params.istimeout )
    {
        say_battlechatter( #"hash_bba063c0b5c2214f", undefined, undefined, 1 );
    }
}

// Namespace zm_vo
// Params 1
// Checksum 0xb7e8a93f, Offset: 0x4bfc
// Size: 0x6c
function on_player_death( params )
{
    if ( !level.b_zm_game_over && level.gametype != "zm_rb" && !game_utility::function_21211f3255f8ea58() && level.gametype != "zm_guided" && !game_utility::function_d68874417f3eea5c() )
    {
        level thread vo_say_announcer( function_157326aa0e824343( #"player_elimination" ) );
    }
}

// Namespace zm_vo
// Params 1
// Checksum 0x5a376415, Offset: 0x4c70
// Size: 0x42
function on_turned( params )
{
    player = params.attacker;
    
    if ( isplayer( player ) )
    {
        player say_battlechatter( #"bc_ammomod_brainrot_convert", undefined, undefined, 1 );
    }
}

// Namespace zm_vo
// Params 1
// Checksum 0x9e39b73f, Offset: 0x4cba
// Size: 0xff
function function_66eebfc0261222f6( params )
{
    self endon( #"disconnect" );
    var_9f6257f0ebc7d724 = 30000;
    
    if ( !is_hero_operator() )
    {
        return;
    }
    
    if ( level function_e4b91ef97fc5eb0c( #"hash_4bf6bab69fcaf7c1" ) )
    {
        return;
    }
    
    if ( !self.var_f430f45707dbee08 )
    {
        level function_2eca337ff0ec3a94( #"hash_4bf6bab69fcaf7c1", var_9f6257f0ebc7d724 );
        wait 1;
        self.var_f430f45707dbee08 = function_8c1a12974bd11f01( #"hash_6eff64f6c6c963eb", #"bc_flavor_player_positive" );
        
        if ( !self.var_f430f45707dbee08 )
        {
            level function_2eca337ff0ec3a94( #"hash_4bf6bab69fcaf7c1", 0 );
        }
        
        return;
    }
    
    if ( utility::percent_chance( 60 ) )
    {
        level function_2eca337ff0ec3a94( #"hash_4bf6bab69fcaf7c1", var_9f6257f0ebc7d724 );
        b_success = say_battlechatter( #"hash_331aeece631b84f9", undefined, undefined, 1 );
        
        if ( !b_success )
        {
            level function_2eca337ff0ec3a94( #"hash_4bf6bab69fcaf7c1", 0 );
        }
    }
}

