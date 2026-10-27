// scripts\mp\augments\healing_aura_augments.gsc  (hash_2b7a4e867f583b30.gscc) (size: 8851 Bytes / 0x2293 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4428d528 (1143526696)
// size ...... 8851 (0x2293)
// includes .. 13  (offset: 0x2113)
// strings ... 19  (offset: 0x217b)
// dev strs .. 0   (offset: 0x2293)
// exports ... 21  (offset: 0x160b)
// cseg ...... 0x212 + 0x13f9 (0x160b)
// imports ... 63  (offset: 0x1953)
// animtree1 . 0   (offset: 0x2293)
// animtree2 . 0   (offset: 0x2293)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\armor;
#using scripts\mp\common\field_upgrades\field_upgrades;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\equipment;
#using scripts\mp\health_overcharge;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\playerlogic;

#namespace healing_aura_augments;

// Namespace healing_aura_augments
// Params 0, eflags: 0x5
// Checksum 0xd7863d20, Offset: 0x230
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"healing_aura_augments", undefined, &init_healing_aura_augments, undefined );
}

// Namespace healing_aura_augments
// Params 0
// Checksum 0x96cec7b1, Offset: 0x251
// Size: 0x79
function init_healing_aura_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    callback::add( #"player_connect", &healing_aura_augments_on_player_connect );
    callback::add( #"player_death", &healing_aura_augments_on_death );
    callback::add( #"hash_9741c7ee14b21924", &function_b03d10fe901028a1 );
    callback::add( #"player_spawned", &healing_aura_augments_on_spawn );
    callback::add( #"player_laststand_revived", &function_82bc85b2ce2b4cb2 );
}

// Namespace healing_aura_augments
// Params 1
// Checksum 0x1cbaf1a3, Offset: 0x2d2
// Size: 0x2e
function healing_aura_augments_on_player_connect( params )
{
    callback::add( "player_used_healing_aura", &function_802e518785a4f64a );
    callback::add( "on_healingaura_healed", &on_healingaura_healed );
}

// Namespace healing_aura_augments
// Params 1
// Checksum 0x5ed21498, Offset: 0x308
// Size: 0x125
function healing_aura_augments_on_death( params )
{
    var_9f6970c93764d03f = 0;
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && player utility::callsharedfunc( #"zombie", #"player_has_augment", #"healingaura_necromancer" ) )
        {
            can_affect = 1;
            
            if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
            {
                can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( player, self );
            }
            
            var_9f6970c93764d03f = can_affect;
        }
    }
    
    if ( var_9f6970c93764d03f )
    {
        self.num_perks_decay = 0;
        zombie_perks::function_c11ba4bb3d0a676b( 1 );
        self.var_f2826da4c1d205c2 = 1;
    }
}

// Namespace healing_aura_augments
// Params 0, eflags: 0x4
// Checksum 0x13f6c0b7, Offset: 0x435
// Size: 0xc, Type: bool
function private function_b0c3afecd86b784b()
{
    return istrue( self.var_f2826da4c1d205c2 );
}

// Namespace healing_aura_augments
// Params 0, eflags: 0x4
// Checksum 0x7b129405, Offset: 0x44a
// Size: 0xc
function private function_49af5f8c0ed7291c()
{
    self.var_f2826da4c1d205c2 = undefined;
}

// Namespace healing_aura_augments
// Params 0, eflags: 0x4
// Checksum 0x68c12e7b, Offset: 0x45e
// Size: 0x49
function private function_2522e090ac57bbb7()
{
    if ( istrue( self.var_1584d4e76cc755b1 ) )
    {
        if ( isdefined( self.a_saved_weapons ) && self.a_saved_weapons[ "save_source" ] == "healing_aura_augments" )
        {
            self.a_saved_weapons = undefined;
        }
    }
    
    self.var_1584d4e76cc755b1 = undefined;
}

// Namespace healing_aura_augments
// Params 1
// Checksum 0x60f19479, Offset: 0x4af
// Size: 0xd5
function function_b03d10fe901028a1( params )
{
    foreach ( player in level.players )
    {
        if ( player != self && istrue( player utility::callsharedfunc( #"zombie", #"player_has_augment", #"healingaura_necromancer" ) ) )
        {
            utility::callsharedfunc( #"zombie", #"save_loadout", "healing_aura_augments" );
            self.var_1584d4e76cc755b1 = 1;
            return;
        }
    }
}

// Namespace healing_aura_augments
// Params 1
// Checksum 0xff1542bd, Offset: 0x58c
// Size: 0x3b0
function healing_aura_augments_on_spawn( sparams )
{
    self endon( #"death_or_disconnect" );
    
    if ( self.var_d6ab1ae1af095f90 )
    {
        self.var_d6ab1ae1af095f90 = undefined;
        self.var_ec38617d35c96690 = 1;
        self.var_dd1463085e5c5240 = 1;
        self.var_fba35c30b168d4c = undefined;
        b_skip_tactical_equipment = 0;
        tactical_equipment_ref = undefined;
        tactical_equipment_ammo = undefined;
        
        if ( isdefined( self.a_saved_weapons ) && isdefined( self.a_saved_weapons[ "equip_secondary" ][ "weapon" ] ) )
        {
            saved_tactical_equipment = self.a_saved_weapons[ "equip_secondary" ][ "weapon" ];
            var_102837fee0ea02c3 = getscriptbundle( saved_tactical_equipment.name );
            
            if ( isdefined( var_102837fee0ea02c3 ) && ( var_102837fee0ea02c3.ref == "equip_grappling_hook" || var_102837fee0ea02c3.ref == "equip_grappling_hook_upgraded" ) )
            {
                b_skip_tactical_equipment = 1;
                
                if ( isdefined( self.var_87522aee8be7890b ) && isdefined( self.var_87522aee8be7890b.ref ) )
                {
                    tactical_equipment_ref = self.var_87522aee8be7890b.ref;
                    tactical_equipment_ammo = self.var_87522aee8be7890b.ammo;
                }
            }
        }
        
        respawn_weapon = self.var_97fab3b324c4c972;
        respawn_pap_level = self.var_8e2afd0861231a4f;
        respawn_rarity = self.healing_aura_secondary_weapon_rarity;
        self.var_97fab3b324c4c972 = undefined;
        self.var_8e2afd0861231a4f = undefined;
        self.healing_aura_secondary_weapon_rarity = undefined;
        var_34c9dcb053df0fd4 = 1;
        
        if ( isweapon( respawn_weapon ) && weapon::iswonderweapon( respawn_weapon ) )
        {
            var_34c9dcb053df0fd4 = 0;
        }
        
        utility::callsharedfunc( #"zombie", #"restore_loadout", respawn_weapon, 0, 0, b_skip_tactical_equipment, 1, undefined, var_34c9dcb053df0fd4 );
        function_2522e090ac57bbb7();
        inventory_utility::forcevalidweapon( respawn_weapon );
        
        if ( isdefined( tactical_equipment_ref ) )
        {
            equipment_mp::giveequipment( tactical_equipment_ref, "secondary" );
            equipment_mp::setequipmentammo( tactical_equipment_ref, tactical_equipment_ammo );
        }
        
        thread switch_thread( respawn_weapon, respawn_pap_level, respawn_rarity );
        function_49af5f8c0ed7291c();
        
        if ( self.var_d43f0027cdfe15 )
        {
            self.var_d43f0027cdfe15 = undefined;
            lost_perks = self.var_a0c63f8db21c605b;
            lost_purchased_perks = self.var_f1650ed763b03141;
            var_e3077a702a449f55 = [];
            
            if ( lost_perks.size > 2 )
            {
                for ( i = 0; i < 2 ; i++ )
                {
                    var_e3077a702a449f55[ i ] = lost_perks[ i ];
                }
            }
            
            all_perks = arraycombine( self.bleedout_perks, var_e3077a702a449f55 );
            
            foreach ( perk in all_perks )
            {
                if ( !utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", perk ) )
                {
                    var_332f8b58377eacb4 = arraycontains( lost_purchased_perks, perk );
                    utility::callsharedfunc( #"loot_perks", #"hash_d60bebeaed508539", perk, var_332f8b58377eacb4 );
                    waitframe();
                }
            }
        }
        
        armor::givestartingarmor();
        return;
    }
    
    function_2522e090ac57bbb7();
    self.var_97fab3b324c4c972 = undefined;
    self.var_8e2afd0861231a4f = undefined;
    self.healing_aura_secondary_weapon_rarity = undefined;
    self.var_fba35c30b168d4c = undefined;
    function_49af5f8c0ed7291c();
}

// Namespace healing_aura_augments
// Params 3
// Checksum 0x523a1597, Offset: 0x944
// Size: 0xf2
function switch_thread( respawn_weapon, respawn_pap_level, respawn_rarity )
{
    self endon( #"death_or_disconnect" );
    waitframe();
    
    if ( !self )
    {
        return;
    }
    
    if ( isweapon( respawn_weapon ) && self hasweapon( respawn_weapon ) )
    {
        self switchtoweaponimmediate( respawn_weapon );
        utility::waittill_any_timeout( 5, "weapon_catchup_done" );
        
        if ( isdefined( respawn_pap_level ) && respawn_pap_level > 0 )
        {
            utility::callsharedfunc( #"pack_a_punch", #"hash_4fb89d74adceafac", respawn_weapon, respawn_pap_level, 1 );
        }
        
        if ( isdefined( respawn_rarity ) )
        {
            waitframe();
            item_weapon::function_40e1cbd0e1f47d1a( respawn_weapon, respawn_rarity, 1 );
        }
    }
    
    utility::callsharedfunc( #"pack_a_punch", #"hash_7f95018b0780f0f1" );
    utility::callsharedfunc( #"ammo_mod", #"hash_88a73fb490c01c96" );
    utility::callsharedfunc( #"zombie", #"hash_d7c108d9a9770758" );
    self setclientomnvar( "ui_scoreboard_enabled", 1 );
}

// Namespace healing_aura_augments
// Params 1
// Checksum 0x5f263829, Offset: 0xa3e
// Size: 0x24
function function_82bc85b2ce2b4cb2( params )
{
    self.var_fba35c30b168d4c = undefined;
    function_2522e090ac57bbb7();
    function_49af5f8c0ed7291c();
}

// Namespace healing_aura_augments
// Params 1
// Checksum 0xa62a1e00, Offset: 0xa6a
// Size: 0x27, Type: bool
function function_b3df40ddf4269465( augmentname )
{
    return istrue( utility::callsharedfunc( #"zombie", #"player_has_augment", augmentname ) );
}

// Namespace healing_aura_augments
// Params 0, eflags: 0x4
// Checksum 0x75825b, Offset: 0xa9a
// Size: 0x3d
function private function_1a924aaffa55106c()
{
    var_342f148abbadf983 = istrue( self.var_fba35c30b168d4c );
    var_ed71590e5be998cd = istrue( self.var_1584d4e76cc755b1 );
    
    if ( !var_342f148abbadf983 && !var_ed71590e5be998cd )
    {
        return 0;
    }
    
    return var_ed71590e5be998cd;
}

// Namespace healing_aura_augments
// Params 1
// Checksum 0xbb7f7b1c, Offset: 0xae0
// Size: 0x305
function function_802e518785a4f64a( params )
{
    if ( function_b3df40ddf4269465( #"healingaura_pillar_of_light" ) && utility::issharedfuncdefined( #"zombie", #"healing_aura_pillar" ) )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) && player.team == self.team )
            {
                can_affect = 1;
                
                if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
                {
                    can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, player );
                }
                
                if ( can_affect )
                {
                    level thread utility::callsharedfunc( #"zombie", #"healing_aura_pillar", self, player );
                }
            }
        }
    }
    
    if ( function_b3df40ddf4269465( #"healingaura_stoic_presence" ) )
    {
        duration = level.zombie_augments[ #"healingaura_stoic_presence" ].var_ef76181e96fa2c48 ?? 1.75;
        settings = field_upgrades::get_field_upgrade_bundle();
        var_73ab0f5e7a91fe45 = settings.enemy_knockdown_radius;
        thread zombie_utils::function_607ff821e430d594( self.origin, var_73ab0f5e7a91fe45, duration, self.team, 1 );
    }
    
    if ( function_b3df40ddf4269465( #"healingaura_bountiful_harvest" ) )
    {
        overhealamount = level.zombie_augments[ #"healingaura_bountiful_harvest" ].var_9e7d60df7759105b ?? 50;
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && player.team == self.team )
            {
                can_affect = 1;
                
                if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
                {
                    can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, player );
                }
                
                if ( can_affect )
                {
                    health_overcharge::function_f6da758a8ee4c988( player, "healingaura_bountiful_harvest", overhealamount );
                }
            }
        }
    }
    
    if ( function_b3df40ddf4269465( #"healingaura_resilience" ) )
    {
        thread start_resilience();
    }
    
    if ( function_b3df40ddf4269465( #"healingaura_necromancer" ) )
    {
        thread revive_dead();
    }
}

// Namespace healing_aura_augments
// Params 0
// Checksum 0x894f152b, Offset: 0xded
// Size: 0x345
function revive_dead()
{
    foreach ( player in level.players )
    {
        if ( !player function_b0c3afecd86b784b() )
        {
            continue;
        }
        
        if ( !isalive( player ) || player.sessionstate == "spectator" )
        {
            if ( utility::issharedfuncdefined( #"instanceInventory", #"inventoryisvalid" ) )
            {
                while ( !level.var_8671749938fb45db && !utility::callsharedfunc( #"instanceInventory", #"inventoryisvalid", self ) )
                {
                    waitframe();
                }
            }
            
            player thread playerlogic::removespawnmessageshortly( 0.1 );
            player.var_14955bc056bab547 = 1;
            var_6a1e141315b5d05d = 0;
            
            foreach ( perk in player.bleedout_perks )
            {
                if ( perk == "specialty_quickrevive" )
                {
                    var_6a1e141315b5d05d = 1;
                }
            }
            
            if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_quickrevive", #"quick_revive_precision_surgery" ) || var_6a1e141315b5d05d && player utility::callsharedfunc( #"zombie", #"player_has_augment", #"quick_revive_precision_surgery" ) )
            {
                player.var_d43f0027cdfe15 = 1;
            }
            
            if ( player function_1a924aaffa55106c() )
            {
                waitframe();
                player.var_97fab3b324c4c972 = player.healing_aura_secondary_weapon;
                
                if ( !isweapon( player.var_97fab3b324c4c972 ) )
                {
                    player.var_97fab3b324c4c972 = player.laststandoldweaponobj;
                }
            }
            
            player.var_d6ab1ae1af095f90 = 1;
            
            if ( hasomnvar( "ui_scoreboard_enabled" ) )
            {
                player setclientomnvar( "ui_scoreboard_enabled", 0 );
                waitframe();
            }
            
            if ( player isspectatinganyone() )
            {
                stopspectateplayer( player getentitynumber(), 1, 0 );
            }
            
            player thread function_b74b712a09ef3a9c();
            player thread playerlogic::spawnclient();
            
            if ( function_b3df40ddf4269465( #"healingaura_bountiful_harvest" ) )
            {
                overhealamount = level.zombie_augments[ #"healingaura_bountiful_harvest" ].var_9e7d60df7759105b ?? 50;
                can_affect = 1;
                
                if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
                {
                    can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, player );
                }
                
                if ( player.team == self.team && can_affect )
                {
                    health_overcharge::function_f6da758a8ee4c988( player, "healingaura_bountiful_harvest", overhealamount );
                }
            }
        }
    }
}

// Namespace healing_aura_augments
// Params 0
// Checksum 0x8856abcc, Offset: 0x113a
// Size: 0x36
function function_b74b712a09ef3a9c()
{
    self endon( #"death_or_disconnect" );
    self waittill( #"spawned_player" );
    waitframe();
    
    if ( isalive( self ) )
    {
        self.health = self.maxhealth;
    }
}

// Namespace healing_aura_augments
// Params 0
// Checksum 0xc4590392, Offset: 0x1178
// Size: 0x1bb
function start_resilience()
{
    self notify( #"hash_b9fbf15f2320890b" );
    self endon( #"hash_b9fbf15f2320890b" );
    level endon( #"game_ended" );
    resilience_players = [];
    delayreduction = level.zombie_augments[ #"healingaura_resilience" ].var_1b924daf800e9cb8 ?? 0;
    regenincrease = level.zombie_augments[ #"healingaura_resilience" ].var_38ac92179a73e4b2 ?? 0;
    duration = level.zombie_augments[ #"healingaura_resilience" ].var_3c3f90843672716 ?? 1;
    
    foreach ( player in level.players )
    {
        can_affect = 1;
        
        if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
        {
            can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, player );
        }
        
        if ( player.team == self.team && can_affect )
        {
            player.var_6e8d4ecf936120c = 1 - delayreduction;
            player.var_e6a8138052022574 = 1 + regenincrease;
            resilience_players[ resilience_players.size ] = player;
        }
    }
    
    thread wait_resilience( resilience_players, duration );
}

// Namespace healing_aura_augments
// Params 2
// Checksum 0xe7737db9, Offset: 0x133b
// Size: 0xe5
function wait_resilience( resilience_players, waittime )
{
    self notify( #"hash_b0fdb1494fcdeb0f" );
    self endon( #"hash_b0fdb1494fcdeb0f" );
    level endon( #"game_ended" );
    str_team = self.team;
    wait waittime;
    
    foreach ( player in resilience_players )
    {
        if ( player.team == str_team )
        {
            player.var_6e8d4ecf936120c = 1;
            player.var_e6a8138052022574 = 1;
        }
    }
}

// Namespace healing_aura_augments
// Params 1
// Checksum 0x6c3766c, Offset: 0x1428
// Size: 0x79
function function_a4f7d9241a16e548( duration )
{
    self endon( #"death_or_disconnect" );
    
    if ( isplayer( self ) && self getscriptablehaspart( "healing_aura_inner_strength" ) && self getscriptableparthasstate( "healing_aura_inner_strength", "healing_aura_inner_strength_on" ) && self getscriptableparthasstate( "healing_aura_inner_strength", "healing_aura_inner_strength_on" ) )
    {
        utility::function_7c10ea82c1e305b8( "healing_aura_inner_strength", "healing_aura_inner_strength_on" );
        wait duration;
        utility::function_7c10ea82c1e305b8( "healing_aura_inner_strength", "healing_aura_inner_strength_off" );
    }
}

// Namespace healing_aura_augments
// Params 1
// Checksum 0x8e4f0fb0, Offset: 0x14a9
// Size: 0x162
function on_healingaura_healed( params )
{
    healer = params.healer;
    
    if ( isplayer( healer ) )
    {
        if ( healer function_b3df40ddf4269465( #"healingaura_inner_strength" ) )
        {
            duration = level.zombie_augments[ #"healingaura_inner_strength" ].var_a5a174510a874e10 ?? 10;
            healer thread function_a4f7d9241a16e548( duration );
            
            if ( utility::issharedfuncdefined( #"zombie", #"hash_8bd9ed022653701d" ) )
            {
                self.var_2de028ea974579b5[ #"healingaura_inner_strength" ] = 1;
                thread utility::callsharedfunc( #"zombie", #"hash_8bd9ed022653701d", duration, #"healingaura_inner_strength", "innerstrength" );
            }
        }
        
        if ( healer function_b3df40ddf4269465( #"healingaura_protection" ) )
        {
            duration = level.zombie_augments[ #"healingaura_protection" ].var_6e47d77edc5d22c4 ?? 3;
            
            if ( utility::issharedfuncdefined( #"zombie", #"hash_d654f8d8c48840f" ) )
            {
                self.var_bd752fd42b2e2193[ #"healingaura_protection" ] = 1;
                thread utility::callsharedfunc( #"zombie", #"hash_d654f8d8c48840f", duration, #"healingaura_protection", "protection" );
            }
        }
    }
}

