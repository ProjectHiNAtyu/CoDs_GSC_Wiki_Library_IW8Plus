// scripts\mp\augments\aether_shroud_augments.gsc  (hash_7be4e7aa981d7545.gscc) (size: 18093 Bytes / 0x46ad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x243d60bc (608002236)
// size ...... 18093 (0x46ad)
// includes .. 17  (offset: 0x42b1)
// strings ... 58  (offset: 0x4339)
// dev strs .. 0   (offset: 0x46ad)
// exports ... 28  (offset: 0x2d45)
// cseg ...... 0x579 + 0x27cc (0x2d45)
// imports ... 138 (offset: 0x31a5)
// animtree1 . 0   (offset: 0x46ad)
// animtree2 . 0   (offset: 0x46ad)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\field_upgrades\field_upgrades_aether_shroud;
#using scripts\mp\common\utility\perk;
#using scripts\mp\gametypes\common;
#using scripts\mp\outofbounds;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace aether_shroud_augments;

// Namespace aether_shroud_augments
// Params 0, eflags: 0x5
// Checksum 0x3af0a788, Offset: 0x597
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"aether_shroud_augments", undefined, &init_aether_shroud_augments, undefined );
}

// Namespace aether_shroud_augments
// Params 0
// Checksum 0xcb933226, Offset: 0x5b8
// Size: 0x1a5
function init_aether_shroud_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    level._effect[ "aether_shroud_teleport" ] = loadfxasset( "vfx_t10_gameplay_zm_ai_aether_shroud_quickmove" );
    callback::add( #"player_connect", &function_d683e59d349a267 );
    callback::add( #"on_ai_killed", &function_39000a8ac04a6b77 );
    callback::add( #"player_disconnect", &function_70e0b61acc98bd45 );
    zombie_utils::function_dfae6a5bd222c586( &function_cdb581edad8e148f );
    utility::registersharedfunc( #"aether_shroud", #"hash_1273deb22f1e3ca2", &function_26955fb0cb56b2a9 );
    utility::registersharedfunc( #"aether_shroud", #"hash_e34f2d0d3f7de38f", &function_cf4dc7376f7f1a44 );
    field_upgrades_aether_shroud::function_fc2c22d3c418e1c4( undefined, undefined, "aether_shroud_teleport_exclude_volume" );
    
    if ( isdefined( level.zombie_augments[ #"aether_shroud_afterimage" ] ) )
    {
        var_2849d1231115e2d6 = level.zombie_augments[ #"aether_shroud_afterimage" ].var_9c428a695fb1a65c;
        
        if ( isdefined( var_2849d1231115e2d6 ) )
        {
            level._effect[ "aether_shroud_afterimage_fx" ] = loadfxasset( var_2849d1231115e2d6 );
        }
    }
    
    if ( !isdefined( level.var_db9bfced1ac2187f ) )
    {
        content = [ "physicscontents_edge", "physicscontents_glass", "physicscontents_water", "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicleclip", "physicscontents_itemclip", "physicscontents_clipshot", "physicscontents_characterproxy", "physicscontents_playerclip", "physicscontents_vehicle" ];
        level.var_db9bfced1ac2187f = physics_createcontents( content );
    }
}

// Namespace aether_shroud_augments
// Params 1
// Checksum 0x6a67024, Offset: 0x765
// Size: 0x3a
function function_26955fb0cb56b2a9( zone_names )
{
    if ( !isdefined( level.var_9b4c25e805ef1d13 ) )
    {
        level.var_9b4c25e805ef1d13 = [];
    }
    
    level.var_9b4c25e805ef1d13 = arraycombine( level.var_9b4c25e805ef1d13, zone_names );
}

// Namespace aether_shroud_augments
// Params 1
// Checksum 0x3a6271a1, Offset: 0x7a7
// Size: 0xc0
function function_cf4dc7376f7f1a44( zone_names )
{
    if ( !isdefined( level.var_9b4c25e805ef1d13 ) )
    {
        level.var_9b4c25e805ef1d13 = [];
    }
    
    foreach ( index, zone_name in zone_names )
    {
        if ( arraycontains( level.var_9b4c25e805ef1d13, zone_name ) )
        {
            level.var_9b4c25e805ef1d13[ index ] = undefined;
            
            if ( isint( index ) )
            {
                function_cdc669dbc8ea2101( level.var_9b4c25e805ef1d13 );
            }
        }
    }
}

// Namespace aether_shroud_augments
// Params 1
// Checksum 0x23bac77, Offset: 0x86f
// Size: 0x27f
function function_70e0b61acc98bd45( params )
{
    if ( utility::ent_flag( "aether_shroud_in_use" ) && function_cc279e012ff064d8( #"aether_shroud_group_shroud" ) )
    {
        n_radius = level.zombie_augments[ #"aether_shroud_taken" ].var_d0066831520586e2 ?? 512;
        n_radius *= n_radius;
        
        foreach ( player in level.players )
        {
            if ( self == player )
            {
                continue;
            }
            
            if ( self.team != player.team )
            {
                continue;
            }
            
            if ( player utility::ent_flag( "aether_shroud_in_use" ) )
            {
                continue;
            }
            
            if ( distance2dsquared( player.origin, self.origin ) < n_radius )
            {
                b_remove_aether_shroud = 1;
                
                if ( player.var_568623dc77af5450 )
                {
                    foreach ( other_player in level.players )
                    {
                        if ( player == other_player || other_player.team != self.team )
                        {
                            continue;
                        }
                        
                        if ( distance2dsquared( player.origin, other_player.origin ) < n_radius && other_player utility::ent_flag( "aether_shroud_in_use" ) && other_player function_cc279e012ff064d8( #"aether_shroud_group_shroud" ) )
                        {
                            b_remove_aether_shroud = 0;
                            break;
                        }
                    }
                }
                
                if ( b_remove_aether_shroud )
                {
                    player val::reset( "aether_shroud_group_shroud", "ignoreme" );
                    player.var_568623dc77af5450 = undefined;
                    player field_upgrades_aether_shroud::function_a77d049ba5227e1f();
                    player callback::callback( "aether_shroud_group_remove", { #player:player } );
                    
                    if ( !player.aether_shroud_active )
                    {
                        player notify( #"end_aether_shroud" );
                    }
                }
            }
        }
    }
}

// Namespace aether_shroud_augments
// Params 1
// Checksum 0x67802a7c, Offset: 0xaf6
// Size: 0x2e
function function_d683e59d349a267( sparams )
{
    callback::add( "aether_shroud_started", &augment_aether_shroud_started );
    callback::add( "aether_shroud_ended", &augment_aether_shroud_ended );
}

// Namespace aether_shroud_augments
// Params 1
// Checksum 0x6065fcd, Offset: 0xb2c
// Size: 0x2ff
function augment_aether_shroud_started( sparams )
{
    if ( function_cc279e012ff064d8( #"aether_shroud_aether_dash" ) )
    {
        thread aether_shroud_teleport();
    }
    
    if ( function_cc279e012ff064d8( #"aether_shroud_taken" ) )
    {
        thread aether_shroud_taken_damage();
        thread aether_shroud_taken_speed_up();
    }
    
    if ( function_cc279e012ff064d8( #"aether_shroud_group_shroud" ) )
    {
        thread aether_shroud_group_shroud();
    }
    
    if ( function_cc279e012ff064d8( #"aether_shroud_shadow_blade" ) )
    {
        if ( isdefined( self.var_cc1262e66dbb1c79 ) )
        {
            self.var_e128bf4e7e72ad92 = self getcurrentweapon();
            self.shadowbladekills = 0;
            self switchtoweaponimmediate( self.var_cc1262e66dbb1c79 );
            val::set( "aether_shroud_shadow_blade", "weapon_switch", 0 );
            
            if ( function_cc279e012ff064d8( #"aether_shroud_shadow_blade" ) && !utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_faster_melee" ) )
            {
                perk::giveperk( "specialty_fastermelee" );
            }
            
            thread function_48b8aa69cf868c45();
        }
    }
    
    if ( function_cc279e012ff064d8( #"aether_shroud_otherworldly_reload" ) )
    {
        ammoscalar = 0.2;
        currentweapon = self getcurrentweapon();
        max_clip_size = weaponclipsize( currentweapon );
        var_482e9999b75ed3d8 = istrue( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_pack_mule" ) );
        var_1d280e09faabad5b = utility::get_max_stock_ammo( currentweapon, var_482e9999b75ed3d8 );
        var_7ee2cd26e86a1ceb = weapon::iswonderweapon( currentweapon );
        
        if ( var_7ee2cd26e86a1ceb )
        {
            ammoscalar = 0.2;
        }
        
        if ( currentweapon.reloaddisabled )
        {
            max_clip_size = weaponclipsize( currentweapon );
            ammoscalar = 0.2;
            new_amount = int( min( self getweaponammoclip( currentweapon ) + max_clip_size * ammoscalar, max_clip_size ) );
            self setweaponammoclip( currentweapon, new_amount );
        }
        else
        {
            maxammo = max_clip_size + var_1d280e09faabad5b;
            current_ammo_clip = self getweaponammoclip( currentweapon );
            current_ammo_stock = self getweaponammostock( currentweapon );
            
            if ( maxammo == 0 )
            {
                if ( !currentweapon.ismelee && current_ammo_clip < currentweapon.clipsize )
                {
                    new_amount = current_ammo_clip + max( 1, maxammo * ammoscalar );
                    new_amount = min( new_amount, max_clip_size );
                    self setweaponammoclip( currentweapon, int( new_amount ) );
                }
            }
            else
            {
                ammo_gain = max( 1, maxammo * ammoscalar );
                ammo_gain = max( ammo_gain, current_ammo_clip );
                var_94d4d4ee80644599 = abs( max_clip_size - current_ammo_clip );
                ammo_remainder = ammo_gain > var_94d4d4ee80644599 ? ammo_gain - var_94d4d4ee80644599 : 0;
                self setweaponammoclip( currentweapon, int( min( current_ammo_clip + ammo_gain, max_clip_size ) ) );
                self setweaponammostock( currentweapon, int( min( current_ammo_stock + ammo_remainder, var_1d280e09faabad5b ) ) );
            }
        }
    }
    
    if ( function_cc279e012ff064d8( #"aether_shroud_afterimage" ) )
    {
        thread function_3ef7dfb91d9bc704();
    }
}

// Namespace aether_shroud_augments
// Params 0, eflags: 0x4
// Checksum 0xcb93c9d0, Offset: 0xe33
// Size: 0x317
function private function_b35a83dbab9c07c6()
{
    if ( !isdefined( level.aether_clones ) )
    {
        level.aether_clones = [];
    }
    
    player = self;
    
    if ( isdefined( player.var_11a8ef77fa83ab5c ) )
    {
        player.var_11a8ef77fa83ab5c function_3d49312028a8aacd();
    }
    
    forward = vectornormalize( anglestoforward( self.angles ) );
    forward *= 64;
    spawnorigin = self.origin + forward;
    
    if ( !utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", spawnorigin ) )
    {
        left = vectornormalize( anglestoleft( self.angles ) );
        left *= 64;
        spawnorigin = self.origin + left;
    }
    
    if ( !utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", spawnorigin ) )
    {
        right = vectornormalize( anglestoright( self.angles ) );
        right *= 64;
        spawnorigin = self.origin + right;
    }
    
    if ( !utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", spawnorigin ) )
    {
        behind = vectornormalize( anglestoforward( self.angles ) );
        behind *= -1;
        behind *= 64;
        spawnorigin = self.origin + behind;
    }
    
    if ( !utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", spawnorigin ) )
    {
        spawnorigin = self.origin;
    }
    
    decoyorigin = getclosestpointonnavmesh( spawnorigin );
    decoyorigin = getgroundposition( decoyorigin, 1 );
    offset = ( 0, 0, 0 );
    decoyorigin += offset;
    player.var_11a8ef77fa83ab5c = spawn( "script_model", decoyorigin );
    player.var_11a8ef77fa83ab5c function_ce21f4102d5d17f6( player.operatorcustomization.skinref, "super_combat_hologram_aether_shadow_clone" );
    player.var_11a8ef77fa83ab5c.team = player.team;
    player.var_11a8ef77fa83ab5c.owner = player;
    player.var_11a8ef77fa83ab5c setentityowner( player );
    player.var_11a8ef77fa83ab5c setotherent( player );
    player.var_11a8ef77fa83ab5c.angles = player.angles;
    player.var_11a8ef77fa83ab5c scriptmodelplayanim( "mp_stand_melee_hit_01_me_fists", "combatHolo_notify" );
    player.var_11a8ef77fa83ab5c.spawnedtype = 0;
    player.var_11a8ef77fa83ab5c setscriptablepartstate( #"fx", #"on" );
    level.aether_clones = function_46f9072493651dc9( level.aether_clones );
    level.aether_clones[ level.aether_clones.size ] = player.var_11a8ef77fa83ab5c;
}

// Namespace aether_shroud_augments
// Params 1
// Checksum 0x1791910b, Offset: 0x1152
// Size: 0x174
function augment_aether_shroud_ended( sparams )
{
    foreach ( player in level.players )
    {
        if ( self.team != player.team )
        {
            continue;
        }
        
        player val::reset( "aether_shroud_group_shroud", "ignoreme" );
        
        if ( player.var_568623dc77af5450 )
        {
            player.var_568623dc77af5450 = undefined;
            player field_upgrades_aether_shroud::function_a77d049ba5227e1f();
            
            if ( !player.aether_shroud_active )
            {
                player notify( #"end_aether_shroud" );
            }
        }
    }
    
    if ( isdefined( self.var_e128bf4e7e72ad92 ) )
    {
        self switchtoweaponimmediate( self.var_e128bf4e7e72ad92 );
        self.var_e128bf4e7e72ad92 = undefined;
    }
    
    self notify( #"end_taken_speedup" );
    val::reset( "aether_shroud_shadow_blade", "weapon_switch" );
    
    if ( function_cc279e012ff064d8( #"aether_shroud_shadow_blade" ) && !utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_faster_melee" ) )
    {
        perk::removeperk( "specialty_fastermelee" );
    }
}

// Namespace aether_shroud_augments
// Params 0
// Checksum 0x6daa6597, Offset: 0x12ce
// Size: 0x4d
function function_48b8aa69cf868c45()
{
    self endon( #"end_aether_shroud" );
    self endon( #"death_or_disconnect" );
    self playsoundevent( %"sndevent_shadowblade_raise" );
    
    while ( true )
    {
        self waittill( #"melee_swipe_start" );
        self playsoundevent( %"sndevent_shadowblade_melee" );
    }
}

// Namespace aether_shroud_augments
// Params 0, eflags: 0xc
// Checksum 0x3012ce4b, Offset: 0x1323
// Size: 0x3b8
function private aether_shroud_group_shroud()
{
    self notify( #"hash_376c07da71b1b48e" );
    self endon( #"hash_376c07da71b1b48e" );
    self endon( #"end_aether_shroud" );
    self endon( #"death_or_disconnect" );
    usetime = level.superglobals.staticsuperdata[ "super_aether_shroud" ].usetime;
    starttime = gettime();
    endtime = starttime + usetime * 1000;
    n_radius = level.zombie_augments[ #"aether_shroud_taken" ].var_d0066831520586e2 ?? 512;
    n_radius *= n_radius;
    self.aether_shroud_group_shroud = [];
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player == self )
            {
                continue;
            }
            
            if ( self.team != player.team )
            {
                continue;
            }
            
            if ( player utility::ent_flag( "aether_shroud_in_use" ) )
            {
                continue;
            }
            
            var_58df457fb4eec4cf = 0;
            
            foreach ( other_player in level.players )
            {
                if ( other_player == player )
                {
                    continue;
                }
                
                if ( self.team != other_player.team )
                {
                    continue;
                }
                
                can_affect = 1;
                
                if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
                {
                    can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( other_player, player );
                }
                
                if ( !can_affect )
                {
                    continue;
                }
                
                if ( player.inlaststand )
                {
                    continue;
                }
                
                if ( distance2dsquared( player.origin, other_player.origin ) < n_radius && other_player utility::ent_flag( "aether_shroud_in_use" ) && other_player function_cc279e012ff064d8( #"aether_shroud_group_shroud" ) )
                {
                    var_58df457fb4eec4cf = 1;
                    break;
                }
            }
            
            if ( var_58df457fb4eec4cf && !player.var_568623dc77af5450 )
            {
                player.var_568623dc77af5450 = 1;
                player val::set( "aether_shroud_group_shroud", "ignoreme", 1 );
                player thread field_upgrades_aether_shroud::function_e4cf58e5cd81aa53();
                callback::callback( "aether_shroud_group_set", { #duration:( endtime - gettime() ) * 0.001, #player:player } );
                continue;
            }
            
            if ( !var_58df457fb4eec4cf && player.var_568623dc77af5450 )
            {
                self.aether_shroud_group_shroud = arrayremove( self.aether_shroud_group_shroud, player );
                player val::reset( "aether_shroud_group_shroud", "ignoreme" );
                player.var_568623dc77af5450 = undefined;
                player field_upgrades_aether_shroud::function_a77d049ba5227e1f();
                callback::callback( "aether_shroud_group_remove", { #player:player } );
                
                if ( !player.aether_shroud_active )
                {
                    player notify( #"end_aether_shroud" );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace aether_shroud_augments
// Params 0, eflags: 0x4
// Checksum 0x7ab05f9f, Offset: 0x16e3
// Size: 0x6c
function private aether_shroud_taken_speed_up()
{
    speedup = level.zombie_augments[ #"aether_shroud_taken" ].var_ba7df557bc039720 ?? 0.1;
    weapons::addextramovespeed( "aether_shroud_taken", speedup );
    
    if ( !common::function_8ff835bf23198a0( "quick_revive_escape_plan" ) )
    {
        common::function_ac4bf3256b2545e3( "aether_shroud_taken", speedup );
    }
    
    weapons::updatemovespeedscale();
    thread aether_shroud_taken_speed_down();
}

// Namespace aether_shroud_augments
// Params 1, eflags: 0x4
// Checksum 0x99cbdaef, Offset: 0x1757
// Size: 0x53
function private aether_shroud_taken_speed_down( duration )
{
    self endon( #"disconnect" );
    utility::waittill_any_timeout( 20, "end_taken_speedup" );
    weapons::removeextramovespeed( "aether_shroud_taken" );
    
    if ( common::function_8ff835bf23198a0( "aether_shroud_taken" ) )
    {
        common::function_d85a92c557ea5a52( "aether_shroud_taken" );
    }
    
    weapons::updatemovespeedscale();
}

// Namespace aether_shroud_augments
// Params 0, eflags: 0x4
// Checksum 0xaa5e28b2, Offset: 0x17b2
// Size: 0x216
function private aether_shroud_taken_damage()
{
    zombie_kill_throttle = throttle::throttle_initialize( "aether_shroud_taken_throttle", 3, level.framedurationseconds );
    playfx( utility::getfx( "energy_mine_sm_explo" ), ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 32 ) );
    n_radius = level.zombie_augments[ #"aether_shroud_taken" ].var_79c9e06aa33242d2 ?? 250;
    affected_agents = getaiarrayinradius( self.origin, n_radius );
    
    if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
    {
        affected_agents = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( affected_agents, self );
    }
    
    objweapon = makeweapon( "aether_shroud" );
    var_622931df2c9b536 = level.zombie_augments[ #"aether_shroud_taken" ].var_7db130b6cd8d5555 ?? 2;
    current_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    base_zombie_max_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", current_round );
    damage = base_zombie_max_health * var_622931df2c9b536;
    
    foreach ( agent in affected_agents )
    {
        if ( !isalive( agent ) )
        {
            continue;
        }
        
        if ( agent.team === self.team )
        {
            continue;
        }
        
        agent dodamage( damage, self.origin, self, self, "MOD_ELEMENTAL_DARK", objweapon, "none", undefined, 1073807360 );
        throttle::throttle_wait_in_queue( zombie_kill_throttle, agent );
    }
}

// Namespace aether_shroud_augments
// Params 1, eflags: 0x4
// Checksum 0xa80999c0, Offset: 0x19d0
// Size: 0x27, Type: bool
function private function_cc279e012ff064d8( augmentname )
{
    return istrue( utility::callsharedfunc( #"zombie", #"player_has_augment", augmentname ) );
}

// Namespace aether_shroud_augments
// Params 1, eflags: 0x4
// Checksum 0xe5356e5a, Offset: 0x1a00
// Size: 0x38
function private function_980ca3f64c4c71d0( velocity )
{
    self endon( #"death_or_disconnect" );
    
    while ( self.var_916bcfb673de02e9 )
    {
        if ( isplayer( self ) )
        {
            self setvelocity( velocity );
        }
        
        waitframe();
    }
}

// Namespace aether_shroud_augments
// Params 0, eflags: 0x4
// Checksum 0xc2bd8089, Offset: 0x1a40
// Size: 0x2b0
function private aether_shroud_teleport()
{
    self endon( #"disconnect" );
    
    if ( self.b_disable_aether_shroud_teleport )
    {
        return;
    }
    
    if ( self.var_d1c4c78b9fb7d153 )
    {
        return;
    }
    
    fxid = utility::getfx( "aether_shroud_teleport" );
    playfxontag( fxid, self, "j_spine4" );
    var_12905f37d92d8d76 = 1000;
    var_88d00a565ab1cb5a = self getvelocity();
    normalizedvel = vectornormalize( var_88d00a565ab1cb5a );
    var_4c9d1becf9041a5c = var_88d00a565ab1cb5a;
    
    if ( var_88d00a565ab1cb5a[ 0 ] < 65 && var_88d00a565ab1cb5a[ 0 ] > -65 && var_88d00a565ab1cb5a[ 1 ] < 65 && var_88d00a565ab1cb5a[ 1 ] > -65 )
    {
        forward = anglestoforward( self.angles );
        forward = vectornormalize( forward );
        normalizedvel = forward;
    }
    
    xboost = clamp( normalizedvel[ 0 ] * var_12905f37d92d8d76, -700, 700 );
    yboost = clamp( normalizedvel[ 1 ] * var_12905f37d92d8d76, -700, 700 );
    zboost = clamp( normalizedvel[ 2 ], -50, 50 );
    var_88d00a565ab1cb5a += ( xboost, yboost, zboost );
    
    if ( self tagexists( "tag_flash" ) )
    {
        playercenter = self gettagorigin( "tag_flash" );
    }
    else
    {
        playercenter = self getcentroid();
    }
    
    finalpos = playercenter + var_88d00a565ab1cb5a;
    self.var_916bcfb673de02e9 = 1;
    var_87ccf04521c5906c = vectornormalize( var_88d00a565ab1cb5a );
    var_87ccf04521c5906c *= 32;
    testwall = playercenter + var_87ccf04521c5906c;
    enemiesnearby = getaiarrayinradius( self.origin, 1024 );
    ignoreents = arraycombine( level.players, enemiesnearby );
    traceresults = trace::sphere_trace( playercenter, testwall, 16, ignoreents, level.var_db9bfced1ac2187f, undefined, 1 );
    
    if ( traceresults[ "fraction" ] < 1 )
    {
        var_222d1843a08c282b = traceresults[ "position" ];
        
        if ( distance2d( var_222d1843a08c282b, playercenter ) < 24 )
        {
            self.var_916bcfb673de02e9 = undefined;
            
            if ( isalive( self ) )
            {
                stopfxontag( fxid, self, "j_spine4" );
            }
            
            return;
        }
    }
    
    thread function_351e6a3d32e9c5c4( playercenter, finalpos, self.origin );
    waitframe();
    
    if ( isplayer( self ) && isalive( self ) && !self.inlaststand )
    {
        thread function_980ca3f64c4c71d0( var_88d00a565ab1cb5a );
    }
    
    wait 0.5;
    
    if ( isplayer( self ) && self.var_916bcfb673de02e9 )
    {
        self setvelocity( var_4c9d1becf9041a5c );
        self.var_916bcfb673de02e9 = undefined;
        
        if ( isalive( self ) )
        {
            stopfxontag( fxid, self, "j_spine4" );
        }
    }
}

// Namespace aether_shroud_augments
// Params 1, eflags: 0x4
// Checksum 0x937250f9, Offset: 0x1cf8
// Size: 0xd5
function private function_922a1a48e134f43d( var_4836193860876db2 )
{
    self endon( #"death_or_disconnect" );
    playerspine = self gettagorigin( "j_spine4" );
    var_4836193860876db2 = ( var_4836193860876db2[ 0 ], var_4836193860876db2[ 1 ], playerspine[ 2 ] );
    movehelper = spawn( "script_model", playerspine );
    movehelper setmodel( "tag_origin" );
    fxid = utility::getfx( "aether_shroud_teleport" );
    playfxontag( fxid, movehelper, "tag_origin" );
    movehelper moveto( var_4836193860876db2, 0.2 );
    wait 0.2;
    playerspine = self gettagorigin( "j_spine4" );
    movehelper moveto( playerspine, 0.2 );
    wait 0.2;
    movehelper linktoblendtotag( self, "j_spine4" );
    stopfxontag( fxid, movehelper, "tag_origin" );
    wait 1;
    movehelper delete();
}

// Namespace aether_shroud_augments
// Params 3, eflags: 0x4
// Checksum 0x9c967dfc, Offset: 0x1dd5
// Size: 0x339
function private function_351e6a3d32e9c5c4( origin, var_4836193860876db2, playerstartpos )
{
    self endon( #"death_or_disconnect" );
    position_offset = origin - playerstartpos;
    var_4836193860876db2 += position_offset;
    contents = trace::create_character_contents();
    trace = trace::sphere_trace_get_all_results( origin, var_4836193860876db2, 64, self, contents );
    var_407deca8e101f26f = [];
    
    foreach ( trace_result in trace )
    {
        if ( isai( trace_result[ "entity" ] ) && isalive( trace_result[ "entity" ] ) && !isdefined( trace_result[ "entity" ].var_bd22ba6c600a23a3 ) )
        {
            var_407deca8e101f26f[ var_407deca8e101f26f.size ] = trace_result[ "entity" ];
        }
    }
    
    objweapon = makeweapon( "aether_shroud" );
    
    if ( isdefined( var_407deca8e101f26f ) && var_407deca8e101f26f.size != 0 )
    {
        /#
        #/
        
        var_d5bdb577cea76e64 = [];
        
        foreach ( possible_enemy in var_407deca8e101f26f )
        {
            if ( isalive( possible_enemy ) && possible_enemy.team != self.team && possible_enemy.aicategory == "normal" && !possible_enemy.magic_bullet_shield && !possible_enemy.damageshield )
            {
                var_d5bdb577cea76e64[ var_d5bdb577cea76e64.size ] = possible_enemy;
            }
        }
        
        if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
        {
            var_d5bdb577cea76e64 = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( var_d5bdb577cea76e64, self );
        }
        
        var_d5bdb577cea76e64 = sortbydistance( var_d5bdb577cea76e64, origin );
        zombie_kill_throttle = throttle::throttle_initialize( "aether_shroud_dash_kill", 3, level.framedurationseconds );
        
        foreach ( var_5ca2d7e6c048e8e3 in var_d5bdb577cea76e64 )
        {
            var_5ca2d7e6c048e8e3 function_7f8988ce63c1623d( 0 );
            throttle::throttle_wait_in_queue( zombie_kill_throttle, var_5ca2d7e6c048e8e3 );
            
            if ( isalive( var_5ca2d7e6c048e8e3 ) )
            {
                var_5ca2d7e6c048e8e3.forceannihilate = 1;
                var_5ca2d7e6c048e8e3.var_e797f68de73ece4e = "_ashroud";
                var_5ca2d7e6c048e8e3 kill( var_5ca2d7e6c048e8e3.origin, self, self, "MOD_ELEMENTAL_DARK", objweapon );
            }
        }
        
        throttle::throttle_destroy( zombie_kill_throttle );
    }
}

// Namespace aether_shroud_augments
// Params 1
// Checksum 0x2e662d38, Offset: 0x2116
// Size: 0x32c, Type: bool
function function_8094dea2161ae8af( v_destination )
{
    if ( utility::issharedfuncdefined( #"zombie", #"hash_bad01cbc996e3dba" ) )
    {
        if ( !utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", v_destination ) )
        {
            return true;
        }
    }
    
    if ( outofbounds::ispointinoutofbounds( v_destination, "allies" ) )
    {
        return true;
    }
    
    foreach ( var_9f829dd4984d562e in level.var_6f847c531576ce6b )
    {
        if ( isdefined( var_9f829dd4984d562e.v_position ) && isdefined( var_9f829dd4984d562e.n_radius ) )
        {
            if ( distancesquared( v_destination, var_9f829dd4984d562e.v_position ) <= var_9f829dd4984d562e.n_radius * var_9f829dd4984d562e.n_radius )
            {
                return true;
            }
        }
        
        if ( isstring( var_9f829dd4984d562e.str_vol_targetname ) )
        {
            var_ff314ef2e0bfea9c = getentarray( var_9f829dd4984d562e.str_vol_targetname, #targetname );
            
            foreach ( vol_banned in var_ff314ef2e0bfea9c )
            {
                if ( vol_banned istouchingpoint( v_destination ) )
                {
                    return true;
                }
            }
        }
    }
    
    level.var_1eb7c7e5ddc66725 = function_5713d46873b29625( level.var_1eb7c7e5ddc66725 );
    
    if ( level.var_1eb7c7e5ddc66725.size > 0 )
    {
        foreach ( var_97295a559c409ff5 in level.var_1eb7c7e5ddc66725 )
        {
            if ( var_97295a559c409ff5 istouchingpoint( v_destination ) )
            {
                return false;
            }
        }
        
        return true;
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_907ea089ee1bd681" ) )
    {
        if ( isdefined( level.var_9b4c25e805ef1d13 ) && level.var_9b4c25e805ef1d13.size != 0 )
        {
            foreach ( zone_name in level.var_9b4c25e805ef1d13 )
            {
                if ( utility::callsharedfunc( #"zombie", #"hash_907ea089ee1bd681", v_destination, zone_name ) )
                {
                    return false;
                }
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace aether_shroud_augments
// Params 1
// Checksum 0xb46be8ea, Offset: 0x244b
// Size: 0x383
function function_cdb581edad8e148f( sparams )
{
    damage = sparams.idamage ?? 0;
    player = sparams.eattacker;
    
    if ( isplayer( player ) && sparams.objweapon === player.var_cc1262e66dbb1c79 && player.aether_shroud_active && !self.disallow_aether_shroud_shadow_blade && player function_cc279e012ff064d8( #"aether_shroud_shadow_blade" ) )
    {
        var_3e63619e0a687f94 = level.zombie_augments[ #"aether_shroud_shadow_blade" ].var_21d463038d40326a ?? 2;
        crit_dmg_multiplier = level.zombie_augments[ #"aether_shroud_shadow_blade" ].var_70e4d0618a90013e ?? 2.5;
        normal_floor = level.zombie_augments[ #"aether_shroud_shadow_blade" ].var_9c100cf70bb30a42 ?? 0.25;
        var_e2ac4e6581a11235 = level.zombie_augments[ #"aether_shroud_shadow_blade" ].var_f75c9717c25dca3 ?? 0.34;
        var_901e13599a664cf1 = level.zombie_augments[ #"aether_shroud_shadow_blade" ].var_c65fbf07d97462e3 ?? 0.05;
        var_abda743fe3202116 = level.zombie_augments[ #"aether_shroud_shadow_blade" ].var_8960573fd0b3fad2 ?? 0.01;
        var_472e105160179c4b = level.zombie_augments[ #"aether_shroud_shadow_blade" ].var_d480b6ab3bfa482d ?? 0.005;
        current_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        base_zombie_max_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", current_round ) ?? self.maxhealth;
        var_578d71b7c00fc4ba = base_zombie_max_health * normal_floor ?? 100;
        var_6a02108301e17dc = undefined;
        
        if ( self.aicategory === "normal" )
        {
            damage = base_zombie_max_health;
        }
        else
        {
            damage = max( damage, var_578d71b7c00fc4ba );
            
            if ( sparams.biscritical )
            {
                damage *= crit_dmg_multiplier;
            }
            else
            {
                damage *= var_3e63619e0a687f94;
            }
            
            if ( self.aicategory === "special" )
            {
                var_6a02108301e17dc = self.maxhealth * var_e2ac4e6581a11235;
            }
            else if ( self.aicategory === "elite" )
            {
                var_6a02108301e17dc = self.maxhealth * var_901e13599a664cf1;
            }
            else if ( self.aicategory === "hvt" )
            {
                var_6a02108301e17dc = self.maxhealth * var_abda743fe3202116;
            }
            else if ( self.aicategory === "boss" )
            {
                var_6a02108301e17dc = self.maxhealth * var_472e105160179c4b;
            }
        }
        
        if ( damage < var_578d71b7c00fc4ba )
        {
            damage = var_578d71b7c00fc4ba;
        }
        
        if ( var_6a02108301e17dc && damage > var_6a02108301e17dc )
        {
            damage = var_6a02108301e17dc;
        }
        
        sparams.idflags |= 1073741824;
        
        if ( sparams.idamage > damage )
        {
            damage = sparams.idamage;
        }
        
        if ( self.aicategory == "normal" && self.health < damage )
        {
            self.var_e797f68de73ece4e = "_ashroud";
        }
    }
    
    return damage;
}

// Namespace aether_shroud_augments
// Params 1
// Checksum 0xedde06a2, Offset: 0x27d7
// Size: 0xca
function function_39000a8ac04a6b77( sparams )
{
    if ( isplayer( sparams.eattacker ) )
    {
        player = sparams.eattacker;
        
        if ( !isdefined( player.shadowbladekills ) )
        {
            player.shadowbladekills = 0;
        }
        
        if ( player function_cc279e012ff064d8( #"aether_shroud_shadow_blade" ) && player.aether_shroud_active && player.shadowbladekills < 20 )
        {
            player.shadowbladekills++;
            extend_amount = level.zombie_augments[ #"aether_shroud_shadow_blade" ].var_696d30b2fe2515a4 ?? 0.1;
            player supers_mp::function_9f116b8da4a01a94( extend_amount );
        }
    }
}

// Namespace aether_shroud_augments
// Params 0, eflags: 0x4
// Checksum 0x2464f169, Offset: 0x28a9
// Size: 0xef
function private function_3ef7dfb91d9bc704()
{
    attract_duration = level.zombie_augments[ #"aether_shroud_afterimage" ].var_5dd12c6d4d0a70b1 ?? 3;
    var_c81a917552049716 = level.zombie_augments[ #"aether_shroud_afterimage" ].var_9e3c204d4a033eb5 ?? 256;
    extension_bonus = level.zombie_augments[ #"aether_shroud_extension" ].var_756d4b57563470dc ?? 1;
    function_b35a83dbab9c07c6();
    self.var_11a8ef77fa83ab5c.attractor = zombie_attractor_manager::add_attractor( self.var_11a8ef77fa83ab5c, 2, var_c81a917552049716, 1, undefined, &aether_shroud_afterimage_validation, 0, undefined, 1 );
    
    if ( function_cc279e012ff064d8( #"aether_shroud_extension" ) )
    {
        attract_duration += attract_duration * extension_bonus;
    }
    
    self.var_11a8ef77fa83ab5c thread aether_shroud_afterimage_thread( attract_duration );
}

// Namespace aether_shroud_augments
// Params 1
// Checksum 0x8ada8f65, Offset: 0x29a0
// Size: 0x8f
function aether_shroud_afterimage_thread( attract_duration )
{
    level endon( #"game_ended" );
    wait attract_duration;
    
    if ( self )
    {
        fxorigin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 32 );
        
        if ( isdefined( level._effect[ "aether_shroud_afterimage_fx" ] ) )
        {
            playfx( utility::getfx( "aether_shroud_afterimage_fx" ), fxorigin );
        }
        
        self.owner thread aether_shroud_afterimage_explosion( self );
        function_3d49312028a8aacd();
    }
}

// Namespace aether_shroud_augments
// Params 0
// Checksum 0x73d0646a, Offset: 0x2a37
// Size: 0xa3
function function_3d49312028a8aacd()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    fxid = utility::getfx( "energy_mine_split" );
    fxorigin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 32 );
    playfx( fxid, fxorigin );
    player = self.owner;
    
    if ( isdefined( self.attractor ) )
    {
        zombie_attractor_manager::remove_attractor( self.attractor );
    }
    
    self delete();
    
    if ( isplayer( player ) )
    {
        player.var_11a8ef77fa83ab5c = undefined;
    }
}

// Namespace aether_shroud_augments
// Params 2
// Checksum 0x23c6e3a, Offset: 0x2ae2
// Size: 0x3a, Type: bool
function aether_shroud_afterimage_validation( attractor, zombie )
{
    if ( zombie zombie_utils::function_bf1464d09f4e4b40() )
    {
        return false;
    }
    
    if ( zombie.aicategory == "hvt" )
    {
        return false;
    }
    
    return true;
}

// Namespace aether_shroud_augments
// Params 1
// Checksum 0xa9d4bcdb, Offset: 0x2b25
// Size: 0x220
function aether_shroud_afterimage_explosion( clone )
{
    zombie_kill_throttle = throttle::throttle_initialize( "aether_shroud_afterimage_throttle", 3, level.framedurationseconds );
    radius = level.zombie_augments[ #"aether_shroud_afterimage" ].var_a22a44aace6caad2 ?? 200;
    var_2b5d1dc7ccc7c88 = level.zombie_augments[ #"aether_shroud_afterimage" ].var_eaeb69a92b7c3188 ?? 0.51;
    objweapon = makeweapon( "aether_shroud" );
    damagepos = clone.origin;
    player = clone.owner;
    zombies = getaiarrayinradius( damagepos, radius );
    
    if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
    {
        zombies = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( zombies, player );
    }
    
    if ( zombies.size > 0 )
    {
        round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( player.origin );
        zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        damage = zombie_base_health * var_2b5d1dc7ccc7c88;
        
        foreach ( zombie in zombies )
        {
            if ( zombie.aicategory == "normal" && !issubstr( zombie.subclass, "zombie_base_armored" ) )
            {
                zombie zombie_knockdown::function_6fc167d4a3590991( damagepos );
            }
            
            zombie dodamage( damage, damagepos, player, player, "MOD_ELEMENTAL_DARK", objweapon, "none", undefined, 1073807360 );
            throttle::throttle_wait_in_queue( zombie_kill_throttle, zombie );
        }
    }
}

