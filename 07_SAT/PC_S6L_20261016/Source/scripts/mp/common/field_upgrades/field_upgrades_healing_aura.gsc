// scripts\mp\common\field_upgrades\field_upgrades_healing_aura.gsc  (hash_40c7ea3dcfa00144.gscc) (size: 10396 Bytes / 0x289c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x75d53cca (1976909002)
// size ...... 10396 (0x289c)
// includes .. 12  (offset: 0x2630)
// strings ... 28  (offset: 0x2690)
// dev strs .. 5   (offset: 0x2860)
// exports ... 25  (offset: 0x17fc)
// cseg ...... 0x2f5 + 0x1507 (0x17fc)
// imports ... 86  (offset: 0x1be4)
// animtree1 . 0   (offset: 0x289c)
// animtree2 . 0   (offset: 0x289c)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\field_upgrades\field_upgrades;
#using scripts\mp\common\utility\player;
#using scripts\mp\laststand;
#using scripts\mp\supers;

#namespace field_upgrades_healing_aura;

// Namespace field_upgrades_healing_aura
// Params 0, eflags: 0x5
// Checksum 0x26ef3c0f, Offset: 0x313
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"healing_aura", undefined, undefined, &init );
}

// Namespace field_upgrades_healing_aura
// Params 0
// Checksum 0x49ec94eb, Offset: 0x334
// Size: 0x114
function init()
{
    superbundle = field_upgrades::function_1fcc83f10e7752e5( "super_healing_aura" );
    
    if ( !isdefined( superbundle ) )
    {
        return;
    }
    
    level._effect[ "field_upgrade_healing_aura_pillar" ] = loadfxasset( "vfx_t10_gameplay_zm_ai_zai_healing_aura_3p_lvl5" );
    utility::flag_wait( "supers_initialized" );
    level.var_e6e55ccba9ef0e84 = 0;
    supers_mp::function_48aaa60b2ce7b8a1( "super_healing_aura", undefined, undefined, &begin_use_healing_aura, &function_17ac078d61e28c, undefined );
    utility::registersharedfunc( #"zombie", #"healing_aura_pillar", &healing_aura_pillar );
    utility::registersharedfunc( #"zombie", #"hash_f32d27d0e19d136a", &function_107233ea77c5384a );
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_command( "<dev string:x3a>", "<dev string:x4c>" );
        devgui::add_devgui_command( "<dev string:x7a>", "<dev string:x8f>" );
        devgui::function_77df7fe7dd273e10();
    #/
    
    level callback::add( #"on_ai_killed_medal", &on_killed_medal );
    callback::add( #"player_laststand_exit", &on_laststand_exit );
    scene::function_85b13b837056bc8b( &function_6bfb6c5bb03e18cf );
}

// Namespace field_upgrades_healing_aura
// Params 0
// Checksum 0x3234885, Offset: 0x450
// Size: 0xed, Type: bool
function begin_use_healing_aura()
{
    if ( isdefined( level.field_upgrade_bundles[ "super_healing_aura" ] ) )
    {
        healingauraweapon = level.field_upgrade_bundles[ "super_healing_aura" ].offhandweapon;
        deploysuccess = field_upgrades::field_upgrade_play_gesture( healingauraweapon, "super_healing_aura" );
        
        if ( isdefined( level.begin_use_healing_aura ) && !self [[ level.begin_use_healing_aura ]]() )
        {
            return false;
        }
        
        if ( deploysuccess )
        {
            currentweapon = self getcurrentweapon();
            
            if ( !currentweapon.isdualwield )
            {
                self setscriptablepartstate( "wand_fx", "wand_on_healing_aura", 0 );
            }
            
            self.last_healing_aura = gettime();
            thread run_healing_aura();
            self notify( #"using_healing_aura" );
            callback::callback( "player_used_healing_aura" );
            level callback::callback( "using_healing_aura", { #user:self } );
            return true;
        }
    }
    
    return false;
}

// Namespace field_upgrades_healing_aura
// Params 2
// Checksum 0xa0c733ea, Offset: 0x546
// Size: 0x4d, Type: bool
function function_17ac078d61e28c( fromdeath, attacker )
{
    wait_time = utility::function_6f5d2e1f1ff70482( 5000 );
    utility::delaythread( wait_time, &callback::callback, "field_upgrade_ended", { #ref:"super_healing_aura" } );
    return false;
}

// Namespace field_upgrades_healing_aura
// Params 0
// Checksum 0x4ba20930, Offset: 0x59c
// Size: 0x9
function run_healing_aura()
{
    thread heal_all_players();
}

// Namespace field_upgrades_healing_aura
// Params 0
// Checksum 0x84cf92db, Offset: 0x5ad
// Size: 0xd8
function heal_all_players()
{
    players = get_valid_players();
    
    foreach ( player in players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        player function_d96690fecfaefec8( self );
        
        if ( isdefined( level.var_b626b7280fca71fa ) && isdefined( level.var_b626b7280fca71fa[ "id_healing_aura_heal" ] ) )
        {
            self [[ level.var_b626b7280fca71fa[ "id_healing_aura_heal" ] ]]();
        }
    }
    
    if ( self.low_health_healed )
    {
        thread function_7ebc4a7f65247e40();
    }
}

// Namespace field_upgrades_healing_aura
// Params 1
// Checksum 0xb978c76f, Offset: 0x68d
// Size: 0x150
function function_d96690fecfaefec8( reviver )
{
    self notify( #"healing_aura_healed" );
    thread function_107233ea77c5384a( 1 );
    var_4b3848955f37d3ff = 1;
    
    if ( var_4b3848955f37d3ff && self.inlaststand )
    {
        reviver.low_health_healed = 1;
        thread function_8673df44708f54ac();
        thread revive_player( reviver );
        reviver callback::callback( "field_upgrade_stats_track", { #stats:"revives", #ref:"super_healing_aura", #player:reviver } );
    }
    else
    {
        if ( !reviver.low_health_healed && self.health / self.maxhealth < 0.25 )
        {
            reviver.low_health_healed = 1;
            
            if ( utility::issharedfuncdefined( #"sound", #"play_scoreevent_vo", 0 ) )
            {
                utility::callsharedfunc( #"sound", #"play_scoreevent_vo", reviver, #"bc_super_healing_aura_success" );
            }
        }
        
        refill_player_health();
    }
    
    sparams = spawnstruct();
    sparams.healer = reviver;
    sparams.waspillar = 0;
    callback::callback( "on_healingaura_healed", sparams );
}

// Namespace field_upgrades_healing_aura
// Params 1
// Checksum 0x487f149, Offset: 0x7e5
// Size: 0x8d
function function_107233ea77c5384a( duration )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.var_14237761a6491554 ) )
    {
        str_on_state = self.var_14237761a6491554;
    }
    else if ( player::isinlaststand( self ) )
    {
        str_on_state = "super_fx_on_downed_player";
    }
    else
    {
        str_on_state = "super_fx_on";
    }
    
    self setscriptablepartstate( "healing_aura_fx", str_on_state, 0 );
    wait duration;
    self setscriptablepartstate( "healing_aura_fx", "super_fx_off", 0 );
}

// Namespace field_upgrades_healing_aura
// Params 1
// Checksum 0xe020ee0b, Offset: 0x87a
// Size: 0x16
function on_laststand_exit( sparams )
{
    self.beingremoterevived = undefined;
}

// Namespace field_upgrades_healing_aura
// Params 2
// Checksum 0x11902785, Offset: 0x898
// Size: 0xc7
function revive_player( reviver, use_remote_revive )
{
    self notify( #"hash_46412c9efb98d38e" );
    self endon( #"hash_46412c9efb98d38e" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    n_timeout = 8;
    
    while ( player::isinlaststand( self ) && !self.var_cc09887c7db65ab5 )
    {
        if ( n_timeout <= 0 )
        {
            break;
        }
        
        waitframe();
        n_timeout -= level.framedurationseconds;
    }
    
    self notify( #"last_stand_exit" );
    
    if ( hasomnvar( "ui_scoreboard_enabled" ) )
    {
        self setclientomnvar( "ui_scoreboard_enabled", 0 );
        waitframe();
        self setclientomnvar( "ui_scoreboard_enabled", 1 );
    }
    
    laststand::function_75e6bc3d39e1f2bb( reviver, "last_stand_revived_healing_aura" );
}

// Namespace field_upgrades_healing_aura
// Params 1
// Checksum 0x97c01b37, Offset: 0x967
// Size: 0x55
function function_8673df44708f54ac( var_6ddcbfd5a5aa356f )
{
    self notify( #"hash_7489ef17ca04cd7a" );
    self endon( #"hash_7489ef17ca04cd7a" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self waittill( #"last_stand_exit" );
    refill_player_health();
    
    if ( var_6ddcbfd5a5aa356f )
    {
    }
}

// Namespace field_upgrades_healing_aura
// Params 0
// Checksum 0x3854fa95, Offset: 0x9c4
// Size: 0x162
function get_valid_players()
{
    bundle = field_upgrades::get_field_upgrade_bundle();
    affected_radius = bundle.healing_players_radius;
    players = [];
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( self.team != player.team )
        {
            continue;
        }
        
        if ( player utility::ent_flag( "disable_player_heal_items" ) )
        {
            continue;
        }
        
        can_affect = 1;
        
        if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
        {
            can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, player );
        }
        
        if ( !can_affect )
        {
            continue;
        }
        
        if ( isdefined( affected_radius ) && distancesquared( player.origin, self.origin ) > squared( affected_radius ) )
        {
            continue;
        }
        
        players[ players.size ] = player;
    }
    
    return players;
}

// Namespace field_upgrades_healing_aura
// Params 0
// Checksum 0xcb1f27db, Offset: 0xb2f
// Size: 0x1d
function refill_player_health()
{
    self.health = self.maxhealth;
    damage_effects::onexitdeathsdoor( 1 );
}

// Namespace field_upgrades_healing_aura
// Params 2
// Checksum 0x54c22144, Offset: 0xb54
// Size: 0x41d
function healing_aura_pillar( owner, player )
{
    level endon( #"game_ended" );
    level endon( #"hash_5872f13e4be1c312" );
    
    if ( !isplayer( player ) || !isplayer( owner ) )
    {
        return;
    }
    
    level.var_e6e55ccba9ef0e84++;
    
    if ( level.var_e6e55ccba9ef0e84 > 4 )
    {
        return;
    }
    
    duration = level.zombie_augments[ #"healingaura_pillar_of_light" ].var_aa9010e3054d6327 ?? 10;
    ticktime = level.zombie_augments[ #"healingaura_pillar_of_light" ].var_1ddb6bd26d1a550b ?? 1;
    var_575fa5fcfb8b6b1c = level.zombie_augments[ #"healingaura_pillar_of_light" ].var_b575f1d4268f1e97 ?? 50;
    range = level.zombie_augments[ #"healingaura_pillar_of_light" ].var_c3ad4ea16f1994a8 ?? 8;
    var_7e7ca0a63d1d515e = spawn( "script_model", player.origin );
    var_7e7ca0a63d1d515e setmodel( "tag_origin" );
    var_7e7ca0a63d1d515e.fx = playfxontag( utility::getfx( "field_upgrade_healing_aura_pillar" ), var_7e7ca0a63d1d515e, "tag_origin" );
    duration *= 1000;
    starttime = gettime();
    lasttime = gettime();
    owner notify( #"hash_63cb19726e08f6fc" );
    
    if ( !owner val::get( "toggle_remote_revive" ) )
    {
        owner val::set( "healing_aura_pillar_revive", "toggle_remote_revive", 1 );
    }
    
    while ( lasttime - starttime < duration )
    {
        nearbyplayers = getplayersinradius( var_7e7ca0a63d1d515e.origin, range, undefined, undefined, undefined, owner.team );
        
        foreach ( resplayer in nearbyplayers )
        {
            can_affect = 1;
            
            if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
            {
                can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( owner, resplayer );
            }
            
            if ( can_affect && resplayer.inlaststand )
            {
                resplayer thread function_8673df44708f54ac();
                resplayer thread revive_player( owner, 1 );
            }
        }
        
        foreach ( healplayer in level.players )
        {
            if ( !healplayer.inlaststand && healplayer.team == owner.team )
            {
                can_affect = 1;
                
                if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
                {
                    can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( owner, healplayer );
                }
                
                if ( can_affect )
                {
                    healplayer pillar_heal( owner, var_575fa5fcfb8b6b1c, ticktime );
                }
            }
        }
        
        lasttime = gettime();
        wait ticktime;
    }
    
    owner thread function_d5e47ee83e71c421();
    level.var_e6e55ccba9ef0e84--;
    level.var_e6e55ccba9ef0e84 = int( clamp( level.var_e6e55ccba9ef0e84, 0, 4 ) );
    killfxontag( level._effect[ "field_upgrade_healing_aura_pillar" ], var_7e7ca0a63d1d515e, "tag_origin" );
    
    if ( level.var_e6e55ccba9ef0e84 == 0 )
    {
        owner callback::callback( #"hash_8c65892ba685a482", {} );
    }
}

// Namespace field_upgrades_healing_aura
// Params 0
// Checksum 0xfae99c84, Offset: 0xf79
// Size: 0xec
function function_d5e47ee83e71c421()
{
    self notify( #"hash_f9529382557352db" );
    self endon( #"hash_f9529382557352db" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"hash_63cb19726e08f6fc" );
    var_e71d4811bfa1d660 = 1;
    
    while ( var_e71d4811bfa1d660 )
    {
        var_e71d4811bfa1d660 = 0;
        
        foreach ( player in level.players )
        {
            if ( player.beingremoterevived )
            {
                var_e71d4811bfa1d660 = 1;
                break;
            }
        }
        
        waitframe();
    }
    
    val::reset( "healing_aura_pillar_revive", "toggle_remote_revive" );
}

// Namespace field_upgrades_healing_aura
// Params 3
// Checksum 0x974d8c27, Offset: 0x106d
// Size: 0xbe
function pillar_heal( healer, var_575fa5fcfb8b6b1c, fxduration )
{
    if ( isplayer( self ) && isalive( self ) )
    {
        function_107233ea77c5384a( fxduration );
        
        if ( isplayer( self ) && isalive( self ) )
        {
            healthtotal = self.health + var_575fa5fcfb8b6b1c;
            self.health = int( clamp( healthtotal, self.health, self.maxhealth ) );
            sparams = spawnstruct();
            sparams.healer = healer;
            sparams.waspillar = 1;
            callback::callback( "on_healingaura_healed", sparams );
        }
    }
}

// Namespace field_upgrades_healing_aura
// Params 0
// Checksum 0x758dbefc, Offset: 0x1133
// Size: 0x119
function set_healing_beam()
{
    level endon( #"game_ended" );
    players = get_valid_players();
    
    foreach ( player in players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        var_1342f94d76d06801 = utility::groundpos( player.origin );
        var_cd79df12e48136a2 = spawn( "script_model", var_1342f94d76d06801 );
        var_cd79df12e48136a2 setmodel( "tag_origin" );
        var_cd79df12e48136a2 linkto( player );
        var_2568565ee3f4564f = spawn( "script_model", var_1342f94d76d06801 );
        var_2568565ee3f4564f setmodel( "tag_origin" );
        var_2568565ee3f4564f linkto( var_cd79df12e48136a2 );
        var_cd79df12e48136a2.var_2568565ee3f4564f = var_2568565ee3f4564f;
        var_cd79df12e48136a2 thread function_5266fe4c4795bae3( self );
    }
}

// Namespace field_upgrades_healing_aura
// Params 1
// Checksum 0x863b89c3, Offset: 0x1254
// Size: 0x38
function function_7f442d2911583adb( var_a6deffd8b974de91 )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    waitframe();
    playfxontag( utility::getfx( var_a6deffd8b974de91 ), self, "tag_origin" );
}

// Namespace field_upgrades_healing_aura
// Params 1
// Checksum 0xeda3d754, Offset: 0x1294
// Size: 0x144
function function_5266fe4c4795bae3( user_player )
{
    self endon( #"death" );
    time = 0;
    settings = user_player field_upgrades::get_field_upgrade_bundle();
    duration = settings.var_2c196ab256fa1634;
    tick = settings.var_6c1439592839d9b5;
    beam_radius = settings.beam_radius;
    
    while ( time <= duration )
    {
        players = user_player get_valid_players();
        
        foreach ( player in players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( distance2dsquared( self.origin, player.origin ) <= squared( beam_radius ) )
            {
                player function_d96690fecfaefec8( user_player );
            }
        }
        
        time += tick;
        wait tick;
    }
    
    wait tick;
    self delete();
}

// Namespace field_upgrades_healing_aura
// Params 0
// Checksum 0x365f4c29, Offset: 0x13e0
// Size: 0x9e
function function_2380be09d78ea998()
{
    level endon( #"game_ended" );
    players = get_valid_players();
    
    foreach ( player in players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        player thread function_a7c8a63b7d7389c3( self );
    }
}

// Namespace field_upgrades_healing_aura
// Params 1
// Checksum 0x548996a7, Offset: 0x1486
// Size: 0x103
function function_a7c8a63b7d7389c3( user_player )
{
    id = self getentitynumber();
    self notify( "do_player_regen" + id );
    self endon( "do_player_regen" + id );
    self endon( #"death_or_disconnect" );
    time = 0;
    settings = user_player field_upgrades::get_field_upgrade_bundle();
    duration = settings.var_fde81f7a4cd36329;
    tick = settings.var_b31a2270454894c;
    var_824bb7c48629baae = settings.var_45e991ba88539595;
    
    while ( time <= duration )
    {
        if ( !self.inlaststand )
        {
            if ( isnumber( self.health ) && isnumber( self.maxhealth ) )
            {
                self.health = int( min( self.health + var_824bb7c48629baae, self.maxhealth ) );
            }
        }
        
        time += tick;
        wait tick;
    }
    
    waitframe();
}

// Namespace field_upgrades_healing_aura
// Params 1, eflags: 0x4
// Checksum 0xd1c4c460, Offset: 0x1591
// Size: 0x1ae
function private on_killed_medal( params )
{
    player = params.attacker;
    
    if ( player.low_health_healed || isdefined( player.rapidkill_data[ "healing_aura" ] ) && player.rapidkill_data[ "healing_aura" ].rapidkill_count > 0 )
    {
        if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
        {
            player utility::callsharedfunc( #"medal", #"track_rapid_kill", "healing_aura" );
        }
        
        if ( isdefined( player.rapidkill_data[ "healing_aura" ] ) && player.rapidkill_data[ "healing_aura" ].rapidkill_count == 5 )
        {
            player namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_combatmedic" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                player utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_combatmedic" );
            }
        }
    }
    
    if ( player.last_healing_aura && player.last_healing_aura + 5000 > gettime() )
    {
        params = { #stats:"kills_while_active", #ref:"super_healing_aura", #field_upgrade:"healing_aura", #victim:params.victim, #player:player };
        player callback::callback( "on_field_upgrade_kill_track", params );
    }
}

// Namespace field_upgrades_healing_aura
// Params 0, eflags: 0x4
// Checksum 0x9f9c690, Offset: 0x1747
// Size: 0x1b
function private function_7ebc4a7f65247e40()
{
    self endon( #"death_or_disconnect" );
    wait 2;
    self.low_health_healed = undefined;
}

// Namespace field_upgrades_healing_aura
// Params 0, eflags: 0x4
// Checksum 0xf81a6b77, Offset: 0x176a
// Size: 0x92
function private function_6bfb6c5bb03e18cf()
{
    foreach ( player in level.players )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        player utility::function_7c10ea82c1e305b8( "healing_aura_fx", "super_fx_off" );
    }
}

