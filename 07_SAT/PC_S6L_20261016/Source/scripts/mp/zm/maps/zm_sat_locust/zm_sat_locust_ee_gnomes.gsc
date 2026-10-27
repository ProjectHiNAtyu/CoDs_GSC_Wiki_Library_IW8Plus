// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_ee_gnomes.gsc  (hash_40912451a2502514.gscc) (size: 23863 Bytes / 0x5d37 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4a2a94a9 (1244304553)
// size ...... 23863 (0x5d37)
// includes .. 28  (offset: 0x57fb)
// strings ... 70  (offset: 0x58db)
// dev strs .. 12  (offset: 0x5c8f)
// exports ... 68  (offset: 0x2fa3)
// cseg ...... 0x5fb + 0x29a8 (0x2fa3)
// imports ... 252 (offset: 0x3a43)
// animtree1 . 0   (offset: 0x5d37)
// animtree2 . 0   (offset: 0x5d37)
#using script_75cfaf905999d816;
#using scripts\anim\dialogue;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\interaction;
#using scripts\mp\player_banter;
#using scripts\mp\supers;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\weapons\zm_damage;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_locust_ee_gnomes;

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x5
// Checksum 0x5b4439f1, Offset: 0x619
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_1cf7ef91edc75b52", #"zm_quest", &pre_main, &post_main );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x65ed9aa3, Offset: 0x646
// Size: 0x11d
function private pre_main()
{
    if ( !getdvarint( @"hash_427ebffc772911dd", 0 ) || isusingmatchrulesdata() && !getmatchrulesdata( "zmData", "sideContentEnabled" ) || !getdvarint( @"hash_b4aab7ef9461b82d", 1 ) )
    {
        return;
    }
    
    level.ee_gnomes = spawnstruct();
    level.ee_gnomes.in_world = [];
    level.ee_gnomes.in_shop = [];
    level.ee_gnomes.exit_banter_played = 0;
    level.ee_gnomes.var_4f74bfb90244d361 = getdvarint( @"hash_d26852a2577a035e", 20 );
    level.ee_gnomes.var_eb5e050b963df92 = getdvarint( @"hash_59c2d3ede8695f61", 500 );
    zm_quest::register_quest_step( #"hash_1cf7ef91edc75b52", #"collect_gnomes", &function_7d6d613ab952c071, &function_60062348e78b78d6 );
    zm_quest::register_quest_step( #"hash_1cf7ef91edc75b52", #"activate_gnome", &function_7d6d5e3ab952b9d8, &function_60062248e78b76a3 );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0xc0902111, Offset: 0x76b
// Size: 0xd9
function private post_main()
{
    if ( !getdvarint( @"hash_427ebffc772911dd", 0 ) || isusingmatchrulesdata() && !getmatchrulesdata( "zmData", "sideContentEnabled" ) || !getdvarint( @"hash_b4aab7ef9461b82d", 1 ) )
    {
        return;
    }
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    init_values();
    level thread function_543d9a56ea2a1b6f();
    level callback::add( "zone_changed", &on_zone_changed );
    level callback::add( "on_zombie_ai_killed", &on_zombie_killed );
    level callback::add( #"hash_2fc46531ebe36dde", &function_7a96d8fc84444088 );
    level callback::add( #"start_game_ended", &on_game_ended );
    zm_save::function_1f44a48caae2acbf();
    reload_gnomes();
    level thread zm_quest::start_quest( #"hash_1cf7ef91edc75b52" );
    
    /#
        debug_init();
    #/
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0xd18050f3, Offset: 0x84c
// Size: 0xd1
function private init_values()
{
    level val::group_register( #"gnome_form", [ "usability", "weapon_pickup", "supers", "allow_scripted_bgb_use", "gesture", "killstreaks", "crouch", "prone", "slide_boost", "slide", "sprint", "equipment_primary", "equipment_secondary", "damage", "weapon", "ads", "allow_grab", "allow_battlechatter_vo", "breath_system", "allow_wall_jump", "melee" ] );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0xbb803f8e, Offset: 0x925
// Size: 0xd8
function private reload_gnomes()
{
    if ( !zm_save::function_1dda3554974a999e() )
    {
        return;
    }
    
    value = zm_quest::function_73720cdf21c3cfd7( #"hash_1cf7ef91edc75b52", #"gnomes_recovered" ) ?? 0;
    
    if ( value == 0 )
    {
        return;
    }
    
    foreach ( gnome in level.ee_gnomes.in_world )
    {
        if ( !utility::get_bit_flag( value, gnome.idx ) )
        {
            continue;
        }
        
        gnome function_9e8a86a8525e9703();
    }
}

// Namespace zm_sat_locust_ee_gnomes
// Params 2, eflags: 0x4
// Checksum 0xbfe6c143, Offset: 0xa05
// Size: 0x2d
function private function_7d6d613ab952c071( skipped, save_restored )
{
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( "ee_wr_step_01" );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 2, eflags: 0x4
// Checksum 0xa088b180, Offset: 0xa3a
// Size: 0xa5
function private function_60062348e78b78d6( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        foreach ( gnome in level.ee_gnomes.in_world )
        {
            gnome function_9e8a86a8525e9703();
        }
    }
    
    profilestop();
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x2204d989, Offset: 0xae7
// Size: 0x220
function private function_543d9a56ea2a1b6f()
{
    utility::flag_wait( "scriptables_ready" );
    world_locs = utility::getstructarray( "eegn_gn_wo" );
    world_locs = arrayrandomize( world_locs );
    astrid_locs = utility::getstructarray( "eegn_gn_as" );
    astrid_locs = arrayrandomize( astrid_locs );
    gnomes = [];
    
    foreach ( idx, loc in world_locs )
    {
        gnome = spawnscriptable( %"sat_zm_prop_woodrow", loc.origin, loc.angles );
        gnome setscriptablepartstate( #"model", "version_" + idx + 1 );
        gnome.idx = idx;
        gnome.astrid_loc = astrid_locs[ idx ];
        gnome.var_af70f02bb9462edd = 1;
        gnome.var_436fc13baa7377d8 = 1;
        gnome.health = 100;
        gnome.basearchetype = "none";
        gnome zm_damage::register_scriptable_damage_callback( &function_c9654221a19a0f7e );
        gnome callback::add( #"hash_11e40a4909e138f7", &function_9e8a86a8525e9703 );
        gnomes[ gnomes.size ] = gnome;
    }
    
    level.ee_gnomes.in_world = gnomes;
    level.ee_gnomes.capture_count = 0;
    level.ee_gnomes.capture_req = gnomes.size;
    utility::add_fx( "woodrow_form_in", "vfx_sat_zm_levels_locust_ee_gnome_form_in" );
    utility::add_fx( "woodrow_form_out", "vfx_sat_zm_levels_locust_ee_gnome_form_out" );
    utility::add_fx( "woodrow_jump", "vfx_sat_zm_levels_locust_ee_gnome_aoe_pulse" );
    utility::add_fx( "woodrow_interact", "vfx_sat_zm_levels_locust_ee_gnome_activate" );
    utility::add_fx( "woodrow_projectile", "vfx_sat_zm_levels_locust_ee_gnome_lantern_loop" );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0x3291ca3e, Offset: 0xd0f
// Size: 0xfd
function private function_c9654221a19a0f7e( params )
{
    if ( utility::isbulletdamage( params.smeansofdeath ) || damage::isprojectiledamage( params.smeansofdeath ) )
    {
        if ( params.eattacker ammo_mod::function_ba9b2ecd18bdbdd8( params.objweapon, "shadowvortex" ) )
        {
            if ( ammo_mod::ammo_mod_response( 0, params.einflictor, params.eattacker, params.idamage, params.idflags, params.smeansofdeath, params.sweapon, params.vpoint, params.vdir, params.shitloc, params.timeoffset, params.modelindex, params.partname, params.objweapon ) )
            {
                return self.health;
            }
        }
    }
    
    return 0;
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0x854c5f2d, Offset: 0xe15
// Size: 0x242
function private function_9e8a86a8525e9703( params )
{
    astrid_gnome = spawnscriptable( %"sat_zm_prop_woodrow", self.astrid_loc.origin, self.astrid_loc.angles );
    astrid_gnome setscriptablepartstate( #"model", "version_" + self.idx + 1 );
    level.ee_gnomes.in_shop[ level.ee_gnomes.in_shop.size ] = astrid_gnome;
    self setscriptablepartstate( #"model", #"hidden" );
    utility::delaycall( level.framedurationseconds, &freescriptable );
    
    if ( isdefined( params ) )
    {
        self setscriptablepartstate( #"effects", #"vortex" );
        astrid_gnome utility::delaycall( 0.5, &setscriptablepartstate, #"effects", #"vortex" );
    }
    
    level.ee_gnomes.capture_count++;
    
    if ( params.eattacker )
    {
        self.var_42ad252ed55abadf = utility::spawn_tag_origin( self.origin, self.angles );
        self.var_42ad252ed55abadf thread utility::delete_after_delay( 5 );
        self.var_42ad252ed55abadf thread dialogue::say_self( "dx_zm_lesd_est2_lofg_lesd2gngnid" );
        
        if ( level.ee_gnomes.capture_count == 1 )
        {
            params.eattacker utility::delaythread( 2, &namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01, #"hash_a3d20b6e489dd4b7", #"hash_5212ed7ec42f115a" );
        }
    }
    
    value = zm_quest::function_73720cdf21c3cfd7( #"hash_1cf7ef91edc75b52", #"gnomes_recovered" ) ?? 0;
    value = utility::set_bit_flag( value, self.idx );
    zm_quest::function_4eefe6de31f5ddab( #"hash_1cf7ef91edc75b52", #"gnomes_recovered", value );
    
    if ( level.ee_gnomes.capture_count == level.ee_gnomes.capture_req )
    {
        utility::flag_set( "ee_wr_step_01" );
    }
}

// Namespace zm_sat_locust_ee_gnomes
// Params 2, eflags: 0x4
// Checksum 0x1c2e827e, Offset: 0x105f
// Size: 0x123
function private function_7d6d5e3ab952b9d8( skipped, save_restored )
{
    var_cc9dbb3fbaaec44e = utility::getstruct( "eegn_gn_in" );
    helmet = level callback::response( 0, #"hash_95d2fe8a74e011f8", { #angles:var_cc9dbb3fbaaec44e.angles, #origin:var_cc9dbb3fbaaec44e.origin } );
    
    if ( !helmet )
    {
        interact = spawnscriptable( %"sat_zm_interact_woodrow", var_cc9dbb3fbaaec44e.origin, var_cc9dbb3fbaaec44e.angles );
        interact setscriptablepartstate( #"interact", #"enabled_48" );
        interaction::register_scriptable_interact( interact, &function_3cbea4eb6c84fb82 );
        zm_sat_locust_util::function_295a36ef38f5acae( #"gnome_interact", interact );
    }
    else
    {
        level callback::add( #"hash_cce1f9ca7f216f81", &function_98851f234097ec14 );
        level callback::add( #"hash_9e91383fd1158a63", &function_14dba867d6d5b442 );
    }
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( "ee_wr_step_02" );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 2, eflags: 0x4
// Checksum 0xdfd17c12, Offset: 0x118a
// Size: 0x2e
function private function_60062248e78b76a3( skipped, save_restored )
{
    profilestart();
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "ee_wr_step_02" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0xb583180e, Offset: 0x11c0
// Size: 0x58
function private function_3cbea4eb6c84fb82( player )
{
    if ( self.in_use )
    {
        return;
    }
    
    playfx( utility::getfx( "woodrow_interact" ), self.origin );
    function_98851f234097ec14( { #player:player } );
    utility::delaycall( level.framedurationseconds, &freescriptable );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1
// Checksum 0x665a0e3d, Offset: 0x1220
// Size: 0x62
function function_98851f234097ec14( params )
{
    if ( !utility::flag( "ee_wr_step_02" ) )
    {
        utility::flag_set( "ee_wr_step_02" );
        
        if ( params.player )
        {
            params.player thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_8028ab1132604a78" );
        }
    }
    
    params.player thread function_e12daa32bc251158();
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1
// Checksum 0xf4246a28, Offset: 0x128a
// Size: 0x47
function function_14dba867d6d5b442( params )
{
    if ( params.player.gnome_form.progress == 0 )
    {
        return;
    }
    
    params.player notify( #"hash_36f455373b2c6a85" );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0xc
// Checksum 0x88bbc8e, Offset: 0x12d9
// Size: 0x16d
function private function_e12daa32bc251158( time = getdvarfloat( @"hash_89bd342928d82886", 30 ) )
{
    self notify( #"hash_5d62b7d301d89645" );
    self endon( #"hash_5d62b7d301d89645" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_36f455373b2c6a85" );
    self.gnome_form = { #mantle_time:undefined, #kill_cooldown:0, #end_time:undefined, #total_time:time, #progress:1, #active:0 };
    
    while ( true )
    {
        if ( !self.gnome_form.active )
        {
            if ( self crouchbuttonpressed() && function_2615a637054d2022() )
            {
                form_apply();
                wait 1;
                continue;
            }
        }
        else if ( self.gnome_form.active )
        {
            if ( self crouchbuttonpressed() && ( !self.gnome_form.mantle_time || utility::time_has_passed( self.gnome_form.mantle_time, 0.5 ) && self isonground() ) || !function_6691e5d6efa88c07() )
            {
                form_cancel();
                wait 1;
                continue;
            }
        }
        
        waitframe();
    }
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x79b417b8, Offset: 0x144e
// Size: 0x69
function private form_apply()
{
    self endon( #"death_or_disconnect" );
    function_8dccc63e0b07e4ee();
    wait getdvarfloat( @"hash_10978674f3152d9c", 0.2 );
    thread function_70e8820406caee17();
    function_a887d433f6cefa2e();
    function_fcc3c291b837389b();
    function_ddd7556bf73a7145();
    form_toggle_state( 1 );
    level callback::callback( #"hash_1775b5a01b4f4346", { #player:self } );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x728f4dae, Offset: 0x14bf
// Size: 0x47
function private function_70e8820406caee17()
{
    self endon( #"death_or_disconnect" );
    
    if ( !self getcamerathirdperson() )
    {
        self notify( #"zm_down_toggle" );
        self.was_third_person = 0;
        waitframe();
    }
    else
    {
        self.was_third_person = 1;
    }
    
    self.disable_third_person_toggle = 1;
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0xea89c25b, Offset: 0x150e
// Size: 0x19
function private function_a887d433f6cefa2e()
{
    if ( !zm_quest::function_9b18c35fba5c3d31() )
    {
        return;
    }
    
    supers_mp::superusefinished( 0, undefined, undefined, 1 );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0xbcb12fab, Offset: 0x152f
// Size: 0x3b
function private function_fcc3c291b837389b()
{
    self canceloffhands();
    self releaseoffhand();
    self stopanimscriptsceneevent();
    self stopgestureviewmodel();
    killstreakdeploy::streakdeploy_cancelalldeployments();
    self notify( #"equip_deploy_cancel" );
    
    if ( self isviewmodelanimplaying() )
    {
        self stopviewmodelanim();
    }
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0xedd7f5e5, Offset: 0x1572
// Size: 0x1a
function private function_8dccc63e0b07e4ee()
{
    weapon_utility::saveweaponstates();
    val::group_set( #"gnome_form", 0 );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x508e6661, Offset: 0x1594
// Size: 0x142
function private function_ddd7556bf73a7145()
{
    player_utility::function_dbe5a52a6654a982();
    playfx( utility::getfx( "woodrow_form_in" ), self.origin );
    self playsoundevent( %"hash_64bfe4703a9f3de7" );
    self playsoundevent( %"hash_47ed0d70bbd9ec22" );
    self.prop = spawn( "script_model", self.origin );
    self.prop.angles = self.angles;
    self.prop.targetname = "prop";
    self.prop.host = self;
    self.prop setentityisprop( 1 );
    self.prop linkto( self, "tag_sync" );
    self.prop function_7207895b28c71c79( 1 );
    self.prop notsolid();
    self.prop setmodel( %"sat_zm_prop_woodrow_01" );
    self.prop function_efe38a5aece1fe83( 0 );
    self setpropentity( self.prop );
    self function_b63e3c462f2e452b( ( -150, 0, 0 ) );
    self function_16332a7775f10aa9();
    utility::ent_flag_set( "blizzard_immune" );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0xc0b16848, Offset: 0x16de
// Size: 0x47
function private form_cancel()
{
    self endon( #"death_or_disconnect" );
    function_50d0564a42d0285f();
    function_3e7b4a73169fcd6();
    function_c381f9cb94d45f8d();
    form_toggle_state( 0 );
    level callback::callback( #"hash_4860b292b1e63c3e", { #player:self } );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x212599b8, Offset: 0x172d
// Size: 0x2f
function private function_50d0564a42d0285f()
{
    self.disable_third_person_toggle = undefined;
    
    if ( self.was_third_person )
    {
        return;
    }
    
    self notify( #"zm_down_toggle" );
    self.was_third_person = undefined;
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x5358727, Offset: 0x1764
// Size: 0x22
function private function_3e7b4a73169fcd6()
{
    val::group_reset( #"gnome_form" );
    weapon_utility::restoreweaponstates( self.lastdroppableweaponobj );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x77dcde30, Offset: 0x178e
// Size: 0x89
function private function_c381f9cb94d45f8d()
{
    if ( isalive( self ) )
    {
        playfx( utility::getfx( "woodrow_form_out" ), self.origin );
        player_utility::function_b54a1e23734ef07();
        self playsoundevent( %"hash_64bfe4703a9f3de7" );
        self playsoundevent( %"hash_47ed0d70bbd9ec22" );
        self setpropentity();
        self function_b63e3c462f2e452b( ( 0, 0, 0 ) );
    }
    
    self.prop unlink();
    self.prop delete();
    utility::ent_flag_clear( "blizzard_immune" );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0xe81ec698, Offset: 0x181f
// Size: 0x158
function private form_toggle_state( active )
{
    self.gnome_form.active = active;
    self.gnome_form.start_time = gettime();
    
    if ( active )
    {
        thread function_a3195a90c7324012( 1 );
        thread function_e47e0cd84cc0251a();
        thread function_f7b6b6013626b161();
        thread form_disconnect_watcher();
        thread function_ffeb1bc2396c594c();
        thread gnome_chatter();
        val::group_set( #"gnome_form", 0 );
        callback::callback( #"hash_2fc46531ebe36dde" );
        return;
    }
    
    function_e5859b7a159193d1();
    function_57b0330a77f6a979();
    callback::callback( #"hash_7f9d491bb0ff6a88" );
    dialogue::stop_dialogue( 1, 1 );
    self notify( #"hash_7245b0213d72d509" );
    
    if ( self.gnome_form.progress == 0 )
    {
        if ( !player_banter::function_4e1aff6241ebea8() )
        {
            if ( !level.ee_gnomes.exit_banter_played )
            {
                utility::delaythread( level.framedurationseconds, &namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01, #"hash_15a684ea55b27118", #"hash_5212ed7ec42f115a" );
                level.ee_gnomes.exit_banter_played = 1;
            }
        }
        
        self notify( #"hash_36f455373b2c6a85" );
        return;
    }
    
    self notify( #"hash_28009ab3010672e9" );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0xc
// Checksum 0x89b88000, Offset: 0x197f
// Size: 0x61
function private function_a3195a90c7324012( delay )
{
    self notify( #"hash_8657fedf59544657" );
    self endon( #"hash_8657fedf59544657" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_28009ab3010672e9" );
    self endon( #"hash_36f455373b2c6a85" );
    function_e42057300d2035b0( delay );
    
    for ( ;; )
    {
        wait 0.25;
        function_c971a1bf454fbb01();
    }
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x4b92e0ba, Offset: 0x19e8
// Size: 0x87
function private function_e5859b7a159193d1()
{
    foreach ( rune_ent in self.gnome_form.rune_ents )
    {
        rune_ent function_1453c7a10e7d502f( 1 );
    }
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0x2cb13d3c, Offset: 0x1a77
// Size: 0xe, Type: bool
function private form_blizzard_immune( params )
{
    return true;
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0x910d36a5, Offset: 0x1a8e
// Size: 0x1d7
function private function_e42057300d2035b0( delay )
{
    if ( delay )
    {
        self endon( #"death_or_disconnect" );
        self endon( #"hash_28009ab3010672e9" );
        self endon( #"hash_36f455373b2c6a85" );
        wait delay;
    }
    
    rune_ents = [];
    
    for ( i = 0; i < 2 ; i++ )
    {
        rune_ent = spawn( "script_model", self.prop gettagorigin( "tag_lamp" ) );
        rune_ent setmodel( %"tag_origin_woodrow_projectile" );
        rune_ent solid();
        rune_ent show();
        rune_ent setnonstick( 1 );
        rune_ent utility::function_32b24db3127bff40( "base", "swarm_on" );
        rune_ent.var_d62ad5bfd64ba592 = "tag_origin";
        rune_ent.host = self;
        rune_ent.isactive = 1;
        rune_ent.team = rune_ent.host.team;
        rune_ent.isactive = 1;
        rune_ent.duration = 5;
        namespace_62d6417c8f47a982::function_825925e0a97eedb7( rune_ent );
        namespace_62d6417c8f47a982::function_9d6fcfde1a685656( rune_ent, 80, 10, 150, 2000 );
        namespace_62d6417c8f47a982::function_192e744d83b3f2aa( rune_ent, 200 );
        namespace_62d6417c8f47a982::function_f209b09df560f7db( rune_ent, 0 );
        namespace_62d6417c8f47a982::enable_vehicle_collision( rune_ent );
        rune_ent callback::add( "homing_ball_hit_character", &function_e03924ad097a8c66 );
        rune_ent linkto( self.prop, "tag_lamp", ( 0, 0, 0 ), ( 0, 0, 0 ) );
        rune_ents[ rune_ents.size ] = rune_ent;
    }
    
    self.gnome_form.rune_ents = rune_ents;
    self.gnome_form.runes_active = 2;
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0x8f695c2b, Offset: 0x1c6d
// Size: 0x19f
function private function_e03924ad097a8c66( params )
{
    var_90ec0886f9ccf215 = params.var_14e87d44408dd566;
    index = zm_utility::get_round_number() > level.ee_gnomes.var_4f74bfb90244d361;
    
    switch ( var_90ec0886f9ccf215.aicategory )
    {
        case #"hash_84fcf5e68d7230b2":
            scalar = [ getdvarfloat( @"hash_eef832ea8550e100", 0.5 ), getdvarfloat( @"hash_c309f798f1583809", 0.5 ) ];
            break;
        case #"hash_8c089e813083e510":
            scalar = [ getdvarfloat( @"hash_39c4ab75f65a2336", 0.1 ), getdvarfloat( @"hash_c34f84b0b910ab57", 0.08 ) ];
            break;
        case #"hash_7b0e2f2ed84f34":
        case #"hash_4e47eb6c32f5b165":
            scalar = [ getdvarfloat( @"hash_29e1f4564f993902", 0.05 ), getdvarfloat( @"hash_b34d283aaac7c553", 0.05 ) ];
            break;
        default:
            assertmsg( "<dev string:x24>" + var_90ec0886f9ccf215.aicategory );
            skip_damage = 1;
            break;
    }
    
    if ( !skip_damage )
    {
        var_90ec0886f9ccf215 dodamage( round( var_90ec0886f9ccf215.maxhealth * scalar[ index ] ), var_90ec0886f9ccf215.origin, self, self, "MOD_PROJECTILE", level.weaponnone );
    }
    
    function_1453c7a10e7d502f();
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0xfda64e63, Offset: 0x1e14
// Size: 0xa9
function private function_c971a1bf454fbb01( rune )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_28009ab3010672e9" );
    self endon( #"hash_36f455373b2c6a85" );
    ball = undefined;
    
    for ( i = 0; i < 2 ; i++ )
    {
        if ( self.gnome_form.rune_ents[ i ].isactive )
        {
            ball = self.gnome_form.rune_ents[ i ];
            break;
        }
    }
    
    if ( !isdefined( ball ) )
    {
        return;
    }
    
    if ( !function_e23dbc34b32dcba6( ball ) )
    {
        return;
    }
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0x3f053450, Offset: 0x1ec5
// Size: 0x89
function private function_e23dbc34b32dcba6( ball )
{
    target_ent = function_488e567e4c18d7ec( ball );
    
    if ( !isdefined( target_ent ) )
    {
        return 0;
    }
    
    ball unlink();
    velocity = function_dbeabb23964c1b0d( ball );
    ball namespace_62d6417c8f47a982::function_e47e242b17d4abc3( velocity, 3, 0 );
    ball namespace_62d6417c8f47a982::set_target_ent( ball, target_ent );
    namespace_62d6417c8f47a982::function_cf9c0c9c03fe5550( ball, 1 );
    ball setcandamage( 0 );
    ball function_b398682b38f521f5( 1 );
    ball thread function_a76a71b55ac1da8f();
    ball thread function_4c8c3eb5bcd35a03( target_ent );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0xc48db505, Offset: 0x1f56
// Size: 0x131
function private function_488e567e4c18d7ec( ball )
{
    player = ball.host;
    var_898b2d8d5239223c = player.origin + ( 0, 0, 32 );
    zombies = getaiarrayinradius( var_898b2d8d5239223c, level.ee_gnomes.var_eb5e050b963df92, zm_utility::get_zombie_team() );
    zombies = sortbydistance( zombies, var_898b2d8d5239223c );
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( zombie.b_in_spawn_closet )
        {
            continue;
        }
        
        if ( !zm_utility::is_active_zombie( zombie ) )
        {
            continue;
        }
        
        if ( !zombie val::get( "damage" ) )
        {
            continue;
        }
        
        target = zombie;
        break;
    }
    
    return target;
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0x6686ca72, Offset: 0x2090
// Size: 0x3d
function private function_dbeabb23964c1b0d( ball )
{
    vel_dir = vectornormalize( ball.origin - self getcentroid() );
    vel_mag = 80;
    return vel_dir * vel_mag;
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x3f796d36, Offset: 0x20d6
// Size: 0x8d
function private function_a76a71b55ac1da8f()
{
    self endon( #"death" );
    self endon( #"ball_deactivate" );
    self.ball_spawn_time = gettime();
    
    for ( ;; )
    {
        if ( distancesquared( self.origin, self.host.origin ) > self.var_30d41208260198b1 )
        {
            function_1453c7a10e7d502f();
            break;
        }
        
        if ( gettime() - self.ball_spawn_time > self.duration * 1000 )
        {
            function_1453c7a10e7d502f();
            break;
        }
        
        wait 1;
    }
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0x792faf3f, Offset: 0x216b
// Size: 0x3f
function private function_4c8c3eb5bcd35a03( target )
{
    self endon( #"death" );
    self endon( #"ball_deactivate" );
    
    if ( isdefined( target ) )
    {
        target waittill( #"death" );
        function_1453c7a10e7d502f();
    }
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0xc685bba9, Offset: 0x21b2
// Size: 0x73
function private function_1453c7a10e7d502f( immediately = 0 )
{
    if ( self.isactive )
    {
        state = "swarm_destroyed";
        utility::function_32b24db3127bff40( "base", state );
        namespace_62d6417c8f47a982::function_6299c776502742fa( self );
        self setcandamage( 0 );
        self notsolid();
        self.incontact = undefined;
        thread function_e2cdbee5282232cf( immediately );
        self notify( #"ball_deactivate" );
    }
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0xdf08ff8f, Offset: 0x222d
// Size: 0xaf
function private function_e2cdbee5282232cf( immediately = 0 )
{
    self.isactive = 0;
    
    if ( !immediately )
    {
        thread utility::delete_after_delay( 1 );
    }
    else
    {
        self delete();
    }
    
    self.host.gnome_form.runes_active--;
    
    if ( self.host.gnome_form.active && self.host.gnome_form.runes_active == 0 )
    {
        self.host function_a3195a90c7324012( 1 );
    }
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x9b711b0e, Offset: 0x22e4
// Size: 0x54
function private function_e47e0cd84cc0251a()
{
    self.gnome_form.jump_cooldown = undefined;
    callback::add( #"jump_begin", &function_35bad142f9d837f4 );
    callback::add( #"jump_end", &function_a1dbb427b67fbed );
    callback::add( #"mantle_begin", &function_13d064a3cac800d6 );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0xbd94ddf5, Offset: 0x2340
// Size: 0x28
function private function_35bad142f9d837f4( params )
{
    if ( dialogue::function_8231932c5efc0648() )
    {
        dialogue::stop_dialogue();
    }
    
    thread dialogue::say_self( "dx_zm_lesd_est2_lofg_lesd2gngnjpef" );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0x5247eaf3, Offset: 0x2370
// Size: 0x198
function private function_a1dbb427b67fbed( params )
{
    if ( dialogue::function_8231932c5efc0648() )
    {
        dialogue::stop_dialogue();
    }
    
    thread dialogue::say_self( "dx_zm_lesd_est2_lofg_lesd2gngnldef" );
    
    if ( self.gnome_form.jump_cooldown && !utility::time_has_passed( self.gnome_form.jump_cooldown, 2 ) )
    {
        return;
    }
    
    playfx( utility::getfx( "woodrow_jump" ), self.origin );
    self playsoundevent( %"hash_715f820a60cd27cc" );
    self playsoundevent( %"hash_47f10d0a91d21e45" );
    zombies = getaiarrayinradius( self.origin, 192, zm_utility::get_zombie_team() );
    
    foreach ( zombie in zombies )
    {
        if ( !zm_utility::is_active_zombie( zombie ) )
        {
            continue;
        }
        
        if ( !zombie val::get( "damage" ) )
        {
            continue;
        }
        
        if ( zombie zombie_knockdown::function_19d6107cb6bdff5c() )
        {
            continue;
        }
        
        zombie zombie_knockdown::function_6fc167d4a3590991( self.origin, 500, 30 );
    }
    
    self.prop utility::function_32b24db3127bff40( "jump_pulse", "enabled" );
    self.gnome_form.jump_cooldown = gettime();
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0xc189d495, Offset: 0x2510
// Size: 0x40
function private function_13d064a3cac800d6( params )
{
    self.gnome_form.mantle_time = gettime();
    
    if ( dialogue::function_8231932c5efc0648() )
    {
        dialogue::stop_dialogue();
    }
    
    thread dialogue::say_self( "dx_zm_lesd_est2_lofg_lesd2gngnmtef" );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x4c10b29, Offset: 0x2558
// Size: 0x41
function private function_57b0330a77f6a979()
{
    callback::remove( #"jump_begin", &function_35bad142f9d837f4 );
    callback::remove( #"jump_end", &function_a1dbb427b67fbed );
    callback::remove( #"mantle_begin", &function_13d064a3cac800d6 );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x57be5f5, Offset: 0x25a1
// Size: 0xcf, Type: bool
function private function_2615a637054d2022()
{
    if ( !function_6691e5d6efa88c07() )
    {
        return false;
    }
    
    if ( self getstanceblocked( "stand" ) || self getstanceblocked( "crouch" ) )
    {
        return false;
    }
    
    if ( supers_mp::function_ec7e2ab9a462557b() )
    {
        return false;
    }
    
    if ( self isthrowinggrenade() )
    {
        return false;
    }
    
    if ( self ismantling() )
    {
        return false;
    }
    
    if ( self ismeleeing() )
    {
        return false;
    }
    
    if ( !self getgroundentity() )
    {
        return false;
    }
    
    superdata = supers_mp::getcurrentsuper();
    
    if ( isdefined( superdata ) )
    {
        if ( superdata.state == 3 && function_727b517dbb3c512b( function_620de7149cc44669() ) )
        {
            return false;
        }
    }
    
    if ( killstreak_utility::is_using_killstreak() )
    {
        return false;
    }
    
    if ( self isswitchingweapon() )
    {
        if ( function_727b517dbb3c512b( self function_ca1904a5dd87fd53() ) )
        {
            return false;
        }
    }
    
    if ( function_727b517dbb3c512b( self getcurrentweapon() ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0xbbfb7423, Offset: 0x2679
// Size: 0xa8, Type: bool
function private function_6691e5d6efa88c07()
{
    if ( !isalive( self ) )
    {
        return false;
    }
    
    if ( self isswimming() || self function_fbf06f80548d841d() )
    {
        return false;
    }
    
    if ( self isparachuting() || self isparachutedeployed() || self isinfreefall() )
    {
        return false;
    }
    
    if ( self isonladder() )
    {
        return false;
    }
    
    if ( player::isinlaststand( self ) )
    {
        return false;
    }
    
    if ( self isinexecutionattack() || self isinexecutionvictim() )
    {
        return false;
    }
    
    if ( self ismeatshieldattacker() || self ismeatshieldvictim() )
    {
        return false;
    }
    
    if ( self.var_420915a121e1cc41 )
    {
        return false;
    }
    
    if ( utility::flag( "gnome_form_disabled" ) )
    {
        return false;
    }
    
    if ( utility::flag( "zm_game_over" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0xe945c1fc, Offset: 0x272a
// Size: 0x18
function private function_620de7149cc44669()
{
    return !self isswitchingweapon() ? self getcurrentweapon() : self function_ca1904a5dd87fd53();
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x8e335edb, Offset: 0x274b
// Size: 0x42, Type: bool
function private function_6d2804f389d6aeb()
{
    weapon = function_620de7149cc44669();
    
    if ( isdefined( weapon ) && weapon::iskillstreakweapon( weapon ) )
    {
        self notify( #"cancel_all_killstreak_deployments" );
        self notify( #"equip_deploy_cancel" );
        return true;
    }
    
    return false;
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0x9999df8f, Offset: 0x2796
// Size: 0x5f, Type: bool
function private function_727b517dbb3c512b( weapon )
{
    if ( killstreak_utility::iskillstreakdeployweapon( weapon ) )
    {
        return true;
    }
    else if ( killstreak_utility::function_ca1af65b4230eb71( weapon ) )
    {
        return true;
    }
    else if ( killstreak_utility::function_2910a801443e6b84( weapon ) )
    {
        return true;
    }
    else if ( killstreak_utility::function_603ce692d8e119af( weapon ) )
    {
        return true;
    }
    else if ( killstreak_utility::function_8bec29aceea719c3( weapon ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x9c5d28af, Offset: 0x27fe
// Size: 0x122
function private function_f7b6b6013626b161()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_28009ab3010672e9" );
    self endon( #"hash_36f455373b2c6a85" );
    start_time = gettime();
    end_time = int( self.gnome_form.progress * self.gnome_form.total_time * 1000 ) + start_time;
    
    while ( self.gnome_form.progress > 0 )
    {
        waitframe();
        time_left = max( 0, ( end_time - gettime() ) * 0.001 );
        progress = max( 0, time_left / self.gnome_form.total_time );
        self.gnome_form.progress = progress;
        
        /#
            self iprintlnbold( "<dev string:x38>" + progress + "<dev string:x43>" + time_left );
        #/
    }
    
    level callback::callback( #"hash_47ee442f8d4a2047", { #player:self } );
    form_cancel();
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x592a91b1, Offset: 0x2928
// Size: 0x52
function private form_disconnect_watcher()
{
    level endon( #"zm_game_over" );
    self endon( #"hash_7245b0213d72d509" );
    self waittill( #"death_or_disconnect" );
    level callback::callback( #"hash_4860b292b1e63c3e", { #player:self } );
    function_c381f9cb94d45f8d();
    form_toggle_state( 0 );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0xe10e19cc, Offset: 0x2982
// Size: 0x35
function private function_ffeb1bc2396c594c()
{
    level endon( #"zm_game_over" );
    self endon( #"hash_7245b0213d72d509" );
    level waittill( #"mq_encounter_starting" );
    thread function_e28b59d485ebb043();
    thread form_cancel();
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x91048a5f, Offset: 0x29bf
// Size: 0x41
function private function_e28b59d485ebb043()
{
    level endon( #"zm_game_over" );
    
    if ( !utility::flag( "gnome_form_disabled" ) )
    {
        utility::flag_set( "gnome_form_disabled" );
    }
    
    utility::flag_wait( "flag_locust_boss_players_entered" );
    utility::flag_clear( "gnome_form_disabled" );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0xba647aa3, Offset: 0x2a08
// Size: 0x4a
function private on_zone_changed( params )
{
    if ( params.zone_struct.zone_name != "zone_downtown_shop" )
    {
        return;
    }
    
    if ( !self.gnome_form.active )
    {
        return;
    }
    
    thread function_fb357f302b14ed04();
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0x7324a1e6, Offset: 0x2a5a
// Size: 0x3a
function private function_7a96d8fc84444088( params )
{
    zone = zone_manager::get_current_zone();
    
    if ( zone.zone_name != "zone_downtown_shop" )
    {
        return;
    }
    
    thread function_fb357f302b14ed04();
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x2c4c7825, Offset: 0x2a9c
// Size: 0x8d
function private function_fb357f302b14ed04()
{
    level endon( #"zm_game_over" );
    self endon( #"death_or_disconnect" );
    level callback::remove( "zone_changed", &on_zone_changed );
    level callback::remove( #"hash_2fc46531ebe36dde", &function_7a96d8fc84444088 );
    
    if ( player_banter::function_4e1aff6241ebea8() )
    {
        player_banter::function_850de641659a4090();
    }
    
    temp_astrid = utility::spawn_tag_origin( ( 3136.5, 3746.92, 196.43 ) );
    temp_astrid thread dialogue::say_self( "dx_zm_lesd_est2_alvn_lesd2gnanstgntf" );
    temp_astrid thread utility::delete_after_delay( 10 );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0x20e34145, Offset: 0x2b31
// Size: 0xf0
function private gnome_chatter( immediate = 0 )
{
    level endon( #"zm_game_over" );
    level endon( #"special_round_end" );
    self endon( #"death" );
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
        self endon( #"hash_7245b0213d72d509" );
    }
    
    if ( !immediate )
    {
        wait randomintrange( 5, 16 );
    }
    
    for ( ;; )
    {
        self.gnome_chatter = 1;
        
        if ( !isplayer( self ) )
        {
            self.var_42ad252ed55abadf = utility::spawn_tag_origin( self.origin, self.angles );
            self.var_42ad252ed55abadf dialogue::say_self( "dx_zm_lesd_est2_lofg_lesd2gngnid" );
            self.var_42ad252ed55abadf delete();
        }
        else
        {
            dialogue::say_self( "dx_zm_lesd_est2_lofg_lesd2gngnid" );
        }
        
        self notify( #"gnome_chatter_done" );
        self.gnome_chatter = 0;
        wait randomintrange( 25, 51 );
    }
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0x7c481583, Offset: 0x2c29
// Size: 0xe7
function private on_zombie_killed( params )
{
    if ( !isdefined( params.eattacker.host ) )
    {
        return;
    }
    
    player = params.eattacker.host;
    
    if ( !player.gnome_form.active )
    {
        return;
    }
    
    if ( params.smeansofdeath != "MOD_PROJECTILE" )
    {
        return;
    }
    
    if ( params.objweapon != level.weaponnone )
    {
        return;
    }
    
    player callback::callback( "zombie_score_event", { #scoreevent:#"zombie_kia_gnome" } );
    
    if ( !utility::cointoss() )
    {
        return;
    }
    
    if ( !utility::time_has_passed( player.gnome_form.kill_cooldown, 60 ) )
    {
        return;
    }
    
    player thread function_4335ab148e48a1a2();
}

// Namespace zm_sat_locust_ee_gnomes
// Params 0, eflags: 0x4
// Checksum 0x464d5557, Offset: 0x2d18
// Size: 0x5b
function private function_4335ab148e48a1a2()
{
    level endon( #"zm_game_over" );
    self endon( #"death_or_disconnect" );
    self.gnome_form.kill_cooldown = gettime();
    
    if ( self.gnome_chatter )
    {
        utility::waittill_notify_or_timeout( "gnome_chatter_done", 5 );
    }
    
    thread dialogue::say_self( "dx_zm_lesd_est2_lofg_lesd2gngnklln" );
}

// Namespace zm_sat_locust_ee_gnomes
// Params 1, eflags: 0x4
// Checksum 0x3668d9e3, Offset: 0x2d7b
// Size: 0x18
function private on_game_ended( params )
{
    utility::flag_set( "gnome_form_disabled" );
}

/#

    // Namespace zm_sat_locust_ee_gnomes
    // Params 0, eflags: 0x4
    // Checksum 0x993a7adf, Offset: 0x2d9b
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace zm_sat_locust_ee_gnomes
    // Params 0, eflags: 0x4
    // Checksum 0x7a171b5b, Offset: 0x2daf
    // Size: 0x5e, Type: dev
    function private devgui_init()
    {
        zm_quest::function_bc99f123a684344f( #"hash_1cf7ef91edc75b52" );
        devgui::add_devgui_func( "<dev string:x52>", "<dev string:x60>", &function_4d45f82243372c5 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x71>", "<dev string:x88>", &function_2f29b43fc97ceeea );
        devgui::function_cd4e263c1f3018ae( "<dev string:xa0>", "<dev string:xba>", &function_2f29b43fc97ceeea );
        zm_quest::function_c1400a2f4670c23f();
    }

    // Namespace zm_sat_locust_ee_gnomes
    // Params 0, eflags: 0x4
    // Checksum 0x31d02bf6, Offset: 0x2e15
    // Size: 0xd, Type: dev
    function private function_4d45f82243372c5()
    {
        level thread function_71dfb722fc60c94a();
    }

    // Namespace zm_sat_locust_ee_gnomes
    // Params 0, eflags: 0x4
    // Checksum 0x86629676, Offset: 0x2e2a
    // Size: 0xcc, Type: dev
    function private function_71dfb722fc60c94a()
    {
        if ( utility::flag( "<dev string:x60>" ) )
        {
            utility::flag_clear( "<dev string:x60>" );
            return;
        }
        else
        {
            utility::flag_set( "<dev string:x60>" );
        }
        
        foreach ( gnome in level.ee_gnomes.in_world )
        {
            debug::sphere( gnome, 64, ( 1, 0, 0 ), undefined, "<dev string:x60>", "<dev string:xd4>" );
        }
    }

    // Namespace zm_sat_locust_ee_gnomes
    // Params 1, eflags: 0x4
    // Checksum 0x14572933, Offset: 0x2efe
    // Size: 0x91, Type: dev
    function private function_2f29b43fc97ceeea( params )
    {
        if ( params[ 0 ] == "<dev string:xda>" )
        {
            player = level.players[ 0 ];
        }
        else
        {
            contents = trace::create_character_contents();
            trace = zm_sat_locust_util::get_player_trace( level.players[ 0 ], getaiarray(), contents );
            
            if ( trace[ "<dev string:xdf>" ] && isplayer( trace[ "<dev string:xdf>" ] ) )
            {
                player = trace[ "<dev string:xdf>" ];
            }
        }
        
        player thread function_4be5cd91b1cef783();
    }

    // Namespace zm_sat_locust_ee_gnomes
    // Params 0, eflags: 0x4
    // Checksum 0x58b28af6, Offset: 0x2f97
    // Size: 0xc, Type: dev
    function private function_4be5cd91b1cef783()
    {
        thread function_e12daa32bc251158();
    }

#/
