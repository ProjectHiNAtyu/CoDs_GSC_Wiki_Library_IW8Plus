// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ee_anvil.gsc  (hash_6b0b685c0da58967.gscc) (size: 18055 Bytes / 0x4687 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xee47e417 (3997688855)
// size ...... 18055 (0x4687)
// includes .. 16  (offset: 0x41a7)
// strings ... 61  (offset: 0x4227)
// dev strs .. 10  (offset: 0x460f)
// exports ... 37  (offset: 0x2bdb)
// cseg ...... 0x6ab + 0x2530 (0x2bdb)
// imports ... 126 (offset: 0x31a3)
// animtree1 . 0   (offset: 0x4687)
// animtree2 . 0   (offset: 0x4687)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\class;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\pack_a_punch;
#using scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_ww_quest;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_save;

#namespace zm_sat_scarab_ee_anvil;

// Namespace zm_sat_scarab_ee_anvil
// Params 0, eflags: 0x5
// Checksum 0xeb5c86ca, Offset: 0x6c9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_f70c2d942b8c5b0d", undefined, undefined, &postmain_init );
}

// Namespace zm_sat_scarab_ee_anvil
// Params 0, eflags: 0x4
// Checksum 0x50411ec3, Offset: 0x6ea
// Size: 0x26c
function private postmain_init()
{
    level.anvil_ee = zm_quest::get_quest( #"hash_2aa9778743131a7f" );
    zm_quest::register_quest_step( #"hash_2aa9778743131a7f", #"step_1", &setup_step_1, &function_61e5b348e99af311 );
    zm_quest::register_quest_step( #"hash_2aa9778743131a7f", #"step_2", &setup_step_2, &function_61e5b048e99aec78 );
    level utility::flag_wait_all( "zm_sat_scarab_ee_anvil_cs_completed", "zm_quest_initialized", "scriptables_ready", "begin_round_logic" );
    level zm_save::function_1f44a48caae2acbf();
    level function_95a1a7b1f84d1f6();
    level.anvil_ee.anvil = level.scarab_ww_quest.anvil;
    
    if ( !isdefined( level.anvil_ee.var_35d408c24f4c7250 ) )
    {
        level.anvil_ee.var_35d408c24f4c7250 = [];
    }
    
    level.anvil_ee.anvil setscriptablepartstate( "usable", "on" );
    level.anvil_ee.anvil.interaction interaction::set_interact_use_callback( &function_f95bf06f1fd45e89 );
    level.anvil_ee.anvil.interaction interaction::set_interact_hint_callback( &anvil_hint );
    level.anvil_ee.anvil.interaction.owner = undefined;
    level.anvil_ee.anvil.interaction.var_3858c302c909d413 = 0;
    level thread function_f031b2e56d3be74b();
    level callback::add( #"player_disconnect", &on_player_disconnect );
    level callback::add( #"player_death", &on_player_death );
    level callback::add( "on_round_end", &on_round_end );
    level callback::add( #"player_item_pickup", &on_pickup_item );
    level callback::add( #"player_item_drop", &function_a7d250e6835848ad );
    level callback::add( #"player_used_item", &function_5048387a2aeaf443 );
    
    /#
        level function_7fd4aa8d8772d5e5();
    #/
    
    level thread zm_quest::start_quest( #"hash_2aa9778743131a7f" );
    level.var_f2ca870da41c2821 = [ "dx_zm_sesd_est1_sslh_sesd1anvaccoff1" ];
    level.var_6d74410eea9738ac = [ "dx_zm_sesd_est1_sslh_sesd1anvcragau" ];
}

// Namespace zm_sat_scarab_ee_anvil
// Params 0, eflags: 0x4
// Checksum 0xfcaa63fa, Offset: 0x95e
// Size: 0x27
function private function_95a1a7b1f84d1f6()
{
    level utility::flag_wait( "WWQ_ASSET_INIT_COMPLETE" );
    level.scarab_ww_quest utility::ent_flag_wait( "zm_quest_completed" );
    wait 15;
}

// Namespace zm_sat_scarab_ee_anvil
// Params 0, eflags: 0x4
// Checksum 0x1f429b01, Offset: 0x98d
// Size: 0x8f
function private function_f031b2e56d3be74b()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( level.scarab_ww_quest.wonder_weapon_item || level.anvil_ee.gauntlet )
        {
            level.anvil_ee.anvil utility::function_32b24db3127bff40( "usable", "off" );
        }
        else
        {
            level.anvil_ee.anvil utility::function_32b24db3127bff40( "usable", "on" );
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 1, eflags: 0x4
// Checksum 0x3c5d3ced, Offset: 0xa24
// Size: 0x1e8
function private function_f95bf06f1fd45e89( player )
{
    if ( player && player.interactions_disabled )
    {
        return;
    }
    
    if ( level.scarab_ww_quest.wonder_weapon_item )
    {
        return;
    }
    
    if ( self.owner && self.owner != player )
    {
        return;
    }
    
    if ( self.var_3858c302c909d413 )
    {
        return;
    }
    
    if ( !getdvarint( @"hash_198acb83ff4a2f93", 0 ) )
    {
        if ( self.b_in_cd )
        {
            return;
        }
    }
    
    current_weapon = player getcurrentweapon();
    
    if ( !isdefined( current_weapon ) )
    {
        return;
    }
    
    current_weapon = current_weapon getnoaltweapon();
    
    if ( !current_weapon )
    {
        assert( 0, "<dev string:x24>" );
        return;
    }
    
    if ( weapon::iswonderweapon( current_weapon ) && !player.var_9671b56fc0ea55a9 )
    {
        return;
    }
    
    if ( class::ismeleeweapon( current_weapon ) && !player.var_9671b56fc0ea55a9 )
    {
        return;
    }
    
    if ( weapon::iskillstreakweapon( current_weapon ) && !player.var_9671b56fc0ea55a9 )
    {
        return;
    }
    
    if ( current_weapon.basename == "sat_sh_terrier_mp" && !player.var_9671b56fc0ea55a9 )
    {
        return;
    }
    
    if ( current_weapon.basename == "sat_dm_tasman_mp" && !player.var_9671b56fc0ea55a9 )
    {
        return;
    }
    
    level.anvil_ee.anvil setscriptablepartstate( "usable", "off" );
    
    if ( player.var_9671b56fc0ea55a9 )
    {
        player do_returning();
        self.owner = undefined;
        level notify( #"hash_889d92583d464708" );
    }
    else
    {
        player do_offering( current_weapon );
        self.owner = player;
        thread function_efa36b06afa00e79( player );
    }
    
    level.anvil_ee.anvil setscriptablepartstate( "usable", "on" );
}

// Namespace zm_sat_scarab_ee_anvil
// Params 2, eflags: 0x4
// Checksum 0x36909c2b, Offset: 0xc14
// Size: 0x36
function private anvil_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_scarab_ee_anvil
// Params 1
// Checksum 0x1cb60033, Offset: 0xc53
// Size: 0xd7
function do_offering( current_weapon )
{
    if ( self.var_9671b56fc0ea55a9 )
    {
        return;
    }
    
    if ( current_weapon )
    {
        var_4f25070ebe8ca61f = utility::getstruct( "ee_anvil_offer_loc", "script_noteworthy" );
        self playsoundtoplayer( "uin_zm_drop_weap", self );
        var_ba32220871dffa80 = function_2535619d314c1099( current_weapon, var_4f25070ebe8ca61f.origin, var_4f25070ebe8ca61f.angles );
        take_weapon( current_weapon );
        self.var_9671b56fc0ea55a9 = var_ba32220871dffa80;
        var_ba32220871dffa80 thread do_bob();
        level utility::flag_set( "ee_anvil_wp_on_anvil" );
        var_ba32220871dffa80 thread function_9bbed3e27f22cee6( self );
        
        if ( !utility::flag( "anvil_ee_play_first_offer_vo" ) )
        {
            level thread play_vo( var_4f25070ebe8ca61f.origin, level.var_f2ca870da41c2821 );
            utility::flag_set( "anvil_ee_play_first_offer_vo" );
        }
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 0
// Checksum 0xbe5f162f, Offset: 0xd32
// Size: 0x32
function do_returning()
{
    if ( !self.var_9671b56fc0ea55a9 )
    {
        return;
    }
    
    function_b008741a8c14cd();
    self.var_9671b56fc0ea55a9 delete();
    level utility::flag_clear( "ee_anvil_wp_on_anvil" );
}

// Namespace zm_sat_scarab_ee_anvil
// Params 1
// Checksum 0x185a1890, Offset: 0xd6c
// Size: 0x38
function function_9bbed3e27f22cee6( player )
{
    level endon( #"game_ended" );
    level endon( #"ee_anvil_wp_on_anvil" );
    player waittill( #"death_or_disconnect" );
    self delete();
}

// Namespace zm_sat_scarab_ee_anvil
// Params 1
// Checksum 0xad583014, Offset: 0xdac
// Size: 0x92
function do_consuming( player )
{
    level endon( #"game_ended" );
    player endon( #"death" );
    self.var_3858c302c909d413 = 1;
    level function_23ec21fea23547e6( player );
    player item_weapon::function_e570f94856126417( player.var_7781d04e4cb3af02.weaponobj );
    level thread do_rewarding( player );
    level zm_sat_scarab_ww_quest::function_3f203864ea2e36bc();
    self.var_3858c302c909d413 = 0;
    self.owner = undefined;
    level utility::flag_clear( "ee_anvil_wp_on_anvil" );
    thread do_cooldown();
}

// Namespace zm_sat_scarab_ee_anvil
// Params 0
// Checksum 0xefb416c5, Offset: 0xe46
// Size: 0x30
function do_cooldown()
{
    level endon( #"game_ended" );
    self.b_in_cd = 1;
    level waittill( #"round_end" );
    self.b_in_cd = 0;
}

// Namespace zm_sat_scarab_ee_anvil
// Params 1, eflags: 0x4
// Checksum 0xfcc97384, Offset: 0xe7e
// Size: 0x46d
function private do_rewarding( player )
{
    level endon( #"game_ended" );
    wait 1.1;
    
    if ( !player )
    {
        return;
    }
    
    player.var_9671b56fc0ea55a9 delete();
    var_7fb813c2ac295924 = utility::getstruct( "ee_anvil_offer_loc", "script_noteworthy" ).origin;
    player playsoundtoplayer( "evt_trail_impact", player );
    
    if ( utility::flag( "ee_anvil_do_gauntlet_rewarding" ) && getdvarint( @"hash_1339f37dad46cdfd", 0 ) )
    {
        level utility::flag_clear( "ee_anvil_do_gauntlet_rewarding" );
        owners = function_7cc7cfed5d7ba6d8();
        spawn_gauntlet( owners );
        return;
    }
    
    var_16d42a10b0c48355 = utility::getstructarray( "ee_anvil_reward_loc", "script_noteworthy" );
    var_803636f189544e2 = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarab_ee_anvil_common", "default" );
    
    for ( i = 0; i < var_803636f189544e2.size ; i++ )
    {
        if ( var_803636f189544e2[ i ] )
        {
            function_cfdb14f88fc49202();
            rwd_loc = function_50bc33792d6e9bc0( var_16d42a10b0c48355 );
            spawnoptions = spawnstruct();
            payload = [ #"teamselect", player getentitynumber() ];
            spawnoptions.payload = payload;
            item = common_item::function_47324f290423b2d1( var_803636f189544e2[ i ], var_7fb813c2ac295924, rwd_loc.origin, undefined, 1 );
            item thread do_bob();
            item.var_971e93302cc7c9db = rwd_loc;
            level.anvil_ee.var_35d408c24f4c7250[ level.anvil_ee.var_35d408c24f4c7250.size ] = item;
            wait 0.1;
        }
    }
    
    if ( player && player.var_7781d04e4cb3af02 )
    {
        var_1a35183efa8032b6 = [];
        
        switch ( player.var_7781d04e4cb3af02.rarity )
        {
            case 1:
                var_1a35183efa8032b6 = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarab_ee_anvil_aether_tool_t1", "default" );
                break;
            case 2:
                var_1a35183efa8032b6 = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarab_ee_anvil_aether_tool_t2", "default" );
                break;
            case 3:
                var_1a35183efa8032b6 = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarab_ee_anvil_aether_tool_t3", "default" );
                break;
            case 4:
                var_1a35183efa8032b6 = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarab_ee_anvil_aether_tool_t4", "default" );
                break;
            case 5:
                var_1a35183efa8032b6 = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarab_ee_anvil_aether_tool_t5", "default" );
                break;
        }
        
        for ( i = 0; i < var_1a35183efa8032b6.size ; i++ )
        {
            if ( var_1a35183efa8032b6[ i ] )
            {
                function_cfdb14f88fc49202();
                rwd_loc = function_50bc33792d6e9bc0( var_16d42a10b0c48355 );
                item = common_item::function_47324f290423b2d1( var_1a35183efa8032b6[ i ], var_7fb813c2ac295924, rwd_loc.origin, undefined, 1 );
                item thread do_bob();
                item.var_971e93302cc7c9db = rwd_loc;
                level.anvil_ee.var_35d408c24f4c7250[ level.anvil_ee.var_35d408c24f4c7250.size ] = item;
                wait 0.1;
            }
        }
        
        var_1a350b3efa80161f = [];
        
        switch ( player.var_7781d04e4cb3af02.pap_level )
        {
            case 1:
                var_1a350b3efa80161f = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarab_ee_anvil_aether_crystal_t1", "default" );
                break;
            case 2:
                var_1a350b3efa80161f = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarab_ee_anvil_aether_crystal_t2", "default" );
                break;
            case 3:
                var_1a350b3efa80161f = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarab_ee_anvil_aether_crystal_t3", "default" );
                break;
            case 4:
                var_1a350b3efa80161f = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_scarab_ee_anvil_aether_crystal_t4", "default" );
                break;
        }
        
        for ( i = 0; i < var_1a350b3efa80161f.size ; i++ )
        {
            if ( var_1a350b3efa80161f[ i ] )
            {
                function_cfdb14f88fc49202();
                rwd_loc = function_50bc33792d6e9bc0( var_16d42a10b0c48355 );
                item = common_item::function_47324f290423b2d1( var_1a350b3efa80161f[ i ], var_7fb813c2ac295924, rwd_loc.origin, undefined, 1 );
                item thread do_bob();
                item.var_971e93302cc7c9db = rwd_loc;
                level.anvil_ee.var_35d408c24f4c7250[ level.anvil_ee.var_35d408c24f4c7250.size ] = item;
                wait 0.1;
            }
        }
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 1, eflags: 0x4
// Checksum 0xb8c2d431, Offset: 0x12f3
// Size: 0x55
function private function_50bc33792d6e9bc0( var_f144346027c675dd )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        var_f96dc22ebafe5b69 = utility::array_random( var_f144346027c675dd );
        
        if ( !var_f96dc22ebafe5b69.var_e26932b14b792eb3 )
        {
            var_f96dc22ebafe5b69.var_e26932b14b792eb3 = 1;
            return var_f96dc22ebafe5b69;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 0
// Checksum 0xacdf517b, Offset: 0x1350
// Size: 0x8d
function function_cfdb14f88fc49202()
{
    if ( level.anvil_ee.var_35d408c24f4c7250.size >= 10 )
    {
        var_3ba19dcaa15a05e8 = level.anvil_ee.var_35d408c24f4c7250[ 0 ];
        
        if ( var_3ba19dcaa15a05e8 )
        {
            level.anvil_ee.var_35d408c24f4c7250 = arrayremove( level.anvil_ee.var_35d408c24f4c7250, var_3ba19dcaa15a05e8 );
            var_3ba19dcaa15a05e8.var_971e93302cc7c9db.var_e26932b14b792eb3 = 0;
            var_3ba19dcaa15a05e8 freescriptable();
        }
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 1, eflags: 0x4
// Checksum 0xaa730e7e, Offset: 0x13e5
// Size: 0x238
function private take_weapon( weap )
{
    weapstruct = spawnstruct();
    weapstruct.weaponobj = weap;
    weapstruct.clipammo = self getweaponammoclip( weap );
    
    if ( weapon::isakimbo( weap ) )
    {
        weapstruct.clipammo_l = self getweaponammoclip( weap, "left" );
    }
    
    weapstruct.stockammo = self getweaponammostock( weap );
    weapstruct.pap_level = pack_a_punch::get_pap_level( weap );
    weapstruct.rarity = item_weapon::function_fb81bd2fe070faa6( weap );
    weapstruct.ammo_mod = ammo_mod::get_ammo_mod_name( weap );
    weapstruct.basename = weap.basename;
    item_weapon::function_9e7275fa51ace996( weap, "scarabanvilee_takeweapon" );
    item_weapon::items_weapon_removeweapon( { #var_5156a93210ad2807:1, #dontdrop:1, #weapon:weap } );
    wpreplaced = undefined;
    weaplist = self getweaponslistprimaries();
    
    foreach ( wp in weaplist )
    {
        if ( wp.isalternate || wp.basename == "t10_me_diveknife_mp" || wp.basename == "t10_me_climbfists" || wp.basename == "sat_me_knife_mp" )
        {
            weaplist = arrayremove( weaplist, wp );
        }
    }
    
    if ( weaplist.size > 0 )
    {
        wpreplaced = weaplist[ 0 ];
    }
    else
    {
        dedicated_melee = self getweaponmeleeslot();
        
        if ( isdefined( dedicated_melee ) )
        {
            wpreplaced = dedicated_melee;
        }
        else
        {
            inventory_utility::_giveweapon( level.defaultfist );
            wpreplaced = level.defaultfist;
        }
    }
    
    self switchtoweaponimmediate( wpreplaced );
    weapon::fixupplayerweapons( self, wpreplaced );
    self.var_7781d04e4cb3af02 = weapstruct;
}

// Namespace zm_sat_scarab_ee_anvil
// Params 0, eflags: 0x4
// Checksum 0x96192ef, Offset: 0x1625
// Size: 0x15e
function private function_b008741a8c14cd()
{
    if ( isdefined( self ) && isdefined( self.var_7781d04e4cb3af02 ) )
    {
        weapstruct = self.var_7781d04e4cb3af02;
        self playsoundtoplayer( "uin_zm_common_pickup_item_mechanical", self );
        item_weapon::function_35910aac16378fec( weapstruct.weaponobj, weapstruct.clipammo, weapstruct.stockammo );
        item_weapon::function_d6a514964e1e7f2c( weapstruct.weaponobj );
        
        if ( weapstruct.pap_level > 0 )
        {
            pack_a_punch::function_3f3b9cdbb4843e45( weapstruct.weaponobj, weapstruct.pap_level, 1 );
        }
        
        item_weapon::function_40e1cbd0e1f47d1a( weapstruct.weaponobj, weapstruct.rarity, 1 );
        
        if ( weapstruct.ammo_mod )
        {
            ammo_mod::add_ammo_mod_to_weapon( weapstruct.weaponobj, weapstruct.ammo_mod, 1 );
        }
        
        if ( weapon::isakimbo( weapstruct.weaponobj ) && weapstruct.clipammo_l >= 0 )
        {
            self setweaponammoclip( weapstruct.weaponobj, weapstruct.clipammo_l, "left" );
        }
        
        self switchtoweaponimmediate( weapstruct.weaponobj );
        weapon::fixupplayerweapons( self, weapstruct.weaponobj );
        self.var_7781d04e4cb3af02 = undefined;
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 1, eflags: 0x4
// Checksum 0x7c3b99c, Offset: 0x178b
// Size: 0x30
function private function_efa36b06afa00e79( player )
{
    level endon( #"game_ended" );
    level endon( #"hash_889d92583d464708" );
    wait 10;
    thread do_consuming( player );
}

// Namespace zm_sat_scarab_ee_anvil
// Params 1
// Checksum 0x28a817bc, Offset: 0x17c3
// Size: 0x249
function spawn_gauntlet( players )
{
    var_81b4ed473d8c2f4f = utility::getstruct( "ee_anvil_gunlet_loc", "script_noteworthy" );
    s_weapon_bundle = getscriptbundle( %"hash_e5db3b642aea010" );
    spawnoptions = common_item::function_bc5ff2958b71a708( var_81b4ed473d8c2f4f.origin, var_81b4ed473d8c2f4f.angles );
    spawnoptions.overridepaplvl = 1;
    var_619aa3791b99968c = item_weapon::function_477bf1207c6672a5( s_weapon_bundle, spawnoptions );
    spawnoptions.weapon = pack_a_punch::function_e190a315803e2870( var_619aa3791b99968c, 1 );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.critical = 1;
    item = common_item::function_61c2c0251e742ffd( s_weapon_bundle, undefined, spawnoptions );
    item.var_9cdf6e8431d63a52 = getweaponcamoname( var_619aa3791b99968c );
    item.var_55e9f57a4e01f24c = 1;
    item thread do_bob();
    level.anvil_ee.gauntlet = item;
    
    foreach ( player in players )
    {
        spawnoptions.exclusiveowner = player;
        player playsoundtoplayer( "evt_scarab_anvil_spawn", player );
    }
    
    foreach ( p in level.players )
    {
        if ( arraycontains( players, p ) )
        {
            continue;
        }
        
        item disablescriptableplayeruse( p );
    }
    
    if ( !utility::flag( "anvil_ee_play_spawn_guantlet_vo" ) )
    {
        level thread play_vo( var_81b4ed473d8c2f4f.origin, level.var_6d74410eea9738ac );
        utility::flag_set( "anvil_ee_play_spawn_guantlet_vo" );
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 0
// Checksum 0x23c48a6b, Offset: 0x1a14
// Size: 0x135
function function_7cc7cfed5d7ba6d8()
{
    if ( !isdefined( owners ) )
    {
        owners = [];
    }
    
    max = 0;
    
    foreach ( p in level.players )
    {
        if ( p.var_5032ff9cc591da82 >= max )
        {
            max = p.var_5032ff9cc591da82;
            
            foreach ( ply in owners )
            {
                if ( ply.var_5032ff9cc591da82 < max )
                {
                    owners = arrayremove( owners, ply );
                }
            }
            
            owners[ owners.size ] = p;
        }
    }
    
    return owners;
}

// Namespace zm_sat_scarab_ee_anvil
// Params 0
// Checksum 0x3c6e81b5, Offset: 0x1b52
// Size: 0x135
function do_bob()
{
    level endon( #"hash_7ff7f16b66af8a2b" );
    self endon( #"death" );
    wait 1;
    mover = utility::spawn_model( "tag_origin", self.origin, self.angles );
    self.var_bbbd4325dfda2643 = mover;
    
    if ( isent( self ) )
    {
        self linkto( mover );
    }
    else
    {
        utility::scriptable_setparententity( mover );
    }
    
    mover.var_7fb813c2ac295924 = mover.origin;
    mover.v_end_upper = mover.origin + ( 0, 0, 1 );
    mover.v_end_lower = mover.origin + ( 0, 0, -1 );
    bob_time = 2 + randomfloatrange( -0.2, 0.2 );
    
    while ( true )
    {
        mover moveto( mover.v_end_upper, bob_time );
        mover waittill( #"movedone" );
        mover moveto( mover.v_end_lower, bob_time );
        mover waittill( #"movedone" );
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 2, eflags: 0x4
// Checksum 0x769de24a, Offset: 0x1c8f
// Size: 0x1b6
function private setup_step_1( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"hash_2aa9778743131a7f", #"hash_3f8706f58f29895e" ) == 1 )
    {
        level utility::flag_set( "ee_anvil_offer_pistol" );
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"hash_2aa9778743131a7f", #"hash_6513321c637c66e6" ) == 1 )
    {
        level utility::flag_set( "ee_anvil_offer_smg" );
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"hash_2aa9778743131a7f", #"hash_ed9af6444f69b18d" ) == 1 )
    {
        level utility::flag_set( "ee_anvil_offer_shotgun" );
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"hash_2aa9778743131a7f", #"hash_5a101e974fd681f2" ) == 1 )
    {
        level utility::flag_set( "ee_anvil_offer_ar" );
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"hash_2aa9778743131a7f", #"hash_81cbbd1c74873817" ) == 1 )
    {
        level utility::flag_set( "ee_anvil_offer_lmg" );
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"hash_2aa9778743131a7f", #"hash_5a0635974fce5482" ) == 1 )
    {
        level utility::flag_set( "ee_anvil_offer_dm" );
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"hash_2aa9778743131a7f", #"hash_6509531c63744a74" ) == 1 )
    {
        level utility::flag_set( "ee_anvil_offer_snp" );
    }
    
    if ( zm_quest::function_73720cdf21c3cfd7( #"hash_2aa9778743131a7f", #"hash_f652cf7d4f401a59" ) == 1 )
    {
        level utility::flag_set( "ee_anvil_offer_launcher" );
    }
    
    level utility::flag_wait_all( "ee_anvil_offer_pistol", "ee_anvil_offer_smg", "ee_anvil_offer_shotgun", "ee_anvil_offer_ar", "ee_anvil_offer_lmg", "ee_anvil_offer_dm", "ee_anvil_offer_snp", "ee_anvil_offer_launcher" );
    level utility::flag_set( "ee_anvil_do_gauntlet_rewarding" );
}

/#

    // Namespace zm_sat_scarab_ee_anvil
    // Params 0, eflags: 0x4
    // Checksum 0xbe780173, Offset: 0x1e4d
    // Size: 0x32, Type: dev
    function private function_7fd4aa8d8772d5e5()
    {
        zm_quest::function_bc99f123a684344f( #"hash_2aa9778743131a7f" );
        devgui::add_devgui_func( "<dev string:x3e>", "<dev string:x62>", &function_cbbc514501c16863 );
        zm_quest::function_394bdba74beda0aa();
    }

    // Namespace zm_sat_scarab_ee_anvil
    // Params 0, eflags: 0x4
    // Checksum 0x9388b440, Offset: 0x1e87
    // Size: 0x19b, Type: dev
    function private function_cbbc514501c16863()
    {
        level utility::flag_set( "<dev string:x80>" );
        zm_quest::function_4eefe6de31f5ddab( #"hash_2aa9778743131a7f", #"hash_6513321c637c66e6", 1 );
        level utility::flag_set( "<dev string:x93>" );
        zm_quest::function_4eefe6de31f5ddab( #"hash_2aa9778743131a7f", #"hash_ed9af6444f69b18d", 1 );
        level utility::flag_set( "<dev string:xaa>" );
        zm_quest::function_4eefe6de31f5ddab( #"hash_2aa9778743131a7f", #"hash_5a101e974fd681f2", 1 );
        level utility::flag_set( "<dev string:xbc>" );
        zm_quest::function_4eefe6de31f5ddab( #"hash_2aa9778743131a7f", #"hash_81cbbd1c74873817", 1 );
        level utility::flag_set( "<dev string:xcf>" );
        zm_quest::function_4eefe6de31f5ddab( #"hash_2aa9778743131a7f", #"hash_5a0635974fce5482", 1 );
        level utility::flag_set( "<dev string:xe1>" );
        zm_quest::function_4eefe6de31f5ddab( #"hash_2aa9778743131a7f", #"hash_6509531c63744a74", 1 );
        level utility::flag_set( "<dev string:xf4>" );
        zm_quest::function_4eefe6de31f5ddab( #"hash_2aa9778743131a7f", #"hash_f652cf7d4f401a59", 1 );
        
        foreach ( player in level.players )
        {
            player.var_5032ff9cc591da82 = 7;
        }
    }

#/

// Namespace zm_sat_scarab_ee_anvil
// Params 2, eflags: 0x4
// Checksum 0x7547711, Offset: 0x202a
// Size: 0x88
function private function_61e5b348e99af311( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        level utility::flag_set( "ee_anvil_offer_pistol" );
        level utility::flag_set( "ee_anvil_offer_smg" );
        level utility::flag_set( "ee_anvil_offer_shotgun" );
        level utility::flag_set( "ee_anvil_offer_ar" );
        level utility::flag_set( "ee_anvil_offer_lmg" );
        level utility::flag_set( "ee_anvil_offer_dm" );
        level utility::flag_set( "ee_anvil_offer_snp" );
        level utility::flag_set( "ee_anvil_offer_launcher" );
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 1
// Checksum 0x8728267b, Offset: 0x20ba
// Size: 0x37e
function function_23ec21fea23547e6( player )
{
    if ( player.var_7781d04e4cb3af02.pap_level <= 0 )
    {
        return;
    }
    
    if ( !player )
    {
        return;
    }
    
    if ( !isdefined( player.var_5032ff9cc591da82 ) )
    {
        player.var_5032ff9cc591da82 = 0;
    }
    
    if ( issubstr( player.var_7781d04e4cb3af02.basename, "_pi_" ) )
    {
        if ( !utility::flag( "ee_anvil_offer_pistol" ) )
        {
            level utility::flag_set( "ee_anvil_offer_pistol" );
            player.var_5032ff9cc591da82++;
            zm_quest::function_4eefe6de31f5ddab( #"hash_2aa9778743131a7f", #"hash_3f8706f58f29895e", 1 );
        }
        
        return;
    }
    
    if ( issubstr( player.var_7781d04e4cb3af02.basename, "_sm_" ) )
    {
        if ( !utility::flag( "ee_anvil_offer_smg" ) )
        {
            level utility::flag_set( "ee_anvil_offer_smg" );
            player.var_5032ff9cc591da82++;
            zm_quest::function_4eefe6de31f5ddab( #"hash_2aa9778743131a7f", #"hash_6513321c637c66e6", 1 );
        }
        
        return;
    }
    
    if ( issubstr( player.var_7781d04e4cb3af02.basename, "_sh_" ) )
    {
        if ( !utility::flag( "ee_anvil_offer_shotgun" ) )
        {
            level utility::flag_set( "ee_anvil_offer_shotgun" );
            player.var_5032ff9cc591da82++;
            zm_quest::function_4eefe6de31f5ddab( #"hash_2aa9778743131a7f", #"hash_ed9af6444f69b18d", 1 );
        }
        
        return;
    }
    
    if ( issubstr( player.var_7781d04e4cb3af02.basename, "_ar_" ) )
    {
        if ( !utility::flag( "ee_anvil_offer_ar" ) )
        {
            level utility::flag_set( "ee_anvil_offer_ar" );
            player.var_5032ff9cc591da82++;
            zm_quest::function_4eefe6de31f5ddab( #"hash_2aa9778743131a7f", #"hash_5a101e974fd681f2", 1 );
        }
        
        return;
    }
    
    if ( issubstr( player.var_7781d04e4cb3af02.basename, "_lm_" ) )
    {
        if ( !utility::flag( "ee_anvil_offer_lmg" ) )
        {
            level utility::flag_set( "ee_anvil_offer_lmg" );
            player.var_5032ff9cc591da82++;
            zm_quest::function_4eefe6de31f5ddab( #"hash_2aa9778743131a7f", #"hash_81cbbd1c74873817", 1 );
        }
        
        return;
    }
    
    if ( issubstr( player.var_7781d04e4cb3af02.basename, "_dm_" ) )
    {
        if ( !utility::flag( "ee_anvil_offer_dm" ) )
        {
            level utility::flag_set( "ee_anvil_offer_dm" );
            player.var_5032ff9cc591da82++;
            zm_quest::function_4eefe6de31f5ddab( #"hash_2aa9778743131a7f", #"hash_5a0635974fce5482", 1 );
        }
        
        return;
    }
    
    if ( issubstr( player.var_7781d04e4cb3af02.basename, "_sn_" ) )
    {
        if ( !utility::flag( "ee_anvil_offer_snp" ) )
        {
            level utility::flag_set( "ee_anvil_offer_snp" );
            player.var_5032ff9cc591da82++;
            zm_quest::function_4eefe6de31f5ddab( #"hash_2aa9778743131a7f", #"hash_6509531c63744a74", 1 );
        }
        
        return;
    }
    
    if ( issubstr( player.var_7781d04e4cb3af02.basename, "_la_" ) )
    {
        if ( !utility::flag( "ee_anvil_offer_launcher" ) )
        {
            level utility::flag_set( "ee_anvil_offer_launcher" );
            player.var_5032ff9cc591da82++;
            zm_quest::function_4eefe6de31f5ddab( #"hash_2aa9778743131a7f", #"hash_f652cf7d4f401a59", 1 );
        }
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 2, eflags: 0x4
// Checksum 0x52268f77, Offset: 0x2440
// Size: 0x21
function private setup_step_2( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 2, eflags: 0x4
// Checksum 0x2f5175d1, Offset: 0x2469
// Size: 0x172
function private function_61e5b048e99aec78( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        if ( !getdvarint( @"hash_1339f37dad46cdfd", 0 ) )
        {
            return;
        }
        
        if ( b_save_restored )
        {
            level thread function_4d57c618a04b583b();
            return;
        }
        
        var_b64a686a60cda13d = 1;
        
        foreach ( p in level.players )
        {
            weaplist = p getweaponslistprimaries();
            
            foreach ( wp in weaplist )
            {
                if ( wp.basename == "sat_ww_firefly_zm" )
                {
                    var_b64a686a60cda13d = 0;
                    break;
                }
            }
        }
        
        if ( var_b64a686a60cda13d )
        {
            spawn_gauntlet( level.players );
            level utility::flag_clear( "ee_anvil_do_gauntlet_rewarding" );
        }
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 0, eflags: 0x4
// Checksum 0x3c1f15c8, Offset: 0x25e3
// Size: 0x161
function private function_4d57c618a04b583b()
{
    level zm_save::function_1f44a48caae2acbf();
    level utility::flag_wait( "begin_round_logic" );
    var_b64a686a60cda13d = 1;
    
    foreach ( p in level.players )
    {
        weaplist = p getweaponslistprimaries();
        
        foreach ( wp in weaplist )
        {
            if ( wp.basename == "sat_ww_firefly_zm" )
            {
                var_b64a686a60cda13d = 0;
                break;
            }
        }
    }
    
    if ( var_b64a686a60cda13d )
    {
        while ( isdefined( level.scarab_ww_quest.wonder_weapon_item ) )
        {
            waitframe();
        }
        
        spawn_gauntlet( level.players );
        level utility::flag_clear( "ee_anvil_do_gauntlet_rewarding" );
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 1
// Checksum 0x4b9309ee, Offset: 0x274c
// Size: 0x175
function on_pickup_item( params )
{
    if ( params.itembundle.baseweapon == "sat_ww_firefly_zm" && self != level.var_b8f3dfaff402a0a9 )
    {
        level.var_b8f3dfaff402a0a9 = params.player;
    }
    
    if ( params.item.var_bbbd4325dfda2643 )
    {
        if ( params.item && !isent( params.item ) && params.item isscriptableinstance() )
        {
            params.item utility::scriptable_clearparententity();
        }
        
        params.item.var_bbbd4325dfda2643 delete();
    }
    
    if ( params.item.var_971e93302cc7c9db )
    {
        params.item.var_971e93302cc7c9db.var_e26932b14b792eb3 = 0;
    }
    
    if ( isarray( level.anvil_ee.var_35d408c24f4c7250 ) && arraycontains( level.anvil_ee.var_35d408c24f4c7250, params.item ) )
    {
        level.anvil_ee.var_35d408c24f4c7250 = arrayremove( level.anvil_ee.var_35d408c24f4c7250, params.item );
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 1, eflags: 0x4
// Checksum 0x60a602ea, Offset: 0x28c9
// Size: 0xc2
function private function_5048387a2aeaf443( params )
{
    if ( params.item.var_55e9f57a4e01f24c && isnumber( params.item.var_951c89546ec50477 ) && params.item.var_951c89546ec50477 > 0 && !self function_13c842a7e0d8ff64() )
    {
        params.item.weaponobj = pack_a_punch::function_e190a315803e2870( params.item.weaponobj, params.item.var_951c89546ec50477, undefined, params.item.var_9cdf6e8431d63a52 );
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 1
// Checksum 0x805b1b44, Offset: 0x2993
// Size: 0x43
function function_a7d250e6835848ad( params )
{
    if ( params.itembundle.baseweapon == "sat_ww_firefly_zm" && self == level.var_b8f3dfaff402a0a9 )
    {
        level.var_b8f3dfaff402a0a9 = undefined;
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 1
// Checksum 0x17a8392b, Offset: 0x29de
// Size: 0xb7
function on_player_death( params )
{
    if ( self == level.var_b8f3dfaff402a0a9 )
    {
        weaplist = self getweaponslistprimaries();
        
        foreach ( weap in weaplist )
        {
            if ( weap.basename == "sat_ww_firefly_zm" )
            {
                spawn_gauntlet( level.players );
                return;
            }
        }
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 1
// Checksum 0x4221cc66, Offset: 0x2a9d
// Size: 0x2a
function on_player_disconnect( params )
{
    if ( self == level.var_b8f3dfaff402a0a9 )
    {
        spawn_gauntlet( level.players );
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 1
// Checksum 0x4226583f, Offset: 0x2acf
// Size: 0x18
function on_round_end( params )
{
    level notify( #"round_end" );
}

// Namespace zm_sat_scarab_ee_anvil
// Params 2
// Checksum 0x8974babd, Offset: 0x2aef
// Size: 0xcd
function play_vo( v_pos, var_9edba246be039c91 )
{
    e_vo_source = utility::spawn_model( "tag_origin", v_pos );
    e_vo_source thread function_facc91eeae3df558();
    
    foreach ( player in level.players )
    {
        var_fc9b3886c46fd13a = utility::array_random( var_9edba246be039c91 );
        
        if ( var_fc9b3886c46fd13a && player )
        {
            player playsoundtoplayer( var_fc9b3886c46fd13a, player, e_vo_source );
        }
    }
}

// Namespace zm_sat_scarab_ee_anvil
// Params 0
// Checksum 0x69cba092, Offset: 0x2bc4
// Size: 0x17
function function_facc91eeae3df558()
{
    level endon( #"game_ended" );
    wait 5;
    self delete();
}

