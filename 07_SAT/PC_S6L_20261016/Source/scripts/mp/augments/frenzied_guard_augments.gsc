// scripts\mp\augments\frenzied_guard_augments.gsc  (hash_6ffb3e863b0e994b.gscc) (size: 8838 Bytes / 0x2286 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa752ff19 (2807234329)
// size ...... 8838 (0x2286)
// includes .. 10  (offset: 0x2052)
// strings ... 29  (offset: 0x20a2)
// dev strs .. 0   (offset: 0x2286)
// exports ... 15  (offset: 0x163e)
// cseg ...... 0x2ee + 0x1350 (0x163e)
// imports ... 62  (offset: 0x1896)
// animtree1 . 0   (offset: 0x2286)
// animtree2 . 0   (offset: 0x2286)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\armor;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;

#namespace frenzied_guard_augments;

// Namespace frenzied_guard_augments
// Params 0, eflags: 0x5
// Checksum 0x54899c9d, Offset: 0x30c
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"frenzied_guard_augments", undefined, undefined, &init_frenzied_guard_augments );
}

// Namespace frenzied_guard_augments
// Params 0
// Checksum 0x634b983f, Offset: 0x32d
// Size: 0xc9
function init_frenzied_guard_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    callback::add( "on_frenzied_guard_start", &on_frenzied_guard_start );
    callback::add( "on_frenzied_guard_end", &on_frenzied_guard_end );
    callback::add( #"player_damaged", &function_e81812360b62df89 );
    callback::add( #"player_disconnect", &function_f22b867628897c05 );
    callback::add( "end_group_frenzy", &function_f22b867628897c05 );
    
    if ( isdefined( level.zombie_augments[ #"frenzied_guard_retribution" ] ) )
    {
        retributionfx = level.zombie_augments[ #"frenzied_guard_retribution" ].var_9c428a695fb1a65c;
        
        if ( isdefined( retributionfx ) )
        {
            level._effect[ "frenzied_retribution_fx" ] = loadfxasset( retributionfx );
        }
    }
}

// Namespace frenzied_guard_augments
// Params 1
// Checksum 0xd4530a8e, Offset: 0x3fe
// Size: 0x2eb
function on_frenzied_guard_start( sparams )
{
    thread function_448f8d85c24776bd();
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frenzied_guard_fists_of_frenzy" ) )
    {
        thread function_2c005fa2be240c38();
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frenzied_guard_high_defense" ) )
    {
        self.var_b383d46f0fbe700 = level.zombie_augments[ #"frenzied_guard_high_defense" ].var_b383d46f0fbe700 ?? 150;
        self.var_638eb8a47c8ee352 = level.zombie_augments[ #"frenzied_guard_high_defense" ].var_b383d46f0fbe700 ?? 150;
        self.var_8c594113e8ed3d60 = 1;
        armor::setarmoromnvars();
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frenzied_guard_frenzy_fire" ) )
    {
        perk::giveperk( "specialty_ammodrainsfromstockfirst" );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frenzied_guard_retribution" ) )
    {
        if ( self getscriptableparthasstate( "frenzied_guard_retribution_fx", "frenzied_guard_retribution_on" ) )
        {
            self setscriptablepartstate( "frenzied_guard_retribution_fx", "frenzied_guard_retribution_on" );
        }
        
        thread function_6d9e6cf8e7e41be6();
        thread frenzied_guard_retribution_thread();
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frenzied_guard_phalanx" ) )
    {
        thread frenzied_guard_phalanx_thread();
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frenzied_guard_rally" ) )
    {
        rallyrange = level.zombie_augments[ #"frenzied_guard_rally" ].var_8b6258aded194a23;
        nearbyplayers = getplayersinradius( self.origin, rallyrange, undefined, undefined, undefined, self.team );
        
        foreach ( player in nearbyplayers )
        {
            can_affect = 1;
            
            if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
            {
                can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, player );
            }
            
            if ( !can_affect )
            {
                continue;
            }
            
            if ( player != self && player getscriptableparthasstate( "frenzied_guard_rally_fx", "frenzied_guard_rally_on" ) )
            {
                player setscriptablepartstate( "frenzied_guard_rally_fx", "frenzied_guard_rally_on" );
                player thread function_6d9e6cf8e7e41be6();
            }
            
            player armor::setarmorhealth( player.maxarmorhealth );
        }
    }
}

// Namespace frenzied_guard_augments
// Params 0, eflags: 0x4
// Checksum 0x1472ebd1, Offset: 0x6f1
// Size: 0x53
function private function_6d9e6cf8e7e41be6()
{
    self endon( #"death_or_disconnect" );
    waitframe();
    
    if ( self getscriptableparthasstate( "frenzied_guard_rally_fx", "frenzied_guard_rally_off" ) )
    {
        self setscriptablepartstate( "frenzied_guard_rally_fx", "frenzied_guard_rally_off" );
    }
    
    if ( self getscriptableparthasstate( "frenzied_guard_retribution_fx", "frenzied_guard_retribution_off" ) )
    {
        self setscriptablepartstate( "frenzied_guard_retribution_fx", "frenzied_guard_retribution_off" );
    }
}

// Namespace frenzied_guard_augments
// Params 1
// Checksum 0xe7d3df45, Offset: 0x74c
// Size: 0x1be
function on_frenzied_guard_end( sparams )
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frenzied_guard_fists_of_frenzy" ) )
    {
        thread function_ca28f6328bcd8fe();
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frenzied_guard_high_defense" ) )
    {
        self.var_b383d46f0fbe700 = undefined;
        self.var_638eb8a47c8ee352 = undefined;
        self.var_8c594113e8ed3d60 = undefined;
        armor::setarmoromnvars();
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frenzied_guard_frenzy_fire" ) )
    {
        perk::removeperk( "specialty_ammodrainsfromstockfirst" );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"frenzied_guard_phalanx" ) && isdefined( self.var_77cb3def72f91ae8 ) )
    {
        foreach ( player in self.var_77cb3def72f91ae8 )
        {
            if ( player.group_frenzied_guard_active )
            {
                self.var_77cb3def72f91ae8 = arrayremove( self.var_77cb3def72f91ae8, player );
                player.group_frenzied_guard_active = undefined;
                
                if ( !player.solo_frenzied_guard_active )
                {
                    player thread set_group_frenzy( 0 );
                    player notify( #"end_frenzied_guard" );
                    player.parentfrenzy = undefined;
                }
            }
        }
        
        self.var_77cb3def72f91ae8 = undefined;
    }
}

// Namespace frenzied_guard_augments
// Params 0, eflags: 0x4
// Checksum 0x7fb0b6c4, Offset: 0x912
// Size: 0x227
function private frenzied_guard_retribution_thread()
{
    self endon( #"death_or_disconnect", #"end_frenzied_guard" );
    range = level.zombie_augments[ #"frenzied_guard_retribution" ].var_412c2d809adca770 ?? 120;
    var_2b5d1dc7ccc7c88 = level.zombie_augments[ #"frenzied_guard_retribution" ].var_e2079785ee31994b ?? 0.5;
    zombies = getaiarrayinradius( self.origin, range );
    
    if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
    {
        zombies = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( zombies, self );
    }
    
    if ( zombies.size > 0 )
    {
        round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
        zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        damage = zombie_base_health * var_2b5d1dc7ccc7c88;
        
        foreach ( zombie in zombies )
        {
            if ( zombie.aicategory == "normal" )
            {
                zombie zombie_knockdown::function_6fc167d4a3590991( self.origin );
            }
            
            self playrumbleonentity( "damage_light" );
            self earthquakeforplayer( 0.2, 1, self.origin, 100 );
            
            if ( zombie.health - damage <= 0 )
            {
                zombie.var_6b1845284e358d3e = 1;
                zombie.forceannihilate = 1;
            }
            
            zombie dodamage( damage, self.origin, self, self, "MOD_UNKNOWN", "<explicitweaponnone>", "none", undefined, 1073807360 );
            wait level.framedurationseconds ?? 0.2;
        }
    }
}

// Namespace frenzied_guard_augments
// Params 1, eflags: 0x4
// Checksum 0xf43a235b, Offset: 0xb41
// Size: 0xdc
function private set_group_frenzy( bon = 0 )
{
    self endon( #"death_or_disconnect" );
    utility::ent_flag_init( "frenzied_guard_active" );
    
    if ( bon )
    {
        utility::ent_flag_set( "frenzied_guard_active" );
        self.group_frenzied_guard_active = 1;
        postfxbundle = level.field_upgrade_bundles[ "super_frenzied_guard" ].var_6a566dda6f666c3b;
        pbgpostfxbundlestart( self, postfxbundle );
        waitframe();
        
        if ( isalive( self ) )
        {
            self setscriptablepartstate( "frenzied_guard_fx", "super_fx_on", 0 );
        }
        
        return;
    }
    
    postfxbundle = level.field_upgrade_bundles[ "super_frenzied_guard" ].var_6a566dda6f666c3b;
    pbgpostfxbundleend( self, postfxbundle );
    self setscriptablepartstate( "frenzied_guard_fx", "super_fx_deactivate", 0 );
    utility::ent_flag_clear( "frenzied_guard_active" );
    self.group_frenzied_guard_active = undefined;
}

// Namespace frenzied_guard_augments
// Params 0
// Checksum 0x99e30eac, Offset: 0xc25
// Size: 0xd6
function function_448f8d85c24776bd()
{
    self notify( #"hash_200dc0c7dc620be6" );
    self endon( #"hash_200dc0c7dc620be6" );
    level endon( #"game_ended" );
    str_team = self.team;
    wait 60;
    
    foreach ( player in level.players )
    {
        if ( str_team == player.team && player.group_frenzied_guard_active )
        {
            player set_group_frenzy( 0 );
        }
    }
}

// Namespace frenzied_guard_augments
// Params 1
// Checksum 0x504d334d, Offset: 0xd03
// Size: 0x31b
function function_f22b867628897c05( sparams )
{
    self notify( #"hash_e89387d3e5b5b15" );
    self endon( #"hash_e89387d3e5b5b15" );
    
    if ( utility::ent_flag( "frenzied_guard_active" ) && utility::callsharedfunc( #"zombie", #"player_has_augment", #"frenzied_guard_phalanx" ) )
    {
        n_radius = level.zombie_augments[ #"frenzied_guard_phalanx" ].var_2ff67af3f7f78f11 ?? 500;
        n_radius *= n_radius;
        
        foreach ( player in level.players )
        {
            if ( self == player || self.team != player.team )
            {
                continue;
            }
            
            if ( player.solo_frenzied_guard_active )
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
            
            if ( distance2dsquared( player.origin, self.origin ) < n_radius )
            {
                b_remove_frenzied_guard = 1;
                
                if ( player.group_frenzied_guard_active )
                {
                    foreach ( other_player in level.players )
                    {
                        if ( player == other_player || self.team != other_player.team )
                        {
                            continue;
                        }
                        
                        if ( distance2dsquared( player.origin, other_player.origin ) < n_radius && other_player.solo_frenzied_guard_active && !player::isinlaststand( other_player ) && other_player utility::callsharedfunc( #"zombie", #"player_has_augment", #"frenzied_guard_phalanx" ) )
                        {
                            can_affect = 1;
                            
                            if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
                            {
                                can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( other_player, player );
                            }
                            
                            if ( can_affect )
                            {
                                b_remove_frenzied_guard = 0;
                                break;
                            }
                        }
                    }
                }
                
                if ( b_remove_frenzied_guard )
                {
                    player thread set_group_frenzy( 0 );
                    player notify( #"end_frenzied_guard" );
                    player.group_frenzied_guard_active = undefined;
                }
            }
        }
    }
}

// Namespace frenzied_guard_augments
// Params 0, eflags: 0x4
// Checksum 0x8dbeb99c, Offset: 0x1026
// Size: 0x223
function private frenzied_guard_phalanx_thread()
{
    self endon( #"death_or_disconnect", #"end_frenzied_guard" );
    n_radius = level.zombie_augments[ #"frenzied_guard_phalanx" ].var_2ff67af3f7f78f11 ?? 500;
    n_radius *= n_radius;
    self.var_77cb3def72f91ae8 = [];
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player == self || self.team != player.team )
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
            
            if ( distance2dsquared( player.origin, self.origin ) <= n_radius )
            {
                if ( !player.group_frenzied_guard_active )
                {
                    if ( !player.solo_frenzied_guard_active )
                    {
                        self.var_77cb3def72f91ae8[ self.var_77cb3def72f91ae8.size ] = player;
                        player.group_frenzied_guard_active = 1;
                        player thread set_group_frenzy( 1 );
                        player.parentfrenzy = self;
                    }
                }
                
                continue;
            }
            
            if ( player.group_frenzied_guard_active )
            {
                self.var_77cb3def72f91ae8 = arrayremove( self.var_77cb3def72f91ae8, player );
                player.group_frenzied_guard_active = undefined;
                player.parentfrenzy = undefined;
                
                if ( !player.solo_frenzied_guard_active )
                {
                    player thread set_group_frenzy( 0 );
                    player notify( #"end_frenzied_guard" );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace frenzied_guard_augments
// Params 1, eflags: 0x4
// Checksum 0xfe01b9c2, Offset: 0x1251
// Size: 0x13a
function private function_57484f934fb86683( zombie )
{
    self endon( #"death_or_disconnect" );
    waitframe();
    
    if ( isplayer( self ) && isalive( zombie ) )
    {
        var_2b5d1dc7ccc7c88 = level.zombie_augments[ #"frenzied_guard_retribution" ].var_e2079785ee31994b ?? 0.5;
        round_difficulty = zombie zombie_utils::get_zombie_round_difficulty();
        zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
        damage = int( zombie_base_health * var_2b5d1dc7ccc7c88 );
        damage++;
        
        if ( zombie.aicategory == "normal" )
        {
            zombie zombie_knockdown::function_6fc167d4a3590991( self.origin );
        }
        
        self playrumbleonentity( "damage_light" );
        self earthquakeforplayer( 0.2, 1, self.origin, 100 );
        
        if ( zombie.health - damage <= 0 )
        {
            zombie.var_6b1845284e358d3e = 1;
            zombie.forceannihilate = 1;
        }
        
        zombie dodamage( damage, self.origin, self, self, "MOD_UNKNOWN", "<explicitweaponnone>", "none", undefined, 1073807360 );
    }
}

// Namespace frenzied_guard_augments
// Params 1, eflags: 0x4
// Checksum 0x1fea5827, Offset: 0x1393
// Size: 0x145
function private function_e81812360b62df89( sparams )
{
    if ( isplayer( self ) && sparams.eattacker.type == "zombie" && isalive( sparams.eattacker ) && sparams.smeansofdeath == "MOD_MELEE" )
    {
        if ( utility::ent_flag( "frenzied_guard_active" ) && utility::callsharedfunc( #"zombie", #"player_has_augment", #"frenzied_guard_retribution" ) )
        {
            if ( self getscriptableparthasstate( "frenzied_guard_retribution_fx", "frenzied_guard_retribution_hit" ) )
            {
                self setscriptablepartstate( "frenzied_guard_retribution_fx", "frenzied_guard_retribution_hit" );
            }
            
            if ( isdefined( level._effect[ "frenzied_retribution_fx" ] ) )
            {
                fxorigin = ( sparams.eattacker.origin[ 0 ], sparams.eattacker.origin[ 1 ], sparams.eattacker.origin[ 2 ] + 48 );
                playfx( utility::getfx( "frenzied_retribution_fx" ), fxorigin );
            }
            
            thread function_6d9e6cf8e7e41be6();
            thread function_57484f934fb86683( sparams.eattacker );
        }
    }
}

// Namespace frenzied_guard_augments
// Params 0, eflags: 0x4
// Checksum 0x5557c9de, Offset: 0x14e0
// Size: 0x8e
function private function_2c005fa2be240c38()
{
    self.var_1ca6533426e9abfe = self getcurrentweapon();
    fist_weapon = level.defaultfist ?? "t10_me_fists";
    
    if ( !self hasweapon( fist_weapon ) )
    {
        self giveweapon( fist_weapon );
    }
    
    self switchtoweaponimmediate( fist_weapon );
    val::set( "frenzied_guard_augment", "weapon_switch", 0 );
    val::set( "frenzied_guard_augment", "disallow_loot_but_auto_loot", 1 );
    self.var_432159241a2f9367 = 1;
    self.var_e830497a1d286f74 = 1;
    self.var_fb567d2e89888013 = 1;
}

// Namespace frenzied_guard_augments
// Params 0, eflags: 0x4
// Checksum 0xb6064235, Offset: 0x1576
// Size: 0xc8
function private function_ca28f6328bcd8fe()
{
    fist_weapon = level.defaultfist ?? "t10_me_fists";
    
    if ( self hasweapon( fist_weapon ) )
    {
        self takeweapon( fist_weapon );
    }
    
    val::reset( "frenzied_guard_augment", "weapon_switch" );
    val::reset( "frenzied_guard_augment", "disallow_loot_but_auto_loot" );
    
    if ( !player::isinlaststand( self ) )
    {
        if ( isweapon( self.var_1ca6533426e9abfe ) )
        {
            var_20231d0ef435c90e = self.var_1ca6533426e9abfe;
        }
        else
        {
            [ var_20231d0ef435c90e ] = self getweaponslistprimaries();
        }
        
        self switchtoweaponimmediate( var_20231d0ef435c90e );
    }
    
    self.var_1ca6533426e9abfe = undefined;
    self.var_432159241a2f9367 = undefined;
    self.var_e830497a1d286f74 = undefined;
    self.var_fb567d2e89888013 = undefined;
}

