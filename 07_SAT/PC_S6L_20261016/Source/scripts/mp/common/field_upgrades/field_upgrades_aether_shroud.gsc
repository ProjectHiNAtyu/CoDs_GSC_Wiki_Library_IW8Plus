// scripts\mp\common\field_upgrades\field_upgrades_aether_shroud.gsc  (hash_65da5c4e10ce96dd.gscc) (size: 7941 Bytes / 0x1f05 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfb2b3485 (4213912709)
// size ...... 7941 (0x1f05)
// includes .. 11  (offset: 0x1c8d)
// strings ... 30  (offset: 0x1ce5)
// dev strs .. 5   (offset: 0x1ec9)
// exports ... 21  (offset: 0x1131)
// cseg ...... 0x2e4 + 0xe4d (0x1131)
// imports ... 70  (offset: 0x1479)
// animtree1 . 0   (offset: 0x1f05)
// animtree2 . 0   (offset: 0x1f05)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\field_upgrades\field_upgrades;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\supers;

#namespace field_upgrades_aether_shroud;

// Namespace field_upgrades_aether_shroud
// Params 0, eflags: 0x5
// Checksum 0x589cbe8e, Offset: 0x302
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"aether_shroud", undefined, undefined, &init );
}

// Namespace field_upgrades_aether_shroud
// Params 0
// Checksum 0x68ef3572, Offset: 0x323
// Size: 0x188
function init()
{
    superbundle = field_upgrades::function_1fcc83f10e7752e5( "super_aether_shroud" );
    
    if ( !isdefined( superbundle ) )
    {
        return;
    }
    
    var_41bf192ada44559a = superbundle.var_1b41e5673800aa21;
    var_d881ff74de58de57 = superbundle.var_8eb1b6b613d4c005;
    var_9d9c7b953ee02aac = superbundle.var_fbc87e444b409bba;
    level._effect[ "aether_shroud_1p_effect" ] = loadfxasset( var_41bf192ada44559a ?? "" );
    level._effect[ "aether_shroud_3p_head_effect" ] = loadfxasset( var_d881ff74de58de57 ?? "" );
    level._effect[ "aether_shroud_3p_torso_effect" ] = loadfxasset( var_9d9c7b953ee02aac ?? "" );
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_aether_shroud", &set_aether_shroud, &unset_aether_shroud, &begin_use_aether_shroud, &function_63c791098b816b7, undefined, &set_aether_shroud );
    
    if ( !isdefined( level.var_6f847c531576ce6b ) )
    {
        level.var_6f847c531576ce6b = [];
    }
    
    if ( !isdefined( level.var_1eb7c7e5ddc66725 ) )
    {
        level.var_1eb7c7e5ddc66725 = [];
    }
    
    scene::function_85b13b837056bc8b( &function_406825b10cce6821 );
    level callback::add( #"on_ai_killed_medal", &on_killed_medal );
    level callback::add( #"player_laststand_revived", &on_player_revived_aether_shroud );
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_command( "<dev string:x3a>", "<dev string:x4d>" );
        devgui::add_devgui_command( "<dev string:x7c>", "<dev string:x92>" );
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace field_upgrades_aether_shroud
// Params 0
// Checksum 0xb60676a6, Offset: 0x4b3
// Size: 0x8b
function function_406825b10cce6821()
{
    foreach ( player in level.players )
    {
        if ( player utility::ent_flag( "aether_shroud_in_use" ) )
        {
            player function_63c791098b816b7();
        }
    }
}

// Namespace field_upgrades_aether_shroud
// Params 0
// Checksum 0x690625ed, Offset: 0x546
// Size: 0xef
function set_aether_shroud()
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"aether_shroud_extension" ) )
    {
        base_duration = field_upgrades::function_5f728868b18ef0c0( "super_aether_shroud", #"hash_50e0747334dae395" );
        
        if ( !isdefined( base_duration ) )
        {
            base_duration = 8;
        }
        
        self.var_87e9b1896b9a4e5f = base_duration;
        extend_amount = base_duration + base_duration * ( level.zombie_augments[ #"aether_shroud_extension" ].var_756d4b57563470dc ?? 0 );
        self.super.staticdata.usetime = extend_amount;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"aether_shroud_high_capacity" ) && !isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        perk::giveperk( "specialty_overcharge_field_upgrade" );
    }
}

// Namespace field_upgrades_aether_shroud
// Params 0
// Checksum 0x6c7632a, Offset: 0x63d
// Size: 0x7a
function unset_aether_shroud()
{
    if ( isdefined( self.var_87e9b1896b9a4e5f ) )
    {
        self.super.staticdata.usetime = self.var_87e9b1896b9a4e5f;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"aether_shroud_high_capacity" ) && isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        perk::removeperk( "specialty_overcharge_field_upgrade" );
    }
}

// Namespace field_upgrades_aether_shroud
// Params 3
// Checksum 0x783fccd9, Offset: 0x6bf
// Size: 0x85
function function_fc2c22d3c418e1c4( v_position, n_radius, str_vol_targetname )
{
    var_9f829dd4984d562e = spawnstruct();
    var_9f829dd4984d562e.v_position = v_position;
    var_9f829dd4984d562e.n_radius = n_radius;
    var_9f829dd4984d562e.str_vol_targetname = str_vol_targetname;
    
    if ( !isdefined( level.var_6f847c531576ce6b ) )
    {
        level.var_6f847c531576ce6b = [];
    }
    
    level.var_6f847c531576ce6b[ level.var_6f847c531576ce6b.size ] = var_9f829dd4984d562e;
}

// Namespace field_upgrades_aether_shroud
// Params 1
// Checksum 0x7064fb2f, Offset: 0x74c
// Size: 0x136
function function_8c8f958e252e459a( str_vol_targetname )
{
    if ( isarray( level.var_6f847c531576ce6b ) )
    {
        a_s_to_remove = [];
        
        foreach ( var_9f829dd4984d562e in level.var_6f847c531576ce6b )
        {
            if ( var_9f829dd4984d562e.str_vol_targetname == str_vol_targetname )
            {
                if ( !isdefined( a_s_to_remove ) )
                {
                    a_s_to_remove = [];
                }
                
                a_s_to_remove[ a_s_to_remove.size ] = var_9f829dd4984d562e;
            }
        }
        
        foreach ( s_to_remove in a_s_to_remove )
        {
            level.var_6f847c531576ce6b = arrayremove( level.var_6f847c531576ce6b, s_to_remove );
        }
    }
}

// Namespace field_upgrades_aether_shroud
// Params 1
// Checksum 0x77a8bae2, Offset: 0x88a
// Size: 0x5c
function function_389c71a28c63b4e6( var_97295a559c409ff5 )
{
    if ( isstring( var_97295a559c409ff5 ) )
    {
        var_97295a559c409ff5 = getent( var_97295a559c409ff5, #targetname );
    }
    
    if ( isent( var_97295a559c409ff5 ) )
    {
        if ( !isdefined( level.var_1eb7c7e5ddc66725 ) )
        {
            level.var_1eb7c7e5ddc66725 = [];
        }
        
        level.var_1eb7c7e5ddc66725[ level.var_1eb7c7e5ddc66725.size ] = var_97295a559c409ff5;
    }
}

// Namespace field_upgrades_aether_shroud
// Params 1
// Checksum 0x9940023f, Offset: 0x8ee
// Size: 0x47
function function_d14f1f669499ab41( var_97295a559c409ff5 )
{
    if ( isstring( var_97295a559c409ff5 ) )
    {
        var_97295a559c409ff5 = getent( var_97295a559c409ff5, #targetname );
    }
    
    if ( isent( var_97295a559c409ff5 ) )
    {
        level.var_1eb7c7e5ddc66725 = arrayremove( level.var_1eb7c7e5ddc66725, var_97295a559c409ff5 );
    }
}

// Namespace field_upgrades_aether_shroud
// Params 0
// Checksum 0xd2da7497, Offset: 0x93d
// Size: 0x99, Type: bool
function begin_use_aether_shroud()
{
    if ( isdefined( level.field_upgrade_bundles[ "super_aether_shroud" ] ) )
    {
        aethershroudweapon = level.field_upgrade_bundles[ "super_aether_shroud" ].offhandweapon;
        thread function_bc842998963a71c6( aethershroudweapon );
        deploysuccess = field_upgrades::field_upgrade_play_gesture( aethershroudweapon, "super_aether_shroud" );
        
        if ( deploysuccess )
        {
            currentweapon = self getcurrentweapon();
            
            if ( !currentweapon.isdualwield )
            {
                self setscriptablepartstate( "wand_fx", "wand_on_aether_shroud", 0 );
            }
            
            thread aether_shroud_active();
            return true;
        }
    }
    
    return false;
}

// Namespace field_upgrades_aether_shroud
// Params 1, eflags: 0xc
// Checksum 0xcdae890b, Offset: 0x9df
// Size: 0x89
function private function_bc842998963a71c6( weapon_name )
{
    self notify( #"hash_31aad48d50f1a739" );
    self endon( #"hash_31aad48d50f1a739" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"end_aether_shroud" );
    self waittill( #"last_stand_enter" );
    gesture_weapon = makeweapon( weapon_name );
    wait gesture_weapon.firetime;
    waitframe();
    
    if ( utility::ent_flag( "aether_shroud_in_use" ) )
    {
        thread function_63c791098b816b7();
    }
}

// Namespace field_upgrades_aether_shroud
// Params 0, eflags: 0xc
// Checksum 0x13538943, Offset: 0xa70
// Size: 0x43
function private function_27d8618a2a5e0659()
{
    self notify( #"hash_f3f2c135cd4fff7b" );
    self endon( #"hash_f3f2c135cd4fff7b" );
    self endon( #"end_aether_shroud", #"death_or_disconnect" );
    self waittill( #"weapon_fired" );
    thread supers_mp::superusefinished();
}

// Namespace field_upgrades_aether_shroud
// Params 2
// Checksum 0xb708557f, Offset: 0xabb
// Size: 0xe8, Type: bool
function function_63c791098b816b7( fromdeath, attacker )
{
    self notify( #"end_aether_shroud" );
    utility::ent_flag_clear( "field_upgrade_in_use" );
    utility::ent_flag_clear( "aether_shroud_in_use" );
    params = { #var_4ce2be89357100be:self.aether_shroud_kill_count ?? 0, #player:self };
    callback::callback( "aether_shroud_ended", params );
    callback::callback( "field_upgrade_ended", { #ref:"super_aether_shroud" } );
    
    if ( self.aether_shroud_kill_count >= 5 )
    {
        if ( utility::issharedfuncdefined( #"sound", #"play_scoreevent_vo", 0 ) )
        {
            utility::callsharedfunc( #"sound", #"play_scoreevent_vo", self, #"bc_super_aether_shroud_success" );
        }
    }
    
    self.aether_shroud_kill_count = undefined;
    return false;
}

// Namespace field_upgrades_aether_shroud
// Params 0
// Checksum 0xa140217a, Offset: 0xbac
// Size: 0x230
function aether_shroud_active()
{
    self endon( #"disconnect" );
    utility::ent_flag_init( "field_upgrade_in_use" );
    utility::ent_flag_set( "field_upgrade_in_use" );
    utility::ent_flag_init( "aether_shroud_in_use" );
    utility::ent_flag_set( "aether_shroud_in_use" );
    self.aether_shroud_active = 1;
    var_dc58879cfee40e71 = level.superglobals.staticsuperdata[ "super_aether_shroud" ].usetime;
    params = { #duration:var_dc58879cfee40e71, #player:self };
    callback::callback( "aether_shroud_started", params );
    
    if ( self.var_568623dc77af5450 )
    {
        self.var_568623dc77af5450 = undefined;
        postfxbundle = level.field_upgrade_bundles[ "super_aether_shroud" ].var_67f9d640c30063e7;
        pbgpostfxbundleend( self, postfxbundle );
    }
    
    if ( isdefined( level.var_83d22984577c2e1c ) )
    {
        self [[ level.var_83d22984577c2e1c ]]( 1 );
    }
    else
    {
        val::set( "aether_shroud", "ignoreme", 1 );
    }
    
    val::set( "aether_shroud", "allow_grab", 0 );
    thread function_e4cf58e5cd81aa53();
    
    if ( level.field_upgrade_bundles[ "super_aether_shroud" ].var_31de3b2154460b4 )
    {
        var_d7f262dcf07a14c5 = level.sharedfuncs[ #"player" ][ #"hash_104a5cd5cbb639b6" ];
        var_64473ee4dca213c1 = level.sharedfuncs[ #"player" ][ #"hash_64b07f4926bae8f8" ];
        
        if ( var_d7f262dcf07a14c5 && var_64473ee4dca213c1 )
        {
            self [[ var_d7f262dcf07a14c5 ]]();
            thread function_27d8618a2a5e0659();
        }
    }
    
    var_efc80e8d3a6c9b8 = utility::waittill_any_timeout( 100, "last_stand_enter", "death", "end_aether_shroud" );
    
    if ( var_64473ee4dca213c1 )
    {
        self [[ var_64473ee4dca213c1 ]]();
    }
    
    if ( isdefined( level.var_83d22984577c2e1c ) )
    {
        self [[ level.var_83d22984577c2e1c ]]( 0 );
    }
    
    val::reset_all( "aether_shroud" );
    thread function_a77d049ba5227e1f();
    self.aether_shroud_active = undefined;
    utility::ent_flag_clear( "field_upgrade_in_use" );
    utility::ent_flag_clear( "aether_shroud_in_use" );
}

// Namespace field_upgrades_aether_shroud
// Params 0
// Checksum 0x972fc059, Offset: 0xde4
// Size: 0x6c
function function_ee25e63da29db8ca()
{
    curweap = self getcurrentprimaryweapon();
    total_ammo = self getammocount( curweap );
    clip_size = int( min( total_ammo, weaponclipsize( curweap ) ) );
    var_310403950a4736a3 = total_ammo - clip_size;
    
    if ( var_310403950a4736a3 < 0 )
    {
        var_310403950a4736a3 = 0;
        clip_size = total_ammo;
    }
    
    self setweaponammoclip( curweap, clip_size );
    self setweaponammostock( curweap, var_310403950a4736a3 );
}

// Namespace field_upgrades_aether_shroud
// Params 0
// Checksum 0x48355b6, Offset: 0xe58
// Size: 0x80
function function_e4cf58e5cd81aa53()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"end_aether_shroud" );
    thread aether_shroud_fov_change();
    postfxbundle = level.field_upgrade_bundles[ "super_aether_shroud" ].var_67f9d640c30063e7;
    pbgpostfxbundlestart( self, postfxbundle );
    waitframe();
    
    if ( isalive( self ) && !player::isinlaststand( self ) )
    {
        self setscriptablepartstate( "aether_shroud_fx", "super_fx_on", 0 );
    }
}

// Namespace field_upgrades_aether_shroud
// Params 0
// Checksum 0x66564572, Offset: 0xee0
// Size: 0x4f
function aether_shroud_fov_change()
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_6905fb37f08f5a8e" );
    self endon( #"hash_6905fb37f08f5a8e" );
    self lerpfovbypreset( "zombiedefault" );
    utility::waittill_any_timeout_no_endon_death( 100, "super_use_finished", "end_aether_shroud" );
    self lerpfovbypreset( "default_2seconds" );
}

// Namespace field_upgrades_aether_shroud
// Params 0
// Checksum 0x722808eb, Offset: 0xf37
// Size: 0x40
function function_a77d049ba5227e1f()
{
    postfxbundle = level.field_upgrade_bundles[ "super_aether_shroud" ].var_67f9d640c30063e7;
    pbgpostfxbundleend( self, postfxbundle );
    self setscriptablepartstate( "aether_shroud_fx", "super_fx_deactivate", 0 );
}

// Namespace field_upgrades_aether_shroud
// Params 1, eflags: 0x4
// Checksum 0x7682dbe0, Offset: 0xf7f
// Size: 0x116
function private on_killed_medal( params )
{
    player = params.attacker;
    
    if ( player.aether_shroud_active )
    {
        if ( !isdefined( player.aether_shroud_kill_count ) )
        {
            player.aether_shroud_kill_count = 0;
        }
        
        player.aether_shroud_kill_count++;
        
        if ( player.aether_shroud_kill_count == 5 )
        {
            player namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_hideandseek" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                player utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_hideandseek" );
            }
        }
        
        params = { #stats:"kills_while_active", #ref:"super_aether_shroud", #field_upgrade:"aether_shroud", #victim:params.victim, #player:player };
        player callback::callback( "on_field_upgrade_kill_track", params );
    }
}

// Namespace field_upgrades_aether_shroud
// Params 1, eflags: 0x4
// Checksum 0x2381cfaf, Offset: 0x109d
// Size: 0x94
function private on_player_revived_aether_shroud( params )
{
    if ( params.reviver != self && params.reviver.aether_shroud_active )
    {
        reviver = params.reviver;
        reviver namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_spectralsalvation" );
        reviver callback::callback( "field_upgrade_stats_track", { #stats:"revives_while_shrouded", #ref:"super_aether_shroud", #player:reviver } );
    }
}

