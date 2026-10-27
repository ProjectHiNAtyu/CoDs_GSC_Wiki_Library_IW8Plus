// scripts\mp\zm\gametypes\zm_rb_rh_mod.gsc  (hash_7c2657941e2192b4.gscc) (size: 1340 Bytes / 0x53c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x232eb2bf (590262975)
// size ...... 1340 (0x53c)
// includes .. 4   (offset: 0x4ec)
// strings ... 4   (offset: 0x50c)
// dev strs .. 0   (offset: 0x53c)
// exports ... 5   (offset: 0x308)
// cseg ...... 0xdd + 0x22b (0x308)
// imports ... 10  (offset: 0x3d0)
// animtree1 . 0   (offset: 0x53c)
// animtree2 . 0   (offset: 0x53c)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\currency;

#namespace zm_rb_rh_mod;

// Namespace zm_rb_rh_mod
// Params 0, eflags: 0x5
// Checksum 0x6806a62c, Offset: 0xfb
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_rb_rh_mod", undefined, &preinit, undefined );
}

// Namespace zm_rb_rh_mod
// Params 0
// Checksum 0x2fc10369, Offset: 0x11c
// Size: 0x49
function preinit()
{
    utility::registersharedfunc( #"zm_rb_rh_mod", #"main", &main );
    utility::flag_set( "zm_rb_rh_mod_initialized" );
    level._effect[ #"gun_disappear" ] = loadfxasset( "vfx_t10_gameplay_zm_magic_box_bunny_rarity_white_disappear" );
}

// Namespace zm_rb_rh_mod
// Params 0
// Checksum 0x8e9f47a0, Offset: 0x16d
// Size: 0x20
function main()
{
    utility::registersharedfunc( #"perk_machine", #"hash_e863dfdfdb696446", &function_98693801f9b82fe3 );
}

// Namespace zm_rb_rh_mod
// Params 4
// Checksum 0x16b84e15, Offset: 0x195
// Size: 0x172
function function_98693801f9b82fe3( usable, perk_root, var_4c22addfe5b4f20e, hint_data )
{
    level.var_ea5fb2ecb092a34e = 1;
    var_4c22addfe5b4f20e = zombie_perks::function_77331fd62580dd0a();
    level.var_ea5fb2ecb092a34e = 0;
    
    if ( currency::can_afford( currency::get_perk_machine_currency( usable.script_notify ), var_4c22addfe5b4f20e ) )
    {
        hint_data.aux_text = undefined;
        hint_data.interactable = 1;
        hint_data.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE";
    }
    else
    {
        hint_data.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
        hint_data.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE_NOT_ENOUGH";
        hint_data.interactable = 0;
    }
    
    override_data = { #interactable:hint_data.interactable, #aux_text:hint_data.aux_text, #icon_text_value:var_4c22addfe5b4f20e, #var_776a268784e089af:hint_data.var_776a268784e089af, #buttoncallout:hint_data.buttoncallout, #icon:"jup_ui_map_icon_mr_peeks", #description:&"hash_6b18695f1ec678d6", #title:&"hash_d48c758412396b", #type:"HINT_BUTTON" };
    return override_data;
}

