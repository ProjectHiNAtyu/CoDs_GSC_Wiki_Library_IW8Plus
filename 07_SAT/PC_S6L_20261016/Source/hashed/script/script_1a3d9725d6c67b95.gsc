// script_1a3d9725d6c67b95  (hash_1a3d9725d6c67b95.gscc) (size: 9231 Bytes / 0x240f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa56f8db8 (2775551416)
// size ...... 9231 (0x240f)
// includes .. 13  (offset: 0x2203)
// strings ... 27  (offset: 0x226b)
// dev strs .. 5   (offset: 0x23d3)
// exports ... 22  (offset: 0x1597)
// cseg ...... 0x2fa + 0x129d (0x1597)
// imports ... 74  (offset: 0x1907)
// animtree1 . 0   (offset: 0x240f)
// animtree2 . 0   (offset: 0x240f)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\powerups\full_power;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_item;
#using scripts\mp\playerachievements;

#namespace namespace_1c4e4a7c76c7dfd5;

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 0, eflags: 0x5
// Checksum 0x779e4e1b, Offset: 0x318
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_48ba0851621a4a60", #"scarab_boss_fight", &pre_main, undefined );
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 0, eflags: 0x4
// Checksum 0x4a0c03bb, Offset: 0x341
// Size: 0xb8
function private pre_main()
{
    powerups::register_powerup( "scarab_firefly_boss", &function_e414f20fd70c259a, &function_6ee60d5cadd9a4e6 );
    powerups::register_powerup( "scarab_ruby_boss", &function_bac94abddc2388ed, &function_6ee60d5cadd9a4e6 );
    powerups::register_powerup( "scarab_locust_boss", &function_baf213ed02ae7e83, &function_6ee60d5cadd9a4e6 );
    powerups::register_powerup( "scarab_hornet_boss", &function_97a311f72e4c8039, &function_6ee60d5cadd9a4e6 );
    level callback::add( #"player_connect", &function_dd45775ae0ef0a7b );
    level callback::add( #"hash_22fdd0c3eb081084", &function_f2a5f8f940f14e5e );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"force_blessing_quests_completed", &function_9df028b08c002cea );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"force_blessing_pedestals_raised", &function_cca0736590795cae );
    level thread init_pedestals();
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 2
// Checksum 0xf8e89184, Offset: 0x401
// Size: 0x474
function init_pedestals( var_8548fff06f0aba9c, var_62219b9bd11a99bf )
{
    self notify( #"hash_fc9662eff7c5567c" );
    self endon( #"hash_fc9662eff7c5567c" );
    level utility::flag_wait( "scarab_boss_fight_start" );
    
    if ( getdvarint( @"hash_c65289e4a2e66470", 0 ) || var_8548fff06f0aba9c )
    {
        level.completed_firefly_mq = 1;
        level.completed_ruby_mq = 1;
        level.completed_locust_mq = 1;
        level.completed_hornet_mq = 1;
    }
    
    level.var_9808c91613a30ec8 = utility::getstructarray( "scarab_blessing_pedestals", "targetname" );
    
    foreach ( var_7c06ccff26c8744e in level.var_9808c91613a30ec8 )
    {
        switch ( var_7c06ccff26c8744e.script_noteworthy )
        {
            case #"hash_4e7a993fbfc368df":
                if ( level.completed_firefly_mq && !isdefined( var_7c06ccff26c8744e.model ) )
                {
                    var_7c06ccff26c8744e.model = spawnscriptable( "zm_sat_scarab_boss_fight_firefly_pedestal", var_7c06ccff26c8744e.origin, var_7c06ccff26c8744e.angles );
                }
                
                break;
            case #"hash_a07627d3096b1d4c":
                if ( level.completed_ruby_mq && !isdefined( var_7c06ccff26c8744e.model ) )
                {
                    var_7c06ccff26c8744e.model = spawnscriptable( "zm_sat_scarab_boss_fight_ruby_pedestal", var_7c06ccff26c8744e.origin, var_7c06ccff26c8744e.angles );
                }
                
                break;
            case #"hash_a890dcc1c036f522":
                if ( level.completed_locust_mq && !isdefined( var_7c06ccff26c8744e.model ) )
                {
                    var_7c06ccff26c8744e.model = spawnscriptable( "zm_sat_scarab_boss_fight_locust_pedestal", var_7c06ccff26c8744e.origin, var_7c06ccff26c8744e.angles );
                }
                
                break;
            case #"hash_76cbdaaee883135c":
                if ( level.completed_hornet_mq && !isdefined( var_7c06ccff26c8744e.model ) )
                {
                    var_7c06ccff26c8744e.model = spawnscriptable( "zm_sat_scarab_boss_fight_hornet_pedestal", var_7c06ccff26c8744e.origin, var_7c06ccff26c8744e.angles );
                }
                
                break;
        }
        
        var_7c06ccff26c8744e.var_4b1eeea2626bb5fc = { #angles:var_7c06ccff26c8744e.angles, #origin:var_7c06ccff26c8744e.origin };
        var_ad8b274417815b62 = utility::getstructarray( var_7c06ccff26c8744e.target, "targetname" );
        
        foreach ( var_5990ce3727e634d1 in var_ad8b274417815b62 )
        {
            if ( var_5990ce3727e634d1.script_noteworthy == "powerup_spawn" )
            {
                var_7c06ccff26c8744e.s_powerup_loc = var_5990ce3727e634d1;
                continue;
            }
            
            if ( var_5990ce3727e634d1.script_noteworthy == "start_pos" )
            {
                var_7c06ccff26c8744e.s_start_pos = var_5990ce3727e634d1;
            }
        }
        
        if ( isdefined( var_7c06ccff26c8744e.model ) )
        {
            if ( !isdefined( var_7c06ccff26c8744e.model.linkedparent ) )
            {
                var_7c06ccff26c8744e.model.origin = var_7c06ccff26c8744e.s_start_pos.origin;
                var_7c06ccff26c8744e.model.angles = var_7c06ccff26c8744e.s_start_pos.angles;
            }
            
            if ( !isdefined( var_7c06ccff26c8744e.e_mover ) )
            {
                var_7c06ccff26c8744e.e_mover = utility::function_1808878d1c511ce8( var_7c06ccff26c8744e.model.origin, var_7c06ccff26c8744e.model.angles );
                var_7c06ccff26c8744e.model utility::scriptable_setparententity( var_7c06ccff26c8744e.e_mover );
            }
            
            var_7c06ccff26c8744e thread pedestal_rise( var_62219b9bd11a99bf );
        }
    }
    
    /#
        init_devgui();
    #/
}

/#

    // Namespace namespace_1c4e4a7c76c7dfd5
    // Params 0, eflags: 0x4
    // Checksum 0x7818c28d, Offset: 0x87d
    // Size: 0x44, Type: dev
    function private init_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x4c>", "<dev string:x67>", &function_9df028b08c002cea );
        devgui::add_devgui_func( "<dev string:x87>", "<dev string:xa2>", &function_cca0736590795cae );
        devgui::function_77df7fe7dd273e10();
    }

#/

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 1
// Checksum 0x9ea87eb6, Offset: 0x8c9
// Size: 0x21
function function_9df028b08c002cea( params )
{
    level thread init_pedestals( 1, 0 );
    iprintlnbold( "force_blessing_quests_completed" );
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 1
// Checksum 0x4aca606, Offset: 0x8f2
// Size: 0x22
function function_cca0736590795cae( params )
{
    level thread init_pedestals( 1, 1 );
    iprintlnbold( "force_blessing_pedestals_raised" );
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 1, eflags: 0x4
// Checksum 0xf378b8fb, Offset: 0x91c
// Size: 0xa0
function private function_dd45775ae0ef0a7b( params )
{
    if ( !level.completed_firefly_mq )
    {
        playerachievements::getstate( self, 54420 );
        playerachievements::getstate( self, 63431 );
    }
    
    if ( !level.completed_ruby_mq )
    {
        playerachievements::getstate( self, 64034 );
        playerachievements::getstate( self, 64041 );
    }
    
    if ( !level.completed_locust_mq )
    {
        playerachievements::getstate( self, 69556 );
        playerachievements::getstate( self, 69558 );
    }
    
    if ( !level.completed_hornet_mq )
    {
        playerachievements::getstate( self, 69565 );
        playerachievements::getstate( self, 69567 );
    }
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 1, eflags: 0x4
// Checksum 0x34852db0, Offset: 0x9c4
// Size: 0x1e6
function private function_f2a5f8f940f14e5e( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !level.completed_firefly_mq )
    {
        if ( params.achievementid == 54420 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 54420, "progress", 0 ) )
            {
                level.completed_firefly_mq = 1;
            }
        }
        else if ( params.achievementid == 63431 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 63431, "progress", 0 ) )
            {
                level.completed_firefly_mq = 1;
            }
        }
    }
    
    if ( !level.completed_ruby_mq )
    {
        if ( params.achievementid == 64034 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 64034, "progress", 0 ) )
            {
                level.completed_ruby_mq = 1;
            }
        }
        else if ( params.achievementid == 64041 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 64041, "progress", 0 ) )
            {
                level.completed_ruby_mq = 1;
            }
        }
    }
    
    if ( !level.completed_locust_mq )
    {
        if ( params.achievementid == 69556 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 69556, "progress", 0 ) )
            {
                level.completed_locust_mq = 1;
            }
        }
        else if ( params.achievementid == 69558 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 69558, "progress", 0 ) )
            {
                level.completed_locust_mq = 1;
            }
        }
    }
    
    if ( !level.completed_hornet_mq )
    {
        if ( params.achievementid == 69565 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 69565, "progress", 0 ) )
            {
                level.completed_hornet_mq = 1;
            }
            
            return;
        }
        
        if ( params.achievementid == 69567 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 69567, "progress", 0 ) )
            {
                level.completed_hornet_mq = 1;
            }
        }
    }
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 0
// Checksum 0x7405c479, Offset: 0xbb2
// Size: 0x7d
function function_439675b016c63652()
{
    foreach ( var_7c06ccff26c8744e in level.var_9808c91613a30ec8 )
    {
        var_7c06ccff26c8744e thread pedestal_rise( 1 );
    }
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 1, eflags: 0xc
// Checksum 0xe1abdeb8, Offset: 0xc37
// Size: 0x1dd
function private pedestal_rise( b_force_raise )
{
    self notify( #"hash_e51f7628c9f0387f" );
    self endon( #"hash_e51f7628c9f0387f" );
    
    if ( !( isdefined( self.e_mover ) && isdefined( self.model ) ) || self.b_raised )
    {
        return;
    }
    
    if ( !b_force_raise )
    {
        switch ( self.script_noteworthy )
        {
            case #"hash_4e7a993fbfc368df":
                utility::flag_wait( "scarab_powerup_firefly_activate" );
                break;
            case #"hash_a07627d3096b1d4c":
                utility::flag_wait( "scarab_powerup_ruby_activate" );
                break;
            case #"hash_a890dcc1c036f522":
                utility::flag_wait( "scarab_powerup_locust_activate" );
                break;
            case #"hash_76cbdaaee883135c":
                utility::flag_wait( "scarab_powerup_hornet_activate" );
                break;
        }
    }
    
    pedestal_mover = self.e_mover;
    earthquake( 0.5, 1, self.var_4b1eeea2626bb5fc.origin, 2000 );
    self.b_raised = 1;
    self.model utility::function_7c10ea82c1e305b8( "vfx", "spawn" );
    self.player_collision = utility::spawn_model( %"hash_542b5f61f0d54b27", self.origin, self.angles );
    self.var_e1adedc4a4a5146d = function_aafd9c2a00b86dba( self.player_collision, "custom_default_on" );
    pedestal_mover moveto( self.var_4b1eeea2626bb5fc.origin, self.script_timeout ?? 3 );
    pedestal_mover rotateto( self.var_4b1eeea2626bb5fc.angles, self.script_timeout ?? 3 );
    pedestal_mover waittill( #"movedone" );
    pedestal_spawn_powerup();
    pedestal_lower();
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 0
// Checksum 0x17c621b1, Offset: 0xe1c
// Size: 0x69
function pedestal_spawn_powerup()
{
    powerup = powerups::powerup_drop( self.script_noteworthy, self.s_powerup_loc.origin, -1 );
    powerup.angles = self.s_powerup_loc.angles;
    powerup waittill( #"powerup_grabbed", player );
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 0
// Checksum 0x9d4dc7ea, Offset: 0xe8d
// Size: 0xef
function pedestal_lower()
{
    pedestal_mover = self.e_mover;
    earthquake( 0.5, 1, self.var_4b1eeea2626bb5fc.origin, 2000 );
    self.b_raised = undefined;
    self.model utility::function_7c10ea82c1e305b8( "vfx", "despawn" );
    pedestal_mover moveto( self.s_start_pos.origin, self.script_timeout ?? 3 );
    pedestal_mover rotateto( self.s_start_pos.angles, self.script_timeout ?? 3 );
    pedestal_mover waittill( #"movedone" );
    
    if ( self.var_e1adedc4a4a5146d )
    {
        destroynavobstacle( self.var_e1adedc4a4a5146d );
    }
    
    if ( self.player_collision )
    {
        self.player_collision delete();
    }
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 2
// Checksum 0xdcbc3538, Offset: 0xf84
// Size: 0xfd
function function_e414f20fd70c259a( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    
    foreach ( player in a_players )
    {
        player thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( str_powerup );
        var_688c88bf33579499 = arrayrandomize( zombie_perks::get_perks_str_array() );
        
        for ( i = 0; i < 3 ; i++ )
        {
            str_random_perk = var_688c88bf33579499[ i ];
            
            if ( player zombie_perks::has_perk( str_random_perk ) )
            {
                player zombie_perks::function_3c5c75cec72d90aa( str_random_perk );
                continue;
            }
            
            player zombie_perks::give_perk( str_random_perk, 0, 0, 0, 1 );
        }
    }
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 2
// Checksum 0x7dad77e, Offset: 0x1089
// Size: 0xd4
function function_bac94abddc2388ed( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    var_3621b6ad3fb45884 = powerups::get_powerup_info( str_powerup );
    
    foreach ( player in a_players )
    {
        player thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( str_powerup, var_3621b6ad3fb45884.var_3f03b937c69044df );
        player thread full_power::function_21f8005dcd5af7f9();
        player thread function_3c98c106b339c790( var_3621b6ad3fb45884.var_3f03b937c69044df );
    }
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 1
// Checksum 0xd8c6e7a7, Offset: 0x1165
// Size: 0xb2
function function_3c98c106b339c790( n_lifetime )
{
    self endon( #"death_or_disconnect" );
    
    while ( n_lifetime > 0 )
    {
        if ( n_lifetime < 5 )
        {
            n_wait = n_lifetime;
            wait n_wait;
            break;
        }
        else
        {
            n_wait = 5;
            n_lifetime -= n_wait;
            wait n_wait;
        }
        
        primary_equip_ref = equipment_mp::getcurrentequipment( "primary" );
        var_382c92ced2f61c35 = equipment_mp::getequipmentmaxammo( primary_equip_ref );
        equipment_mp::setequipmentammo( primary_equip_ref, var_382c92ced2f61c35, var_382c92ced2f61c35 );
        secondary_equip_ref = equipment_mp::getcurrentequipment( "secondary" );
        var_f9720a7bbc3dc8a5 = equipment_mp::getequipmentmaxammo( secondary_equip_ref );
        equipment_mp::setequipmentammo( secondary_equip_ref, var_f9720a7bbc3dc8a5, var_f9720a7bbc3dc8a5 );
    }
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 2
// Checksum 0x6201c799, Offset: 0x121f
// Size: 0x149
function function_baf213ed02ae7e83( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    var_3621b6ad3fb45884 = powerups::get_powerup_info( str_powerup );
    
    foreach ( player in a_players )
    {
        player thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( str_powerup, var_3621b6ad3fb45884.var_3f03b937c69044df );
        player.health = player.maxhealth;
        player damage_effects::onexitdeathsdoor( 1 );
        owns_armor = isdefined( player.armorhealth ) && player.maxarmorhealth > 0;
        
        if ( owns_armor )
        {
            if ( !player armor::has_full_armor() )
            {
                player armor::repair_armor( player.maxarmorhealth );
            }
            
            player armor::function_164c824617d7e8d7( player armor::function_db9ebf086f67fe92() );
        }
    }
    
    level thread increased_armor_plates( var_3621b6ad3fb45884.var_3f03b937c69044df );
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 1, eflags: 0xc
// Checksum 0x20b7f6f7, Offset: 0x1370
// Size: 0x6c
function private increased_armor_plates( n_lifetime )
{
    self notify( #"hash_7d1bc89d2dce18c8" );
    self endon( #"hash_7d1bc89d2dce18c8" );
    
    if ( !level callback::exists( #"on_ai_killed", &function_965a356e46ddc748 ) )
    {
        level callback::add( #"on_ai_killed", &function_965a356e46ddc748 );
    }
    
    wait n_lifetime;
    level callback::remove( #"on_ai_killed", &function_965a356e46ddc748 );
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 1, eflags: 0x4
// Checksum 0xab53899d, Offset: 0x13e4
// Size: 0x9a
function private function_965a356e46ddc748( params )
{
    player = params.eattacker;
    
    if ( isplayer( player ) && utility::percent_chance( 33 ) )
    {
        spawn_options = common_item::items_initspawnoptions_spawnfromposition( self.var_5e0be30a5816a64d, self.angles );
        spawn_options.var_4a4b419f66681601 = [ player ];
        spawn_options.var_c580c0e8b49f1fcc = 1;
        item = player common_item::function_57b88e025e5fb03e( %"hash_7211ee48fe72c9e9", 1, spawn_options );
    }
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 2
// Checksum 0x47424212, Offset: 0x1486
// Size: 0xcb
function function_97a311f72e4c8039( str_powerup, ent_powerup )
{
    a_players = powerups::get_powerup_players( str_powerup );
    var_3621b6ad3fb45884 = powerups::get_powerup_info( str_powerup );
    
    foreach ( player in a_players )
    {
        player thread namespace_9d8e359c3b1041e5::showpoweruphudsharedfunc( str_powerup, var_3621b6ad3fb45884.var_3f03b937c69044df );
        player thread function_5898f738d3f0750f( var_3621b6ad3fb45884.var_3f03b937c69044df );
    }
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 1, eflags: 0x4
// Checksum 0x3d395d57, Offset: 0x1559
// Size: 0x32
function private function_5898f738d3f0750f( n_lifetime )
{
    self.var_21b6849991ff8d5d = 0.5;
    utility::waittill_any_timeout( n_lifetime, "death_or_disconnect" );
    self.var_21b6849991ff8d5d = undefined;
}

// Namespace namespace_1c4e4a7c76c7dfd5
// Params 0
// Checksum 0xd36f0ca6, Offset: 0x1593
// Size: 0x3, Type: bool
function function_6ee60d5cadd9a4e6()
{
    return false;
}

