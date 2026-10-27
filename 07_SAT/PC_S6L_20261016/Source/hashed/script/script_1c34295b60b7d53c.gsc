// script_1c34295b60b7d53c  (hash_1c34295b60b7d53c.gscc) (size: 4341 Bytes / 0x10f5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x44580913 (1146620179)
// size ...... 4341 (0x10f5)
// includes .. 8   (offset: 0xf89)
// strings ... 19  (offset: 0xfc9)
// dev strs .. 0   (offset: 0x10f5)
// exports ... 9   (offset: 0x939)
// cseg ...... 0x236 + 0x703 (0x939)
// imports ... 43  (offset: 0xaa1)
// animtree1 . 0   (offset: 0x10f5)
// animtree2 . 0   (offset: 0x10f5)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_enemy_ai;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;

#namespace namespace_88202cd1fcbe89e9;

// Namespace namespace_88202cd1fcbe89e9
// Params 0, eflags: 0x5
// Checksum 0xf970b4d7, Offset: 0x254
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_f4d0c1cdd8f35630", #"ztron_item", undefined, &init );
}

// Namespace namespace_88202cd1fcbe89e9
// Params 0
// Checksum 0xfa38172d, Offset: 0x27d
// Size: 0x66
function init()
{
    utility::add_fx( "ztron_horn", "vfx_sat_zm_horn_ztron" );
    utility::add_fx( "ztron_team_shift", "vfx_sat_zm_powerup_timeshift_red_ztron" );
    ztron_item::function_5844a9c240f7dc8d( #"coat_of_arms", #"use", &usecoatofarms );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_coatofarms_active_lp", "evt_ztron_pickup_coatofarms_active_lp", 1 );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_coatofarms_active_end", "evt_ztron_pickup_coatofarms_active_end" );
}

// Namespace namespace_88202cd1fcbe89e9
// Params 1
// Checksum 0xd80bb35d, Offset: 0x2eb
// Size: 0x88
function usecoatofarms( params )
{
    player = params.player;
    item = params.scriptable;
    itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
    ground_pos = utility::drop_to_ground( item.origin, 30, -100 );
    level thread function_48af9b28a56a2c8c( ground_pos, player, itemdata.duration );
}

// Namespace namespace_88202cd1fcbe89e9
// Params 3
// Checksum 0x964e1439, Offset: 0x37b
// Size: 0x1d6
function function_48af9b28a56a2c8c( origin, player, duration = 20 )
{
    var_26dad9e6f542326d = utility::spawn_model( "sat_zm_ztron_props_coat_of_arms", origin + ( 0, 0, 36 ) );
    
    if ( !isdefined( var_26dad9e6f542326d ) )
    {
        return;
    }
    
    var_26dad9e6f542326d notsolid();
    trigger = spawn( "trigger_radius", var_26dad9e6f542326d.origin, 0, 245, 60 );
    
    if ( !isdefined( trigger ) )
    {
        var_26dad9e6f542326d delete();
        return;
    }
    
    ztron_sound::ztron_playsound( "ztron_pickup_coatofarms_active_lp", undefined, var_26dad9e6f542326d );
    trigger.owner = player;
    trigger.color = player.ztron.color;
    trigger enablelinkto();
    trigger linkto( var_26dad9e6f542326d );
    trigger.radius = 245;
    trigger.opentime = 3000;
    trigger.openfull = gettime() + trigger.opentime;
    playfxontag( utility::getfx( "ztron_team_shift" ), var_26dad9e6f542326d, "tag_origin" );
    trigger thread function_cb7d14c0b71793fe( player ztron_player_utility::function_10777122eee28fa8( duration ), player.team );
    duration = 3.1;
    
    if ( player.ztron.upgradeMask & 16384 )
    {
        duration *= 1.5;
    }
    
    player utility::waittill_any_timeout( duration, "ztron_exit_taken", "ztron_teleporter_taken" );
    stopfxontag( utility::getfx( "ztron_team_shift" ), var_26dad9e6f542326d, "tag_origin" );
    ztron_sound::ztron_stopsound( var_26dad9e6f542326d );
    ztron_sound::ztron_playsound( "ztron_pickup_coatofarms_active_end", undefined, var_26dad9e6f542326d );
    wait 1;
    
    if ( isdefined( var_26dad9e6f542326d ) )
    {
        var_26dad9e6f542326d delete();
    }
    
    if ( isdefined( trigger ) )
    {
        trigger delete();
    }
}

// Namespace namespace_88202cd1fcbe89e9
// Params 2
// Checksum 0x58010c06, Offset: 0x559
// Size: 0x1b8
function function_cb7d14c0b71793fe( duration, owner_team )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", guy );
        
        if ( isplayer( guy ) )
        {
            continue;
        }
        
        if ( !isdefined( guy.ztron ) )
        {
            continue;
        }
        
        if ( guy.teamshifted )
        {
            continue;
        }
        
        if ( guy.no_coatofarms || guy.ztron.boss )
        {
            continue;
        }
        
        if ( guy isragdoll() )
        {
            continue;
        }
        
        if ( !isalive( guy ) || guy.health <= 0 )
        {
            continue;
        }
        
        if ( guy.team == owner_team )
        {
            continue;
        }
        
        if ( isdefined( self.openfull ) )
        {
            time = gettime();
            
            if ( time < self.openfull )
            {
                dist = distance( guy.origin, self.origin );
                frac = dist / self.radius;
                diff = time - self.birthtime;
                dfrac = diff / self.opentime;
                
                if ( frac > dfrac )
                {
                    continue;
                }
            }
        }
        
        self.owner thread ztron_player_utility::function_9dbd11353321b474( "coatofarms", guy.var_945ef487faad2413 );
        guy thread function_cb59f7c0b6f10c7f( self, duration, owner_team );
        guy thread ztron_util::function_b0697f1cfec70e89( level, "ztron_exit_taken", "ztron_teleporter_taken", "round_over" );
    }
}

// Namespace namespace_88202cd1fcbe89e9
// Params 3, eflags: 0x4
// Checksum 0x76842ad0, Offset: 0x719
// Size: 0x172
function private function_cb59f7c0b6f10c7f( trigger, duration, new_team )
{
    self endon( #"death" );
    self.teamshifted = 1;
    color = trigger.color;
    ztron_vfx::function_a2884eba34f8ea6b( utility::getfx( "ztron_horn" ), self, "tag_origin" );
    ztron_vfx::function_a2884eba34f8ea6b( utility::getfx( "ztron_player_trail_" + color ), self, "tag_origin" );
    self.oldteam = self.team;
    oldmelee = self.meleedamage;
    self.meleedamage = 750;
    self.team = new_team;
    function_e985dc41bc98059b();
    result = level utility::waittill_any_return_params_or_timeout( duration, "coat_shift_back", "slayer_round_finished", "round_over" );
    ztron_vfx::aistopfxontag( utility::getfx( "ztron_horn" ), self, "tag_origin" );
    ztron_vfx::aistopfxontag( utility::getfx( "ztron_player_trail_" + color ), self, "tag_origin" );
    self.teamshifted = undefined;
    self.team = self.oldteam;
    self.meleedamage = oldmelee;
    function_e985dc41bc98059b();
    
    if ( result[ "message" ] == "slayer_round_finished" || result[ "message" ] == "round_over" )
    {
        thread ztron_util::function_ea0a0be5c5468c48( 0.1 );
    }
}

// Namespace namespace_88202cd1fcbe89e9
// Params 0, eflags: 0x4
// Checksum 0xa46333b1, Offset: 0x893
// Size: 0x35
function private function_e985dc41bc98059b()
{
    self clearenemy();
    self.favoriteenemy = undefined;
    ztron_enemy_ai::function_29bbc6846013b71b();
    
    if ( isdefined( self.favoriteenemy ) )
    {
        self getenemyinfo( self.favoriteenemy );
    }
}

/#

    // Namespace namespace_88202cd1fcbe89e9
    // Params 1
    // Checksum 0xf987ed9e, Offset: 0x8d0
    // Size: 0x69, Type: dev
    function function_37139f6968a68641( trigger )
    {
        level endon( #"ztron_game_is_over" );
        setdvarifuninitialized( @"hash_530aba970305c0c", 1 );
        
        while ( isdefined( trigger ) )
        {
            if ( getdvarint( @"hash_530aba970305c0c" ) )
            {
                drawtrigger( trigger, ( 0, 1, 0 ), 0, 0, 0, ( 0, 1, 0 ) );
            }
            
            waitframe();
        }
    }

#/
