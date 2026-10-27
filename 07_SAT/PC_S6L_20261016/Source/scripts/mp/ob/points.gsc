// scripts\mp\ob\points.gsc  (hash_2ffe6b9e7733fa59.gscc) (size: 19792 Bytes / 0x4d50 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa1a84c58 (2712161368)
// size ...... 19792 (0x4d50)
// includes .. 16  (offset: 0x47c0)
// strings ... 71  (offset: 0x4840)
// dev strs .. 7   (offset: 0x4cdc)
// exports ... 48  (offset: 0x32dc)
// cseg ...... 0x565 + 0x2d77 (0x32dc)
// imports ... 99  (offset: 0x3a5c)
// animtree1 . 0   (offset: 0x4d50)
// animtree2 . 0   (offset: 0x4d50)
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\ai\ai_category;
#using scripts\mp\cash;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\currency;
#using scripts\mp\equipment;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\ob;
#using scripts\mp\rank;
#using scripts\mp\supers;

#namespace points;

// Namespace points
// Params 0
// Checksum 0xe30c7ab7, Offset: 0x583
// Size: 0x130
function init()
{
    utility::registersharedfunc( #"points", #"get_points", &ob_get_points );
    utility::registersharedfunc( #"points", #"set_points", &function_5ec07217e48081ca );
    utility::registersharedfunc( #"points", #"take_points", &function_da2d936f7db411e1 );
    utility::registersharedfunc( #"points", #"add_points", &ob_add_points );
    utility::registersharedfunc( #"ob", #"getweaponelement", &ob_get_weapon_element );
    level.modifyunifiedpointscallback = &ob_modify_points;
    level.var_2365b76f19ea37ea = &function_92b70ecfc2f8e086;
    level callback::add( #"on_ai_killed", &ob_event_on_ai_killed );
    level callback::add( "zombie_score_event", &ob_score_event );
    level callback::add( #"player_connect", &on_player_connect );
    level callback::add( #"player_damaged", &on_player_damaged );
    level callback::add( "lootcache_looted", &on_loot_cache_used );
    level callback::add( #"hash_5f04bed91965f0ec", &function_32f6d601e5c468c4 );
}

// Namespace points
// Params 1
// Checksum 0x26248ead, Offset: 0x6bb
// Size: 0x5e
function on_loot_cache_used( params )
{
    if ( isdefined( params.cacheinstance ) && isdefined( params.cacheinstance.type ) && !params.cacheinstance.openedbefore )
    {
        ob_do_score_event( #"container_looted" );
    }
}

// Namespace points
// Params 1
// Checksum 0xc326ca49, Offset: 0x721
// Size: 0x64
function on_player_damaged( params )
{
    if ( isplayer( params.victim ) )
    {
        if ( !isdefined( params.victim.no_damage_kill_count ) )
        {
            params.victim.no_damage_kill_count = 0;
        }
        
        params.victim.no_damage_kill_count = 0;
    }
}

// Namespace points
// Params 1
// Checksum 0x1782065e, Offset: 0x78d
// Size: 0x4e
function on_player_connect( params )
{
    starting_essence = currency::get_start_currency_amount( #"essence" ) ?? 0;
    currency::init_player_currency( #"essence", starting_essence );
    callback::add( "safe_opened_nearby", &function_5639eeb7622665fe );
}

// Namespace points
// Params 1
// Checksum 0x2f4868a1, Offset: 0x7e3
// Size: 0x1c
function function_5639eeb7622665fe( sparams )
{
    ob_do_score_event( #"dmz_safe_opened" );
}

// Namespace points
// Params 2
// Checksum 0xd83969d5, Offset: 0x807
// Size: 0x70
function get_xp_override( eventstring, sweapon )
{
    if ( !isxhash( eventstring ) )
    {
        eventstring = getxhash( eventstring );
    }
    
    xp = rank::getscoreinfoxp( eventstring );
    
    if ( isdefined( xp ) && isdefined( self.var_cbb73538dc6fd584 ) )
    {
        xp = int( xp * self.var_cbb73538dc6fd584 );
    }
    
    if ( isdefined( xp ) && xp != 0 )
    {
    }
    
    return xp;
}

// Namespace points
// Params 5
// Checksum 0xf52089b0, Offset: 0x880
// Size: 0x3b
function ob_modify_points( points, event, player, objweapon, eventinfo )
{
    return points * player get_point_scalar();
}

// Namespace points
// Params 7
// Checksum 0x9c37334e, Offset: 0x8c4
// Size: 0x104
function ob_do_score_event( scoreevent, sweapon, var_f7625c598d91b359 = 0, reason = #"none", var_6e4cf71db6f03963 = undefined, var_e2f650bcd8419ea7 = undefined, victim = undefined )
{
    obsettings = ob::get_ob_settings();
    
    if ( !isplayer( self ) || !obsettings.var_3f60cda910ca643f && player::isinlaststand( self ) && !var_f7625c598d91b359 )
    {
        return;
    }
    
    if ( !isdefined( var_e2f650bcd8419ea7 ) )
    {
        var_e2f650bcd8419ea7 = get_xp_override( scoreevent, sweapon );
    }
    
    doscoreevent( scoreevent, sweapon, var_6e4cf71db6f03963, var_e2f650bcd8419ea7, victim, undefined, undefined, undefined, undefined, 1 );
    essence = ob_get_points();
    currency::set_currency_amount( #"essence", essence, reason );
    self setclientomnvar( "zm_essence", essence );
}

// Namespace points
// Params 3
// Checksum 0x1145a8fd, Offset: 0x9d0
// Size: 0x7d
function ob_give_points( eventstring, points, victim )
{
    if ( !isplayer( self ) || player::isinlaststand( self ) )
    {
        return;
    }
    
    doscoreevent( eventstring, undefined, points, undefined, victim, undefined, undefined, undefined, undefined, 1 );
    essence = ob_get_points();
    self.currency[ #"essence" ] = essence;
    self setclientomnvar( "zm_essence", essence );
}

// Namespace points
// Params 1
// Checksum 0xbfca3599, Offset: 0xa55
// Size: 0x6c
function function_da2d936f7db411e1( points )
{
    currentpoints = gamescore::getplayerscore( self );
    points = currentpoints - points;
    
    if ( points < 0 )
    {
        points = 0;
    }
    
    gamescore::setplayerscore( self, points );
    essence = ob_get_points();
    self.currency[ #"essence" ] = essence;
    self setclientomnvar( "zm_essence", essence );
}

// Namespace points
// Params 0
// Checksum 0x2a28496e, Offset: 0xac9
// Size: 0x1a
function function_66253092b6523c6d()
{
    self.var_533b3f9efca831cd = gamescore::getplayerscore( self );
    function_5ec07217e48081ca( 0 );
}

// Namespace points
// Params 0
// Checksum 0x125861a8, Offset: 0xaeb
// Size: 0x21
function function_3d419d8542442d64()
{
    if ( !isdefined( self.var_533b3f9efca831cd ) )
    {
        return;
    }
    
    function_5ec07217e48081ca( self.var_533b3f9efca831cd );
}

// Namespace points
// Params 0
// Checksum 0xe3092952, Offset: 0xb14
// Size: 0x20
function ob_get_points()
{
    currentpoints = gamescore::getplayerscore( self );
    cash::function_eb5a5549b0c6ecde( currentpoints );
    return currentpoints;
}

// Namespace points
// Params 1
// Checksum 0x5b0f335d, Offset: 0xb3d
// Size: 0x36
function ob_add_points( points )
{
    currentpoints = gamescore::getplayerscore( self );
    totalpoints = currentpoints + points;
    function_5ec07217e48081ca( totalpoints );
}

// Namespace points
// Params 1
// Checksum 0xb24ff924, Offset: 0xb7b
// Size: 0x7f
function function_5ec07217e48081ca( points )
{
    if ( points > 999999 )
    {
        println( "<dev string:x24>" + points + "<dev string:x48>" + 999999 + "<dev string:x8c>" );
        points = 999999;
    }
    
    gamescore::setplayerscore( self, points );
    essence = ob_get_points();
    self.currency[ #"essence" ] = essence;
    self setclientomnvar( "zm_essence", essence );
}

// Namespace points
// Params 1
// Checksum 0x36e29fc3, Offset: 0xc02
// Size: 0x29
function set_point_scalar( value )
{
    assert( isplayer( self ), "<dev string:x8e>" );
    self.zombie_point_scalar = value;
}

// Namespace points
// Params 0
// Checksum 0x80236bde, Offset: 0xc33
// Size: 0x30
function get_point_scalar()
{
    assert( isplayer( self ), "<dev string:xbb>" );
    
    if ( isnumber( self.zombie_point_scalar ) )
    {
        return self.zombie_point_scalar;
    }
    
    return 1;
}

// Namespace points
// Params 2
// Checksum 0x90032611, Offset: 0xc6c
// Size: 0x163
function function_47dc9b24caa6ae1f( base_kia, var_9b672797eb3d6743 )
{
    switch ( base_kia )
    {
        case #"hash_12321caf6868c4":
        case #"hash_e1bee4c99e310fb":
        case #"zombie_kia_special":
        case #"vermin_kia":
        case #"mangler_kia":
        case #"rusher_kia":
        case #"mimic_kia":
        case #"armoredzombie_kia":
        case #"sniper_kia":
        case #"mannequin_kia":
        case #"zombie_kia":
        case #"hellhound_kia":
        case #"shielded_kia":
        case #"grenadier_kia":
        case #"ghoul_kia":
        case #"parasite_kia":
        case #"shocktroop_kia":
        case #"zombie_kia_elite":
        case #"soldier_kia":
        case #"disciple_kia":
        case #"hash_f723bebcd7a6dbc7":
            var_afdd7c74e32f8475 = hashcat( base_kia, var_9b672797eb3d6743 );
            break;
        default:
            var_afdd7c74e32f8475 = base_kia;
            break;
    }
    
    var_afdd7c74e32f8475 = getxhash( var_afdd7c74e32f8475 );
    
    if ( !isdefined( level.scoreinfo[ var_afdd7c74e32f8475 ] ) )
    {
        var_afdd7c74e32f8475 = base_kia;
    }
    
    return var_afdd7c74e32f8475;
}

// Namespace points
// Params 1
// Checksum 0xb9abad93, Offset: 0xdd8
// Size: 0xa1
function function_9567f8294193ad4b( weapon )
{
    if ( isdefined( weapon ) && isdefined( weapon.basename ) )
    {
        switch ( weapon.basename )
        {
            case #"hash_99a952a970bfa5e4":
            case #"hash_e69f44ae97e8fc97":
                return "_monkeybomb";
            case #"hash_3e6715cf4cbc46d0":
                return "_turret_trap";
            case #"hash_15f465447f809c29":
            case #"hash_b527a878a1d900a3":
                return "_kazimir";
            case #"hash_3188799009d92bfe":
                return "_rcxd";
            default:
                return;
        }
    }
}

// Namespace points
// Params 1, eflags: 0x4
// Checksum 0xe6500163, Offset: 0xe82
// Size: 0x58
function private function_5a9ad0e34e4ab14( player )
{
    if ( !isplayer( player ) )
    {
        return level.weaponnone;
    }
    
    playerid = player getentitynumber();
    
    if ( !self.var_d4b7ed447e2bf50c[ playerid ] )
    {
        return level.weaponnone;
    }
    
    return self.var_d4b7ed447e2bf50c[ playerid ];
}

// Namespace points
// Params 0, eflags: 0x4
// Checksum 0xda213eca, Offset: 0xee3
// Size: 0x5e
function private function_1e4288657bbba2e8()
{
    if ( isplayer( self.var_bd22ba6c600a23a3 ) )
    {
        return self.var_bd22ba6c600a23a3;
    }
    
    if ( isstruct( self.last_dmg_struct ) && isplayer( self.last_dmg_struct.var_bd22ba6c600a23a3 ) )
    {
        return self.last_dmg_struct.var_bd22ba6c600a23a3;
    }
}

// Namespace points
// Params 8
// Checksum 0x17977878, Offset: 0xf4a
// Size: 0x57b
function function_92b70ecfc2f8e086( victim, eattacker, einflictor, smeansofdeath, sweapon, shitloc, typestring, kiastring )
{
    var_bd22ba6c600a23a3 = victim function_1e4288657bbba2e8();
    
    if ( var_bd22ba6c600a23a3 )
    {
        ammomodscoreevent = function_bd686ffa524f4c4e( var_bd22ba6c600a23a3, undefined, kiastring, victim );
        
        if ( ammomodscoreevent )
        {
            var_bd22ba6c600a23a3 thread function_9abc0979fe0e4e0( ammomodscoreevent, undefined, victim, kiastring );
            var_bd22ba6c600a23a3 function_244d8307381c0f44( victim, smeansofdeath, undefined );
        }
        
        return;
    }
    
    var_bd22ba6c600a23a3 = eattacker function_1e4288657bbba2e8();
    
    if ( var_bd22ba6c600a23a3 )
    {
        victim.var_e797f68de73ece4e = "_brot";
        eattacker = var_bd22ba6c600a23a3;
        sweapon = undefined;
    }
    
    var_7912b7fee009f972 = kiastring;
    eliminationscoreevent = function_b908e47ab1e62455( kiastring, victim ) ?? var_7912b7fee009f972;
    
    if ( eliminationscoreevent )
    {
        foreach ( player in self.a_n_player_damage )
        {
            if ( eattacker == player )
            {
                continue;
            }
            
            var_af019b261d1e4ac3 = victim function_5a9ad0e34e4ab14( player );
            player thread function_9abc0979fe0e4e0( eliminationscoreevent, var_af019b261d1e4ac3, victim, kiastring );
        }
    }
    
    ammomodscoreevent = function_bd686ffa524f4c4e( einflictor, sweapon, kiastring, victim );
    
    if ( ammomodscoreevent )
    {
        eattacker thread function_9abc0979fe0e4e0( ammomodscoreevent, sweapon, victim, kiastring );
        eattacker function_244d8307381c0f44( victim, smeansofdeath, sweapon );
        return;
    }
    
    if ( var_bd22ba6c600a23a3 )
    {
        return;
    }
    
    var_a4bfb989b0ab5ef = function_fd9ce781e6a270ba( kiastring, eattacker );
    
    if ( var_a4bfb989b0ab5ef )
    {
        eattacker thread function_9abc0979fe0e4e0( var_a4bfb989b0ab5ef, sweapon, victim, kiastring );
        eattacker function_244d8307381c0f44( victim, smeansofdeath, sweapon );
        return;
    }
    
    superscoreevent = function_c65b5d87ddbf42d7( einflictor, sweapon, kiastring, victim );
    
    if ( superscoreevent )
    {
        eattacker thread function_9abc0979fe0e4e0( superscoreevent, sweapon, victim, kiastring );
        eattacker function_244d8307381c0f44( victim, smeansofdeath, sweapon );
        return;
    }
    
    skillscoreevent = function_6c5bf3cc96e093d5( einflictor, sweapon, victim );
    
    if ( skillscoreevent )
    {
        eattacker thread function_9abc0979fe0e4e0( skillscoreevent, sweapon, victim, kiastring );
        eattacker function_244d8307381c0f44( victim, smeansofdeath, sweapon );
        return;
    }
    
    meleescoreevent = function_79b8c0b28a16a73c( smeansofdeath, kiastring, victim );
    
    if ( meleescoreevent )
    {
        eattacker thread function_9abc0979fe0e4e0( meleescoreevent, sweapon, victim, kiastring );
        eattacker function_244d8307381c0f44( victim, smeansofdeath, sweapon );
        return;
    }
    
    criticalscoreevent = function_cf457fa5aaa1b729( eattacker, kiastring, victim );
    
    if ( criticalscoreevent )
    {
        eattacker thread function_9abc0979fe0e4e0( criticalscoreevent, sweapon, victim, kiastring );
        eattacker function_244d8307381c0f44( victim, smeansofdeath, sweapon );
        return;
    }
    
    equipmentscoreevent = function_e9c6162765f78d4( sweapon, kiastring, victim );
    
    if ( equipmentscoreevent )
    {
        eattacker thread function_9abc0979fe0e4e0( equipmentscoreevent, sweapon, victim, kiastring );
        eattacker function_244d8307381c0f44( victim, smeansofdeath, sweapon );
        return;
    }
    
    killstreakscoreevent = function_f826d498352b0d0a( einflictor, sweapon, kiastring, victim );
    
    if ( killstreakscoreevent )
    {
        eattacker thread function_9abc0979fe0e4e0( killstreakscoreevent, sweapon, victim, kiastring );
        eattacker function_244d8307381c0f44( victim, smeansofdeath, sweapon );
        return;
    }
    
    vehiclescoreevent = function_5090f3ec0ba26c38( einflictor, kiastring, victim );
    
    if ( vehiclescoreevent )
    {
        eattacker thread function_9abc0979fe0e4e0( vehiclescoreevent, sweapon, victim, kiastring );
        eattacker function_244d8307381c0f44( victim, smeansofdeath, sweapon );
        return;
    }
    
    var_b1aa1e478fe2b20 = function_9567f8294193ad4b( sweapon );
    
    if ( isdefined( var_b1aa1e478fe2b20 ) )
    {
        kiastring = function_47dc9b24caa6ae1f( kiastring, var_b1aa1e478fe2b20 );
    }
    else if ( isdefined( einflictor.weapon_name ) && isdefined( level.killstreakweaponmap[ einflictor.weapon_name ] ) )
    {
        end_string = "_" + level.killstreakweaponmap[ einflictor.weapon_name ];
        kiastring = function_47dc9b24caa6ae1f( kiastring, end_string );
    }
    else if ( eattacker killstreak::isjuggernaut() )
    {
        kiastring = function_47dc9b24caa6ae1f( kiastring, "_juggernaut" );
    }
    else if ( weapon::iskillstreakweapon( sweapon ) )
    {
        end_string = "_" + level.killstreakweaponmap[ sweapon.basename ];
        kiastring = function_47dc9b24caa6ae1f( kiastring, end_string );
    }
    else if ( einflictor.weapon_name == "hellhound_molotov" )
    {
        end_string = "_hellhound_flame";
        kiastring = function_47dc9b24caa6ae1f( kiastring, end_string );
    }
    else
    {
        binvehicle = 0;
        
        if ( isdefined( einflictor.vehicletype ) )
        {
            if ( einflictor.streakname == "rcxd" )
            {
                kiastring = function_47dc9b24caa6ae1f( kiastring, "_rcxd" );
            }
            else
            {
                kiastring = function_47dc9b24caa6ae1f( kiastring, "_vehicle" );
            }
        }
        
        if ( smeansofdeath == "MOD_MELEE" )
        {
            kiastring = function_47dc9b24caa6ae1f( kiastring, "_melee" );
        }
        
        if ( isdefined( self.last_dmg_struct ) && self.last_dmg_struct.biscritical )
        {
            kiastring = function_47dc9b24caa6ae1f( kiastring, "_critical" );
        }
    }
    
    if ( isdefined( self.var_5d3022108c155ed4 ) )
    {
        kiastring = self.var_5d3022108c155ed4;
    }
    
    if ( smeansofdeath == "MOD_EXECUTION" && self.unittype == "zombie" )
    {
        kiastring = #"zombie_kia_executed";
    }
    
    if ( eliminationscoreevent && !isvalidscoreevent( kiastring ) )
    {
        eattacker thread function_9abc0979fe0e4e0( eliminationscoreevent, sweapon, victim, kiastring );
    }
    else
    {
        eattacker thread function_9abc0979fe0e4e0( kiastring, sweapon, victim, kiastring );
    }
    
    eattacker function_244d8307381c0f44( victim, smeansofdeath, sweapon );
}

// Namespace points
// Params 2, eflags: 0x4
// Checksum 0xb4ee46d6, Offset: 0x14cd
// Size: 0x100
function private function_fd9ce781e6a270ba( kiastring, eattacker )
{
    assert( isdefined( kiastring ), "<dev string:xe8>" );
    scoreevent = "";
    rapidkillthreshold = level.scoreeventglobals.rapidkillthreshold ?? 5;
    
    if ( isdefined( eattacker.rapidkill_data[ "general" ] ) && eattacker.rapidkill_data[ "general" ].rapidkill_count != 0 )
    {
        if ( eattacker.rapidkill_data[ "general" ].rapidkill_count % rapidkillthreshold == 0 )
        {
            scoreevent = #"rapid_kills";
            
            if ( isvalidscoreevent( scoreevent ) )
            {
                eattacker setclientomnvar( "ui_num_rapid_kills", clampint( eattacker.rapidkill_data[ "general" ].rapidkill_count, 1, 100 ) );
                return scoreevent;
            }
            
            return;
        }
    }
}

// Namespace points
// Params 3, eflags: 0x4
// Checksum 0xb3e0c28e, Offset: 0x15d6
// Size: 0x8e
function private function_79b8c0b28a16a73c( meansofdeath, kiastring, enemy )
{
    assert( isdefined( kiastring ), "<dev string:xe8>" );
    
    if ( meansofdeath != "MOD_MELEE" || self.last_dmg_struct.biscritical )
    {
        return;
    }
    
    scoreevent = hashcat( #"melee", "_kill" );
    scoreevent = function_41e7b7e813d58123( scoreevent, enemy );
    return isvalidscoreevent( scoreevent ) ? scoreevent : undefined;
}

// Namespace points
// Params 1, eflags: 0x4
// Checksum 0xd0510e92, Offset: 0x166d
// Size: 0x16, Type: bool
function private isvalidscoreevent( scoreevent )
{
    return rank::getscoreinfovalue( scoreevent ) > 0;
}

// Namespace points
// Params 3, eflags: 0x4
// Checksum 0x1ee7b109, Offset: 0x168c
// Size: 0xb7
function private function_cf457fa5aaa1b729( attacker, kiastring, enemy )
{
    assert( isdefined( kiastring ), "<dev string:xe8>" );
    
    if ( !self.last_dmg_struct.biscritical )
    {
        return;
    }
    
    if ( self.last_dmg_struct.eattacker != attacker && self.var_1480bf6f03b7e0be.eattacker != attacker )
    {
        return;
    }
    
    scoreevent = hashcat( #"critical", "_kill" );
    scoreevent = function_41e7b7e813d58123( scoreevent, enemy );
    return isvalidscoreevent( scoreevent ) ? scoreevent : undefined;
}

// Namespace points
// Params 3, eflags: 0x4
// Checksum 0xdd1c1efb, Offset: 0x174c
// Size: 0x85
function private function_5090f3ec0ba26c38( inflictor, kiastring, enemy )
{
    assert( isdefined( kiastring ), "<dev string:xe8>" );
    
    if ( !inflictor.vehicletype || inflictor function_a7378c4908103226() )
    {
        return;
    }
    
    scoreevent = hashcat( #"vehicle", "_kill" );
    scoreevent = function_41e7b7e813d58123( scoreevent, enemy );
    return isvalidscoreevent( scoreevent ) ? scoreevent : undefined;
}

// Namespace points
// Params 2, eflags: 0x4
// Checksum 0x37473bea, Offset: 0x17da
// Size: 0x81
function private function_b908e47ab1e62455( kiastring, enemy )
{
    assert( isdefined( kiastring ), "<dev string:xe8>" );
    
    if ( !isdefined( self.a_n_player_damage ) || self.a_n_player_damage.size <= 0 )
    {
        return;
    }
    
    scoreevent = hashcat( #"elimination", "_kill" );
    scoreevent = function_41e7b7e813d58123( scoreevent, enemy );
    return isvalidscoreevent( scoreevent ) ? scoreevent : undefined;
}

// Namespace points
// Params 2, eflags: 0x4
// Checksum 0x7f615913, Offset: 0x1864
// Size: 0x4b
function private function_58567342b275d71( weapon, inflictor )
{
    superref = supers_mp::getsuperrefforsuperweapon( weapon );
    
    if ( superref )
    {
        return superref;
    }
    
    if ( inflictor.superref )
    {
        return inflictor.superref;
    }
}

// Namespace points
// Params 4, eflags: 0x4
// Checksum 0xcd3678ed, Offset: 0x18b8
// Size: 0x8b
function private function_c65b5d87ddbf42d7( inflictor, weapon, kiastring, enemy )
{
    assert( isdefined( kiastring ), "<dev string:xe8>" );
    superref = function_58567342b275d71( weapon, inflictor );
    
    if ( !superref )
    {
        return;
    }
    
    scoreevent = hashcat( getxhash( superref ), "_kill" );
    scoreevent = function_41e7b7e813d58123( scoreevent, enemy );
    return isvalidscoreevent( scoreevent ) ? scoreevent : undefined;
}

// Namespace points
// Params 3, eflags: 0x4
// Checksum 0xd7320e04, Offset: 0x194c
// Size: 0x82
function private function_6c5bf3cc96e093d5( inflictor, weapon, enemy )
{
    skillref = inflictor utility::callsharedfunc( #"skills", #"hash_d1b0a8ba618e0ca8", weapon );
    
    if ( !skillref )
    {
        return;
    }
    
    scoreevent = hashcat( getxhash( skillref ), "_kill" );
    scoreevent = function_41e7b7e813d58123( scoreevent, enemy );
    return isvalidscoreevent( scoreevent ) ? scoreevent : undefined;
}

// Namespace points
// Params 4, eflags: 0x4
// Checksum 0x5c2ac695, Offset: 0x19d7
// Size: 0xbe
function private function_bd686ffa524f4c4e( inflictor, weapon, kiastring, enemy )
{
    assert( isdefined( kiastring ), "<dev string:xe8>" );
    ammomodref = enemy.var_e797f68de73ece4e ?? enemy.var_bb4d607514eb37ce;
    
    if ( !ammomodref )
    {
        return;
    }
    
    if ( ammomodref == "_cfreeze" && enemy.var_e957ff879042cc5f != inflictor )
    {
        return;
    }
    
    scoreevent = hashcat( #"ammo_mod", ammomodref, "_kill" );
    scoreevent = function_41e7b7e813d58123( scoreevent, enemy );
    return isvalidscoreevent( scoreevent ) ? scoreevent : undefined;
}

// Namespace points
// Params 4, eflags: 0x4
// Checksum 0xe441925a, Offset: 0x1a9e
// Size: 0x8b
function private function_f826d498352b0d0a( inflictor, weapon, kiastring, enemy )
{
    assert( isdefined( kiastring ), "<dev string:xe8>" );
    killstreakref = function_f3125e3865021c1c( inflictor, weapon );
    
    if ( !killstreakref )
    {
        return;
    }
    
    scoreevent = hashcat( getxhash( killstreakref ), "_kill" );
    scoreevent = function_41e7b7e813d58123( scoreevent, enemy );
    return isvalidscoreevent( scoreevent ) ? scoreevent : undefined;
}

// Namespace points
// Params 2, eflags: 0x4
// Checksum 0xcc90239c, Offset: 0x1b32
// Size: 0xa0
function private function_f3125e3865021c1c( inflictor, weapon )
{
    if ( killstreak::getkillstreaknamefromweapon( weapon ) )
    {
        return killstreak::getkillstreaknamefromweapon( weapon );
    }
    
    if ( isdefined( level.killstreakweaponmap[ inflictor.weapon_name ] ) )
    {
        return level.killstreakweaponmap[ inflictor.weapon_name ];
    }
    
    if ( inflictor.streakinfo.streakname )
    {
        return inflictor.streakinfo.streakname;
    }
    
    if ( inflictor.streakname )
    {
        return inflictor.streakname;
    }
}

// Namespace points
// Params 2, eflags: 0x4
// Checksum 0xe45975f2, Offset: 0x1bdb
// Size: 0xe0
function private function_41e7b7e813d58123( scoreevent, enemy )
{
    enemycategory = ai_category::function_e6e323e14b12152e( enemy );
    
    switch ( enemycategory )
    {
        case #"normal":
            return hashcat( scoreevent, "_normal" );
        case #"advanced":
            return hashcat( scoreevent, "_advanced" );
        case #"special":
            return hashcat( scoreevent, "_special" );
        case #"hvt":
        case #"elite":
            return hashcat( scoreevent, "_elite" );
        case #"boss":
            return hashcat( scoreevent, "_boss" );
        default:
            assertmsg( "<dev string:xfd>" + enemy.subclass );
            return;
    }
}

// Namespace points
// Params 1, eflags: 0x4
// Checksum 0xcde3e5ed, Offset: 0x1cc3
// Size: 0x46
function private function_bd412cac7e05f642( weapon )
{
    equipmentref = equipment_mp::function_fdc4a655fbde0dec( getweaponbasename( weapon ) );
    
    if ( equipmentref )
    {
        return equipmentref;
    }
    
    if ( weapon.equipmentref )
    {
        return weapon.equipmentref;
    }
}

// Namespace points
// Params 3, eflags: 0x4
// Checksum 0x42f1682c, Offset: 0x1d12
// Size: 0x81
function private function_e9c6162765f78d4( weapon, kiastring, enemy )
{
    assert( isdefined( kiastring ), "<dev string:xe8>" );
    equipmentref = function_bd412cac7e05f642( weapon );
    
    if ( !equipmentref )
    {
        return;
    }
    
    scoreevent = hashcat( getxhash( equipmentref ), "_kill" );
    scoreevent = function_41e7b7e813d58123( scoreevent, enemy );
    return isvalidscoreevent( scoreevent ) ? scoreevent : undefined;
}

// Namespace points
// Params 4
// Checksum 0x2a3d6d9c, Offset: 0x1d9c
// Size: 0x224
function function_9abc0979fe0e4e0( var_7912b7fee009f972, sweapon, victim, kiastring )
{
    var_c237037189ce2bf0 = 0;
    
    if ( isdefined( victim ) && victim.var_2364be08b6facb67 )
    {
        var_c237037189ce2bf0 = 1;
    }
    
    if ( utility::ent_flag( "powerup_insta_kill_active" ) )
    {
        var_c237037189ce2bf0 = 1;
    }
    
    if ( !isdefined( level.ob_killing_score_event_throttle ) )
    {
        level.ob_killing_score_event_throttle = throttle::throttle_initialize( "ob_killing_score_event", 2, level.framedurationseconds );
    }
    
    var_1819ea4dc4ef3a41 = spawnstruct();
    throttle::throttle_wait_in_queue( level.ob_killing_score_event_throttle, var_1819ea4dc4ef3a41 );
    
    if ( var_7912b7fee009f972 == "zombie_kia_executed" )
    {
        wait 1;
    }
    
    if ( isdefined( self ) )
    {
        if ( var_c237037189ce2bf0 )
        {
            val::set( "zm_allow_give_super_point", "allow_give_super_point", 0 );
        }
        
        xp = rank::getscoreinfoxp( var_7912b7fee009f972 ) ?? 0;
        
        if ( ai_category::function_4c80eeabb07939c1( kiastring ) )
        {
            self.pers[ "telemetry" ].elite_eliminations++;
            self.pers[ "telemetry" ].elite_eliminations_xp = self.pers[ "telemetry" ].elite_eliminations_xp + xp;
        }
        else if ( ai_category::function_76252ef8d8fa6517( kiastring ) )
        {
            self.pers[ "telemetry" ].special_eliminations++;
            self.pers[ "telemetry" ].special_eliminations_xp = self.pers[ "telemetry" ].special_eliminations_xp + xp;
        }
        else
        {
            self.pers[ "telemetry" ].eliminations++;
            self.pers[ "telemetry" ].eliminations_xp = self.pers[ "telemetry" ].eliminations_xp + xp;
        }
        
        ob_do_score_event( var_7912b7fee009f972, sweapon, 0, #"kill", undefined, undefined, victim );
        val::reset_all( "zm_allow_give_super_point" );
        ob::function_7684428f2ac101cb();
    }
}

// Namespace points
// Params 3
// Checksum 0xa533f3fc, Offset: 0x1fc8
// Size: 0x5ee
function function_244d8307381c0f44( victim, smeansofdeath, sweapon )
{
    if ( isdefined( self.no_damage_kill_count ) && self.no_damage_kill_count != 0 && self.no_damage_kill_count % 20 == 0 )
    {
        ob_do_score_event( #"medal_jackrabbit" );
    }
    
    if ( !isdefined( self.rapidkill_data ) )
    {
        return;
    }
    
    if ( isdefined( self.rapidkill_data[ "MOD_MELEE" ] ) && self.rapidkill_data[ "MOD_MELEE" ].rapidkill_count != 0 )
    {
        if ( self.rapidkill_data[ "MOD_MELEE" ].rapidkill_count % 15 == 0 )
        {
            ob_do_score_event( #"hash_934604e5ebee53a5" );
        }
        else if ( self.rapidkill_data[ "MOD_MELEE" ].rapidkill_count % 10 == 0 )
        {
            ob_do_score_event( #"hash_9345ffe5ebee4b26" );
        }
        else if ( self.rapidkill_data[ "MOD_MELEE" ].rapidkill_count % 5 == 0 )
        {
            ob_do_score_event( #"hash_d586c80f3dbf32a6" );
        }
    }
    
    if ( isdefined( self.rapidkill_data[ "primary" ] ) && self.rapidkill_data[ "primary" ].rapidkill_count != 0 )
    {
        if ( self.rapidkill_data[ "primary" ].rapidkill_count % 20 == 0 )
        {
            ob_do_score_event( #"medal_rapidkill_20" );
        }
        else if ( self.rapidkill_data[ "primary" ].rapidkill_count % 15 == 0 )
        {
            ob_do_score_event( #"medal_rapidkill_15" );
        }
        else if ( self.rapidkill_data[ "primary" ].rapidkill_count % 10 == 0 )
        {
            ob_do_score_event( #"medal_rapidkill_10" );
        }
    }
    
    if ( isdefined( self.rapidkill_data[ "vehicle_crush_or_kill" ] ) && self.rapidkill_data[ "vehicle_crush_or_kill" ].rapidkill_count != 0 )
    {
        if ( self.rapidkill_data[ "vehicle_crush_or_kill" ].rapidkill_count % 20 == 0 )
        {
            ob_do_score_event( #"medal_rapidkill_vehicle_20" );
        }
        else if ( self.rapidkill_data[ "vehicle_crush_or_kill" ].rapidkill_count % 15 == 0 )
        {
            ob_do_score_event( #"medal_rapidkill_vehicle_15" );
        }
        else if ( self.rapidkill_data[ "vehicle_crush_or_kill" ].rapidkill_count % 10 == 0 )
        {
            ob_do_score_event( #"medal_rapidkill_vehicle_10" );
        }
    }
    
    if ( isdefined( self.rapidkill_data[ "single_explosive_kill" ] ) && self.rapidkill_data[ "single_explosive_kill" ].rapidkill_count != 0 )
    {
        if ( self.rapidkill_data[ "single_explosive_kill" ].rapidkill_count % 20 == 0 )
        {
            ob_do_score_event( #"hash_54f28fa9ddf9b769" );
        }
        else if ( self.rapidkill_data[ "single_explosive_kill" ].rapidkill_count % 15 == 0 )
        {
            ob_do_score_event( #"hash_54f592a9ddfbf259" );
        }
        else if ( self.rapidkill_data[ "single_explosive_kill" ].rapidkill_count % 10 == 0 )
        {
            ob_do_score_event( #"hash_54f595a9ddfbf772" );
        }
    }
    
    if ( isdefined( self.rapidkill_data[ "killstreak_kill" ] ) && self.rapidkill_data[ "killstreak_kill" ].rapidkill_count != 0 )
    {
        if ( self.rapidkill_data[ "killstreak_kill" ].rapidkill_count % 20 == 0 )
        {
            ob_do_score_event( #"hash_6ded9a614605c2b0" );
        }
        else if ( self.rapidkill_data[ "killstreak_kill" ].rapidkill_count % 15 == 0 )
        {
            ob_do_score_event( #"hash_6df7af61460e3ae4" );
        }
        else if ( self.rapidkill_data[ "killstreak_kill" ].rapidkill_count % 10 == 0 )
        {
            ob_do_score_event( #"hash_6df7ac61460e35cb" );
        }
    }
    
    if ( isdefined( self.rapidkill_data[ "elemental_kill_fire" ] ) && self.rapidkill_data[ "elemental_kill_fire" ].rapidkill_count != 0 )
    {
        if ( self.rapidkill_data[ "elemental_kill_fire" ].rapidkill_count % 10 == 0 )
        {
            ob_do_score_event( #"hash_1d16a90346898202" );
        }
    }
    
    if ( isdefined( self.rapidkill_data[ "elemental_kill_cold" ] ) && self.rapidkill_data[ "elemental_kill_cold" ].rapidkill_count != 0 )
    {
        if ( self.rapidkill_data[ "elemental_kill_cold" ].rapidkill_count % 10 == 0 )
        {
            ob_do_score_event( #"hash_a12b45eb4f1d0138" );
        }
    }
    
    if ( isdefined( self.rapidkill_data[ "elemental_kill_electrical" ] ) && self.rapidkill_data[ "elemental_kill_electrical" ].rapidkill_count != 0 )
    {
        if ( self.rapidkill_data[ "elemental_kill_electrical" ].rapidkill_count % 10 == 0 )
        {
            ob_do_score_event( #"hash_deefad4fef3853c" );
        }
    }
    
    if ( isdefined( self.rapidkill_data[ "elemental_kill_toxic" ] ) && self.rapidkill_data[ "elemental_kill_toxic" ].rapidkill_count != 0 )
    {
        if ( self.rapidkill_data[ "elemental_kill_toxic" ].rapidkill_count % 10 == 0 )
        {
            ob_do_score_event( #"hash_2d04f4b7c3b707" );
        }
    }
}

// Namespace points
// Params 1
// Checksum 0x8a162c4f, Offset: 0x25be
// Size: 0x44
function ob_score_event( sparams )
{
    if ( isplayer( self ) && isdefined( sparams.scoreevent ) )
    {
        scoreevent = sparams.scoreevent;
        ob_do_score_event( scoreevent );
    }
}

// Namespace points
// Params 3
// Checksum 0xf8d99833, Offset: 0x260a
// Size: 0x1cc
function ob_get_weapon_element( objweapon, eattacker, smeansofdeath )
{
    element = "none";
    root_weapon_string = objweapon.var_1616e6fbba9a722d;
    has_ammo_mod_fn = level.sharedfuncs[ #"zombie" ][ #"has_ammo_mod" ];
    
    if ( isplayer( eattacker ) && level.ammo_mods_in_use && isdefined( has_ammo_mod_fn ) && eattacker [[ has_ammo_mod_fn ]]( objweapon ) )
    {
        get_ammo_mod_name_fn = level.sharedfuncs[ #"zombie" ][ #"get_ammo_mod_name" ];
        
        if ( isdefined( get_ammo_mod_name_fn ) )
        {
            ammomod_name = eattacker [[ get_ammo_mod_name_fn ]]( objweapon );
            
            if ( isdefined( level.ammo_mods[ ammomod_name ].element ) )
            {
                element = level.ammo_mods[ ammomod_name ].element;
            }
        }
    }
    else
    {
        weaponbundle = undefined;
        
        if ( isdefined( level.weaponmetadata ) )
        {
            weaponbundle = level.weaponmetadata[ root_weapon_string ];
        }
        
        if ( isdefined( weaponbundle ) && isdefined( weaponbundle.elementdamagetype ) )
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
// Checksum 0x7cfd874, Offset: 0x27df
// Size: 0x785
function ob_event_on_ai_killed( sparams )
{
    if ( self.death_source == "despawn" )
    {
        return;
    }
    
    var_bd22ba6c600a23a3 = self.var_bd22ba6c600a23a3;
    elementalweakness = self.elementalweakness;
    
    if ( !isdefined( level.ob_ai_killed_points_throttle ) )
    {
        level.ob_ai_killed_points_throttle = throttle::throttle_initialize( "ob_ai_killed_points_throttle", 1, level.framedurationseconds );
    }
    
    ai_killed_event = spawnstruct();
    throttle::throttle_wait_in_queue( level.ob_ai_killed_points_throttle, ai_killed_event );
    
    if ( isdefined( sparams.eattacker ) && isplayer( sparams.eattacker.var_bd22ba6c600a23a3 ) )
    {
        player = sparams.eattacker.var_bd22ba6c600a23a3;
        player ob_do_score_event( #"brainrot_kill", undefined, 0, #"kill" );
    }
    
    if ( isplayer( var_bd22ba6c600a23a3 ) )
    {
        var_bd22ba6c600a23a3 ob_do_score_event( #"brainrot_kill", undefined, 0, #"kill" );
    }
    
    if ( isplayer( sparams.eattacker ) )
    {
        if ( !isdefined( sparams.eattacker.rapidkill_data ) )
        {
            sparams.eattacker.rapidkill_data = [];
        }
        
        sparams.eattacker track_rapidkill( "general" );
        
        if ( isdefined( sparams.smeansofdeath ) )
        {
            sparams.eattacker track_rapidkill( sparams.smeansofdeath );
        }
        
        is_field_upgrade = is_field_upgrade_weapons( sparams );
        is_killstreak = is_killstreak_weapons( sparams.sweapon );
        
        if ( isdefined( sparams.sweapon ) && isdefined( sparams.smeansofdeath ) && sparams.sweapon.classname != "turret" && sparams.sweapon.inventorytype == "primary" && sparams.smeansofdeath != "MOD_MELEE" && !is_field_upgrade )
        {
            sparams.eattacker track_rapidkill( "primary" );
        }
        
        if ( isdefined( sparams.smeansofdeath ) && !is_killstreak && !is_field_upgrade && sparams.smeansofdeath == "MOD_EXPLOSIVE" || sparams.smeansofdeath == "MOD_PROJECTILE" || sparams.smeansofdeath == "MOD_PROJECTILE_SPLASH" || sparams.smeansofdeath == "MOD_GRENADE_SPLASH" )
        {
            sparams.eattacker track_rapidkill( "single_explosive_kill", sparams.sweapon );
        }
        
        if ( isdefined( sparams.eattacker.vehicle ) && sparams.eattacker.currentweapon.classname == "turret" )
        {
            sparams.eattacker track_rapidkill( "vehicle_crush_or_kill" );
        }
        
        if ( sparams.eattacker killstreak::isjuggernaut() || is_killstreak )
        {
            sparams.eattacker track_rapidkill( "killstreak_kill" );
        }
        
        if ( !isdefined( sparams.eattacker.no_damage_kill_count ) )
        {
            sparams.eattacker.no_damage_kill_count = 0;
        }
        
        sparams.eattacker.no_damage_kill_count++;
    }
    
    if ( isdefined( sparams.eattacker ) && isplayer( sparams.eattacker.owner ) )
    {
        if ( !isdefined( sparams.eattacker.owner.rapidkill_data ) )
        {
            sparams.eattacker.owner.rapidkill_data = [];
        }
        
        if ( sparams.eattacker.streakname == "sentry_turret" )
        {
            sparams.eattacker.owner track_rapidkill( "killstreak_kill" );
        }
        
        if ( sparams.eattacker.classname == "script_vehicle" )
        {
            sparams.eattacker.owner track_rapidkill( "vehicle_crush_or_kill" );
        }
    }
    
    if ( isdefined( sparams.sweapon ) && isdefined( sparams.smeansofdeath ) && isplayer( sparams.eattacker ) )
    {
        var_5e5a2456deacd236 = ob_get_weapon_element( sparams.sweapon, sparams.eattacker, sparams.smeansofdeath );
        var_12f86adcdc0f31a4 = "none";
        
        if ( var_5e5a2456deacd236 == "fire" || sparams.smeansofdeath == "MOD_ELEMENTAL_FIRE" )
        {
            if ( !isdefined( sparams.einflictor ) || sparams.einflictor.weapon_name != "hellhound_molotov" )
            {
                sparams.eattacker track_rapidkill( "elemental_kill_fire" );
                var_12f86adcdc0f31a4 = #"fire_damage_weakness_kill";
            }
        }
        else if ( var_5e5a2456deacd236 == "cold" || sparams.smeansofdeath == "MOD_ELEMENTAL_COLD" )
        {
            sparams.eattacker track_rapidkill( "elemental_kill_cold" );
            var_12f86adcdc0f31a4 = #"cold_damage_weakness_kill";
        }
        else if ( var_5e5a2456deacd236 == "electrical" || sparams.smeansofdeath == "MOD_ELEMENTAL_ELEC" )
        {
            sparams.eattacker track_rapidkill( "elemental_kill_electrical" );
            var_12f86adcdc0f31a4 = #"electric_damage_weakness_kill";
        }
        else if ( var_5e5a2456deacd236 == "toxic" || sparams.smeansofdeath == "MOD_ELEMENTAL_TOXIC" )
        {
            sparams.eattacker track_rapidkill( "elemental_kill_toxic" );
            var_12f86adcdc0f31a4 = #"toxic_damage_weakness_kill";
        }
        
        if ( isarray( elementalweakness ) && elementalweakness[ var_5e5a2456deacd236 ] && var_12f86adcdc0f31a4 != "none" )
        {
            sparams.eattacker ob_do_score_event( var_12f86adcdc0f31a4, undefined, 0, #"kill" );
        }
    }
    
    if ( isplayer( sparams.eattacker ) && isdefined( sparams.einflictor ) && sparams.einflictor.weapon_name == "hellhound_molotov" )
    {
        einflictor = sparams.einflictor;
        
        if ( isdefined( einflictor.var_d7594a5edcf54e30 ) )
        {
            einflictor [[ einflictor.var_d7594a5edcf54e30 ]]();
        }
    }
    
    if ( isdefined( sparams.eattacker ) && sparams.eattacker.var_43d79e31059e0e5b )
    {
        if ( isplayer( sparams.eattacker.pet_owner ) )
        {
            sparams.eattacker.pet_owner ob_do_score_event( #"pet_dog_kill", undefined, 0, #"kill" );
        }
    }
}

// Namespace points
// Params 1
// Checksum 0xad69dd17, Offset: 0x2f6c
// Size: 0x62
function rapidkillmonitor( rapidkill_type )
{
    self notify( rapidkill_type + "recent_zombie_rapid_kill" );
    self endon( rapidkill_type + "recent_zombie_rapid_kill" );
    level endon( #"game_ended" );
    wait 2;
    
    if ( isdefined( self.rapidkill_data[ rapidkill_type ] ) && isplayer( self ) )
    {
        self.rapidkill_data[ rapidkill_type ].rapidkill_count = 0;
    }
}

// Namespace points
// Params 2
// Checksum 0x7c1ae5be, Offset: 0x2fd6
// Size: 0xf7
function track_rapidkill( rapidkill_type, sweapon )
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
    
    self.rapidkill_data[ rapidkill_type ].rapidkill_count++;
    thread rapidkillmonitor( rapidkill_type );
}

// Namespace points
// Params 1
// Checksum 0xdb64d749, Offset: 0x30d5
// Size: 0x66, Type: bool
function is_killstreak_weapons( sweapon )
{
    return isdefined( sweapon ) && isdefined( sweapon.basename ) && issubstr( sweapon.basename, "cluster_spike" ) || issubstr( sweapon.basename, "toma_proj" ) || issubstr( sweapon.basename, "artillery_mp" );
}

// Namespace points
// Params 1
// Checksum 0x7e287c64, Offset: 0x3144
// Size: 0xf0, Type: bool
function is_field_upgrade_weapons( sparams )
{
    var_24b1dba23ae30495 = [ %"energy_mine", %"tesla_storm", %"frost_blast" ];
    
    if ( isdefined( sparams.sweapon ) )
    {
        foreach ( field_upgrade in var_24b1dba23ae30495 )
        {
            if ( isdefined( level.weaponmetadata[ field_upgrade ] ) && level.weaponmetadata[ field_upgrade ].weaponobj == sparams.sweapon )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace points
// Params 1, eflags: 0x4
// Checksum 0xd425af8, Offset: 0x323d
// Size: 0x9f
function private function_32f6d601e5c468c4( sparams )
{
    foreach ( player in self.a_n_player_damage )
    {
        if ( player != sparams.attacker )
        {
            player thread doscoreevent( #"hash_4701720c90b3b4dc" );
        }
    }
}

