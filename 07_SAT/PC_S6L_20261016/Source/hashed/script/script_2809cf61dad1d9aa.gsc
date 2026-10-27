// script_2809cf61dad1d9aa  (hash_2809cf61dad1d9aa.gscc) (size: 46842 Bytes / 0xb6fa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x815c5e27 (2170314279)
// size ...... 46842 (0xb6fa)
// includes .. 33  (offset: 0xab36)
// strings ... 148 (offset: 0xac3e)
// dev strs .. 18  (offset: 0xb606)
// exports ... 123 (offset: 0x6e66)
// cseg ...... 0xb84 + 0x62e2 (0x6e66)
// imports ... 316 (offset: 0x819e)
// animtree1 . 0   (offset: 0xb6fa)
// animtree2 . 0   (offset: 0xb6fa)
#using script_236edd51aea4c314;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\interactive_notes;
#using scripts\common\math;
#using scripts\common\puzzles\frequency_matching_puzzle;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\field_upgrades\field_upgrades_wiley_fox;
#using scripts\mp\common\killstreaks\white_phosphorus;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\damage;
#using scripts\mp\ent_manager;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\scripted_weapons;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_wunderbarrage;
#using scripts\mp\zm\systems\weapons\zm_damage;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace namespace_179a60483790d55e;

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x5
// Checksum 0xf51723ca, Offset: 0xba2
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_d1612ed5d50da819", #"zm_quest", &pre_main, &post_main );
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x6f5b24cc, Offset: 0xbcf
// Size: 0x29a
function private pre_main()
{
    level.var_41a9e596c74a0cf8 = { #var_ae1f10f1861dfc53:getdvarfloat( @"hash_e4d338dc14987c18", 60 ), #var_66d4a6fad90da8b8:getdvarfloat( @"hash_f8681b1a5be66cd1", 30 ), #shock_stick_duration:getdvarfloat( @"hash_25cc31ab1e5cfa0e", 5 ), #var_299cdcaa0733a3e6:getdvarfloat( @"hash_a9438d5ce262d920", 60 ), #var_1b5cc3c51eeeb7ae:getdvarfloat( @"hash_9730878e31a50cf0", 10 ), #var_68a50ba962899ecb:getdvarfloat( @"hash_faef023a0ca2f05", 60 ), #psych_duration:getdvarfloat( @"hash_8a0ca9051dc254bc", 10 ), #psych_radius:getdvarint( @"hash_4c6dc68fb3283c50", 192 ), #var_c7a084f83b8b0408:getdvarfloat( @"hash_c4e76185bafdd40a", 8 ), #var_3b5a3ebf3f26501d:getdvarfloat( @"hash_92fe1fddd98b47f7", 45 ), #var_c8d0f8135a134d40:0 };
    
    if ( !getdvarint( @"enable_locust_mq", 0 ) )
    {
        return;
    }
    
    zm_quest::register_quest_step( #"hash_d1612ed5d50da819", #"access_lighthouse", &function_7d6d613ab952c071, &function_60062348e78b78d6 );
    zm_quest::register_quest_step( #"hash_d1612ed5d50da819", #"collect_crowbar", &function_7d6d5e3ab952b9d8, &function_60062248e78b76a3 );
    zm_quest::register_quest_step( #"hash_d1612ed5d50da819", #"hash_85e38cf4f364aeb8", &function_7d6d5f3ab952bc0b, &function_60062148e78b7470 );
    zm_quest::register_quest_step( #"hash_d1612ed5d50da819", #"fire_aa_gun", &function_7d6d643ab952c70a, &function_60062848e78b83d5 );
    zm_quest::register_quest_step( #"hash_d1612ed5d50da819", #"collect_transmitter", &function_7d6d653ab952c93d, &function_60062748e78b81a2 );
    zm_quest::register_quest_step( #"hash_d1612ed5d50da819", #"install_transmitter", &function_7d6d623ab952c2a4, &function_60062648e78b7f6f );
    zm_quest::register_quest_step( #"hash_d1612ed5d50da819", #"radio_tower_holdout", &function_7d6d633ab952c4d7, &function_60062548e78b7d3c );
    zm_quest::register_quest_step( #"hash_d1612ed5d50da819", #"melt_ascender", &function_20d1719df0abff1b, &function_a2cc1969a5b41b08 );
    zm_quest::register_quest_step( #"hash_d1612ed5d50da819", #"hash_cba58ffc1e721b8a", &function_20d1729df0ac014e, &function_a2cc1c69a5b421a1 );
    zm_quest::register_quest_step( #"hash_d1612ed5d50da819", #"hash_6a77ae0bb51c81c", &function_20d1739df0ac0381, &function_a2cc1b69a5b41f6e );
    zm_quest::register_quest_step( #"hash_d1612ed5d50da819", #"collect_wb", &function_7d6d583ab952aca6, &function_60062c48e78b8ca1 );
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0xac54bc66, Offset: 0xe71
// Size: 0x98
function private post_main()
{
    level thread function_914ccbd0ea9c9215();
    level thread function_ebfa00c9aea86f13();
    level thread function_f37a346f98a5d5ec();
    level thread function_aa51706f88c55842();
    level thread function_3dfba7d01cd447e2();
    
    if ( !getdvarint( @"enable_locust_mq", 0 ) )
    {
        return;
    }
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level thread function_197b8a55db852955();
    level thread function_8c040619ebdc447e();
    level thread function_e80a8dfb3d5d818d();
    level thread function_8bf80bc9fe07a28b();
    zm_save::function_1f44a48caae2acbf();
    utility::flag_wait( "onStartGameTypeFinished" );
    
    /#
        debug_init();
    #/
    
    level thread zm_quest::start_quest( #"hash_d1612ed5d50da819" );
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x13b81566, Offset: 0xf11
// Size: 0x35
function private function_197b8a55db852955()
{
    level endon( #"mq_rm_core" );
    utility::flag_wait( "pap_step_12" );
    wait 60;
    zm_sat_locust_util::function_a8b578b47e763d0f( "dx_zm_lomn_1rrt_typa_ml1rbrprq" );
    utility::flag_set( "tyr_request_1" );
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0xa8bc1273, Offset: 0xf4e
// Size: 0xd1
function private function_8c040619ebdc447e()
{
    utility::flag_wait( "scriptables_ready" );
    loc = utility::getstruct( "mqmi_crba" );
    asset = zm_sat_locust_util::get_quest_item_ref( %"zmloot_sat_locust_quest_bertram" );
    params = { #spawntype:#"spawn_at_pos", #spawnangles:loc.angles, #spawnorigin:loc.origin, #asset:asset };
    item = zm_sat_locust_util::spawn_quest_item( params );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        item setscriptablepartstate( item function_84ad2f70189ee7c3(), #"visible_not_usable" );
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_e1b204b85412e1fb", item );
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0xccb71cd9, Offset: 0x1027
// Size: 0x3dc
function private function_914ccbd0ea9c9215()
{
    utility::add_fx( "psych_grenade", "vfx_sat_core_equip_gas_grenade" );
    utility::flag_wait( "scriptables_ready" );
    manifest_loc = utility::getstruct( "mqmi_no_ma", "targetname" );
    data = interactive_notes::create_note_data( "zm_locust_foundry_cargo_manifest", "interactive_note_paper_secret" );
    manifest = interactive_notes::spawn_note( data, manifest_loc.origin, manifest_loc.angles );
    hint_locs = utility::getstructarray( "mqmi_no_lo", "targetname" );
    var_2b1b67d02bc41fa = utility::array_random( hint_locs );
    types = [ "shell", "experiment", "gas", "robot" ];
    swap_idx = randomint( 4 );
    
    switch ( swap_idx )
    {
        case 0:
            data = interactive_notes::create_note_data( "zm_locust_swap_none", "interactive_note_paper_secret" );
            contents = [ "shell", "experiment", "gas", "robot" ];
            break;
        case 1:
            data = interactive_notes::create_note_data( "zm_locust_swap_experiment", "interactive_note_paper_secret" );
            contents = [ "experiment", "shell", "gas", "robot" ];
            break;
        case 2:
            data = interactive_notes::create_note_data( "zm_locust_swap_toxic", "interactive_note_paper_secret" );
            contents = [ "gas", "experiment", "shell", "robot" ];
            break;
        case 3:
            data = interactive_notes::create_note_data( "zm_locust_swap_robot", "interactive_note_paper_secret" );
            contents = [ "robot", "experiment", "gas", "shell" ];
            break;
    }
    
    hint = interactive_notes::spawn_note( data, var_2b1b67d02bc41fa.origin, var_2b1b67d02bc41fa.angles );
    zm_sat_locust_util::function_295a36ef38f5acae( #"aa_shell_hint", hint );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        hint_text = utility::callsharedfunc( #"directed_mode", #"get_interact_func", #"hash_615dfad92a4b326b" );
    }
    
    crates = [];
    locs = utility::getstructarray( "mqmi_cr_lo" );
    locs = arrayrandomize( locs );
    
    foreach ( idx, loc in locs )
    {
        origin = loc.origin;
        angles = loc.angles;
        crate = spawnscriptable( %"sat_zm_prop_roscoe_cargo", ( round( origin[ 0 ] ), round( origin[ 1 ] ), round( origin[ 2 ] ) ), angleclamp180( angles ) );
        interaction::register_scriptable_interact( crate, &function_f48a86467293e5d1, undefined, undefined, hint_text );
        crate.visible_type = types[ idx ];
        crate.contents = contents[ idx ];
        crate setscriptablepartstate( #"body", crate.visible_type );
        crates[ crates.size ] = crate;
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_66bc71bf51846d35", crates );
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0xd208f022, Offset: 0x140b
// Size: 0x11d
function private function_f48a86467293e5d1( player )
{
    if ( !utility::flag( "mq_rm_step_02" ) )
    {
        return;
    }
    
    if ( !level.var_41a9e596c74a0cf8.var_c8d0f8135a134d40 && self.contents != "shell" )
    {
        level.var_41a9e596c74a0cf8.var_c8d0f8135a134d40 = 1;
        level thread battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_negative" );
    }
    
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    self setscriptablepartstate( #"interactable", #"disabled" );
    self setscriptablepartstate( #"anim", #"open" );
    wait 0.5;
    
    switch ( self.contents )
    {
        case #"hash_6811bc3f22a2a9e1":
            thread function_ba986bf946616bf1();
            break;
        case #"hash_a64e5eee72269db2":
            thread function_5298f6c32b8dc12c( player );
            break;
        case #"hash_fb36696c0708bf42":
            thread function_79b17b657b805a92( player );
            break;
        case #"hash_c3de03d5b7a72abf":
            thread function_293deaf8dbbba201( player );
            break;
    }
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x3c0edde8, Offset: 0x1530
// Size: 0x151
function private function_ba986bf946616bf1()
{
    var_25e5121dcacdffa4 = self.origin + ( 0, 0, 62 );
    land_org = self.origin + anglestoforward( self.angles ) * 72;
    var_82fb01db4c58032 = ( 0, 0, 0 );
    asset = zm_quest::function_b0a5181ebe7bb905() ? %"hash_74b455ae4dc827ad" : %"zmloot_sat_locust_quest_irving";
    spawnoptions = common_item::function_f5dfaa3bbdf99a33( land_org, var_25e5121dcacdffa4, var_82fb01db4c58032 );
    spawnoptions.var_b8402e625c429a31 = 1;
    spawnoptions.var_23d3495c57d61bdf = 1;
    params = { #spawnoptions:spawnoptions, #asset:asset };
    item = zm_sat_locust_util::spawn_quest_item( params );
    
    if ( zm_quest::function_b0a5181ebe7bb905() && utility::flag( #"hash_a8fa833fe3563102" ) )
    {
        zm_quest::function_b5d75b34f712db9a();
        item setscriptablepartstate( #"objective", #"enabled" );
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_ded897a885bd34ad", item );
    self setscriptablepartstate( #"effects", #"opening_shell" );
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0xea97cae3, Offset: 0x1689
// Size: 0x64
function private function_5298f6c32b8dc12c( attacker )
{
    utility::function_7c10ea82c1e305b8( "effects", "opening_psych" );
    thread function_252c38a4ae335b69();
    attacker thread function_e33a540e29cb7afb();
    wait level.var_41a9e596c74a0cf8.psych_duration;
    utility::function_7c10ea82c1e305b8( "effects", "off" );
    
    if ( isalive( attacker ) )
    {
        attacker thread function_d597f9a0427e832d();
    }
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x98ec3e52, Offset: 0x16f5
// Size: 0x4e
function private function_d597f9a0427e832d()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait level.var_41a9e596c74a0cf8.var_3b5a3ebf3f26501d - level.var_41a9e596c74a0cf8.var_c7a084f83b8b0408;
    level notify( #"hash_5ded9fffe3000f9e" );
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x31986280, Offset: 0x174b
// Size: 0xe6
function private function_252c38a4ae335b69()
{
    trigger = spawn( "trigger_radius", self.origin, 0, level.var_41a9e596c74a0cf8.psych_radius, 128 );
    trigger::makeenterexittrigger( trigger, &function_251586b331f57d34, &function_34ffc70197465eb2 );
    wait level.var_41a9e596c74a0cf8.psych_duration;
    
    foreach ( ent in trigger.triggerenterents )
    {
        if ( isplayer( ent ) )
        {
            ent thread function_273fa066ac28d3a8();
        }
    }
    
    trigger delete();
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0x1f817bdd, Offset: 0x1839
// Size: 0x248
function private function_462ece64ba7fee7( trigger )
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_1f7a3b28c814e517" );
    self endon( #"hash_1f7a3b28c814e517" );
    bundle = level.equipment.table[ "equip_gas_grenade" ].bundle;
    shockassetname = bundle.var_b45d254cca07a4d3 ?? %"gas_grenade_heavy_mp";
    
    if ( bundle.gasgrenadepbgpostfxbundle )
    {
        self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_382df7654f0561bd" ] ]]( { #postfxbundlename:bundle.gasgrenadepbgpostfxbundle }, 1, 1 );
    }
    
    if ( bundle.var_1aadfb29005ffaa4 )
    {
        self.var_955518e3fd692fbd = 1;
        
        if ( !isdefined( self.var_221bcd7e6f8830f8 ) )
        {
            self.var_221bcd7e6f8830f8 = {};
        }
        
        self.var_221bcd7e6f8830f8.weapon = trigger.weapon_object;
        
        foreach ( trigger in self.gastriggerstouching )
        {
            self.var_221bcd7e6f8830f8.attackers[ trigger.owner.entnum ?? utility::get_entity_number( trigger.owner ) ] = trigger.owner;
        }
        
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"gas_hallucination" ][ #"hash_fafb93cf2eff0b4b" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( level.equipment.table[ "equip_gas_grenade" ].bundle );
        }
    }
    
    gas_grenade::function_dcb13d23fa969d90();
    
    while ( true )
    {
        shellshock_utility_cpmp::_shellshock( shockassetname, #"gas", 0.75, 0 );
        wait 0.3;
    }
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0xcc80f298, Offset: 0x1a89
// Size: 0x18e
function private function_273fa066ac28d3a8()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"enter_psych" );
    wait 10;
    bundle = level.equipment.table[ "equip_gas_grenade" ].bundle;
    
    if ( bundle.gasgrenadepbgpostfxbundle )
    {
        [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_494b07757cd511a5" ] ]]( { #postfxbundlename:bundle.gasgrenadepbgpostfxbundle } );
    }
    
    if ( bundle.var_1aadfb29005ffaa4 )
    {
        if ( !isdefined( self.perks[ "specialty_hallucination_immunity" ] ) )
        {
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"gas_hallucination" ][ #"hash_f00f78b8f103a397" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                self [[ var_32dbca3143d9c4a5 ]]( level.equipment.table[ "equip_gas_grenade" ].bundle );
            }
            
            if ( !self.var_193dad851d6389a4 )
            {
                var_e5e3f7fdc72e8f26 = level.equipment.table[ "equip_gas_grenade" ].bundle.var_b45d254cca07a4d3;
                
                if ( !var_e5e3f7fdc72e8f26 )
                {
                    return;
                }
                
                shellshock_utility_cpmp::_shellshock( var_e5e3f7fdc72e8f26, #"stun", 0.75, 0, 100 );
            }
        }
        
        self.var_955518e3fd692fbd = undefined;
    }
    
    self notify( #"hash_1f7a3b28c814e517" );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0xb75376a2, Offset: 0x1c1f
// Size: 0xca
function private function_251586b331f57d34( ent, trigger )
{
    if ( !isdefined( trigger ) || !isalive( ent ) || !isplayer( ent ) && !isai( ent ) )
    {
        return;
    }
    
    if ( isplayer( ent ) )
    {
        ent notify( #"enter_psych" );
        ent thread function_462ece64ba7fee7( trigger );
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"gas_hallucination" ][ #"hash_fafb93cf2eff0b4b" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            ent [[ var_32dbca3143d9c4a5 ]]( level.equipment.table[ "equip_gas_grenade" ].bundle );
        }
        
        ent thread gas_grenade::function_f45f8371a30fea6b( trigger.owner );
    }
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0xfdad5ae6, Offset: 0x1cf1
// Size: 0x29
function private function_34ffc70197465eb2( ent, trigger )
{
    if ( !isplayer( ent ) )
    {
        return;
    }
    
    ent thread function_273fa066ac28d3a8();
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x7b6e4259, Offset: 0x1d22
// Size: 0x8f
function private function_e33a540e29cb7afb()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    level endon( #"hash_5ded9fffe3000f9e" );
    
    while ( true )
    {
        wait level.var_41a9e596c74a0cf8.var_c7a084f83b8b0408;
        thread function_252c38a4ae335b69();
        cursed_scriptable = spawnscriptable( %"sat_zm_prop_roscoe_curse", self.origin, self.angles );
        cursed_scriptable setscriptablepartstate( "effects", "psych" );
        level thread function_67601c8adbb5b5b0( cursed_scriptable );
    }
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0x7cff54a4, Offset: 0x1db9
// Size: 0x33
function private function_67601c8adbb5b5b0( cursed_scriptable )
{
    level endon( #"game_ended" );
    wait level.var_41a9e596c74a0cf8.var_c7a084f83b8b0408;
    cursed_scriptable freescriptable();
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0xb2784ba3, Offset: 0x1df4
// Size: 0x134
function private function_79b17b657b805a92( player )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self setscriptablepartstate( #"effects", #"opening_gas" );
    origin = self.origin + anglestoforward( self.angles ) * 64;
    fake_owner = utility::spawn_tag_origin( origin, self.angles );
    fake_owner.team = "axis";
    duration = 30;
    trigger = spawn( "trigger_radius", self.origin, 0, 128, 96 );
    trigger ent_manager::registerspawn( 1, &sweepgas );
    trigger.playersintrigger = [];
    trigger.duration = duration;
    trigger.owner = fake_owner;
    trigger thread function_7303425977a7eec7( self, fake_owner );
    player thread function_562c265afa83870a();
    wait duration;
    self setscriptablepartstate( #"effects", #"off" );
    trigger sweepgas();
    fake_owner delete();
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0xfa8b9e8e, Offset: 0x1f30
// Size: 0x97
function private function_7303425977a7eec7( crate, owner )
{
    level endon( #"game_ended" );
    crate endon( #"death" );
    self endon( #"death" );
    thread gas_watchtriggerexit();
    
    for ( ;; )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && !arraycontains( self.playersintrigger, ent ) )
        {
            self.playersintrigger[ ent getentitynumber() ] = ent;
            ent thread gas_onentertrigger( self );
        }
    }
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x67eaa308, Offset: 0x1fcf
// Size: 0x35
function private function_562c265afa83870a()
{
    self endon( #"death_or_disconnect" );
    thread function_132bcf64079a6c9();
    wait level.var_41a9e596c74a0cf8.var_68a50ba962899ecb;
    level notify( #"hash_3aa609f7a7ed296c" );
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x6fb25ddb, Offset: 0x200c
// Size: 0x135
function private function_132bcf64079a6c9()
{
    level endon( #"game_ended" );
    level endon( #"hash_3aa609f7a7ed296c" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        wait level.var_41a9e596c74a0cf8.var_1b5cc3c51eeeb7ae;
        fake_owner = utility::spawn_tag_origin( self.origin, self.angles );
        fake_owner.team = "axis";
        trigger = spawn( "trigger_radius", self.origin, 0, 128, 96 );
        trigger ent_manager::registerspawn( 1, &sweepgas );
        trigger.playersintrigger = [];
        trigger.owner = fake_owner;
        trigger.duration = level.var_41a9e596c74a0cf8.var_1b5cc3c51eeeb7ae;
        cursed_scriptable = spawnscriptable( %"sat_zm_prop_roscoe_curse", self.origin, self.angles );
        cursed_scriptable setscriptablepartstate( "effects", "gas" );
        trigger thread function_7303425977a7eec7( self, fake_owner );
        trigger thread function_96564834c1a3518e( self, fake_owner, cursed_scriptable );
    }
}

// Namespace namespace_179a60483790d55e
// Params 3, eflags: 0x4
// Checksum 0x2e0674e4, Offset: 0x2149
// Size: 0x5b
function private function_96564834c1a3518e( player, fake_owner, cursed_scriptable )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    self endon( #"death" );
    wait 10;
    cursed_scriptable freescriptable();
    fake_owner delete();
    sweepgas();
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0xe6605b66, Offset: 0x21ac
// Size: 0xf9
function private function_293deaf8dbbba201( player )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self setscriptablepartstate( #"effects", #"opening_electric" );
    origin = self.origin + anglestoforward( self.angles ) * 64;
    fake_owner = utility::spawn_tag_origin( origin, self.angles );
    fake_owner.team = "axis";
    duration = 30;
    trigger = spawn( "noent_volume_trigger_radius", self.origin, 0, 128, 128 );
    trigger thread function_c41e747f4ee53bf0( self, fake_owner );
    player thread function_6fa3fd53a5a3bd51();
    wait duration;
    self setscriptablepartstate( #"effects", #"off" );
    trigger delete();
    fake_owner delete();
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0x925b5603, Offset: 0x22ad
// Size: 0x131
function private function_c41e747f4ee53bf0( crate, owner )
{
    level endon( #"game_ended" );
    crate endon( #"death" );
    self endon( #"death" );
    shockdata = function_cb7cf10550b2290( owner );
    
    for ( ;; )
    {
        entities = getplayersandaiarrayinradius( crate.origin, 96 );
        
        foreach ( ent in entities )
        {
            if ( !ent istouching( self ) )
            {
                continue;
            }
            
            if ( ent utility::callsharedfunc( #"shockstick", #"shockstick_canbehaywire", shockdata, 1 ) )
            {
                shockdata thread utility::callsharedfunc( #"shockstick", #"shockstick_applyhaywire", ent, shockdata.weapon, 0 );
            }
        }
        
        wait 0.1;
    }
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x295d55e6, Offset: 0x23e6
// Size: 0x35
function private function_6fa3fd53a5a3bd51()
{
    self endon( #"death_or_disconnect" );
    thread function_8d30017d1da527f6();
    wait level.var_41a9e596c74a0cf8.var_299cdcaa0733a3e6;
    level notify( #"hash_3a812e64f6423877" );
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x8a9aa522, Offset: 0x2423
// Size: 0xeb
function private function_8d30017d1da527f6()
{
    level endon( #"game_ended" );
    level endon( #"hash_3a812e64f6423877" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        wait level.var_41a9e596c74a0cf8.shock_stick_duration;
        fake_owner = utility::spawn_tag_origin( self.origin, self.angles );
        fake_owner.team = "axis";
        trigger = spawn( "noent_volume_trigger_radius", self.origin, 0, 128, 128 );
        trigger thread function_c41e747f4ee53bf0( self, fake_owner );
        cursed_scriptable = spawnscriptable( %"sat_zm_prop_roscoe_curse", self.origin, self.angles );
        cursed_scriptable setscriptablepartstate( "effects", "shock" );
        trigger function_a2364bb16d62711d( self, fake_owner, cursed_scriptable );
    }
}

// Namespace namespace_179a60483790d55e
// Params 3, eflags: 0x4
// Checksum 0x874e7162, Offset: 0x2516
// Size: 0x6b
function private function_a2364bb16d62711d( player, fake_owner, cursed_scriptable )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    self endon( #"death" );
    wait level.var_41a9e596c74a0cf8.shock_stick_duration;
    cursed_scriptable freescriptable();
    fake_owner delete();
    self delete();
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x56dc5f0e, Offset: 0x2589
// Size: 0x178
function private function_ebfa00c9aea86f13()
{
    utility::flag_wait( "scriptables_ready" );
    shell_chamber = utility::getstruct( "mqmi_aa_ch", "script_noteworthy" );
    shell_chamber = spawnscriptable( %"sat_zm_prop_harold", shell_chamber.origin, shell_chamber.angles );
    zm_sat_locust_util::function_295a36ef38f5acae( #"aa_gun", shell_chamber );
    crates = getentarray( "robot_antenna_crate", #targetname );
    
    foreach ( idx, crate in crates )
    {
        if ( !isdefined( crate.script_index ) )
        {
            crate.script_index = idx;
        }
        
        if ( crate.origin[ 2 ] <= 222 )
        {
            new_crate = utility::spawn_model( %"t10_storage_crate_wood_shipping_01_large_squ_01_locust", crate.origin, crate.angles, undefined, 1.25 );
            new_crate.targetname = crate.targetname;
            new_crate.script_index = idx;
            crate delete();
            break;
        }
    }
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0xac870133, Offset: 0x2709
// Size: 0x33
function private function_f37a346f98a5d5ec()
{
    utility::flag_wait( "scriptables_ready" );
    var_301b99223500fbfc = getent( "robot_head_antenna_clip", #targetname );
    var_301b99223500fbfc notsolid();
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x1587f8a3, Offset: 0x2744
// Size: 0x61
function private function_e80a8dfb3d5d818d()
{
    utility::flag_wait( "scriptables_ready" );
    transmitter_deposit = utility::getstruct( "mqmi_tr_de", "targetname" );
    transmitter_deposit = spawnscriptable( %"sat_zm_prop_ichabod_deposit", transmitter_deposit.origin, transmitter_deposit.angles );
    zm_sat_locust_util::function_295a36ef38f5acae( #"transmitter_deposit", transmitter_deposit );
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x90c9dbdb, Offset: 0x27ad
// Size: 0x1e7
function private function_3dfba7d01cd447e2()
{
    utility::flag_wait( "scriptables_ready" );
    ice_fx = utility::getstruct( "mqmi_to_ic", "targetname" );
    ice_fx = spawnscriptable( %"sat_zm_prop_percival_ice", ice_fx.origin, ice_fx.angles );
    ice = utility::get_target_ent( "radio_tower_ascender" );
    
    if ( !isdefined( ice ) )
    {
        return;
    }
    
    radio_tower_ascender = getentitylessscriptablearray( "scriptable_t10_ascender_zipline_01", "classname", ice.origin, 250 )[ 0 ];
    zipline_icon = getentitylessscriptablearray( "scriptable_sat_ascender_zipline_icon_dynamic_zm", #classname, ice.origin - ( 0, 0, 64 ), 128 )[ 0 ];
    radio_tower_ascender.ice_fx = ice_fx;
    radio_tower_ascender.zipline_icon = zipline_icon;
    radio_tower_ascender.ice = ice;
    radio_tower_ascender.ice.health = 1;
    
    if ( getdvarint( @"enable_locust_mq", 0 ) )
    {
        radio_tower_ascender.ice setcandamage( 1 );
        radio_tower_ascender.ice thread damage::monitordamage( radio_tower_ascender.ice.health, "hitequip", &radio_tower_ascender_destroy, &zm_sat_locust_util::function_2220168ba514a45f, 0, undefined, undefined, 0 );
        radio_tower_ascender.ice field_upgrades_wiley_fox::add_manual_target( radio_tower_ascender.ice );
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"radio_tower_ascender", radio_tower_ascender );
    utility::flag_wait( "scriptables_ready" );
    radio_tower_ascender setscriptablepartstate( "top", "off" );
    utility::flag_wait( "onStartGameTypeFinished" );
    radio_tower_ascender.ice_fx utility::function_32b24db3127bff40( #"fx", #"ice" );
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0xbba62f53, Offset: 0x299c
// Size: 0x288
function private function_8bf80bc9fe07a28b()
{
    utility::flag_wait( "scriptables_ready" );
    radio_tower_puzzle = utility::getstruct( "mqmi_to_pu", "targetname" );
    radio_tower_puzzle = spawnscriptable( %"sat_zm_prop_percival", radio_tower_puzzle.origin, radio_tower_puzzle.angles );
    radio_tower_puzzle setscriptablepartstate( "body", "disabled" );
    radio_tower_puzzle.var_9547be81f3a08454 = level.var_41a9e596c74a0cf8.var_66d4a6fad90da8b8;
    zm_sat_locust_util::register_limited_interact( radio_tower_puzzle, &function_e8eab0897dbdb3fe, &function_d7d86acbc6cc1ed7, undefined, &function_88b0a84570ca995, undefined, undefined, radio_tower_puzzle.var_9547be81f3a08454 );
    radio_tower_puzzle.var_533d263c23329b50 = 0;
    radio_tower_puzzle function_80711b96bee36c72();
    var_ec82b59cdd178cb1 = utility::getstructarray( "mqmi_ba_ta", "targetname" );
    radio_tower_puzzle.var_ec82b59cdd178cb1 = [];
    
    foreach ( call_in_loc in var_ec82b59cdd178cb1 )
    {
        radio_tower_puzzle.var_ec82b59cdd178cb1[ call_in_loc.script_int ] = call_in_loc;
    }
    
    radio_tower_puzzle function_fff6283d76d8c51();
    lights = getentitylessscriptablearray( %"sat_zm_prop_light", undefined, ( 3058, 9580, 1689 ), 256 );
    lights_amp = [];
    lights_freq = [];
    
    if ( lights.size > 0 )
    {
        foreach ( light in lights )
        {
            if ( light.script_noteworthy == "amplitude" )
            {
                lights_amp[ lights_amp.size ] = light;
                continue;
            }
            
            if ( light.script_noteworthy == "frequency" )
            {
                lights_freq[ lights_freq.size ] = light;
            }
        }
        
        zm_sat_locust_util::function_295a36ef38f5acae( #"lights_amplitude", lights_amp );
        zm_sat_locust_util::function_295a36ef38f5acae( #"lights_frequency", lights_freq );
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"radio_tower_puzzle", radio_tower_puzzle );
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x1c7325b6, Offset: 0x2c2c
// Size: 0x2d
function private function_aa51706f88c55842()
{
    utility::flag_wait( "robot_controllers_init" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_25f192b7bac57fef", level.robot_controllers[ "secondary" ] );
}

// Namespace namespace_179a60483790d55e
// Params 0
// Checksum 0x8b047bd1, Offset: 0x2c61
// Size: 0xa8
function function_80711b96bee36c72()
{
    self.freq = 10;
    self.amp = 0.45;
    self.widget = "scripted_widget_frequency_matching_puzzle";
    self.peaks = 0;
    self.rate = 5;
    self.falloff = 0;
    self.perturbation = 0;
    self.allow_exit = 1;
    self.match_frequency = 1;
    self.difficulty = "hard";
    self.time = 1;
    self.param = "Locust";
    self.use_set_frequencies = 1;
    self.use_stick_rotation_controls = 1;
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0x291f2515, Offset: 0x2d11
// Size: 0x3f
function private function_7d6d613ab952c071( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    level callback::add( "zone_changed", &function_a2924fd3a5e566b7 );
    utility::flag_wait( "mq_rm_step_01" );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0xdcb2f693, Offset: 0x2d58
// Size: 0x40
function private function_60062348e78b78d6( skipped, save_restored )
{
    profilestart();
    level callback::remove( "zone_changed", &function_a2924fd3a5e566b7 );
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_rm_step_01" );
    }
    
    profilestop();
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0x982b5684, Offset: 0x2da0
// Size: 0x37
function private function_a2924fd3a5e566b7( params )
{
    if ( params.zone_struct.zone_name != "zone_lighthouse_int_puzzle_2" )
    {
        return;
    }
    
    utility::flag_set( "mq_rm_step_01" );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0x77aa197e, Offset: 0x2ddf
// Size: 0x79
function private function_7d6d5e3ab952b9d8( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        item = zm_sat_locust_util::get_quest_reference( #"hash_e1b204b85412e1fb" );
        item setscriptablepartstate( item function_84ad2f70189ee7c3(), #"visible" );
    }
    
    level callback::add( "quest_item_used", &function_b737e1af0d05ce6d );
    utility::flag_wait( "mq_rm_step_02" );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0x347968eb, Offset: 0x2e60
// Size: 0x8a
function private function_60062248e78b76a3( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_rm_step_02" );
        zm_quest::function_b57dfe9625966b0b( #"hash_6a85abddd70de8c5", 0, #"crowbar", 1 );
        zm_sat_locust_util::function_a70056d3a99eace5( #"hash_e1b204b85412e1fb" );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
        level thread zm_quest::update_round_cap( 11, 1, 0 );
    }
    
    profilestop();
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0x38548b1b, Offset: 0x2ef2
// Size: 0xb1
function private function_b737e1af0d05ce6d( params )
{
    if ( params.bundle.scriptable == %"zmloot_sat_locust_quest_bertram" || params.bundle.scriptable == %"hash_34b78bf5c3007673" )
    {
        utility::flag_set( "mq_rm_step_02" );
        zm_quest::function_b57dfe9625966b0b( #"hash_6a85abddd70de8c5", 0, #"crowbar", 1 );
        zm_quest::show_splash_item_picked_up( #"hash_6a85abddd70de8c5", #"crowbar", 1, params.player );
        zm_sat_locust_util::function_63a23256772ea1b9( params.player );
    }
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0xfd0b85dc, Offset: 0x2fab
// Size: 0x7a
function private function_7d6d5f3ab952bc0b( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    level callback::add( "quest_item_used", &function_ff492f29ccb83e0 );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        hint = zm_sat_locust_util::get_quest_reference( #"aa_shell_hint" );
        hint callback::add( #"interactive_note_scriptable_used", &function_56be0a3d435e3e01 );
    }
    
    utility::flag_wait( "mq_rm_step_03" );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0xa06cf8d1, Offset: 0x302d
// Size: 0x5d
function private function_56be0a3d435e3e01( instance, player )
{
    utility::flag_set( #"hash_a8fa833fe3563102" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    callback::remove( #"interactive_note_scriptable_used", &function_56be0a3d435e3e01 );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0x640e633d, Offset: 0x3092
// Size: 0xa9
function private function_60062148e78b7470( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_rm_step_03" );
        zm_quest::function_b57dfe9625966b0b( #"hash_6a85abddd70de8c5", 0, #"aa_shell", 1 );
        
        if ( zm_save::function_1dda3554974a999e() )
        {
            level thread function_9ab31445a2c13bb4();
        }
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        utility::flag_set( #"hash_a8fa833fe3563102" );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    level callback::remove( "quest_item_used", &function_ff492f29ccb83e0 );
    profilestop();
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0xa73f6400, Offset: 0x3143
// Size: 0xd5
function private function_ff492f29ccb83e0( params )
{
    if ( params.bundle.scriptable == %"zmloot_sat_locust_quest_irving" || params.bundle.scriptable == %"hash_74b455ae4dc827ad" )
    {
        utility::flag_set( "mq_rm_step_03" );
        zm_quest::function_b57dfe9625966b0b( #"hash_6a85abddd70de8c5", 0, #"aa_shell", 1 );
        zm_quest::show_splash_item_picked_up( #"hash_6a85abddd70de8c5", #"aa_shell", 1, params.player );
        zm_sat_locust_util::function_63a23256772ea1b9( params.player );
        params.player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_901d1571ed4bbb10", #"bc_flavor_player_positive" );
    }
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0xab143a85, Offset: 0x3220
// Size: 0xc2
function private function_9ab31445a2c13bb4()
{
    utility::flag_wait( "loading_screen_fade_out_begin" );
    crates = zm_sat_locust_util::get_quest_reference( #"hash_66bc71bf51846d35" );
    
    foreach ( crate in crates )
    {
        crate setscriptablepartstate( #"interactable", #"disabled" );
        crate setscriptablepartstate( #"anim", #"open" );
    }
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0x7985ba63, Offset: 0x32ea
// Size: 0x6e
function private function_7d6d643ab952c70a( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    shell_chamber = zm_sat_locust_util::get_quest_reference( #"aa_gun" );
    shell_chamber setscriptablepartstate( "usable", "enabled" );
    interaction::register_scriptable_interact( shell_chamber, &function_f6fd7924c8c330fd, undefined, undefined, &function_8bce2cd400eaeb55 );
    utility::flag_wait( "mq_rm_step_04" );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0xb1621ae1, Offset: 0x3360
// Size: 0x6f
function private function_60062848e78b83d5( skipped, save_restored )
{
    profilestart();
    utility::delaythread( level.framedurationseconds, &zm_sat_locust_util::function_a70056d3a99eace5, #"aa_gun" );
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_rm_step_04" );
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            utility::flag_set( #"hash_a8fa813fe3562d9c" );
        }
    }
    
    level thread function_51857e9f5ef199fe( skipped );
    profilestop();
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0x5951601, Offset: 0x33d7
// Size: 0x25
function private aa_gun_dmg_watcher( params )
{
    if ( namespace_e625df044ece0a58::function_c531ee6013cf3d72( params, 1, 0 ) )
    {
        return self.health;
    }
    
    return 0;
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0x3e957fac, Offset: 0x3405
// Size: 0x13
function private function_e87fab490bbe604b( params )
{
    thread aa_gun_fire();
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0xfd2032f3, Offset: 0x3420
// Size: 0xe4
function private aa_gun_fire()
{
    self setscriptablepartstate( "sfx", "firing" );
    harold_fxanim = getentitylessscriptablearray( "harold_mq", #script_noteworthy );
    harold_fxanim[ 0 ] setscriptablepartstate( "animation", "firing" );
    playrumbleonposition( "artillery_rumble_heavy", harold_fxanim[ 0 ].origin );
    earthquakeadvanced( 0.5, 0.3, 0.25, 0.75, harold_fxanim[ 0 ].origin, 768, 1000, 2000 );
    wait 0.5;
    set_1 = [ "dx_zm_lomn_1rrt_lvtw_ml1faasha1ln1", "dx_zm_lomn_1rrt_detw_ml1faasha1ln2" ];
    set_2 = [ "dx_zm_lomn_1rrt_detw_ml1faasha2ln1", "dx_zm_lomn_1rrt_lvtw_ml1faasha2ln2" ];
    level thread zm_sat_locust_util::function_1d7335486cb891d8( set_1, set_2, 0.5 );
    utility::flag_set( "mq_rm_step_04" );
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0xe23f3bac, Offset: 0x350c
// Size: 0xe0
function private function_f6fd7924c8c330fd( player )
{
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    self setscriptablepartstate( "sfx", "loading" );
    self setscriptablepartstate( "usable", "disabled" );
    self setscriptablepartstate( "model", "active" );
    self.health = 1;
    self.var_af70f02bb9462edd = 1;
    self.var_436fc13baa7377d8 = 1;
    self.var_18d4007b123c953a = 1;
    player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_5f43313474503703", #"hash_5212ed7ec42f115a" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        utility::flag_set( #"hash_a8fa813fe3562d9c" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    zm_damage::register_scriptable_damage_callback( &aa_gun_dmg_watcher );
    callback::add( #"hash_11e40a4909e138f7", &function_e87fab490bbe604b );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0xeeb5bb03, Offset: 0x35f4
// Size: 0x7d
function private function_8bce2cd400eaeb55( interact, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        return { #var_26bbd300351fde34:0, #string:&"hash_196e605773b54647", #type:"HINT_BUTTON" };
    }
    
    return { #description:&"", #title:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0xbcae28e6, Offset: 0x367a
// Size: 0x404
function private function_51857e9f5ef199fe( skipped )
{
    antenna_component = getent( "robot_head_antenna", #targetname );
    antenna_scriptable = getentitylessscriptablearray( "robot_head_antenna_scriptable", #targetname );
    antenna_scriptable = antenna_scriptable[ 0 ];
    var_301b99223500fbfc = getent( "robot_head_antenna_clip", #targetname );
    crates = getentarray( "robot_antenna_crate", #targetname );
    
    if ( !skipped )
    {
        antenna_component setscriptablepartstate( #"effects", #"damaged" );
        playrumbleonposition( "artillery_rumble_heavy", antenna_component.origin );
        earthquakeadvanced( 0.6, 0.4, 0.25, 0.75, antenna_component.origin, 500, 1000, 2000 );
    }
    
    interact_loc = utility::getstruct( "mqmi_ro_at_in_lo" );
    interact = spawnscriptable( %"sat_zm_interact_locust", interact_loc.origin, interact_loc.angles );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        hint = utility::callsharedfunc( #"directed_mode", #"get_interact_func", #"hash_a098c327ff36b16b" );
    }
    
    interaction::register_scriptable_interact( interact, &function_b719f6bdccc10a63, undefined, undefined, hint );
    var_8f064ab62a09021f = utility::getstructarray( "mqmi_ro_at_lo_lo" );
    interact.var_8f064ab62a09021f = utility::array_sort_by_script_index( var_8f064ab62a09021f );
    interact.component_count = 5;
    zm_sat_locust_util::function_295a36ef38f5acae( #"antenna_interact", interact );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    movement_path_struct = utility::getstruct( "mqmi_an_pa_st" );
    movement_path = [ movement_path_struct ];
    
    while ( isdefined( movement_path_struct.target ) )
    {
        movement_path_struct = utility::getstruct( movement_path_struct.target );
        movement_path[ movement_path.size ] = movement_path_struct;
    }
    
    move_time = !skipped ? 0.25 : level.framedurationseconds;
    
    foreach ( var_91924ab1040d73db in movement_path )
    {
        antenna_component rotateto( var_91924ab1040d73db.angles, move_time );
        antenna_component moveto( var_91924ab1040d73db.origin, move_time );
        
        if ( !skipped && var_91924ab1040d73db.targetname == "antenna_path_end" )
        {
            antenna_component thread function_63889b56c4d62b72( crates );
        }
        
        antenna_component waittill( #"movedone" );
    }
    
    foreach ( player in level.players )
    {
        if ( distance2dsquared( antenna_component.origin, player.origin ) <= 3600 )
        {
            player knockback( anglestoforward( interact_loc.angles ), 550, 0 );
        }
    }
    
    if ( !skipped )
    {
        earthquake( 0.35, 0.25, antenna_component.origin, 1250 );
    }
    
    if ( crates )
    {
        utility::array_delete( crates );
    }
    
    if ( interact )
    {
        interact setscriptablepartstate( "interact", "enabled_96" );
    }
    
    var_301b99223500fbfc solid();
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0x33209a8a, Offset: 0x3a86
// Size: 0xfe
function private function_63889b56c4d62b72( crates )
{
    crates = utility::array_sort_by_script_index( crates );
    fx_scriptables = [];
    
    for ( i = 0; i < crates.size ; i++ )
    {
        fx = spawnscriptable( "sat_zm_locust_pap_blocker", crates[ i ].origin, crates[ i ].angles );
        fx_scriptables[ fx_scriptables.size ] = fx;
        wait 0.1;
        fx setscriptablepartstate( "sat_zm_locust_pap_blocker", "explode" );
        crates[ i ] delete();
    }
    
    wait 2.5;
    
    foreach ( fx in fx_scriptables )
    {
        fx freescriptable();
    }
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0xe9326b39, Offset: 0x3b8c
// Size: 0x2d
function private function_7d6d653ab952c93d( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( "mq_rm_step_05" );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0xec516289, Offset: 0x3bc1
// Size: 0xd1
function private function_60062748e78b81a2( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_rm_step_05" );
        zm_sat_locust_util::function_a70056d3a99eace5( #"transmitter_spawn" );
        zm_sat_locust_util::function_a70056d3a99eace5( #"antenna_interact" );
        zm_quest::function_b57dfe9625966b0b( #"hash_6a85abddd70de8c5", 0, #"transmitter", 1 );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        utility::flag_set( #"hash_a8fa803fe3562be9" );
        utility::flag_set( #"hash_a8fa7f3fe3562a36" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
        level callback::add( "zone_changed", &function_cc013e40a9171caf );
    }
    
    level callback::remove( "quest_item_used", &function_7de4a7186bdcc032 );
    profilestop();
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0xf56e99f, Offset: 0x3c9a
// Size: 0x25
function private function_b719f6bdccc10a63( player )
{
    self setscriptablepartstate( "interact", "default" );
    thread function_7d632431d7fbc908( player );
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0x9fd0f994, Offset: 0x3cc7
// Size: 0xc0
function private function_7d632431d7fbc908( player )
{
    var_e4f842607274ef86 = self.component_count * 1.5;
    thread function_e6359cc9a47e66();
    params = { #hud_description:&"shared_hintstrings/searching", #var_b35caf93a1ae502d:self, #hold_time:var_e4f842607274ef86, #craft_reason:#"hash_765a12a7527099ad" };
    result = player zm_quest::function_e4eb2d1c1bd8fc4e( params );
    self notify( #"search_complete" );
    
    if ( result )
    {
        self.component_count = 0;
        thread function_1c874dd120292fb3();
        return;
    }
    
    wait 1;
    self setscriptablepartstate( "interact", "enabled_96" );
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0xee373a73, Offset: 0x3d8f
// Size: 0x37
function private function_e6359cc9a47e66()
{
    self endon( #"search_complete" );
    
    while ( self.component_count > 1 )
    {
        wait 1.5;
        self.component_count--;
        thread function_5e98f707debd4b98();
    }
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0xb8bf0ad1, Offset: 0x3dce
// Size: 0x64
function private function_5e98f707debd4b98()
{
    loot_location = self.var_8f064ab62a09021f[ self.component_count ];
    spawn_options = common_item::function_f5dfaa3bbdf99a33( loot_location.origin, self.origin, loot_location.angles );
    common_item::function_38cde6a6acb68ea6( %"hash_4e41d47793dc99e7", 1, spawn_options );
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0xa5b2e8, Offset: 0x3e3a
// Size: 0xf6
function private function_1c874dd120292fb3()
{
    loot_location = self.var_8f064ab62a09021f[ 0 ];
    params = { #spawntype:#"hash_5624a153809c30bc", #toangles:loot_location.angles, #spawningent:self, #toorigin:loot_location.origin, #asset:%"zmloot_sat_locust_quest_ichabod" };
    transmitter_spawn = zm_sat_locust_util::spawn_quest_item( params );
    zm_sat_locust_util::function_295a36ef38f5acae( #"transmitter_spawn", transmitter_spawn );
    level callback::add( "quest_item_used", &function_7de4a7186bdcc032 );
    utility::delaycall( level.framedurationseconds, &freescriptable );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        utility::flag_set( #"hash_a8fa803fe3562be9" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0x8f035a19, Offset: 0x3f38
// Size: 0xb2
function private function_7de4a7186bdcc032( params )
{
    if ( params.bundle.scriptable == %"zmloot_sat_locust_quest_ichabod" )
    {
        zm_quest::function_b57dfe9625966b0b( #"hash_6a85abddd70de8c5", 0, #"transmitter", 1 );
        zm_quest::show_splash_item_picked_up( #"hash_6a85abddd70de8c5", #"transmitter", 1, params.player );
        zm_sat_locust_util::function_63a23256772ea1b9( params.player );
        params.player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_ed87b9829dff8e36", #"hash_5212ed7ec42f115a" );
        utility::flag_set( "mq_rm_step_05" );
    }
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0xe56ff278, Offset: 0x3ff2
// Size: 0x6f
function private function_cc013e40a9171caf( params )
{
    if ( params.zone_struct.zone_name == "zone_robot_head" )
    {
        utility::flag_set( #"hash_a8fa7e3fe3562883" );
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
            level callback::remove( "zone_changed", &function_cc013e40a9171caf );
        }
    }
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0xd420e102, Offset: 0x4069
// Size: 0x125
function private function_7d6d623ab952c2a4( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player prestreamasset( "model", %"sat_locust_zm_ichabod", 1000 );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        hint = utility::callsharedfunc( #"directed_mode", #"get_interact_func", #"hash_d47e7a05beac35d2" );
    }
    
    transmitter_deposit = zm_sat_locust_util::get_quest_reference( #"transmitter_deposit" );
    interaction::register_scriptable_interact( transmitter_deposit, &function_b97a38da9ad6115, undefined, undefined, hint );
    transmitter_deposit setscriptablepartstate( "usable", "enabled" );
    utility::flag_wait( "mq_rm_step_06" );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0x9353fdb2, Offset: 0x4196
// Size: 0x1b5
function private function_60062648e78b7f6f( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_rm_step_06" );
        transmitter_deposit = zm_sat_locust_util::get_quest_reference( #"transmitter_deposit" );
        transmitter_deposit setscriptablepartstate( "body", "enabled" );
        transmitter_deposit setscriptablepartstate( "usable", "disabled" );
        transmitter_deposit setscriptablepartstate( "vfx", "off" );
        transmitter_deposit setscriptablepartstate( "sfx", "inserted" );
        radio_tower_puzzle = zm_sat_locust_util::get_quest_reference( #"radio_tower_puzzle" );
        radio_tower_puzzle setscriptablepartstate( "body", "enabled" );
        radio_tower_puzzle setscriptablepartstate( "sfx", "power_on" );
        radio_tower_puzzle setscriptablepartstate( "sfx_loop", "on" );
    }
    
    foreach ( player in level.players )
    {
        player prestreamclear( "model" );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        utility::flag_clear( #"hash_a8fa8c3fe356404d" );
        utility::flag_set( #"hash_a8fa7e3fe3562883" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
        level thread zm_quest::update_round_cap( 12, 1, 0 );
        level callback::remove( "zone_changed", &function_cc013e40a9171caf );
    }
    
    profilestop();
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0xe4c3af97, Offset: 0x4353
// Size: 0x166
function private function_b97a38da9ad6115( player )
{
    self setscriptablepartstate( "usable", "disabled" );
    params = { #hud_description:&"zm_sat_locust/replacing_transmitter", #var_b35caf93a1ae502d:self, #hold_time:3, #craft_reason:#"transmitter_repair" };
    result = player zm_quest::function_e4eb2d1c1bd8fc4e( params );
    
    if ( result )
    {
        utility::flag_set( "mq_rm_step_06" );
        self setscriptablepartstate( "body", "enabled" );
        self setscriptablepartstate( "vfx", "off" );
        self setscriptablepartstate( "sfx", "inserted" );
        radio_tower_puzzle = zm_sat_locust_util::get_quest_reference( #"radio_tower_puzzle" );
        radio_tower_puzzle setscriptablepartstate( "body", "enabled" );
        radio_tower_puzzle setscriptablepartstate( "sfx", "power_on" );
        radio_tower_puzzle setscriptablepartstate( "sfx_loop", "on" );
        level thread battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_positive", 0.5 );
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            utility::flag_clear( #"hash_a8fa8c3fe356404d" );
            level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
        }
        
        return;
    }
    
    utility::delaycall( 1, &setscriptablepartstate, "usable", "enabled" );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0xc88f44b9, Offset: 0x44c1
// Size: 0x29
function private function_7d6d633ab952c4d7( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    level thread function_e85e7b697593574d();
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0x4c3bb46f, Offset: 0x44f2
// Size: 0x5a
function private function_60062548e78b7d3c( skipped, save_restored )
{
    profilestart();
    radio_tower_puzzle = zm_sat_locust_util::get_quest_reference( #"radio_tower_puzzle" );
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_rm_step_07" );
        radio_tower_puzzle setscriptablepartstate( "usable", "disabled" );
    }
    
    profilestop();
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x93985ce9, Offset: 0x4554
// Size: 0x130
function private function_e85e7b697593574d()
{
    level endon( #"game_ended" );
    level endon( #"mq_rm_step_07_c" );
    radio_tower_puzzle = zm_sat_locust_util::get_quest_reference( #"radio_tower_puzzle" );
    guided_mode = zm_quest::function_b0a5181ebe7bb905();
    var_dd0f43c146409c70 = guided_mode ? 1.5 : 1;
    var_bbcd600b477f18c2 = guided_mode ? 3 : 2.5;
    
    while ( true )
    {
        for ( i = radio_tower_puzzle.solved_count; i < 2 ; i++ )
        {
            thread function_5fe6315a03990847( "amp", radio_tower_puzzle.var_c60823282e971ebb[ i ] );
            thread function_5fe6315a03990847( "freq", radio_tower_puzzle.var_dd4ec9a0e7aabfe3[ i ] );
            utility::waittill_multiple( "light_amp_done", "light_freq_done" );
            wait var_dd0f43c146409c70;
        }
        
        if ( guided_mode && !utility::flag( #"hash_a8fa7d3fe35626d0" ) )
        {
            utility::flag_set( #"hash_a8fa7d3fe35626d0" );
            level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
        }
        
        wait var_bbcd600b477f18c2;
    }
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0x4217dc6a, Offset: 0x468c
// Size: 0x1c5
function private function_5fe6315a03990847( type, var_d0fa654d90bf3c68 )
{
    level endon( #"game_ended" );
    level endon( #"mq_rm_step_07_c" );
    
    if ( type == "amp" )
    {
        flag = "light_amp_done";
        lights = zm_sat_locust_util::get_quest_reference( #"lights_amplitude" );
    }
    else
    {
        flag = "light_freq_done";
        lights = zm_sat_locust_util::get_quest_reference( #"lights_frequency" );
    }
    
    utility::flag_clear( flag );
    var_b7419cfb5ccaa85e = zm_quest::function_b0a5181ebe7bb905() ? 0.5 : 0.25;
    
    for ( i = 0; i < var_d0fa654d90bf3c68 ; i++ )
    {
        foreach ( light in lights )
        {
            light setscriptablepartstate( #"sat_zm_prop_light", #"light_off" );
        }
        
        wait var_b7419cfb5ccaa85e;
        
        foreach ( light in lights )
        {
            light setscriptablepartstate( #"sat_zm_prop_light", #"light_on" );
        }
        
        wait var_b7419cfb5ccaa85e;
    }
    
    utility::flag_set( flag );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0x4ac15944, Offset: 0x4859
// Size: 0x2d
function private function_20d1719df0abff1b( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( "mq_rm_step_07_a" );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0xabcd82fc, Offset: 0x488e
// Size: 0x72
function private function_a2cc1969a5b41b08( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        radio_tower_ascender = zm_sat_locust_util::get_quest_reference( #"radio_tower_ascender" );
        radio_tower_ascender.ice radio_tower_ascender_destroy();
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace namespace_179a60483790d55e
// Params 1
// Checksum 0xa0f10069, Offset: 0x4908
// Size: 0x9b
function radio_tower_ascender_destroy( data )
{
    radio_tower_ascender = zm_sat_locust_util::get_quest_reference( #"radio_tower_ascender" );
    
    if ( !isdefined( radio_tower_ascender ) )
    {
        return -1;
    }
    
    radio_tower_ascender.ice_fx setscriptablepartstate( "fx", "melt" );
    radio_tower_ascender setscriptablepartstate( "top", "use" );
    radio_tower_ascender.zipline_icon setscriptablepartstate( "icon", "active" );
    zone_manager::set_zone_enabled( "zone_foundry_tower", 1 );
    utility::flag_set( "mq_rm_step_07_a" );
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0x5bf8ee24, Offset: 0x49ab
// Size: 0x59
function private function_20d1729df0ac014e( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    radio_tower_puzzle = zm_sat_locust_util::get_quest_reference( #"radio_tower_puzzle" );
    radio_tower_puzzle setscriptablepartstate( "usable", "enabled" );
    utility::flag_wait( "mq_rm_step_07_b" );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0x7593e4ea, Offset: 0x4a0c
// Size: 0x70
function private function_a2cc1c69a5b421a1( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_rm_step_07_b" );
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            utility::flag_set( #"hash_a8fa7d3fe35626d0" );
        }
        
        radio_tower_puzzle = zm_sat_locust_util::get_quest_reference( #"radio_tower_puzzle" );
        radio_tower_puzzle.solved_count = 1;
    }
    
    profilestop();
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x6b34fafc, Offset: 0x4a84
// Size: 0xdf
function private function_3d3a816dac237582()
{
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        difficulty_round_number = zm_round_logic::get_rb_round_number();
    }
    else
    {
        difficulty_round_number = max( 15, zm_round_logic::get_rb_round_number() + 5 );
    }
    
    var_30085f70fc117162 = utility::getstruct( "mqmi_ka_ra_to", "targetname" );
    hvt_params = { #difficulty_round_number:difficulty_round_number, #var_30085f70fc117162:var_30085f70fc117162, #spawner_zombie_type:"zombie_karkinos", #count:1 };
    radio_tower_karkinos = zm_sat_locust_util::spawn_quest_zombie( hvt_params );
    radio_tower_karkinos callback::add( "on_zombie_ai_killed", &function_34792857e22e1409 );
    zm_sat_locust_util::function_295a36ef38f5acae( #"radio_tower_karkinos", radio_tower_karkinos );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0x6e5b3e08, Offset: 0x4b6b
// Size: 0xd6
function private function_34792857e22e1409( params )
{
    radio_tower_puzzle = zm_sat_locust_util::get_quest_reference( #"radio_tower_puzzle" );
    radio_tower_puzzle.completed = 0;
    radio_tower_puzzle.var_533d263c23329b50 = 0;
    radio_tower_puzzle function_80711b96bee36c72();
    radio_tower_puzzle setscriptablepartstate( "body", "enabled" );
    radio_tower_puzzle setscriptablepartstate( "sfx", "power_on" );
    radio_tower_puzzle setscriptablepartstate( "sfx_loop", "on" );
    radio_tower_puzzle setscriptablepartstate( "usable", "enabled" );
    radio_tower_puzzle zm_sat_locust_util::function_1a3e351820ab994c();
    zm_sat_locust_util::function_7bf944a5a2b76f39( #"radio_tower_karkinos" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    utility::flag_set( "mq_rm_step_07_b" );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0x52c7c6c2, Offset: 0x4c49
// Size: 0x18e
function private function_20d1739df0ac0381( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        utility::flag_wait( "begin_round_logic" );
        radio_tower_puzzle = zm_sat_locust_util::get_quest_reference( #"radio_tower_puzzle" );
        radio_tower_puzzle setscriptablepartstate( "usable", "enabled" );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        difficulty_round_number = zm_round_logic::get_rb_round_number();
    }
    else
    {
        difficulty_round_number = max( 15, zm_round_logic::get_rb_round_number() + 5 );
    }
    
    spawn_zones = [ zone_manager::get_zone_struct( "zone_foundry_north" ), zone_manager::get_zone_struct( "zone_robot_foot" ), zone_manager::get_zone_struct( "zone_foundry_comms" ), zone_manager::get_zone_struct( "zone_foundry" ) ];
    count = level.players.size > 1 ? 15 : 10;
    params = { #spawner_zombie_type:"zombie_base", #forced_move_speed:"sprint", #max_spawn_count:count, #max_active_zombies:count, #var_98f23c369371e8ec:1, #var_1e899b25f3766233:0, #var_d346909023f61570:difficulty_round_number, #difficulty_round_number:difficulty_round_number, #spawn_zones:spawn_zones, #name:"wave_radio_tower" };
    level thread zm_sat_locust_util::holdout_event( params );
    utility::flag_wait( "mq_rm_step_07_c" );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0xa6f5b60d, Offset: 0x4ddf
// Size: 0x21b
function private function_a2cc1b69a5b41f6e( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        utility::flag_set( "mq_rm_step_07_c" );
    }
    
    if ( zm_sat_locust_util::is_holdout_event_active( "wave_radio_tower" ) )
    {
        zm_sat_locust_util::end_holdout_event( "wave_radio_tower" );
    }
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"lights_amplitude" ) )
    {
        lights_amp = zm_sat_locust_util::get_quest_reference( #"lights_amplitude" );
        
        foreach ( light in lights_amp )
        {
            light setscriptablepartstate( #"sat_zm_prop_light", #"light_on" );
        }
    }
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"lights_frequency" ) )
    {
        lights_freq = zm_sat_locust_util::get_quest_reference( #"lights_frequency" );
        
        foreach ( light in lights_freq )
        {
            light setscriptablepartstate( #"sat_zm_prop_light", #"light_on" );
        }
    }
    
    radio_tower_puzzle = zm_sat_locust_util::get_quest_reference( #"radio_tower_puzzle" );
    radio_tower_puzzle setscriptablepartstate( "usable", "disabled" );
    radio_tower_puzzle.solved_count = 2;
    transmitter_deposit = zm_sat_locust_util::get_quest_reference( #"transmitter_deposit" );
    transmitter_deposit setscriptablepartstate( "sfx", "communication activating" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
}

// Namespace namespace_179a60483790d55e
// Params 0
// Checksum 0xfaf138bf, Offset: 0x5002
// Size: 0x2
function function_a20facf127b471ab()
{
    
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x6420f61c, Offset: 0x500c
// Size: 0xb0
function private function_fff6283d76d8c51()
{
    self.solved_count = 0;
    set_radio_code();
    self.cypher_keys = [];
    
    for ( i = 0; i < 2 ; i++ )
    {
        amp = math::lerp_fraction( 1, 7, self.var_c60823282e971ebb[ i ] );
        freq = math::lerp_fraction( 1, 8, self.var_dd4ec9a0e7aabfe3[ i ] );
        goal_val = { #freq:freq, #amp:amp };
        self.cypher_keys[ self.cypher_keys.size ] = goal_val;
    }
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0xc5688e2b, Offset: 0x50c4
// Size: 0x1d9
function private set_radio_code()
{
    self.var_c60823282e971ebb = [];
    self.var_dd4ec9a0e7aabfe3 = [];
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        var_eb0b5416404c1cf3 = [ 4, 2 ];
        var_eb0b5516404c1f26 = [ 5, 3 ];
        var_7e8661062960364b = [ 1, 6 ];
        var_7e8662062960387e = [ 2, 8 ];
        var_79e0d73b5df17099 = utility::cointoss();
        var_83feaa0e9aa77ec8 = utility::cointoss();
        level.var_41a9e596c74a0cf8.set_1 = var_79e0d73b5df17099;
        level.var_41a9e596c74a0cf8.set_2 = var_83feaa0e9aa77ec8;
        self.var_c60823282e971ebb = [ var_eb0b5416404c1cf3[ var_79e0d73b5df17099 ], var_eb0b5516404c1f26[ var_83feaa0e9aa77ec8 ] ];
        self.var_dd4ec9a0e7aabfe3 = [ var_7e8661062960364b[ var_79e0d73b5df17099 ], var_7e8662062960387e[ var_83feaa0e9aa77ec8 ] ];
        return;
    }
    
    var_64f90d65cb0d2402 = arrayrandomize( [ 1, 2, 3, 4, 5, 6, 7 ] );
    var_42121c390e9a0e98 = arrayrandomize( [ 1, 2, 3, 4, 5, 6, 7, 8 ] );
    
    for ( i = 0; i < 2 ; i++ )
    {
        amp_val = var_64f90d65cb0d2402[ i ];
        freq_val = var_42121c390e9a0e98[ i ];
        self.var_c60823282e971ebb[ self.var_c60823282e971ebb.size ] = amp_val;
        self.var_dd4ec9a0e7aabfe3[ self.var_dd4ec9a0e7aabfe3.size ] = freq_val;
    }
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0x5e8a8ef6, Offset: 0x52a5
// Size: 0x4a
function private function_cf2ede8ce438b126( player )
{
    val_struct = self.cypher_keys[ self.solved_count ];
    player frequency_matching_puzzle::function_4b8de1a9e27d3e0e( val_struct.freq, val_struct.amp );
}

/#

    // Namespace namespace_179a60483790d55e
    // Params 0, eflags: 0x4
    // Checksum 0xa2b2daf9, Offset: 0x52f7
    // Size: 0x81, Type: dev
    function private function_fccfffa800d0a2b0()
    {
        var_c60823282e971ebb = zm_sat_locust_util::get_quest_reference( #"radio_tower_puzzle" ).var_c60823282e971ebb;
        var_dd4ec9a0e7aabfe3 = zm_sat_locust_util::get_quest_reference( #"radio_tower_puzzle" ).var_dd4ec9a0e7aabfe3;
        iprintlnbold( "<dev string:x24>" + var_c60823282e971ebb[ 0 ] + "<dev string:x2c>" + var_dd4ec9a0e7aabfe3[ 0 ] + "<dev string:x33>" + var_c60823282e971ebb[ 1 ] + "<dev string:x2c>" + var_dd4ec9a0e7aabfe3[ 1 ] + "<dev string:x40>" );
    }

    // Namespace namespace_179a60483790d55e
    // Params 0, eflags: 0x4
    // Checksum 0xfcfbefdb, Offset: 0x5380
    // Size: 0x7b, Type: dev
    function private function_a1a98f6fdde18371()
    {
        radio_tower_puzzle = zm_sat_locust_util::get_quest_reference( #"radio_tower_puzzle" );
        radio_tower_puzzle.var_9547be81f3a08454 = radio_tower_puzzle.var_9547be81f3a08454 == level.var_41a9e596c74a0cf8.var_66d4a6fad90da8b8 ? level.var_41a9e596c74a0cf8.var_66d4a6fad90da8b8 * 1000 : level.var_41a9e596c74a0cf8.var_66d4a6fad90da8b8;
    }

#/

// Namespace namespace_179a60483790d55e
// Params 0
// Checksum 0xd7ccae0c, Offset: 0x5403
// Size: 0x2
function function_a5e580aeb7e1026a()
{
    
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0xbe1b7ea5, Offset: 0x540d
// Size: 0x32, Type: bool
function private function_e8eab0897dbdb3fe( player )
{
    self setscriptablepartstate( "usable", "disabled" );
    self.var_60a18211288345a4 = player;
    thread start_frequency_puzzle( player );
    return true;
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0xed863422, Offset: 0x5448
// Size: 0xc1
function private function_d7d86acbc6cc1ed7( player )
{
    self.var_60a18211288345a4 = undefined;
    
    if ( self.var_d46b85cfdf61574e )
    {
        self setscriptablepartstate( "body", "disabled" );
        self setscriptablepartstate( "sfx", "shut_down" );
        self setscriptablepartstate( "sfx_loop", "off" );
        self.failed = 1;
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            utility::flag_set( #"hash_a8fa8c3fe356404d" );
            level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
        }
    }
    
    if ( !self.completed && !self.failed )
    {
        utility::delaycall( 1, &setscriptablepartstate, "usable", "enabled" );
    }
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0xdbc9dc8, Offset: 0x5511
// Size: 0x7d
function private function_88b0a84570ca995( interact, player )
{
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_locust/percival_hint", #type:"HINT_BUTTON" };
    }
    
    return { #description:&"", #title:&"", #type:"HINT_NOBUTTON" };
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0x345d9643, Offset: 0x5597
// Size: 0xd3
function private start_frequency_puzzle( player )
{
    player frequency_matching_puzzle::frequency_match_puzzle_open( self.widget, self.freq, self.amp, self.peaks, self.rate, self.falloff, self.perturbation, self.allow_exit, self.match_frequency, self.difficulty, self.time, 0, self.param, self.use_set_frequencies, self.use_stick_rotation_controls );
    function_cf2ede8ce438b126( player );
    thread function_5f0a32915c8d8b15();
    thread function_76c7eb175de354c5();
    thread function_a60225eac90df5be();
    
    if ( !self.var_533d263c23329b50 )
    {
        self.var_533d263c23329b50 = 1;
        thread function_b5304dc1c54d1ace( player );
    }
}

// Namespace namespace_179a60483790d55e
// Params 0
// Checksum 0x15f406f7, Offset: 0x5672
// Size: 0x6f
function function_76c7eb175de354c5()
{
    self notify( #"hash_40e75ecf389a8ad4" );
    self endon( #"hash_40e75ecf389a8ad4" );
    level endon( #"game_ended" );
    self.var_60a18211288345a4 endon( #"frequency_match_puzzle_timeout" );
    self.var_60a18211288345a4 waittill( #"frequency_match_puzzle_success" );
    thread function_ba7f73be6f03400c( self.var_60a18211288345a4 );
    zm_sat_locust_util::limited_interact_exited( self.var_60a18211288345a4 );
}

// Namespace namespace_179a60483790d55e
// Params 0
// Checksum 0x85e9452, Offset: 0x56e9
// Size: 0x70
function function_a60225eac90df5be()
{
    self notify( #"hash_4925a7c4d9d4eee" );
    self endon( #"hash_4925a7c4d9d4eee" );
    level endon( #"game_ended" );
    self.var_60a18211288345a4 endon( #"frequency_match_puzzle_success" );
    self.var_60a18211288345a4 utility::waittill_any( "frequency_match_puzzle_timeout", "frequency_match_puzzle_closed" );
    self notify( #"frequency_match_puzzle_closed" );
    zm_sat_locust_util::limited_interact_exited( self.var_60a18211288345a4 );
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0xc7954b23, Offset: 0x5761
// Size: 0x7c
function private function_b5304dc1c54d1ace( player )
{
    level endon( #"game_ended" );
    level endon( #"wunderbarrage_started" );
    utility::waittill_notify_or_timeout( "limited_interact_failed", self.var_9547be81f3a08454 );
    level notify( #"hash_f90d2caa29cf52bb" );
    self setscriptablepartstate( "body", "disabled" );
    self setscriptablepartstate( "sfx", "shut_down" );
    self setscriptablepartstate( "sfx_loop", "off" );
    function_703de298547ab03b();
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x8efd6579, Offset: 0x57e5
// Size: 0xa5
function private function_703de298547ab03b()
{
    level endon( #"game_ended" );
    
    if ( self.var_60a18211288345a4 )
    {
        self.var_60a18211288345a4 notify( #"frequency_match_puzzle_timeout" );
        level notify( #"frequency_match_puzzle_timeout" );
        self.var_60a18211288345a4 frequency_matching_puzzle::function_5de683bf6f9d243c( 1 );
    }
    
    self.failed = 1;
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        utility::flag_set( #"hash_a8fa8c3fe356404d" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    wait level.var_41a9e596c74a0cf8.var_ae1f10f1861dfc53;
    function_79b62e1ba0c349ac();
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0xde02b78a, Offset: 0x5892
// Size: 0x90
function private function_79b62e1ba0c349ac()
{
    self setscriptablepartstate( "body", "enabled" );
    self setscriptablepartstate( "sfx", "power_on" );
    self setscriptablepartstate( "sfx_loop", "on" );
    self setscriptablepartstate( "usable", "enabled" );
    self.var_533d263c23329b50 = 0;
    self.failed = 0;
    zm_sat_locust_util::function_1a3e351820ab994c();
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        utility::flag_clear( #"hash_a8fa8c3fe356404d" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0xc78c069e, Offset: 0x592a
// Size: 0x1f3
function private function_ba7f73be6f03400c( player )
{
    level endon( #"game_ended" );
    self.completed = 1;
    self.solved_count++;
    self setscriptablepartstate( "sfx", "success" );
    
    if ( !utility::flag( "mq_rm_step_07_b" ) )
    {
        utility::flag_set( "mq_rm_step_07_b" );
    }
    
    switch ( self.solved_count )
    {
        case 1:
            wunderbarrage_data_struct = structcopy( level.robot_wunderbarrage.defaults );
            wunderbarrage_data_struct.row_offset = 150;
            wunderbarrage_data_struct.column_offset = 100;
            wunderbarrage_data_struct.var_cc48735c9f8faaca = 2;
            wunderbarrage_data_struct.var_2a1b17b60632a51d = 4;
            wunderbarrage_data_struct.var_c6318ece6fa18364 = 0.75;
            wunderbarrage_data_struct.danger_zone_radius = wunderbarrage_data_struct.row_offset * ( wunderbarrage_data_struct.var_cc48735c9f8faaca - 2 );
            dialogue = !player namespace_c0b4f2882c9d100f::is_richtofen() ? "dx_zm_lomn_1rrt_typa_ml1casig1" : "dx_zm_lomn_1rrt_typa_ml1casig1pu";
            level zm_sat_locust_util::function_a8b578b47e763d0f( dialogue );
            level thread zm_sat_locust_wunderbarrage::launch_wunderbarrage( wunderbarrage_data_struct, player, undefined, self.var_ec82b59cdd178cb1[ 1 ].origin );
            wait 1;
            
            if ( player )
            {
                player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_348eb2e169407495", #"hash_5212ed7ec42f115a" );
            }
            
            break;
        case 2:
            dialogue = !player namespace_c0b4f2882c9d100f::is_richtofen() ? "dx_zm_lomn_1rrt_typa_ml1casig2" : "dx_zm_lomn_1rrt_typa_ml1casig2pu";
            level zm_sat_locust_util::function_a8b578b47e763d0f( dialogue );
            level thread zm_sat_locust_wunderbarrage::launch_wunderbarrage( undefined, player, undefined, self.var_ec82b59cdd178cb1[ 2 ].origin );
            self.solved_by = player;
            break;
        default:
            break;
    }
    
    thread function_3a079bbd2ba985c1();
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0x4
// Checksum 0x9f6f06c3, Offset: 0x5b25
// Size: 0xab
function private function_3a079bbd2ba985c1()
{
    level waittill( #"wunderbarrage_ended" );
    
    if ( self.solved_count != 2 )
    {
        wait 1;
        self setscriptablepartstate( "body", "disabled" );
        self setscriptablepartstate( "sfx", "shut_down" );
        self setscriptablepartstate( "sfx_loop", "off" );
        function_3d3a816dac237582();
        return;
    }
    
    dialogue = !self.solved_by || !self.solved_by namespace_c0b4f2882c9d100f::is_richtofen() ? "dx_zm_lomn_1rrt_typa_ml1casigscs" : "dx_zm_lomn_1rrt_typa_ml1casigscspu";
    level thread zm_sat_locust_util::function_a8b578b47e763d0f( dialogue );
    utility::flag_set( "mq_rm_step_07_c" );
}

// Namespace namespace_179a60483790d55e
// Params 0, eflags: 0xc
// Checksum 0xa3d2e917, Offset: 0x5bd8
// Size: 0x95
function private function_5f0a32915c8d8b15()
{
    self notify( #"hash_7c0daaa6af4ea458" );
    self endon( #"hash_7c0daaa6af4ea458" );
    level endon( #"game_ended" );
    level endon( #"hash_f90d2caa29cf52bb" );
    self endon( #"frequency_match_puzzle_closed" );
    sound_info_struct = self.var_60a18211288345a4.var_38a5b2e851fe7867;
    
    while ( true )
    {
        function_398bc9ee922d91fd( "radio_puzzle_freq", sound_info_struct.var_44d36925a7312a1a );
        function_398bc9ee922d91fd( "radio_puzzle_amp", sound_info_struct.var_4b6b53fd75a0fa6e );
        wait 0.1;
    }
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0x8d967220, Offset: 0x5c75
// Size: 0x86
function private function_7d6d583ab952aca6( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    station = zm_sat_locust_util::get_quest_reference( #"hash_25f192b7bac57fef" );
    station.controller setscriptablepartstate( station.controller function_84ad2f70189ee7c3(), #"visible" );
    level callback::add( #"player_item_pickup", &function_d702d3a3b631c7be );
    utility::flag_wait( "mq_rm_step_08" );
}

// Namespace namespace_179a60483790d55e
// Params 2, eflags: 0x4
// Checksum 0x95130a19, Offset: 0x5d03
// Size: 0x199
function private function_60062c48e78b8ca1( skipped, save_restored )
{
    profilestart();
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_25f192b7bac57fef" ) )
    {
        station = zm_sat_locust_util::get_quest_reference( #"hash_25f192b7bac57fef" );
    }
    
    setomnvar( o"ui_item_bernard_secondary_allowed", 1 );
    level.fishing_struct.loot_index = 2;
    level thread zm_sat_locust_util::terminal_set_state( #"online_3" );
    level callback::remove( #"player_item_pickup", &function_d702d3a3b631c7be );
    
    if ( skipped || save_restored )
    {
        if ( !save_restored )
        {
            /#
                if ( station && station.controller && level.player && isalive( level.player ) )
                {
                    common_item::items_scriptable_used( station.controller, station.controller function_84ad2f70189ee7c3(), #"visible", level.player, 0 );
                }
            #/
        }
        else if ( station.controller )
        {
            station.controller freescriptable();
        }
        
        level.fishing_struct.force_wb = 1;
        utility::flag_set( "mq_rm_step_08" );
        zm_quest::function_b57dfe9625966b0b( #"locust_quest_pap", 0, #"robot_controller", 2 );
    }
    
    utility::flag_set( "mq_rm_core" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0x300ff7eb, Offset: 0x5ea4
// Size: 0xa4
function private function_d702d3a3b631c7be( params )
{
    if ( params.itembundle.scriptable == %"zmloot_sat_locust_quest_bernard_secondary" )
    {
        level.fishing_struct.force_wb = 1;
        utility::flag_set( "mq_rm_step_08" );
        zm_quest::function_b57dfe9625966b0b( #"locust_quest_pap", 0, #"robot_controller", 2 );
        zm_quest::show_splash_item_picked_up( #"locust_quest_pap", #"robot_controller", 2, params.player );
        zm_sat_locust_util::function_63a23256772ea1b9( params.player );
    }
}

// Namespace namespace_179a60483790d55e
// Params 0
// Checksum 0x283e99e6, Offset: 0x5f50
// Size: 0x2
function __debug()
{
    
}

/#

    // Namespace namespace_179a60483790d55e
    // Params 0, eflags: 0x4
    // Checksum 0xa0e591a7, Offset: 0x5f5a
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace namespace_179a60483790d55e
    // Params 0, eflags: 0x4
    // Checksum 0x579ee926, Offset: 0x5f6e
    // Size: 0x8a, Type: dev
    function private devgui_init()
    {
        zm_quest::function_bc99f123a684344f( #"hash_d1612ed5d50da819" );
        devgui::add_devgui_func( "<dev string:x43>", "<dev string:x5b>", &function_21988422556ff49 );
        devgui::add_devgui_func( "<dev string:x6f>", "<dev string:x86>", &function_11eae50b443dcf25 );
        devgui::add_devgui_func( "<dev string:x98>", "<dev string:xae>", &function_53b77a087164911d );
        devgui::add_devgui_func( "<dev string:xbd>", "<dev string:xbd>", &function_fccfffa800d0a2b0 );
        devgui::add_devgui_func( "<dev string:xda>", "<dev string:xda>", &function_a1a98f6fdde18371 );
        zm_quest::function_c1400a2f4670c23f();
    }

    // Namespace namespace_179a60483790d55e
    // Params 0, eflags: 0x4
    // Checksum 0x655d32f9, Offset: 0x6000
    // Size: 0x131, Type: dev
    function private function_21988422556ff49()
    {
        zm_utility::open_sesame();
        var_3fb6e6959465a40a = [ #"locust_quest_pap", #"hash_709d77ab2b2005c5" ];
        
        foreach ( quest in var_3fb6e6959465a40a )
        {
            if ( !zm_quest::is_quest_complete( quest ) )
            {
                zm_quest = zm_quest::get_quest( quest );
                
                foreach ( step in zm_quest.steps )
                {
                    zm_quest::function_e65609834444650c( step );
                }
            }
        }
    }

    // Namespace namespace_179a60483790d55e
    // Params 0, eflags: 0x4
    // Checksum 0x6203e91e, Offset: 0x6139
    // Size: 0x107, Type: dev
    function private function_11eae50b443dcf25()
    {
        if ( utility::flag( "<dev string:xfe>" ) )
        {
            utility::flag_clear( "<dev string:xfe>" );
            return;
        }
        else
        {
            utility::flag_set( "<dev string:xfe>" );
        }
        
        crates = zm_sat_locust_util::get_quest_reference( #"hash_66bc71bf51846d35" );
        
        foreach ( crate in crates )
        {
            debug::sphere( crate, 16, ( 1, 1, 1 ), undefined, "<dev string:xfe>" );
            debug::print3d( crate, crate.contents, ( 1, 1, 1 ), undefined, "<dev string:xfe>", "<dev string:x10a>", 1, 1, 16 );
        }
    }

    // Namespace namespace_179a60483790d55e
    // Params 0, eflags: 0x4
    // Checksum 0xa41fe70f, Offset: 0x6248
    // Size: 0x17, Type: dev
    function private function_53b77a087164911d()
    {
        level.players[ 0 ] thread function_3ad6e87e72a67bf4();
    }

    // Namespace namespace_179a60483790d55e
    // Params 0, eflags: 0x4
    // Checksum 0xac675bb9, Offset: 0x6267
    // Size: 0x167, Type: dev
    function private function_3ad6e87e72a67bf4()
    {
        widget = "<dev string:x110>";
        freq = getdvarfloat( @"puzzle_freq", 5 );
        amp = getdvarfloat( @"puzzle_amp", 0.4 );
        peaks = getdvarint( @"hash_411634c3c5fe1541", 0 );
        rate = getdvarfloat( @"puzzle_rate", 5 );
        falloff = getdvarint( @"puzzle_fallout", 0 );
        perturbation = getdvarfloat( @"hash_af063f56e2f77dc2", 0 );
        allow_exit = 1;
        match_frequency = 1;
        difficulty = getdvar( @"puzzle_difficulty", "<dev string:x13a>" );
        time = getdvarfloat( @"puzzle_time", 1 );
        var_194c3ef49c0313d9 = 0;
        param = "<dev string:x141>";
        use_set_frequencies = 1;
        use_stick_rotation_controls = 1;
        frequency_matching_puzzle::frequency_match_puzzle_open( widget, freq, amp, peaks, rate, falloff, perturbation, allow_exit, match_frequency, difficulty, time, var_194c3ef49c0313d9, param, use_set_frequencies, use_stick_rotation_controls );
        frequency_matching_puzzle::function_4b8de1a9e27d3e0e( 0.5, 0.5 );
        self waittill( #"frequency_match_puzzle_closed" );
    }

#/

// Namespace namespace_179a60483790d55e
// Params 1
// Checksum 0xf5ed7193, Offset: 0x63d6
// Size: 0xca
function gas_onentertrigger( trigger )
{
    if ( !isdefined( self.gastriggerstouching ) )
    {
        self.gastriggerstouching = [];
    }
    
    entnum = trigger getentitynumber();
    self.gastriggerstouching[ entnum ] = trigger;
    self.lastgastouchtime = gettime();
    self notify( #"hash_9292d26860c37712" );
    thread gas_grenade::function_5f57379dc2327524( trigger.owner, trigger );
    thread gas_grenade::function_1505269c0f0de5aa( trigger );
    
    if ( self.gastriggerstouching.size >= 1 )
    {
        thread gas_grenade::gas_applyspeedredux();
        thread gas_applyblur();
        thread gas_startcoughing( trigger.owner );
    }
    
    if ( !isdefined( self.loopingcoughaudio ) )
    {
        white_phosphorus::enableloopingcoughaudio( trigger.owner );
    }
    
    return entnum;
}

// Namespace namespace_179a60483790d55e
// Params 1
// Checksum 0x86d60b3c, Offset: 0x64a9
// Size: 0x6e
function gas_onexittrigger( trigger )
{
    triggerid = trigger getentitynumber();
    assert( isdefined( triggerid ), "<dev string:x148>" );
    
    if ( !isdefined( self.gastriggerstouching ) )
    {
        return;
    }
    
    self.gastriggerstouching[ triggerid ] = undefined;
    self.lastgastouchtime = gettime();
    
    if ( self.gastriggerstouching.size == 0 )
    {
        thread function_a72b7cc6cf273c45( trigger );
    }
}

// Namespace namespace_179a60483790d55e
// Params 1
// Checksum 0x7632fd9, Offset: 0x651f
// Size: 0x7d
function function_a72b7cc6cf273c45( trigger )
{
    self endon( #"hash_9292d26860c37712" );
    var_ac255db0656a7936 = trigger.owner.entnum ?? utility::get_entity_number( trigger.owner );
    wait 0.25;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    thread gas_grenade::gas_removespeedredux();
    thread gas_removeblur( var_ac255db0656a7936 );
    white_phosphorus::disableloopingcoughaudio();
    self notify( #"gas_exited" );
}

// Namespace namespace_179a60483790d55e
// Params 2
// Checksum 0xb6dec4e6, Offset: 0x65a4
// Size: 0x3a
function function_5f57379dc2327524( owner, trigger )
{
    utility::waittill_any( "death_or_disconnect", "last_stand_enter", "start_hallucination_immunity" );
    gas_grenade::gas_clear( !player::isreallyalive( self ) );
}

// Namespace namespace_179a60483790d55e
// Params 0
// Checksum 0x4a59f30, Offset: 0x65e6
// Size: 0xf0
function gas_watchtriggerexit()
{
    self endon( #"death" );
    
    while ( true )
    {
        foreach ( id, player in self.playersintrigger )
        {
            if ( !isdefined( player ) )
            {
                self.playersintrigger[ id ] = undefined;
                continue;
            }
            
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            if ( player istouching( self ) && !gas_grenade::function_8de1f4bd0dc11222( player ) && !player.var_193dad851d6389a4 )
            {
                continue;
            }
            
            self.playersintrigger[ player getentitynumber() ] = undefined;
            player thread gas_onexittrigger( self );
        }
        
        waitframe();
    }
}

// Namespace namespace_179a60483790d55e
// Params 0
// Checksum 0x94a930b9, Offset: 0x66de
// Size: 0x164
function gas_applyblur()
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_1f7a3b28c814e517" );
    self endon( #"hash_1f7a3b28c814e517" );
    
    if ( isdefined( self.perks[ "specialty_hallucination_immunity" ] ) )
    {
        return;
    }
    
    bundle = level.equipment.table[ "equip_gas_grenade" ].bundle;
    shockassetname = bundle.var_b45d254cca07a4d3;
    
    if ( isdefined( self.gastriggerstouching ) )
    {
        foreach ( trigger in self.gastriggerstouching )
        {
            if ( isdefined( trigger ) && trigger.owner == self )
            {
                /#
                    if ( getdvarint( @"hash_6c7fd12a611ca1e8", 0 ) == 1 )
                    {
                        break;
                    }
                #/
                
                shockassetname = bundle.gas_grenade_light_shock;
            }
        }
    }
    
    gas_grenade::function_dcb13d23fa969d90();
    
    while ( true )
    {
        shellshock_utility_cpmp::_shellshock( shockassetname, #"gas", 0.75, 0 );
        wait 0.3;
    }
}

// Namespace namespace_179a60483790d55e
// Params 1
// Checksum 0xd4ac7f00, Offset: 0x684a
// Size: 0x18
function gas_removeblur( var_ac255db0656a7936 )
{
    self notify( #"hash_1f7a3b28c814e517" );
}

// Namespace namespace_179a60483790d55e
// Params 1
// Checksum 0xfee6a49d, Offset: 0x686a
// Size: 0x74
function gas_startcoughing( triggerowner )
{
    self endon( #"gas_exited" );
    self endon( #"death_or_disconnect" );
    var_d11a327929f8b79 = getdvarfloat( @"hash_2ef09b292af0ff6d", 1 );
    var_52d22ca9520a034b = getdvarfloat( @"hash_e0de3305bf9cea1b", 1.5 );
    
    for ( ;; )
    {
        childthread gas_applycough( triggerowner, 1 );
        wait randomfloatrange( var_d11a327929f8b79, var_52d22ca9520a034b );
    }
}

// Namespace namespace_179a60483790d55e
// Params 2
// Checksum 0xec7ab34d, Offset: 0x68e6
// Size: 0x85
function gas_applycough( attacker, fromimpact )
{
    var_f51647acde95eb6d = isdefined( self.perks[ "specialty_gas_grenade_resist" ] );
    var_b660048a0793257a = self == attacker;
    
    if ( !var_b660048a0793257a && var_f51647acde95eb6d || self getinairpocket() )
    {
        return;
    }
    
    isheavy = 0;
    
    if ( fromimpact )
    {
        isheavy = 1;
    }
    
    if ( !self.gascoughinprogress || fromimpact )
    {
        thread gas_queuecough( isheavy );
    }
}

// Namespace namespace_179a60483790d55e
// Params 1
// Checksum 0x647f8952, Offset: 0x6973
// Size: 0x85
function gas_queuecough( isheavy )
{
    self endon( #"death_or_disconnect" );
    self endon( #"gas_clear_cough" );
    self endon( #"gas_exited" );
    self notify( #"gas_queue_cough" );
    self endon( #"gas_queue_cough" );
    var_458c575e2b8c77cf = gettime() + 1000;
    
    while ( gas_grenade::gas_coughisblocked() )
    {
        waitframe();
    }
    
    if ( isheavy && gettime() > var_458c575e2b8c77cf )
    {
        isheavy = 0;
    }
    
    thread gas_begincoughing( isheavy );
}

// Namespace namespace_179a60483790d55e
// Params 1
// Checksum 0xad280d89, Offset: 0x6a00
// Size: 0x160
function gas_begincoughing( isheavy )
{
    self endon( #"death_or_disconnect" );
    self endon( #"gas_clear_cough" );
    self notify( #"gas_begin_coughing" );
    self endon( #"gas_begin_coughing" );
    
    if ( !isnullweapon( self getheldoffhand() ) )
    {
        childthread gas_grenade::gas_takeheldoffhand();
    }
    
    self.gascoughinprogress = 1;
    var_af26ed837ee66f07 = scripted_weapons::get_scripted_weapon_object( #"gas_cough_light" );
    var_4e22443d07a9c648 = scripted_weapons::get_scripted_weapon_object( #"gas_cough_heavy" );
    
    if ( self hasweapon( var_af26ed837ee66f07 ) )
    {
        inventory_utility::_takeweapon( var_af26ed837ee66f07 );
    }
    
    if ( self hasweapon( var_4e22443d07a9c648 ) )
    {
        inventory_utility::_takeweapon( var_4e22443d07a9c648 );
    }
    
    weaponobj = isheavy ? var_4e22443d07a9c648 : var_af26ed837ee66f07;
    duration = isheavy ? 3.33 : 1.833;
    val::set( "gas_grenade", "supers", 0 );
    self giveandfireoffhand( weaponobj );
    childthread gas_grenade::gas_monitorcoughweaponfired( weaponobj );
    childthread gas_grenade::gas_monitorcoughweapontaken( weaponobj );
    childthread gas_grenade::gas_monitorcoughduration( duration );
    utility::waittill_any( "gas_coughWeaponFired", "gas_coughWeaponTaken", "gas_coughDuration" );
    val::reset( "gas_grenade", "supers" );
    
    if ( self hasweapon( weaponobj ) )
    {
        inventory_utility::_takeweapon( weaponobj );
    }
    
    self.gascoughinprogress = undefined;
}

// Namespace namespace_179a60483790d55e
// Params 0
// Checksum 0x6ba7bc9a, Offset: 0x6b68
// Size: 0x9
function sweepgas()
{
    thread gas_destroytrigger();
}

// Namespace namespace_179a60483790d55e
// Params 0
// Checksum 0x9cef39e9, Offset: 0x6b79
// Size: 0x13d
function gas_destroytrigger()
{
    if ( isdefined( self ) )
    {
        foreach ( player in self.playersintrigger )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            self.playersintrigger[ player getentitynumber() ] = undefined;
            player thread gas_onexittrigger( self );
        }
    }
    
    ent_manager::deregisterspawn();
    
    if ( isdefined( self.badplace ) )
    {
        destroynavobstacle( self.badplace );
    }
    
    if ( isdefined( self ) )
    {
        if ( self.owner && self.owner.gas_grenade_array )
        {
            self.owner.gas_grenade_array = arrayremove( self.owner.gas_grenade_array, self );
        }
        
        self delete();
    }
    
    if ( isarray( level.var_9f723c1b2e8c3484 ) )
    {
        level.var_9f723c1b2e8c3484 = function_5713d46873b29625( level.var_9f723c1b2e8c3484 );
    }
}

// Namespace namespace_179a60483790d55e
// Params 1, eflags: 0x4
// Checksum 0x640833c9, Offset: 0x6cbe
// Size: 0x1a7
function private function_cb7cf10550b2290( attacker )
{
    shockdata = spawnstruct();
    shockdata.tableinfo = weapon::getequipmenttableinfo( "equip_shockstick" );
    shockdata.owner = attacker;
    shockdata.team = attacker.team;
    shockdata.origin = attacker.origin;
    shockdata.weapon = shockdata.tableinfo.objweapon;
    shockdata.tableinfo.var_f3447a3874df563f = 0;
    shockdata.tableinfo.var_9891ed88bcd38fd2 = 1;
    shockdata.tableinfo.var_c6920ebeb7833310 = 1;
    shockdata.tableinfo.var_cd1e9f6afbf90d3a = 1;
    shockdata.tableinfo.bundle.var_f232776b54e76cfa = 0.3;
    shockdata.tableinfo.bundle.var_860545b754d7ecc0 = 2.5;
    shockdata.tableinfo.bundle.var_c8bb02c8c8cd0442 = 30;
    shockdata.tableinfo.bundle.shockstick_tickinterval = 0.2;
    shockdata.tableinfo.bundle.var_4c6cc0f99efbb64f = 1;
    return shockdata;
}

