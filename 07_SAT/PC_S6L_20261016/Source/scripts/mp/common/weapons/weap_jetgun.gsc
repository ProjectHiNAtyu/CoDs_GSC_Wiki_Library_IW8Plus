// scripts\mp\common\weapons\weap_jetgun.gsc  (hash_209f40b97ba0bbe7.gscc) (size: 22799 Bytes / 0x590f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdd69a96f (3714689391)
// size ...... 22799 (0x590f)
// includes .. 15  (offset: 0x5443)
// strings ... 57  (offset: 0x54bb)
// dev strs .. 18  (offset: 0x5837)
// exports ... 51  (offset: 0x34eb)
// cseg ...... 0x45c + 0x308f (0x34eb)
// imports ... 187 (offset: 0x3ce3)
// animtree1 . 0   (offset: 0x590f)
// animtree2 . 0   (offset: 0x590f)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\powerups;
#using scripts\common\status_effects\effect_burn;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vortex;
#using scripts\mp\loot\common_item;

#namespace weap_jetgun;

// Namespace weap_jetgun
// Params 0
// Checksum 0x9ac21c85, Offset: 0x47a
// Size: 0x54c
function init()
{
    weapon_name = utility::get_scripted_weapon_name( #"jetgun" );
    level callback::add( #"player_weapon_change", &jetgun_on_weapon_change );
    thread function_d81f48f88df7d05d();
    level zombie_utils::function_b021918a41e1df51( weapon_name, &jetgun_on_ai_damage );
    level vortex::register_vortex_priority( "jetgun", 2 );
    level.jetgun_weapon_basename = weapon_name;
    level.var_f7d8c385fccc43b4[ weapon_name ] = &function_804a094640767141;
    jetgun_weapon = makeweapon( weapon_name );
    jetgun_clip = weaponclipsize( jetgun_weapon );
    jetgun_firetime = weaponfiretime( jetgun_weapon );
    jetgun_settings = jetgun_weapon.weaponcustomsettings;
    assert( isdefined( jetgun_settings ), "<dev string:x24>" );
    level.jetgun_draggable_ents = [];
    level.var_741ef58bc309684e = [];
    var_6be6fa8eee52a3dc = jetgun_settings.var_6159fde39ad819ea ?? 3;
    level.jetgun_draggable_throttle = throttle::throttle_initialize_gate( "jetgun_draggable", var_6be6fa8eee52a3dc, level.framedurationseconds );
    level.var_c0d043be50aec175 = throttle::throttle_initialize( "jetgun_damgeable", 8, level.framedurationseconds );
    level.var_5e237f4d32c177a5 = jetgun_settings.var_7952d7ddfc6f6429;
    level.var_bb817668ecea91f0 = jetgun_settings.var_11d21e5618ed15ef * 1000;
    level.var_4ba5a12b54e097d9 = jetgun_settings.var_8dc39d5a95e009d;
    level.var_95efe7f55f67107 = jetgun_settings.var_a450039bf5bd5b0f * 0.25;
    level.var_a19939d80b34513f = jetgun_settings.var_729c7cf630ad8de1 * 0.25;
    level.var_89819c5b23fd769f = jetgun_settings.var_a67e90b3619d5495 * 0.25;
    level.var_464322bc4a217255 = [ jetgun_settings.var_b8bea91795b76182, jetgun_settings.var_51618afb22b4f8ea, jetgun_settings.var_516189fb22b4f6b7, jetgun_settings.var_516188fb22b4f484 ];
    level.var_7906e021471809f0 = [ jetgun_settings.var_ffb4f147d44e43d, jetgun_settings.var_7d030647d498ee25, jetgun_settings.var_7d030347d498e78c, jetgun_settings.var_7d030447d498e9bf ];
    level.var_6d9bcc0d87f622f1 = jetgun_settings.var_8cd6f0d340ec9864;
    level._effect[ "jetgun_drag_zombie_fx" ] = loadfxasset( jetgun_settings.var_64b4a873333d24ca );
    level._effect[ "jetgun_grind_zombie_fx" ] = loadfxasset( jetgun_settings.var_bf8a4a22658dc46 );
    level._effect[ "jetgun_grind_zombie_screen_fx" ] = loadfxasset( jetgun_settings.var_4447074b6ed2adf2 );
    level._effect[ "jetgun_special_fire_wave_fx" ] = loadfxasset( jetgun_settings.var_b435929c09614774 );
    level.var_d0d462aa9ef5a51b = [ jetgun_settings.overheatcooldown, jetgun_settings.var_292eebfc145a07, jetgun_settings.var_292febfc145c3a, jetgun_settings.var_2930ebfc145e6d ];
    full_recover = jetgun_clip * 0.05;
    level.var_c5c65aa83a7189b4 = [ full_recover / jetgun_settings.recovertime, full_recover / jetgun_settings.var_f6f362cba7a29e2f, full_recover / jetgun_settings.var_f6f363cba7a2a062, full_recover / jetgun_settings.var_f6f364cba7a2a295 ];
    level.var_1bff0cffd060f175 = jetgun_settings.recoverthreshold * jetgun_clip;
    level.var_bcdd92da8e55610b = [ jetgun_settings.var_dc51d0d06a28badd, jetgun_settings.var_8f8914db91f41245, jetgun_settings.var_8f8911db91f40bac, jetgun_settings.var_8f8912db91f40ddf ];
    level.var_7ba2cc2c1ca84639 = istrue( jetgun_settings.var_82f57d9c899538cd );
    level.var_4a9d4cac9cf7b384 = [];
    level.var_f0cba51b4a80c1a7 = [];
    extra_ammo_mult = ( jetgun_clip - 40 ) * 0.05;
    extra_ammo_sub = 2.5;
    
    foreach ( i, charge_time in level.var_bcdd92da8e55610b )
    {
        fire_time = charge_time / ( jetgun_clip - 40 );
        
        if ( fire_time < 0.02 )
        {
            fire_time = 0.02;
            level.var_f0cba51b4a80c1a7[ i ] = min( max( extra_ammo_mult / charge_time - extra_ammo_sub, 0.01 ), 20 );
        }
        else
        {
            level.var_f0cba51b4a80c1a7[ i ] = 0;
        }
        
        level.var_4a9d4cac9cf7b384[ i ] = int( fire_time * 100 / jetgun_firetime / ( i > 0 ? 1.5 : 1 ) );
    }
    
    utility::registersharedfunc( #"jetgun", #"hash_f5c28d458e95c1fc", &function_50fafa4721732e7f );
    
    /#
        init_jetgun_devgui();
    #/
}

// Namespace weap_jetgun
// Params 0, eflags: 0x4
// Checksum 0x6bfccf0e, Offset: 0x9ce
// Size: 0x26
function private function_d81f48f88df7d05d()
{
    level endon( #"game_ended" );
    utility::flag_wait( "common_items_init" );
    common_item::function_9c9e4c71569f3ae8( &function_b190a58d96c55ce6 );
}

// Namespace weap_jetgun
// Params 1
// Checksum 0x9088268d, Offset: 0x9fc
// Size: 0x3f
function function_50fafa4721732e7f( ent )
{
    level.jetgun_draggable_ents = function_5713d46873b29625( level.jetgun_draggable_ents );
    level.jetgun_draggable_ents = arraycombineunique( level.jetgun_draggable_ents, [ ent ] );
}

// Namespace weap_jetgun
// Params 1
// Checksum 0x25e407f2, Offset: 0xa43
// Size: 0x24
function function_209abc68d5d95ee6( ent )
{
    level.jetgun_draggable_ents = arrayremove( level.jetgun_draggable_ents, ent );
}

// Namespace weap_jetgun
// Params 1
// Checksum 0xb31d054a, Offset: 0xa6f
// Size: 0x3f
function function_d997e6e75c25fc99( ent )
{
    level.var_741ef58bc309684e = function_5713d46873b29625( level.var_741ef58bc309684e );
    level.var_741ef58bc309684e = arraycombineunique( level.var_741ef58bc309684e, [ ent ] );
}

// Namespace weap_jetgun
// Params 1
// Checksum 0xd638afbe, Offset: 0xab6
// Size: 0x24
function function_7be59add033911aa( ent )
{
    level.var_741ef58bc309684e = arrayremove( level.var_741ef58bc309684e, ent );
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0x4122a4ed, Offset: 0xae2
// Size: 0xa4
function private jetgun_on_weapon_change( params )
{
    if ( !isdefined( params.weapon ) )
    {
        return;
    }
    
    if ( !self getscriptablehaspart( "JetGunVFX" ) )
    {
        self notify( #"hash_46469bdc8433db8" );
        return;
    }
    
    if ( params.weapon.basename == level.jetgun_weapon_basename )
    {
        thread function_6e13037a73f9ce43( params.weapon );
        thread function_cd067b389f84dea7( params.weapon );
        function_c5428438f42b80a9();
        return;
    }
    
    self notify( #"hash_46469bdc8433db8" );
    self setscriptablepartstate( "JetGunVFX", "off" );
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0x9c52e627, Offset: 0xb8e
// Size: 0x53
function private jetgun_on_ai_damage( params )
{
    if ( isdefined( params.metabonename ) )
    {
        return -1;
    }
    
    active_metabones = metabone::function_30d906ccb9fe2142( "Types_Damageable" );
    
    if ( active_metabones.size > 0 )
    {
        params.metabonename = utility::array_random( active_metabones );
    }
    
    return -1;
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0xb1195aed, Offset: 0xbea
// Size: 0x46
function private function_804a094640767141( dmg_struct )
{
    if ( self.aicategory == "boss" )
    {
        dmg_struct.idamage *= 0.3;
    }
    
    return dmg_struct.idamage;
}

// Namespace weap_jetgun
// Params 0, eflags: 0x4
// Checksum 0x59ddd400, Offset: 0xc39
// Size: 0x7b
function private function_c5428438f42b80a9()
{
    if ( !isdefined( level.var_4874286f69f87bc4 ) )
    {
        level.var_4874286f69f87bc4 = [];
    }
    
    owner_num = self getentitynumber();
    
    if ( isdefined( level.var_4874286f69f87bc4[ owner_num ] ) )
    {
        return;
    }
    
    level.var_4874286f69f87bc4[ owner_num ] = [];
    
    for ( i = 0; i < 5 ; i++ )
    {
        level.var_4874286f69f87bc4[ owner_num ][ i ] = utility::spawn_model( "tag_origin" );
    }
}

// Namespace weap_jetgun
// Params 0, eflags: 0x4
// Checksum 0x279bdc68, Offset: 0xcbc
// Size: 0xb9
function private function_2689aa7e6adf2e53()
{
    owner_num = self getentitynumber();
    assert( isdefined( level.var_4874286f69f87bc4[ owner_num ] ) );
    
    foreach ( ent in level.var_4874286f69f87bc4[ owner_num ] )
    {
        if ( !ent.var_4601cc6fca1385fb )
        {
            ent.var_4601cc6fca1385fb = 1;
            return ent;
        }
    }
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0xe9e84a8b, Offset: 0xd7d
// Size: 0x4a
function private function_412e7a808691d4f5( ent )
{
    if ( isdefined( self ) )
    {
        utility::scriptable_clearparententity();
        
        if ( ent islinked() )
        {
            common_item::function_725abd79805e767e();
        }
        
        self.var_6fc9a812fd8f7a06 = undefined;
    }
    
    if ( isdefined( ent ) )
    {
        ent unlink();
        ent.var_4601cc6fca1385fb = undefined;
    }
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0x4e3a4e05, Offset: 0xdcf
// Size: 0xb4
function private function_b190a58d96c55ce6( params )
{
    if ( isdefined( params.item ) )
    {
        /#
            if ( getdvarint( @"hash_823c645f0ac6c4d7", 0 ) )
            {
                return;
            }
        #/
        
        if ( isdefined( params.spawnoptions.var_f35b5b18b029c493 ) && !params.spawnoptions.var_f35b5b18b029c493 )
        {
            return;
        }
        
        item = params.item;
        item endon( #"death" );
        
        while ( true )
        {
            waitframe();
            
            if ( !isdefined( item ) )
            {
                return;
            }
            
            if ( item function_ef43fd0a946e1594() )
            {
                break;
            }
        }
        
        wait 0.5;
        function_50fafa4721732e7f( item );
    }
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0x5f410bf3, Offset: 0xe8b
// Size: 0x49
function private function_c58a373dc27debdd( weapon )
{
    self endon( #"death_or_disconnect" );
    thread jetgun_recover_ammo( weapon );
    self waittill( #"hash_46469bdc8433db8" );
    val::reset_all( "jetgun" );
    self stopforcedfire();
    thread jetgun_recover_ammo( weapon );
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0x19a051c0, Offset: 0xedc
// Size: 0x1dd
function private function_6e13037a73f9ce43( current_weapon )
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_46469bdc8433db8" );
    self endon( #"hash_46469bdc8433db8" );
    thread function_c58a373dc27debdd( current_weapon );
    pap_lvl = namespace_9d8e359c3b1041e5::function_1d4087075103b248( current_weapon );
    fire_time = level.var_bcdd92da8e55610b[ pap_lvl ] * 1000;
    cooldown = level.var_d0d462aa9ef5a51b[ pap_lvl ] * 1000;
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        self notify( #"jetgun_weapon_fired" );
        self.var_7985491c947cbdba = undefined;
        val::set( "jetgun", "disallow_loot_but_auto_loot", 1 );
        val::set( "jetgun", "fire_time_scale" );
        
        while ( self isshooting() && !self ismeleeing() )
        {
            if ( !is_using_jetgun() )
            {
                wait 0.25;
                break;
            }
            
            cur_ammo = self getweaponammoclip( current_weapon );
            
            if ( function_e0623ccc02a298d2() )
            {
                if ( !isdefined( self.var_7985491c947cbdba ) )
                {
                    self.var_7985491c947cbdba = gettime() + fire_time;
                }
            }
            else
            {
                self.var_7985491c947cbdba = undefined;
            }
            
            function_fc70118fe9e9cc4d( current_weapon );
            
            if ( cur_ammo && function_25cc0191478a2b80() )
            {
                function_fd6d697d51f04848( current_weapon );
                self.var_e3e3bd632b4e66d0 = gettime() + cooldown;
            }
            else
            {
                function_85e7557ae7c62f18( current_weapon );
            }
            
            wait 0.25;
            
            if ( cur_ammo == 0 )
            {
                self.var_e3e3bd632b4e66d0 = gettime() + cooldown;
                break;
            }
        }
        
        val::reset( "jetgun", "disallow_loot_but_auto_loot" );
        val::reset( "jetgun", "fire_time_scale" );
        self.var_7985491c947cbdba = undefined;
        function_fc70118fe9e9cc4d( current_weapon );
        thread jetgun_recover_ammo( current_weapon );
        function_5d4afec35df95b50();
    }
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0xb44fb89c, Offset: 0x10c1
// Size: 0xa4
function private function_cd067b389f84dea7( weapon )
{
    self endon( #"hash_46469bdc8433db8" );
    self endon( #"death" );
    self notify( #"hash_7c42c0edb534f42a" );
    self endon( #"hash_7c42c0edb534f42a" );
    
    while ( true )
    {
        current_ammo = self getweaponammoclip( weapon );
        self setscriptablepartstate( "JetGunVFX", current_ammo <= 0 ? "overheat" : "idle" );
        self waittill( #"weapon_switch_started" );
        self setscriptablepartstate( "JetGunVFX", "off" );
        utility::waittill_any( "weapon_switch_canceled", "offhand_end" );
    }
}

// Namespace weap_jetgun
// Params 2, eflags: 0x4
// Checksum 0xff74fafa, Offset: 0x116d
// Size: 0x93
function private function_6b87874de418f9a2( weapon, extra_ammo_used )
{
    ammo_used = 0;
    
    while ( isdefined( self.var_7985491c947cbdba ) )
    {
        cur_ammo = self getweaponammoclip( weapon );
        
        if ( cur_ammo < 40 )
        {
            return;
        }
        
        ammo_used += extra_ammo_used;
        
        if ( ammo_used >= 1 )
        {
            new_ammo = cur_ammo - int( ammo_used );
            ammo_used -= int( ammo_used );
            self setweaponammoclip( weapon, new_ammo > 0 ? new_ammo : 0 );
        }
        
        wait 0.05;
    }
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0xbc4e256, Offset: 0x1208
// Size: 0x168
function private function_fc70118fe9e9cc4d( weapon )
{
    current_ammo = self getweaponammoclip( weapon );
    threshold_ammo = 40;
    curr_state = self getscriptablepartstate( "JetGunVFX" );
    
    if ( self isshooting() && !self ismeleeing() && current_ammo )
    {
        switch ( curr_state )
        {
            case #"hash_1c39674e5b0de0f3":
                self setscriptablepartstate( "JetGunVFX", "firing" );
                break;
            case #"hash_af07eacf0367c12a":
                if ( current_ammo < threshold_ammo )
                {
                    self setscriptablepartstate( "JetGunVFX", "firing_end" );
                }
                
                break;
            case #"hash_a2f0a165dfb8eedf":
                if ( level.var_7ba2cc2c1ca84639 )
                {
                    self setscriptablepartstate( "JetGunVFX", "firing" );
                }
                
                break;
            default:
                break;
        }
        
        return;
    }
    
    switch ( curr_state )
    {
        case #"hash_81f645ddee02c3c":
        case #"hash_a2f0a165dfb8eedf":
        case #"hash_af07eacf0367c12a":
            self setscriptablepartstate( "JetGunVFX", current_ammo <= 0 ? "overheat" : "idle" );
            break;
        case #"hash_d948471b76b18f65":
            if ( current_ammo > 0 )
            {
                self setscriptablepartstate( "JetGunVFX", "idle" );
            }
            
            break;
        default:
            break;
    }
}

// Namespace weap_jetgun
// Params 0, eflags: 0x4
// Checksum 0x9fc31f29, Offset: 0x1378
// Size: 0x7
function private function_e0623ccc02a298d2()
{
    return self adsbuttonpressed();
}

// Namespace weap_jetgun
// Params 0, eflags: 0x4
// Checksum 0x8ed56ddb, Offset: 0x1388
// Size: 0x3d, Type: bool
function private function_25cc0191478a2b80()
{
    is_overheat_cooldown = gettime() < self.var_e3e3bd632b4e66d0;
    charge_completed = gettime() > self.var_7985491c947cbdba;
    return !is_overheat_cooldown && charge_completed;
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0x363b7019, Offset: 0x13ce
// Size: 0x38
function private function_fd6d697d51f04848( weapon )
{
    self setweaponammoclip( weapon, 1 );
    self startforcedfire();
    self waittill( #"weapon_fired" );
    self stopforcedfire();
    childthread jetgun_blast_wave_enemies_in_range( weapon );
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0x548089f7, Offset: 0x140e
// Size: 0x371
function private jetgun_blast_wave_enemies_in_range( weapon )
{
    self setscriptablepartstate( "JetGunVFX", "special_fired" );
    pap_lvl = namespace_9d8e359c3b1041e5::function_1d4087075103b248( weapon );
    n_damage = level.var_7906e021471809f0[ pap_lvl ];
    n_damage_normal = n_damage * 1.35;
    damage_radius = level.var_464322bc4a217255[ pap_lvl ];
    wave_force = max( n_damage * 2, 6000 );
    wave_radius = damage_radius * 2;
    ignore_team = self.team;
    damage_origin = self.origin;
    damage_radius_sq = squared( damage_radius );
    radiusdamage( self.origin, wave_radius, n_damage, n_damage, self, undefined, weapon, 1 );
    potential_enemies = physics_querypoint( self.origin, wave_radius, physics_createcontents( [ "physicscontents_characterproxy" ] ), [ self ], "physicsquery_all" );
    
    if ( !isdefined( potential_enemies ) || potential_enemies.size == 0 )
    {
        return;
    }
    
    foreach ( potential_target in potential_enemies )
    {
        zombie = potential_target[ "entity" ];
        
        if ( !isalive( zombie ) || zombie.team == ignore_team || !isagent( zombie ) )
        {
            continue;
        }
        
        throttle::throttle_wait_in_queue( level.var_c0d043be50aec175, zombie );
        
        if ( !isalive( zombie ) )
        {
            continue;
        }
        
        if ( zombie damageconetrace( damage_origin, self ) <= 0 )
        {
            continue;
        }
        
        attacker = self ?? undefined;
        check_dist_sq = distancesquared( damage_origin, zombie.origin );
        n_final_damage = zombie.aicategory == "normal" ? check_dist_sq < 4096 ? max( n_damage_normal, zombie.health ) : n_damage_normal : n_damage;
        
        if ( damage_radius_sq > check_dist_sq || zombie.var_1bc1a37495c8ca04 )
        {
            if ( n_final_damage >= zombie.health )
            {
                zombie.ragdollimpactvector = ( vectornormalize( zombie.origin - damage_origin ) + ( 0, 0, 0.4 ) ) * wave_force;
                zombie.ragdollhitloc = "torso_lower";
                zombie.do_immediate_ragdoll = 1;
            }
            
            zombie effect_burn::burn( 2, level.var_6d9bcc0d87f622f1, 0.5, attacker, "jetgun_blast_wave", undefined, undefined, "fire", 0, weapon );
            zombie dodamage( n_final_damage, damage_origin, attacker, attacker, "MOD_ELEMENTAL_FIRE", weapon, "none", undefined, 65536 );
            
            if ( !isalive( zombie ) )
            {
                continue;
            }
        }
        
        if ( zombie.aicategory == "normal" )
        {
            zombie zombie_knockdown::function_a113e6ee43535d37( damage_origin, n_damage );
            continue;
        }
        
        zombie zombie_stun::stun_ai( zombie.aicategory == "special" ? 5 : 1 );
    }
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0x5dd70a2c, Offset: 0x1787
// Size: 0x2a
function private function_85e7557ae7c62f18( current_weapon )
{
    function_e6d78f093779c76();
    function_cae79384903aeeee();
    function_5bd6e9475f8c50c0();
    function_1d349abfa6c7ea8d( current_weapon );
}

// Namespace weap_jetgun
// Params 0, eflags: 0x4
// Checksum 0xf1ba52b8, Offset: 0x17b9
// Size: 0x1c5
function private function_e6d78f093779c76()
{
    view_forward = anglestoforward( self getplayerangles() );
    view_pos = self getvieworigin() + view_forward * 10 - ( 0, 0, 10 );
    level.var_741ef58bc309684e = function_5713d46873b29625( level.var_741ef58bc309684e );
    var_98301f65348c89ee = arraycombine( level.var_741ef58bc309684e, level.a_loot_crystals );
    
    foreach ( damaged_ent in var_98301f65348c89ee )
    {
        if ( distancesquared( view_pos, damaged_ent.origin ) > squared( 512 ) )
        {
            continue;
        }
        
        normal = vectornormalize( damaged_ent.origin - view_pos );
        dot = vectordot( view_forward, normal );
        
        if ( dot < 0.7 )
        {
            continue;
        }
        
        v_trace_offset = damaged_ent.var_18fac94bd702d196 ?? ( 0, 0, 2 );
        
        if ( self damageconetrace( damaged_ent.origin + v_trace_offset ) <= 0 )
        {
            continue;
        }
        
        if ( isent( damaged_ent ) )
        {
            damaged_ent dodamage( 10, self.origin, self, self );
            continue;
        }
        
        if ( damaged_ent isscriptableinstance() )
        {
            if ( damaged_ent getscriptableparthasstate( "aetherella_statuette", "static" ) )
            {
                damaged_ent thread drag_aetherella_statuette( self );
                continue;
            }
            
            damaged_ent scriptabledodamage( 10, self, self );
        }
    }
}

// Namespace weap_jetgun
// Params 1, eflags: 0xc
// Checksum 0xcc20455c, Offset: 0x1986
// Size: 0x1b0
function private drag_aetherella_statuette( player )
{
    self notify( #"hash_984bfad12c4f1488" );
    self endon( #"hash_984bfad12c4f1488" );
    player endon( #"death" );
    self notify( #"statuette_moving" );
    
    if ( !isdefined( self.mover ) )
    {
        self.mover = utility::spawn_model( "tag_origin", self.origin, self.angles );
        self scriptablesetparententity( self.mover );
        playfxontag( utility::getfx( "ee_statuette_move_fx" ), self.mover, "tag_origin" );
    }
    
    thread spin_aetherella_statuette();
    v_target = player gettagorigin( "j_wrist_le" ) + ( 0, 0, 6 );
    v_direction = vectornormalize( v_target - self.origin );
    v_end = self.origin + v_direction * 24;
    self.mover moveto( v_end, 0.25 );
    self.mover waittill( #"movedone" );
    
    if ( distancesquared( v_target, self.origin + ( 0, 0, 3 ) ) <= squared( 28 ) )
    {
        if ( isdefined( self.mover ) )
        {
            self.mover delete();
        }
        
        level.var_d3e8bf179e337e43.last_player = player;
        playsoundatpos( player.origin, "evt_aetherella_ee_vacuumed" );
        self notify( #"vacuumed" );
        self freescriptable();
        return;
    }
    
    thread bob_aetherella_statuette();
}

// Namespace weap_jetgun
// Params 0, eflags: 0xc
// Checksum 0x9f8b523a, Offset: 0x1b3e
// Size: 0x85
function private spin_aetherella_statuette()
{
    self notify( #"hash_6ca974eb242f28cf" );
    self endon( #"hash_6ca974eb242f28cf" );
    self.mover endon( #"death" );
    v_rotate = ( randomintrange( 10, 20 ), randomintrange( 10, 20 ), randomintrange( 10, 20 ) );
    
    while ( true )
    {
        self.mover rotatevelocity( v_rotate, 99999 );
        self.mover waittill( #"rotatedone" );
    }
}

// Namespace weap_jetgun
// Params 0, eflags: 0xc
// Checksum 0xad201d83, Offset: 0x1bcb
// Size: 0x10c
function private bob_aetherella_statuette()
{
    self notify( #"hash_6a4443137c48165e" );
    self endon( #"hash_6a4443137c48165e" );
    self endon( #"statuette_moving" );
    self.mover endon( #"death" );
    v_start = self.mover.origin;
    v_move = ( 0, 0, 1 );
    n_move_time = 1;
    self.mover moveto( v_start - v_move, n_move_time / 2 );
    self.mover waittill( #"movedone" );
    
    while ( true )
    {
        self.mover moveto( v_start + v_move, n_move_time );
        self.mover waittill( #"movedone" );
        wait 0.1;
        self.mover moveto( v_start - v_move, n_move_time );
        self.mover waittill( #"movedone" );
        wait 0.1;
    }
}

// Namespace weap_jetgun
// Params 0, eflags: 0x4
// Checksum 0x98cd86c6, Offset: 0x1cdf
// Size: 0x346
function private function_cae79384903aeeee()
{
    move_dist = function_e0623ccc02a298d2() ? 60 : 50;
    view_forward = anglestoforward( self getplayerangles() );
    view_pos = self getvieworigin() + view_forward * 10 - ( 0, 0, 10 );
    var_5fbbd3aa41b38b34 = arraycombine( level.jetgun_draggable_ents, powerups::get_powerups_root().active_powerups );
    var_5fbbd3aa41b38b34 = function_5713d46873b29625( var_5fbbd3aa41b38b34 );
    var_37cac6613cddb7d9 = 0;
    var_db6b40e5445c785a = 0.8425;
    
    foreach ( dragged_ent in var_5fbbd3aa41b38b34 )
    {
        if ( !isdefined( dragged_ent ) || distancesquared( view_pos, dragged_ent.origin ) > squared( 512 ) )
        {
            continue;
        }
        
        normal = vectornormalize( dragged_ent.origin - view_pos );
        dist = distance( dragged_ent.origin, view_pos );
        dot = vectordot( view_forward, normal );
        
        if ( dot < var_db6b40e5445c785a )
        {
            continue;
        }
        
        if ( isent( dragged_ent ) || isstruct( dragged_ent ) )
        {
            throttle::throttle_wait_gate( level.jetgun_draggable_throttle );
        }
        
        if ( !isdefined( dragged_ent ) )
        {
            continue;
        }
        
        if ( !dragged_ent.var_dfb318e5eea4ecf1 )
        {
            if ( self damageconetrace( dragged_ent.origin ) <= 0 )
            {
                continue;
            }
        }
        
        dragged_ent notify( #"dragged_by_jetgun", self );
        
        if ( dragged_ent.disable_dragged )
        {
            continue;
        }
        
        if ( !dragged_ent val::get( "allow_secondary_attack_damage" ) )
        {
            continue;
        }
        
        v_dest = dragged_ent.origin - normal * move_dist;
        
        if ( dist < move_dist )
        {
            v_dest = view_pos;
        }
        
        if ( isent( dragged_ent ) )
        {
            dragged_ent unlink();
            dragged_ent moveto( v_dest, 0.25 );
        }
        else if ( dragged_ent isscriptableinstance() )
        {
            if ( var_37cac6613cddb7d9 >= 5 )
            {
                continue;
            }
            
            if ( !isdefined( dragged_ent.var_6fc9a812fd8f7a06 ) )
            {
                draggable_ent = function_2689aa7e6adf2e53();
                
                if ( !isdefined( draggable_ent ) )
                {
                    continue;
                }
                
                draggable_ent.origin = dragged_ent.origin;
                draggable_ent.angles = dragged_ent.angles;
                dragged_ent.var_6fc9a812fd8f7a06 = draggable_ent;
                dragged_ent thread utility::thread_on_notify_no_endon_death( "death", &function_412e7a808691d4f5, dragged_ent, draggable_ent );
                dragged_ent utility::scriptable_clearparententity();
                dragged_ent utility::scriptable_setparententity( draggable_ent );
            }
            
            var_37cac6613cddb7d9++;
            dragged_ent.var_6fc9a812fd8f7a06 unlink();
            dragged_ent.var_6fc9a812fd8f7a06 moveto( v_dest, 0.25 );
        }
        
        if ( isdefined( dragged_ent.mesh_mdl ) )
        {
            dragged_ent.mesh_mdl moveto( v_dest, 0.25 );
        }
        
        dragged_ent thread function_e876816c7fe6ba4b( self );
    }
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0x938f7a79, Offset: 0x202d
// Size: 0x15f
function private function_e876816c7fe6ba4b( player )
{
    self endon( #"death" );
    self endon( #"dragged_by_jetgun", #"hash_2707519ad1e4d234" );
    
    if ( !isdefined( self.ground_offset ) )
    {
        self.ground_offset = self.origin - utility::drop_to_ground( self.origin, 10 );
    }
    
    wait 0.25;
    ground_pos = utility::drop_to_ground( self.origin, 10 ) + self.ground_offset;
    time = distance( ground_pos, self.origin ) / 100;
    time = clamp( time, 0.05, 10 );
    
    if ( isdefined( self.item ) )
    {
        self.item common_item::function_725abd79805e767e();
    }
    
    if ( isent( self ) )
    {
        self moveto( ground_pos, time );
    }
    else if ( self isscriptableinstance() )
    {
        utility::delaythreadendon( time * 0.5, "dragged_by_jetgun", &common_item::function_725abd79805e767e );
    }
    
    if ( isdefined( self.var_6fc9a812fd8f7a06 ) )
    {
        self.var_6fc9a812fd8f7a06 moveto( ground_pos, time );
        utility::delaythreadendon( time, "dragged_by_jetgun", &function_412e7a808691d4f5, self.var_6fc9a812fd8f7a06 );
    }
    
    if ( isdefined( self.mesh_mdl ) )
    {
        self.mesh_mdl moveto( ground_pos, time );
    }
}

// Namespace weap_jetgun
// Params 0, eflags: 0x4
// Checksum 0x2d238e5d, Offset: 0x2194
// Size: 0x1da
function private function_5bd6e9475f8c50c0()
{
    view_pos = self getvieworigin();
    view_forward = anglestoforward( self getplayerangles() );
    cylinder_radius = 256;
    grind_range = level.var_4ba5a12b54e097d9;
    drag_range = level.var_5e237f4d32c177a5;
    
    /#
        cylinder_radius = getdvarfloat( @"scr_jetgun_cylinder_radius", cylinder_radius );
        grind_range = getdvarfloat( @"scr_jetgun_grind_range", grind_range );
        drag_range = getdvarfloat( @"scr_jetgun_drag_range", drag_range );
    #/
    
    end_pos = view_pos + view_forward * drag_range;
    
    /#
        if ( 2 == getdvarint( @"scr_jetgun_debug" ) )
        {
            near_circle_pos = view_pos + view_forward * 2;
            sphere( near_circle_pos, cylinder_radius, ( 1, 1, 0 ), 1, 100 );
            line( near_circle_pos, end_pos, ( 0, 0, 1 ), 1, 1, 100 );
            sphere( end_pos, cylinder_radius, ( 1, 0, 0 ), 1, 100 );
        }
    #/
    
    potential_enemies = physics_querypoint( view_pos, drag_range, physics_createcontents( [ "physicscontents_characterproxy" ] ), [ self ], "physicsquery_all" );
    
    if ( !isdefined( potential_enemies ) || potential_enemies.size == 0 )
    {
        return;
    }
    
    foreach ( potential_target in potential_enemies )
    {
        function_5721ab45e6ba1f5b( potential_target[ "entity" ], view_pos, squared( drag_range ), squared( grind_range ), squared( cylinder_radius ), view_forward, end_pos );
    }
}

// Namespace weap_jetgun
// Params 7, eflags: 0x4
// Checksum 0x5b91b382, Offset: 0x2376
// Size: 0x313
function private function_5721ab45e6ba1f5b( zombie, view_pos, drag_range_sq, grind_range_sq, cylinder_radius_sq, view_forward, end_pos )
{
    if ( !isalive( zombie ) || zombie.team == self.team || isplayer( zombie ) )
    {
        return;
    }
    
    if ( zombie.jetgun_fling || zombie.jetgun_grind )
    {
        return;
    }
    
    test_origin = zombie getcentroid();
    test_range_sq = distancesquared( view_pos, test_origin );
    
    if ( test_range_sq > drag_range_sq )
    {
        /#
            zombie jetgun_debug_print( "<dev string:x51>", ( 1, 0, 0 ) );
        #/
        
        return;
    }
    
    normal = vectornormalize( test_origin - view_pos );
    dot = vectordot( view_forward, normal );
    
    if ( abs( dot ) < 0.7 )
    {
        /#
            zombie jetgun_debug_print( "<dev string:x57>", ( 1, 0, 0 ) );
        #/
        
        return;
    }
    
    radial_origin = pointonsegmentnearesttopoint( view_pos, end_pos, test_origin );
    
    if ( distancesquared( test_origin, radial_origin ) > cylinder_radius_sq )
    {
        /#
            zombie jetgun_debug_print( "<dev string:x5b>", ( 1, 0, 0 ) );
        #/
        
        return;
    }
    
    if ( zombie damageconetrace( view_pos, self ) <= 0 )
    {
        /#
            zombie jetgun_debug_print( "<dev string:x64>", ( 1, 0, 0 ) );
        #/
        
        return;
    }
    
    if ( test_range_sq < grind_range_sq )
    {
        if ( zombie.aicategory == "normal" )
        {
            if ( !function_e0623ccc02a298d2() )
            {
                childthread jetgun_grind_zombie( zombie, dot > 0 );
            }
        }
        else
        {
            jetgun_stun_zombie( zombie );
            jetgun_drag_stun_zombie( zombie );
            damage_ratio = zombie.aicategory == "special" ? level.var_a19939d80b34513f : level.var_89819c5b23fd769f;
            childthread function_5f998081f7a7aab3( zombie, damage_ratio );
        }
        
        return;
    }
    
    if ( test_range_sq < drag_range_sq && dot > 0 )
    {
        dot_dist = 0.7 + 0.285 * test_range_sq / drag_range_sq;
        
        if ( dot < dot_dist )
        {
            /#
                zombie jetgun_debug_print( "<dev string:x69>", ( 1, 0, 0 ) );
            #/
            
            return;
        }
        
        if ( zombie.aicategory == "normal" )
        {
            if ( !function_e0623ccc02a298d2() )
            {
                function_55679d067f8b3283( zombie, normal * -1 );
            }
            
            return;
        }
        
        if ( test_range_sq < drag_range_sq / 4 )
        {
            jetgun_stun_zombie( zombie );
            jetgun_drag_stun_zombie( zombie );
            damage_ratio = zombie.aicategory == "special" ? level.var_a19939d80b34513f : level.var_89819c5b23fd769f;
            damage_dist_max = sqrt( drag_range_sq ) / 2;
            damage_ratio = damage_ratio * ( damage_dist_max - sqrt( test_range_sq ) ) / ( damage_dist_max - sqrt( grind_range_sq ) );
            childthread function_5f998081f7a7aab3( zombie, damage_ratio );
        }
    }
}

// Namespace weap_jetgun
// Params 2, eflags: 0x4
// Checksum 0x98844437, Offset: 0x2691
// Size: 0x78
function private function_5f998081f7a7aab3( zombie, damage_ratio )
{
    zombie endon( #"death" );
    throttle::throttle_wait_in_queue( level.var_c0d043be50aec175, zombie );
    zombie function_4e50cee914f25db2( self, 100 );
    zombie dodamage( int( zombie.maxhealth * damage_ratio ) + 1, self.origin, self, self, "MOD_CRUSH", undefined, "none", undefined, 65536 );
}

// Namespace weap_jetgun
// Params 2, eflags: 0x4
// Checksum 0x2f267782, Offset: 0x2711
// Size: 0xcd
function private jetgun_grind_zombie( zombie, b_pulled )
{
    zombie endon( #"death" );
    throttle::throttle_wait_in_queue( level.var_c0d043be50aec175, zombie );
    
    if ( !zombie.jetgun_grind && !zombie.magic_bullet_shield && !zombie.damageshield && !zombie val::get( "non_deletable" ) )
    {
        zombie.jetgun_grind = 1;
        zombie notify( #"grinding" );
        zombie callback::add( "killed_body_cloned", &function_1a97b140cf55bbf1 );
        zombie function_786bb6aa1b76c7ee( "death_pulled", b_pulled );
        zombie kill( self.origin, self, self, "MOD_CRUSH", self getcurrentweapon() );
    }
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0x3e3c8c16, Offset: 0x27e6
// Size: 0x115
function private function_1a97b140cf55bbf1( params )
{
    corpse = params.body;
    attacker = params.eattacker;
    time = 0.2;
    
    if ( isdefined( attacker ) )
    {
        time = time * distance( attacker.origin, corpse.origin ) / level.var_4ba5a12b54e097d9;
    }
    
    wait time;
    
    if ( !isdefined( corpse ) )
    {
        return;
    }
    
    effect_pos = corpse gettagorigin( "j_spine4" );
    effect_angles = corpse gettagangles( "j_spine4" );
    
    if ( isdefined( effect_pos ) && isdefined( effect_angles ) )
    {
        playfx( utility::getfx( "jetgun_grind_zombie_fx" ), effect_pos, anglestoforward( effect_angles ), anglestoup( effect_angles ) );
        utility::play_sound_in_space( "exp_jetgun_grind_flesh", corpse.origin );
    }
    
    if ( isplayer( attacker ) )
    {
        playfxontagforclients( utility::getfx( "jetgun_grind_zombie_screen_fx" ), attacker, "j_head", attacker );
    }
    
    corpse delete();
}

// Namespace weap_jetgun
// Params 2, eflags: 0x4
// Checksum 0x15929fd, Offset: 0x2903
// Size: 0x191
function private function_55679d067f8b3283( zombie, vdir )
{
    player_number = self getentitynumber();
    vortex_origin = self.last_valid_position ?? self.origin;
    view_forward = anglestoforward( self getplayerangles() );
    vortex_center = self getvieworigin() + view_forward * 10 - ( 0, 0, 10 );
    vortex_height = max( vortex_center[ 2 ] - vortex_origin[ 2 ] - 15, 0 );
    vortex_payload = { #mode:"jetgun", #height:vortex_height };
    zombie vortex::set_vortex_state( "jetgun", player_number, vortex_origin, level.var_4ba5a12b54e097d9, vortex_payload );
    
    if ( !isdefined( zombie.var_8c5a16fd69eab0ed ) )
    {
        if ( level.var_bb817668ecea91f0 >= 0 )
        {
            zombie.var_8c5a16fd69eab0ed = gettime() + level.var_bb817668ecea91f0;
        }
    }
    else if ( gettime() > zombie.var_8c5a16fd69eab0ed )
    {
        jetgun_grind_zombie( zombie, 1 );
        return;
    }
    
    zombie function_4e50cee914f25db2( self );
    
    if ( level.var_95efe7f55f67107 > 0 )
    {
        zombie dodamage( int( zombie.maxhealth * level.var_95efe7f55f67107 ) + 1, self.origin, self, self, "MOD_CRUSH", undefined, "none", undefined, 65536 );
    }
    
    zombie thread delay_stop_dragged_state( player_number );
}

// Namespace weap_jetgun
// Params 2, eflags: 0x4
// Checksum 0x349e9c6b, Offset: 0x2a9c
// Size: 0x17f
function private function_4e50cee914f25db2( player, cooldown_ms )
{
    if ( gettime() < self.var_d0992af62fe903f )
    {
        return;
    }
    
    self.var_d0992af62fe903f = gettime() + ( cooldown_ms ?? 500 );
    view_forward = anglestoforward( player getplayerangles() );
    vortex_center = player getvieworigin() + view_forward * 10 - ( 0, 0, 10 );
    possible_tags = arrayrandomize( [ "j_head", "j_spine4", "j_knee_le", "j_knee_ri", "j_elbow_le", "j_elbow_ri" ] );
    piece_origin = self.origin + ( 0, 0, 50 );
    
    foreach ( tag in possible_tags )
    {
        if ( self tagexists( tag ) )
        {
            piece_origin = self gettagorigin( tag );
            break;
        }
    }
    
    piece_forward = vectornormalize( vortex_center - piece_origin );
    playfx( utility::getfx( "jetgun_drag_zombie_fx" ), piece_origin, piece_forward );
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0xacf37cc, Offset: 0x2c23
// Size: 0x5a
function private function_ab3ac61851c73374( goal )
{
    while ( true )
    {
        var_e2c0b4e91f0ca8cb = self.var_5e0be30a5816a64d;
        
        if ( navisstraightlinereachable( var_e2c0b4e91f0ca8cb, goal, self ) )
        {
            break;
        }
        
        if ( distancesquared( var_e2c0b4e91f0ca8cb, goal ) < 1600 )
        {
            goal = var_e2c0b4e91f0ca8cb;
            break;
        }
        
        goal = ( var_e2c0b4e91f0ca8cb + goal ) * 0.5;
    }
    
    return goal;
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0x890efcf2, Offset: 0x2c86
// Size: 0x60
function private delay_stop_dragged_state( player_number )
{
    self endon( #"death" );
    self notify( "delay_stop_dragged_state_singleton" + player_number );
    self endon( "delay_stop_dragged_state_singleton" + player_number );
    wait 0.5;
    vortex::clear_vortex_state( "jetgun", player_number, !self._blackboard.var_6391b373c0f57a6d );
    self.var_8c5a16fd69eab0ed = undefined;
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0xc1104487, Offset: 0x2cee
// Size: 0x3f
function private jetgun_stun_zombie( zombie )
{
    if ( zombie.jetgun_stun_time > gettime() )
    {
        return;
    }
    
    zombie zombie_stun::stun_ai( 1 );
    zombie.jetgun_stun_time = gettime() + 500;
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0xf1bb64e7, Offset: 0x2d35
// Size: 0x28e
function private jetgun_drag_stun_zombie( zombie )
{
    if ( !zombie zombie_stun::is_stunned() )
    {
        return;
    }
    
    drag_dist = function_e0623ccc02a298d2() ? 50 : 40;
    var_7ed9052b9ad8ad2a = vectornormalize( self.origin - zombie.origin );
    var_d3f6172e792cfe0c = var_7ed9052b9ad8ad2a * drag_dist + zombie.origin;
    var_dc2b557d61cf0ffa = getclosestpointonnavmesh( var_d3f6172e792cfe0c );
    var_a1486add328f0bc9 = vectornormalize( var_dc2b557d61cf0ffa - zombie.origin );
    
    /#
        if ( getdvarint( @"scr_jetgun_debug" ) )
        {
            line( zombie.origin, var_d3f6172e792cfe0c, ( 0, 1, 0 ), 1, 1, 40 );
            line( zombie.origin, var_dc2b557d61cf0ffa, ( 0, 0, 1 ), 1, 1, 40 );
        }
    #/
    
    if ( vectordot( var_a1486add328f0bc9, var_7ed9052b9ad8ad2a ) < 0.8 )
    {
        /#
            zombie jetgun_debug_print( "<dev string:x72>", ( 1, 0, 0 ) );
        #/
        
        return;
    }
    
    if ( distance( var_dc2b557d61cf0ffa, zombie.origin ) > drag_dist * 1.5 )
    {
        /#
            zombie jetgun_debug_print( "<dev string:x7b>", ( 1, 0, 0 ) );
        #/
        
        return;
    }
    
    if ( !zombie trace::ai_trace_passed( zombie.origin + ( 0, 0, 5 ), var_dc2b557d61cf0ffa, zombie.angles, zombie ) )
    {
        /#
            zombie jetgun_debug_print( "<dev string:x89>", ( 1, 0, 0 ) );
        #/
        
        return;
    }
    
    if ( !isdefined( zombie.var_6fc9a812fd8f7a06 ) )
    {
        var_6fc9a812fd8f7a06 = spawn( "script_origin", zombie.origin );
        var_6fc9a812fd8f7a06.targetname = "jetgun_drag_stun_zombie";
        zombie.var_6fc9a812fd8f7a06 = var_6fc9a812fd8f7a06;
        zombie thread utility::delete_on_death( var_6fc9a812fd8f7a06 );
    }
    
    if ( !zombie islinked() )
    {
        zombie.var_6fc9a812fd8f7a06.origin = zombie.origin;
        zombie.var_6fc9a812fd8f7a06.angles = zombie.angles;
        zombie linkto( zombie.var_6fc9a812fd8f7a06 );
    }
    
    zombie.var_6fc9a812fd8f7a06 moveto( var_dc2b557d61cf0ffa, 0.25 );
    zombie thread delay_stop_stun_dragged_state();
}

// Namespace weap_jetgun
// Params 0, eflags: 0x4
// Checksum 0xd00fcfb, Offset: 0x2fcb
// Size: 0x32
function private delay_stop_stun_dragged_state()
{
    self endon( #"death" );
    self notify( #"delay_stop_stun_dragged_state" );
    self endon( #"delay_stop_stun_dragged_state" );
    wait 0.5;
    self unlink();
}

// Namespace weap_jetgun
// Params 1, eflags: 0xc
// Checksum 0x3f2f5a26, Offset: 0x3005
// Size: 0x27f
function private jetgun_recover_ammo( weapon )
{
    self notify( #"hash_4562e7eeb0094c08" );
    self endon( #"hash_4562e7eeb0094c08" );
    self endon( #"death_or_disconnect" );
    self endon( #"jetgun_weapon_fired" );
    clip_size = weaponclipsize( weapon );
    pap_lvl = namespace_9d8e359c3b1041e5::function_1d4087075103b248( weapon );
    recover_ammo = level.var_c5c65aa83a7189b4[ pap_lvl ];
    ammo_add = 0;
    var_78b505da88d06ecd = 0;
    
    while ( true )
    {
        wait 0.05;
        
        if ( !level.var_89b36f1bf8d5018 && !var_78b505da88d06ecd && ( self attackbuttonpressed() || self adsbuttonpressed() || self isshooting() ) )
        {
            continue;
        }
        
        current_ammo = self getweaponammoclip( weapon );
        function_1d349abfa6c7ea8d( weapon );
        
        if ( current_ammo >= clip_size )
        {
            function_fc70118fe9e9cc4d( weapon );
            break;
        }
        
        if ( var_78b505da88d06ecd && current_ammo >= level.var_1bff0cffd060f175 )
        {
            val::reset_all( "jetgun" );
            var_78b505da88d06ecd = 0;
        }
        
        if ( !self hasweapon( weapon ) )
        {
            break;
        }
        
        if ( current_ammo == 0 && isdefined( self.var_e3e3bd632b4e66d0 ) && gettime() < self.var_e3e3bd632b4e66d0 )
        {
            cooldown_s = utility::function_6f5d2e1f1ff70482( self.var_e3e3bd632b4e66d0 - gettime() );
            
            /#
                if ( level.var_220ff268d0a97488 )
                {
                    cooldown_s = 0;
                }
            #/
            
            if ( self getcurrentweapon().basename == weapon.basename )
            {
                childthread function_423069835edc658e( cooldown_s );
            }
            
            msg = utility::waittill_any_timeout( cooldown_s, "zmb_max_ammo" );
            
            if ( msg != "timeout" )
            {
                continue;
            }
            
            if ( self getcurrentweapon().basename == weapon.basename )
            {
                var_78b505da88d06ecd = 1;
                val::set( "jetgun", "fire", 0 );
                self setscriptablepartstate( "JetGunVFX", "idle" );
            }
            
            wait 0.5;
            
            if ( !self hasweapon( weapon ) )
            {
                break;
            }
        }
        
        if ( current_ammo == 0 )
        {
            recover_ammo = 5;
        }
        
        ammo_add += recover_ammo;
        
        if ( ammo_add < 1 )
        {
            continue;
        }
        
        new_ammo = current_ammo + int( ammo_add );
        ammo_add -= int( ammo_add );
        self setweaponammoclip( weapon, new_ammo > clip_size ? clip_size : new_ammo );
        function_fc70118fe9e9cc4d( weapon );
    }
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0xaf2bdf12, Offset: 0x328c
// Size: 0x52
function private function_1d349abfa6c7ea8d( weapon )
{
    clip_size = weaponclipsize( weapon );
    current_clip_value = self getweaponammoclip( weapon );
    value = abs( clip_size - current_clip_value );
    self function_70576dbab4f88e19( #"hash_a657d11a4c601c7e", value );
}

// Namespace weap_jetgun
// Params 0, eflags: 0x4
// Checksum 0xe79a1ea4, Offset: 0x32e6
// Size: 0x2
function private function_5d4afec35df95b50()
{
    
}

// Namespace weap_jetgun
// Params 1, eflags: 0x4
// Checksum 0xf7d556aa, Offset: 0x32f0
// Size: 0x60
function private function_423069835edc658e( cooldown_s )
{
    self endon( #"hash_46469bdc8433db8" );
    time_end = gettime() + cooldown_s * 1000;
    
    while ( time_end > gettime() )
    {
        waitframe();
        
        if ( self attackbuttonpressed() || self adsbuttonpressed() )
        {
            self playsoundtoplayer( "wpn_jegun_dryfire_plr", self );
            wait 0.5;
        }
    }
}

// Namespace weap_jetgun
// Params 0, eflags: 0x4
// Checksum 0x77c943de, Offset: 0x3358
// Size: 0x41, Type: bool
function private is_using_jetgun()
{
    var_a7161deab070b065 = self getcurrentweapon();
    
    if ( !isdefined( var_a7161deab070b065 ) || isnullweapon( var_a7161deab070b065 ) || var_a7161deab070b065.basename != level.jetgun_weapon_basename )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace weap_jetgun
    // Params 0
    // Checksum 0x5d1444ba, Offset: 0x33a2
    // Size: 0x44, Type: dev
    function init_jetgun_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x98>" );
        devgui::add_devgui_func( "<dev string:xaf>", "<dev string:xc1>", &function_366f34a5ed926517 );
        devgui::add_devgui_func( "<dev string:xd3>", "<dev string:xec>", &function_50b91dbea3646d5d );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace weap_jetgun
    // Params 0
    // Checksum 0x5ad95380, Offset: 0x33ee
    // Size: 0x47, Type: dev
    function function_366f34a5ed926517()
    {
        if ( level.var_70601b774199d5e )
        {
            level.var_70601b774199d5e = 0;
        }
        else
        {
            level.var_70601b774199d5e = 1;
        }
        
        iprintlnbold( level.var_70601b774199d5e ? "<dev string:x105>" : "<dev string:x11d>" );
    }

    // Namespace weap_jetgun
    // Params 0
    // Checksum 0x6108b998, Offset: 0x343d
    // Size: 0x47, Type: dev
    function function_50b91dbea3646d5d()
    {
        if ( level.var_220ff268d0a97488 )
        {
            level.var_220ff268d0a97488 = 0;
        }
        else
        {
            level.var_220ff268d0a97488 = 1;
        }
        
        iprintlnbold( level.var_220ff268d0a97488 ? "<dev string:x136>" : "<dev string:x155>" );
    }

    // Namespace weap_jetgun
    // Params 2
    // Checksum 0x5916f777, Offset: 0x348c
    // Size: 0x5f, Type: dev
    function jetgun_debug_print( msg, color )
    {
        if ( !level.var_70601b774199d5e )
        {
            return;
        }
        
        if ( !isdefined( color ) )
        {
            color = ( 1, 1, 1 );
        }
        
        print3d( self.origin + ( 0, 0, 60 ), msg, color, 1, 1, 40 );
    }

#/
