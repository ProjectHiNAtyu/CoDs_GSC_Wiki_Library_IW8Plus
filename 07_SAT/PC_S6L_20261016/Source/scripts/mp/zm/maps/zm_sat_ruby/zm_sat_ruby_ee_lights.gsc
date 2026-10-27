// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_lights.gsc  (hash_5e4bf9c603de9044.gscc) (size: 13248 Bytes / 0x33c0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2fa259c9 (799168969)
// size ...... 13248 (0x33c0)
// includes .. 11  (offset: 0x307c)
// strings ... 43  (offset: 0x30d4)
// dev strs .. 5   (offset: 0x3384)
// exports ... 25  (offset: 0x1e08)
// cseg ...... 0x40b + 0x19fd (0x1e08)
// imports ... 121 (offset: 0x21f0)
// animtree1 . 0   (offset: 0x33c0)
// animtree2 . 0   (offset: 0x33c0)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\callbacks;
#using scripts\common\heartbeat;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_ruby_ee_lights;

// Namespace zm_sat_ruby_ee_lights
// Params 0, eflags: 0x5
// Checksum 0xa800a09c, Offset: 0x429
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_c086bf1fdc49e868", #"zm_quest", &function_64c919a3c3f4f9d9, &function_a9e47fbcbb37cade );
}

// Namespace zm_sat_ruby_ee_lights
// Params 0, eflags: 0x4
// Checksum 0x7b66ddfa, Offset: 0x456
// Size: 0xf5
function private function_64c919a3c3f4f9d9()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    level.var_938002c14e89645f = zm_quest::get_quest( #"hash_c086bf1fdc49e868" );
    level.var_938002c14e89645f.var_304b6020739ee663 = loadfxasset( "vfx_sat_levels_zm_ruby_wall_lamp_moving" );
    level.var_938002c14e89645f.fx_light_max = loadfxasset( "vfx_sat_levels_zm_ruby_wall_lamp_upgraded_moving" );
    level.var_938002c14e89645f.fx_blast_attack = loadfxasset( "vfx_sat_levels_zm_ruby_wall_lamp_light_attack" );
    level.var_938002c14e89645f.var_c72b39e141bbad57 = loadfxasset( "vfx_sat_levels_zm_ruby_wall_lamp_light_attack_upgraded" );
    zm_quest::register_quest_step( #"hash_c086bf1fdc49e868", #"take_light", &setup_take_light );
    zm_quest::register_quest_step( #"hash_c086bf1fdc49e868", #"give_light", &setup_all_lights, &all_lights_complete );
}

// Namespace zm_sat_ruby_ee_lights
// Params 0, eflags: 0x4
// Checksum 0x937b7154, Offset: 0x553
// Size: 0x40
function private function_a9e47fbcbb37cade()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hash_c086bf1fdc49e868" );
}

// Namespace zm_sat_ruby_ee_lights
// Params 2, eflags: 0x4
// Checksum 0xc241b327, Offset: 0x59b
// Size: 0x2c
function private setup_take_light( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        level thread function_d88735a14a28f1ac();
        return;
    }
    
    function_d88735a14a28f1ac();
}

// Namespace zm_sat_ruby_ee_lights
// Params 0, eflags: 0x4
// Checksum 0x2cd70447, Offset: 0x5cf
// Size: 0x134
function private function_d88735a14a28f1ac()
{
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "begin_round_logic" );
    level.var_938002c14e89645f.n_attack_radius = 64;
    level.var_938002c14e89645f.var_852b5e0f670dbc6e = "on";
    level.var_938002c14e89645f.a_lamps = getentitylessscriptablearray( "scriptable_zm_sat_ruby_ee_light", #classname );
    var_14ccbbb87eee7648 = zm_quest::function_73720cdf21c3cfd7( #"hash_c086bf1fdc49e868", #"starter" );
    
    if ( var_14ccbbb87eee7648 )
    {
        level thread function_b218226f3eb24c5d( var_14ccbbb87eee7648 );
        return;
    }
    
    level utility::flag_set( "ee_la_save_restore_complete" );
    starter = utility::array_random( level.var_938002c14e89645f.a_lamps );
    starter setscriptablepartstate( "vfx", "on" );
    starter.var_e12f26713e8411c0 = 1;
    zm_quest::function_4eefe6de31f5ddab( #"hash_c086bf1fdc49e868", #"starter", int( starter.script_noteworthy ) );
    
    /#
        level thread ee_lights_debug( starter );
    #/
    
    starter turn_on_lamp();
}

// Namespace zm_sat_ruby_ee_lights
// Params 1, eflags: 0x4
// Checksum 0x4d1bcd10, Offset: 0x70b
// Size: 0x146
function private function_b218226f3eb24c5d( var_14ccbbb87eee7648 )
{
    level utility::flag_wait( "initial_player_spawned" );
    
    foreach ( lamp in level.var_938002c14e89645f.a_lamps )
    {
        var_22754e38a04d6172 = zm_quest::function_73720cdf21c3cfd7( #"hash_c086bf1fdc49e868", getxhash( lamp.script_noteworthy ) );
        
        if ( var_22754e38a04d6172 == 1 )
        {
            lamp thread turn_on_lamp();
        }
        else if ( var_22754e38a04d6172 == 0 )
        {
            lamp.var_e12f26713e8411c0 = undefined;
            lamp setscriptablepartstate( "vfx", "recharging" );
            lamp thread recharge_lamp();
        }
        
        if ( zm_quest::function_73720cdf21c3cfd7( #"hash_c086bf1fdc49e868", hashcat( #"hash_17658c8cf4a56018", lamp.script_noteworthy ) ) )
        {
            lamp function_2247b874d7369e02( level.players[ 0 ] );
        }
    }
    
    level utility::flag_set( "ee_la_save_restore_complete" );
}

// Namespace zm_sat_ruby_ee_lights
// Params 2, eflags: 0x4
// Checksum 0xa6f16adc, Offset: 0x859
// Size: 0x31
function private setup_all_lights( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        level thread function_4be78f4da774ec8b();
        return;
    }
    
    function_4be78f4da774ec8b();
    function_a26f1150f7ed9875();
}

// Namespace zm_sat_ruby_ee_lights
// Params 2, eflags: 0x4
// Checksum 0x268867d2, Offset: 0x892
// Size: 0x1f
function private all_lights_complete( b_skipped, b_save_restored )
{
    level thread upgrade_all_lights( b_skipped );
}

// Namespace zm_sat_ruby_ee_lights
// Params 1, eflags: 0x4
// Checksum 0x5e4f881, Offset: 0x8b9
// Size: 0x285
function private upgrade_all_lights( b_skipped )
{
    level utility::flag_wait( "ee_la_save_restore_complete" );
    
    foreach ( player in level.players )
    {
        player playsoundtoplayer( "evt_ee_complete_success_stinger", player );
        
        if ( player.var_861e3c3dc470a34 )
        {
            foreach ( light in player.var_861e3c3dc470a34 )
            {
                killfxontag( level.var_938002c14e89645f.var_304b6020739ee663, light, "tag_origin" );
                playfxontag( level.var_938002c14e89645f.fx_light_max, light, "tag_origin" );
            }
        }
    }
    
    level.var_938002c14e89645f.n_attack_radius = 100;
    level.var_938002c14e89645f.var_852b5e0f670dbc6e = "maxed";
    level.var_938002c14e89645f.var_304b6020739ee663 = level.var_938002c14e89645f.fx_light_max;
    
    foreach ( lamp in level.var_938002c14e89645f.a_lamps )
    {
        if ( b_skipped && getdvarint( @"ee_lights_debug", 0 ) )
        {
            lamp thread turn_on_lamp();
            continue;
        }
        
        if ( lamp.var_e12f26713e8411c0 )
        {
            lamp setscriptablepartstate( "vfx", level.var_938002c14e89645f.var_852b5e0f670dbc6e );
            continue;
        }
        
        lamp setscriptablepartstate( "vfx", "recharging" );
    }
}

// Namespace zm_sat_ruby_ee_lights
// Params 0, eflags: 0x4
// Checksum 0xa51d2b60, Offset: 0xb46
// Size: 0xa2
function private function_4be78f4da774ec8b()
{
    level utility::flag_wait( "ee_la_save_restore_complete" );
    
    foreach ( lamp in level.var_938002c14e89645f.a_lamps )
    {
        if ( !lamp.var_e12f26713e8411c0 )
        {
            lamp thread function_edb57f576ef436f7();
            waitframe();
        }
    }
}

// Namespace zm_sat_ruby_ee_lights
// Params 0, eflags: 0x4
// Checksum 0x3156d202, Offset: 0xbf0
// Size: 0xbd
function private function_a26f1150f7ed9875()
{
    while ( true )
    {
        b_complete = 1;
        level waittill( #"on_round_end" );
        wait 5;
        
        foreach ( lamp in level.var_938002c14e89645f.a_lamps )
        {
            if ( !lamp.var_e12f26713e8411c0 )
            {
                b_complete = 0;
                break;
            }
        }
        
        if ( b_complete )
        {
            break;
        }
    }
}

// Namespace zm_sat_ruby_ee_lights
// Params 0, eflags: 0x4
// Checksum 0x7c319754, Offset: 0xcb5
// Size: 0x9a
function private function_edb57f576ef436f7()
{
    self waittill( #"light_hit_lamp", params );
    self.var_e12f26713e8411c0 = 1;
    params.e_light moveto( self.origin, 0.3 );
    params.e_light waittill( #"movedone" );
    killfxontag( level.var_938002c14e89645f.var_304b6020739ee663, params.e_light, "tag_origin" );
    params.e_light delete();
    thread turn_on_lamp();
}

// Namespace zm_sat_ruby_ee_lights
// Params 0, eflags: 0x4
// Checksum 0xf0144ab8, Offset: 0xd57
// Size: 0x95
function private turn_on_lamp()
{
    self setscriptablepartstate( "vfx", level.var_938002c14e89645f.var_852b5e0f670dbc6e );
    self.var_e12f26713e8411c0 = 1;
    self.b_recharging = undefined;
    zm_quest::function_4eefe6de31f5ddab( #"hash_c086bf1fdc49e868", getxhash( self.script_noteworthy ), 1 );
    
    if ( !isdefined( self.trigger ) )
    {
        self.trigger = spawn( "noent_volume_trigger_radius", self.origin - ( 0, 0, 200 ), 0, 200, 200 );
    }
    
    function_227751973d4e0a70();
}

// Namespace zm_sat_ruby_ee_lights
// Params 0, eflags: 0x4
// Checksum 0x54639830, Offset: 0xdf4
// Size: 0x3d
function private recharge_lamp()
{
    self endon( #"death" );
    self.b_recharging = 1;
    wait 3;
    level waittill( #"on_round_end" );
    
    if ( self.var_e12f26713e8411c0 )
    {
        return;
    }
    
    thread turn_on_lamp();
}

// Namespace zm_sat_ruby_ee_lights
// Params 0, eflags: 0xc
// Checksum 0xf052afd5, Offset: 0xe39
// Size: 0x170
function private function_227751973d4e0a70()
{
    self notify( #"hash_1507ced386a7411d" );
    self endon( #"hash_1507ced386a7411d" );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", player );
        
        if ( player.var_861e3c3dc470a34 && player.var_861e3c3dc470a34.size == 5 )
        {
            continue;
        }
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        n_count = 0;
        
        while ( isalive( player ) && player playerads() == 1 && n_count < 3 )
        {
            v_start = player utility::get_player_camera_origin();
            v_end = v_start + anglestoforward( player getplayerangles() ) * 200;
            trace = trace::ray_trace( v_start, v_end, player );
            
            if ( distance( trace[ "position" ], self.origin ) > 16 )
            {
                break;
            }
            
            wait 1;
            n_count++;
            player thread heartbeat_thread();
        }
        
        if ( n_count == 3 && isalive( player ) && player playerads() == 1 )
        {
            self.var_e12f26713e8411c0 = undefined;
            self setscriptablepartstate( "vfx", "recharging" );
            zm_quest::function_4eefe6de31f5ddab( #"hash_c086bf1fdc49e868", getxhash( self.script_noteworthy ), 0 );
            thread function_2247b874d7369e02( player );
            break;
        }
    }
}

// Namespace zm_sat_ruby_ee_lights
// Params 0, eflags: 0x4
// Checksum 0x3b6420e0, Offset: 0xfb1
// Size: 0x1a
function private heartbeat_thread()
{
    self endon( #"death_or_disconnect" );
    childthread heartbeat::function_8dc91616e5f2c60( "heartbeatLight" );
}

// Namespace zm_sat_ruby_ee_lights
// Params 1, eflags: 0x4
// Checksum 0x79ff1664, Offset: 0xfd3
// Size: 0x1d1
function private function_2247b874d7369e02( player )
{
    e_rotater = utility::spawn_model( "tag_origin", player getcentroid() );
    e_rotater linkto( player );
    player.ee_light_rotater = e_rotater;
    
    if ( !isdefined( player.var_60a5924ebae9c069 ) )
    {
        player.var_60a5924ebae9c069 = 0;
    }
    
    player.var_60a5924ebae9c069++;
    zm_quest::function_4eefe6de31f5ddab( #"hash_c086bf1fdc49e868", hashcat( #"hash_17658c8cf4a56018", self.script_noteworthy ), 1 );
    e_light = utility::spawn_model( "tag_origin", self.origin );
    e_light.e_lamp = self;
    e_light playsoundonmovingent( "evt_ruby_ee_light_absorb" );
    playfxontag( level.var_938002c14e89645f.var_304b6020739ee663, e_light, "tag_origin" );
    e_light playloopsound( "evt_trail_lp" );
    
    do
    {
        var_44616205278e62f2 = function_2ac1cef0fcea2bf5( player );
        e_light moveto( var_44616205278e62f2, 0.25, 0.1 );
        wait 0.25;
    }
    while ( distance( var_44616205278e62f2, e_light.origin ) > 32 );
    
    if ( !isalive( player ) )
    {
        e_light delete();
        thread recharge_lamp();
        return;
    }
    
    if ( !player.var_99a9f9a29f376728 )
    {
        player.var_99a9f9a29f376728 = 1;
        player playloopsound( "amb_ruby_ee_light_circling_plr_lp" );
    }
    
    player thread function_853957fb5c5cc5ca();
    
    if ( !isdefined( player.var_861e3c3dc470a34 ) )
    {
        player.var_861e3c3dc470a34 = [];
    }
    
    player.var_861e3c3dc470a34[ player.var_861e3c3dc470a34.size ] = e_light;
    e_light linkto( e_rotater );
    e_rotater function_f137e973856d34d9( ( 0, 360000, 0 ), 3000 );
}

// Namespace zm_sat_ruby_ee_lights
// Params 1, eflags: 0x4
// Checksum 0x3a505d6, Offset: 0x11ac
// Size: 0x40
function private function_2ac1cef0fcea2bf5( player )
{
    var_44616205278e62f2 = player utility::get_player_camera_origin() + anglestoforward( player getplayerangles( 1 ) ) * 24 + ( 0, 0, -18 );
    return var_44616205278e62f2;
}

// Namespace zm_sat_ruby_ee_lights
// Params 0, eflags: 0xc
// Checksum 0xb1fba8e0, Offset: 0x11f5
// Size: 0x236
function private function_853957fb5c5cc5ca()
{
    self notify( #"hash_77f8fecbd33fe281" );
    self endon( #"hash_77f8fecbd33fe281" );
    self notifyonplayercommand( "launch_light", "+melee" );
    self notifyonplayercommand( "launch_light", "+melee_zoom" );
    self notifyonplayercommand( "launch_light", "+melee_sprint" );
    self notifyonplayercommand( "launch_light", "+melee_breath" );
    
    while ( isalive( self ) )
    {
        str_notify = utility::waittill_any_return( "death", "disconnect", "launch_light" );
        
        if ( str_notify == "death" || str_notify == "disconnect" )
        {
            if ( self.var_861e3c3dc470a34 )
            {
                foreach ( light in self.var_861e3c3dc470a34 )
                {
                    if ( light )
                    {
                        light.e_lamp thread recharge_lamp();
                        light delete();
                    }
                }
            }
            
            if ( self.ee_light_rotater )
            {
                self.ee_light_rotater delete();
            }
            
            return;
        }
        
        e_light = utility::array_random( self.var_861e3c3dc470a34 );
        self.var_861e3c3dc470a34 = arrayremove( self.var_861e3c3dc470a34, e_light );
        zm_quest::function_6265be8d0549e1b1( #"hash_c086bf1fdc49e868", hashcat( #"hash_17658c8cf4a56018", e_light.e_lamp.script_noteworthy ) );
        level callback::callback( #"hash_b61059e638cec9a3", { #ent:e_light } );
        level thread function_615360b63eaa6154( self, e_light );
        
        if ( self.var_861e3c3dc470a34.size == 0 )
        {
            break;
        }
        
        wait 1;
        continue;
    }
    
    self notifyonplayercommandremove( "launch_light", "+melee" );
    self notifyonplayercommandremove( "launch_light", "+melee_zoom" );
    self notifyonplayercommandremove( "launch_light", "+melee_sprint" );
    self notifyonplayercommandremove( "launch_light", "+melee_breath" );
}

// Namespace zm_sat_ruby_ee_lights
// Params 2, eflags: 0x4
// Checksum 0xa13fa2, Offset: 0x1433
// Size: 0x259
function private function_615360b63eaa6154( player, e_light )
{
    if ( !e_light )
    {
        return;
    }
    
    killfxontag( level.var_938002c14e89645f.var_304b6020739ee663, e_light, "tag_origin" );
    player.var_60a5924ebae9c069--;
    
    if ( player playerads() < 1 )
    {
        wait 0.3;
    }
    
    if ( player.var_99a9f9a29f376728 && player.var_60a5924ebae9c069 == 0 )
    {
        player.var_99a9f9a29f376728 = undefined;
        player stoploopsound( "amb_ruby_ee_light_circling_plr_lp" );
    }
    
    e_light unlink();
    waitframe();
    playfxontag( level.var_938002c14e89645f.var_304b6020739ee663, e_light, "tag_origin" );
    
    if ( player )
    {
        player playsound( "evt_ruby_ee_light_attack_launch" );
        v_start = player utility::get_player_camera_origin();
        v_end = v_start + anglestoforward( player getplayerangles() ) * 4000;
        contents = trace::create_default_contents( 1 );
        trace = trace::ray_trace( v_start, v_end, player, contents );
        var_6c269b1b35003e9e = trace[ "position" ] ?? v_end;
        n_move_time = distance( v_start, var_6c269b1b35003e9e ) / 500;
        e_light.origin = v_start;
        e_light moveto( var_6c269b1b35003e9e, n_move_time );
        level thread function_4e7799d557475dd0( e_light );
        e_light utility::waittill_any_timeout( n_move_time, "light_hit" );
        function_271c810c7ec2ba39( player, e_light, var_6c269b1b35003e9e, v_end, v_start );
        
        /#
            if ( e_light && getdvarint( @"ee_lights_debug", 0 ) == 2 )
            {
                v_follow = function_2ac1cef0fcea2bf5( player );
                e_light dontinterpolate();
                e_light.origin = v_follow;
                e_light linkto( player.ee_light_rotater );
                playfxontag( level.var_938002c14e89645f.var_304b6020739ee663, e_light, "<dev string:x24>" );
                player.var_861e3c3dc470a34[ player.var_861e3c3dc470a34.size ] = e_light;
                player thread function_853957fb5c5cc5ca();
                return;
            }
        #/
    }
    
    e_light.e_lamp thread recharge_lamp();
    
    if ( !e_light.b_absorbed && !e_light.b_hit )
    {
        e_light delete();
    }
}

// Namespace zm_sat_ruby_ee_lights
// Params 5, eflags: 0x4
// Checksum 0x337a3b29, Offset: 0x1694
// Size: 0x16e
function private function_271c810c7ec2ba39( player, e_light, var_6c269b1b35003e9e, v_end, v_start )
{
    if ( level.var_6877527cd881ec30 && var_6c269b1b35003e9e == v_end )
    {
        v_dir = vectornormalize( v_end - v_start );
        b_success = withinfov( v_end, vectortoangles( v_dir ), level.var_6877527cd881ec30.origin, cos( 2 ) );
        
        if ( b_success )
        {
            /#
                iprintlnbold( "<dev string:x2f>" );
            #/
            
            e_light forcenetfieldhighlod( 1 );
            playfxontag( level.var_938002c14e89645f.var_304b6020739ee663, e_light, "tag_origin" );
            
            while ( e_light && level.var_6877527cd881ec30 && player )
            {
                var_b6081b1b6ba5e8b5 = distance( e_light.origin, level.var_6877527cd881ec30.origin );
                
                if ( var_b6081b1b6ba5e8b5 < 50000 )
                {
                    break;
                }
                
                n_move_time = var_b6081b1b6ba5e8b5 / 9999;
                e_light moveto( level.var_6877527cd881ec30.origin, n_move_time );
                wait 0.5;
            }
            
            if ( level.var_6877527cd881ec30 && player )
            {
                level.var_6877527cd881ec30 notify( #"hash_7563563629108fc4", player );
            }
        }
    }
}

// Namespace zm_sat_ruby_ee_lights
// Params 1, eflags: 0x4
// Checksum 0xa996da8a, Offset: 0x180a
// Size: 0x338
function private function_4e7799d557475dd0( e_light )
{
    e_light endon( #"move_done" );
    
    while ( e_light )
    {
        v_light = e_light.origin;
        a_ai = getaiarrayinradius( v_light, 64, level.var_ece703e3d116381c );
        
        if ( a_ai.size )
        {
            a_ai = sortbydistance( a_ai, v_light );
            
            foreach ( ai in a_ai )
            {
                if ( !ai.b_hit_by_light && ( issubstr( ai.subclass, "zombie_base" ) || issubstr( ai.subclass, "zombie_shade" ) ) && ai istouchingpoint( v_light ) )
                {
                    ai thread ai_hit_by_light( e_light );
                    e_light.b_hit = 1;
                    ai_impact = ai;
                    break;
                }
            }
            
            if ( e_light.b_hit )
            {
                e_light notify( #"light_hit" );
                
                if ( level.var_938002c14e89645f.var_852b5e0f670dbc6e != "maxed" )
                {
                    playfx( level.var_938002c14e89645f.fx_blast_attack, e_light.origin );
                    playsoundatpos( e_light.origin, "evt_ruby_ee_light_attack_impact" );
                }
                else
                {
                    playfx( level.var_938002c14e89645f.var_c72b39e141bbad57, e_light.origin );
                    playsoundatpos( e_light.origin, "evt_ruby_ee_upgraded_light_attack_impact" );
                }
                
                a_ai_in_radius = getaiarrayinradius( v_light, level.var_938002c14e89645f.n_attack_radius, level.var_ece703e3d116381c );
                
                foreach ( var_774dd748c02bc2b6 in a_ai_in_radius )
                {
                    if ( var_774dd748c02bc2b6 != ai_impact && ( issubstr( var_774dd748c02bc2b6.subclass, "zombie_base" ) || issubstr( var_774dd748c02bc2b6.subclass, "zombie_shade" ) ) )
                    {
                        waitframe();
                        
                        if ( isalive( var_774dd748c02bc2b6 ) && !var_774dd748c02bc2b6.b_hit_by_light )
                        {
                            var_774dd748c02bc2b6 thread ai_hit_by_light();
                        }
                    }
                }
                
                return;
            }
        }
        
        a_lights = getentitylessscriptablearray( "scriptable_zm_sat_ruby_ee_light", #classname, v_light, 48 );
        
        if ( a_lights.size && a_lights[ 0 ] getscriptablepartstate( "vfx" ) == "off" )
        {
            e_light.b_absorbed = 1;
            a_lights[ 0 ] notify( #"light_hit_lamp", { #e_light:e_light } );
            return;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_ruby_ee_lights
// Params 1, eflags: 0x4
// Checksum 0x8dcfaa4f, Offset: 0x1b4a
// Size: 0xde
function private ai_hit_by_light( e_light )
{
    self.b_hit_by_light = 1;
    
    if ( e_light )
    {
        e_light moveto( self gettagorigin( "j_spine4" ), 0.35 );
        e_light thread utility::delete_after_delay( 0.3 );
    }
    
    self setscriptablepartstate( "simple_dissolve", "fade_out_long", 0 );
    asm::function_d82cb83c9c260d49( 0.2 );
    val::set( "hit_by_light", "ignoreall", 1 );
    val::set( "hit_by_light", "ignoreme", 1 );
    thread zombie_knockdown::function_6fc167d4a3590991( e_light.origin ?? self.origin );
    wait 0.9;
    self function_e8726d980fa12944();
    wait 1;
    
    while ( isalive( self ) )
    {
        self.var_a13bed1ac47e1b2c = 1;
        self invisiblenotsolid();
        self kill( e_light.origin );
        waitframe();
    }
}

/#

    // Namespace zm_sat_ruby_ee_lights
    // Params 1, eflags: 0x4
    // Checksum 0x8bb1c079, Offset: 0x1c30
    // Size: 0x1d8, Type: dev
    function private ee_lights_debug( starter )
    {
        if ( !getdvarint( @"ee_lights_debug", 0 ) )
        {
            return;
        }
        
        wait 3;
        zm_utility::open_sesame();
        v_dest = starter.origin - ( 0, 0, 64 ) + anglestoforward( starter.angles ) * 100;
        level.players[ 0 ] setorigin( getclosestpointonnavmesh( v_dest ) );
        level.players[ 0 ] setplayerangles( ( starter.angles[ 0 ], starter.angles[ 1 ] + 180, starter.angles[ 2 ] ) );
        
        while ( true )
        {
            foreach ( lamp in level.var_938002c14e89645f.a_lamps )
            {
                if ( lamp.var_e12f26713e8411c0 )
                {
                    print3d( lamp.origin, "<dev string:x40>", ( 0, 1, 0 ), 1, 3, 1, 1 );
                    continue;
                }
                
                if ( lamp.b_recharging )
                {
                    print3d( lamp.origin, "<dev string:x42>", ( 1, 1, 0 ), 1, 3, 1, 1 );
                    continue;
                }
                
                print3d( lamp.origin, "<dev string:x44>", ( 1, 0, 0 ), 1, 3, 1, 1 );
            }
            
            waitframe();
        }
    }

#/
