// scripts\mp\common\perks\zombie\perk_w_mod.gsc  (hash_3345b9458f7958dc.gscc) (size: 19001 Bytes / 0x4a39 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x76fe6a0a (1996384778)
// size ...... 19001 (0x4a39)
// includes .. 16  (offset: 0x4609)
// strings ... 49  (offset: 0x4689)
// dev strs .. 17  (offset: 0x496d)
// exports ... 40  (offset: 0x2f4d)
// cseg ...... 0x345 + 0x2c08 (0x2f4d)
// imports ... 134 (offset: 0x358d)
// animtree1 . 0   (offset: 0x4a39)
// animtree2 . 0   (offset: 0x4a39)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\perks\zombie\zombie_perks;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\currency;

#namespace perk_w_mod;

// Namespace perk_w_mod
// Params 0, eflags: 0x5
// Checksum 0xe105cc03, Offset: 0x363
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "specialty_w_mod", undefined, &__init__, undefined );
}

// Namespace perk_w_mod
// Params 0
// Checksum 0x3ad36859, Offset: 0x380
// Size: 0xa
function __init__()
{
    level thread perk_w_mod_init();
}

// Namespace perk_w_mod
// Params 0
// Checksum 0xae58fa21, Offset: 0x392
// Size: 0x1a6
function perk_w_mod_init()
{
    if ( !level.zombie_perks_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level utility::flag_init( "specialty_w_mod" + "init_complete" );
    level._effect[ #"w_mod_damage" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_wisp_tea_demon_suck_soul_base_zmb_torso" );
    level._effect[ #"w_mod_spawn" ] = level._effect[ #"w_mod_damage" ];
    level._effect[ #"w_mod_despawn" ] = level._effect[ #"w_mod_damage" ];
    level utility::flag_wait_all( "StartGameTypeCallbackFinished", "zombie_perks_init_complete" );
    
    /#
        level thread setup_w_mod_devgui();
    #/
    
    str_currency = currency::get_perk_machine_currency( "specialty_w_mod" );
    var_fcb7626c79b3c98f = currency::get_perk_machine_cost( "specialty_w_mod" );
    level thread zombie_perks::enable_perk_for_level( "specialty_w_mod", str_currency, var_fcb7626c79b3c98f, &function_dea6ec180cb849b7, &function_9868471f53ccd285 );
    utility::registersharedfunc( #"w_mod", #"hash_f5a9afab08f0dcea", &function_de79bd3b0e276b33 );
    utility::registersharedfunc( #"w_mod", #"hash_f55a11e321b0a83d", &function_83edc9631d14829c );
    utility::registersharedfunc( #"w_mod", #"delete_wisp", &delete_wisp );
    utility::registersharedfunc( #"w_mod", #"wisp_ignore", &wisp_ignore );
    utility::registersharedfunc( #"w_mod", #"hash_99ea4242fa8d9ae3", &function_2ba31641db668862 );
    level utility::flag_set( "specialty_w_mod" + "init_complete" );
}

// Namespace perk_w_mod
// Params 1
// Checksum 0x16da2114, Offset: 0x540
// Size: 0x22
function function_8266614527308805( vfxid )
{
    level._effect[ #"w_mod_damage_override" ] = vfxid;
}

// Namespace perk_w_mod
// Params 0
// Checksum 0xef3870ac, Offset: 0x56a
// Size: 0x15
function function_1c2aa29489437190()
{
    level._effect[ #"w_mod_damage_override" ] = undefined;
}

// Namespace perk_w_mod
// Params 1
// Checksum 0xdcde89b1, Offset: 0x587
// Size: 0x22
function function_8b4439e8e8b05190( vfxid )
{
    level._effect[ #"hash_695af3358a9e5add" ] = vfxid;
}

// Namespace perk_w_mod
// Params 0
// Checksum 0x4ef5e50f, Offset: 0x5b1
// Size: 0x15
function function_e9cfd9ce98cc289b()
{
    level._effect[ #"hash_695af3358a9e5add" ] = undefined;
}

// Namespace perk_w_mod
// Params 1
// Checksum 0x9c995e5e, Offset: 0x5ce
// Size: 0x22
function function_bde7ad132a5210c7( vfxid )
{
    level._effect[ #"hash_52a1b0c755c6efca" ] = vfxid;
}

// Namespace perk_w_mod
// Params 0
// Checksum 0xc717fdb6, Offset: 0x5f8
// Size: 0x15
function function_1ff2345cd091e1cc()
{
    level._effect[ #"hash_52a1b0c755c6efca" ] = undefined;
}

// Namespace perk_w_mod
// Params 0, eflags: 0x4
// Checksum 0x7559f8b7, Offset: 0x615
// Size: 0x5e, Type: bool
function private function_ccdaa0a0c98b1c26()
{
    return level._effect[ #"w_mod_damage_override" ] ?? utility::callsharedfunc( #"zombie", #"hash_b8d2e46cea84f289", self.var_4fd5ac47a9bd8c18.augment_mask, "damage" ) ?? level._effect[ #"w_mod_damage" ];
}

// Namespace perk_w_mod
// Params 0, eflags: 0x4
// Checksum 0x814a2ce3, Offset: 0x67c
// Size: 0x5e, Type: bool
function private get_w_mod_spawn_vfx()
{
    return level._effect[ #"hash_52a1b0c755c6efca" ] ?? utility::callsharedfunc( #"zombie", #"hash_b8d2e46cea84f289", self.var_4fd5ac47a9bd8c18.augment_mask, "spawn" ) ?? level._effect[ #"w_mod_spawn" ];
}

// Namespace perk_w_mod
// Params 0, eflags: 0x4
// Checksum 0x55a62b2e, Offset: 0x6e3
// Size: 0x5e, Type: bool
function private function_e004d0a963719d1d()
{
    return level._effect[ #"hash_695af3358a9e5add" ] ?? utility::callsharedfunc( #"zombie", #"hash_b8d2e46cea84f289", self.var_4fd5ac47a9bd8c18.augment_mask, "despawn" ) ?? level._effect[ #"w_mod_despawn" ];
}

// Namespace perk_w_mod
// Params 0
// Checksum 0xc0bdab0b, Offset: 0x74a
// Size: 0x9
function function_dea6ec180cb849b7()
{
    function_e883cae10d830490();
}

// Namespace perk_w_mod
// Params 4
// Checksum 0x926f76b5, Offset: 0x75b
// Size: 0x2e
function function_9868471f53ccd285( var_d93428f5ff5cb05d, str_perk, str_result, var_e97a4f4962bc3f25 )
{
    function_1fce1a8a18585596();
}

// Namespace perk_w_mod
// Params 0
// Checksum 0x7b318a7a, Offset: 0x791
// Size: 0x5a
function function_e883cae10d830490()
{
    if ( level.perkbundles[ "specialty_w_mod" ] )
    {
        zombie_perks::function_5d65c3d58cc084ec( "specialty_w_mod" );
        
        if ( !level callback::exists( #"on_ai_killed", &function_7e4e1c6c39fc475d ) )
        {
            level callback::add( #"on_ai_killed", &function_7e4e1c6c39fc475d );
        }
        
        self.var_77456b5cca824efe = 1;
    }
}

// Namespace perk_w_mod
// Params 0
// Checksum 0x33bb1673, Offset: 0x7f3
// Size: 0x9e
function function_1fce1a8a18585596()
{
    if ( level.perkbundles[ "specialty_w_mod" ] )
    {
        zombie_perks::function_25539251d02082( "specialty_w_mod" );
        level callback::remove( #"on_ai_killed", &function_7e4e1c6c39fc475d );
        
        if ( self )
        {
            self.var_3f4ab11e0fd7c0e6 = 0;
            
            if ( !( utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_savior" ) && self.var_4fd5ac47a9bd8c18 && player::isinlaststand( self ) ) )
            {
                if ( self.var_4fd5ac47a9bd8c18 )
                {
                    self.var_4fd5ac47a9bd8c18 thread delete_wisp( self );
                }
            }
        }
    }
}

// Namespace perk_w_mod
// Params 1, eflags: 0x4
// Checksum 0x3eff5bf0, Offset: 0x899
// Size: 0x1fe
function private function_7e4e1c6c39fc475d( params )
{
    if ( !isplayer( params.eattacker ) )
    {
        return;
    }
    
    if ( level.var_8eb019fd327a4643 )
    {
        return;
    }
    
    player = params.eattacker;
    
    if ( !player zombie_perks::has_perk( "specialty_w_mod" ) )
    {
        return;
    }
    
    if ( player.var_4fd5ac47a9bd8c18 )
    {
        return;
    }
    
    cooldowntime = level.perkbundles[ "specialty_w_mod" ].wmodcooldown ?? 0;
    
    if ( player utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_haste" ) )
    {
        cooldowntime -= level.zombie_augments[ #"w_mod_haste" ].var_e04e5c3533d67c4d ?? 0;
    }
    
    cooldowntime = utility::function_4b74c15943231980( cooldowntime );
    var_ed3b071518ff386b = player.var_77456b5cca824efe;
    
    /#
        if ( level.var_f1c54646e394530 )
        {
            force_no_cooldown = level.var_f1c54646e394530;
        }
        
        if ( level.var_1841284cde59f340 )
        {
            var_ed3b071518ff386b = level.var_1841284cde59f340;
        }
    #/
    
    if ( !player.var_3f4ab11e0fd7c0e6 || player.var_3f4ab11e0fd7c0e6 && gettime() >= player.var_3f4ab11e0fd7c0e6 + cooldowntime || force_no_cooldown )
    {
        if ( !isdefined( player.var_b997ab5ebe9a1057 ) )
        {
            player.var_b997ab5ebe9a1057 = 0;
        }
        
        player.var_b997ab5ebe9a1057++;
        
        if ( player.var_b997ab5ebe9a1057 >= level.perkbundles[ "specialty_w_mod" ].var_76b6fd591d237684 || var_ed3b071518ff386b )
        {
            player.var_3f4ab11e0fd7c0e6 = gettime();
            
            /#
                iprintlnbold( "<dev string:x24>" );
            #/
            
            player thread function_d46674d3b5d32438();
            player.var_b997ab5ebe9a1057 = 0;
            player.var_77456b5cca824efe = undefined;
        }
    }
}

// Namespace perk_w_mod
// Params 1
// Checksum 0xa826fcbc, Offset: 0xa9f
// Size: 0x1035
function function_d46674d3b5d32438( overrideparams )
{
    self notify( #"hash_f78f5b7303458a0c" );
    self endon( #"hash_f78f5b7303458a0c" );
    scriptable = overrideparams.scriptable ?? level.perkbundles[ "specialty_w_mod" ].var_10289c72a22feea1;
    origin = self geteye() + anglestoforward( self.angles ) * 50 + anglestoright( self.angles ) * 50;
    angles = self.angles;
    spawn_point = origin;
    wisp = spawnscriptable( scriptable, spawn_point, angles );
    wisp.var_bb035c0551548452 = overrideparams.search_range ?? level.perkbundles[ "specialty_w_mod" ].var_bb035c0551548452;
    wisp.var_1ceaa502bfb4398e = overrideparams.var_c2613e85d84857b ?? level.perkbundles[ "specialty_w_mod" ].var_1ceaa502bfb4398e;
    wisp.var_83e0c7e6434855e5 = overrideparams.base_max_speed ?? level.perkbundles[ "specialty_w_mod" ].var_83e0c7e6434855e5;
    wisp.var_fbe49475015973ae = overrideparams.var_a7c29cfa649167e0 ?? level.perkbundles[ "specialty_w_mod" ].var_fbe49475015973ae;
    wisp.var_61db20a999482609 = overrideparams.var_1d14185e5468202d ?? level.perkbundles[ "specialty_w_mod" ].var_61db20a999482609;
    wisp.var_c30086d245483308 = overrideparams.damage_perc ?? level.perkbundles[ "specialty_w_mod" ].var_c30086d245483308;
    wisp.var_4e6632480cfff133 = overrideparams.attack_rate ?? level.perkbundles[ "specialty_w_mod" ].var_4e6632480cfff133;
    wisp.var_bb063e46d21339cf = overrideparams.summon_time ?? level.perkbundles[ "specialty_w_mod" ].var_bb063e46d21339cf;
    wisp.var_8bd6a439e83d23f8 = overrideparams.fixed_attack_damage;
    wisp.var_39ba408da99f8d3d = overrideparams.var_f289150eafcfea7e;
    wisp.var_547b9cc4b23498d = overrideparams.zombie_damage_multiplier ?? 1;
    wisp.var_a3ea15f1c39b0ee0 = overrideparams.human_damage_multiplier ?? 1;
    wisp.var_990ae4ab6dffedb6 = overrideparams.player_damage_multiplier ?? 1;
    wisp.var_43ca8673c4e4f107 = overrideparams.use_fixed_damage;
    wisp.var_d36ada6487c143f6 = overrideparams.var_112369a470e1652 ?? 0;
    wisp.proc_weapon = self getcurrentprimaryweapon();
    wisp.var_cb7b53471c8f3170 = overrideparams.var_cb7b53471c8f3170 ?? "<explicitweaponnone>";
    wisp.var_21c148796dcc185f = 1;
    wisp.audio_state = "default";
    wisp.idle_forward_offset = 115;
    wisp.idle_right_offset = 95;
    wisp.e_mover = utility::spawn_model( "tag_origin", spawn_point, angles );
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_extension" ) )
    {
        wisp.var_bb063e46d21339cf += level.zombie_augments[ #"w_mod_extension" ].var_c8e43979d5d7f91f;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_demon_mask" ) )
    {
        wisp.var_c30086d245483308 = level.zombie_augments[ #"w_mod_demon_mask" ].var_e3d0eb79fd6fe167;
        wisp.var_fbe49475015973ae *= 0.1;
        wisp.audio_state = "demon";
        wisp.augment_mask = "_wrath";
        wisp.var_e1699d0305dec76e = 1;
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_will_o_wisp" ) )
    {
        wisp.var_c30086d245483308 = level.zombie_augments[ #"w_mod_will_o_wisp" ].var_e3d0eb79fd6fe167;
        wisp.audio_state = "monkey";
        wisp.augment_mask = "_distraction";
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_savior" ) )
    {
        if ( !isdefined( self.w_mod_savior_uses ) )
        {
            self.w_mod_savior_uses = 3;
        }
        
        wisp.audio_state = "fox";
        wisp.augment_mask = "_salvation";
        
        if ( self.w_mod_savior_uses > 0 )
        {
            val::set( "w_mod_savior", "allow_last_stand", 1 );
        }
        else
        {
            val::reset( "w_mod_savior", "allow_last_stand" );
        }
    }
    
    self.var_4fd5ac47a9bd8c18 = wisp;
    params = spawnstruct();
    params.owner = self;
    params.wisp = wisp;
    level callback::callback( "w_mod_spawned", params );
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_pretty_mask" ) )
    {
        thread utility::callsharedfunc( #"zombie", #"hash_22cc15f7a077344e" );
        wisp.audio_state = "lady";
        wisp.augment_mask = "_benevolence";
    }
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_fetcher" ) )
    {
        thread utility::callsharedfunc( #"zombie", #"hash_4e197dc8416370b7" );
    }
    
    wisp.e_mover.state = wisp.audio_state;
    wisp.owner = self;
    wisp.can_target = 1;
    wisp utility::scriptable_setparententity( wisp.e_mover );
    
    if ( !isdefined( wisp.augment_mask ) )
    {
        wisp.augment_mask = "";
    }
    
    wisp utility::function_7c10ea82c1e305b8( "wisp", "on" + wisp.augment_mask );
    wisp utility::function_7c10ea82c1e305b8( "audio", "on_" + wisp.audio_state );
    wisp thread wisp_death_watcher( self );
    calc_dist = 1;
    playfxontag( get_w_mod_spawn_vfx(), wisp.e_mover, "tag_origin" );
    wisp thread function_26b507986e9824ed( self );
    wisp thread function_9b1b29b9e04e1b47( self );
    val::set( "w_mod", "ignore_afk", 1 );
    
    while ( wisp )
    {
        if ( !isent( wisp.e_mover ) )
        {
            return;
        }
        
        if ( !isplayer( self ) )
        {
            wisp delete_wisp( self );
            return;
        }
        
        if ( level utility::flag( "zm_game_over" ) )
        {
            wisp delete_wisp( self );
            return;
        }
        
        if ( self.sessionstate == "dead" || self.sessionstate == "spectator" )
        {
            wisp delete_wisp( self );
            return;
        }
        
        if ( self.var_d1c4c78b9fb7d153 )
        {
            wait level.framedurationseconds;
            continue;
        }
        
        if ( wisp && wisp.var_d1e820894084abac && isalive( wisp.var_d1e820894084abac ) )
        {
            if ( distancesquared( wisp.var_d1e820894084abac.origin, wisp.origin ) < 1000 )
            {
                wait 1;
                continue;
            }
        }
        else if ( wisp.var_d1e820894084abac && ( wisp.var_d1e820894084abac.health <= 0 || !isalive( wisp.var_d1e820894084abac ) ) )
        {
            wisp.var_d1e820894084abac = undefined;
        }
        
        if ( !wisp.locked_on_ent )
        {
            var_824d754551b7938e = get_closest_enemy( self.origin, wisp.var_bb035c0551548452, wisp.var_d36ada6487c143f6 );
            wisp.locked_on_ent = var_824d754551b7938e;
            
            if ( !isdefined( wisp.distance_to_target ) )
            {
                wisp.distance_to_target = 0;
            }
            
            if ( var_824d754551b7938e )
            {
                if ( !isdefined( var_824d754551b7938e.var_270eef9780ddfbb2 ) )
                {
                    var_824d754551b7938e.var_270eef9780ddfbb2 = 0;
                }
                
                if ( var_824d754551b7938e != wisp.last_ent )
                {
                    wisp.move_accel = 0.4;
                    
                    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_demon_mask" ) )
                    {
                        wisp.move_accel = 0.01;
                    }
                }
            }
        }
        
        if ( wisp.force_target )
        {
            var_824d754551b7938e = undefined;
        }
        
        can_move_to_enemy = 0;
        var_bdd5725ddde1a788 = self getcentroid();
        
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_pretty_mask" ) )
        {
            wisp.can_target = 0;
        }
        
        if ( isent( var_824d754551b7938e ) && isalive( var_824d754551b7938e ) )
        {
            var_bdd5725ddde1a788 = var_824d754551b7938e getcentroid();
            
            if ( var_824d754551b7938e namespace_b76ff2659823e89d::is_crawling() )
            {
                can_move_to_enemy = function_5da553f86a08cf57( wisp, var_bdd5725ddde1a788, 0 );
            }
            else
            {
                can_move_to_enemy = function_5da553f86a08cf57( wisp, var_bdd5725ddde1a788 );
            }
            
            if ( utility::getsharedfunc( #"zombie", #"is_active_zombie" ) )
            {
                if ( !utility::callsharedfunc( #"zombie", #"is_active_zombie", var_824d754551b7938e ) )
                {
                    can_move_to_enemy = 0;
                }
            }
            
            if ( utility::getsharedfunc( "zombie", #"get_round_enemies" ) )
            {
                zombies_left = utility::callsharedfunc( #"zombie", #"get_round_enemies" );
                
                if ( zombies_left.size == 1 && !var_824d754551b7938e.ignore_enemy_count )
                {
                    can_move_to_enemy = 0;
                    
                    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_lure" ) && wisp && !var_824d754551b7938e.b_in_spawn_closet )
                    {
                        can_move_to_enemy = 1;
                        wisp.can_target = 1;
                        var_824d754551b7938e.b_cleanup_no_respawn = 1;
                        var_824d754551b7938e val::set( "w_mod_lure", "ignore_cleanup", 1 );
                        
                        if ( !wisp.var_651194267e546747 )
                        {
                            attractor_range = level.zombie_augments[ #"w_mod_lure" ].var_f7343e8f047f9dbe;
                            wisp.var_21c148796dcc185f = 0;
                            var_824d754551b7938e.var_75afeb7d6a870ec0 = 1;
                            wisp.var_d1e820894084abac = var_824d754551b7938e;
                            wisp.var_651194267e546747 = var_824d754551b7938e zombie_attractor_manager::function_7eb1aaa8bc7cc15( wisp.e_mover, 0, attractor_range, 0, undefined, &function_6d4719a0ca40944a, 0, undefined, 0 );
                        }
                        else if ( wisp.var_651194267e546747.range == 0 )
                        {
                            attractor_range = level.zombie_augments[ #"w_mod_lure" ].var_f7343e8f047f9dbe;
                            wisp.var_651194267e546747.range = attractor_range;
                        }
                    }
                }
            }
        }
        else
        {
            if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_lure" ) && wisp.var_651194267e546747.range > 0 )
            {
                if ( var_824d754551b7938e.var_75afeb7d6a870ec0 )
                {
                    wisp.var_21c148796dcc185f = 1;
                    wisp.var_651194267e546747.range = 0;
                }
            }
            
            if ( wisp.force_target )
            {
                var_bdd5725ddde1a788 = wisp.force_target.origin;
                can_move_to_enemy = function_5da553f86a08cf57( wisp, var_bdd5725ddde1a788, 0 );
            }
        }
        
        if ( wisp.can_target && can_move_to_enemy && isent( wisp.e_mover ) && gettime() > var_824d754551b7938e.var_270eef9780ddfbb2 && !var_824d754551b7938e.var_3807d4363cfee498 || wisp.force_target && can_move_to_enemy )
        {
            wisp function_64f943481d9678ca( var_bdd5725ddde1a788, calc_dist );
            
            if ( wisp.distance_to_target <= wisp.var_fbe49475015973ae )
            {
                wisp.in_attack_range = 1;
            }
            else if ( wisp )
            {
                wisp.in_attack_range = 0;
            }
            
            if ( wisp.var_e1699d0305dec76e )
            {
                wisp.var_3d4349e6aa22684e = wisp.distance_to_target <= wisp.var_fbe49475015973ae * wisp.var_e1699d0305dec76e;
            }
            
            if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_will_o_wisp" ) )
            {
                if ( !wisp.var_abb6f3b49bff999f )
                {
                    wisp.var_c30086d245483308 = level.zombie_augments[ #"w_mod_will_o_wisp" ].var_e3d0eb79fd6fe167;
                    attractor_range = level.zombie_augments[ #"w_mod_will_o_wisp" ].var_2104f20e9a41a370;
                    wisp.var_abb6f3b49bff999f = zombie_attractor_manager::add_attractor( wisp.e_mover, 0, attractor_range, 1, undefined, &function_6d4719a0ca40944a, 0, undefined, 0 );
                }
                else if ( wisp.var_abb6f3b49bff999f.range == 0 )
                {
                    attractor_range = level.zombie_augments[ #"w_mod_will_o_wisp" ].var_2104f20e9a41a370;
                    wisp.var_abb6f3b49bff999f.range = attractor_range;
                }
            }
        }
        else
        {
            wisp.last_ent = wisp.locked_on_ent;
            wisp.locked_on_ent = undefined;
            move_back_to_player = 1;
            
            if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_will_o_wisp" ) && wisp.var_abb6f3b49bff999f.range > 0 )
            {
                wisp.var_abb6f3b49bff999f.range = 0;
            }
            
            if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_fetcher" ) && wisp.fetcher_target )
            {
                move_offset = ( 0, 0, 10 );
                can_move_to_target = function_5da553f86a08cf57( wisp, wisp.fetcher_target.origin + move_offset, 0 );
                
                if ( can_move_to_target )
                {
                    wisp function_64f943481d9678ca( wisp.fetcher_target.origin, calc_dist );
                    wisp.locked_on_ent = wisp.fetcher_target;
                    move_back_to_player = 0;
                    wisp.move_accel = 1;
                }
            }
            
            if ( wisp && move_back_to_player && !wisp.var_67eac7361c5992b6 )
            {
                var_bdd5725ddde1a788 = self getcentroid() + anglestoforward( self.angles ) * wisp.idle_forward_offset + anglestoright( self.angles ) * wisp.idle_right_offset;
                wisp function_64f943481d9678ca( var_bdd5725ddde1a788, calc_dist, 3, 1 );
            }
        }
        
        calc_dist *= -1;
        wait level.framedurationseconds;
    }
}

// Namespace perk_w_mod
// Params 4, eflags: 0x4
// Checksum 0xed8d0990, Offset: 0x1adc
// Size: 0x3cf
function private function_64f943481d9678ca( var_bdd5725ddde1a788, recalculate_distance = 1, close_speed_multiplier = 1, var_f49831f56575b5f2 )
{
    if ( !self )
    {
        return;
    }
    
    if ( recalculate_distance == 1 )
    {
        self.distance_to_target = distance( self.e_mover.origin, var_bdd5725ddde1a788 );
        self.var_cbe1e78c0be559d3 = distance( self.owner.origin, self.e_mover.origin );
    }
    
    if ( !self.is_teleporting && self.var_cbe1e78c0be559d3 > self.var_61db20a999482609 + 50 && isplayer( self.owner ) && !self.locked_on_ent.var_75afeb7d6a870ec0 )
    {
        thread handle_teleport();
    }
    
    if ( !self || !self.e_mover )
    {
        return;
    }
    
    vector_to_target = var_bdd5725ddde1a788 - self.e_mover.origin;
    normal_vector = vectornormalize( vector_to_target );
    move_distance = self.var_83e0c7e6434855e5 * level.framedurationseconds * min( self.distance_to_target * 0.01, self.var_1ceaa502bfb4398e );
    move_vector = move_distance * normal_vector;
    max_accel = 1;
    
    if ( self.owner utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_demon_mask" ) && self.locked_on_ent )
    {
        max_accel = 2;
        
        if ( !isdefined( self.move_accel ) )
        {
            self.move_accel = 0.05;
        }
        
        if ( move_distance < 20 )
        {
            max_accel = 5;
            self.move_accel = min( 0.05 + self.move_accel, max_accel );
        }
    }
    
    if ( !isdefined( self.move_accel ) )
    {
        self.move_accel = 1;
    }
    
    self.move_accel = min( 0.01 + self.move_accel, max_accel );
    
    if ( var_f49831f56575b5f2 )
    {
        self.move_accel = min( self.move_accel, 1 );
    }
    
    move_vector *= self.move_accel;
    
    if ( move_distance < 10 )
    {
        move_vector *= close_speed_multiplier;
    }
    
    move_to_point = self.e_mover.origin + move_vector;
    self.e_mover.var_bdd5725ddde1a788 = var_bdd5725ddde1a788;
    self.e_mover.move_distance = move_distance;
    
    if ( !isdefined( self.var_686106236bae01f9 ) )
    {
        self.var_686106236bae01f9 = 0;
    }
    
    if ( var_f49831f56575b5f2 && !self.var_67eac7361c5992b6 )
    {
        self.var_686106236bae01f9 = cos( gettime() / 10 ) * 1.2;
        self.e_mover moveto( move_to_point + ( 0, 0, self.var_686106236bae01f9 ), level.framedurationseconds );
        self.e_mover.rotate_angles = vectortoangles( var_bdd5725ddde1a788 - self.e_mover.origin + anglestoforward( self.owner.angles ) * 25 );
        return;
    }
    
    self.e_mover moveto( move_to_point, level.framedurationseconds );
    self.var_686106236bae01f9 = 0;
    self.e_mover.rotate_angles = vectortoangles( var_bdd5725ddde1a788 - self.e_mover.origin );
}

// Namespace perk_w_mod
// Params 0, eflags: 0xc
// Checksum 0x19d0bed7, Offset: 0x1eb3
// Size: 0xd5
function private handle_teleport()
{
    self notify( #"hash_da07da4568550cce" );
    self endon( #"hash_da07da4568550cce" );
    self.locked_on_ent = undefined;
    self.is_teleporting = 1;
    teleport_pos = self.owner getcentroid() + anglestoforward( self.owner.angles ) * self.idle_forward_offset + anglestoright( self.owner.angles ) * self.idle_right_offset;
    self.e_mover.origin = teleport_pos;
    playfxontag( self.owner get_w_mod_spawn_vfx(), self.e_mover, "tag_origin" );
    wait 1;
    
    if ( self )
    {
        self.is_teleporting = 0;
    }
}

// Namespace perk_w_mod
// Params 1, eflags: 0xc
// Checksum 0xab7723c4, Offset: 0x1f90
// Size: 0xd3
function private function_26b507986e9824ed( player )
{
    self notify( #"hash_6ae97916395bf2b7" );
    self endon( #"hash_6ae97916395bf2b7" );
    self endon( #"wisp_death" );
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !player )
    {
        return;
    }
    
    while ( self )
    {
        if ( self.e_mover && self.e_mover.rotate_angles && self.e_mover.move_distance > 0.5 )
        {
            self.e_mover rotateto( self.e_mover.rotate_angles, 0.1 );
            self.e_mover waittill( #"rotatedone" );
        }
        
        waitframe();
    }
}

// Namespace perk_w_mod
// Params 3, eflags: 0x4
// Checksum 0xba5bb516, Offset: 0x206b
// Size: 0x16b
function private function_5da553f86a08cf57( wisp, var_bdd5725ddde1a788, is_alive_target = 1 )
{
    if ( !isdefined( var_bdd5725ddde1a788 ) )
    {
        return 0;
    }
    
    if ( wisp.var_cbe1e78c0be559d3 > wisp.var_61db20a999482609 )
    {
        return 0;
    }
    
    if ( wisp.is_teleporting )
    {
        return 0;
    }
    
    if ( wisp.var_21c148796dcc185f && is_alive_target )
    {
        traceresults = physics_raycast( self geteye() + ( 0, 0, 20 ), var_bdd5725ddde1a788, trace::create_default_contents(), undefined, 0, "physicsquery_closest", 0, 0 );
        can_move_to_enemy = isalive( traceresults[ 0 ][ "entity" ] );
    }
    else if ( wisp.var_21c148796dcc185f )
    {
        traceresults = physics_raycast( self geteye() + ( 0, 0, 20 ), var_bdd5725ddde1a788, trace::create_default_contents(), undefined, 0, "physicsquery_closest", 0, 0 );
        can_move_to_enemy = traceresults[ 0 ][ "hittype" ] != "hittype_world" || !traceresults[ 0 ];
    }
    else
    {
        can_move_to_enemy = 1;
    }
    
    /#
        if ( level.var_4738bf10918d677c )
        {
            trace::draw_trace( traceresults, ( 1, 1, 1 ), 0, 2 );
            line( self geteye() + ( 0, 0, 20 ), var_bdd5725ddde1a788, ( 1, 1, 1 ), 1, 1 );
        }
    #/
    
    return can_move_to_enemy;
}

// Namespace perk_w_mod
// Params 1, eflags: 0xc
// Checksum 0xf36cbeee, Offset: 0x21df
// Size: 0x5fa
function private function_9b1b29b9e04e1b47( player )
{
    self notify( #"hash_bfe865e922c97191" );
    self endon( #"hash_bfe865e922c97191" );
    self endon( #"wisp_death" );
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    attack_interval_time = self.var_4e6632480cfff133;
    
    while ( self && isent( self.e_mover ) )
    {
        wait attack_interval_time;
        
        if ( self && isplayer( player ) && player utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_demon_mask" ) )
        {
            self.var_67eac7361c5992b6 = 0;
        }
        
        if ( isplayer( player ) && player utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_lure" ) )
        {
            if ( self.locked_on_ent.var_75afeb7d6a870ec0 )
            {
                continue;
            }
        }
        
        if ( self.in_attack_range || self.var_3d4349e6aa22684e )
        {
            if ( isent( self.locked_on_ent ) && isalive( self.locked_on_ent ) )
            {
                function_f1573f15cd67f904( self.locked_on_ent, player function_ccdaa0a0c98b1c26() );
            }
            
            waitframe();
        }
        
        if ( self && isent( self.locked_on_ent ) && isplayer( player ) && isalive( self.locked_on_ent ) )
        {
            if ( !self.in_attack_range )
            {
                continue;
            }
            
            currentweapon = player getcurrentweapon();
            
            if ( self.var_43ca8673c4e4f107 )
            {
                damage = self.var_8bd6a439e83d23f8;
            }
            else
            {
                round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( player );
                base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
                damage = base_zombie_maxhealth * self.var_c30086d245483308;
            }
            
            if ( self.locked_on_ent.type == #"zombie" )
            {
                damage *= self.var_547b9cc4b23498d;
            }
            else if ( isplayer( self.locked_on_ent ) )
            {
                damage *= self.var_990ae4ab6dffedb6;
            }
            else
            {
                damage *= self.var_a3ea15f1c39b0ee0;
            }
            
            if ( weapon::ismeleeonly( self.proc_weapon ) || weapon::issuperweapon( self.proc_weapon ) || weapon::iskillstreakweapon( self.proc_weapon ) || weapon::isgamemodeweapon( self.proc_weapon ) )
            {
                w_wisp = weapon::buildweapon( level.laststandweapon );
                self.proc_weapon = w_wisp;
            }
            
            self.locked_on_ent.var_dd22e69947766504 = 1;
            
            if ( self.var_39ba408da99f8d3d )
            {
                damage_dflags = 0;
            }
            else
            {
                damage_dflags = 1073807360;
            }
            
            self.locked_on_ent dodamage( damage, self.e_mover.origin, player, player, "MOD_UNKNOWN", self.var_cb7b53471c8f3170, "torso_upper", undefined, damage_dflags );
            
            if ( player.var_d20938c9e42e667d )
            {
                playsoundatpos( self.e_mover.origin, player.var_d20938c9e42e667d );
            }
            
            self.locked_on_ent.var_dd22e69947766504 = undefined;
            
            if ( player utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_demon_mask" ) )
            {
                self.var_67eac7361c5992b6 = 1;
            }
            
            if ( player utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_will_o_wisp" ) )
            {
                var_a7c29cfa649167e0 = level.zombie_augments[ #"w_mod_will_o_wisp" ].var_e82b8b0b3b2d134a;
                enemy_team = utility::callsharedfunc( #"ai", #"get_aitype_default_spawn_team_SharedFunc" );
                enemy_array = getaiarrayinradius( self.e_mover.origin, var_a7c29cfa649167e0, enemy_team );
                
                foreach ( enemy in enemy_array )
                {
                    if ( !isdefined( level.w_mod_will_o_wisp_dmg_throttle ) )
                    {
                        level.w_mod_will_o_wisp_dmg_throttle = throttle::throttle_initialize( "w_mod_will_o_wisp_dmg_throttle", 1 );
                    }
                    
                    level throttle::throttle_wait_in_queue( level.w_mod_will_o_wisp_dmg_throttle, enemy );
                    
                    if ( enemy != self.locked_on_ent )
                    {
                        enemy.var_dd22e69947766504 = 1;
                        enemy dodamage( damage, self.e_mover.origin, player, player, "MOD_UNKNOWN", "<explicitweaponnone>", "torso_upper", undefined, damage_dflags );
                        enemy.var_dd22e69947766504 = undefined;
                    }
                }
            }
            
            if ( isent( self.locked_on_ent ) && isalive( self.locked_on_ent ) )
            {
                if ( !isdefined( self.locked_on_ent.var_2204cc1654475fd7 ) )
                {
                    self.locked_on_ent.var_2204cc1654475fd7 = 0;
                }
                
                self.locked_on_ent.var_2204cc1654475fd7++;
                
                if ( self.locked_on_ent.var_2204cc1654475fd7 >= 6 )
                {
                    self.locked_on_ent.var_270eef9780ddfbb2 = gettime() + 3000;
                    self.locked_on_ent.var_2204cc1654475fd7 = 0;
                }
                
                continue;
            }
            
            player namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"zombie_kia_w_mod" );
        }
    }
}

// Namespace perk_w_mod
// Params 2, eflags: 0x4
// Checksum 0x753fbcf4, Offset: 0x27e1
// Size: 0x72
function private function_f1573f15cd67f904( target, var_6f7f53aefaa4347d )
{
    if ( isxhash( var_6f7f53aefaa4347d ) || isstring( var_6f7f53aefaa4347d ) )
    {
        fx_id = level._effect[ var_6f7f53aefaa4347d ];
    }
    else
    {
        fx_id = var_6f7f53aefaa4347d;
    }
    
    if ( target tagexists( "j_spine4" ) )
    {
        playfxontag( fx_id, target, "j_spine4" );
        return;
    }
    
    playfxontag( fx_id, target, "tag_origin" );
}

// Namespace perk_w_mod
// Params 2, eflags: 0x4
// Checksum 0xc624c5ae, Offset: 0x285b
// Size: 0x6e
function private function_9dc527997431998f( pos, var_6f7f53aefaa4347d )
{
    if ( isxhash( var_6f7f53aefaa4347d ) || isstring( var_6f7f53aefaa4347d ) )
    {
        fx_id = level._effect[ var_6f7f53aefaa4347d ];
    }
    else
    {
        fx_id = var_6f7f53aefaa4347d;
    }
    
    var_c16e8946d253c0ce = spawnfx( fx_id, pos );
    triggerfx( var_c16e8946d253c0ce );
    wait 2;
    
    if ( var_c16e8946d253c0ce )
    {
        var_c16e8946d253c0ce delete();
    }
}

// Namespace perk_w_mod
// Params 1
// Checksum 0x816c0801, Offset: 0x28d1
// Size: 0xc5
function wisp_death_watcher( player )
{
    self endon( #"wisp_death" );
    wait self.var_bb063e46d21339cf;
    start_time = gettime();
    time_elapsed = gettime() - start_time;
    
    if ( player utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_lure" ) )
    {
        while ( isent( self.locked_on_ent ) && isalive( self.locked_on_ent ) && self.locked_on_ent.var_75afeb7d6a870ec0 && time_elapsed < 600000 )
        {
            wait 1;
            time_elapsed = gettime() - start_time;
        }
    }
    
    thread delete_wisp( player );
}

// Namespace perk_w_mod
// Params 1
// Checksum 0x1c54992, Offset: 0x299e
// Size: 0x1e8
function delete_wisp( player )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !self isscriptableinstance() )
    {
        return;
    }
    
    if ( player utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_savior" ) )
    {
        player val::reset( "w_mod_savior", "allow_last_stand" );
        player thread utility::callsharedfunc( #"zm_laststand", #"zm_laststand_alive_check" );
    }
    
    if ( self.var_651194267e546747 )
    {
        zombie_attractor_manager::remove_attractor( self.var_651194267e546747 );
    }
    
    if ( self.var_abb6f3b49bff999f )
    {
        zombie_attractor_manager::remove_attractor( self.var_abb6f3b49bff999f );
    }
    
    var_212182deaf095089 = player.var_f719974045aab983 ?? #"hash_ce835189fae04fb5";
    playsoundatpos( self.origin, var_212182deaf095089 );
    level thread function_9dc527997431998f( self.origin, player function_e004d0a963719d1d() );
    waitframe();
    self notify( #"wisp_death" );
    
    if ( isplayer( player ) && isdefined( player.var_8cfbf5cf0100bf52 ) )
    {
        player.var_8cfbf5cf0100bf52 delete();
        waitframe();
    }
    
    if ( isplayer( player ) )
    {
        player utility::function_7c10ea82c1e305b8( "w_mod_heal", "off" );
    }
    
    if ( isent( self.e_mover ) )
    {
        self.e_mover delete();
    }
    
    if ( self && self isscriptableinstance() )
    {
        self freescriptable();
    }
    
    if ( isplayer( player ) )
    {
        player.var_4fd5ac47a9bd8c18 = undefined;
        player val::reset( "w_mod", "ignore_afk" );
        player.var_3f4ab11e0fd7c0e6 = gettime();
    }
    
    params = spawnstruct();
    params.owner = player;
    level callback::callback( "w_mod_despawned", params );
    
    /#
        iprintlnbold( "<dev string:x34>" );
    #/
}

// Namespace perk_w_mod
// Params 2
// Checksum 0x7e02c4be, Offset: 0x2b8e
// Size: 0x36, Type: bool
function function_6d4719a0ca40944a( attractor, ai )
{
    return ai.aicategory == "normal" && !ai.var_840153567385cc6b;
}

// Namespace perk_w_mod
// Params 1
// Checksum 0x1244f29, Offset: 0x2bcd
// Size: 0x4e, Type: bool
function function_de79bd3b0e276b33( target )
{
    if ( self.var_4fd5ac47a9bd8c18 && target )
    {
        self.var_4fd5ac47a9bd8c18.force_target = target;
        self.var_4fd5ac47a9bd8c18.locked_on_ent = target;
        return true;
    }
    
    return false;
}

// Namespace perk_w_mod
// Params 0
// Checksum 0x2037261c, Offset: 0x2c24
// Size: 0x4b
function function_83edc9631d14829c()
{
    if ( self.var_4fd5ac47a9bd8c18 && self.var_4fd5ac47a9bd8c18.force_target )
    {
        self.var_4fd5ac47a9bd8c18.force_target = undefined;
        self.var_4fd5ac47a9bd8c18.locked_on_ent = undefined;
    }
}

// Namespace perk_w_mod
// Params 1
// Checksum 0x1f1137ff, Offset: 0x2c77
// Size: 0x1c
function wisp_ignore( id )
{
    val::set( id, "w_mod_ignore_target", 1 );
}

// Namespace perk_w_mod
// Params 1
// Checksum 0x41c0266c, Offset: 0x2c9b
// Size: 0x1a
function function_2ba31641db668862( id )
{
    val::reset( id, "w_mod_ignore_target" );
}

// Namespace perk_w_mod
// Params 1, eflags: 0x4
// Checksum 0x93586826, Offset: 0x2cbd
// Size: 0x33, Type: bool
function private function_59fb39487166f319( target )
{
    return target.team != self.team && !target val::get( "w_mod_ignore_target" );
}

// Namespace perk_w_mod
// Params 3, eflags: 0x4
// Checksum 0xb5f2b76b, Offset: 0x2cf9
// Size: 0x68
function private get_closest_enemy( origin, radius, var_112369a470e1652 )
{
    if ( var_112369a470e1652 )
    {
        var_fdc5e4472f1e2a76 = getplayersandaiarrayinradius( origin, radius );
        var_824d754551b7938e = utility::get_closest_filtered( origin, var_fdc5e4472f1e2a76, radius, &function_59fb39487166f319 );
        return var_824d754551b7938e;
    }
    
    var_824d754551b7938e = ai::get_ai_closest( origin, undefined, undefined, undefined, radius, &function_59fb39487166f319 );
    return var_824d754551b7938e;
}

/#

    // Namespace perk_w_mod
    // Params 0
    // Checksum 0x8fa420da, Offset: 0x2d6a
    // Size: 0x74, Type: dev
    function setup_w_mod_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x45>" );
        devgui::add_devgui_func( "<dev string:x5b>", "<dev string:x6b>", &function_ba881c0e0dbbf42d, 0 );
        devgui::add_devgui_func( "<dev string:x81>", "<dev string:x98>", &function_1edf1937cf479d59, 0 );
        devgui::add_devgui_func( "<dev string:xae>", "<dev string:xcd>", &function_aac0543e7c1ea0d0, 0 );
        devgui::add_devgui_func( "<dev string:xe8>", "<dev string:xfa>", &function_6077b12f615bc7f5, 0 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace perk_w_mod
    // Params 0
    // Checksum 0x60ebfb45, Offset: 0x2de6
    // Size: 0x98, Type: dev
    function function_6077b12f615bc7f5()
    {
        foreach ( player in level.players )
        {
            if ( isdefined( player.var_4fd5ac47a9bd8c18 ) )
            {
                player.var_4fd5ac47a9bd8c18 delete_wisp( player );
            }
        }
    }

    // Namespace perk_w_mod
    // Params 0
    // Checksum 0x1084f0cb, Offset: 0x2e86
    // Size: 0x3d, Type: dev
    function function_ba881c0e0dbbf42d()
    {
        if ( level.var_f1c54646e394530 )
        {
            level.var_f1c54646e394530 = 0;
            iprintlnbold( "<dev string:x10c>" );
            return;
        }
        
        level.var_f1c54646e394530 = 1;
        iprintlnbold( "<dev string:x128>" );
    }

    // Namespace perk_w_mod
    // Params 0
    // Checksum 0x76d44199, Offset: 0x2ecb
    // Size: 0x3d, Type: dev
    function function_1edf1937cf479d59()
    {
        if ( level.var_1841284cde59f340 )
        {
            level.var_1841284cde59f340 = 0;
            iprintlnbold( "<dev string:x143>" );
            return;
        }
        
        level.var_1841284cde59f340 = 1;
        iprintlnbold( "<dev string:x163>" );
    }

    // Namespace perk_w_mod
    // Params 0
    // Checksum 0xe3450eba, Offset: 0x2f10
    // Size: 0x3d, Type: dev
    function function_aac0543e7c1ea0d0()
    {
        if ( level.var_4738bf10918d677c )
        {
            level.var_4738bf10918d677c = 0;
            iprintlnbold( "<dev string:x182>" );
            return;
        }
        
        level.var_4738bf10918d677c = 1;
        iprintlnbold( "<dev string:x1a5>" );
    }

#/
