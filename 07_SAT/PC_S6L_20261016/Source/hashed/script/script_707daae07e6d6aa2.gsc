// script_707daae07e6d6aa2  (hash_707daae07e6d6aa2.gscc) (size: 16018 Bytes / 0x3e92 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x33782e93 (863514259)
// size ...... 16018 (0x3e92)
// includes .. 13  (offset: 0x3ae2)
// strings ... 39  (offset: 0x3b4a)
// dev strs .. 24  (offset: 0x3d72)
// exports ... 39  (offset: 0x24f6)
// cseg ...... 0x28a + 0x226c (0x24f6)
// imports ... 131 (offset: 0x2b0e)
// animtree1 . 0   (offset: 0x3e92)
// animtree2 . 0   (offset: 0x3e92)
#using script_437ee0f94301721b;
#using script_bdb08507b3b7b94;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\status_effects\effect_stun;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\interaction;
#using scripts\mp\zm\systems\zm_interaction;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_utility;

#namespace zm_zombie_uranus_tower;

// Namespace zm_zombie_uranus_tower
// Params 0, eflags: 0x5
// Checksum 0x60f2676e, Offset: 0x2a8
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_zombie_uranus_tower", undefined, undefined, &post_main );
}

// Namespace zm_zombie_uranus_tower
// Params 0
// Checksum 0xa3d7fe81, Offset: 0x2c9
// Size: 0x17a
function post_main()
{
    /#
        devgui_init();
    #/
    
    level.uranus_tower = spawnstruct();
    level.uranus_tower.var_afee42d70fbda038 = [];
    level.uranus_tower.souls = 0;
    level.uranus_tower.phase = 0;
    level.uranus_tower.settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    
    if ( isdefined( level.uranus_tower.settings.attackvfx ) )
    {
        utility::add_fx( "uranus_attack_vfx", level.uranus_tower.settings.attackvfx );
    }
    
    utility::registersharedfunc( #"zombie_uranus", #"hash_199a328db2c1dad8", &setup_tower );
    utility::registersharedfunc( #"zombie_uranus", #"hash_8887c4db58a529ab", &setup_panel );
    utility::registersharedfunc( #"zombie_uranus", #"hash_371e97b7a78e876a", &spawn_tower );
    utility::registersharedfunc( #"zombie_uranus", #"hash_6729f1b420f75832", &activate_tower );
    utility::registersharedfunc( #"zombie_uranus", #"hash_567859af2c010066", &deactivate_towers );
    level callback::add( #"hash_7d96b0fd9c6eff63", &function_860df8baec719184 );
}

// Namespace zm_zombie_uranus_tower
// Params 1, eflags: 0x4
// Checksum 0x9ba1b785, Offset: 0x44b
// Size: 0x1e
function private function_860df8baec719184( params )
{
    set_phase( params.phase );
}

// Namespace zm_zombie_uranus_tower
// Params 1
// Checksum 0x3e7e1361, Offset: 0x471
// Size: 0x22
function function_66fae7465989fbaf( target )
{
    level.uranus_tower.attacktarget = target;
}

// Namespace zm_zombie_uranus_tower
// Params 2
// Checksum 0x3de90414, Offset: 0x49b
// Size: 0xb2
function setup_panel( pos, angles = ( 0, 0, 0 ) )
{
    panel = spawnstruct();
    panel.origin = pos;
    panel.interact = interaction::register_interact( pos, 100, &on_use_panel, &function_e2a186fa2ab8a7fc );
    panel.interact sethintonobstruction( "show" );
    panel.interact setusableenabled( 0 );
    panel.activated = 0;
    level.uranus_tower.panel = panel;
    return panel;
}

// Namespace zm_zombie_uranus_tower
// Params 1
// Checksum 0xbae9a516, Offset: 0x556
// Size: 0x66
function set_panel_usable( usable )
{
    if ( level.uranus_tower.panel )
    {
        level.uranus_tower.panel.activated = usable;
        level.uranus_tower.panel.interact setusableenabled( usable );
    }
}

// Namespace zm_zombie_uranus_tower
// Params 1
// Checksum 0x7381b3ff, Offset: 0x5c4
// Size: 0x2fd
function on_use_panel( player )
{
    if ( self.inuse )
    {
        return;
    }
    
    self.inuse = 1;
    player thread zm_interaction::function_307c21197e0798d4( &"zm_sat_ruby/uranus_interact" );
    player zm_quest::function_eb3a5a6c3f4f3ba6( { #craft_reason:"using_panel" } );
    interacttime = level.uranus_tower.settings.interactlist[ level.players.size - 1 ].var_14b5e7fc1bb5e093;
    result = player zm_interaction::function_df340931f1a0fe6e( interacttime, self, self.interact_use_range, 1, self, 1 );
    player zm_interaction::function_54d885543db575f3( player, self );
    
    if ( isdefined( player.var_a0de55e36be21b7a ) )
    {
        player zm_interaction::function_7c7ed762cd4d0333();
    }
    
    player zm_quest::function_b94186b3fb991490( { #craft_reason:"using_panel" } );
    self.inuse = 0;
    callback::callback( #"hash_7226f74302044718", { #phase:level.uranus_tower.phase, #player:player } );
    attackedtower = undefined;
    
    if ( result )
    {
        set_panel_usable( 0 );
        level.boss_uranus.boss utility::callsharedfunc( #"zombie_uranus", #"hash_1347e30f12e31225" );
        zm_quest::clear_all_guidance();
        
        if ( level.uranus_tower.phase >= 3 )
        {
            utility::callsharedfunc( #"zombie_uranus", #"hash_8488c9e136de573a" );
            delay_kill_time = getdvarfloat( @"hash_f52c9aa5874404af", 5 );
            
            if ( delay_kill_time > 0 )
            {
                utility::delaycall( delay_kill_time, &kill_boss );
            }
            
            player thread zm_vo::function_8c1a12974bd11f01( #"hash_af545bafd963f60d", #"bc_flavor_player_positive" );
        }
        else
        {
            level thread function_da72e4541aff25c8();
            player thread zm_vo::function_8c1a12974bd11f01( #"hash_947b3a4d82946a67" );
        }
        
        boss = utility::callsharedfunc( #"zombie_uranus", #"hash_8aa4e7e3e44dbeb1" );
        
        if ( isdefined( boss ) )
        {
            duration = 5;
            
            foreach ( tower in level.uranus_tower.var_afee42d70fbda038 )
            {
                if ( tower is_activated() && !tower function_31854a9e29e8d2d() )
                {
                    tower tower_emp_pulse();
                    tower thread function_89b4f7ef9bd60711( boss, duration );
                    attackedtower = tower;
                }
            }
        }
    }
    
    if ( attackedtower )
    {
        attackedtower thread function_973f22048fea7ba9();
    }
    
    return result;
}

// Namespace zm_zombie_uranus_tower
// Params 0
// Checksum 0xa7480e56, Offset: 0x8ca
// Size: 0x36
function kill_boss()
{
    Uranus = utility::callsharedfunc( #"zombie_uranus", #"hash_8aa4e7e3e44dbeb1" );
    
    if ( isalive( Uranus ) )
    {
        Uranus kill();
    }
}

// Namespace zm_zombie_uranus_tower
// Params 0
// Checksum 0x53cf4bba, Offset: 0x908
// Size: 0x120
function function_973f22048fea7ba9()
{
    level endon( #"game_ended" );
    Uranus = utility::callsharedfunc( #"zombie_uranus", #"hash_8aa4e7e3e44dbeb1" );
    
    if ( !isalive( Uranus ) )
    {
        return;
    }
    
    utility::waittill_notify_or_timeout( "tower_attack_finished", 5 );
    
    if ( !isalive( Uranus ) )
    {
        deactivate_towers();
        return;
    }
    
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    
    if ( settings.phase_list.size <= 0 )
    {
        return;
    }
    
    var_6bcaa76eb96d52d4 = 1 - Uranus.phase / settings.phase_list.size;
    
    if ( !Uranus.changing_phase && Uranus.health > 0 && Uranus.health <= Uranus.maxhealth * var_6bcaa76eb96d52d4 )
    {
        Uranus utility::callsharedfunc( #"zombie_uranus", #"hash_886d275d9bbb29e3", Uranus.phase + 1 );
    }
}

// Namespace zm_zombie_uranus_tower
// Params 1, eflags: 0x4
// Checksum 0xecebacbc, Offset: 0xa30
// Size: 0xff
function private set_phase( phase )
{
    level.uranus_tower.phase = phase;
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    
    foreach ( tower in level.uranus_tower.var_afee42d70fbda038 )
    {
        activate = phase >= settings.phase_list.size || tower.index == phase - 1;
        tower clear_souls();
        tower activate_tower( activate );
    }
}

// Namespace zm_zombie_uranus_tower
// Params 2
// Checksum 0xd5abd78, Offset: 0xb37
// Size: 0x7f
function function_e2a186fa2ab8a7fc( interact, player )
{
    if ( !player.interactions_disabled )
    {
        return { #var_26bbd300351fde34:0, #string:&"zm_sat_ruby/platform_button", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_zombie_uranus_tower
// Params 0, eflags: 0x4
// Checksum 0xfda863d5, Offset: 0xbbe
// Size: 0x1b2
function private function_da72e4541aff25c8()
{
    const_stun_duration = 7;
    zombies = getaiarrayinradius( function_2c47559bb164982e(), 2000, "team_two_hundred" );
    
    foreach ( zombie in zombies )
    {
        if ( isalive( zombie ) && zombie.aicategory != "boss" )
        {
            if ( utility::cointoss() )
            {
                zombie kill();
                continue;
            }
            
            zombie effect_stun::stun( "deadwire", const_stun_duration, undefined, "shocked_on", undefined, "electrical" );
            zombie utility::function_7c10ea82c1e305b8( "shocked", "shocked_on" );
        }
    }
    
    wait const_stun_duration;
    level.boss_uranus.boss utility::callsharedfunc( #"zombie_uranus", #"hash_c381381c8d11497b" );
    
    foreach ( zombie in zombies )
    {
        if ( isalive( zombie ) && zombie.aicategory != "boss" )
        {
            zombie utility::function_7c10ea82c1e305b8( "shocked", "shocked_off" );
        }
    }
}

// Namespace zm_zombie_uranus_tower
// Params 0, eflags: 0x4
// Checksum 0x9e61feac, Offset: 0xd78
// Size: 0x104
function private function_2c47559bb164982e()
{
    if ( level.uranus_tower.middle_pos )
    {
        return level.uranus_tower.middle_pos;
    }
    
    middle = ( 0, 0, 0 );
    
    foreach ( tower in level.uranus_tower.var_afee42d70fbda038 )
    {
        middle += tower.origin;
    }
    
    middle *= 1 / level.uranus_tower.var_afee42d70fbda038.size;
    level.uranus_tower.middle_pos = middle;
    return middle;
}

// Namespace zm_zombie_uranus_tower
// Params 0, eflags: 0x4
// Checksum 0x26318033, Offset: 0xe85
// Size: 0x1c
function private tower_emp_pulse()
{
    self.sbl utility::function_32b24db3127bff40( "emp", "on" );
}

// Namespace zm_zombie_uranus_tower
// Params 2
// Checksum 0xde54b3e9, Offset: 0xea9
// Size: 0x4f
function spawn_tower( pos, angles = ( 0, 0, 0 ) )
{
    tower = spawnscriptable( "sat_zm_mars_defence_cannons_scriptable", pos, angles );
    
    if ( tower )
    {
        setup_tower( tower );
    }
}

// Namespace zm_zombie_uranus_tower
// Params 1
// Checksum 0xbd978df2, Offset: 0xf00
// Size: 0x10d
function setup_tower( scriptable )
{
    tower = spawnstruct();
    tower.origin = scriptable.origin;
    tower.sbl = scriptable;
    tower.shoot_ent = spawn( "script_model", tower.origin + ( 0, 0, 435 ) );
    tower.shoot_ent setmodel( "tag_origin" );
    level.uranus_tower.var_afee42d70fbda038[ level.uranus_tower.var_afee42d70fbda038.size ] = tower;
    tower.index = level.uranus_tower.var_afee42d70fbda038.size - 1;
    
    if ( !level callback::exists( #"on_ai_killed", &event_on_ai_killed ) )
    {
        level callback::add( #"on_ai_killed", &event_on_ai_killed );
    }
    
    tower activate_tower( 0 );
    return tower;
}

// Namespace zm_zombie_uranus_tower
// Params 1
// Checksum 0x22957721, Offset: 0x1016
// Size: 0x31
function activate_tower( activate )
{
    self.activated = activate;
    self.sbl utility::function_32b24db3127bff40( "charge", "inactive" );
}

// Namespace zm_zombie_uranus_tower
// Params 0
// Checksum 0xbe1fb59e, Offset: 0x104f
// Size: 0xaa
function deactivate_towers()
{
    foreach ( tower in level.uranus_tower.var_afee42d70fbda038 )
    {
        tower activate_tower( 0 );
        tower.sbl utility::function_32b24db3127bff40( "charge", "inactive" );
    }
    
    set_panel_usable( 0 );
}

// Namespace zm_zombie_uranus_tower
// Params 0
// Checksum 0xe46d83c1, Offset: 0x1101
// Size: 0xb
function is_activated()
{
    return self.activated;
}

// Namespace zm_zombie_uranus_tower
// Params 0
// Checksum 0xe46d83c1, Offset: 0x1115
// Size: 0xb
function function_31854a9e29e8d2d()
{
    return self.attacking;
}

// Namespace zm_zombie_uranus_tower
// Params 1
// Checksum 0x47c21bea, Offset: 0x1129
// Size: 0x18f
function event_on_ai_killed( params )
{
    if ( function_e6086e82698d92a5() )
    {
        return;
    }
    
    enemy = self;
    
    if ( enemy.aicategory == "normal" && enemy.team == zm_utility::get_zombie_team() && isplayer( params.eattacker ) )
    {
        closestsq = -1;
        
        foreach ( tower in level.uranus_tower.var_afee42d70fbda038 )
        {
            if ( tower is_activated() )
            {
                distsq = distance2dsquared( enemy.origin, tower.origin );
                
                if ( distsq > 9000000 )
                {
                    continue;
                }
                
                if ( distsq < closestsq || closestsq < 0 )
                {
                    closestsq = distsq;
                    closesttower = tower;
                }
            }
        }
        
        if ( isdefined( closesttower ) )
        {
            closesttower thread function_e97adef989aafe5d( enemy );
            
            if ( !utility::flag( "first_soul_vo_played" ) )
            {
                utility::flag_set( "first_soul_vo_played" );
                params.eattacker zm_vo::function_8c1a12974bd11f01( #"hash_fd0dbb8361814d6b", #"bc_flavor_player_positive" );
            }
        }
    }
}

// Namespace zm_zombie_uranus_tower
// Params 1
// Checksum 0x7c6a7f0f, Offset: 0x12c0
// Size: 0x1fd
function function_e97adef989aafe5d( enemy )
{
    level endon( #"game_ended" );
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    pos = enemy.origin + ( 0, 0, 50 );
    soulent = utility::spawn_model( settings.soulmodel, pos );
    soulent utility::function_32b24db3127bff40( "soul", "vfx_on" );
    movetime = getdvarfloat( @"hash_e263f7d82063d670", 2 );
    acc = getdvarfloat( @"hash_42e5e3d2e8758dd2", 0.5 );
    towerpos = self.sbl gettagorigin( "j_cannon_top", 1 ) ?? self.sbl.origin + ( 0, 0, 435 );
    deltaheight = towerpos[ 2 ] - soulent.origin[ 2 ];
    controldir = ( 0, 0, 1 );
    var_e9a06f889a2d5d02 = getdvarfloat( @"hash_cf54d93de5c7921e", 0.1 );
    var_bcb7c1079939679c = getdvarfloat( @"hash_6c7c5f77a9f80b40", 0.5 );
    
    if ( deltaheight > 0 )
    {
        var_96e81673dd3580eb = soulent.origin + controldir * randomfloatrange( deltaheight * var_e9a06f889a2d5d02, deltaheight * var_bcb7c1079939679c );
    }
    else
    {
        var_96e81673dd3580eb = soulent.origin + controldir * randomfloatrange( deltaheight * var_bcb7c1079939679c, deltaheight * var_e9a06f889a2d5d02 );
    }
    
    soulent thread utility::function_8001268940441423( soulent.origin, towerpos, var_96e81673dd3580eb, movetime, 0 );
    wait movetime;
    soulent utility::function_32b24db3127bff40( "soul", "vfx_off" );
    soulent delete();
    collect_souls( 1 );
}

// Namespace zm_zombie_uranus_tower
// Params 3, eflags: 0xc
// Checksum 0xe9718a15, Offset: 0x14c5
// Size: 0x2e2
function private function_89b4f7ef9bd60711( boss, duration, damageoverride )
{
    self notify( #"hash_bafc2227385941d9" );
    self endon( #"hash_bafc2227385941d9" );
    level endon( #"game_ended" );
    settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
    interval = 0.5;
    damagefull = ( damageoverride ?? boss.maxhealth ) / settings.phase_list.size + 1000;
    var_fbcd8c1bea9ed66a = duration / interval;
    damagedcount = 0;
    attacker = self.shoot_ent;
    self.attacking = 1;
    
    if ( self.sbl tagexists( "j_cannon_top" ) )
    {
        self.shoot_ent.origin = self.sbl gettagorigin( "j_cannon_top" );
    }
    
    damage = damagefull / duration / interval;
    self.sbl utility::function_32b24db3127bff40( "beam", "charge" );
    tag = self.index == 0 ? "tag_laser_weak_le" : "tag_laser_weak_ri";
    hitent = utility::spawn_model( settings.var_90cf7bf03220eeec );
    hitent linkto( boss, tag, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    attackvfx = playfxontagsbetweenclients( utility::getfx( "uranus_attack_vfx" ), attacker, "tag_origin", hitent, "tag_origin" );
    attackvfx utility::delaycall( duration ?? 5, &delete );
    hitent utility::delaycall( duration ?? 5, &delete );
    hitent utility::function_32b24db3127bff40( "tower_beam", "impact" );
    boss zombie_uranus::start_pain();
    next_damage_time = 0;
    interval = utility::function_4b74c15943231980( interval );
    
    while ( damagedcount < var_fbcd8c1bea9ed66a && isalive( boss ) )
    {
        if ( next_damage_time <= gettime() )
        {
            boss val::set( #"zombie_uranus", "damage", 1 );
            boss dodamage( damage, attacker.origin, attacker, undefined, "MOD_PROJECTILE", undefined, hitent.origin );
            boss val::set( #"zombie_uranus", "damage", 0 );
            damagedcount++;
            next_damage_time = gettime() + interval;
        }
        
        waitframe();
    }
    
    self.sbl utility::function_32b24db3127bff40( "beam", "beam_off" );
    
    if ( isalive( boss ) )
    {
        boss zombie_uranus::end_pain();
    }
    
    self.attacking = 0;
    self notify( #"tower_attack_finished" );
}

// Namespace zm_zombie_uranus_tower
// Params 1
// Checksum 0x926b0226, Offset: 0x17af
// Size: 0xd3
function get_charge_count( phase )
{
    /#
        debugcount = getdvarint( @"hash_197a53e38e40f561", 0 );
        
        if ( debugcount > 0 )
        {
            return debugcount;
        }
    #/
    
    phase = maxint( 1, phase );
    
    if ( phase <= level.uranus_tower.settings.phase_list.size )
    {
        phasesetting = level.uranus_tower.settings.phase_list[ phase - 1 ];
        playercount = level.players.size;
        return ( phasesetting.var_e9fe33047720af8f[ playercount - 1 ].var_d379d381c2756707 ?? 0 );
    }
    
    assertmsg( "<dev string:x24>" + phase );
    return 0;
}

// Namespace zm_zombie_uranus_tower
// Params 1
// Checksum 0x2ae44cd3, Offset: 0x188b
// Size: 0x59, Type: bool
function function_e6086e82698d92a5( lv = 3 )
{
    ratio = lv / 3;
    return level.uranus_tower.souls >= get_charge_count( level.uranus_tower.phase ) * ratio;
}

// Namespace zm_zombie_uranus_tower
// Params 1
// Checksum 0x7611993f, Offset: 0x18ed
// Size: 0x2fd
function collect_souls( soulcount )
{
    charged = 0;
    prev_souls = level.uranus_tower.souls;
    level.uranus_tower.souls += soulcount;
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        zm_quest::function_9f49b2a045ece8ae( level.uranus_tower.souls, 1, #"ruby_mq_guidance", #"boss_1" );
    }
    
    var_3167c82754999d32 = get_charge_count( level.uranus_tower.phase );
    
    if ( level.uranus_tower.souls >= var_3167c82754999d32 && !level.uranus_tower.panel.activated )
    {
        foreach ( player in level.players )
        {
            player thread zm_utility::white_screen_flash( 0.5, 0.5 );
        }
        
        charged = 1;
        set_panel_usable( 1 );
        level thread zm_quest::function_d5ef98341fd6a057( [ #"hash_b1edba3fa3447cce" ] );
        thread zm_quest::update_guidance( [ [ level.uranus_tower.panel ] ], #"ruby_mq_guidance", #"boss_2" );
    }
    
    charge_anim = undefined;
    
    if ( !charged )
    {
        var_23fefa0d25c9f9f = int( var_3167c82754999d32 * 0.33 );
        var_6685e9d7d83f5a1 = int( var_3167c82754999d32 * 0.66 );
        
        if ( prev_souls < var_23fefa0d25c9f9f && level.uranus_tower.souls >= var_23fefa0d25c9f9f )
        {
            charge_anim = "charge_33";
        }
        else if ( prev_souls < var_6685e9d7d83f5a1 && level.uranus_tower.souls >= var_6685e9d7d83f5a1 )
        {
            charge_anim = "charge_66";
        }
    }
    else if ( prev_souls < var_3167c82754999d32 )
    {
        charge_anim = "full_charge";
    }
    
    foreach ( tower in level.uranus_tower.var_afee42d70fbda038 )
    {
        if ( tower is_activated() )
        {
            tower thread function_1d2b4b2c4d123659( charge_anim );
        }
    }
}

// Namespace zm_zombie_uranus_tower
// Params 1
// Checksum 0x2dbcd5a2, Offset: 0x1bf2
// Size: 0x87
function function_1d2b4b2c4d123659( charge_anim )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    tower = self;
    
    if ( charge_anim )
    {
        tower.sbl utility::function_32b24db3127bff40( "charge", charge_anim );
    }
    
    if ( tower.sbl getscriptableparthasstate( "soul_cage", "collected" ) )
    {
        tower.sbl utility::function_32b24db3127bff40( "soul_cage", "collected" );
    }
}

// Namespace zm_zombie_uranus_tower
// Params 0
// Checksum 0xed7a4d2f, Offset: 0x1c81
// Size: 0xb5
function clear_souls()
{
    level.uranus_tower.souls = 0;
    
    foreach ( tower in level.uranus_tower.var_afee42d70fbda038 )
    {
        tower.sbl utility::function_32b24db3127bff40( "charge", "inactive" );
    }
    
    set_panel_usable( 0 );
}

/#

    // Namespace zm_zombie_uranus_tower
    // Params 0
    // Checksum 0xd5f4b70, Offset: 0x1d3e
    // Size: 0x102, Type: dev
    function devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x43>" + "<dev string:x67>" );
        devgui::add_devgui_func( "<dev string:x6e>", "<dev string:x80>", &function_42f64ff5fbfe8063, 1, 10 );
        devgui::add_devgui_func( "<dev string:x96>", "<dev string:xa2>", &clear_souls, 1, 11 );
        devgui::add_devgui_func( "<dev string:xae>", "<dev string:xbf>", &function_973c0af3685b68eb, 1, 12 );
        devgui::add_devgui_func( "<dev string:xd6>", "<dev string:xe8>", &function_6730df8ed445c3e9, 1, 13 );
        devgui::add_devgui_func( "<dev string:x106>", "<dev string:x119>", &function_aef5d15d079a32af, undefined, 14 );
        devgui::add_devgui_func( "<dev string:x12c>", "<dev string:x13f>", &function_aef5d25d079a34e2, undefined, 15 );
        devgui::add_devgui_func( "<dev string:x152>", "<dev string:x165>", &function_aef5d35d079a3715, undefined, 16 );
        devgui::add_devgui_func( "<dev string:x178>", "<dev string:x188>", &test_soul_trail, 1, 17 );
        devgui::function_77df7fe7dd273e10();
        
        if ( getdvarint( @"hash_43ec95d261472638" ) )
        {
            thread function_bfc9f2bc0ffeb6a8();
        }
    }

    // Namespace zm_zombie_uranus_tower
    // Params 0
    // Checksum 0xb1d8192b, Offset: 0x1e48
    // Size: 0x65, Type: dev
    function function_42f64ff5fbfe8063()
    {
        boss = utility::callsharedfunc( #"zombie_uranus", #"hash_8aa4e7e3e44dbeb1" );
        
        if ( boss.changing_phase )
        {
            return;
        }
        
        collect_souls( int( get_charge_count( level.uranus_tower.phase ) * 0.33 ) + 1 );
    }

    // Namespace zm_zombie_uranus_tower
    // Params 0
    // Checksum 0x7208db53, Offset: 0x1eb5
    // Size: 0x3f, Type: dev
    function function_973c0af3685b68eb()
    {
        if ( !getdvarint( @"hash_43ec95d261472638" ) )
        {
            setdvar( @"hash_43ec95d261472638", 1 );
            thread function_bfc9f2bc0ffeb6a8();
            return;
        }
        
        setdvar( @"hash_43ec95d261472638", 0 );
    }

    // Namespace zm_zombie_uranus_tower
    // Params 0, eflags: 0xc
    // Checksum 0x133d1948, Offset: 0x1efc
    // Size: 0x171, Type: dev
    function private function_bfc9f2bc0ffeb6a8()
    {
        self notify( #"hash_42822ae36cf5f318" );
        self endon( #"hash_42822ae36cf5f318" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( isdefined( level.uranus_tower ) )
            {
                break;
            }
            
            wait 1;
        }
        
        while ( getdvarint( @"hash_43ec95d261472638" ) )
        {
            if ( isdefined( level.uranus_tower.panel ) )
            {
                function_6a6ce32bf2c4b967( level.uranus_tower.panel );
            }
            
            foreach ( tower in level.uranus_tower.var_afee42d70fbda038 )
            {
                function_6a6ce32bf2c4b967( tower );
                
                if ( tower.shoot_ent )
                {
                    sphere( tower.shoot_ent.origin, 50, ( 1, 0, 0 ), 0, 1 );
                }
                
                sphere( tower.sbl gettagorigin( "<dev string:x198>" ), 30, ( 0, 1, 0 ), 0, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace zm_zombie_uranus_tower
    // Params 1, eflags: 0x4
    // Checksum 0x27982798, Offset: 0x2075
    // Size: 0x122, Type: dev
    function private function_6a6ce32bf2c4b967( target )
    {
        ystart = 75;
        yoffset = 16;
        chargereq = get_charge_count( level.uranus_tower.phase );
        z = ystart;
        print3d( target.origin + ( 0, 0, z ), "<dev string:x1a5>" + level.uranus_tower.souls + "<dev string:x1ad>" + chargereq, ( 1, 1, 1 ), 1 );
        z += yoffset;
        print3d( target.origin + ( 0, 0, z ), "<dev string:x1b1>" + target is_activated(), ( 1, 1, 1 ), 1 );
        z += yoffset;
        print3d( target.origin + ( 0, 0, z ), "<dev string:x1bd>" + level.uranus_tower.phase, ( 1, 1, 1 ), 1 );
        z += yoffset;
    }

    // Namespace zm_zombie_uranus_tower
    // Params 0
    // Checksum 0x8e5da339, Offset: 0x219f
    // Size: 0x73, Type: dev
    function function_aef5d15d079a32af()
    {
        boss = utility::callsharedfunc( #"zombie_uranus", #"hash_8aa4e7e3e44dbeb1" );
        boss zombie_uranus_asm::set_phase( 1 );
        level.uranus_tower.var_afee42d70fbda038[ 0 ] tower_emp_pulse();
        level.uranus_tower.var_afee42d70fbda038[ 0 ] thread function_89b4f7ef9bd60711( boss, 5, 1000 );
    }

    // Namespace zm_zombie_uranus_tower
    // Params 0
    // Checksum 0x1754f280, Offset: 0x221a
    // Size: 0x75, Type: dev
    function function_aef5d25d079a34e2()
    {
        boss = utility::callsharedfunc( #"zombie_uranus", #"hash_8aa4e7e3e44dbeb1" );
        boss zombie_uranus_asm::set_phase( 2 );
        level.uranus_tower.var_afee42d70fbda038[ 1 ] tower_emp_pulse();
        level.uranus_tower.var_afee42d70fbda038[ 1 ] thread function_89b4f7ef9bd60711( boss, 5, 1000 );
    }

    // Namespace zm_zombie_uranus_tower
    // Params 0
    // Checksum 0x73af560d, Offset: 0x2297
    // Size: 0xb4, Type: dev
    function function_aef5d35d079a3715()
    {
        boss = utility::callsharedfunc( #"zombie_uranus", #"hash_8aa4e7e3e44dbeb1" );
        boss zombie_uranus_asm::set_phase( 3 );
        level.uranus_tower.var_afee42d70fbda038[ 0 ] tower_emp_pulse();
        level.uranus_tower.var_afee42d70fbda038[ 0 ] thread function_89b4f7ef9bd60711( boss, 5, 1000 );
        level.uranus_tower.var_afee42d70fbda038[ 1 ] tower_emp_pulse();
        level.uranus_tower.var_afee42d70fbda038[ 1 ] thread function_89b4f7ef9bd60711( boss, 5, 1000 );
    }

    // Namespace zm_zombie_uranus_tower
    // Params 0
    // Checksum 0x7e0610f3, Offset: 0x2353
    // Size: 0xb7, Type: dev
    function function_6730df8ed445c3e9()
    {
        level.uranus_tower.souls = 0;
        
        foreach ( tower in level.uranus_tower.var_afee42d70fbda038 )
        {
            if ( tower is_activated() )
            {
                tower activate_tower( 0 );
                continue;
            }
            
            tower activate_tower( 1 );
        }
    }

    // Namespace zm_zombie_uranus_tower
    // Params 0
    // Checksum 0x327f14de, Offset: 0x2412
    // Size: 0xe4, Type: dev
    function test_soul_trail()
    {
        Uranus = level.debug_uranus;
        settings = utility::callsharedfunc( #"zombie_uranus", #"hash_6a335156d7ce17de" );
        origin = devgui::function_97024c0a6d1256a6();
        
        foreach ( tower in level.uranus_tower.var_afee42d70fbda038 )
        {
            if ( tower is_activated() )
            {
                tower thread function_e97adef989aafe5d( { #origin:origin } );
            }
        }
    }

#/
