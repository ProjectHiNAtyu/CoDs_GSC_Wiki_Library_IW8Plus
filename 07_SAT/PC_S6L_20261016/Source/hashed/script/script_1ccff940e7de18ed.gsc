// script_1ccff940e7de18ed  (hash_1ccff940e7de18ed.gscc) (size: 12859 Bytes / 0x323b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7f024ff5 (2130857973)
// size ...... 12859 (0x323b)
// includes .. 8   (offset: 0x2f53)
// strings ... 22  (offset: 0x2f93)
// dev strs .. 29  (offset: 0x30db)
// exports ... 32  (offset: 0x1d8f)
// cseg ...... 0x1c1 + 0x1bce (0x1d8f)
// imports ... 103 (offset: 0x228f)
// animtree1 . 0   (offset: 0x323b)
// animtree2 . 0   (offset: 0x323b)
#using script_5cda26b07ee216bf;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_weyward_wipe_attack;

// Namespace zombie_weyward_wipe_attack
// Params 0
// Checksum 0x53b9ad74, Offset: 0x1df
// Size: 0x55
function function_916c9689e28d0a30()
{
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ff65fe290c8aa942 )
    {
        utility::add_fx( "weyward_wipe_attack_beam", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ff65fe290c8aa942 );
    }
    
    /#
        function_1c6e2d548401b22d();
    #/
}

// Namespace zombie_weyward_wipe_attack
// Params 0
// Checksum 0x7469d1b6, Offset: 0x23c
// Size: 0x20b
function init_zombie_weyward_wipe_attack()
{
    self.wipe_attack_active = 0;
    self.var_d415f9cad43b30f5 = undefined;
    self.wipe_attack_beams = [];
    self.var_ce389e75c9c3128e = [];
    self.var_921a9f9435db7175 = 0;
    self.wipe_attack_last_time = undefined;
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.var_b1f9143556f58493 = settings.var_d90afa3c336c2ba4 ?? 4;
    self.var_3972c37151a337aa = [];
    self.var_3972c37151a337aa[ 2 ] = settings.var_44263356b2b6e001 ?? 2;
    self.var_3972c37151a337aa[ 3 ] = settings.var_d110e14e3e42be70 ?? 1;
    self.var_1e5c86d2e292151e = settings.var_5435683afdc2eee7 ?? 25;
    self.var_e854626af2784710 = [ settings.var_276df2aee2881f39 ?? 16, settings.var_2771f8aee28c2242 ?? 14, settings.var_2775feaee290254b ?? 12, settings.var_277b04aee2965b54 ?? 10 ];
    self.wipe_attack_cooldown = settings.var_3e36d53af1192f70 ?? 30;
    self.var_ec1b878fe5d259e8 = settings.var_f30b13f0fd71388e ?? 400;
    self.var_4730f713e84a565c = settings.var_d4620947d3b7ba25;
    self.wipe_attack_enabled = settings.var_8c02a6a68822dac6 ?? 1;
    self.wipe_attack_radius = settings.var_d89983b548328a7b ?? 1600;
    self.var_e72cea66a4c6432f = settings.var_cc741fa78a5742c ?? "orbCenter";
    self.var_b0d31d1be7931099 = [ 3, 3, 4, 4 ];
    self.var_a43f2789f42d2b9b = settings.var_1c7b9b44760bae46 ?? 0;
    thread wipe_attack_monitor();
    thread function_dd1c011b5cf9c1bc();
}

// Namespace zombie_weyward_wipe_attack
// Params 0, eflags: 0x4
// Checksum 0x613265f7, Offset: 0x44f
// Size: 0x1cc
function private wipe_attack_monitor()
{
    self endon( #"death" );
    var_a04ec364ff63db78 = undefined;
    
    while ( true )
    {
        if ( !getdvarint( @"weyward_wipe_attack_enabled", self.wipe_attack_enabled ) )
        {
            waitframe();
            continue;
        }
        
        if ( !zombie_weyward_shadow_soul::function_56db8ae62fa6ec66( 3 ) )
        {
            waitframe();
            continue;
        }
        
        if ( self.wipe_attack_active )
        {
            waitframe();
            continue;
        }
        
        alive_stingers = get_alive_stingers();
        stinger_threshold = function_6a58e857f13bfdc8();
        
        if ( alive_stingers.size >= stinger_threshold )
        {
            alive_time_s = getdvarfloat( @"hash_756491d87ad0b2a0", self.var_1e5c86d2e292151e );
            
            if ( !isdefined( var_a04ec364ff63db78 ) )
            {
                var_a04ec364ff63db78 = gettime();
                
                /#
                    if ( debug_wipe_attack() )
                    {
                        println( "<dev string:x24>" + alive_stingers.size + "<dev string:x43>" + alive_time_s + "<dev string:x59>" );
                    }
                #/
            }
            
            elapsed_ms = gettime() - var_a04ec364ff63db78;
            
            if ( elapsed_ms >= alive_time_s * 1000 )
            {
                cooldown_s = getdvarfloat( @"weyward_wipe_attack_cooldown_s", self.wipe_attack_cooldown );
                
                if ( isdefined( self.wipe_attack_last_time ) && !utility::time_has_passed( self.wipe_attack_last_time, cooldown_s ) )
                {
                    /#
                        if ( debug_wipe_attack() )
                        {
                            println( "<dev string:x61>" + alive_time_s + "<dev string:x71>" + cooldown_s + "<dev string:x89>" );
                        }
                    #/
                    
                    wait 0.5;
                    continue;
                }
                
                /#
                    if ( debug_wipe_attack() )
                    {
                        println( "<dev string:x61>" + alive_time_s + "<dev string:x94>" );
                    }
                #/
                
                var_a04ec364ff63db78 = undefined;
                thread begin_wipe_attack( alive_stingers );
            }
        }
        else
        {
            if ( isdefined( var_a04ec364ff63db78 ) )
            {
                /#
                    if ( debug_wipe_attack() )
                    {
                        println( "<dev string:xb6>" + stinger_threshold + "<dev string:xe2>" );
                    }
                #/
            }
            
            var_a04ec364ff63db78 = undefined;
        }
        
        wait 0.5;
    }
}

// Namespace zombie_weyward_wipe_attack
// Params 0, eflags: 0x4
// Checksum 0x616cd93a, Offset: 0x623
// Size: 0x47
function private function_6a58e857f13bfdc8()
{
    threshold = getdvarint( @"hash_f20987a916375c79", self.var_b1f9143556f58493 );
    
    if ( level.players.size > 1 )
    {
        threshold += function_d7e703523846c08d( zombie_weyward_shadow_soul::get_weyward_phase() );
    }
    
    return threshold;
}

// Namespace zombie_weyward_wipe_attack
// Params 1, eflags: 0x4
// Checksum 0x938959a8, Offset: 0x673
// Size: 0x79
function private function_d7e703523846c08d( phase_num )
{
    mp_increase = 0;
    
    switch ( phase_num )
    {
        case 2:
            mp_increase = self.var_3972c37151a337aa[ 2 ];
            return getdvarint( @"hash_8cdda20c5678b13f", mp_increase );
        case 3:
            mp_increase = self.var_3972c37151a337aa[ 3 ];
            return getdvarint( @"hash_7cc64dc9f5a511b8", mp_increase );
    }
    
    return mp_increase;
}

// Namespace zombie_weyward_wipe_attack
// Params 0, eflags: 0x4
// Checksum 0xe08731ab, Offset: 0x6f5
// Size: 0xb7
function private get_alive_stingers()
{
    alive = [];
    
    if ( !isdefined( self.summon_stingers ) )
    {
        return alive;
    }
    
    foreach ( stinger in self.summon_stingers )
    {
        if ( !isalive( stinger ) )
        {
            continue;
        }
        
        if ( stinger utility::ent_flag( "in_retract" ) )
        {
            continue;
        }
        
        alive[ alive.size ] = stinger;
    }
    
    return alive;
}

// Namespace zombie_weyward_wipe_attack
// Params 0, eflags: 0x4
// Checksum 0x419dfa4a, Offset: 0x7b5
// Size: 0xa4
function private function_399c8387abb64058()
{
    fighting_player_count = 0;
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || player.inlaststand )
        {
            continue;
        }
        
        fighting_player_count++;
    }
    
    return maxint( 1, fighting_player_count );
}

// Namespace zombie_weyward_wipe_attack
// Params 1, eflags: 0x4
// Checksum 0x519a8e41, Offset: 0x862
// Size: 0x249
function private begin_wipe_attack( stingers )
{
    self endon( #"death" );
    
    if ( self.wipe_attack_active )
    {
        return;
    }
    
    self.wipe_attack_active = 1;
    self.var_921a9f9435db7175 = self.var_921a9f9435db7175 ?? 0;
    self.var_921a9f9435db7175++;
    charging_stingers = [];
    
    foreach ( stinger in stingers )
    {
        if ( !isalive( stinger ) )
        {
            continue;
        }
        
        if ( stinger utility::ent_flag( "in_retract" ) )
        {
            continue;
        }
        
        function_879eb2879b114621( stinger );
        charging_stingers[ charging_stingers.size ] = stinger;
    }
    
    self.var_ce389e75c9c3128e = charging_stingers;
    function_af1e689b98691180();
    
    if ( self.var_ce389e75c9c3128e.size < function_6a58e857f13bfdc8() )
    {
        function_80961e8be53938a8();
        self.wipe_attack_active = 0;
        return;
    }
    
    center = function_ba636707f671696d();
    blast_model = function_a20b12cf5f602c5e( center );
    
    if ( !isdefined( blast_model ) )
    {
        function_80961e8be53938a8();
        self.wipe_attack_active = 0;
        return;
    }
    
    self.var_d415f9cad43b30f5 = blast_model;
    thread utility::delete_on_death( blast_model );
    self.wipe_attack_beams = [];
    
    if ( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ff65fe290c8aa942 ) )
    {
        foreach ( stinger in self.var_ce389e75c9c3128e )
        {
            function_ffaa9296b7ae3c84( stinger, center );
        }
    }
    
    /#
        if ( debug_wipe_attack() )
        {
            println( "<dev string:xf0>" + self.var_ce389e75c9c3128e.size + "<dev string:x11a>" + center );
        }
    #/
    
    function_f0c5d6ad347ca287( blast_model );
}

// Namespace zombie_weyward_wipe_attack
// Params 0, eflags: 0x4
// Checksum 0x3baad389, Offset: 0xab3
// Size: 0xb2
function private function_af1e689b98691180()
{
    if ( !isdefined( self.summon_stingers ) )
    {
        return;
    }
    
    foreach ( stinger in self.summon_stingers )
    {
        if ( !isalive( stinger ) || !stinger utility::ent_flag( "in_retract" ) )
        {
            continue;
        }
        
        thread function_f2d24f71b94f0082( stinger, self.var_921a9f9435db7175 );
    }
}

// Namespace zombie_weyward_wipe_attack
// Params 1, eflags: 0x4
// Checksum 0x32329d41, Offset: 0xb6d
// Size: 0x35
function private function_879eb2879b114621( stinger )
{
    stinger function_786bb6aa1b76c7ee( "in_wipe_attack_charge", 1 );
    stinger asm::function_7256f5ba459c840b( "wipe_attack_in" );
    stinger notify( #"wipe_attack_begin" );
}

// Namespace zombie_weyward_wipe_attack
// Params 2, eflags: 0x4
// Checksum 0x53878cdc, Offset: 0xbaa
// Size: 0x13b
function private function_ffaa9296b7ae3c84( stinger, center )
{
    if ( !isalive( stinger ) || !isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ff65fe290c8aa942 ) || !isdefined( self.var_d415f9cad43b30f5 ) )
    {
        return;
    }
    
    if ( stinger tagexists( "j_tail_11" ) )
    {
        str_beam_tag = "j_tail_11";
    }
    else if ( stinger tagexists( "j_head" ) )
    {
        str_beam_tag = "j_head";
    }
    else
    {
        str_beam_tag = "tag_origin";
    }
    
    stinger utility::function_7c10ea82c1e305b8( "wipe_attack", "on" );
    
    if ( !isdefined( stinger.wipe_attack_beam ) )
    {
        stinger.wipe_attack_beam = playfxontagsbetweenclients( utility::getfx( "weyward_wipe_attack_beam" ), stinger, str_beam_tag, self.var_d415f9cad43b30f5, "tag_origin" );
    }
    
    if ( isdefined( stinger.wipe_attack_beam ) )
    {
        self.wipe_attack_beams = arraycombineunique( self.wipe_attack_beams, [ stinger.wipe_attack_beam ] );
        stinger thread utility::delete_on_death( stinger.wipe_attack_beam );
    }
    
    if ( isdefined( center ) )
    {
        stinger thread function_681068c3052504d7( center );
    }
}

// Namespace zombie_weyward_wipe_attack
// Params 2, eflags: 0x4
// Checksum 0xf71a1bb8, Offset: 0xced
// Size: 0x103
function private function_f2d24f71b94f0082( stinger, generation )
{
    self endon( #"death" );
    stinger endon( #"death" );
    
    while ( isalive( stinger ) && stinger utility::ent_flag( "in_retract" ) )
    {
        waitframe();
    }
    
    if ( !isalive( stinger ) || !self.wipe_attack_active || self.var_921a9f9435db7175 != generation )
    {
        return;
    }
    
    function_879eb2879b114621( stinger );
    self.var_ce389e75c9c3128e[ self.var_ce389e75c9c3128e.size ] = stinger;
    
    if ( !stinger callback::exists( #"on_ai_killed", &function_6a74ab0dbed72cd1 ) )
    {
        stinger callback::add( #"on_ai_killed", &function_6a74ab0dbed72cd1 );
    }
    
    function_ffaa9296b7ae3c84( stinger, self.var_d415f9cad43b30f5.origin );
    
    /#
        if ( debug_wipe_attack() )
        {
            println( "<dev string:x12f>" + self.var_ce389e75c9c3128e.size );
        }
    #/
}

// Namespace zombie_weyward_wipe_attack
// Params 1, eflags: 0x4
// Checksum 0x9d16a3ab, Offset: 0xdf8
// Size: 0xd6
function private function_681068c3052504d7( center )
{
    self.var_7f9449fb06dd18be = utility::spawn_tag_origin( self.origin, self.angles );
    thread utility::delete_on_death( self.var_7f9449fb06dd18be );
    self linktoblendtotag( self.var_7f9449fb06dd18be );
    yaw = vectortoyaw( center - self.var_7f9449fb06dd18be.origin );
    v_rotate_to_angles = ( self.angles[ 0 ], yaw, 0 );
    self.var_7f9449fb06dd18be rotateto( v_rotate_to_angles, 0.75 );
    self.var_7f9449fb06dd18be waittill( #"rotatedone" );
    wait 0.5;
    
    if ( isdefined( self.var_7f9449fb06dd18be ) )
    {
        self.var_7f9449fb06dd18be delete();
    }
}

// Namespace zombie_weyward_wipe_attack
// Params 1, eflags: 0x4
// Checksum 0x2fcdbd, Offset: 0xed6
// Size: 0x6e
function private function_6a74ab0dbed72cd1( params )
{
    if ( isplayer( params.eattacker ) && isalive( self.stinger_owner ) )
    {
        if ( !isdefined( self.stinger_owner.var_e17da394fb97ae2e ) )
        {
            self.stinger_owner.var_e17da394fb97ae2e = 0;
        }
        
        self.stinger_owner.var_e17da394fb97ae2e++;
    }
}

// Namespace zombie_weyward_wipe_attack
// Params 1, eflags: 0x4
// Checksum 0xf26c46a3, Offset: 0xf4c
// Size: 0x74
function private function_904477a7829b6a06( params )
{
    if ( self.subclass == "zombie_weyward_stinger" )
    {
        self endon( #"death" );
        waitframe();
        callback::add( #"on_ai_killed", &function_6a74ab0dbed72cd1 );
        
        if ( isalive( self.stinger_owner ) )
        {
            self.stinger_owner thread function_f2d24f71b94f0082( self, self.stinger_owner.var_921a9f9435db7175 );
        }
    }
}

// Namespace zombie_weyward_wipe_attack
// Params 1, eflags: 0x4
// Checksum 0xde7258e6, Offset: 0xfc8
// Size: 0x27d
function private function_f0c5d6ad347ca287( blast_model )
{
    self endon( #"death" );
    player_count = function_399c8387abb64058();
    charge_time_s = getdvarfloat( @"hash_767463a2040d04f1", self.var_e854626af2784710[ int( clamp( player_count - 1, 0, 3 ) ) ] );
    var_913181f063c20d51 = gettime();
    charge_end = var_913181f063c20d51 + charge_time_s * 1000;
    self.var_ce389e75c9c3128e = function_46f9072493651dc9( self.var_ce389e75c9c3128e );
    self.var_e17da394fb97ae2e = 0;
    
    foreach ( stinger in self.var_ce389e75c9c3128e )
    {
        if ( !stinger callback::exists( #"on_ai_killed", &function_6a74ab0dbed72cd1 ) )
        {
            stinger callback::add( #"on_ai_killed", &function_6a74ab0dbed72cd1 );
        }
    }
    
    if ( !level callback::exists( "on_zombie_ai_spawned", &function_904477a7829b6a06 ) )
    {
        level callback::add( "on_zombie_ai_spawned", &function_904477a7829b6a06 );
    }
    
    var_4b32bd4360f173cf = minint( self.var_b0d31d1be7931099[ int( clamp( player_count - 1, 0, 3 ) ) ], self.var_ce389e75c9c3128e.size );
    
    while ( gettime() < charge_end )
    {
        self.var_ce389e75c9c3128e = function_46f9072493651dc9( self.var_ce389e75c9c3128e );
        
        if ( self.var_e17da394fb97ae2e >= var_4b32bd4360f173cf || self.var_ce389e75c9c3128e.size == 0 || utility::flag( "playing_game_over_scene" ) )
        {
            /#
                if ( debug_wipe_attack() )
                {
                    println( "<dev string:x182>" );
                }
            #/
            
            wipe_attack_fail( blast_model );
            return;
        }
        
        /#
            if ( debug_wipe_attack() )
            {
                remaining = ( charge_end - gettime() ) / 1000;
                print3d( blast_model.origin + ( 0, 0, 30 ), "<dev string:x1b6>" + int( remaining ) + "<dev string:x1c1>", ( 1, 0.5, 0 ), 1, 1.5 );
                function_b08f8b8b091d8991();
            }
        #/
        
        waitframe();
    }
    
    wipe_attack_succeed( blast_model );
}

// Namespace zombie_weyward_wipe_attack
// Params 1, eflags: 0x4
// Checksum 0x21b90b97, Offset: 0x124d
// Size: 0x1be
function private wipe_attack_succeed( blast_model )
{
    /#
        if ( debug_wipe_attack() )
        {
            println( "<dev string:x1c3>" );
        }
    #/
    
    var_42e3770e978a4e7f = function_8258e4f2c85ac29b();
    self.ignore_turtle_shell = 1;
    self.var_a7339c2c551e2788 = 1;
    
    foreach ( player in var_42e3770e978a4e7f )
    {
        if ( isdefined( self.var_4730f713e84a565c ) )
        {
            pbgpostfxbundlestart( player, self.var_4730f713e84a565c );
            player thread function_dc66f05ce5d3dafc( self.var_4730f713e84a565c, 1 );
        }
        
        if ( self.var_a43f2789f42d2b9b )
        {
            player dodamage( getdvarint( @"weyward_wipe_attack_damage", 450 ), blast_model.origin, self, self, "MOD_EXPLOSIVE", undefined, "torso_upper" );
            continue;
        }
        
        player val::set( "weyward_wipe_attack", "bypass_saving_throws", 1 );
        player dodamage( player.health + 9999, self.origin, self, self, "MOD_UNKNOWN", undefined, "torso_upper" );
        player val::reset( "weyward_wipe_attack", "bypass_saving_throws" );
    }
    
    if ( !self.var_a43f2789f42d2b9b )
    {
        self.ignore_turtle_shell = undefined;
        self.var_a7339c2c551e2788 = undefined;
    }
    
    function_6038b95b7d12359a( blast_model, 1 );
    function_80961e8be53938a8();
    self.wipe_attack_active = 0;
    self.wipe_attack_last_time = gettime();
}

// Namespace zombie_weyward_wipe_attack
// Params 2, eflags: 0x4
// Checksum 0xbd9f12b5, Offset: 0x1413
// Size: 0x2c
function private function_dc66f05ce5d3dafc( var_51cf687c0934f7b3, delay_s )
{
    self endon( #"disconnect" );
    wait delay_s;
    pbgpostfxbundleend( self, var_51cf687c0934f7b3 );
}

// Namespace zombie_weyward_wipe_attack
// Params 1, eflags: 0x4
// Checksum 0x88ea38ce, Offset: 0x1447
// Size: 0x49
function private wipe_attack_fail( blast_model )
{
    /#
        if ( debug_wipe_attack() )
        {
            println( "<dev string:x1f6>" );
        }
    #/
    
    function_6038b95b7d12359a( blast_model );
    function_80961e8be53938a8();
    self.wipe_attack_active = 0;
    self.wipe_attack_last_time = gettime();
}

// Namespace zombie_weyward_wipe_attack
// Params 0, eflags: 0x4
// Checksum 0x3614003c, Offset: 0x1498
// Size: 0x109
function private function_80961e8be53938a8()
{
    level callback::remove( "on_zombie_ai_spawned", &function_904477a7829b6a06 );
    
    foreach ( stinger in self.var_ce389e75c9c3128e )
    {
        if ( isalive( stinger ) )
        {
            stinger function_786bb6aa1b76c7ee( "in_wipe_attack_charge", 0 );
            stinger utility::function_7c10ea82c1e305b8( "wipe_attack", "off" );
            
            if ( stinger callback::exists( #"on_ai_killed", &function_6a74ab0dbed72cd1 ) )
            {
                stinger callback::remove( #"on_ai_killed", &function_6a74ab0dbed72cd1 );
            }
            
            if ( isent( stinger.var_7f9449fb06dd18be ) )
            {
                stinger.var_7f9449fb06dd18be delete();
            }
        }
    }
    
    self.var_ce389e75c9c3128e = [];
}

// Namespace zombie_weyward_wipe_attack
// Params 2, eflags: 0x4
// Checksum 0x9983b18f, Offset: 0x15a9
// Size: 0xe2
function private function_6038b95b7d12359a( blast_model, success = 0 )
{
    foreach ( beam in self.wipe_attack_beams )
    {
        if ( isdefined( beam ) )
        {
            beam delete();
        }
    }
    
    self.wipe_attack_beams = [];
    
    if ( isdefined( blast_model ) )
    {
        blast_model utility::function_7c10ea82c1e305b8( "base", success ? "success" : "fail" );
        blast_model thread utility::delete_after_delay( 1 );
    }
    
    self.var_d415f9cad43b30f5 = undefined;
}

// Namespace zombie_weyward_wipe_attack
// Params 0, eflags: 0x4
// Checksum 0xf4d067ab, Offset: 0x1693
// Size: 0xeb
function private function_ba636707f671696d()
{
    sum = ( 0, 0, 0 );
    count = 0;
    
    foreach ( stinger in self.var_ce389e75c9c3128e )
    {
        if ( isalive( stinger ) )
        {
            sum += stinger.origin;
            count++;
        }
    }
    
    if ( count == 0 )
    {
        return ( self.origin + ( 0, 0, self.var_ec1b878fe5d259e8 ) );
    }
    
    center = sum / count;
    return center + ( 0, 0, self.var_ec1b878fe5d259e8 );
}

// Namespace zombie_weyward_wipe_attack
// Params 1, eflags: 0x4
// Checksum 0xf22a5a77, Offset: 0x1787
// Size: 0x68
function private function_a20b12cf5f602c5e( position )
{
    charge_model = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_dc43297bcd6affee;
    
    if ( !isdefined( charge_model ) )
    {
        /#
            if ( debug_wipe_attack() )
            {
                println( "<dev string:x219>" );
            }
        #/
        
        return;
    }
    
    var_421cc465f5b58128 = utility::spawn_model( charge_model, position );
    return var_421cc465f5b58128;
}

// Namespace zombie_weyward_wipe_attack
// Params 0, eflags: 0x4
// Checksum 0x5bbc63b0, Offset: 0x17f8
// Size: 0xbb
function private function_dd1c011b5cf9c1bc()
{
    self waittill( #"death" );
    
    if ( self.wipe_attack_active )
    {
        function_6038b95b7d12359a( self.var_d415f9cad43b30f5 );
        
        foreach ( stinger in self.summon_stingers )
        {
            if ( isalive( stinger ) )
            {
                stinger function_786bb6aa1b76c7ee( "in_wipe_attack_charge", 0 );
            }
        }
    }
    
    self.wipe_attack_active = 0;
}

// Namespace zombie_weyward_wipe_attack
// Params 0, eflags: 0x4
// Checksum 0xdd9229ee, Offset: 0x18bb
// Size: 0x13b
function private function_8258e4f2c85ac29b()
{
    a_player_targets = [];
    n_radius = getdvarfloat( @"weyward_wipe_attack_radius", self.wipe_attack_radius );
    v_attack_origin = get_wipe_attack_center();
    var_f8b2442149946a6b = getplayersinradius( v_attack_origin, n_radius );
    a_ignore_ents = getplayersandaiarrayinradius( v_attack_origin, n_radius );
    
    foreach ( player in var_f8b2442149946a6b )
    {
        if ( !isalive( player ) )
        {
            continue;
        }
        
        if ( player.inlaststand )
        {
            continue;
        }
        
        if ( player.oubliette.var_c858d5cbff6ce7a )
        {
            continue;
        }
        
        v_start = v_attack_origin;
        v_end = player geteye();
        
        if ( trace::ray_trace_passed( v_start, v_end, a_ignore_ents, trace::create_default_contents( 1 ) ) )
        {
            a_player_targets[ a_player_targets.size ] = player;
        }
    }
    
    return a_player_targets;
}

// Namespace zombie_weyward_wipe_attack
// Params 0, eflags: 0x4
// Checksum 0x233b8fa6, Offset: 0x19ff
// Size: 0x74
function private get_wipe_attack_center()
{
    if ( getdvar( @"weyward_wipe_attack_center", self.var_e72cea66a4c6432f ) == "orbCenter" )
    {
        v_attack_origin = self.var_d415f9cad43b30f5.origin;
    }
    else
    {
        v_attack_origin = self.var_87babd99816390fb.origin;
    }
    
    if ( !isdefined( v_attack_origin ) )
    {
        v_attack_origin = self.var_d415f9cad43b30f5.origin;
    }
    
    return v_attack_origin;
}

/#

    // Namespace zombie_weyward_wipe_attack
    // Params 0, eflags: 0x4
    // Checksum 0x8a2a88e2, Offset: 0x1a7c
    // Size: 0x44, Type: dev
    function private function_1c6e2d548401b22d()
    {
        devgui::function_9082edeb5db93280( "<dev string:x253>" );
        devgui::add_devgui_func( "<dev string:x278>", "<dev string:x28a>", &force_wipe_attack );
        devgui::add_devgui_func( "<dev string:x2a4>", "<dev string:x2b6>", &function_51effac32085d0f9 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_weyward_wipe_attack
    // Params 1, eflags: 0x4
    // Checksum 0x303ae7b6, Offset: 0x1ac8
    // Size: 0x10c, Type: dev
    function private force_wipe_attack( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x2d7>" );
        
        if ( isdefined( weyward ) )
        {
            alive_stingers = [];
            
            foreach ( stinger in weyward.summon_stingers )
            {
                if ( isalive( stinger ) )
                {
                    alive_stingers[ alive_stingers.size ] = stinger;
                }
            }
            
            stinger_threshold = weyward function_6a58e857f13bfdc8();
            
            if ( alive_stingers.size >= stinger_threshold )
            {
                weyward thread begin_wipe_attack( alive_stingers );
                return;
            }
            
            println( "<dev string:x2e6>" + stinger_threshold + "<dev string:x304>" + alive_stingers.size );
        }
    }

    // Namespace zombie_weyward_wipe_attack
    // Params 1, eflags: 0x4
    // Checksum 0x290854ce, Offset: 0x1bdc
    // Size: 0x24, Type: dev
    function private function_51effac32085d0f9( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x31c>", @"weyward_wipe_attack_debug" );
    }

    // Namespace zombie_weyward_wipe_attack
    // Params 1, eflags: 0x4
    // Checksum 0x69848d56, Offset: 0x1c08
    // Size: 0x169, Type: dev
    function private function_b08f8b8b091d8991( n_debug_frame_duration )
    {
        if ( !isdefined( n_debug_frame_duration ) )
        {
            n_debug_frame_duration = 1;
        }
        
        var_18c7fcc80e290e8a = get_wipe_attack_center();
        
        if ( isdefined( var_18c7fcc80e290e8a ) )
        {
            sphere( var_18c7fcc80e290e8a, getdvarfloat( @"weyward_wipe_attack_radius", self.wipe_attack_radius ), ( 1, 0, 0 ), undefined, int( n_debug_frame_duration ) );
            var_42e3770e978a4e7f = function_8258e4f2c85ac29b();
            
            foreach ( index, player in level.players )
            {
                if ( arraycontains( var_42e3770e978a4e7f, player ) )
                {
                    var_c9e35826ee79c05c = ( 1, 0, 0 );
                }
                else
                {
                    var_c9e35826ee79c05c = ( 0, 1, 0 );
                }
                
                line( var_18c7fcc80e290e8a, player geteye(), var_c9e35826ee79c05c, undefined, n_debug_frame_duration );
                print3d( var_18c7fcc80e290e8a + ( 0, 0, index * -10 ), "<dev string:x336>" + ( player.name ?? player getentitynumber() ) + "<dev string:x343>" + distance( var_18c7fcc80e290e8a, player geteye() ), var_c9e35826ee79c05c, 1, n_debug_frame_duration );
            }
        }
    }

    // Namespace zombie_weyward_wipe_attack
    // Params 0, eflags: 0x4
    // Checksum 0xa0a29c10, Offset: 0x1d79
    // Size: 0x16, Type: dev
    function private debug_wipe_attack()
    {
        return getdvarint( @"weyward_wipe_attack_debug", 0 ) > 0;
    }

#/
