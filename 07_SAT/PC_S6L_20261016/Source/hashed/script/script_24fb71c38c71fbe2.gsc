// script_24fb71c38c71fbe2  (hash_24fb71c38c71fbe2.gscc) (size: 4164 Bytes / 0x1044)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x866ec08d (2255405197)
// size ...... 4164 (0x1044)
// includes .. 0   (offset: 0xdf8)
// strings ... 43  (offset: 0xdf8)
// dev strs .. 0   (offset: 0x1044)
// exports ... 12  (offset: 0xa3c)
// cseg ...... 0x567 + 0x4d5 (0xa3c)
// imports ... 12  (offset: 0xc1c)
// animtree1 . 0   (offset: 0x1044)
// animtree2 . 0   (offset: 0x1044)
#namespace assets;

// Namespace assets
// Params 0
// Checksum 0x95497d63, Offset: 0x585
// Size: 0x2
function main()
{
    
}

// Namespace assets
// Params 1
// Checksum 0x8d2a3037, Offset: 0x58f
// Size: 0x9b
function setup_asset( unit_type )
{
    switch ( unit_type )
    {
        case #"hash_44aaeb0edd152195":
            soldier();
            return;
        case #"hash_e87767df2e5c3a68":
            civilian();
            return;
        case #"hash_f4a90c6c03d32ee9":
            dog();
            return;
        case #"hash_4ad475e6e15635bd":
            juggernaut();
            return;
        case #"hash_1403dfb5d1265ddc":
            suicidebomber();
            return;
        case #"hash_f695947f7a9ce23f":
            zombie();
            return;
        default:
            return;
    }
}

// Namespace assets
// Params 0
// Checksum 0x5572910c, Offset: 0x632
// Size: 0x144
function soldier()
{
    if ( !function_245186af488799a1( "soldier" ) )
    {
        level._effect[ "npc_flashlight" ] = loadfxasset( "vfx_iw9_core_flashlight_npc_nolight" );
        level._effect[ "npc_flashlight_flare" ] = loadfxasset( "vfx_iw9_core_flashlight_npc" );
        precachemodel( "attachment_wm_tac_light_held" );
        precachemodel( "offhand_wm_smartphone_on" );
        precachemodel( "p7_bottle_plastic_16oz_water" );
        precachemodel( "cp_disco_folding_chair_lod0" );
        precachemodel( "weapon_wm_pi_mike1911_phys" );
        precachemodel( "misc_cigarette_01_centered" );
        precachemodel( "misc_wm_blackbox_laptop" );
        level.g_effect[ "cellphone_glow" ] = loadfxasset( "vfx_iw7_levels_piccadilly_pic_phone_light_01" );
        level.g_effect[ "cigarette_lit" ] = loadfxasset( "vfx_iw8_char_cigarette_lit_hand_01" );
        level.g_effect[ "cigarette_lit_toss" ] = loadfxasset( "vfx_iw8_char_cigarette_lit_hand_01_toss" );
        level.g_effect[ "cigarette_unlit" ] = loadfxasset( "vfx_iw8_char_cigarette_unlit_hand_01" );
        level.g_effect[ "lighter_glow" ] = loadfxasset( "vfx_iw8_char_cigarette_lighter_glow_hand_01" );
        level.g_effect[ "cigarette_smoke" ] = loadfxasset( "vfx_iw8_char_cigarette_smoke_blow_01" );
        level._effect[ "crawling_death_blood_smear" ] = loadfxasset( "vfx_core_impacts_blood_smear_decal" );
        register_ai_assets( "soldier" );
    }
}

// Namespace assets
// Params 0
// Checksum 0xa64a944d, Offset: 0x77e
// Size: 0x2
function civilian()
{
    
}

// Namespace assets
// Params 0
// Checksum 0xab4d897a, Offset: 0x788
// Size: 0x2
function dog()
{
    
}

// Namespace assets
// Params 0
// Checksum 0x25d2b805, Offset: 0x792
// Size: 0x7e
function juggernaut()
{
    if ( !function_245186af488799a1( "juggernaut" ) )
    {
        if ( !isdefined( level.g_effect ) )
        {
            level.g_effect = [];
        }
        
        level._effect[ "npc_flashlight" ] = loadfxasset( "vfx_iw9_core_flashlight_npc_nolight" );
        level._effect[ "npc_flashlight_flare" ] = loadfxasset( "vfx_iw9_core_flashlight_npc" );
        level._effect[ "crawling_death_blood_smear" ] = loadfxasset( "vfx_core_impacts_blood_smear_decal" );
        register_ai_assets( "juggernaut" );
    }
}

// Namespace assets
// Params 0
// Checksum 0xc3031f03, Offset: 0x818
// Size: 0x95
function suicidebomber()
{
    if ( !function_245186af488799a1( "suicidebomber" ) )
    {
        precachemodel( "offhand_wm_clacker" );
        
        if ( isdismembermentenabled() )
        {
            level.g_effect[ "vfx_suicide_bomber_gib_explode" ] = loadfxasset( "vfx_iw8_weap_explo_suicide_bomb" );
        }
        else
        {
            level.g_effect[ "vfx_suicide_bomber_gib_explode" ] = loadfxasset( "vfx_core_blank" );
        }
        
        level.g_effect[ "vfx_suicide_bomber_no_dismember" ] = loadfxasset( "vfx_iw8_weap_explo_frag_gren" );
        level._effect[ "suicide_bomber_clicker_flash" ] = loadfxasset( "vfx_requests_piccadilly_suicide_bomber_clicker_flash" );
        register_ai_assets( "suicidebomber" );
    }
}

// Namespace assets
// Params 0
// Checksum 0x337830f7, Offset: 0x8b5
// Size: 0x1d
function zombie()
{
    if ( !function_245186af488799a1( "zombie" ) )
    {
        register_ai_assets( "zombie" );
    }
}

// Namespace assets
// Params 1
// Checksum 0xda6c2d06, Offset: 0x8da
// Size: 0x75
function register_ai_assets( type )
{
    if ( !isdefined( level.var_7169fff0a2555824 ) )
    {
        level.var_7169fff0a2555824 = [];
    }
    
    switch ( type )
    {
        case #"hash_1403dfb5d1265ddc":
        case #"hash_44aaeb0edd152195":
        case #"hash_4ad475e6e15635bd":
            function_47eba94c33d7bf85();
            break;
        default:
            break;
    }
    
    level.var_7169fff0a2555824[ type ] = 1;
}

// Namespace assets
// Params 1
// Checksum 0xcf5040d2, Offset: 0x957
// Size: 0x26, Type: bool
function function_245186af488799a1( type )
{
    return isdefined( level.var_7169fff0a2555824 ) && level.var_7169fff0a2555824[ type ];
}

// Namespace assets
// Params 0
// Checksum 0x4832ebe7, Offset: 0x986
// Size: 0xb6
function function_47eba94c33d7bf85()
{
    if ( isdefined( level.g_effect[ "human_gib_fullbody" ] ) )
    {
        return;
    }
    
    if ( isdismembermentenabled() )
    {
        level.g_effect[ "human_gib_fullbody" ] = loadfxasset( "vfx_iw8_weap_explo_suicide_gib_dir1" );
        level.g_effect[ "human_gib_head" ] = loadfxasset( "vfx_iw8_weap_impact_flesh_fatal_head_med_dismb" );
        level.g_effect[ "human_gib_head_cap" ] = loadfxasset( "vfx_iw8_weap_impact_flesh_dismemberment_head_cap" );
        return;
    }
    
    level.g_effect[ "human_gib_fullbody" ] = loadfxasset( "vfx_core_blank" );
    level.g_effect[ "human_gib_head" ] = loadfxasset( "vfx_core_blank" );
    level.g_effect[ "human_gib_head_cap" ] = loadfxasset( "vfx_core_blank" );
}

