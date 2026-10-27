// script_5cda26b07ee216bf  (hash_5cda26b07ee216bf.gscc) (size: 20292 Bytes / 0x4f44 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1e153ff8 (504709112)
// size ...... 20292 (0x4f44)
// includes .. 10  (offset: 0x4a34)
// strings ... 55  (offset: 0x4a84)
// dev strs .. 25  (offset: 0x4e0c)
// exports ... 41  (offset: 0x3248)
// cseg ...... 0x472 + 0x2dd6 (0x3248)
// imports ... 136 (offset: 0x38b0)
// animtree1 . 0   (offset: 0x4f44)
// animtree2 . 0   (offset: 0x4f44)
#using script_14f857806c1ea0cc;
#using script_16ea1b94f0f381b3;
#using script_640b69521097c6a5;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_weyward_shadow_soul;

// Namespace zombie_weyward_shadow_soul
// Params 0
// Checksum 0xe5e78441, Offset: 0x490
// Size: 0x67
function function_f7d097c7de4febee()
{
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_709229aacf05d8ee )
    {
        utility::add_fx( "weyward_shadow_soul_beam", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_709229aacf05d8ee );
    }
    
    level callback::add( "weyward_restore_from_fake_death", &function_97402d7714fcc71a );
    
    /#
        function_ff9c5d5d0784a2cf();
    #/
}

// Namespace zombie_weyward_shadow_soul
// Params 0
// Checksum 0x1d0ac6b9, Offset: 0x4ff
// Size: 0x2d6
function init_zombie_weyward_shadow_soul()
{
    self.shadow_souls = [];
    self.shadow_soul_phase = 1;
    self.shadow_soul_shield_active = 0;
    self.shadow_soul_immune = 0;
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.var_aebba24aed9f1efd[ 0 ] = 1;
    self.var_aebba24aed9f1efd[ 1 ] = settings.var_50c062396096fbdd ?? 0.7;
    self.var_aebba24aed9f1efd[ 2 ] = settings.var_d22cee76da733bf8 ?? 0.33;
    self.var_aebba24aed9f1efd[ 3 ] = 0;
    self.var_5520d84e885bb982 = [ self.var_aebba24aed9f1efd[ 1 ], settings.var_2d655911ca393531 ?? 0.7, settings.var_fa516c2886bddd90 ?? 0.73, settings.var_61ff9ef1eea9764b ?? 0.75 ];
    thread function_9025ab7ef19a4be2();
    self.var_43d521bf94f61a76 = settings.var_c0218a0f3fc066f9 ?? 4;
    self.var_39ac8b5da987a635 = settings.var_c11e71aa14c04634 ?? 7;
    self.var_984fb0f3aeafa472 = [ 0, settings.var_c5bcaef5000a297c ?? 2, settings.var_4030c92494c8babd ?? 3, settings.var_2f6b96a83d64ef7e ?? 4 ];
    self.var_a82b9f0426b9c88f = [ 0, settings.var_8da95fb0dd321cab ?? 2, settings.var_4dff786b8f6b831a ?? 3, settings.var_dafe00a6d4b1f91 ?? 4 ];
    self.shadow_soul_fly_height = settings.var_d04abf288f4997dd ?? 200;
    self.var_642b369dca4060ed = settings.var_83681bde024ce7e0 ?? 60;
    self.shadow_soul_radius = settings.var_6ac93ea025b53b1f ?? 110;
    self.shadow_soul_fly_speed = settings.var_20dddd15bbdf6249 ?? 300;
    self.var_52d1141310b97f2 = settings.var_2acdf1ce3b349027 ?? 5;
    self.shadow_soul_immune_duration = settings.var_40578de1d1a6e500 ?? 20;
    self.shadow_soul_teleport_range = settings.var_32a3e56a5edb9067 ?? 2000;
    self.var_92d7a886edd44579 = settings.var_a0013bbd446a65b7 ?? 0.15;
    self.var_b132e4221924c798 = settings.var_348d74ab7126be91 ?? 0.75;
    self.shadow_soul_enabled = settings.var_cdcdc60c60db2ea ?? 1;
}

// Namespace zombie_weyward_shadow_soul
// Params 1, eflags: 0x4
// Checksum 0x41a98e13, Offset: 0x7dd
// Size: 0x15f
function private function_97402d7714fcc71a( params )
{
    self endon( #"death" );
    function_3164cfc53fa7ba78();
    count = getdvarint( @"hash_a549f0be27bb52ef", self.var_39ac8b5da987a635 );
    count += self.var_a82b9f0426b9c88f[ int( clamp( level.players.size - 1, 0, 3 ) ) ];
    positions = function_5cd8381640522f9c( count );
    
    for ( i = 0; i < count ; i++ )
    {
        spawn_shadow_soul( positions[ i ] );
    }
    
    function_a3c1cf14ebcc3e46();
    function_3164cfc53fa7ba78();
    function_de92f052633c1fa1();
    wait 1;
    
    foreach ( var_76ff015046c9aa1 in self.shadow_souls )
    {
        if ( isalive( var_76ff015046c9aa1 ) )
        {
            thread function_688679a6a88e6c01( var_76ff015046c9aa1 );
        }
    }
    
    self.shadow_soul_shield_active = 1;
    utility::function_7c10ea82c1e305b8( "shadow_soul_shield", "on" );
    zombie_weyward_skull::function_3321fee4b8702a40();
    thread shadow_soul_shield_monitor();
}

// Namespace zombie_weyward_shadow_soul
// Params 0
// Checksum 0x4e466254, Offset: 0x944
// Size: 0xb
function get_weyward_phase()
{
    return self.shadow_soul_phase;
}

// Namespace zombie_weyward_shadow_soul
// Params 1
// Checksum 0x93c0d7a7, Offset: 0x958
// Size: 0x18, Type: bool
function function_56db8ae62fa6ec66( min_phase )
{
    return self.shadow_soul_phase >= min_phase;
}

// Namespace zombie_weyward_shadow_soul
// Params 1
// Checksum 0x75ea7aee, Offset: 0x979
// Size: 0x33
function set_weyward_phase( new_phase )
{
    if ( self.shadow_soul_phase == new_phase )
    {
        return;
    }
    
    self.shadow_soul_phase = new_phase;
    callback::callback( "new_weyward_phase" );
}

// Namespace zombie_weyward_shadow_soul
// Params 1
// Checksum 0x542153d5, Offset: 0x9b4
// Size: 0x91
function function_2d0e28a49756190e( damage )
{
    if ( self.shadow_soul_phase >= 3 )
    {
        return damage;
    }
    
    health_threshold_ratio = self.var_aebba24aed9f1efd[ self.shadow_soul_phase ];
    var_eab9d49b6c271d50 = ( self.health - damage ) / self.maxhealth;
    
    if ( !isdefined( health_threshold_ratio ) )
    {
        return damage;
    }
    
    if ( var_eab9d49b6c271d50 <= health_threshold_ratio )
    {
        return int( max( self.health - health_threshold_ratio * self.maxhealth, 1 ) );
    }
    
    return damage;
}

// Namespace zombie_weyward_shadow_soul
// Params 1
// Checksum 0x6d3c0471, Offset: 0xa4e
// Size: 0x1c3
function function_f4eba3e3630cd623( damage )
{
    if ( !getdvarint( @"hash_171aed2fbc655bb0", self.shadow_soul_enabled ) )
    {
        return;
    }
    
    if ( self.shadow_soul_phase >= 3 )
    {
        return;
    }
    
    if ( utility::ent_flag( "in_soul_phase_transition" ) )
    {
        return;
    }
    
    health_threshold_ratio = self.shadow_soul_phase == 1 ? max( self.var_5520d84e885bb982[ int( clamp( level.players.size - 1, 0, 3 ) ) ], self.var_aebba24aed9f1efd[ self.shadow_soul_phase ] ) : self.var_aebba24aed9f1efd[ self.shadow_soul_phase ];
    var_eab9d49b6c271d50 = ( self.health - damage ) / self.maxhealth;
    
    if ( !isdefined( health_threshold_ratio ) )
    {
        return;
    }
    
    if ( var_eab9d49b6c271d50 <= health_threshold_ratio )
    {
        var_edc0adb3171d2afb = utility::ent_flag( "in_dash" ) || self getaiblackboarddynamic( "in_immune" ) || self getaiblackboarddynamic( "in_move_turn" );
        
        if ( var_edc0adb3171d2afb )
        {
            return;
        }
        
        utility::ent_flag_set( "in_soul_phase_transition" );
        
        if ( self.shadow_soul_phase == 1 )
        {
            count = getdvarint( @"hash_de9472aada9eaa10", self.var_43d521bf94f61a76 );
            count += self.var_984fb0f3aeafa472[ int( clamp( level.players.size - 1, 0, 3 ) ) ];
        }
        else
        {
            count = getdvarint( @"hash_a549f0be27bb52ef", self.var_39ac8b5da987a635 );
            count += self.var_a82b9f0426b9c88f[ int( clamp( level.players.size - 1, 0, 3 ) ) ];
        }
        
        thread begin_shadow_soul_summon( count );
    }
}

// Namespace zombie_weyward_shadow_soul
// Params 1
// Checksum 0x47cf89c8, Offset: 0xc19
// Size: 0x17
function function_466c457115afa0e2( point )
{
    self.var_87babd99816390fb = point;
}

// Namespace zombie_weyward_shadow_soul
// Params 2
// Checksum 0x61dc8b44, Offset: 0xc38
// Size: 0x7ee
function begin_shadow_soul_summon( count, var_84e2dfa8660cffd7 = 0 )
{
    self endon( #"death" );
    self endon( #"begin_fake_death" );
    self endon( #"begin_real_death" );
    level endon( #"playing_game_over_scene" );
    
    if ( isai( self ) )
    {
        self notify( #"music_immune_started" );
        
        foreach ( player in level.players )
        {
            player thread zombie_boss_healthbar::zombie_boss_healthbar_immune( 1 );
        }
        
        self.shadow_soul_immune = 1;
        self function_786bb6aa1b76c7ee( "shadow_soul_immune", 1 );
        val::set( "shadow_soul_summon", "special_pain", 0 );
        thread function_f71fddf19c6ab63e();
        
        if ( self.shadow_soul_phase == 1 )
        {
            utility::flag_set( "scarab_powerup_firefly_activate" );
        }
        else if ( self.shadow_soul_phase == 2 )
        {
            utility::flag_set( "scarab_powerup_ruby_activate" );
        }
    }
    else
    {
        self.shadow_soul_immune = 1;
    }
    
    positions = function_5cd8381640522f9c( count );
    
    if ( isai( self ) )
    {
        animindex = asm::asm_lookupanimfromalias( "animscripted", "teleport" );
        xanim = asm::asm_getxanim( "animscripted", animindex );
        var_24d1165d77669ed3 = getanimlength( xanim );
        animindex = asm::asm_lookupanimfromalias( "shadow_soul_summon", "0" );
        xanim = asm::asm_getxanim( "shadow_soul_summon", animindex );
        var_9d2365afc15dedef = getanimlength( xanim );
        var_ac58030da4448abb = 1;
        
        if ( getdvarint( @"hash_8c0a90d834d8014a", 0 ) )
        {
            /#
                if ( getdvarint( @"hash_98f8e4d931159c0f", 0 ) )
                {
                    zombie_weyward_asm::function_f8aee546f5ed4cfb( "<dev string:x24>", "<dev string:x53>" );
                }
            #/
            
            asm::function_7256f5ba459c840b( "shadow_soul_summon" );
            var_861eaddc09c62ddc = 0.3;
            var_ec03487ee54d543e = var_9d2365afc15dedef - var_861eaddc09c62ddc;
        }
        else
        {
            thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "teleport", "teleport" );
            var_685ba178f1e87118 = 0.7;
            var_861eaddc09c62ddc = 0.25;
            var_ec03487ee54d543e = var_24d1165d77669ed3 - var_861eaddc09c62ddc - var_685ba178f1e87118;
            wait var_685ba178f1e87118;
        }
    }
    
    thread function_cec8a30a9e5a21a9( count, positions, var_84e2dfa8660cffd7, var_ac58030da4448abb, var_ec03487ee54d543e );
    utility::waittill_notify_or_timeout( "shadow_souls_spawned_and_arrived", 20 );
    
    if ( isai( self ) )
    {
    }
    else
    {
        settle_time = getdvarfloat( @"hash_165a028328a05c40", self.var_52d1141310b97f2 );
        wait settle_time;
    }
    
    utility::function_7c10ea82c1e305b8( "portal", "on" );
    
    if ( isdefined( var_861eaddc09c62ddc ) )
    {
        wait var_861eaddc09c62ddc;
    }
    else
    {
        wait 2;
    }
    
    if ( isai( self ) )
    {
        self clearpath();
        var_f4fb26ca919a4e7e = self.origin;
        callback::callback( "weyward_enter_immune_phase", {} );
        playworldsound( var_f4fb26ca919a4e7e, #"hash_11d23dfeee0d77bc" );
        immune_pos_struct = utility::array_random( utility::getstructarray( "weyward_immune_pos", "script_noteworthy" ) );
        
        if ( isdefined( immune_pos_struct ) )
        {
            self forceteleport( immune_pos_struct.origin, immune_pos_struct.angles );
        }
        else
        {
            self forceteleport( self.origin + ( 0, 0, 2000 ), self.angles );
        }
        
        function_681a1f043e1b7ab3( 0 );
        function_228f2c79c68827dd();
        waitframe();
        
        /#
            if ( getdvarint( @"hash_98f8e4d931159c0f", 0 ) )
            {
                zombie_weyward_asm::function_f8aee546f5ed4cfb( "<dev string:x24>", "<dev string:x66>" );
            }
        #/
        
        asm::function_7256f5ba459c840b( "immune_in" );
        playworldsound( self.origin, #"hash_51de8bb8c9be8e97" );
        
        if ( self.shadow_soul_phase == 2 )
        {
            thread begin_oubliette();
        }
    }
    
    utility::delaythreadendon( 0.5, "death", &utility::function_7c10ea82c1e305b8, "portal", "off" );
    function_de92f052633c1fa1();
    
    if ( isai( self ) )
    {
        self notify( #"hash_b467aaddf42d31aa" );
        self notify( #"entity_drain_immune" );
        immune_duration = getdvarfloat( @"hash_10886013c37e67df", self.shadow_soul_immune_duration );
        wait max( immune_duration - 2, 0 );
        self function_786bb6aa1b76c7ee( "in_immune", 1 );
        self function_f2df0257c63f229( "shadow_soul_immune" );
        wait 2.5;
        self notify( #"drain_beam_effect_end" );
        utility::function_7c10ea82c1e305b8( "drain_fx", "off" );
        thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "teleport", "teleport", self.origin, self.angles );
        utility::function_7c10ea82c1e305b8( "portal", "on" );
        wait 2;
        playworldsound( self.origin, #"hash_11d23dfeee0d77bc" );
        
        foreach ( player in level.players )
        {
            player thread zombie_boss_healthbar::zombie_boss_healthbar_immune( 0 );
        }
        
        self.last_charge_time = gettime() - utility::function_4b74c15943231980( self.charge_cooldown_s ) * 0.85;
        self.shadow_soul_immune = 0;
        self function_786bb6aa1b76c7ee( "in_immune", 0 );
        utility::delaythreadendon( 0.5, "death", &utility::function_7c10ea82c1e305b8, "portal", "off" );
        self forceteleport( var_f4fb26ca919a4e7e, self.angles );
        waitframe();
        self clearpath();
        self clearbtgoal( 0 );
        self clearbtgoal( 4 );
        playworldsound( var_f4fb26ca919a4e7e, #"hash_11d23dfeee0d77bc" );
        function_228f2c79c68827dd();
        set_weyward_phase( self.shadow_soul_phase + 1 );
        utility::ent_flag_clear( "in_soul_phase_transition" );
        val::reset( "shadow_soul_summon", "special_pain" );
        
        if ( self.shadow_soul_phase == 2 )
        {
            utility::flag_set( "scarab_powerup_locust_activate" );
            self notify( #"phase_2_return" );
        }
        else if ( self.shadow_soul_phase == 3 )
        {
            self notify( #"phase_3_return" );
        }
    }
    else
    {
        self.shadow_soul_immune = 0;
    }
    
    function_3164cfc53fa7ba78();
    
    foreach ( var_76ff015046c9aa1 in self.shadow_souls )
    {
        if ( isalive( var_76ff015046c9aa1 ) && var_76ff015046c9aa1.shadow_soul_teleported )
        {
            thread function_688679a6a88e6c01( var_76ff015046c9aa1 );
        }
    }
    
    function_3164cfc53fa7ba78();
    alive_teleported = 0;
    
    foreach ( var_76ff015046c9aa1 in self.shadow_souls )
    {
        if ( isalive( var_76ff015046c9aa1 ) && var_76ff015046c9aa1.shadow_soul_teleported )
        {
            alive_teleported = 1;
            break;
        }
    }
    
    if ( alive_teleported )
    {
        self.shadow_soul_shield_active = 1;
        utility::function_7c10ea82c1e305b8( "shadow_soul_shield", "on" );
        zombie_weyward_skull::function_3321fee4b8702a40();
        thread shadow_soul_shield_monitor();
    }
    
    self notify( #"shadow_soul_summon_complete" );
}

// Namespace zombie_weyward_shadow_soul
// Params 5, eflags: 0x4
// Checksum 0x21a3322e, Offset: 0x142e
// Size: 0xb9
function private function_cec8a30a9e5a21a9( count, positions, var_84e2dfa8660cffd7, var_4bfd53d6f6b600e0, var_cc4a82bdde1a4b15 )
{
    self endon( #"death" );
    self notify( #"hash_a413ec731a8d968" );
    self endon( #"hash_a413ec731a8d968" );
    
    for ( i = 0; i < count ; i++ )
    {
        if ( isai( self ) && var_4bfd53d6f6b600e0 )
        {
            function_681a1f043e1b7ab3( 1, positions[ i ] );
        }
        
        spawn_shadow_soul( positions[ i ], var_84e2dfa8660cffd7, var_4bfd53d6f6b600e0 );
        
        if ( var_4bfd53d6f6b600e0 && var_cc4a82bdde1a4b15 )
        {
            wait var_cc4a82bdde1a4b15 / count;
        }
    }
    
    function_a3c1cf14ebcc3e46();
    self notify( #"shadow_souls_spawned_and_arrived" );
}

// Namespace zombie_weyward_shadow_soul
// Params 0, eflags: 0x4
// Checksum 0x287326fa, Offset: 0x14ef
// Size: 0x70
function private function_f71fddf19c6ab63e()
{
    self endon( #"shadow_soul_summon_complete" );
    n_timeout = 20 + getdvarfloat( @"hash_10886013c37e67df", self.shadow_soul_immune_duration ) + 8.5;
    thread function_1ef86f9d4d212542();
    utility::waittill_any_timeout( n_timeout, "death", "begin_fake_death", "begin_real_death", "playing_game_over_scene" );
    self notify( #"hash_f535f5b2855d0652" );
    function_7787ad31ba861b5d();
}

// Namespace zombie_weyward_shadow_soul
// Params 0, eflags: 0x4
// Checksum 0xecf2a657, Offset: 0x1567
// Size: 0x3f
function private function_1ef86f9d4d212542()
{
    self endon( #"death" );
    self endon( #"shadow_soul_summon_complete" );
    self endon( #"hash_f535f5b2855d0652" );
    level waittill( #"playing_game_over_scene" );
    self notify( #"playing_game_over_scene" );
}

// Namespace zombie_weyward_shadow_soul
// Params 0, eflags: 0x4
// Checksum 0x25357bb1, Offset: 0x15ae
// Size: 0xdb
function private function_7787ad31ba861b5d()
{
    self.shadow_soul_immune = 0;
    self function_f2df0257c63f229( "shadow_soul_immune" );
    self function_786bb6aa1b76c7ee( "in_immune", 0 );
    val::reset( "shadow_soul_summon", "special_pain" );
    utility::ent_flag_clear( "in_soul_phase_transition" );
    
    foreach ( player in level.players )
    {
        player thread zombie_boss_healthbar::zombie_boss_healthbar_immune( 0 );
    }
    
    if ( isalive( self ) )
    {
        function_681a1f043e1b7ab3( 0 );
        utility::function_7c10ea82c1e305b8( "portal", "off" );
    }
}

// Namespace zombie_weyward_shadow_soul
// Params 3
// Checksum 0x27a426ec, Offset: 0x1691
// Size: 0x22c
function function_681a1f043e1b7ab3( var_f1fbc291f2430b1e, positions, var_6b27c1d89b34890e )
{
    self endon( #"death" );
    
    if ( !isdefined( self.var_6c4a3c3fd15acbf ) )
    {
        self.var_6c4a3c3fd15acbf = [];
    }
    
    if ( var_f1fbc291f2430b1e )
    {
        if ( isarray( positions ) )
        {
            foreach ( v_pos in positions )
            {
                beam_dest = utility::spawn_model( "tag_origin", v_pos );
                beam = playfxontagsbetweenclients( utility::getfx( "weyward_shadow_soul_beam" ), self, "j_jaw", beam_dest, "tag_origin" );
                self.var_6c4a3c3fd15acbf[ self.var_6c4a3c3fd15acbf.size ] = beam;
                self.var_6c4a3c3fd15acbf[ self.var_6c4a3c3fd15acbf.size ] = beam_dest;
                wait var_6b27c1d89b34890e ?? 0.5;
            }
        }
        else if ( isvector( positions ) )
        {
            v_pos = positions;
            beam_dest = utility::spawn_model( "tag_origin", v_pos );
            beam = playfxontagsbetweenclients( utility::getfx( "weyward_shadow_soul_beam" ), self, "j_jaw", beam_dest, "tag_origin" );
            self.var_6c4a3c3fd15acbf[ self.var_6c4a3c3fd15acbf.size ] = beam;
            self.var_6c4a3c3fd15acbf[ self.var_6c4a3c3fd15acbf.size ] = beam_dest;
        }
        
        return;
    }
    
    foreach ( beam_ent in self.var_6c4a3c3fd15acbf )
    {
        if ( isdefined( beam_ent ) )
        {
            beam_ent delete();
        }
    }
    
    self.var_6c4a3c3fd15acbf = function_5713d46873b29625( self.var_6c4a3c3fd15acbf );
}

// Namespace zombie_weyward_shadow_soul
// Params 0
// Checksum 0x4ced9367, Offset: 0x18c5
// Size: 0xea
function get_shadow_soul_damage_reduction()
{
    if ( !self.shadow_soul_shield_active )
    {
        return 1;
    }
    
    function_3164cfc53fa7ba78();
    alive_count = 0;
    
    foreach ( var_76ff015046c9aa1 in self.shadow_souls )
    {
        if ( isalive( var_76ff015046c9aa1 ) && var_76ff015046c9aa1.shadow_soul_teleported )
        {
            alive_count++;
        }
    }
    
    if ( alive_count == 0 )
    {
        return 1;
    }
    
    reduction = min( alive_count * self.var_92d7a886edd44579, self.var_b132e4221924c798 );
    return 1 - reduction;
}

// Namespace zombie_weyward_shadow_soul
// Params 3
// Checksum 0xd1bccb50, Offset: 0x19b8
// Size: 0x36e
function spawn_shadow_soul( target_pos, var_84e2dfa8660cffd7, var_4bfd53d6f6b600e0 )
{
    yaw = vectortoyaw( self.origin - target_pos );
    v_facing_angles = ( 0, yaw, 0 );
    
    if ( var_4bfd53d6f6b600e0 )
    {
        v_spawn_origin = target_pos;
    }
    else
    {
        v_spawn_origin = self.origin;
    }
    
    if ( var_84e2dfa8660cffd7 )
    {
        var_76ff015046c9aa1 = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( "sat_spawner_zombie_wither_zm_shadow_mq", v_spawn_origin, v_facing_angles, self.team );
        
        if ( !isdefined( var_76ff015046c9aa1 ) )
        {
            /#
                if ( debug_shadow_soul() )
                {
                    println( "<dev string:x70>" );
                }
            #/
            
            return;
        }
    }
    else
    {
        var_76ff015046c9aa1 = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( function_b3988325430ce242( "zombie_wither_shadow" ), v_spawn_origin, v_facing_angles, self.team );
        
        while ( !var_76ff015046c9aa1 )
        {
            zombies = arrayrandomize( getaiarray( "team_two_hundred" ) );
            
            foreach ( zombie in zombies )
            {
                if ( !isalive( zombie ) || zombie.subclass == "zombie_weyward" || zombie.subclass == "zombie_wither_shadow" || issubstr( zombie.subclass, "hvt" ) )
                {
                    continue;
                }
                
                zombie.nocorpse = 1;
                zombie kill();
                waitframe();
                waitframe();
                break;
            }
            
            var_76ff015046c9aa1 = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( function_b3988325430ce242( "zombie_wither_shadow" ), v_spawn_origin, v_facing_angles, self.team );
            
            if ( var_76ff015046c9aa1 )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    var_76ff015046c9aa1.shadow_soul_owner = self;
    var_76ff015046c9aa1.shadow_soul_arrived = 0;
    var_76ff015046c9aa1.shadow_soul_teleported = 0;
    var_76ff015046c9aa1.b_cleanup_no_respawn = 1;
    var_76ff015046c9aa1.var_15598d8e493afe88 = 1;
    var_76ff015046c9aa1.var_825b17c932865df = 1;
    var_76ff015046c9aa1.var_990324c31d3215c5 = 1;
    var_76ff015046c9aa1 val::set( "shadow_soul_spawn", "damage", 0 );
    var_76ff015046c9aa1 val::set( "shadow_soul", "ignore_cleanup", 1 );
    callback::callback( "on_summoned_by_weyward", { #ent:var_76ff015046c9aa1 } );
    var_76ff015046c9aa1.soul_carrier = utility::function_1808878d1c511ce8( var_76ff015046c9aa1.origin, v_facing_angles );
    var_76ff015046c9aa1 thread utility::delete_on_death( var_76ff015046c9aa1.soul_carrier );
    var_76ff015046c9aa1 utility::delaycallendon( level.framedurationseconds, "death", &linktoblendtotag, var_76ff015046c9aa1.soul_carrier, "tag_origin" );
    self.shadow_souls[ self.shadow_souls.size ] = var_76ff015046c9aa1;
    thread function_53cb0174251a4270( var_76ff015046c9aa1, target_pos );
    thread function_42761ed3a6d63101( var_76ff015046c9aa1 );
    thread function_c6c6821aab418c2( var_76ff015046c9aa1 );
    
    if ( var_84e2dfa8660cffd7 )
    {
        var_76ff015046c9aa1 utility::delaythreadendon( 0.95, "death", &utility::function_7c10ea82c1e305b8, "shadow_soul_fx", "ambient_mq" );
    }
    
    /#
        if ( debug_shadow_soul() )
        {
            println( "<dev string:x9b>" + v_spawn_origin + "<dev string:xb6>" + target_pos + "<dev string:xc3>" + self.shadow_souls.size );
        }
    #/
    
    return var_76ff015046c9aa1;
}

// Namespace zombie_weyward_shadow_soul
// Params 1
// Checksum 0x41ced9df, Offset: 0x1d2f
// Size: 0x16a
function function_5cd8381640522f9c( count )
{
    if ( self.var_924151b61b0c320a && self.var_924151b61b0c320a.size >= count )
    {
        return self.var_924151b61b0c320a;
    }
    
    var_2c075fa23c46910f = getdvarfloat( @"hash_5e36d7da2cb62a72", self.shadow_soul_fly_height ?? 200 );
    min_spacing = getdvarfloat( @"hash_59912dc1103756fb", self.var_642b369dca4060ed ?? 60 );
    center = self.origin + ( 0, 0, var_2c075fa23c46910f );
    
    if ( count <= 1 )
    {
        positions = [];
        positions[ positions.size ] = center;
        return positions;
    }
    
    angle_step = 360 / count;
    sin_half = sin( angle_step * 0.5 );
    
    if ( sin_half > 0 )
    {
        radius = min_spacing / 2 * sin_half;
    }
    else
    {
        radius = min_spacing;
    }
    
    positions = [];
    
    for ( i = 0; i < count ; i++ )
    {
        angle = angle_step * i;
        x = cos( angle ) * radius;
        y = sin( angle ) * radius;
        pos = center + ( x, y, 0 );
        positions[ positions.size ] = pos;
    }
    
    return positions;
}

// Namespace zombie_weyward_shadow_soul
// Params 3
// Checksum 0xd646d7b, Offset: 0x1ea2
// Size: 0x200
function function_53cb0174251a4270( var_76ff015046c9aa1, target_pos, fly_speed_override )
{
    self endon( #"death" );
    var_76ff015046c9aa1 notify( #"hash_1a10772d8288db20" );
    var_76ff015046c9aa1 endon( #"death", #"hash_1a10772d8288db20" );
    function_c6d9a0a40f1f7544( var_76ff015046c9aa1 );
    fly_speed = fly_speed_override ?? getdvarfloat( @"hash_a45b5ebaa24a3890", self.shadow_soul_fly_speed ?? 300 );
    arrival_threshold = 5;
    
    while ( true )
    {
        if ( !isdefined( var_76ff015046c9aa1.soul_carrier ) )
        {
            var_76ff015046c9aa1.soul_carrier = utility::spawn_model( "tag_origin", var_76ff015046c9aa1.origin, var_76ff015046c9aa1.angles );
            var_76ff015046c9aa1 thread utility::delete_on_death( var_76ff015046c9aa1.soul_carrier );
            waitframe();
            var_76ff015046c9aa1 linktoblendtotag( var_76ff015046c9aa1.soul_carrier, "tag_origin" );
        }
        
        if ( !isalive( var_76ff015046c9aa1 ) )
        {
            break;
        }
        
        dir = target_pos - var_76ff015046c9aa1.soul_carrier.origin;
        dist = length( dir );
        
        if ( dist <= arrival_threshold )
        {
            var_76ff015046c9aa1.soul_carrier.origin = target_pos;
            var_76ff015046c9aa1.shadow_soul_arrived = 1;
            function_605268b6f9d2ff4f( var_76ff015046c9aa1 );
            
            /#
                if ( debug_shadow_soul() )
                {
                    println( "<dev string:xcd>" + target_pos );
                }
            #/
            
            return;
        }
        
        move_dist = fly_speed * level.framedurationseconds;
        
        if ( move_dist >= dist )
        {
            var_76ff015046c9aa1.soul_carrier.origin = target_pos;
        }
        else
        {
            var_76ff015046c9aa1.soul_carrier.origin += vectornormalize( dir ) * move_dist;
        }
        
        waitframe();
    }
}

// Namespace zombie_weyward_shadow_soul
// Params 2
// Checksum 0xf3e6790c, Offset: 0x20aa
// Size: 0x115
function function_d80fa2e6b8d59763( bonus_count, max_count )
{
    self endon( #"death" );
    var_49adc4d6eda3ee88 = bonus_count ?? 0;
    
    if ( var_49adc4d6eda3ee88 <= 0 )
    {
        return;
    }
    
    var_8f975854d72e6c8a = self.shadow_souls.size;
    var_6b79f0e6fc15bce1 = max_count ?? bonus_count;
    
    if ( var_8f975854d72e6c8a >= var_6b79f0e6fc15bce1 )
    {
        return;
    }
    
    var_9f6f7a56d272680e = min( var_8f975854d72e6c8a + var_49adc4d6eda3ee88, var_6b79f0e6fc15bce1 );
    cluster_positions = function_5cd8381640522f9c( var_9f6f7a56d272680e );
    
    if ( !cluster_positions.size )
    {
        return;
    }
    
    for ( spawn_index = var_8f975854d72e6c8a; spawn_index < var_9f6f7a56d272680e ; spawn_index++ )
    {
        target_index = int( min( spawn_index, cluster_positions.size - 1 ) );
        spawn_shadow_soul( cluster_positions[ target_index ] );
    }
    
    function_a3c1cf14ebcc3e46();
    function_3164cfc53fa7ba78();
    function_de92f052633c1fa1();
    wait 1;
    self.shadow_soul_shield_active = 1;
    utility::function_7c10ea82c1e305b8( "shadow_soul_shield", "on" );
    zombie_weyward_skull::function_3321fee4b8702a40();
    thread shadow_soul_shield_monitor();
}

// Namespace zombie_weyward_shadow_soul
// Params 0, eflags: 0x4
// Checksum 0xbaaa59f1, Offset: 0x21c7
// Size: 0x96
function private function_228f2c79c68827dd()
{
    if ( isdefined( self.var_bfec04d50947b318 ) )
    {
        foreach ( wither in self.var_bfec04d50947b318 )
        {
            if ( isalive( wither ) )
            {
                wither.var_b4a2ac2812cf870e = 1;
            }
        }
    }
}

// Namespace zombie_weyward_shadow_soul
// Params 1, eflags: 0x4
// Checksum 0x3f3a5b77, Offset: 0x2265
// Size: 0x3c
function private function_605268b6f9d2ff4f( var_76ff015046c9aa1 )
{
    if ( isdefined( var_76ff015046c9aa1.soul_carrier ) )
    {
        var_76ff015046c9aa1.soul_carrier bobbing( ( 0, 0, 1 ), 6, 6 );
    }
}

// Namespace zombie_weyward_shadow_soul
// Params 1, eflags: 0x4
// Checksum 0x3d471b1b, Offset: 0x22a9
// Size: 0x3b
function private function_c6d9a0a40f1f7544( var_76ff015046c9aa1 )
{
    if ( isdefined( var_76ff015046c9aa1.soul_carrier ) )
    {
        var_76ff015046c9aa1.soul_carrier bobbing( ( 0, 0, 0 ), 0, 1 );
    }
}

// Namespace zombie_weyward_shadow_soul
// Params 0, eflags: 0x4
// Checksum 0xc63bc41f, Offset: 0x22ec
// Size: 0xc4
function private function_a3c1cf14ebcc3e46()
{
    self endon( #"death" );
    
    while ( true )
    {
        all_arrived = 1;
        
        foreach ( var_76ff015046c9aa1 in self.shadow_souls )
        {
            if ( isalive( var_76ff015046c9aa1 ) && !var_76ff015046c9aa1.shadow_soul_arrived )
            {
                all_arrived = 0;
                break;
            }
        }
        
        if ( all_arrived )
        {
            self notify( #"all_souls_arrived" );
            return;
        }
        
        waitframe();
    }
}

// Namespace zombie_weyward_shadow_soul
// Params 1, eflags: 0x4
// Checksum 0xe85b2ea0, Offset: 0x23b8
// Size: 0x50
function private function_95a06c3af0070e78( dest )
{
    if ( self.var_87babd99816390fb.var_6b99b6542825bc05 )
    {
        return self.var_87babd99816390fb.angles;
    }
    
    return vectortoangles( self.var_87babd99816390fb.origin - dest );
}

// Namespace zombie_weyward_shadow_soul
// Params 0, eflags: 0x4
// Checksum 0x67195656, Offset: 0x2411
// Size: 0x3cd
function private function_de92f052633c1fa1()
{
    struct_positions = utility::getstructarray( self.var_de4da4507fea9751 ?? "shadow_soul_pos", "script_noteworthy" );
    available_positions = [];
    
    if ( isdefined( struct_positions ) )
    {
        foreach ( s in struct_positions )
        {
            available_positions[ available_positions.size ] = s;
        }
    }
    
    if ( available_positions.size > 1 )
    {
        for ( i = available_positions.size - 1; i > 0 ; i-- )
        {
            j = randomint( i + 1 );
            temp = available_positions[ i ];
            available_positions[ i ] = available_positions[ j ];
            available_positions[ j ] = temp;
        }
    }
    
    position_index = 0;
    teleport_range = getdvarfloat( @"hash_d893671c8979caae", self.shadow_soul_teleport_range ?? 2000 );
    
    foreach ( var_76ff015046c9aa1 in self.shadow_souls )
    {
        if ( !isalive( var_76ff015046c9aa1 ) || var_76ff015046c9aa1.shadow_soul_teleported )
        {
            continue;
        }
        
        dest = undefined;
        
        if ( position_index < available_positions.size )
        {
            dest = available_positions[ position_index ].origin;
            var_6bd86757cb5c529d = isdefined( self.var_de4da4507fea9751 ) ? available_positions[ position_index ].angles : undefined;
            position_index++;
        }
        
        if ( !isdefined( dest ) )
        {
            dest = function_3022252b3d4cc83b( self.origin, teleport_range );
        }
        
        if ( !isdefined( dest ) )
        {
            /#
                if ( debug_shadow_soul() )
                {
                    println( "<dev string:xf1>" );
                }
            #/
            
            continue;
        }
        
        var_76ff015046c9aa1 utility::function_7c10ea82c1e305b8( "shadow_soul_teleport", "teleport_out" );
        wait 0.5;
        
        if ( !isalive( var_76ff015046c9aa1 ) )
        {
            continue;
        }
        
        function_466c457115afa0e2( { #var_6b99b6542825bc05:1, #angles:vectortoangles( self.origin - dest ) } );
        var_56bb7a2692402004 = var_6bd86757cb5c529d ?? function_95a06c3af0070e78( dest );
        var_76ff015046c9aa1.soul_carrier.origin = dest;
        var_76ff015046c9aa1.soul_carrier.angles = var_56bb7a2692402004;
        var_76ff015046c9aa1.shadow_soul_teleported = 1;
        var_76ff015046c9aa1.shadow_soul_teleport_origin = dest;
        var_76ff015046c9aa1.var_e59e24fbb46d7d5e = 1;
        var_76ff015046c9aa1.turnrate = 10;
        
        if ( !var_6bd86757cb5c529d )
        {
            var_76ff015046c9aa1 orientmode( "face angle 3d", var_56bb7a2692402004 );
        }
        
        function_605268b6f9d2ff4f( var_76ff015046c9aa1 );
        
        if ( !self.var_87babd99816390fb.var_6b99b6542825bc05 )
        {
            thread function_c6c6821aab418c2( var_76ff015046c9aa1, self.var_87babd99816390fb );
        }
        
        var_76ff015046c9aa1 val::reset_all( "shadow_soul_spawn" );
        waitframe();
        var_76ff015046c9aa1 utility::function_7c10ea82c1e305b8( "shadow_soul_teleport", "teleport_in" );
        
        if ( isai( self ) )
        {
            var_76ff015046c9aa1 utility::function_7c10ea82c1e305b8( "shadow_soul_fx", "ambient_outside_arena" );
        }
        
        var_76ff015046c9aa1 utility::delaythreadendon( 1, "death", &utility::function_7c10ea82c1e305b8, "shadow_soul_teleport", "off" );
        
        /#
            if ( debug_shadow_soul() )
            {
                println( "<dev string:x124>" + dest );
            }
        #/
    }
}

// Namespace zombie_weyward_shadow_soul
// Params 2, eflags: 0x4
// Checksum 0xb9821634, Offset: 0x27e6
// Size: 0xae
function private function_3022252b3d4cc83b( origin, range )
{
    for ( attempt = 0; attempt < 10 ; attempt++ )
    {
        var_47a8bf3b386be5a5 = randomfloat( 360 );
        random_dist = randomfloatrange( range * 0.5, range );
        target = origin + ( cos( var_47a8bf3b386be5a5 ) * random_dist, sin( var_47a8bf3b386be5a5 ) * random_dist, 0 );
        nav_trace = navtrace( origin, target, self, 1 );
        nav_pos = nav_trace[ "position" ];
        
        if ( distance( nav_pos, origin ) > 100 )
        {
            return nav_pos;
        }
    }
}

// Namespace zombie_weyward_shadow_soul
// Params 1, eflags: 0x4
// Checksum 0x671adf6e, Offset: 0x289d
// Size: 0xf2
function private function_688679a6a88e6c01( var_76ff015046c9aa1 )
{
    self endon( #"death" );
    var_76ff015046c9aa1 endon( #"death" );
    beam_vfx = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_709229aacf05d8ee;
    
    if ( !isdefined( beam_vfx ) && !isdefined( level._effect[ "weyward_shadow_soul_beam" ] ) )
    {
        /#
            if ( debug_shadow_soul() )
            {
                println( "<dev string:x142>" );
            }
        #/
        
        return;
    }
    
    if ( isent( self ) )
    {
        e_beam_target = self;
        str_beam_tag = "j_mainroot";
    }
    else
    {
        e_beam_target = self.e_beam_target;
        str_beam_tag = "tag_origin";
        
        if ( !isent( e_beam_target ) )
        {
            /#
                if ( debug_shadow_soul() )
                {
                    println( "<dev string:x178>" );
                }
            #/
            
            return;
        }
    }
    
    if ( !isdefined( var_76ff015046c9aa1.beam ) )
    {
    }
    
    thread function_c6c6821aab418c2( var_76ff015046c9aa1 );
}

// Namespace zombie_weyward_shadow_soul
// Params 2, eflags: 0x4
// Checksum 0x4fb47588, Offset: 0x2997
// Size: 0x1bd
function private function_c6c6821aab418c2( var_76ff015046c9aa1, target )
{
    if ( self.var_de4da4507fea9751 )
    {
        return;
    }
    
    self endon( #"death" );
    var_76ff015046c9aa1.soul_carrier notify( #"hash_51ef2007a63b6e3f" );
    var_76ff015046c9aa1.soul_carrier endon( #"death", #"hash_51ef2007a63b6e3f" );
    
    if ( !isdefined( target ) )
    {
        target = self;
    }
    
    yaw = vectortoyaw( target.origin - var_76ff015046c9aa1.soul_carrier.origin );
    var_76ff015046c9aa1 orientmode( "face angle 3d", ( var_76ff015046c9aa1.soul_carrier.angles[ 0 ] ?? 0, yaw, var_76ff015046c9aa1.soul_carrier.angles[ 2 ] ?? 0 ) );
    
    while ( true )
    {
        yaw = vectortoyaw( target.origin - var_76ff015046c9aa1.soul_carrier.origin );
        var_76ff015046c9aa1.soul_carrier rotateto( ( var_76ff015046c9aa1.soul_carrier.angles[ 0 ] ?? 0, yaw, var_76ff015046c9aa1.soul_carrier.angles[ 2 ] ?? 0 ), 0.25 );
        var_76ff015046c9aa1.soul_carrier waittill( #"rotatedone" );
        var_76ff015046c9aa1 orientmode( "face angle 3d", ( var_76ff015046c9aa1.soul_carrier.angles[ 0 ] ?? 0, yaw, var_76ff015046c9aa1.soul_carrier.angles[ 2 ] ?? 0 ) );
    }
}

// Namespace zombie_weyward_shadow_soul
// Params 0, eflags: 0xc
// Checksum 0x98e7659d, Offset: 0x2b5c
// Size: 0x1ae
function private shadow_soul_shield_monitor()
{
    self notify( #"hash_1e8c01c733cc93c6" );
    self endon( #"hash_1e8c01c733cc93c6" );
    self endon( #"death" );
    
    while ( true )
    {
        function_3164cfc53fa7ba78();
        alive_teleported = 0;
        
        foreach ( var_76ff015046c9aa1 in self.shadow_souls )
        {
            if ( isalive( var_76ff015046c9aa1 ) && var_76ff015046c9aa1.shadow_soul_teleported )
            {
                alive_teleported = 1;
                break;
            }
        }
        
        if ( !alive_teleported )
        {
            self.shadow_soul_shield_active = 0;
            utility::function_7c10ea82c1e305b8( "shadow_soul_shield", "off" );
            
            foreach ( wither in self.var_bfec04d50947b318 )
            {
                if ( isalive( wither ) && wither.shadow_soul_shield_active )
                {
                    wither.shadow_soul_shield_active = 0;
                    wither utility::function_7c10ea82c1e305b8( "boss_fight_shield", "vulnerable" );
                }
            }
            
            /#
                if ( debug_shadow_soul() )
                {
                    println( "<dev string:x1ad>" );
                }
            #/
            
            return;
        }
        
        waitframe();
    }
}

// Namespace zombie_weyward_shadow_soul
// Params 1, eflags: 0x4
// Checksum 0x10e45021, Offset: 0x2d12
// Size: 0x6d
function private function_42761ed3a6d63101( var_76ff015046c9aa1 )
{
    self endon( #"death" );
    var_76ff015046c9aa1 waittill( #"death" );
    
    if ( isdefined( var_76ff015046c9aa1.soul_carrier ) )
    {
        var_76ff015046c9aa1.soul_carrier delete();
    }
    
    function_3164cfc53fa7ba78();
    
    /#
        if ( debug_shadow_soul() )
        {
            println( "<dev string:x1df>" + self.shadow_souls.size );
        }
    #/
}

// Namespace zombie_weyward_shadow_soul
// Params 0, eflags: 0x4
// Checksum 0xc7c65c60, Offset: 0x2d87
// Size: 0xd7
function private function_9025ab7ef19a4be2()
{
    self waittill( #"death" );
    
    foreach ( var_76ff015046c9aa1 in self.shadow_souls )
    {
        if ( isalive( var_76ff015046c9aa1 ) )
        {
            if ( isdefined( var_76ff015046c9aa1.soul_carrier ) )
            {
                var_76ff015046c9aa1 unlink();
                var_76ff015046c9aa1.soul_carrier delete();
            }
            
            var_76ff015046c9aa1.forceannihilate = 1;
            var_76ff015046c9aa1 kill( self.origin, self );
        }
    }
    
    self.shadow_souls = [];
}

// Namespace zombie_weyward_shadow_soul
// Params 0, eflags: 0x4
// Checksum 0x34c0d71c, Offset: 0x2e66
// Size: 0x2a
function private begin_oubliette()
{
    if ( isdefined( level.var_348a1070393d7e6a ) )
    {
        [[ level.var_348a1070393d7e6a ]]( { #source:"phase_immune" } );
    }
}

// Namespace zombie_weyward_shadow_soul
// Params 0, eflags: 0x4
// Checksum 0xd141ee76, Offset: 0x2e98
// Size: 0x98
function private function_3164cfc53fa7ba78()
{
    alive_souls = [];
    
    foreach ( var_76ff015046c9aa1 in self.shadow_souls )
    {
        if ( isalive( var_76ff015046c9aa1 ) )
        {
            alive_souls[ alive_souls.size ] = var_76ff015046c9aa1;
        }
    }
    
    self.shadow_souls = alive_souls;
}

/#

    // Namespace zombie_weyward_shadow_soul
    // Params 0, eflags: 0x4
    // Checksum 0x3e35103, Offset: 0x2f38
    // Size: 0x70, Type: dev
    function private function_ff9c5d5d0784a2cf()
    {
        devgui::function_9082edeb5db93280( "<dev string:x205>" );
        devgui::add_devgui_func( "<dev string:x22a>", "<dev string:x244>", &function_26a39dbe77631496 );
        devgui::add_devgui_func( "<dev string:x265>", "<dev string:x27f>", &function_26a39ebe776316c9 );
        devgui::add_devgui_func( "<dev string:x2a0>", "<dev string:x2b6>", &function_e83dc63bb63044cc );
        devgui::add_devgui_func( "<dev string:x2d6>", "<dev string:x2e8>", &function_8dbdc27023595c47 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_weyward_shadow_soul
    // Params 1, eflags: 0x4
    // Checksum 0xe308179f, Offset: 0x2fb0
    // Size: 0x97, Type: dev
    function private function_26a39dbe77631496( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x309>" );
        
        if ( isdefined( weyward ) )
        {
            count = getdvarint( @"hash_de9472aada9eaa10", weyward.var_43d521bf94f61a76 );
            count += weyward.var_984fb0f3aeafa472[ int( clamp( level.players.size - 1, 0, 3 ) ) ];
            weyward thread begin_shadow_soul_summon( count );
        }
    }

    // Namespace zombie_weyward_shadow_soul
    // Params 1, eflags: 0x4
    // Checksum 0xaa3aef04, Offset: 0x304f
    // Size: 0x97, Type: dev
    function private function_26a39ebe776316c9( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x309>" );
        
        if ( isdefined( weyward ) )
        {
            count = getdvarint( @"hash_a549f0be27bb52ef", weyward.var_39ac8b5da987a635 );
            count += weyward.var_a82b9f0426b9c88f[ int( clamp( level.players.size - 1, 0, 3 ) ) ];
            weyward thread begin_shadow_soul_summon( count );
        }
    }

    // Namespace zombie_weyward_shadow_soul
    // Params 1, eflags: 0x4
    // Checksum 0x7ddf316c, Offset: 0x30ee
    // Size: 0x110, Type: dev
    function private function_e83dc63bb63044cc( params )
    {
        weyward = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x309>" );
        
        if ( isdefined( weyward ) )
        {
            foreach ( var_76ff015046c9aa1 in weyward.shadow_souls )
            {
                if ( isalive( var_76ff015046c9aa1 ) )
                {
                    if ( isdefined( var_76ff015046c9aa1.soul_carrier ) )
                    {
                        var_76ff015046c9aa1 unlink();
                        var_76ff015046c9aa1.soul_carrier delete();
                    }
                    
                    var_76ff015046c9aa1.forceannihilate = 1;
                    var_76ff015046c9aa1 kill( weyward.origin, weyward );
                }
            }
            
            weyward.shadow_souls = [];
        }
    }

    // Namespace zombie_weyward_shadow_soul
    // Params 1, eflags: 0x4
    // Checksum 0xc59bab14, Offset: 0x3206
    // Size: 0x24, Type: dev
    function private function_8dbdc27023595c47( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x318>", @"hash_8fa977f81e8b48a2" );
    }

    // Namespace zombie_weyward_shadow_soul
    // Params 0, eflags: 0x4
    // Checksum 0xe54b1b2c, Offset: 0x3232
    // Size: 0x16, Type: dev
    function private debug_shadow_soul()
    {
        return getdvarint( @"hash_8fa977f81e8b48a2", 0 ) > 0;
    }

#/
