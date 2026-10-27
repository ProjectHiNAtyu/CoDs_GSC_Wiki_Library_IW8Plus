// scripts\mp\common\field_upgrades\field_upgrades_dark_flare.gsc  (hash_16700203c75fe75f.gscc) (size: 25020 Bytes / 0x61bc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc1b14e77 (3249622647)
// size ...... 25020 (0x61bc)
// includes .. 25  (offset: 0x594c)
// strings ... 103 (offset: 0x5a14)
// dev strs .. 7   (offset: 0x6168)
// exports ... 36  (offset: 0x3d98)
// cseg ...... 0x880 + 0x3518 (0x3d98)
// imports ... 167 (offset: 0x4338)
// animtree1 . 0   (offset: 0x61bc)
// animtree2 . 0   (offset: 0x61bc)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\equipment\c4;
#using scripts\mp\common\equipment\ied;
#using scripts\mp\common\field_upgrades\field_upgrades;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\content_manager;
#using scripts\mp\supers;

#namespace field_upgrades_dark_flare;

// Namespace field_upgrades_dark_flare
// Params 0, eflags: 0x5
// Checksum 0x487166c7, Offset: 0x89e
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"dark_flare", undefined, undefined, &init );
}

// Namespace field_upgrades_dark_flare
// Params 0
// Checksum 0xfe7895d, Offset: 0x8bf
// Size: 0x2b4
function init()
{
    gametypebundle = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_zm_mode" );
    
    if ( isdefined( gametypebundle ) && isdefined( gametypebundle.var_ccc07a18713f8864 ) )
    {
        return;
    }
    
    superbundle = field_upgrades::function_1fcc83f10e7752e5( "super_dark_flare" );
    
    if ( !isdefined( superbundle ) )
    {
        return;
    }
    
    str_impact_fx = superbundle.var_3edd68b6f6e90ca1;
    var_75c76e1dd26a1b62 = superbundle.var_9151a905f37f6fa;
    str_beam_fx = superbundle.var_8be7c202cfedc853;
    var_5390747646e198c7 = superbundle.var_3edd68b6f6e90ca1;
    level._effect[ "dark_flare_impact_effect" ] = loadfxasset( str_impact_fx ?? "" );
    level._effect[ "dark_flare_ball_effect" ] = loadfxasset( var_75c76e1dd26a1b62 ?? "" );
    level._effect[ "dark_flare_beam_effect" ] = loadfxasset( str_beam_fx ?? "" );
    level._effect[ "dark_flare_impact_effect" ] = loadfxasset( var_5390747646e198c7 ?? "" );
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_dark_flare", &set_dark_flare, &unset_dark_flare, &begin_use_dark_flare, &function_f431c04ccd6969d7, undefined, &set_dark_flare );
    supers_mp::function_48aaa60b2ce7b8a1( "super_dark_flare_shadow_ball", undefined, &unset_dark_flare, &begin_use_dark_flare, &function_f431c04ccd6969d7, undefined );
    supers_mp::function_48aaa60b2ce7b8a1( "super_dark_flare_13s", undefined, &unset_dark_flare, &begin_use_dark_flare, &function_f431c04ccd6969d7, undefined );
    level.var_e18313301e451da3[ "super_dark_flare" ] = "super_dark_flare";
    level.var_e18313301e451da3[ "super_dark_flare_shadow_ball" ] = "super_dark_flare";
    level.var_e18313301e451da3[ "super_dark_flare_13s" ] = "super_dark_flare";
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_command( "<dev string:x3a>", "<dev string:x4a>" );
        devgui::add_devgui_command( "<dev string:x76>", "<dev string:x89>" );
        devgui::function_77df7fe7dd273e10();
    #/
    
    callback::add( "killed_body_cloned", &function_f6af973ecf59c35b );
    scene::function_85b13b837056bc8b( &function_ff39d3f01e6a7835 );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) )
    {
        if ( isdefined( level.field_upgrade_bundles[ "super_dark_flare" ] ) )
        {
            var_42a12fde1d871412 = level.field_upgrade_bundles[ "super_dark_flare" ].offhandweapon;
            utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", var_42a12fde1d871412, &on_killed_medal );
        }
    }
    
    level.dark_flare = { #var_28079045bda30435:[], #throttle:throttle::throttle_initialize( "dark_flare_throttle", 1 ) };
}

// Namespace field_upgrades_dark_flare
// Params 0
// Checksum 0x5dccb1f, Offset: 0xb7b
// Size: 0x1c3
function set_dark_flare()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( utility::ent_flag( "loadout_augments_setup_in_progress" ) )
    {
        utility::waittill_any_timeout( 3, "player_loadout_augments_given" );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_high_capacity" ) && !isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        perk::giveperk( "specialty_overcharge_field_upgrade" );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_extension" ) && !utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_shadow_ball" ) && !utility::flag( "dark_flare_augment_set" ) )
    {
        superinfo = supers_mp::getcurrentsuper();
        
        if ( self.super.staticdata.weaponname != "dark_flare_zm_13s" )
        {
            self notify( #"give_super_cancel" );
            waitframe();
            
            if ( supers_mp::getcurrentsuper() )
            {
                supers_mp::setsuperisinuse( 0 );
                thread function_6eb2a7dc5d780f1f( "super_dark_flare_13s" );
            }
        }
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_shadow_ball" ) && !utility::flag( "dark_flare_augment_set" ) )
    {
        superinfo = supers_mp::getcurrentsuper();
        
        if ( self.super.staticdata.weaponname != "dark_flare_zm_shadow_ball" )
        {
            self notify( #"give_super_cancel" );
            waitframe();
            
            if ( supers_mp::getcurrentsuper() )
            {
                supers_mp::setsuperisinuse( 0 );
                thread function_6eb2a7dc5d780f1f( "super_dark_flare_shadow_ball" );
            }
        }
    }
}

// Namespace field_upgrades_dark_flare
// Params 1
// Checksum 0x17ea5693, Offset: 0xd46
// Size: 0xa0
function function_6eb2a7dc5d780f1f( augment_name )
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_high_capacity" ) && isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        perk::removeperk( "specialty_overcharge_field_upgrade" );
    }
    
    supers_mp::clearsuper();
    utility::flag_set( "dark_flare_augment_set" );
    perkpackage::perkpackage_giveimmediate( augment_name, undefined, undefined, undefined, 0 );
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_high_capacity" ) )
    {
        perk::giveperk( "specialty_overcharge_field_upgrade" );
    }
}

// Namespace field_upgrades_dark_flare
// Params 0
// Checksum 0x599a990e, Offset: 0xdee
// Size: 0x9f
function unset_dark_flare()
{
    if ( self.super.staticdata.weaponname == "dark_flare_zm_13s" || self.super.staticdata.weaponname == "dark_flare_zm_shadow_ball" )
    {
        utility::flag_clear( "dark_flare_augment_set" );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_high_capacity" ) && isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        perk::removeperk( "specialty_overcharge_field_upgrade" );
    }
}

// Namespace field_upgrades_dark_flare
// Params 0
// Checksum 0xb07e3b61, Offset: 0xe95
// Size: 0x8b
function function_ff39d3f01e6a7835()
{
    foreach ( player in level.players )
    {
        if ( player utility::ent_flag( "dark_flare_active" ) )
        {
            player exit_dark_flare();
        }
    }
}

// Namespace field_upgrades_dark_flare
// Params 1
// Checksum 0x821431d6, Offset: 0xf28
// Size: 0x13
function function_5e4c8d81d666c458( params )
{
    exit_dark_flare();
}

// Namespace field_upgrades_dark_flare
// Params 0
// Checksum 0x57e97b5c, Offset: 0xf43
// Size: 0x7e
function exit_dark_flare()
{
    self stopgestureviewmodel();
    callback::remove( #"hash_9741c7ee14b21924", &function_5e4c8d81d666c458 );
    callback::remove( #"player_weapon_change", &function_5e4c8d81d666c458 );
    self.dark_flare_active = undefined;
    self.dark_flare_interrupted = 1;
    function_a77d049ba5227e1f();
    
    if ( isdefined( self.super.usepercent ) )
    {
        self.super.usepercent = 0;
    }
}

// Namespace field_upgrades_dark_flare
// Params 0
// Checksum 0x68abf95c, Offset: 0xfc9
// Size: 0x276
function begin_use_dark_flare()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( player::isinlaststand( self ) )
    {
        return;
    }
    
    if ( !callback::exists( #"hash_9741c7ee14b21924", &function_5e4c8d81d666c458 ) )
    {
        callback::add( #"hash_9741c7ee14b21924", &function_5e4c8d81d666c458 );
    }
    
    if ( !callback::exists( #"player_weapon_change", &function_5e4c8d81d666c458 ) )
    {
        callback::add( #"player_weapon_change", &function_5e4c8d81d666c458 );
    }
    
    val::set( "dark_flare", "fire", 0 );
    val::set( "dark_flare", "weapon_switch", 0 );
    val::set( "dark_flare", "offhand_primary_weapons", 0 );
    val::set( "dark_flare", "offhand_secondary_weapons", 0 );
    val::set( "dark_flare", "interactions", 0 );
    val::set( "dark_flare", "crouch", 0 );
    val::set( "dark_flare", "prone", 0 );
    val::set( "dark_flare", "script_weapon_switch", 1 );
    val::set( "dark_flare", "super_switching", 0 );
    val::set( "dark_flare", "vehicle_use", 0 );
    val::set( "dark_flare", "weapon_pickup", 0 );
    val::set( "dark_flare", "allow_grab", 0 );
    val::set( "dark_flare", "reload", 0 );
    val::set( "dark_flare", "disallow_loot_but_auto_loot", 1 );
    
    if ( isdefined( level.field_upgrade_bundles[ "super_dark_flare" ] ) )
    {
        if ( self getstance() != "stand" )
        {
            self setstance( "stand" );
        }
        
        var_42a12fde1d871412 = level.field_upgrade_bundles[ "super_dark_flare" ].offhandweapon;
        deploysuccess = field_upgrades::field_upgrade_play_gesture( var_42a12fde1d871412, "super_dark_flare" );
        
        if ( deploysuccess )
        {
            currentweapon = self getcurrentweapon();
            
            if ( !currentweapon.isdualwield )
            {
                utility::function_7c10ea82c1e305b8( "wand_fx", "wand_on_dark_flare" );
            }
            
            if ( utility::ent_flag( "dark_flare_active" ) )
            {
                return 0;
            }
            
            self.dark_flare_interrupted = undefined;
            thread dark_flare_active( var_42a12fde1d871412 );
            return 1;
        }
    }
    
    val::reset_all( "dark_flare" );
    callback::remove( #"hash_9741c7ee14b21924", &function_5e4c8d81d666c458 );
    callback::remove( #"player_weapon_change", &function_5e4c8d81d666c458 );
    return 0;
}

// Namespace field_upgrades_dark_flare
// Params 2
// Checksum 0x83b2ac1e, Offset: 0x1248
// Size: 0x2c, Type: bool
function function_f431c04ccd6969d7( fromdeath, attacker )
{
    level endon( #"game_ended" );
    thread function_9531467167d06bb9( fromdeath, attacker );
    return false;
}

// Namespace field_upgrades_dark_flare
// Params 2, eflags: 0x4
// Checksum 0xf5685f01, Offset: 0x127d
// Size: 0x1d1
function private function_9531467167d06bb9( fromdeath, attacker )
{
    wait 0.5;
    function_a77d049ba5227e1f();
    
    if ( !self.dark_flare_interrupted )
    {
        thread dark_flare_reset_delay();
    }
    else
    {
        supers_mp::updatesuperuiprogress();
        val::reset_all( "dark_flare" );
        utility::ent_flag_clear( "dark_flare_active" );
    }
    
    if ( isdefined( self.damagedzombies ) )
    {
        foreach ( zombie in self.damagedzombies )
        {
            zombie.dark_flare_slowed = undefined;
            zombie val::reset_all( "dark_flare_dismember" );
        }
        
        self.damagedzombies = function_5713d46873b29625( self.damagedzombies );
    }
    
    if ( !isdefined( self.shadow_ball ) )
    {
        self notify( #"end_dark_flare" );
    }
    
    callback::callback( "field_upgrade_ended", { #ref:"super_dark_flare" } );
    
    if ( self.var_45b23a9c47825133 && utility::issharedfuncdefined( #"sound", #"play_scoreevent_vo", 0 ) )
    {
        utility::callsharedfunc( #"sound", #"play_scoreevent_vo", self, #"bc_super_dark_flare_success" );
    }
    
    self.var_45b23a9c47825133 = undefined;
    callback::remove( #"hash_9741c7ee14b21924", &function_5e4c8d81d666c458 );
    callback::remove( #"player_weapon_change", &function_5e4c8d81d666c458 );
    utility::ent_flag_clear( "dark_flare_active" );
    utility::ent_flag_clear( "field_upgrade_in_use" );
}

// Namespace field_upgrades_dark_flare
// Params 0
// Checksum 0x8141902e, Offset: 0x1456
// Size: 0x2c
function dark_flare_reset_delay()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 1.75;
    val::reset_all( "dark_flare" );
}

// Namespace field_upgrades_dark_flare
// Params 4
// Checksum 0x1e252f64, Offset: 0x148a
// Size: 0x311
function get_enemies_in_beam( potential_enemies, playercenter, castend, radius )
{
    player_axis = anglestoaxis( self getplayerangles() );
    playerleft = playercenter - player_axis[ "right" ] * radius;
    playerright = playercenter + player_axis[ "right" ] * radius;
    playerup = playercenter + player_axis[ "up" ] * radius;
    playerdown = playercenter - player_axis[ "up" ] * radius;
    endleft = castend - player_axis[ "right" ] * radius + player_axis[ "forward" ] * radius;
    endright = castend + player_axis[ "right" ] * radius + player_axis[ "forward" ] * radius;
    endup = castend + player_axis[ "up" ] * radius + player_axis[ "forward" ] * radius;
    enddown = castend - player_axis[ "up" ] * radius + player_axis[ "forward" ] * radius;
    contents = physics_createcontents( [ "physicscontents_characterproxy", "physicscontents_trigger", "physicscontents_missileclip" ] );
    
    if ( !isdefined( potential_enemies ) )
    {
        potential_enemies = [];
    }
    
    ignore_list = update_ignore_list( potential_enemies, [] );
    var_b93a52c567d8b963 = physics_raycast( playerleft, endleft, contents, ignore_list, 0, "physicsquery_all", 0, 1 );
    ignore_list = update_ignore_list( var_b93a52c567d8b963, ignore_list );
    var_ccdce6f0ba316872 = physics_raycast( playerright, endright, contents, ignore_list, 0, "physicsquery_all", 0, 1 );
    ignore_list = update_ignore_list( var_ccdce6f0ba316872, ignore_list );
    var_2c75f73f12cac7b3 = physics_raycast( playerup, endup, contents, ignore_list, 0, "physicsquery_all", 0, 1 );
    ignore_list = update_ignore_list( var_2c75f73f12cac7b3, ignore_list );
    var_7903f098ebc14dc2 = physics_raycast( playerdown, enddown, contents, ignore_list, 0, "physicsquery_all", 0, 1 );
    ignore_list = update_ignore_list( var_7903f098ebc14dc2, ignore_list );
    
    /#
        if ( getdvarint( @"hash_b3259748a4962ef8", 0 ) )
        {
            var_d4618b70ea2e3eee = int( 0.1 / level.framedurationseconds );
            line( playerleft, endleft, var_b93a52c567d8b963.size > 0 ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1, 1, var_d4618b70ea2e3eee );
            line( playerright, endright, var_ccdce6f0ba316872.size > 0 ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1, 1, var_d4618b70ea2e3eee );
            line( playerup, endup, var_2c75f73f12cac7b3.size > 0 ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1, 1, var_d4618b70ea2e3eee );
            line( playerdown, enddown, var_7903f098ebc14dc2.size > 0 ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1, 1, var_d4618b70ea2e3eee );
        }
    #/
    
    potential_enemies = arraycombine( potential_enemies, var_b93a52c567d8b963, var_ccdce6f0ba316872, var_2c75f73f12cac7b3, var_7903f098ebc14dc2 );
    return potential_enemies;
}

// Namespace field_upgrades_dark_flare
// Params 2
// Checksum 0x7022af41, Offset: 0x17a4
// Size: 0x9c
function update_ignore_list( traced_enemies, ignore_list )
{
    foreach ( result in traced_enemies )
    {
        if ( !isdefined( result[ "entity" ] ) )
        {
            continue;
        }
        
        ignore_list[ ignore_list.size ] = result[ "entity" ];
    }
    
    return ignore_list;
}

// Namespace field_upgrades_dark_flare
// Params 1
// Checksum 0x6a255242, Offset: 0x1849
// Size: 0x956
function dark_flare_active( var_42a12fde1d871412 )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    utility::ent_flag_init( "field_upgrade_in_use" );
    utility::ent_flag_set( "field_upgrade_in_use" );
    utility::ent_flag_set( "dark_flare_active" );
    self.dark_flare_active = 1;
    self.var_416620a8510f63b4 = field_upgrades::function_5f728868b18ef0c0( "super_dark_flare", "darkFlareBeamDistance" );
    self.var_3721c1b150f3b38f = field_upgrades::function_5f728868b18ef0c0( "super_dark_flare", "darkFlareCylinderDiameter" );
    self.var_dc58879cfee40e71 = field_upgrades::function_5f728868b18ef0c0( "super_dark_flare", "darkFlareDuration" );
    self.var_309d3d200b85f4ed = field_upgrades::function_5f728868b18ef0c0( "super_dark_flare", "darkFlareMinDamage" );
    self.n_base_damage_percent = field_upgrades::function_5f728868b18ef0c0( "super_dark_flare", "darkFlareBaseDamagePerTick" );
    self.var_61dbbf5af2fa3237 = field_upgrades::function_5f728868b18ef0c0( "super_dark_flare", "darkFlareSpecialDamageCap" );
    self.var_6f444fb48f289d53 = field_upgrades::function_5f728868b18ef0c0( "super_dark_flare", "darkFlareEliteDamageCap" );
    self.var_ebd32538cfd5ffeb = field_upgrades::function_5f728868b18ef0c0( "super_dark_flare", "darkFlareBossDamageCap" );
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_big_beam" ) )
    {
        n_big_beam = 1;
        self.var_3721c1b150f3b38f += self.var_3721c1b150f3b38f * ( level.zombie_augments[ #"dark_flare_big_beam" ].var_2b9583cab7dd0cb5 ?? 0 );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_dark_pact" ) )
    {
        self.var_9c4020f1fd9d7b4e = 1;
        val::reset( "dark_flare_revive", "toggle_remote_revive" );
        self.var_f0f37c5c0e8dc20c = level.zombie_augments[ #"dark_flare_dark_pact" ].var_f671e1194dbb9386 ?? 0;
        self.var_16a6377471fb6976 = level.zombie_augments[ #"dark_flare_dark_pact" ].var_16a6377471fb6976 ?? 0;
        thread function_98b32b6f04e02c53();
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_extension" ) )
    {
        self.var_dc58879cfee40e71 += self.var_dc58879cfee40e71 * ( level.zombie_augments[ #"dark_flare_extension" ].var_9549061ff7d3fc70 ?? 0 );
    }
    
    castcontents = trace::create_contents( 0, 1, 1, 0, 1, 0 );
    var_1a8e86b2afb6be4f = trace::create_contents( 1, 0, 0, 0, 0, 0 );
    contents = physics_createcontents( [ "physicscontents_characterproxy", "physicscontents_trigger", "physicscontents_missileclip" ] );
    level.beamTickThrottle = throttle::throttle_initialize( "beamTickThrottle", 1, utility::function_6f5d2e1f1ff70482( 100 ) );
    start_time = gettime();
    current_time = 0;
    wait 0.5;
    function_e4cf58e5cd81aa53();
    self.damagedzombies = [];
    self.var_42a12fde1d871412 = var_42a12fde1d871412;
    self.var_2c57898bedf02d26 = [];
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_shadow_ball" ) )
    {
        n_vel = level.zombie_augments[ #"dark_flare_shadow_ball" ].var_cbbf82ca761b79a6 ?? 0;
        n_rad = level.zombie_augments[ #"dark_flare_shadow_ball" ].var_281f88c80c8d9819 ?? 0;
        new_shadow_ball = content_manager::spawn_script_model( self, "tag_origin_shadow_ball", 0, 1 );
        self_forward = vectornormalize( anglestoforward( self getplayerangles() ) ) * 30;
        
        if ( self issprinting() || self issprintsliding() )
        {
            self_forward = vectornormalize( anglestoforward( self getplayerangles() ) ) * 50;
        }
        
        new_shadow_ball.origin = self gettagorigin( "j_head" ) + self_forward;
        dist = n_vel * self.var_dc58879cfee40e71;
        v_forward = anglestoforward( self getplayerangles() ) * dist;
        new_shadow_ball moveto( new_shadow_ball.origin + v_forward, self.var_dc58879cfee40e71 );
        
        if ( n_big_beam )
        {
            new_shadow_ball utility::function_7c10ea82c1e305b8( "particle", "particle_big" );
        }
        else
        {
            new_shadow_ball utility::function_7c10ea82c1e305b8( "particle", "particle" );
        }
        
        if ( !isdefined( self.var_aa6eb7083ba75f0b ) )
        {
            self.var_aa6eb7083ba75f0b = [];
        }
        
        if ( !arraycontains( self.var_aa6eb7083ba75f0b, new_shadow_ball ) )
        {
            self.var_aa6eb7083ba75f0b[ self.var_aa6eb7083ba75f0b.size ] = new_shadow_ball;
            thread function_d4fc6dc5e373892d( new_shadow_ball );
        }
    }
    else
    {
        phantasmal_angle = undefined;
        phantasmal_range = undefined;
        
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_phantasmal" ) )
        {
            phantasmal_angle = level.zombie_augments[ #"dark_flare_phantasmal" ].var_3800717341db17cf ?? 0;
            phantasmal_range = level.zombie_augments[ #"dark_flare_phantasmal" ].var_aa38f68d540e49a8 ?? 0;
        }
        
        while ( current_time < self.var_dc58879cfee40e71 )
        {
            self.var_2c57898bedf02d26 = [];
            current_time = utility::function_6f5d2e1f1ff70482( gettime() - start_time );
            
            if ( utility::ent_flag( "interrupt_dark_flare" ) )
            {
                current_time = self.var_dc58879cfee40e71;
                thread exit_dark_flare();
                break;
            }
            
            if ( self.dark_flare_interrupted )
            {
                current_time = self.var_dc58879cfee40e71;
            }
            
            if ( current_time >= self.var_dc58879cfee40e71 )
            {
                break;
            }
            
            if ( !val::get( "weapon" ) )
            {
                current_time = self.var_dc58879cfee40e71;
                thread exit_dark_flare();
            }
            
            playercenter = self gettagorigin( "j_head" );
            playerforward = anglestoforward( self getplayerangles() );
            castend = playercenter + playerforward * self.var_416620a8510f63b4;
            castresult = physics_raycast( playercenter, castend, castcontents, level.players, 0, "physicsquery_closest" );
            
            if ( isdefined( castresult ) )
            {
                if ( castresult.size != 0 )
                {
                    castend = castresult[ 0 ][ "position" ] + playerforward * 0.1;
                }
                
                var_f70e53b05181e8c6 = level.var_e3465ddef476b330 ?? 0;
                potential_enemies = physics_raycast( playercenter, castend, contents, undefined, var_f70e53b05181e8c6, "physicsquery_all", 0, 1 );
                
                if ( !isdefined( potential_enemies ) )
                {
                    potential_enemies = [];
                }
                
                if ( isdefined( phantasmal_angle ) )
                {
                    angle_interval = 15;
                    positive_angle = phantasmal_angle / 2;
                    
                    while ( positive_angle > 0 )
                    {
                        playerpos = anglestoforward( self getplayerangles() + ( 0, positive_angle, 0 ) );
                        var_7be42314eba71a90 = playercenter + playerpos * phantasmal_range;
                        potential_enemies_pos = physics_raycast( playercenter, var_7be42314eba71a90, contents, undefined, var_f70e53b05181e8c6, "physicsquery_all", 0, 1 );
                        potential_enemies = arraycombine( potential_enemies, potential_enemies_pos );
                        
                        /#
                            if ( getdvarint( @"hash_b3259748a4962ef8", 0 ) )
                            {
                                line( playercenter, var_7be42314eba71a90, potential_enemies.size > 0 ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1, 1, int( 0.1 / level.framedurationseconds ) );
                            }
                        #/
                        
                        positive_angle -= angle_interval;
                        waitframe();
                    }
                    
                    negative_angle = phantasmal_angle / 2 * -1;
                    
                    while ( negative_angle < 0 )
                    {
                        playerneg = anglestoforward( self getplayerangles() + ( 0, negative_angle, 0 ) );
                        var_d28e11556353774 = playercenter + playerneg * phantasmal_range;
                        potential_enemies_neg = physics_raycast( playercenter, var_d28e11556353774, contents, undefined, var_f70e53b05181e8c6, "physicsquery_all", 0, 1 );
                        potential_enemies = arraycombine( potential_enemies, potential_enemies_neg );
                        
                        /#
                            if ( getdvarint( @"hash_b3259748a4962ef8", 0 ) )
                            {
                                line( playercenter, var_d28e11556353774, potential_enemies.size > 0 ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1, 1, int( 0.1 / level.framedurationseconds ) );
                            }
                        #/
                        
                        negative_angle += angle_interval;
                        waitframe();
                    }
                }
                
                potential_enemies = get_enemies_in_beam( potential_enemies, playercenter, castend, self.var_3721c1b150f3b38f / 2 );
                
                if ( n_big_beam )
                {
                    potential_enemies = get_enemies_in_beam( potential_enemies, playercenter, castend, self.var_3721c1b150f3b38f / 4 );
                }
                
                if ( utility::issharedfuncdefined( #"dark_flare", #"hash_d3bbf1093b70aec7" ) )
                {
                    self thread [[ utility::getsharedfunc( #"dark_flare", #"hash_d3bbf1093b70aec7" ) ]]( potential_enemies );
                }
                
                function_e0d77bc1a18176e9( castend, self.var_3721c1b150f3b38f / 2 );
                self.damagedzombies = function_46f9072493651dc9( self.damagedzombies );
                calculate_damage( potential_enemies );
            }
            
            self notify( #"dark_flare_tick" );
            
            if ( isdefined( level.beamTickThrottle ) )
            {
                throttle::throttle_wait_in_queue( level.beamTickThrottle, self );
            }
            
            wait 0.1;
        }
    }
    
    val::reset( "dark_flare_revive", "toggle_remote_revive" );
}

// Namespace field_upgrades_dark_flare
// Params 0
// Checksum 0x8a33b195, Offset: 0x21a7
// Size: 0x2d9
function function_98b32b6f04e02c53()
{
    self endon( #"end_dark_flare" );
    str_team = self.team;
    self.var_2c57898bedf02d26 = [];
    
    while ( self.dark_flare_active )
    {
        var_e71d4811bfa1d660 = undefined;
        
        foreach ( player in self.var_2c57898bedf02d26 )
        {
            if ( player.inlaststand )
            {
                if ( !player.beingrevived && isdefined( player.laststandreviveent ) )
                {
                    player.beingremoterevived = 1;
                    
                    if ( !player.var_59bdb583f92af3d1 )
                    {
                        player.var_59bdb583f92af3d1 = 1;
                        val::set( "dark_flare_revive", "toggle_remote_revive", 1 );
                        reviveent = player.laststandreviveent;
                        reviveent notify( #"trigger", self );
                    }
                }
            }
        }
        
        var_e71d4811bfa1d660 = undefined;
        
        foreach ( player in level.players )
        {
            if ( player.team != str_team )
            {
                continue;
            }
            
            if ( !arraycontains( self.var_2c57898bedf02d26, player ) && player.var_59bdb583f92af3d1 )
            {
                player.beingremoterevived = undefined;
                player.var_59bdb583f92af3d1 = undefined;
                continue;
            }
            
            if ( arraycontains( self.var_2c57898bedf02d26, player ) && player.var_59bdb583f92af3d1 )
            {
                var_e71d4811bfa1d660 = 1;
            }
        }
        
        if ( !var_e71d4811bfa1d660 )
        {
            val::reset( "dark_flare_revive", "toggle_remote_revive" );
        }
        
        waitframe();
    }
    
    foreach ( player in level.players )
    {
        if ( player.team != str_team )
        {
            continue;
        }
        
        player.beingremoterevived = undefined;
        player.var_59bdb583f92af3d1 = undefined;
    }
    
    val::reset( "dark_flare_revive", "toggle_remote_revive" );
}

// Namespace field_upgrades_dark_flare
// Params 1
// Checksum 0xb98122ed, Offset: 0x2488
// Size: 0x7aa
function calculate_damage( potential_enemies )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( isdefined( potential_enemies ) && potential_enemies.size != 0 )
    {
        /#
        #/
        
        processed_scriptables = [];
        var_8a24917f6d586fa3 = damage_utility::function_cf1c753aefa70ea1( self.team );
        
        foreach ( potential_target in potential_enemies )
        {
            if ( isdefined( potential_target[ "entity" ] ) && arraycontains( level.dark_flare.var_28079045bda30435, potential_target[ "entity" ] ) )
            {
                if ( isdefined( potential_target[ "entity" ].proxy ) )
                {
                    if ( potential_target[ "entity" ].proxy isscriptableinstance() )
                    {
                        potential_target[ "entity" ].proxy scriptabledodamage( 10, self, self, potential_target[ "position" ], ( 0, 0, 0 ), "MOD_ELEMENTAL_DARK", self.var_42a12fde1d871412 );
                    }
                }
                else
                {
                    ent = potential_target[ "entity" ];
                    var_bd92b960a5e8dd16 = potential_target[ "position" ] ?? ent.origin;
                    
                    if ( isai( ent ) )
                    {
                        round_difficulty = ent zombie_utils::get_zombie_round_difficulty();
                    }
                    else
                    {
                        round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
                    }
                    
                    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
                    
                    if ( !isdefined( zombie_base_health ) )
                    {
                        zombie_base_health = 100;
                    }
                    
                    n_damage = int( zombie_base_health * self.n_base_damage_percent );
                    
                    if ( n_damage < self.var_309d3d200b85f4ed )
                    {
                        n_damage = self.var_309d3d200b85f4ed;
                    }
                    
                    ent dodamage( n_damage, var_bd92b960a5e8dd16, self, self, "MOD_ELEMENTAL_DARK", self.var_42a12fde1d871412, undefined, undefined, 1610678272 );
                }
                
                throttle::throttle_wait_in_queue( level.dark_flare.throttle, potential_target[ "entity" ] );
                continue;
            }
            else if ( isdefined( potential_target[ "entity" ] ) && arraycontains( var_8a24917f6d586fa3, potential_target[ "entity" ] ) )
            {
                ent = potential_target[ "entity" ];
                var_bd92b960a5e8dd16 = potential_target[ "position" ] ?? ent.origin;
                
                if ( isai( ent ) )
                {
                    round_difficulty = ent zombie_utils::get_zombie_round_difficulty();
                }
                else
                {
                    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
                }
                
                zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
                
                if ( !isdefined( zombie_base_health ) )
                {
                    zombie_base_health = 100;
                }
                
                n_damage = int( zombie_base_health * self.n_base_damage_percent );
                
                if ( n_damage < self.var_309d3d200b85f4ed )
                {
                    n_damage = self.var_309d3d200b85f4ed;
                }
                
                ent dodamage( n_damage, var_bd92b960a5e8dd16, self, self, "MOD_ELEMENTAL_DARK", self.var_42a12fde1d871412, undefined, undefined, 1610678272 );
            }
            else if ( isdefined( potential_target[ "scriptable" ] ) && arraycontains( level.dark_flare.var_28079045bda30435, potential_target[ "scriptable" ] ) )
            {
                if ( potential_target[ "scriptable" ] isscriptableinstance() && !arraycontains( processed_scriptables, potential_target[ "scriptable" ] ) )
                {
                    potential_target[ "scriptable" ] scriptabledodamage( 10, self, self, potential_target[ "position" ], ( 0, 0, 0 ), "MOD_ELEMENTAL_DARK", self.var_42a12fde1d871412 );
                    processed_scriptables[ processed_scriptables.size ] = potential_target[ "scriptable" ];
                    throttle::throttle_wait_in_queue( level.dark_flare.throttle, potential_target );
                }
                
                continue;
            }
            
            if ( isalive( potential_target[ "entity" ] ) && potential_target[ "entity" ].team != self.team )
            {
                zombie = potential_target[ "entity" ];
                zombie val::set( "dark_flare_dismember", "allow_dismember", 0 );
                
                if ( ( isagent( zombie ) || isplayer( zombie ) ) && isalive( zombie ) && zombie.team != self.team )
                {
                    if ( isalive( zombie ) && !arraycontains( self.damagedzombies, zombie ) )
                    {
                        self.damagedzombies[ self.damagedzombies.size ] = zombie;
                        zombie thread watch_impact_fx();
                    }
                    
                    var_bd92b960a5e8dd16 = potential_target[ "position" ] ?? zombie.origin;
                    round_difficulty = zombie zombie_utils::get_zombie_round_difficulty();
                    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
                    
                    if ( !isdefined( zombie_base_health ) )
                    {
                        zombie_base_health = 100;
                    }
                    
                    n_damage = int( zombie_base_health * self.n_base_damage_percent );
                    
                    if ( isagent( zombie ) && n_damage >= zombie.health )
                    {
                        zombie.killed_by_dark_flare = 1;
                    }
                    
                    if ( n_damage < self.var_309d3d200b85f4ed )
                    {
                        n_damage = self.var_309d3d200b85f4ed;
                    }
                    
                    zombie dodamage( n_damage, var_bd92b960a5e8dd16, self, self, "MOD_ELEMENTAL_DARK", self.var_42a12fde1d871412, undefined, undefined, 1610678272 );
                    shadow_burn( zombie );
                    
                    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_slowdown" ) )
                    {
                        can_affect = 1;
                        
                        if ( utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
                        {
                            can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( self, zombie );
                        }
                        
                        if ( can_affect && !zombie.dark_flare_slowed )
                        {
                            zombie.dark_flare_slowed = 1;
                            var_450de6d5cec91203 = level.zombie_augments[ #"dark_flare_slowdown" ].var_e1b4f0a6fbe716c5 ?? 0;
                            zombie effect_slow::slow( "dark_flare_slowdown", var_450de6d5cec91203, 2, self, &function_cb9164f240124e13, undefined, "dark" );
                        }
                    }
                    
                    throttle::throttle_wait_in_queue( level.dark_flare.throttle, zombie );
                }
                
                /#
                #/
            }
            
            if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_dark_pact" ) )
            {
                if ( isplayer( potential_target[ "entity" ] ) && potential_target[ "entity" ] != self && potential_target[ "entity" ].team == self.team )
                {
                    player = potential_target[ "entity" ];
                    can_affect = 1;
                    
                    if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
                    {
                        can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, player );
                    }
                    
                    if ( can_affect )
                    {
                        if ( !arraycontains( self.var_2c57898bedf02d26, player ) )
                        {
                            self.var_2c57898bedf02d26[ self.var_2c57898bedf02d26.size ] = player;
                        }
                        
                        if ( utility::ent_flag( "disable_player_heal_items" ) )
                        {
                            return;
                        }
                        
                        if ( !player::isinlaststand( player ) )
                        {
                            if ( !isdefined( self.var_f0f37c5c0e8dc20c ) )
                            {
                                self.var_f0f37c5c0e8dc20c = 0;
                            }
                            
                            player thread function_107233ea77c5384a( 2 );
                            healthtotal = player.health + self.var_f0f37c5c0e8dc20c;
                            player.health = int( clamp( healthtotal, player.health, player.maxhealth ) );
                        }
                    }
                }
            }
        }
    }
}

// Namespace field_upgrades_dark_flare
// Params 1
// Checksum 0x3eb9b596, Offset: 0x2c3a
// Size: 0x174
function shadow_burn( zombie )
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_shadow_burn" ) )
    {
        shadow_burn_percent = level.zombie_augments[ #"dark_flare_shadow_burn" ].var_2f8134201309c201 ?? 0;
        shadow_burn_duration = level.zombie_augments[ #"dark_flare_shadow_burn" ].var_7335bcf1eba6e077 ?? 0;
        round_difficulty = zombie zombie_utils::get_zombie_round_difficulty();
        base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        
        if ( isdefined( zombie.aicategory ) )
        {
            switch ( zombie.aicategory )
            {
                case #"hash_8c089e813083e510":
                    burn_damage = int( base_zombie_maxhealth * shadow_burn_percent );
                    zombie effect_burn::burn( shadow_burn_duration, burn_damage, 1, self, undefined, undefined, undefined, "shadow", undefined, self.super.weaponobj, 1 );
                    break;
                case #"hash_7b0e2f2ed84f34":
                    burn_damage = int( base_zombie_maxhealth * shadow_burn_percent );
                    zombie effect_burn::burn( shadow_burn_duration, burn_damage, 1, self, undefined, undefined, undefined, "shadow", undefined, self.super.weaponobj, 1 );
                    break;
                default:
                    break;
            }
        }
    }
}

// Namespace field_upgrades_dark_flare
// Params 1
// Checksum 0xeaebf97, Offset: 0x2db6
// Size: 0x2e8
function function_d4fc6dc5e373892d( shadow_ball )
{
    level endon( #"game_ended" );
    callback::add( #"player_disconnect", &shadow_ball_cleanup, shadow_ball );
    self.dark_flare_active = 1;
    castcontents = trace::create_contents( 0, 1, 1, 0, 1, 0 );
    var_1a8e86b2afb6be4f = trace::create_contents( 1, 0, 0, 0, 0, 0 );
    level.beamTickThrottle = throttle::throttle_initialize( "beamTickThrottle", 1, utility::function_6f5d2e1f1ff70482( 100 ) );
    start_time = gettime();
    current_time = 0;
    self.damagedzombies = [];
    n_rad = level.zombie_augments[ #"dark_flare_shadow_ball" ].var_281f88c80c8d9819 ?? 0;
    var_b89737961560d863 = level.zombie_augments[ #"dark_flare_shadow_ball" ].var_12f836e3de4128b0 ?? 0;
    n_pulse_rad = level.zombie_augments[ #"dark_flare_shadow_ball" ].var_ca50ce23ee0c7d5a ?? 0;
    contents = physics_createcontents( [ "physicscontents_characterproxy", "physicscontents_trigger", "physicscontents_missileclip" ] );
    n_big_beam = undefined;
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_big_beam" ) )
    {
        n_big_beam = 1;
        n_rad += n_rad * ( level.zombie_augments[ #"dark_flare_big_beam" ].var_2b9583cab7dd0cb5 ?? 0 );
    }
    
    while ( current_time < self.var_dc58879cfee40e71 )
    {
        self.var_2c57898bedf02d26 = [];
        current_time = utility::function_6f5d2e1f1ff70482( gettime() - start_time );
        
        if ( isdefined( shadow_ball ) )
        {
            potential_enemies = undefined;
            potential_enemies = physics_querypoint( shadow_ball.origin, n_rad, contents, undefined, "physicsquery_all" );
            var_1e94abfb26054955 = physics_querypoint( shadow_ball.origin, 5, trace::create_default_contents( 1 ), undefined, "physicsquery_all" );
            
            if ( utility::issharedfuncdefined( #"dark_flare", #"hash_d3bbf1093b70aec7" ) )
            {
                self thread [[ utility::getsharedfunc( #"dark_flare", #"hash_d3bbf1093b70aec7" ) ]]( potential_enemies );
            }
            
            function_e0d77bc1a18176e9( shadow_ball.origin, n_rad );
            
            if ( var_1e94abfb26054955.size > 0 )
            {
                break;
            }
            
            self.damagedzombies = function_46f9072493651dc9( self.damagedzombies );
            calculate_damage( potential_enemies );
        }
        
        if ( isdefined( level.beamTickThrottle ) )
        {
            throttle::throttle_wait_in_queue( level.beamTickThrottle, self );
        }
        
        wait 0.1;
    }
    
    function_15ff20fb89e48251( shadow_ball, n_pulse_rad, var_b89737961560d863, n_big_beam );
    thread shadow_ball_cleanup( undefined, shadow_ball );
}

// Namespace field_upgrades_dark_flare
// Params 2
// Checksum 0x71ce225f, Offset: 0x30a6
// Size: 0x60
function shadow_ball_cleanup( sparams, shadow_ball )
{
    if ( isdefined( self ) )
    {
        callback::remove( #"player_disconnect", &shadow_ball_cleanup );
        arrayremove( self.var_aa6eb7083ba75f0b, shadow_ball );
    }
    
    if ( !shadow_ball )
    {
        return;
    }
    
    shadow_ball utility::function_7c10ea82c1e305b8( "particle", "off" );
    shadow_ball delete();
}

// Namespace field_upgrades_dark_flare
// Params 4
// Checksum 0xa0b811ba, Offset: 0x310e
// Size: 0x3cc
function function_15ff20fb89e48251( shadow_ball, n_rad, var_b89737961560d863, big_beam )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !shadow_ball )
    {
        return;
    }
    
    shadow_ball endon( #"death" );
    s_killstreak_bundle = level.streakglobals.streakbundles[ "rcxd" ];
    n_radius = n_rad;
    var_b89737961560d863 = var_b89737961560d863;
    
    if ( big_beam )
    {
        shadow_ball utility::function_7c10ea82c1e305b8( "aether_pulse", "on_big" );
    }
    else
    {
        shadow_ball utility::function_7c10ea82c1e305b8( "aether_pulse", "on" );
    }
    
    a_zombies = getaiarrayinradius( shadow_ball.origin, n_radius );
    
    foreach ( zombie in a_zombies )
    {
        if ( isalive( zombie ) && !arraycontains( self.damagedzombies, zombie ) )
        {
            self.damagedzombies[ self.damagedzombies.size ] = zombie;
        }
        
        if ( isai( zombie ) && isalive( zombie ) && zombie.team != self.team )
        {
            var_bd92b960a5e8dd16 = zombie.origin;
            round_difficulty = zombie zombie_utils::get_zombie_round_difficulty();
            zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
            
            if ( !isdefined( zombie_base_health ) )
            {
                zombie_base_health = 100;
            }
            
            n_damage = int( zombie_base_health * var_b89737961560d863 );
            
            if ( n_damage >= zombie.health )
            {
                zombie.killed_by_dark_flare = 1;
            }
            
            var_471b16bf43cda71a = !zombie zombie_traverse::is_traversing();
            var_24ed309d808c077a = zombie getcorpseentity();
            
            if ( var_471b16bf43cda71a && isdefined( var_24ed309d808c077a ) )
            {
                var_24ed309d808c077a thread ragdoll_activate( shadow_ball );
            }
            
            if ( n_damage < self.var_578d71b7c00fc4ba )
            {
                n_damage = self.var_578d71b7c00fc4ba;
            }
            
            zombie dodamage( n_damage, var_bd92b960a5e8dd16, self, self, "MOD_ELEMENTAL_DARK", undefined, undefined, undefined, 1073807360 );
            shadow_burn( zombie );
        }
        
        corpses = function_955f614470e71cb2( shadow_ball.origin, n_rad );
        
        foreach ( corpse in corpses )
        {
            corpse thread ragdoll_activate( shadow_ball );
        }
    }
    
    waitframe();
    v_explosion = shadow_ball.origin;
    earthquake( 0.2, level.streakglobals.streakbundles[ "rcxd" ].var_3b037088c6e733f9 * 0.25, v_explosion, n_radius );
    playrumbleonposition( "grenade_rumble", v_explosion );
    physicsexplosionsphere( v_explosion, n_radius, 0, 200, 0 );
    self radiusdamage( shadow_ball.origin, n_radius, s_killstreak_bundle.var_795b7c0589ec54d, s_killstreak_bundle.var_771a1c058761a33, self, "MOD_ELEMENTAL_DARK" );
    glassradiusdamage( shadow_ball.origin, n_radius, 200, 100 );
    shadow_ball utility::function_7c10ea82c1e305b8( "aether_pulse", "off" );
}

// Namespace field_upgrades_dark_flare
// Params 1
// Checksum 0xfe49dcb, Offset: 0x34e2
// Size: 0x78
function ragdoll_activate( shadow_ball )
{
    v_dir = vectornormalize( self.origin - shadow_ball.origin );
    v_launch = v_dir * randomintrange( 2200, 2400 ) + ( 0, 0, randomintrange( 900, 1100 ) );
    
    if ( isdefined( self ) && !self isragdoll() )
    {
        self startragdollfromimpact( "torso_lower", v_launch * 1.2 );
    }
}

// Namespace field_upgrades_dark_flare
// Params 2, eflags: 0x40 variadic
// Checksum 0xf165b467, Offset: 0x3562
// Size: 0x24
function function_cb9164f240124e13( ... )
{
    if ( isdefined( self ) )
    {
        self.dark_flare_slowed = undefined;
    }
}

// Namespace field_upgrades_dark_flare
// Params 2
// Checksum 0x7a34bcbf, Offset: 0x358e
// Size: 0x17b
function function_e0d77bc1a18176e9( center, radius )
{
    if ( isdefined( self.ieds ) && isvector( center ) )
    {
        foreach ( ied in self.ieds )
        {
            if ( isdefined( ied.origin ) )
            {
                if ( distance2dsquared( ied.origin, center ) < radius * radius )
                {
                    ied thread ied::ied_explode( self );
                }
            }
        }
    }
    
    if ( isdefined( self.c4s ) )
    {
        foreach ( c4 in self.c4s )
        {
            if ( isdefined( c4.origin ) )
            {
                if ( distance2dsquared( c4.origin, center ) < radius * radius )
                {
                    c4 thread c4::c4_explode( self );
                }
            }
        }
    }
}

// Namespace field_upgrades_dark_flare
// Params 1
// Checksum 0xde58538a, Offset: 0x3711
// Size: 0x6a
function function_107233ea77c5384a( duration )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    str_on_state = self.var_14237761a6491554 ?? "super_fx_on";
    utility::function_7c10ea82c1e305b8( "healing_aura_fx", str_on_state );
    wait duration;
    utility::function_7c10ea82c1e305b8( "healing_aura_fx", "super_fx_off" );
}

// Namespace field_upgrades_dark_flare
// Params 0
// Checksum 0x387e7fc8, Offset: 0x3783
// Size: 0xdd
function watch_impact_fx()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"death" );
    utility::function_7c10ea82c1e305b8( "darkFlareImpact", "vfx_start" );
    
    if ( !callback::exists( "pre_killed_body_cloned", &function_5da8178bffbab10c ) )
    {
        callback::add( "pre_killed_body_cloned", &function_5da8178bffbab10c );
    }
    
    namespace_659599414270bd0a::function_80623a2279a4d888();
    
    if ( isstartstr( self.subclass, "zombie_base" ) && !namespace_b76ff2659823e89d::is_crawling() )
    {
        self function_786bb6aa1b76c7ee( "death_dafg_dissolve", 1 );
    }
    
    wait 2;
    utility::function_7c10ea82c1e305b8( "darkFlareImpact", "off" );
    
    if ( isstartstr( self.subclass, "zombie_base" ) )
    {
        self function_786bb6aa1b76c7ee( "death_dafg_dissolve", 0 );
    }
    
    namespace_659599414270bd0a::enable_emergence_spawning();
    callback::remove( "pre_killed_body_cloned", &function_5da8178bffbab10c );
}

// Namespace field_upgrades_dark_flare
// Params 1, eflags: 0x4
// Checksum 0x2bfae98e, Offset: 0x3868
// Size: 0x24
function private function_5da8178bffbab10c( params )
{
    utility::ent_flag_set( "dissolve_purple" );
    utility::ent_flag_set( "dark_aether_bubble" );
}

// Namespace field_upgrades_dark_flare
// Params 0
// Checksum 0x5d01af91, Offset: 0x3894
// Size: 0xd4
function function_e4cf58e5cd81aa53()
{
    if ( !player::isinlaststand( self ) )
    {
        self playrumblelooponentity( "dark_flare_rumble" );
    }
    
    waitframe();
    
    if ( isalive( self ) && !player::isinlaststand( self ) && !utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_shadow_ball" ) )
    {
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_big_beam" ) )
        {
            utility::function_7c10ea82c1e305b8( "dark_flare_fx", "super_fx_big_beam_on" );
            return;
        }
        
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"dark_flare_phantasmal" ) )
        {
            utility::function_7c10ea82c1e305b8( "dark_flare_fx", "super_fx_phantasmal_on" );
            return;
        }
        
        utility::function_7c10ea82c1e305b8( "dark_flare_fx", "super_fx_on" );
    }
}

// Namespace field_upgrades_dark_flare
// Params 0
// Checksum 0x21daebcf, Offset: 0x3970
// Size: 0x70
function dark_flare_fov_change()
{
    if ( !isdefined( self.var_dc58879cfee40e71 ) )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    self notify( #"hash_6905fb37f08f5a8e" );
    self endon( #"hash_6905fb37f08f5a8e" );
    self lerpfovbypreset( "zombiedefault" );
    utility::waittill_any_timeout_no_endon_death( self.var_dc58879cfee40e71, "super_use_finished", "end_dark_flare" );
    self lerpfovbypreset( "default_2seconds" );
    self playlocalsound( "deadsilence_end" );
}

// Namespace field_upgrades_dark_flare
// Params 0
// Checksum 0x48566a47, Offset: 0x39e8
// Size: 0x4c
function function_a77d049ba5227e1f()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self stoprumble( "dark_flare_rumble" );
    self playsound( "eqp_fug_aethershroud_deactivate" );
    self stoploopsound( "eqp_fug_aethershroud_loop" );
    utility::function_7c10ea82c1e305b8( "dark_flare_fx", "super_fx_off" );
}

// Namespace field_upgrades_dark_flare
// Params 4, eflags: 0x4
// Checksum 0xc9e76797, Offset: 0x3a3c
// Size: 0x16e
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
    {
        utility::callsharedfunc( #"medal", #"track_rapid_kill", "dark_flare", sweapon );
    }
    
    victim.is_lethal_or_super_kill = 1;
    params = { #highest_multi_kills:1, #stats:"kills", #ref:"super_dark_flare", #var_9ab797085ae4e901:"dark_flare", #victim:victim, #player:self };
    callback::callback( "on_field_upgrade_kill_track", params );
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "dark_flare" ] ) && self.rapidkill_data[ "dark_flare" ].rapidkill_count == 10 )
        {
            namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_beamed" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_beamed" );
            }
            
            self.var_45b23a9c47825133 = 1;
        }
    }
}

// Namespace field_upgrades_dark_flare
// Params 1
// Checksum 0xa7b618eb, Offset: 0x3bb2
// Size: 0x99
function add_manual_target( object )
{
    if ( !isdefined( object ) || !( isent( object ) || object isscriptableinstance() ) )
    {
        assertmsg( "<dev string:xb8>" );
        return;
    }
    
    if ( !isdefined( level.dark_flare ) || arraycontains( level.dark_flare.var_28079045bda30435, object ) )
    {
        return;
    }
    
    object thread manual_target_watcher();
    level.dark_flare.var_28079045bda30435[ level.dark_flare.var_28079045bda30435.size ] = object;
}

// Namespace field_upgrades_dark_flare
// Params 1
// Checksum 0x744541b3, Offset: 0x3c53
// Size: 0x93
function remove_manual_target( object )
{
    if ( !isdefined( object ) || !( isent( object ) || object isscriptableinstance() ) )
    {
        assertmsg( "<dev string:xfb>" );
        return;
    }
    
    if ( !isdefined( level.dark_flare ) || !arraycontains( level.dark_flare.var_28079045bda30435, object ) )
    {
        return;
    }
    
    level.dark_flare.var_28079045bda30435 = arrayremove( level.dark_flare.var_28079045bda30435, object );
}

// Namespace field_upgrades_dark_flare
// Params 0, eflags: 0x4
// Checksum 0x5bf63367, Offset: 0x3cee
// Size: 0x5f
function private manual_target_watcher()
{
    level endon( #"zm_game_over" );
    self endon( #"hash_a0748263cdec9bf7" );
    self waittill( #"death" );
    level.dark_flare.var_28079045bda30435 = arrayremove( level.dark_flare.var_28079045bda30435, self );
    self notify( #"hash_a0748263cdec9bf7" );
}

// Namespace field_upgrades_dark_flare
// Params 1, eflags: 0x4
// Checksum 0xd8f70154, Offset: 0x3d55
// Size: 0x43
function private function_f6af973ecf59c35b( params )
{
    body = zombie_utils::function_4e99fb1239980783( params );
    
    if ( isdefined( body ) && self.killed_by_dark_flare )
    {
        wait 6;
        
        if ( isdefined( body ) )
        {
            body delete();
        }
    }
}

