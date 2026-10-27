// scripts\mp\common\perks\zombie\perk_quick_revive.gsc  (hash_562e9c41427994f9.gscc) (size: 6587 Bytes / 0x19bb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x463cff99 (1178402713)
// size ...... 6587 (0x19bb)
// includes .. 12  (offset: 0x17f3)
// strings ... 21  (offset: 0x1853)
// dev strs .. 0   (offset: 0x19bb)
// exports ... 17  (offset: 0xdd7)
// cseg ...... 0x25a + 0xb7d (0xdd7)
// imports ... 65  (offset: 0x107f)
// animtree1 . 0   (offset: 0x19bb)
// animtree2 . 0   (offset: 0x19bb)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\player;
#using scripts\mp\currency;
#using scripts\mp\damage;
#using scripts\mp\gametypes\common;
#using scripts\mp\laststand;
#using scripts\mp\playerhealth;
#using scripts\mp\weapons;

#namespace perk_quick_revive;

// Namespace perk_quick_revive
// Params 0, eflags: 0x5
// Checksum 0xff2453f1, Offset: 0x278
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "specialty_quickrevive", undefined, &__init__, undefined );
}

// Namespace perk_quick_revive
// Params 0
// Checksum 0x2dc0b70a, Offset: 0x295
// Size: 0xa
function __init__()
{
    level thread perk_quick_revive_init();
}

// Namespace perk_quick_revive
// Params 0
// Checksum 0xfd32477e, Offset: 0x2a7
// Size: 0xf1
function perk_quick_revive_init()
{
    if ( !level.zombie_perks_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level utility::flag_init( "specialty_quickrevive" + "init_complete" );
    level utility::flag_wait_all( "StartGameTypeCallbackFinished", "zombie_perks_init_complete" );
    str_currency = currency::get_perk_machine_currency( "specialty_quickrevive" );
    var_fcb7626c79b3c98f = currency::get_perk_machine_cost( "specialty_quickrevive" );
    level thread zombie_perks::enable_perk_for_level( "specialty_quickrevive", str_currency, var_fcb7626c79b3c98f, &function_5e5121c18057263e, &function_cc34b623eb2864fc );
    playerhealth::function_d7d82c8b22e0a4fe( &function_1e3d062818e83473 );
    damage::register_scripted_damage_override_func( &quick_revive_damage_override_func );
    callback::add( #"player_laststand_revived", &on_revived );
    callback::add( #"on_ai_killed", &function_676bd22c263aba1f );
    callback::add( #"player_laststand", &on_laststand_enter );
    level utility::flag_set( "specialty_quickrevive" + "init_complete" );
}

// Namespace perk_quick_revive
// Params 10
// Checksum 0x58782aa, Offset: 0x3a0
// Size: 0x7d
function quick_revive_damage_override_func( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime )
{
    if ( self.paybackinvul && !eattacker.var_a7339c2c551e2788 )
    {
        return 0;
    }
    
    return idamage;
}

// Namespace perk_quick_revive
// Params 1
// Checksum 0xceccc418, Offset: 0x426
// Size: 0x363
function on_revived( params )
{
    reviver = params.reviver;
    
    if ( isplayer( reviver ) )
    {
        if ( utility::issharedfuncdefined( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) && reviver utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_quickrevive" ) && utility::issharedfuncdefined( #"zombie", #"player_has_augment" ) && reviver utility::callsharedfunc( #"zombie", #"player_has_augment", #"quick_revive_payback" ) )
        {
            if ( utility::ent_flag( "disable_player_heal_items" ) )
            {
                return;
            }
            else
            {
                reviver.paybackinvul = 1;
                invultime = level.zombie_augments[ #"quick_revive_payback" ].var_bd329a147b3e53b8 ?? 0;
                reviver thread quick_revive_payback_timer( invultime );
                reviver.health = reviver.maxhealth;
                reviver utility::function_32b24db3127bff40( "quick_revive_payback_fx", "payback_fx_on" );
            }
        }
        
        if ( utility::issharedfuncdefined( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) && reviver utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_quickrevive" ) && utility::issharedfuncdefined( #"zombie", #"player_has_augment" ) && reviver utility::callsharedfunc( #"zombie", #"player_has_augment", #"quick_revive_escape_plan" ) )
        {
            stunduration = level.zombie_augments[ #"quick_revive_escape_plan" ].var_15cbe29b2cfb8c5c ?? 1.75;
            var_29e6002bcbd21280 = level.zombie_augments[ #"quick_revive_escape_plan" ].var_652f227b708101fa ?? 256;
            duration = level.zombie_augments[ #"quick_revive_escape_plan" ].var_ca380a47a1121cec ?? 1;
            speedup = level.zombie_augments[ #"quick_revive_escape_plan" ].var_6f880eb5fce58e4b ?? 0;
            weapons::addextramovespeed( "quick_revive_escape_plan", speedup );
            
            if ( !common::function_8ff835bf23198a0( "quick_revive_escape_plan" ) )
            {
                common::function_ac4bf3256b2545e3( "quick_revive_escape_plan", speedup );
            }
            
            weapons::updatemovespeedscale();
            self playlocalsound( "evt_perk_aug_revive_escapeplan_oneshot" );
            reviver weapons::addextramovespeed( "quick_revive_escape_plan", speedup );
            
            if ( !reviver common::function_8ff835bf23198a0( "quick_revive_escape_plan" ) )
            {
                reviver common::function_ac4bf3256b2545e3( "quick_revive_escape_plan", speedup );
            }
            
            reviver weapons::updatemovespeedscale();
            reviver playlocalsound( "evt_perk_aug_revive_escapeplan_oneshot" );
            thread zombie_perks::function_a040bb411a7c8142( "quick_revive_escape_plan_speed_down", 0 );
            reviver thread zombie_perks::function_a040bb411a7c8142( "quick_revive_escape_plan_speed_down", 0 );
            thread quick_revive_escape_plan_speed_down( duration );
            reviver thread quick_revive_escape_plan_speed_down( duration );
        }
        
        callback::callback( "perk_stats_track", { #stats:"revives", #var_ffc1674def575bfa:"specialty_quickrevive" } );
    }
    
    if ( level callback::exists( "on_zombie_ai_damaged", &function_1cf7a38df626cd5f, self ) )
    {
        level callback::remove( "on_zombie_ai_damaged", &function_1cf7a38df626cd5f, self );
    }
}

// Namespace perk_quick_revive
// Params 1
// Checksum 0x9ff0bb2c, Offset: 0x791
// Size: 0x25
function quick_revive_payback_timer( duration )
{
    self endon( #"disconnect" );
    wait duration;
    self.paybackinvul = undefined;
}

// Namespace perk_quick_revive
// Params 1
// Checksum 0xb56c3c20, Offset: 0x7be
// Size: 0x83
function quick_revive_escape_plan_speed_down( duration = 0 )
{
    self endon( #"disconnect" );
    wait duration;
    self notify( #"quick_revive_escape_plan_speed_down" );
    weapons::removeextramovespeed( "quick_revive_escape_plan" );
    
    if ( common::function_8ff835bf23198a0( "quick_revive_escape_plan" ) )
    {
        common::function_d85a92c557ea5a52( "quick_revive_escape_plan" );
    }
    
    weapons::updatemovespeedscale();
    waitframe();
    
    if ( isplayer( self ) && isalive( self ) )
    {
        self setscriptablepartstate( "speed_line_camera", #"speed_line_off", 0 );
    }
}

// Namespace perk_quick_revive
// Params 0
// Checksum 0xbee03e5e, Offset: 0x849
// Size: 0x9
function function_5e5121c18057263e()
{
    function_aba0250154600567();
}

// Namespace perk_quick_revive
// Params 4
// Checksum 0xec32e3e0, Offset: 0x85a
// Size: 0x2e
function function_cc34b623eb2864fc( var_d93428f5ff5cb05d, str_perk, str_result, var_e97a4f4962bc3f25 )
{
    function_d716048582608e1d();
}

// Namespace perk_quick_revive
// Params 0
// Checksum 0x64653b3f, Offset: 0x890
// Size: 0x4d
function function_aba0250154600567()
{
    regendelay = level.perkbundles[ "specialty_quickrevive" ].var_8791c6e735cec222 ?? 0.5;
    playerhealth::function_fd91e6d94cab77e7( #"regendelayreduce_quickrevive", regendelay );
    zombie_perks::function_5d65c3d58cc084ec( "specialty_quickrevive" );
}

// Namespace perk_quick_revive
// Params 0
// Checksum 0x2b26027f, Offset: 0x8e5
// Size: 0x28
function function_d716048582608e1d()
{
    self.var_57e1d1441440e957 = undefined;
    playerhealth::function_b1fb4d148779580e( #"regendelayreduce_quickrevive" );
    zombie_perks::function_25539251d02082( "specialty_quickrevive" );
}

// Namespace perk_quick_revive
// Params 1
// Checksum 0xe477b43d, Offset: 0x915
// Size: 0x1b
function function_1e3d062818e83473( healthperframe )
{
    var_5f80b8531e30f0d4 = undefined;
    return var_5f80b8531e30f0d4;
}

// Namespace perk_quick_revive
// Params 1, eflags: 0x4
// Checksum 0xb884d3d1, Offset: 0x939
// Size: 0x52
function private on_laststand_enter( params )
{
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_quickrevive", #"quick_revive_last_chance" ) )
    {
        self.quick_revive_damage_dealt = 0;
        level callback::add( "on_zombie_ai_damaged", &function_1cf7a38df626cd5f, self );
    }
}

// Namespace perk_quick_revive
// Params 2, eflags: 0x4
// Checksum 0xec17fc28, Offset: 0x993
// Size: 0x209
function private function_1cf7a38df626cd5f( params, attacker )
{
    if ( isplayer( params.eattacker ) )
    {
        if ( params.eattacker != attacker )
        {
            return;
        }
        
        var_1b3eb30b79d38a4d = params.eattacker;
    }
    else if ( isplayer( attacker ) )
    {
        if ( isplayer( params.eattacker.owner ) && params.eattacker.owner != attacker )
        {
            return;
        }
        
        var_1b3eb30b79d38a4d = attacker;
    }
    else
    {
        return;
    }
    
    if ( !var_1b3eb30b79d38a4d.inlaststand )
    {
        return;
    }
    
    if ( !var_1b3eb30b79d38a4d utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_quickrevive", #"quick_revive_last_chance" ) )
    {
        return;
    }
    
    var_1b3eb30b79d38a4d.quick_revive_damage_dealt += params.idamage;
    var_5940f6467e184a13 = level.zombie_augments[ #"quick_revive_last_chance" ].var_9f252b3464164e18 ?? 1;
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( var_1b3eb30b79d38a4d.origin );
    var_f1569c16a29ffcbf = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    
    if ( var_1b3eb30b79d38a4d.quick_revive_damage_dealt >= var_f1569c16a29ffcbf * var_5940f6467e184a13 )
    {
        var_759047565b5a2b96 = 0;
        time = gettime();
        laststandtime = var_1b3eb30b79d38a4d.laststandstarttime ?? time;
        
        if ( time - laststandtime > 1000 )
        {
            var_759047565b5a2b96 = 1;
        }
        
        if ( var_759047565b5a2b96 )
        {
            if ( !isdefined( var_1b3eb30b79d38a4d.var_84cde01ffd2cb360 ) )
            {
                var_1b3eb30b79d38a4d.var_84cde01ffd2cb360 = 0;
            }
            
            if ( var_1b3eb30b79d38a4d.var_84cde01ffd2cb360 < 3 )
            {
                var_1b3eb30b79d38a4d thread quick_revive_last_chance_revive_player();
                return;
            }
            
            var_1b3eb30b79d38a4d utility::callsharedfunc( #"zombie", #"hash_f99b1e81a50f8886", 0 );
        }
    }
}

// Namespace perk_quick_revive
// Params 1
// Checksum 0xf0f12dc7, Offset: 0xba4
// Size: 0x14f
function function_676bd22c263aba1f( params )
{
    if ( self.aicategory == "special" || self.aicategory == "elite" )
    {
        if ( isplayer( params.eattacker ) && params.eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_quickrevive", #"quick_revive_adrenaline_rush" ) )
        {
            bonus_heal_amount = level.zombie_augments[ #"quick_revive_adrenaline_rush" ].var_8e4f5dacd22e8806 ?? 0;
            var_ab8007f32d8a3abe = params.eattacker.health;
            
            if ( var_ab8007f32d8a3abe + bonus_heal_amount > params.eattacker.maxhealth )
            {
                params.eattacker.health = params.eattacker.maxhealth;
            }
            else
            {
                params.eattacker.health += bonus_heal_amount;
            }
            
            playerhealth::forcehealthregen( params.eattacker );
        }
    }
}

// Namespace perk_quick_revive
// Params 0, eflags: 0x4
// Checksum 0x1ff46189, Offset: 0xcfb
// Size: 0xdc
function private quick_revive_last_chance_revive_player()
{
    self notify( #"quick_revive_last_chance_revive_player" );
    self endon( #"quick_revive_last_chance_revive_player" );
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
    
    self playlocalsound( "evt_perk_aug_revive_lastchance" );
    laststand::exit( "last_stand_revived_quick_revive_augment", self );
    self.var_84cde01ffd2cb360++;
    utility::callsharedfunc( #"zombie", #"hash_f99b1e81a50f8886", 0 );
    
    if ( level.var_894cf9c132c87505 )
    {
        laststand::setplayerbeingrevivedextrainfo( 0 );
    }
    
    self setclientomnvar( "ui_securing", 0 );
    self setclientomnvar( "ui_securing_progress", 0 );
}

