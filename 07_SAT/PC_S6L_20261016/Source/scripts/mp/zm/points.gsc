// scripts\mp\zm\points.gsc  (hash_2301d27669c5a079.gscc) (size: 22073 Bytes / 0x5639 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xebab6ef (247117551)
// size ...... 22073 (0x5639)
// includes .. 15  (offset: 0x5081)
// strings ... 78  (offset: 0x50f9)
// dev strs .. 2   (offset: 0x5621)
// exports ... 45  (offset: 0x3b51)
// cseg ...... 0x58e + 0x35c3 (0x3b51)
// imports ... 103 (offset: 0x4259)
// animtree1 . 0   (offset: 0x5639)
// animtree2 . 0   (offset: 0x5639)
#using script_16ea1b94f0f381b3;
#using script_aa3bac81ad4fc8e;
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_stun;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\cash;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\currency;
#using scripts\mp\gamescore;
#using scripts\mp\rank;
#using scripts\mp\supers;

#namespace points;

// Namespace points
// Params 0
// Checksum 0x4aa2c40d, Offset: 0x5ac
// Size: 0x1dd
function init()
{
    utility::registersharedfunc( #"points", #"get_points", &zm_get_points );
    utility::registersharedfunc( #"points", #"set_points", &function_40dc4b206b63ac2e );
    utility::registersharedfunc( #"points", #"take_points", &function_b660af7031bca4bd );
    utility::registersharedfunc( #"points", #"add_points", &zm_add_points );
    utility::registersharedfunc( #"medal", #"register_on_kill_medal_callback", &register_on_kill_medal_callback );
    utility::registersharedfunc( #"medal", #"track_rapid_kill", &track_rapidkill );
    utility::registersharedfunc( #"medal", #"track_scorestreak_kill", &function_b1c028fc147828d1 );
    utility::registersharedfunc( #"zombie", #"get_weapon_element", &zm_get_weapon_element );
    utility::registersharedfunc( #"player", #"doScoreEvent", &zm_do_score_event );
    val::register( "zm_points_scalar", 1, 1, "$self", &update_point_scalar, "$value" );
    level.modifyunifiedpointscallback = &zm_modify_points;
    level.var_a3797ac7329f1d8d = &function_b4a37a41147ddca8;
    callback::add( #"player_connect", &on_player_connect );
    callback::add( "on_round_end", &on_round_end );
    level.var_951445557a9211da = &function_ec295b0954b06e3;
    level callback::add( #"killstreak_finish_use", &function_63008f832dff2e72 );
    level callback::add( #"killstreak_trigger_failed", &function_63008f832dff2e72 );
    level callback::add( #"player_damaged", &on_player_damaged );
    level.zm_do_score_event_throttle = throttle::throttle_initialize( "zm_do_score_event", 2 );
}

// Namespace points
// Params 1, eflags: 0x4
// Checksum 0x8dd5c342, Offset: 0x791
// Size: 0x1c
function private function_ec295b0954b06e3( var_953298f2bec03988 )
{
    if ( player::isinlaststand( self ) )
    {
        var_953298f2bec03988 = 1;
    }
    
    return var_953298f2bec03988;
}

// Namespace points
// Params 1
// Checksum 0x436ea653, Offset: 0x7b6
// Size: 0xdf
function on_player_damaged( params )
{
    if ( isplayer( params.victim ) )
    {
        if ( !isdefined( params.victim.no_damage_kill_count ) )
        {
            params.victim.no_damage_kill_count = 0;
        }
        
        params.victim.no_damage_kill_count = 0;
        
        if ( isai( params.eattacker ) && isalive( params.eattacker ) && ( params.eattacker.aicategory == "elite" || params.eattacker.aicategory == "hvt" ) )
        {
            params.eattacker.var_19376e76ef695878 = 1;
        }
    }
}

// Namespace points
// Params 1
// Checksum 0xad96da66, Offset: 0x89d
// Size: 0x7c
function on_player_connect( params )
{
    callback::add( "currency_add", &on_currency_add );
    callback::add( "currency_set", &on_currency_set );
    starting_essence = currency::get_start_currency_amount( #"essence" ) ?? 500;
    
    /#
        starting_essence = getdvarint( @"hash_fa72e80a5f2b2405", starting_essence );
    #/
    
    update_total_score_earned( starting_essence );
    cash::function_eb5a5549b0c6ecde( starting_essence );
    thread function_e8adbe513b8e8019();
}

// Namespace points
// Params 1, eflags: 0x4
// Checksum 0xddc8392c, Offset: 0x921
// Size: 0x4b
function private function_63008f832dff2e72( params )
{
    streakinfo = params.streakinfo;
    owner = streakinfo.owner;
    
    if ( isdefined( owner ) )
    {
        owner.elite_scorestreak_kills = 0;
    }
}

// Namespace points
// Params 1, eflags: 0x4
// Checksum 0x5f30a408, Offset: 0x974
// Size: 0x89
function private on_round_end( params )
{
    foreach ( player in level.players )
    {
        player.var_e49672a0a37fdfa0 = 0;
    }
}

// Namespace points
// Params 0
// Checksum 0x4fab7400, Offset: 0xa05
// Size: 0x50
function function_e8adbe513b8e8019()
{
    self endon( #"disconnect" );
    self.var_30f392ef3b86faf0 = 0;
    self notifyonplayercommand( "trigger_held", "+attack" );
    
    while ( true )
    {
        utility::waittill_any( "trigger_held", "weapon_change", "reload_start" );
        self.var_30f392ef3b86faf0++;
    }
}

// Namespace points
// Params 2
// Checksum 0xf6e69326, Offset: 0xa5d
// Size: 0x12f
function get_xp_override( eventstring, sweapon )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( self.b_disable_xp )
    {
        return -1;
    }
    
    if ( !isxhash( eventstring ) )
    {
        eventstring = getxhash( eventstring );
    }
    
    xp = rank::getscoreinfoxp( eventstring );
    
    if ( isdefined( xp ) && xp != 0 )
    {
        if ( !isdefined( self.var_8379371012c369d9 ) )
        {
            self.var_8379371012c369d9 = 0;
        }
        
        ekiaratio = self.var_8379371012c369d9 / level.var_caeb00173dfb20f1.ekialimit[ level.players.size - 1 ];
        xpratio = 1;
        
        if ( ekiaratio > 1 )
        {
            if ( ekiaratio < 1.25 )
            {
                xpratio *= 0.5;
            }
            else if ( ekiaratio < 1.5 )
            {
                xpratio *= 0.25;
            }
            else
            {
                xpratio *= 0.1;
            }
        }
        
        xp *= level.var_caeb00173dfb20f1.scoreevent[ level.players.size - 1 ];
        xp *= xpratio;
    }
    
    return xp;
}

// Namespace points
// Params 5
// Checksum 0x3783f3e2, Offset: 0xb95
// Size: 0xb2
function zm_modify_points( points, event, player, objweapon, eventinfo )
{
    points += bgb::function_ed911cdbb38c6719( points, event );
    var_43d6ab181b1b91e1 = player get_point_scalar();
    
    if ( !function_c17177fbb8dddf80( event ) )
    {
        points *= var_43d6ab181b1b91e1;
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_f2c6034e2393f380" ) )
    {
        points = player utility::callsharedfunc( #"zombie", #"hash_f2c6034e2393f380", eventinfo, points );
    }
    
    if ( player::isinlaststand( player ) )
    {
        points = 0;
    }
    
    return int( points );
}

// Namespace points
// Params 11
// Checksum 0x6591e48, Offset: 0xc50
// Size: 0x239
function zm_do_score_event( event, objweapon, pointsoverride, xpoverride, victim, var_ae2a12845c1ef7c1, dontwait, cankillchain, streakinfo, var_dd3dc966adfb966, eventinfo )
{
    if ( level.score_events_disabled )
    {
        return;
    }
    
    if ( level.var_2d7cc4a226f6883f )
    {
        if ( !eventinfo.var_46993e9f6a989d94 )
        {
            return;
        }
    }
    
    var_cfa475c861d98850 = utility::callsharedfunc( #"zombie", #"hash_54d8f73c6da037e3", event );
    
    if ( ( isplayer( self ) && self.var_cc1677771f64fd22 || isdefined( victim ) && victim.var_698cf8d8d4a8cbb9 ) && var_cfa475c861d98850 )
    {
        return;
    }
    
    if ( !eventinfo.var_8bcb4a2be0e18c36 && !eventinfo.var_9d1684eeabdc4400 )
    {
        if ( eventinfo.smeansofdeath == "MOD_MELEE" && isplayer( self ) && utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_m_mod", #"m_mod_closing_argument" ) )
        {
            var_b96e04e016fc7f89 = rank::getscoreinfovalue( event ) ?? 0;
            bonuspoints = level.zombie_augments[ #"m_mod_closing_argument" ].var_b27cab6c58e80e1e;
            
            if ( var_b96e04e016fc7f89 )
            {
                pointsoverride = var_b96e04e016fc7f89 + bonuspoints;
            }
            else if ( pointsoverride )
            {
                pointsoverride += bonuspoints;
            }
        }
        
        if ( eventinfo.biscritical && ( eventinfo.aicategory == "special" || eventinfo.aicategory == "elite" ) && isplayer( self ) && utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_deadshot", #"hash_a78ae5e781262788" ) )
        {
            var_b96e04e016fc7f89 = rank::getscoreinfovalue( event ) ?? 0;
            pointsoverride = var_b96e04e016fc7f89 * 2;
        }
    }
    
    thread zm_do_score_event_internal( event, objweapon, pointsoverride, xpoverride, victim, var_ae2a12845c1ef7c1, dontwait, cankillchain, streakinfo, var_dd3dc966adfb966, eventinfo );
}

// Namespace points
// Params 11, eflags: 0x4
// Checksum 0x724442c8, Offset: 0xe91
// Size: 0x218
function private zm_do_score_event_internal( event, objweapon, pointsoverride, xpoverride, victim, var_ae2a12845c1ef7c1, dontwait, cankillchain, streakinfo, var_dd3dc966adfb966, eventinfo )
{
    throttle::throttle_wait_in_queue( level.zm_do_score_event_throttle, self );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_827c38f8b953c541", 0 ) == 1 )
    {
        xpoverride = get_xp_override( event, objweapon );
    }
    
    if ( eventinfo )
    {
        if ( !objweapon || objweapon.basenamehash == %"none" )
        {
            eventinfo.var_ef32324b503188b8 = 1;
        }
    }
    
    if ( !rank::getscoreinfoxp( event ) )
    {
        xpoverride = -1;
    }
    
    doscoreevent( event, objweapon, pointsoverride, xpoverride, victim, var_ae2a12845c1ef7c1, dontwait, cankillchain, streakinfo, var_dd3dc966adfb966, eventinfo );
    
    if ( player::isinlaststand( self ) )
    {
        return;
    }
    
    current_essence = self.currency[ #"essence" ];
    current_points = zm_get_points();
    var_733f6d51657bd10b = current_points - current_essence;
    
    if ( var_733f6d51657bd10b > 0 )
    {
        if ( !isdefined( self.essencegained ) )
        {
            self.essencegained = 0;
        }
        
        self.essencegained += var_733f6d51657bd10b;
        params = spawnstruct();
        params.points = var_733f6d51657bd10b;
        params.eventinfo = eventinfo;
        callback::callback( "on_essence_gained", params );
    }
    
    update_total_score_earned( var_733f6d51657bd10b );
    self.currency[ #"essence" ] = current_points;
    self setclientomnvar( "zm_essence", zm_get_points() );
    
    if ( utility::issharedfuncdefined( #"points", #"hash_f8ef1411750d5b3c" ) )
    {
        utility::callsharedfunc( #"points", #"hash_f8ef1411750d5b3c", event, pointsoverride, objweapon, eventinfo, 1, 1 );
    }
}

// Namespace points
// Params 3
// Checksum 0xed64fe63, Offset: 0x10b1
// Size: 0x96
function zm_give_points( eventstring, points, victim )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( player::isinlaststand( self ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"points", #"zm_give_points_override" ) )
    {
        utility::callsharedfunc( #"points", #"zm_give_points_override", self, points, eventstring, undefined );
        return;
    }
    
    if ( isdefined( points ) )
    {
        points += bgb::function_ed911cdbb38c6719( points, eventstring );
    }
    
    zm_do_score_event( eventstring, undefined, points, undefined, victim, undefined, undefined, undefined, undefined, 1 );
}

// Namespace points
// Params 1
// Checksum 0x7fb24e6f, Offset: 0x114f
// Size: 0x86
function function_b660af7031bca4bd( points )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    currentpoints = gamescore::getplayerscore( self );
    
    if ( !isdefined( currentpoints ) )
    {
        currentpoints = int( 0 );
    }
    
    if ( !isdefined( points ) )
    {
        points = int( 0 );
    }
    
    points = currentpoints - points;
    
    if ( points < 0 )
    {
        points = 0;
    }
    
    gamescore::setplayerscore( self, points );
    self.currency[ #"essence" ] = zm_get_points();
    self setclientomnvar( "zm_essence", zm_get_points() );
}

// Namespace points
// Params 0
// Checksum 0x41d25855, Offset: 0x11dd
// Size: 0x2a
function zm_get_points()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    currentpoints = gamescore::getplayerscore( self );
    cash::function_eb5a5549b0c6ecde( currentpoints );
    return currentpoints;
}

// Namespace points
// Params 1
// Checksum 0xf1f09edc, Offset: 0x1210
// Size: 0xaa
function zm_add_points( points = 0 )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    currentpoints = gamescore::getplayerscore( self );
    totalpoints = int( currentpoints + points );
    function_40dc4b206b63ac2e( totalpoints );
    
    if ( !isdefined( self.essencegained ) )
    {
        self.essencegained = 0;
    }
    
    self.essencegained += points;
    update_total_score_earned( points );
    params = spawnstruct();
    params.points = points;
    callback::callback( "on_essence_gained", params );
}

// Namespace points
// Params 1
// Checksum 0x21b6c883, Offset: 0x12c2
// Size: 0x4b
function function_40dc4b206b63ac2e( points )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    gamescore::setplayerscore( self, points );
    self.currency[ #"essence" ] = zm_get_points();
    self setclientomnvar( "zm_essence", zm_get_points() );
}

// Namespace points
// Params 1, eflags: 0x4
// Checksum 0xa9c15cea, Offset: 0x1315
// Size: 0xb9
function private update_point_scalar( unused_value )
{
    scale = 1;
    valuestates = self.values[ "zm_points_scalar" ];
    
    if ( valuestates.size )
    {
        foreach ( value in valuestates )
        {
            scale *= float( value );
        }
    }
    
    self.zombie_point_scalar = scale;
}

// Namespace points
// Params 2
// Checksum 0xcb9cbefb, Offset: 0x13d6
// Size: 0x69
function set_point_scalar( value, id )
{
    if ( !isplayer( self ) )
    {
        assert( isplayer( self ), "<dev string:x24>" );
        return;
    }
    
    if ( !isdefined( id ) )
    {
        id = "default";
    }
    
    if ( value != 1 )
    {
        val::set( id, "zm_points_scalar", value );
        return;
    }
    
    val::reset( id, "zm_points_scalar" );
}

// Namespace points
// Params 0
// Checksum 0xf9449075, Offset: 0x1447
// Size: 0x3c
function get_point_scalar()
{
    if ( !isplayer( self ) )
    {
        assert( isplayer( self ), "<dev string:x51>" );
        return 1;
    }
    
    if ( isnumber( self.zombie_point_scalar ) )
    {
        return self.zombie_point_scalar;
    }
    
    return 1;
}

// Namespace points
// Params 0
// Checksum 0x2fac2ee9, Offset: 0x148c
// Size: 0x1a
function function_2b4273c6ce33f6eb()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    level.modifyunifiedpointscallback = &zm_modify_points;
}

// Namespace points
// Params 2
// Checksum 0x7e772408, Offset: 0x14ae
// Size: 0x4e
function register_on_kill_medal_callback( identifier, callback_func )
{
    if ( !isdefined( level.var_46853bb7d9038d25[ identifier ] ) )
    {
        level.var_46853bb7d9038d25[ identifier ] = [];
    }
    
    level.var_46853bb7d9038d25[ identifier ][ level.var_46853bb7d9038d25[ identifier ].size ] = callback_func;
}

// Namespace points
// Params 4
// Checksum 0x43e639dd, Offset: 0x1504
// Size: 0x18b4
function function_b4a37a41147ddca8( victim, einflictor, smeansofdeath, sweapon )
{
    if ( isdefined( self.no_damage_kill_count ) && self.no_damage_kill_count != 0 )
    {
        if ( self.no_damage_kill_count == 200 )
        {
            zm_do_score_event( #"medal_invincible" );
        }
        else if ( self.no_damage_kill_count == 100 )
        {
            zm_do_score_event( #"medal_escapeartist" );
        }
        else if ( self.no_damage_kill_count == 75 )
        {
            zm_do_score_event( #"medal_intangible" );
        }
        else if ( self.no_damage_kill_count == 50 )
        {
            zm_do_score_event( #"medal_elusive" );
        }
        else if ( self.no_damage_kill_count == 30 )
        {
            zm_do_score_event( #"medal_nimble" );
        }
        else if ( self.no_damage_kill_count == 15 )
        {
            zm_do_score_event( #"medal_jackrabbit" );
        }
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ "general" ] ) && self.rapidkill_data[ "general" ].rapidkill_count == 10 && ( !self isvehicleactive() || self isinvehicleleanout() ) )
        {
            if ( utility::issharedfuncdefined( #"sound", #"play_scoreevent_vo", 0 ) )
            {
                utility::callsharedfunc( #"sound", #"play_scoreevent_vo", self, #"bc_scoreevent_zm_multikill" );
            }
        }
        
        if ( is_rapidkill_victim( victim, "MOD_MELEE" ) && victim.rapidkill_categories[ "MOD_MELEE" ] && isdefined( self.rapidkill_data[ "MOD_MELEE" ] ) && self.rapidkill_data[ "MOD_MELEE" ].rapidkill_count != 0 )
        {
            if ( self.rapidkill_data[ "MOD_MELEE" ].rapidkill_count % 15 == 0 )
            {
                zm_do_score_event( #"hash_934604e5ebee53a5" );
            }
            else if ( self.rapidkill_data[ "MOD_MELEE" ].rapidkill_count % 10 == 0 )
            {
                zm_do_score_event( #"hash_9345ffe5ebee4b26" );
            }
            else if ( self.rapidkill_data[ "MOD_MELEE" ].rapidkill_count % 5 == 0 )
            {
                zm_do_score_event( #"hash_d586c80f3dbf32a6" );
            }
        }
        
        if ( is_rapidkill_victim( victim, "primary" ) && isdefined( self.rapidkill_data[ "primary" ] ) && self.rapidkill_data[ "primary" ].rapidkill_count != 0 )
        {
            if ( self.rapidkill_data[ "primary" ].rapidkill_count % 30 == 0 )
            {
                zm_do_score_event( #"medal_rapidkill_30" );
            }
            else if ( self.rapidkill_data[ "primary" ].rapidkill_count % 25 == 0 )
            {
                zm_do_score_event( #"medal_rapidkill_25" );
            }
            else if ( self.rapidkill_data[ "primary" ].rapidkill_count % 20 == 0 )
            {
                zm_do_score_event( #"medal_rapidkill_20" );
            }
            else if ( self.rapidkill_data[ "primary" ].rapidkill_count % 15 == 0 )
            {
                zm_do_score_event( #"medal_rapidkill_15" );
            }
            else if ( self.rapidkill_data[ "primary" ].rapidkill_count % 10 == 0 )
            {
                zm_do_score_event( #"medal_rapidkill_10" );
            }
            else if ( self.rapidkill_data[ "primary" ].rapidkill_count % 5 == 0 )
            {
                zm_do_score_event( #"medal_rapidkill_5" );
                
                if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
                {
                    utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_rapidkill_5" );
                }
            }
        }
        
        if ( is_rapidkill_victim( victim, "vehicle_crush_or_kill" ) && isdefined( self.rapidkill_data[ "vehicle_crush_or_kill" ] ) && self.rapidkill_data[ "vehicle_crush_or_kill" ].rapidkill_count != 0 )
        {
            if ( self.rapidkill_data[ "vehicle_crush_or_kill" ].rapidkill_count % 20 == 0 )
            {
                zm_do_score_event( #"medal_rapidkill_vehicle_20" );
            }
            else if ( self.rapidkill_data[ "vehicle_crush_or_kill" ].rapidkill_count % 15 == 0 )
            {
                zm_do_score_event( #"medal_rapidkill_vehicle_15" );
            }
            else if ( self.rapidkill_data[ "vehicle_crush_or_kill" ].rapidkill_count % 10 == 0 )
            {
                zm_do_score_event( #"medal_rapidkill_vehicle_10" );
            }
        }
        
        if ( is_rapidkill_victim( victim, "single_explosive_kill" ) && isdefined( self.rapidkill_data[ "single_explosive_kill" ] ) && self.rapidkill_data[ "single_explosive_kill" ].rapidkill_count != 0 )
        {
            if ( self.rapidkill_data[ "single_explosive_kill" ].rapidkill_count % 20 == 0 )
            {
                zm_do_score_event( #"hash_54f28fa9ddf9b769" );
            }
            else if ( self.rapidkill_data[ "single_explosive_kill" ].rapidkill_count % 15 == 0 )
            {
                zm_do_score_event( #"hash_54f592a9ddfbf259" );
            }
            else if ( self.rapidkill_data[ "single_explosive_kill" ].rapidkill_count % 10 == 0 )
            {
                zm_do_score_event( #"hash_54f595a9ddfbf772" );
            }
        }
        
        if ( is_rapidkill_victim( victim, "killstreak_kill" ) && isdefined( self.rapidkill_data[ "killstreak_kill" ] ) && self.rapidkill_data[ "killstreak_kill" ].rapidkill_count != 0 )
        {
            if ( self.rapidkill_data[ "killstreak_kill" ].rapidkill_count % 20 == 0 )
            {
                zm_do_score_event( #"hash_6ded9a614605c2b0" );
            }
            else if ( self.rapidkill_data[ "killstreak_kill" ].rapidkill_count % 15 == 0 )
            {
                zm_do_score_event( #"hash_6df7af61460e3ae4" );
            }
            else if ( self.rapidkill_data[ "killstreak_kill" ].rapidkill_count % 10 == 0 )
            {
                zm_do_score_event( #"hash_6df7ac61460e35cb" );
            }
        }
        
        if ( is_rapidkill_victim( victim, "elemental_kill_fire" ) && isdefined( self.rapidkill_data[ "elemental_kill_fire" ] ) && self.rapidkill_data[ "elemental_kill_fire" ].rapidkill_count != 0 )
        {
            if ( self.rapidkill_data[ "elemental_kill_fire" ].rapidkill_count % 10 == 0 )
            {
                zm_do_score_event( #"hash_1d16a90346898202" );
            }
        }
        
        if ( is_rapidkill_victim( victim, "elemental_kill_cold" ) && isdefined( self.rapidkill_data[ "elemental_kill_cold" ] ) && self.rapidkill_data[ "elemental_kill_cold" ].rapidkill_count != 0 )
        {
            if ( self.rapidkill_data[ "elemental_kill_cold" ].rapidkill_count % 10 == 0 )
            {
                zm_do_score_event( #"hash_a12b45eb4f1d0138" );
            }
        }
        
        if ( is_rapidkill_victim( victim, "elemental_kill_electrical" ) && isdefined( self.rapidkill_data[ "elemental_kill_electrical" ] ) && self.rapidkill_data[ "elemental_kill_electrical" ].rapidkill_count != 0 )
        {
            if ( self.rapidkill_data[ "elemental_kill_electrical" ].rapidkill_count % 10 == 0 )
            {
                zm_do_score_event( #"hash_deefad4fef3853c" );
            }
        }
        
        if ( is_rapidkill_victim( victim, "elemental_kill_toxic" ) && isdefined( self.rapidkill_data[ "elemental_kill_toxic" ] ) && self.rapidkill_data[ "elemental_kill_toxic" ].rapidkill_count != 0 )
        {
            if ( self.rapidkill_data[ "elemental_kill_toxic" ].rapidkill_count % 10 == 0 )
            {
                zm_do_score_event( #"hash_2d04f4b7c3b707" );
            }
        }
        
        if ( is_rapidkill_victim( victim, "burn_kill" ) && isdefined( self.rapidkill_data[ "burn_kill" ] ) && self.rapidkill_data[ "burn_kill" ].rapidkill_count == 5 )
        {
            zm_do_score_event( #"medal_immolate" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_immolate" );
            }
        }
        
        if ( is_rapidkill_victim( victim, "freeze_kill" ) && isdefined( self.rapidkill_data[ "freeze_kill" ] ) && self.rapidkill_data[ "freeze_kill" ].rapidkill_count == 5 )
        {
            zm_do_score_event( #"medal_glaciate" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_glaciate" );
            }
        }
        
        if ( is_rapidkill_victim( victim, "electrocuted_kill" ) && isdefined( self.rapidkill_data[ "electrocuted_kill" ] ) && self.rapidkill_data[ "electrocuted_kill" ].rapidkill_count == 5 )
        {
            zm_do_score_event( #"medal_voltaic" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_voltaic" );
            }
        }
        
        if ( is_rapidkill_victim( victim, "multielement_kill" ) && isdefined( self.rapidkill_data[ "multielement_kill" ] ) && self.rapidkill_data[ "multielement_kill" ].rapidkill_count == 5 )
        {
            zm_do_score_event( #"medal_alchemist" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_alchemist" );
            }
        }
        
        if ( is_rapidkill_victim( victim, "decoy_grenade" ) && isdefined( self.rapidkill_data[ "decoy_grenade" ] ) && self.rapidkill_data[ "decoy_grenade" ].rapidkill_count == 5 )
        {
            zm_do_score_event( #"medal_fakeout" );
        }
        
        if ( is_rapidkill_victim( victim, "combataxe" ) && isdefined( self.rapidkill_data[ "combataxe" ] ) && self.rapidkill_data[ "combataxe" ].rapidkill_count == 3 )
        {
            zm_do_score_event( #"medal_choppedup" );
        }
        
        if ( is_rapidkill_victim( victim, "adrenaline_or_self_revive" ) && isdefined( self.rapidkill_data[ "adrenaline_or_self_revive" ] ) && self.rapidkill_data[ "adrenaline_or_self_revive" ].rapidkill_count == 5 )
        {
            zm_do_score_event( #"medal_adrenalinerush" );
        }
        
        if ( isdefined( self.rapidkill_data[ "critical" ] ) && self.rapidkill_data[ "critical" ].rapidkill_count != 0 )
        {
            if ( isdefined( victim.last_dmg_struct ) && victim.last_dmg_struct.biscritical )
            {
                if ( isdefined( self.rapidkill_data[ "critical" ] ) && self.rapidkill_data[ "critical" ].rapidkill_count % 20 == 0 )
                {
                    zm_do_score_event( #"medal_headhunter" );
                }
                else if ( isdefined( self.rapidkill_data[ "critical" ] ) && self.rapidkill_data[ "critical" ].rapidkill_count % 5 == 0 )
                {
                    zm_do_score_event( #"medal_deadeye" );
                }
            }
            else
            {
                if ( isdefined( sweapon ) )
                {
                    callback::callback( "on_rapid_kill_end", { #rapidkill_weapon:sweapon, #rapidkill_count:self.rapidkill_data[ "critical" ].rapidkill_count, #rapidkill_type:"critical", #player:self } );
                }
                
                self.rapidkill_data[ "critical" ].rapidkill_count = 0;
            }
        }
        
        if ( is_rapidkill_victim( victim, "MOD_UNKNOWN" ) && self.rapidkill_data[ "MOD_UNKNOWN" ] && self.rapidkill_data[ "MOD_UNKNOWN" ].weapon.var_1616e6fbba9a722d == %"mary_paris" )
        {
            if ( self.rapidkill_data[ "MOD_UNKNOWN" ].rapidkill_count == 10 )
            {
                zm_do_score_event( #"medal_rapidkill_mary_paris_10" );
            }
            
            params = { #highest_multi_kills:1, #stats:"kills", #inflictor:einflictor, #ref:"super_mary_paris", #field_upgrade:"mary_paris", #victim:victim, #player:self };
            callback::callback( "on_field_upgrade_kill_track", params );
        }
        
        if ( is_rapidkill_victim( victim, "MOD_ELEMENTAL_DARK" ) && self.rapidkill_data[ "MOD_ELEMENTAL_DARK" ] && self.rapidkill_data[ "MOD_ELEMENTAL_DARK" ].weapon.var_1616e6fbba9a722d == %"mary_paris" )
        {
            params = { #highest_multi_kills:1, #stats:"kills", #inflictor:einflictor, #ref:"super_mary_paris", #field_upgrade:"mary_paris", #victim:victim, #player:self };
            callback::callback( "on_field_upgrade_kill_track", params );
        }
    }
    
    if ( sweapon.type == "bullet" )
    {
        if ( !isdefined( self.var_b1c4c1650be1aff5 ) )
        {
            self.var_b1c4c1650be1aff5 = 0;
        }
        
        if ( self.var_b1c4c1650be1aff5 == 0 )
        {
            thread function_3914e7e937b3fd9b();
        }
        
        self.var_b1c4c1650be1aff5++;
        
        if ( self.var_b1c4c1650be1aff5 % 3 == 0 )
        {
            zm_do_score_event( #"medal_excessiveforce" );
        }
    }
    
    if ( sweapon.type == "grenade" && is_lethal_equipment_explosive( sweapon ) && isdefined( einflictor.birthtime ) )
    {
        if ( !isdefined( self.var_e5f71cd185c0c552 ) )
        {
            self.var_e5f71cd185c0c552 = [];
        }
        
        if ( !isdefined( self.var_e5f71cd185c0c552[ einflictor.birthtime ] ) )
        {
            self.var_e5f71cd185c0c552[ einflictor.birthtime ] = 0;
        }
        
        victim.is_lethal_or_super_kill = 1;
        
        if ( self.var_e5f71cd185c0c552[ einflictor.birthtime ] == 0 )
        {
            thread function_90a02e964e5bdd73( einflictor.birthtime, einflictor.birthtime != 0 ? 15 : 0.1 );
        }
        
        self.var_e5f71cd185c0c552[ einflictor.birthtime ]++;
        
        if ( self.var_e5f71cd185c0c552[ einflictor.birthtime ] == 5 )
        {
            zm_do_score_event( #"medal_popcorn" );
        }
        else if ( self.var_e5f71cd185c0c552[ einflictor.birthtime ] == 10 )
        {
            zm_do_score_event( #"medal_fulmination" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_fulmination" );
            }
        }
    }
    
    if ( sweapon.type == "grenade" && is_lethal_equipment_fire( sweapon ) && isdefined( einflictor.birthtime ) )
    {
        if ( !isdefined( self.var_e5f71cd185c0c552 ) )
        {
            self.var_e5f71cd185c0c552 = [];
        }
        
        if ( !isdefined( self.var_e5f71cd185c0c552[ einflictor.birthtime ] ) )
        {
            self.var_e5f71cd185c0c552[ einflictor.birthtime ] = 0;
        }
        
        victim.is_lethal_or_super_kill = 1;
        
        if ( self.var_e5f71cd185c0c552[ einflictor.birthtime ] == 0 )
        {
            thread function_90a02e964e5bdd73( einflictor.birthtime, einflictor.birthtime != 0 ? 15 : 0.1 );
        }
        
        self.var_e5f71cd185c0c552[ einflictor.birthtime ]++;
        
        if ( self.var_e5f71cd185c0c552[ einflictor.birthtime ] == 5 )
        {
            zm_do_score_event( #"medal_crispy" );
        }
    }
    
    if ( isdefined( victim.var_1c715bf5ac0aa638 ) && victim effect_stun::function_715dc69554c2d9ed( self, function_2f5082d7ee39b1dc( "equip_concussion" ) ) )
    {
        killstruct = function_a2de091492bdc588( victim.var_1c715bf5ac0aa638 );
        victim.is_tatical_kill = 1;
        
        if ( killstruct.kills == 5 )
        {
            zm_do_score_event( #"medal_finished" );
        }
    }
    
    if ( ( victim.aicategory == "elite" || victim.aicategory == "hvt" ) && !victim.var_19376e76ef695878 )
    {
        zm_do_score_event( #"medal_untouchable" );
    }
    
    if ( !( sweapon.type == "grenade" ) && isexplosivedamagemod( smeansofdeath ) )
    {
        if ( !isdefined( self.var_a4706024e14471d4 ) )
        {
            self.var_a4706024e14471d4 = 0;
        }
        
        if ( self.var_a4706024e14471d4 == 0 )
        {
            thread function_50b64498ccdb39df();
        }
        
        self.var_a4706024e14471d4++;
        
        if ( self.var_a4706024e14471d4 % 10 == 0 )
        {
            zm_do_score_event( #"medal_bigbang" );
        }
    }
    
    if ( victim.aicategory == "special" && ( smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" || smeansofdeath == "MOD_PROJECTILE" ) )
    {
        if ( !isdefined( self.special_kill_count ) )
        {
            self.special_kill_count = 0;
        }
        
        if ( self.special_kill_count == 0 )
        {
            thread function_222a50b1363f46b9();
        }
        
        self.special_kill_count++;
        
        if ( self.special_kill_count % 2 == 0 )
        {
            zm_do_score_event( #"medal_biggame" );
        }
    }
    
    if ( isdefined( victim.var_e7352aa874d3a581 ) && victim.var_e7352aa874d3a581.owner === self )
    {
        if ( !isdefined( self.var_e5f71cd185c0c552 ) )
        {
            self.var_e5f71cd185c0c552 = [];
        }
        
        if ( !isdefined( self.var_e5f71cd185c0c552[ einflictor.birthtime ] ) )
        {
            self.var_e5f71cd185c0c552[ einflictor.birthtime ] = 0;
        }
        
        victim.is_tatical_kill = 1;
        
        if ( self.var_e5f71cd185c0c552[ einflictor.birthtime ] == 0 )
        {
            thread function_90a02e964e5bdd73( einflictor.birthtime, 5 );
        }
        
        self.var_e5f71cd185c0c552[ einflictor.birthtime ]++;
        
        if ( self.var_e5f71cd185c0c552[ einflictor.birthtime ] == 5 )
        {
            zm_do_score_event( #"medal_wattchout" );
        }
    }
    
    if ( isdefined( self.smoke_end_time ) )
    {
        if ( !isdefined( self.smoke_kills ) )
        {
            self.smoke_kills = 0;
        }
        
        self.smoke_kills++;
        
        if ( self.smoke_kills == 5 )
        {
            zm_do_score_event( #"medal_smokedout" );
        }
    }
    
    if ( supers_mp::function_f863d9ef10bf403f() )
    {
        if ( !isdefined( self.var_e664d7be9393c8ee ) )
        {
            self.var_e664d7be9393c8ee = 0;
        }
        
        if ( self.var_e664d7be9393c8ee == 0 )
        {
            thread super_kills_watcher();
        }
        
        self.var_e664d7be9393c8ee++;
        
        if ( self.var_e664d7be9393c8ee == 20 )
        {
            zm_do_score_event( #"medal_fullycharged" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_fullycharged" );
            }
        }
    }
    
    if ( isdefined( level.var_46853bb7d9038d25[ victim.animsetname ] ) )
    {
        foreach ( callback in level.var_46853bb7d9038d25[ victim.animsetname ] )
        {
            self [[ callback ]]( victim, einflictor, smeansofdeath, sweapon );
        }
    }
    
    if ( isdefined( level.var_46853bb7d9038d25[ sweapon.basename ] ) )
    {
        foreach ( callback in level.var_46853bb7d9038d25[ sweapon.basename ] )
        {
            self [[ callback ]]( victim, einflictor, smeansofdeath, sweapon );
        }
    }
    
    if ( isdefined( level.var_46853bb7d9038d25[ sweapon.basenamehash ] ) )
    {
        foreach ( callback in level.var_46853bb7d9038d25[ sweapon.basenamehash ] )
        {
            self [[ callback ]]( victim, einflictor, smeansofdeath, sweapon );
        }
    }
    
    level callback::callback( #"on_ai_killed_medal", { #sweapon:sweapon, #smeansofdeath:smeansofdeath, #victim:victim, #attacker:self } );
    
    if ( victim.is_tatical_kill )
    {
        track_rapidkill( "tatical_kill" );
        
        if ( isdefined( self.rapidkill_data[ "tatical_kill" ] ) && self.rapidkill_data[ "tatical_kill" ].rapidkill_count == 10 )
        {
            zm_do_score_event( #"medal_symphonicdeath" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_symphonicdeath" );
            }
        }
    }
    
    if ( victim.is_lethal_or_super_kill )
    {
        track_rapidkill( "lethal_or_super_kill" );
        
        if ( isdefined( self.rapidkill_data[ "lethal_or_super_kill" ] ) && self.rapidkill_data[ "lethal_or_super_kill" ].rapidkill_count == 20 )
        {
            zm_do_score_event( #"medal_bombingrun" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_bombingrun" );
            }
        }
    }
}

// Namespace points
// Params 0, eflags: 0x4
// Checksum 0x59d71d4b, Offset: 0x2dc0
// Size: 0x1a
function private function_50b64498ccdb39df()
{
    wait 0.05;
    
    if ( isplayer( self ) )
    {
        self.var_a4706024e14471d4 = 0;
    }
}

// Namespace points
// Params 0, eflags: 0x4
// Checksum 0x5a29b4f7, Offset: 0x2de2
// Size: 0x1a
function private function_222a50b1363f46b9()
{
    wait 0.05;
    
    if ( isplayer( self ) )
    {
        self.special_kill_count = 0;
    }
}

// Namespace points
// Params 0, eflags: 0x4
// Checksum 0x89eeeef7, Offset: 0x2e04
// Size: 0x1a
function private function_3914e7e937b3fd9b()
{
    wait 0.05;
    
    if ( isplayer( self ) )
    {
        self.var_b1c4c1650be1aff5 = 0;
    }
}

// Namespace points
// Params 2, eflags: 0x4
// Checksum 0x866f94b2, Offset: 0x2e26
// Size: 0x29
function private function_90a02e964e5bdd73( grenadeid, waittime )
{
    wait waittime;
    
    if ( isdefined( self ) )
    {
        self.var_e5f71cd185c0c552[ grenadeid ] = undefined;
    }
}

// Namespace points
// Params 2, eflags: 0x4
// Checksum 0x3add3c31, Offset: 0x2e57
// Size: 0x1bd
function private function_b1c028fc147828d1( scorestreak_type, victim )
{
    if ( !isdefined( self.var_e49672a0a37fdfa0 ) )
    {
        self.var_e49672a0a37fdfa0 = 0;
    }
    
    self.var_e49672a0a37fdfa0++;
    
    if ( self.var_e49672a0a37fdfa0 == 50 )
    {
        zm_do_score_event( #"medal_fireaway" );
        
        if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
        {
            utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_fireaway" );
        }
    }
    
    if ( isdefined( self.rapidkill_data ) )
    {
        if ( isdefined( self.rapidkill_data[ scorestreak_type ] ) && self.rapidkill_data[ scorestreak_type ].rapidkill_count === 30 )
        {
            zm_do_score_event( #"medal_obliterator" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_obliterator" );
            }
        }
    }
    
    if ( victim.aicategory == "elite" || victim.aicategory == "hvt" )
    {
        if ( !isdefined( self.elite_scorestreak_kills ) )
        {
            self.elite_scorestreak_kills = 0;
        }
        
        self.elite_scorestreak_kills++;
        
        if ( self.elite_scorestreak_kills == 2 )
        {
            zm_do_score_event( #"medal_scorchedearth" );
            
            if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
            {
                utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_scorchedearth" );
            }
        }
    }
}

// Namespace points
// Params 1
// Checksum 0xf84d937e, Offset: 0x301c
// Size: 0x90
function function_2f5082d7ee39b1dc( equip_ref )
{
    if ( !isdefined( level.var_fb5c3ce05700d57f ) )
    {
        level.var_fb5c3ce05700d57f = [];
    }
    
    if ( !isdefined( level.var_fb5c3ce05700d57f[ equip_ref ] ) )
    {
        if ( isdefined( level.equipment.table[ equip_ref ].weaponname ) )
        {
            level.var_fb5c3ce05700d57f[ equip_ref ] = level.equipment.table[ equip_ref ].weaponname;
        }
    }
    
    return level.var_fb5c3ce05700d57f[ equip_ref ];
}

// Namespace points
// Params 1, eflags: 0x4
// Checksum 0x2123d7d4, Offset: 0x30b5
// Size: 0x8f, Type: bool
function private is_lethal_equipment_explosive( sweapon )
{
    return sweapon.basename === function_2f5082d7ee39b1dc( "equip_frag" ) || sweapon.basename === function_2f5082d7ee39b1dc( "equip_ied" ) || sweapon.basename === function_2f5082d7ee39b1dc( "equip_impact_grenade" ) || sweapon.basename === function_2f5082d7ee39b1dc( "equip_semtex" ) || sweapon.basename === function_2f5082d7ee39b1dc( "equip_c4" );
}

// Namespace points
// Params 1, eflags: 0x4
// Checksum 0x8751e5ad, Offset: 0x314d
// Size: 0x3e, Type: bool
function private is_lethal_equipment_fire( sweapon )
{
    return sweapon.basename === function_2f5082d7ee39b1dc( "equip_molotov" ) || sweapon.basename === function_2f5082d7ee39b1dc( "equip_thermobaric_grenade" );
}

// Namespace points
// Params 1, eflags: 0x4
// Checksum 0x12ca27ce, Offset: 0x3194
// Size: 0xed
function private function_a2de091492bdc588( vpoint )
{
    if ( !isdefined( self.var_189e4af2b5e04821 ) )
    {
        self.var_189e4af2b5e04821 = [];
    }
    
    foreach ( kill_struct in self.var_189e4af2b5e04821 )
    {
        if ( kill_struct.vpoint == vpoint )
        {
            kill_struct.kills++;
            return kill_struct;
        }
    }
    
    kill_struct = { #kills:1, #vpoint:vpoint };
    thread concussion_kill_watcher( vpoint );
    self.var_189e4af2b5e04821[ self.var_189e4af2b5e04821.size ] = kill_struct;
    return kill_struct;
}

// Namespace points
// Params 1, eflags: 0x4
// Checksum 0x23f73fbd, Offset: 0x328a
// Size: 0x8c
function private concussion_kill_watcher( vpoint )
{
    self endon( #"disconnect" );
    wait 5;
    
    if ( isdefined( self.var_189e4af2b5e04821.size ) )
    {
        for ( i = 0; i < self.var_189e4af2b5e04821.size ; i++ )
        {
            if ( self.var_189e4af2b5e04821[ i ].vpoint == vpoint )
            {
                self.var_189e4af2b5e04821[ i ] = undefined;
                
                if ( isint( i ) )
                {
                    function_cdc669dbc8ea2101( self.var_189e4af2b5e04821 );
                }
                
                return;
            }
        }
    }
}

// Namespace points
// Params 0, eflags: 0x4
// Checksum 0x888825d, Offset: 0x331e
// Size: 0x25
function private super_kills_watcher()
{
    self endon( #"death_or_disconnect" );
    self waittill( #"super_use_finished_lb" );
    self.var_e664d7be9393c8ee = 0;
}

// Namespace points
// Params 1
// Checksum 0x8729eb3b, Offset: 0x334b
// Size: 0xdb
function rapidkillmonitor( rapidkill_type )
{
    self notify( rapidkill_type + "recent_zombie_rapid_kill" );
    self endon( rapidkill_type + "recent_zombie_rapid_kill" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 2;
    callback::callback( "on_rapid_kill_end", { #rapidkill_weapon:self.rapidkill_data[ rapidkill_type ].weapon, #rapidkill_count:self.rapidkill_data[ rapidkill_type ].rapidkill_count, #rapidkill_type:rapidkill_type, #player:self } );
    
    if ( isdefined( self.rapidkill_data[ rapidkill_type ] ) )
    {
        self.rapidkill_data[ rapidkill_type ].rapidkill_count = 0;
        self.rapidkill_data[ rapidkill_type ].weapon = undefined;
    }
}

// Namespace points
// Params 3
// Checksum 0x53b06e8b, Offset: 0x342e
// Size: 0x162
function track_rapidkill( rapidkill_type, sweapon, victim )
{
    if ( !isdefined( self.rapidkill_data[ rapidkill_type ] ) )
    {
        self.rapidkill_data[ rapidkill_type ] = spawnstruct();
    }
    
    if ( !isdefined( self.rapidkill_data[ rapidkill_type ].rapidkill_count ) )
    {
        self.rapidkill_data[ rapidkill_type ].rapidkill_count = 0;
    }
    
    if ( isdefined( sweapon ) )
    {
        if ( !isdefined( self.rapidkill_data[ rapidkill_type ].weapon ) )
        {
            self.rapidkill_data[ rapidkill_type ].weapon = sweapon;
        }
        else if ( self.rapidkill_data[ rapidkill_type ].weapon != sweapon )
        {
            self.rapidkill_data[ rapidkill_type ].rapidkill_count = 0;
            return;
        }
    }
    
    if ( victim )
    {
        victim.rapidkill_categories[ rapidkill_type ] = 1;
    }
    
    self.rapidkill_data[ rapidkill_type ].rapidkill_count++;
    callback::callback( "on_rapid_kill_counted", { #weapon:sweapon, #rapidkill_count:self.rapidkill_data[ rapidkill_type ].rapidkill_count, #rapidkill_type:rapidkill_type, #player:self } );
    thread rapidkillmonitor( rapidkill_type );
}

// Namespace points
// Params 2
// Checksum 0xf0a6982b, Offset: 0x3598
// Size: 0x24, Type: bool
function is_rapidkill_victim( victim, rapidkill_type )
{
    return istrue( victim.rapidkill_categories[ rapidkill_type ] );
}

// Namespace points
// Params 1
// Checksum 0xdb64d71c, Offset: 0x35c5
// Size: 0x66, Type: bool
function is_killstreak_weapons( sweapon )
{
    return isdefined( sweapon ) && isdefined( sweapon.basename ) && ( issubstr( sweapon.basename, "cluster_spike" ) || issubstr( sweapon.basename, "toma_proj" ) || issubstr( sweapon.basename, "artillery_mp" ) );
}

// Namespace points
// Params 1
// Checksum 0xa967639d, Offset: 0x3634
// Size: 0xde, Type: bool
function is_field_upgrade_weapons( sweapon )
{
    var_24b1dba23ae30495 = [ %"energy_mine", %"tesla_storm", %"frost_blast" ];
    
    if ( isdefined( sweapon ) )
    {
        foreach ( field_upgrade in var_24b1dba23ae30495 )
        {
            if ( isdefined( level.weaponmetadata[ field_upgrade ] ) && level.weaponmetadata[ field_upgrade ].weaponobj == sweapon )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace points
// Params 3
// Checksum 0xc5b8c57c, Offset: 0x371b
// Size: 0x171
function zm_get_weapon_element( objweapon, eattacker, smeansofdeath )
{
    element = "none";
    root_weapon_string = objweapon.var_1616e6fbba9a722d;
    
    if ( isplayer( eattacker ) && level.ammo_mods_in_use && eattacker namespace_9d8e359c3b1041e5::function_f3b72bf1c0b8c737( objweapon ) )
    {
        ammomod_name = eattacker namespace_9d8e359c3b1041e5::function_30cd19b8533d27d2( objweapon );
        
        if ( isdefined( level.ammo_mods[ ammomod_name ].element ) )
        {
            element = level.ammo_mods[ ammomod_name ].element;
        }
    }
    else
    {
        weaponbundle = undefined;
        
        if ( isdefined( level.weaponmetadata ) )
        {
            weaponbundle = level.weaponmetadata[ root_weapon_string ];
        }
        
        if ( isdefined( weaponbundle.elementdamagetype ) )
        {
            element = weaponbundle.elementdamagetype;
        }
    }
    
    if ( isdefined( smeansofdeath ) )
    {
        if ( smeansofdeath == "MOD_FIRE" || smeansofdeath == "MOD_ELEMENTAL_FIRE" )
        {
            element = "fire";
        }
        
        if ( smeansofdeath == "MOD_ELEMENTAL_ELEC" )
        {
            element = "electrical";
        }
        
        if ( smeansofdeath == "MOD_ELEMENTAL_COLD" )
        {
            element = "cold";
        }
        
        if ( smeansofdeath == "MOD_ELEMENTAL_TOXIC" )
        {
            element = "toxic";
        }
        
        if ( smeansofdeath == "MOD_ELEMENTAL_DARK" )
        {
            element = "dark";
        }
        
        if ( smeansofdeath == "MOD_ELEMENTAL_LIGHT" )
        {
            element = "light";
        }
    }
    
    return element;
}

// Namespace points
// Params 1
// Checksum 0xca932b51, Offset: 0x3895
// Size: 0xb4
function on_currency_add( sparams )
{
    if ( isdefined( sparams.amount ) && isdefined( sparams.currencytype ) )
    {
        if ( sparams.currencytype == #"essence" )
        {
            update_total_score_earned( sparams.amount );
            return;
        }
        
        if ( sparams.currencytype == #"salvage" )
        {
            stats::setextrascore4( int( self.currency[ #"salvage" ] / 10 ) );
            return;
        }
        
        stats::function_fe615555f60e88b9( int( self.currency[ #"rare_salvage" ] / 10 ) );
    }
}

// Namespace points
// Params 1
// Checksum 0x16198801, Offset: 0x3951
// Size: 0x10d
function on_currency_set( sparams )
{
    if ( sparams.originalamount < sparams.amount && sparams.currencytype == #"essence" )
    {
        increasedamount = sparams.amount - sparams.originalamount;
        update_total_score_earned( increasedamount );
    }
    
    if ( isdefined( sparams.originalamount ) && isdefined( sparams.amount ) && isdefined( sparams.currencytype ) )
    {
        if ( sparams.currencytype == #"salvage" )
        {
            stats::setextrascore4( int( self.currency[ #"salvage" ] / 10 ) );
            return;
        }
        
        if ( sparams.currencytype == #"rare_salvage" )
        {
            stats::function_fe615555f60e88b9( int( self.currency[ #"rare_salvage" ] / 10 ) );
        }
    }
}

// Namespace points
// Params 1
// Checksum 0x15a239e7, Offset: 0x3a66
// Size: 0x6b
function update_total_score_earned( increment )
{
    if ( level.var_6895525f56448bd5 )
    {
        return;
    }
    
    if ( !isdefined( self.total_score_earned ) )
    {
        self.total_score_earned = 0;
    }
    
    self.total_score_earned += increment;
    stats::setextrascore0( self.total_score_earned & 65535 );
    stats::setextrascore1( self.total_score_earned >> 16 );
}

// Namespace points
// Params 1, eflags: 0x4
// Checksum 0x1653895b, Offset: 0x3ad9
// Size: 0x36, Type: bool
function private function_c17177fbb8dddf80( event )
{
    if ( isdefined( level.var_42c8bc93899add1b ) && isdefined( event ) && arraycontains( level.var_42c8bc93899add1b, event ) )
    {
        return true;
    }
    
    return false;
}

// Namespace points
// Params 1
// Checksum 0x79812a25, Offset: 0x3b18
// Size: 0x39
function function_e2608820bbea3a5c( event )
{
    if ( !isdefined( level.var_42c8bc93899add1b ) )
    {
        level.var_42c8bc93899add1b = [];
    }
    
    level.var_42c8bc93899add1b[ level.var_42c8bc93899add1b.size ] = event;
}

