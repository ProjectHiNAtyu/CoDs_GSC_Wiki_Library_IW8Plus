// scripts\mp\common\perks\zombie\perk_vulture_aid.gsc  (hash_1ed5c8921b4c1572.gscc) (size: 4324 Bytes / 0x10e4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7d3cfc67 (2101148775)
// size ...... 4324 (0x10e4)
// includes .. 7   (offset: 0xf98)
// strings ... 16  (offset: 0xfd0)
// dev strs .. 0   (offset: 0x10e4)
// exports ... 12  (offset: 0x908)
// cseg ...... 0x1cb + 0x73d (0x908)
// imports ... 42  (offset: 0xae8)
// animtree1 . 0   (offset: 0x10e4)
// animtree2 . 0   (offset: 0x10e4)
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\currency;
#using scripts\mp\loot\common_item;

#namespace perk_vulture_aid;

// Namespace perk_vulture_aid
// Params 0, eflags: 0x5
// Checksum 0x543f6f3d, Offset: 0x1e9
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "specialty_vulture_aid", undefined, &__init__, undefined );
}

// Namespace perk_vulture_aid
// Params 0, eflags: 0x1
// Checksum 0xa4e15e8d, Offset: 0x206
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_86f88f5c5daaefd5 );
}

// Namespace perk_vulture_aid
// Params 0
// Checksum 0x6adea57d, Offset: 0x226
// Size: 0xa
function __init__()
{
    level thread perk_vulture_aid_init();
}

// Namespace perk_vulture_aid
// Params 1
// Checksum 0xd0fb214f, Offset: 0x238
// Size: 0x5e
function function_86f88f5c5daaefd5( params )
{
    bundle = level.perkbundles[ "specialty_vulture_aid" ];
    
    if ( !bundle )
    {
        return;
    }
    
    if ( isfunction( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_vulture_aid", &give_vulture_aid_perk, &function_d73562237bebfda7 );
    }
}

// Namespace perk_vulture_aid
// Params 0
// Checksum 0x278cdca1, Offset: 0x29e
// Size: 0xd5
function perk_vulture_aid_init()
{
    if ( !level.zombie_perks_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level utility::flag_init( "specialty_vulture_aid" + "init_complete" );
    level._effect[ "vulture_aid_m_attack_fx" ] = loadfxasset( "vfx_t10_gameplay_zm_a_mod_attack" );
    level utility::flag_wait_all( "StartGameTypeCallbackFinished", "zombie_perks_init_complete" );
    str_currency = currency::get_perk_machine_currency( "specialty_vulture_aid" );
    var_fcb7626c79b3c98f = currency::get_perk_machine_cost( "specialty_vulture_aid" );
    level thread zombie_perks::enable_perk_for_level( "specialty_vulture_aid", str_currency, var_fcb7626c79b3c98f, &give_vulture_aid_perk, &function_d73562237bebfda7 );
    callback::add( "on_zombie_ai_killed", &function_ad230a47a7aa7f54 );
    level utility::flag_set( "specialty_vulture_aid" + "init_complete" );
    scriptable::scriptable_addnotifycallback( "vulture_aid_attack", &function_d0d1546369c08275 );
}

// Namespace perk_vulture_aid
// Params 0
// Checksum 0xe921caea, Offset: 0x37b
// Size: 0x9
function give_vulture_aid_perk()
{
    function_761bccfac9a60012();
}

// Namespace perk_vulture_aid
// Params 4
// Checksum 0xbbf31754, Offset: 0x38c
// Size: 0x2e
function function_d73562237bebfda7( var_d93428f5ff5cb05d, str_perk, str_result, var_e97a4f4962bc3f25 )
{
    function_a2ad222cee640ae0();
}

// Namespace perk_vulture_aid
// Params 0
// Checksum 0x803bda56, Offset: 0x3c2
// Size: 0x1a
function function_761bccfac9a60012()
{
    zombie_perks::function_5d65c3d58cc084ec( "specialty_vulture_aid" );
    callback::callback( "give_vulture_aid" );
}

// Namespace perk_vulture_aid
// Params 0
// Checksum 0x72a0c94a, Offset: 0x3e4
// Size: 0xe
function function_a2ad222cee640ae0()
{
    zombie_perks::function_25539251d02082( "specialty_vulture_aid" );
}

// Namespace perk_vulture_aid
// Params 1
// Checksum 0x43ae5cb4, Offset: 0x3fa
// Size: 0x38e
function function_ad230a47a7aa7f54( params )
{
    if ( !isagent( self ) || !isalive( params.eattacker ) )
    {
        return;
    }
    
    if ( !params.eattacker zombie_perks::has_perk( "specialty_vulture_aid" ) )
    {
        return;
    }
    
    if ( self.var_a13bed1ac47e1b2c || self.b_in_spawn_closet )
    {
        return;
    }
    
    vulture_droplist = level.perkbundles[ "specialty_vulture_aid" ].vulturedroplist;
    var_c92b26bb941461fe = utility::percent_chance( level.perkbundles[ "specialty_vulture_aid" ].var_c30ee4a155a9ea2f ?? 50 );
    var_149193b37ce2e826 = level.perkbundles[ "specialty_vulture_aid" ].var_91a690d121868494 ?? 0.2;
    
    if ( isdefined( vulture_droplist ) && isalive( params.eattacker ) && var_c92b26bb941461fe )
    {
        spawn_options = common_item::items_initspawnoptions_spawnfromposition( self.var_5e0be30a5816a64d, self.angles );
        spawn_options.dropradiusscale = var_149193b37ce2e826;
        spawn_options.var_4a4b419f66681601 = [ params.eattacker ];
        spawn_options.var_c580c0e8b49f1fcc = 1;
        item = params.eattacker common_item::function_38cde6a6acb68ea6( vulture_droplist, 1, spawn_options );
        
        if ( isarray( item ) && isdefined( item[ 0 ] ) )
        {
            item[ 0 ].owner = params.eattacker;
            primary_weapons = item[ 0 ].owner getweaponslistprimaries();
            
            if ( isdefined( item[ 0 ].type ) && isstartstr( item[ 0 ].type, "zmloot_ammo_vultureaid" ) )
            {
                item[ 0 ].var_1a82ea81e4335d1a = level.perkbundles[ "specialty_vulture_aid" ].var_2d64a284f5d01b3 ?? 0.01;
                item[ 0 ].ammo_percent_override = level.perkbundles[ "specialty_vulture_aid" ].var_1e6478f8c295ebc1 ?? 0.2;
                item[ 0 ].var_c1fccb53c0121a8 = level.perkbundles[ "specialty_vulture_aid" ].var_29d3f6d82bdaf5da ?? 0.05;
                item[ 0 ].var_280e80414af5cabd = level.perkbundles[ "specialty_vulture_aid" ].var_52f01cd4c0642093 ?? 0;
                item[ 0 ].var_319af4bdf57f5b2f = level.perkbundles[ "specialty_vulture_aid" ].var_d3895eb3e671a871 ?? 1;
                
                if ( params.eattacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"vulture_aid_parting_gift" ) )
                {
                    item[ 0 ].var_1a82ea81e4335d1a = level.zombie_augments[ #"vulture_aid_parting_gift" ].var_6406bc09d53992e7 ?? 0.01;
                }
            }
        }
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_714e4483f900e0b8" ) )
    {
        var_20a9d5ca930e86e1 = [ "equip_grappling_hook", "equip_grappling_hook_upgraded" ];
        params.var_20a9d5ca930e86e1 = var_20a9d5ca930e86e1;
        utility::callsharedfunc( #"zombie", #"hash_714e4483f900e0b8", params );
    }
}

// Namespace perk_vulture_aid
// Params 4
// Checksum 0x85be4a09, Offset: 0x790
// Size: 0x178
function function_d0d1546369c08275( instance, note, param, var_64ffacba090c91be )
{
    triggermaxsize = 80;
    position = instance.entity gettagorigin( "tag_hint" ) + anglestoforward( instance.entity.angles ) * 20;
    ai_array = getaiarrayinradius( position, triggermaxsize, "team_two_hundred" );
    
    foreach ( ai in ai_array )
    {
        if ( isalive( ai ) && isagent( ai ) )
        {
            if ( ai.aicategory == "normal" )
            {
                ai.forceannihilate = 1;
                ai dodamage( ai.health, position, undefined, undefined, "MOD_MELEE" );
                continue;
            }
            
            ai dodamage( ai.health * 0.2, position, undefined, undefined, "MOD_MELEE" );
        }
    }
    
    waitframe();
    playfx( level._effect[ "vulture_aid_m_attack_fx" ], position );
}

