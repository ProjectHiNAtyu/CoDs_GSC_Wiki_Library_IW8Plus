// scripts\mp\ob\supers\super_survival_life_drain.gsc  (hash_2f7953ad7f6d0ef5.gscc) (size: 10400 Bytes / 0x28a0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1e637af (31864751)
// size ...... 10400 (0x28a0)
// includes .. 14  (offset: 0x2710)
// strings ... 11  (offset: 0x2780)
// dev strs .. 7   (offset: 0x284c)
// exports ... 33  (offset: 0x1584)
// cseg ...... 0x19d + 0x13e7 (0x1584)
// imports ... 107 (offset: 0x1aac)
// animtree1 . 0   (offset: 0x28a0)
// animtree2 . 0   (offset: 0x28a0)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\armor;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\equipment;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\supers;

#namespace survival_life_drain;

// Namespace survival_life_drain
// Params 0, eflags: 0x5
// Checksum 0x7b6d4f59, Offset: 0x1bb
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0x63f4223b, Offset: 0x1db
// Size: 0x92
function private register( params )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_survival_life_drain" );
    assert( bundle, "<dev string:x24>" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_survival_life_drain", undefined, undefined, &begin_use, &end_use, undefined, &function_9a52c179a63a2121 );
    utility::registersharedfunc( #"super_survival_life_drain", #"hash_e2b8202b1b5db7b0", &function_3e825889d342048f );
    
    if ( bundle.var_328a79747c6764f5 )
    {
        level callback::add( #"player_laststand", &on_player_laststand_enter );
    }
}

// Namespace survival_life_drain
// Params 0, eflags: 0x4
// Checksum 0xd2474b6e, Offset: 0x275
// Size: 0x9
function private function_9a52c179a63a2121()
{
    thread function_1a8f8a0a1cca3af0();
}

// Namespace survival_life_drain
// Params 1, eflags: 0xc
// Checksum 0x372f600c, Offset: 0x286
// Size: 0x67
function private function_1a8f8a0a1cca3af0( params )
{
    self notify( #"hash_889eb48a3160c54d" );
    self endon( #"hash_889eb48a3160c54d" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        childthread function_fb29bdf221d35a78();
        
        if ( !function_a657e71349e9436b() )
        {
            function_482eeea96efb7057();
            break;
        }
        
        utility::waittill_any( "remove_super", "super_survival_life_drain_used" );
    }
}

// Namespace survival_life_drain
// Params 0, eflags: 0x4
// Checksum 0xaf289d82, Offset: 0x2f5
// Size: 0x9d, Type: bool
function private function_a657e71349e9436b()
{
    super_slot = supers_mp::getsuperslot( "super_survival_life_drain" );
    super_name = supers_mp::getcurrentsuperref( super_slot );
    
    if ( super_slot == #"tactical" )
    {
        tactical_ref = equipment_mp::getcurrentequipment( "secondary" );
        var_7d9d3c52270ed058 = equipment_mp::getequipmentammo( tactical_ref );
    }
    
    if ( super_name != "super_survival_life_drain" || var_7d9d3c52270ed058 <= 0 || !( super_slot != #"default" || supers_mp::issuperready( undefined, #"default" ) ) )
    {
        return false;
    }
    
    return true;
}

// Namespace survival_life_drain
// Params 0, eflags: 0xc
// Checksum 0x71b74604, Offset: 0x39b
// Size: 0x211
function private function_fb29bdf221d35a78()
{
    self notify( #"hash_a053b0dafc38d682" );
    self endon( #"hash_a053b0dafc38d682" );
    self endon( #"remove_super" );
    self endon( #"super_survival_life_drain_used" );
    
    if ( !function_a657e71349e9436b() )
    {
        function_482eeea96efb7057();
        return;
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_survival_life_drain" );
    
    /#
        if ( getdvarint( @"hash_273e9f545d7026c9", 0 ) )
        {
            var_150e76ca567f8c26 = bundle.survival_life_drain_effect_radius;
            childthread function_c16ab21f85281427( var_150e76ca567f8c26 );
        }
    #/
    
    set_targets( [ self ], undefined, bundle );
    
    if ( level.teambased )
    {
        do
        {
            var_4fbb8dfc09fb7511 = utility::callsharedfunc( "super_survival_life_drain", #"hash_e4efac09d11d4af8" );
            var_150e76ca567f8c26 = utility::function_b720276ae54a4d70( bundle.survival_life_drain_effect_radius, "Survival Life Drain has no value for Radius" );
            targets = squad_utility::function_ed1cc36405244cd4( var_150e76ca567f8c26, 0 );
            allies = undefined;
            
            if ( var_4fbb8dfc09fb7511 )
            {
                allies = function_f5762c7aecaf6c64( var_4fbb8dfc09fb7511.var_545a3574cac17377 );
                
                if ( var_4fbb8dfc09fb7511.onlylaststand )
                {
                    foreach ( ally in allies )
                    {
                        if ( !ally.inlaststand )
                        {
                            allies = arrayremove( allies, ally );
                        }
                    }
                }
                
                if ( var_4fbb8dfc09fb7511.var_3faa2d6eba2c8c69 && var_4fbb8dfc09fb7511.var_3faa2d6eba2c8c69 < allies.size )
                {
                    sortedallies = function_628bac9faa9d1e86( allies, self.origin );
                    allies = utility::array_slice( sortedallies, 0, var_4fbb8dfc09fb7511.var_3faa2d6eba2c8c69 );
                }
                
                targets = arraycombine( targets, allies );
            }
            
            set_targets( targets, allies, bundle );
            wait 0.2;
        }
        while ( true );
    }
}

// Namespace survival_life_drain
// Params 3, eflags: 0x4
// Checksum 0xb5b8885a, Offset: 0x5b4
// Size: 0x135
function private set_targets( targets, var_a64dbe74f2f3f2bd, bundle )
{
    self.survival_life_drain_targets = targets;
    
    if ( !targets.size )
    {
        if ( bundle.var_fac8979647696b4e )
        {
            self setclientomnvar( bundle.var_fac8979647696b4e, 0 );
        }
        
        if ( bundle.var_28f50cc5b9dac317 )
        {
            self setclientomnvar( bundle.var_28f50cc5b9dac317, 0 );
        }
        
        return;
    }
    
    squad_size = squad_utility::getsquadsize( self );
    
    if ( bundle.var_fac8979647696b4e )
    {
        self setclientomnvar( bundle.var_fac8979647696b4e, squad_size - 1 );
    }
    
    if ( bundle.var_28f50cc5b9dac317 )
    {
        if ( squad_size == 1 && !var_a64dbe74f2f3f2bd )
        {
            self setclientomnvar( bundle.var_28f50cc5b9dac317, 0 );
        }
        else
        {
            self setclientomnvar( bundle.var_28f50cc5b9dac317, targets.size );
        }
        
        assert( bundle.var_49c91f13abd737b7, "<dev string:x54>" );
        filledsegments = targets.size - 1;
        
        if ( var_a64dbe74f2f3f2bd )
        {
            filledsegments -= var_a64dbe74f2f3f2bd.size;
        }
        
        self setclientomnvar( bundle.var_49c91f13abd737b7, filledsegments );
    }
}

// Namespace survival_life_drain
// Params 0, eflags: 0x4
// Checksum 0x3ea2da05, Offset: 0x6f1
// Size: 0x107
function private begin_use()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_survival_life_drain" );
    assert( isdefined( bundle ), "<dev string:xcd>" );
    self.var_b71dd0a90750706f = self.survival_life_drain_targets;
    self.survival_life_drain_targets = undefined;
    
    if ( bundle.var_6f28d53438514096 )
    {
        success = apply_effect_squad( bundle );
    }
    else
    {
        success = apply_effect_single( bundle );
    }
    
    if ( success )
    {
        self notify( #"super_survival_life_drain_used" );
        
        if ( !level callback::exists( #"on_ai_killed", &function_8c5e06ee1e60aeb7 ) )
        {
            level callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
        }
        
        if ( bundle.var_8b9eade13fbfb044 )
        {
            assert( !callback::exists( #"super_cancel", &cancel ) );
            callback::add( #"super_cancel", &cancel );
        }
    }
    else
    {
        hud_message::showerrormessage( %"hash_7402b58b8fecef10" );
    }
    
    return success;
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0x44ae7841, Offset: 0x801
// Size: 0x24
function private cancel( params )
{
    self notify( #"cancel_super_survival_life_drain" );
    supers_mp::reducesuperusepercent( 1 );
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0xc8ab01d4, Offset: 0x82d
// Size: 0xbf, Type: bool
function private apply_effect_squad( bundle )
{
    foreach ( squadmate in self.var_b71dd0a90750706f )
    {
        if ( squadmate == self )
        {
            function_eb0e0f130d053987( bundle );
        }
        else
        {
            var_cd34803eda35ad4b = bundle.var_c4817e2648ac0d95;
            
            if ( var_cd34803eda35ad4b )
            {
                function_9b0065d6803f0742( squadmate, var_cd34803eda35ad4b );
            }
        }
        
        squadmate apply_effect_to_player( self, bundle );
    }
    
    return true;
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0x1537f69e, Offset: 0x8f5
// Size: 0xeb, Type: bool
function private apply_effect_single( bundle )
{
    if ( self.inlaststand )
    {
        var_97c975153dd5113f = self;
    }
    else
    {
        foreach ( player in self.var_b71dd0a90750706f )
        {
            if ( player.inlaststand )
            {
                var_97c975153dd5113f = player;
                break;
            }
        }
    }
    
    if ( var_97c975153dd5113f )
    {
        self.var_b71dd0a90750706f = [];
        self.var_b71dd0a90750706f[ self.var_b71dd0a90750706f.size ] = var_97c975153dd5113f;
        var_97c975153dd5113f function_eb0e0f130d053987( bundle );
        var_97c975153dd5113f apply_effect_to_player( self, bundle );
        return true;
    }
    
    return false;
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0x7c2752da, Offset: 0x9e9
// Size: 0x6a
function private function_f5762c7aecaf6c64( radius )
{
    assert( radius, "<dev string:x130>" );
    
    if ( isbrgamemode() )
    {
        team = self.team;
    }
    
    squadmates = squad_utility::getsquadmembers( team, 1 );
    players_in_radius = getplayersinradius( self.origin, radius, radius, 0, squadmates );
    return players_in_radius;
}

// Namespace survival_life_drain
// Params 0, eflags: 0x4
// Checksum 0x2d760af2, Offset: 0xa5c
// Size: 0x21
function private fully_heal()
{
    assert( isplayer( self ) );
    self.health = self.maxhealth;
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0x475982f, Offset: 0xa85
// Size: 0x1e
function private function_6f69126f4c79357b( state_name )
{
    self setscriptablepartstate( #"survival_life_drain_fx", state_name, 0 );
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0xd63244e, Offset: 0xaab
// Size: 0x130
function private stun_nearby_enemies( bundle )
{
    stun_radius = bundle.var_8cdf59c0a3fa0f45;
    stun_duration = bundle.survival_life_drain_stunduration;
    assert( stun_radius, "<dev string:x15c>" );
    assert( stun_duration, "<dev string:x18d>" );
    var_fdc5e4472f1e2a76 = getaiarrayinradius( self.origin, stun_radius );
    
    foreach ( current_enemy in var_fdc5e4472f1e2a76 )
    {
        if ( current_enemy.team != self.team )
        {
            current_enemy.var_96527d1d3c7cdb7e = 1;
            current_enemy zombie_stun::stun_ai( stun_duration );
            
            if ( bundle.var_12efb49f9a610737 )
            {
                namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( bundle.var_12efb49f9a610737 );
            }
            
            current_enemy thread function_75f3cf4d8346732b( stun_duration );
        }
    }
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0x1b64cac0, Offset: 0xbe3
// Size: 0x25
function private function_75f3cf4d8346732b( duration )
{
    self endon( #"death" );
    wait duration;
    self.var_96527d1d3c7cdb7e = undefined;
}

// Namespace survival_life_drain
// Params 2, eflags: 0x4
// Checksum 0xb0b8d66a, Offset: 0xc10
// Size: 0xe2
function private apply_effect_to_player( owner, bundle )
{
    buff_overlay = get_buff_overlay( bundle );
    val::set( "survival_life_drain_invulnerability", "damage_protection_pgb_post_fx", buff_overlay );
    function_6f69126f4c79357b( #"super_fx_on" );
    function_d2305a34d0a083e0( 1 );
    
    if ( self == owner )
    {
        var_98bd41795dc40ef9 = owner utility::callsharedfunc( "super_survival_life_drain", #"hash_c07e6164b9ac6a24" );
        
        if ( var_98bd41795dc40ef9 )
        {
            thread function_4b25bc0f4ec97d38( var_98bd41795dc40ef9 );
        }
    }
    
    score_event_name = get_buff_score_event( owner, bundle );
    
    if ( self.inlaststand )
    {
        revive_player( owner );
        score_event_name = get_revive_score_event( owner, bundle );
    }
    
    self.var_41e03581d6136136 = 1;
    self.var_b5c44a0f2a714640 = owner;
    
    if ( score_event_name )
    {
        owner points::doscoreevent( score_event_name );
    }
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0x46c9cbb7, Offset: 0xcfa
// Size: 0x19a
function private function_4b25bc0f4ec97d38( refill_data )
{
    self endon( #"death_or_disconnect" );
    
    if ( self.inlaststand )
    {
        self waittill( #"last_stand_exit" );
        weapon_switch_in_progress = inventory_utility::isanymonitoredweaponswitchinprogress();
        
        if ( weapon_switch_in_progress )
        {
            self waittill( #"weapon_change" );
        }
    }
    
    if ( refill_data.currentweaponstockammo )
    {
        current_weapon = self getcurrentweapon();
        
        if ( !weapon::iskillstreakweapon( current_weapon.basename ) )
        {
            current_weapon_max_ammo = weaponmaxammo( current_weapon );
            self setweaponammostock( current_weapon, current_weapon_max_ammo );
        }
    }
    
    if ( refill_data.currentweaponclipammo )
    {
        current_weapon = self getcurrentweapon();
        
        if ( !weapon::iskillstreakweapon( current_weapon.basename ) )
        {
            max_clip_ammo = weaponclipsize( current_weapon );
            self setweaponammoclip( current_weapon, max_clip_ammo );
        }
    }
    
    if ( refill_data.var_d923a574ac8311d4 )
    {
        var_7dfa03ff264c8d9f = armor::function_22290101992e4874();
        var_57fa852a339c1cb8 = armor::function_db9ebf086f67fe92();
        
        if ( var_7dfa03ff264c8d9f < var_57fa852a339c1cb8 )
        {
            var_cccab8116b89dd24 = var_57fa852a339c1cb8 - var_7dfa03ff264c8d9f;
            armor::function_164c824617d7e8d7( var_cccab8116b89dd24 );
        }
    }
    
    if ( refill_data.lethalequipment )
    {
        primary_equip_ref = equipment_mp::getcurrentequipment( "primary" );
        
        if ( primary_equip_ref )
        {
            current_ammo = equipment_mp::getequipmentammo( primary_equip_ref );
            max_ammo = equipment_mp::getequipmentmaxammo( primary_equip_ref );
            
            if ( current_ammo < max_ammo )
            {
                var_661941a7f5882631 = max_ammo - current_ammo;
                equipment_mp::incrementequipmentammo( primary_equip_ref, var_661941a7f5882631 );
            }
        }
    }
}

// Namespace survival_life_drain
// Params 2, eflags: 0x4
// Checksum 0x185b6e0e, Offset: 0xe9c
// Size: 0x44
function private get_buff_score_event( owner, bundle )
{
    if ( self == owner )
    {
        return;
    }
    
    if ( squad_utility::function_6a77a8d0f8eb25b5( self, owner ) )
    {
        return bundle.var_c3513bf2be0449fa;
    }
    
    return bundle.var_278a291521f7979c;
}

// Namespace survival_life_drain
// Params 2, eflags: 0x4
// Checksum 0x3f247f64, Offset: 0xee8
// Size: 0x4f
function private get_revive_score_event( owner, bundle )
{
    if ( self == owner )
    {
        return bundle.var_ea369b996e843b79;
    }
    
    if ( squad_utility::function_6a77a8d0f8eb25b5( self, owner ) )
    {
        return bundle.var_4d16e08195d73d07;
    }
    
    return bundle.var_cc00adc6b8561e9;
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0x9ef3b3f2, Offset: 0xf3f
// Size: 0x2a
function private function_eb0e0f130d053987( bundle )
{
    fully_heal();
    
    if ( bundle.var_8cdf59c0a3fa0f45 )
    {
        stun_nearby_enemies( bundle );
    }
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0xd37c05b4, Offset: 0xf71
// Size: 0xc1
function private function_d2305a34d0a083e0( should_show )
{
    squadmates = squad_utility::getsquadmembers( undefined, 1 );
    
    foreach ( player in squadmates )
    {
        if ( should_show )
        {
            val::set( "survival_life_drain_invulnerability", "damage_protection_omnvar", "ui_squadmate_show_damage_protection_" + self.sessionuimemberindex );
            continue;
        }
        
        val::reset( "survival_life_drain_invulnerability", "damage_protection_omnvar" );
    }
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0x301282b9, Offset: 0x103a
// Size: 0x80
function private revive_player( reviver )
{
    if ( !isdefined( self.revivesource ) )
    {
        self.revivesource = [];
    }
    
    self.revivesource[ reviver getguid() ] = #"super_survival_life_drain";
    laststand::function_75e6bc3d39e1f2bb( reviver, "last_stand_revived_healing_aura" );
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_f32d27d0e19d136a" ) )
    {
        thread utility::callsharedfunc( #"zombie", #"hash_f32d27d0e19d136a", 1 );
    }
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0x1e3a5980, Offset: 0x10c2
// Size: 0x4d
function private function_e0ca5e7e9c49b29d( bundle )
{
    buff_overlay = get_buff_overlay( bundle );
    val::reset( "survival_life_drain_invulnerability", "damage_protection_pgb_post_fx" );
    self.var_41e03581d6136136 = undefined;
    function_d2305a34d0a083e0( 0 );
    self.var_b5c44a0f2a714640 = undefined;
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0xe2ce2c67, Offset: 0x1117
// Size: 0x23, Type: bool
function private get_buff_overlay( bundle )
{
    return bundle.var_812052834ff43b82 ?? %"cer_mp_rallyingcry";
}

// Namespace survival_life_drain
// Params 2, eflags: 0x4
// Checksum 0x6e18b01b, Offset: 0x1143
// Size: 0x8a
function private end_use( fromdeath, attacker )
{
    level callback::remove( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_survival_life_drain" );
    remove_effect( bundle );
    
    if ( bundle.var_8b9eade13fbfb044 )
    {
        assert( callback::exists( #"super_cancel", &cancel ) );
        callback::remove( #"super_cancel", &cancel );
    }
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0x6f3e7bb5, Offset: 0x11d5
// Size: 0xa2
function private remove_effect( bundle )
{
    foreach ( buffedplayer in self.var_b71dd0a90750706f )
    {
        buffedplayer function_6f69126f4c79357b( #"super_fx_off" );
        buffedplayer function_e0ca5e7e9c49b29d( bundle );
    }
    
    self.var_b71dd0a90750706f = undefined;
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0x4e01ad05, Offset: 0x127f
// Size: 0xb6
function private function_8c5e06ee1e60aeb7( sparams )
{
    if ( !isplayer( sparams.eattacker ) )
    {
        return;
    }
    
    var_d1af3da2bb5ff67c = undefined;
    score_event_name = undefined;
    
    if ( sparams.eattacker supers_mp::function_d703a675aad9f961( "super_survival_life_drain" ) )
    {
        var_d1af3da2bb5ff67c = sparams.eattacker;
        score_event_name = #"super_survival_life_drain_kill";
    }
    else if ( sparams.eattacker supers_mp::function_fb6534db15e3869c( "super_survival_life_drain" ) )
    {
        var_d1af3da2bb5ff67c = sparams.eattacker.var_b5c44a0f2a714640;
        score_event_name = #"super_survival_life_drain_assist";
    }
    
    if ( var_d1af3da2bb5ff67c )
    {
        var_d1af3da2bb5ff67c points::doscoreevent( score_event_name );
    }
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0x2136fa3d, Offset: 0x133d
// Size: 0x42
function private on_player_laststand_enter( params )
{
    self endon( #"death" );
    superref = supers_mp::getcurrentsuperref();
    
    if ( superref && superref == "super_survival_life_drain" )
    {
        childthread supers_mp::beginsuperuse();
    }
}

// Namespace survival_life_drain
// Params 1, eflags: 0x4
// Checksum 0x278fb4fd, Offset: 0x1387
// Size: 0x12c
function private function_3e825889d342048f( params )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_survival_life_drain" );
    scriptable_part = bundle.var_cbc3b43e1016ebdc;
    scriptable_state = bundle.var_2d567174c2c84c6e;
    
    if ( scriptable_part && scriptable_state )
    {
        utility::function_7c10ea82c1e305b8( scriptable_part, scriptable_state );
    }
    
    var_bde44e01bb0d0136 = bundle.var_a4630911077cf44d;
    
    if ( var_bde44e01bb0d0136 )
    {
        utility::callsharedfunc( #"fullscreenfx", #"hash_382df7654f0561bd", { #postfxbundlename:var_bde44e01bb0d0136 }, 1, 1 );
    }
    
    if ( params.idamage && params.victim )
    {
        if ( utility::issharedfuncdefined( #"challenges", #"hash_331a82c13105b9dd" ) )
        {
            params.victim [[ utility::getsharedfunc( #"challenges", #"hash_331a82c13105b9dd" ) ]]( { #lootid:bundle.lootid, #idamage:params.idamage } );
        }
    }
}

// Namespace survival_life_drain
// Params 0, eflags: 0x4
// Checksum 0x578e0932, Offset: 0x14bb
// Size: 0x3e
function private function_482eeea96efb7057()
{
    waitframe();
    
    if ( self )
    {
        bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_survival_life_drain" );
        
        if ( bundle.var_28f50cc5b9dac317 )
        {
            self setclientomnvar( bundle.var_28f50cc5b9dac317, 0 );
        }
    }
}

/#

    // Namespace survival_life_drain
    // Params 1, eflags: 0xc
    // Checksum 0x4630e66c, Offset: 0x1501
    // Size: 0x83, Type: dev
    function private function_c16ab21f85281427( radius )
    {
        self notify( #"hash_a4cf99391e81f02b" );
        self endon( #"hash_a4cf99391e81f02b" );
        
        while ( true )
        {
            text_distance = "<dev string:x1c0>" + string( radius );
            printtoscreen2d( 500, 350, text_distance, ( 1, 1, 1 ), 2 );
            sphere( self.origin, radius, ( 0, 1, 0 ), 1 );
            waitframe();
        }
    }

#/
