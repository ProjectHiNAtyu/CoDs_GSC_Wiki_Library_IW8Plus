// scripts\mp\active_env\active_env_penthouse.gsc  (hash_2b4b90647dc1d53d.gscc) (size: 10124 Bytes / 0x278c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9ce2207b (2632065147)
// size ...... 10124 (0x278c)
// includes .. 5   (offset: 0x2584)
// strings ... 33  (offset: 0x25ac)
// dev strs .. 0   (offset: 0x278c)
// exports ... 26  (offset: 0x1864)
// cseg ...... 0x2f8 + 0x156c (0x1864)
// imports ... 71  (offset: 0x1c74)
// animtree1 . 0   (offset: 0x278c)
// animtree2 . 0   (offset: 0x278c)
#using scripts\common\active_env\active_env;
#using scripts\common\active_env\utility;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\damage;
#using scripts\mp\juggernaut;

#namespace active_env_penthouse;

// Namespace active_env_penthouse
// Params 0
// Checksum 0x6768e447, Offset: 0x316
// Size: 0x21a
function security_system_init()
{
    var_ffc040ee963cb55b = self;
    var_c500d4ea6f809688 = getent( self.target, #targetname );
    a_e_lights = getentarray( "security_light", #targetname );
    var_87bf59d6dfb5fd8f = getentitylessscriptablearray( "penthouse_security_roller_screen", #script_noteworthy );
    
    if ( isdefined( var_87bf59d6dfb5fd8f ) )
    {
        foreach ( var_c235bf68af5ba36a in var_87bf59d6dfb5fd8f )
        {
            if ( var_c235bf68af5ba36a.classname == "scriptable_t10_ava_window_roller_screen_security_01_triple" )
            {
                var_53597b1475eb8cf7 = "security_crush_zone_triple";
            }
            else
            {
                var_53597b1475eb8cf7 = "security_crush_zone_single";
            }
            
            var_c235bf68af5ba36a.t_crush_zone = getnoentvolumearray( var_53597b1475eb8cf7, #targetname )[ 0 ];
            utility::function_9fc28d50a2652cd7( var_c235bf68af5ba36a.t_crush_zone );
        }
    }
    
    var_8bfc5d451ee7404f = getnoentvolumearray( "security_kill_zone", #script_noteworthy );
    set_security_lights( a_e_lights, 0 );
    function_12944cbf13edf6ec( var_87bf59d6dfb5fd8f );
    init_metal_detectors();
    b_match_rule = getmatchrulesdata( "commonOption", "dynamicMapElementsDisabled" );
    
    if ( b_match_rule || getdvarint( @"hash_f9ea4f196535a5b1", 0 ) )
    {
        return;
    }
    
    var_452bae1464fdabfa = spawnstruct();
    var_452bae1464fdabfa.var_ffc040ee963cb55b = var_ffc040ee963cb55b;
    var_452bae1464fdabfa.var_c500d4ea6f809688 = var_c500d4ea6f809688;
    var_452bae1464fdabfa.a_e_lights = a_e_lights;
    var_452bae1464fdabfa.var_87bf59d6dfb5fd8f = var_87bf59d6dfb5fd8f;
    var_452bae1464fdabfa.var_8bfc5d451ee7404f = var_8bfc5d451ee7404f;
    
    if ( isdefined( var_ffc040ee963cb55b ) && isdefined( var_c500d4ea6f809688 ) )
    {
        var_ffc040ee963cb55b setusefov( 60 );
        var_c500d4ea6f809688 setusefov( 160 );
        var_c500d4ea6f809688 setuserange( 60 );
        var_452bae1464fdabfa function_2cc47dbe37e6d3ad();
    }
}

// Namespace active_env_penthouse
// Params 0
// Checksum 0xbc4f4bcb, Offset: 0x538
// Size: 0x21
function register_default_funcs()
{
    active_env::function_d9f741be3d50fcaa( "security_activate", &security_system_init );
    sliding_bookshelf_init();
    function_b1b1d46d0de01a8b();
}

// Namespace active_env_penthouse
// Params 1
// Checksum 0x31b09e92, Offset: 0x561
// Size: 0x107
function set_terminal_state( var_6958946f47175852 )
{
    switch ( var_6958946f47175852 )
    {
        case #"hash_24337a349f9057f5":
            self setusableenabled( 1 );
            self sethintstring( &"mp/security_activate" );
            self setcursorhint( "HINT_BUTTON" );
            self sethintinoperable( 0 );
            break;
        case #"hash_e867cf0bf08fa2b0":
            self setusableenabled( 1 );
            self sethintstring( &"mp/security_rebooting" );
            self setcursorhint( "HINT_NOBUTTON" );
            self sethintinoperable( 1 );
            break;
        case #"hash_d9a7b65f9477385c":
            self setusableenabled( 1 );
            self sethintstring( &"mp/security_deactivate" );
            self setcursorhint( "HINT_BUTTON" );
            self sethintinoperable( 0 );
            break;
        case #"hash_35bb36c485686365":
            self setusableenabled( 1 );
            self sethintstring( &"mp/security_disabled" );
            self setcursorhint( "HINT_NOBUTTON" );
            self sethintinoperable( 1 );
            break;
        default:
            break;
    }
}

// Namespace active_env_penthouse
// Params 0
// Checksum 0xd83add64, Offset: 0x670
// Size: 0x306
function function_2cc47dbe37e6d3ad()
{
    level endon( #"game_ended" );
    level.var_d4f797840d571ca1 = 0;
    e_alarm = spawn( "script_model", self.var_ffc040ee963cb55b.origin );
    
    while ( true )
    {
        self.var_ffc040ee963cb55b set_terminal_state( "deactivated" );
        self.var_c500d4ea6f809688 set_terminal_state( "deactivated" );
        self.var_ffc040ee963cb55b thread monitor_activate();
        self.var_c500d4ea6f809688 thread monitor_activate();
        level waittill( #"security_activated", e_user );
        level.var_d4f797840d571ca1 = 1;
        self.var_ffc040ee963cb55b set_terminal_state( "rebooting" );
        self.var_c500d4ea6f809688 set_terminal_state( "rebooting" );
        e_alarm playloopsound( "evt_pent_shutter_alarm_loop" );
        set_security_lights( self.a_e_lights, 1 );
        thread function_299073dfef15ce81();
        
        if ( isdefined( self.var_8bfc5d451ee7404f ) )
        {
            foreach ( t_kill_zone in self.var_8bfc5d451ee7404f )
            {
                t_kill_zone thread function_a48236bebed2a1bd( e_user, 7, 1 );
            }
        }
        
        function_110a5fe364d486ab( self.var_87bf59d6dfb5fd8f );
        
        if ( isdefined( self.var_8bfc5d451ee7404f ) )
        {
            foreach ( t_kill_zone in self.var_8bfc5d451ee7404f )
            {
                t_kill_zone notify( #"stop_monitoring" );
            }
        }
        
        function_49b9400ddfbf68b2();
        wait max( 2, 5 );
        e_alarm stoploopsound();
        self.var_ffc040ee963cb55b set_terminal_state( "activated" );
        self.var_ffc040ee963cb55b thread monitor_deactivate();
        self.var_c500d4ea6f809688 set_terminal_state( "activated" );
        self.var_c500d4ea6f809688 thread monitor_deactivate();
        self.var_c500d4ea6f809688 thread auto_off();
        level waittill( #"security_deactivated" );
        level.var_d4f797840d571ca1 = 0;
        thread function_299073dfef15ce81();
        self.var_ffc040ee963cb55b set_terminal_state( "rebooting" );
        self.var_c500d4ea6f809688 set_terminal_state( "rebooting" );
        set_security_lights( self.a_e_lights, 0 );
        function_12944cbf13edf6ec( self.var_87bf59d6dfb5fd8f );
        function_49b9400ddfbf68b2();
        wait max( 2, 10 );
    }
}

// Namespace active_env_penthouse
// Params 3, eflags: 0x4
// Checksum 0x6b78bb54, Offset: 0x97e
// Size: 0x17e
function private function_a48236bebed2a1bd( e_user, n_delay, var_5cb4f8bc8ebba77 = undefined )
{
    level endon( #"game_ended" );
    self endon( #"stop_monitoring" );
    wait n_delay;
    
    while ( true )
    {
        self waittill( #"trigger", e_ent );
        
        if ( isplayer( e_ent ) )
        {
            if ( !ispointinvolume( e_ent.origin, self, 1 ) )
            {
                continue;
            }
            
            e_player = e_ent;
            e_attacker = e_user;
            
            if ( !isdefined( e_attacker ) || e_player.team == e_attacker.team )
            {
                e_attacker = e_player;
            }
            
            e_player.nocorpse = var_5cb4f8bc8ebba77;
            
            if ( e_ent.isjuggernaut && e_ent.var_e4dae87a649544c3 )
            {
                damagedata = spawnstruct();
                damagedata.attacker = e_attacker;
                damagedata.instantdeath = 1;
                e_ent juggernaut::jugg_removejuggernaut( damagedata );
            }
            else
            {
                damage::addattacker( e_player, e_attacker, undefined, nullweapon(), 0, undefined, undefined, undefined, undefined, "MOD_CRUSH" );
                e_player kill( self.origin, e_attacker, self, "MOD_CRUSH" );
            }
            
            continue;
        }
        
        if ( e_ent getcandamage() )
        {
            e_ent dodamage( 99999, self.origin, e_user, self, "MOD_CRUSH" );
        }
    }
}

// Namespace active_env_penthouse
// Params 2, eflags: 0x4
// Checksum 0x2d16169d, Offset: 0xb04
// Size: 0x7a
function private function_cc14489bb4db731b( e_bookshelf, e_user )
{
    level endon( #"game_ended" );
    self endon( #"stop_monitoring" );
    
    while ( true )
    {
        self waittill( #"trigger", e_ent );
        
        if ( isagent( e_ent ) && e_ent istouching( e_bookshelf ) )
        {
            e_ent kill( self.origin, e_user, e_bookshelf, "MOD_CRUSH" );
        }
    }
}

// Namespace active_env_penthouse
// Params 0, eflags: 0x4
// Checksum 0x98be003, Offset: 0xb86
// Size: 0xbe
function private function_299073dfef15ce81()
{
    level endon( #"game_ended" );
    self endon( #"hash_316019751c651d01" );
    
    while ( true )
    {
        foreach ( var_c235bf68af5ba36a in self.var_87bf59d6dfb5fd8f )
        {
            if ( isdefined( var_c235bf68af5ba36a.t_crush_zone.var_d1a9e2ca4ba96c64 ) )
            {
                utility::function_3fcc72db54ef9ce( var_c235bf68af5ba36a.t_crush_zone );
            }
        }
        
        waitframe();
    }
}

// Namespace active_env_penthouse
// Params 0, eflags: 0x4
// Checksum 0x68705b05, Offset: 0xc4c
// Size: 0xe
function private function_49b9400ddfbf68b2()
{
    self notify( #"hash_316019751c651d01" );
}

// Namespace active_env_penthouse
// Params 1
// Checksum 0xe62a82a2, Offset: 0xc62
// Size: 0x107
function function_12944cbf13edf6ec( var_87bf59d6dfb5fd8f )
{
    foreach ( var_c235bf68af5ba36a in var_87bf59d6dfb5fd8f )
    {
        var_c235bf68af5ba36a setscriptablepartstate( "base", "open" );
    }
    
    wait 11;
    
    foreach ( var_c235bf68af5ba36a in var_87bf59d6dfb5fd8f )
    {
        if ( isdefined( var_c235bf68af5ba36a.n_nav_obstacle_id ) )
        {
            destroynavobstacle( var_c235bf68af5ba36a.n_nav_obstacle_id );
        }
    }
}

// Namespace active_env_penthouse
// Params 1
// Checksum 0xa0940919, Offset: 0xd71
// Size: 0xc8
function function_110a5fe364d486ab( var_87bf59d6dfb5fd8f )
{
    foreach ( var_c235bf68af5ba36a in var_87bf59d6dfb5fd8f )
    {
        var_c235bf68af5ba36a setscriptablepartstate( "base", "close" );
        n_obstacle_id = createnavobstaclebybounds( var_c235bf68af5ba36a.origin, ( 4, 192, 80 ), var_c235bf68af5ba36a.angles );
        var_c235bf68af5ba36a.n_nav_obstacle_id = n_obstacle_id;
    }
    
    wait 11;
}

// Namespace active_env_penthouse
// Params 2
// Checksum 0x714d30fb, Offset: 0xe41
// Size: 0x9a
function set_security_lights( a_e_lights, b_turn_on )
{
    foreach ( e_light in a_e_lights )
    {
        if ( b_turn_on )
        {
            e_light setlightintensity( 0.6 );
            continue;
        }
        
        e_light setlightintensity( 0 );
    }
}

// Namespace active_env_penthouse
// Params 0
// Checksum 0x67cfcf49, Offset: 0xee3
// Size: 0x3e
function monitor_activate()
{
    level endon( #"security_activated" );
    self waittill( #"trigger", e_player );
    
    if ( isplayer( e_player ) )
    {
        level notify( #"security_activated", e_player );
    }
}

// Namespace active_env_penthouse
// Params 0
// Checksum 0x5ad170e, Offset: 0xf29
// Size: 0x3c
function monitor_deactivate()
{
    level endon( #"security_deactivated" );
    self waittill( #"trigger", e_player );
    
    if ( isplayer( e_player ) )
    {
        level notify( #"security_deactivated" );
    }
}

// Namespace active_env_penthouse
// Params 0
// Checksum 0xd88d227f, Offset: 0xf6d
// Size: 0x1d
function auto_off()
{
    level endon( #"security_deactivated" );
    wait 30;
    level notify( #"security_deactivated" );
}

// Namespace active_env_penthouse
// Params 0
// Checksum 0x2bed4456, Offset: 0xf92
// Size: 0x289
function sliding_bookshelf_init()
{
    var_d00697f4f58163b5 = getentarray( "sliding_bookshelf_trig", #script_noteworthy );
    e_bookshelf = getent( "sliding_bookshelf", #script_noteworthy );
    
    if ( isdefined( var_d00697f4f58163b5 ) && isdefined( e_bookshelf ) )
    {
        foreach ( var_bca4465989c7c639 in var_d00697f4f58163b5 )
        {
            var_bca4465989c7c639 sethintstring( &"mp/door_use_open" );
            var_bca4465989c7c639 setcursorhint( "HINT_BUTTON" );
            
            if ( var_bca4465989c7c639.targetname == "inside_prompt" )
            {
                var_bca4465989c7c639 setuserange( 120 );
                var_bca4465989c7c639 setusefov( 240 );
            }
            else
            {
                var_bca4465989c7c639 setuserange( 100 );
                var_bca4465989c7c639 setusefov( 50 );
            }
            
            if ( isdefined( var_bca4465989c7c639.targetname ) )
            {
                var_d00697f4f58163b5[ var_bca4465989c7c639.targetname ] = var_bca4465989c7c639;
            }
        }
        
        if ( isdefined( e_bookshelf.target ) )
        {
            e_bookshelf_clip = getent( e_bookshelf.target, #targetname );
            e_bookshelf.var_aa51443487c71c68 = e_bookshelf_clip;
            e_bookshelf_clip linkto( e_bookshelf );
            e_bookshelf.n_nav_obstacle_id = createnavobstaclebyent( e_bookshelf_clip );
        }
        
        if ( isdefined( e_bookshelf_clip.target ) )
        {
            t_crush_zone = getnoentvolumearray( e_bookshelf_clip.target, #targetname )[ 0 ];
            e_bookshelf.t_crush_zone = t_crush_zone;
            utility::function_9fc28d50a2652cd7( e_bookshelf.t_crush_zone );
        }
        
        var_8bfc5d451ee7404f = getnoentvolumearray( "bookshelf_kill_zone", #script_noteworthy );
        
        if ( var_8bfc5d451ee7404f.size > 0 )
        {
            t_kill_zone = var_8bfc5d451ee7404f[ 0 ];
            e_bookshelf.t_kill_zone = t_kill_zone;
        }
        
        b_match_rule = getmatchrulesdata( "commonOption", "dynamicMapElementsDisabled" );
        
        if ( getdvarint( @"hash_f9ea4f196535a5b1", 0 ) || b_match_rule )
        {
            e_bookshelf.origin += ( 100, 0, 0 );
            e_bookshelf thread sliding_bookshelf_disable( var_d00697f4f58163b5 );
            return;
        }
        
        e_bookshelf.is_closed = 1;
        e_bookshelf thread sliding_bookshelf_logic( var_d00697f4f58163b5 );
    }
}

// Namespace active_env_penthouse
// Params 1
// Checksum 0xbba538b7, Offset: 0x1223
// Size: 0xb5
function sliding_bookshelf_disable( var_d00697f4f58163b5 )
{
    self endon( #"game_ended" );
    
    foreach ( var_bca4465989c7c639 in var_d00697f4f58163b5 )
    {
        var_bca4465989c7c639 triggerdisable();
        var_bca4465989c7c639 setusableenabled( 0 );
    }
    
    waitframe();
    destroynavobstacle( self.n_nav_obstacle_id );
    self.n_nav_obstacle_id = createnavobstaclebyent( self.var_aa51443487c71c68 );
}

// Namespace active_env_penthouse
// Params 1
// Checksum 0xfdc4fcc8, Offset: 0x12e0
// Size: 0x2bb
function sliding_bookshelf_logic( var_d00697f4f58163b5 )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( var_bca4465989c7c639 in var_d00697f4f58163b5 )
        {
            str_hint_string = self.is_closed ? &"mp/door_use_open" : &"mp/door_use_close";
            var_bca4465989c7c639 sethintstring( str_hint_string );
            var_bca4465989c7c639 setusableenabled( 1 );
            var_bca4465989c7c639 thread function_583cb3bc3e7cf175( self );
            
            if ( self.is_closed )
            {
                var_d00697f4f58163b5[ "open_prompt" ] triggerdisable();
                var_d00697f4f58163b5[ "open_prompt" ] setusableenabled( 0 );
                var_d00697f4f58163b5[ "closed_prompt" ] triggerenable();
                var_d00697f4f58163b5[ "closed_prompt" ] setusableenabled( 1 );
                continue;
            }
            
            var_d00697f4f58163b5[ "open_prompt" ] triggerenable();
            var_d00697f4f58163b5[ "open_prompt" ] setusableenabled( 1 );
            var_d00697f4f58163b5[ "closed_prompt" ] triggerdisable();
            var_d00697f4f58163b5[ "closed_prompt" ] setusableenabled( 0 );
        }
        
        self waittill( #"bookshelf_used", e_user );
        
        foreach ( var_bca4465989c7c639 in var_d00697f4f58163b5 )
        {
            var_bca4465989c7c639 setusableenabled( 0 );
        }
        
        n_move_dir = -1 + self.is_closed * 2;
        
        if ( n_move_dir > 0 )
        {
            self playsoundonmovingent( "amb_evt_bookshelf_open" );
        }
        else
        {
            self playsoundonmovingent( "amb_evt_bookshelf_close" );
        }
        
        self movex( n_move_dir * 100, 1 );
        self.is_closed = !self.is_closed;
        self.t_crush_zone thread utility::function_5ca354a4734a1bd8();
        
        if ( n_move_dir < 0 )
        {
            self.t_kill_zone thread function_a48236bebed2a1bd( e_user, 0.8 );
            self.t_crush_zone thread function_cc14489bb4db731b( self, e_user );
        }
        
        wait 1;
        self.t_kill_zone notify( #"stop_monitoring" );
        self.t_crush_zone notify( #"stop_monitoring" );
        destroynavobstacle( self.n_nav_obstacle_id );
        self.n_nav_obstacle_id = createnavobstaclebyent( self.var_aa51443487c71c68 );
        self.t_crush_zone thread utility::function_9074f7fdf422f8e5();
    }
}

// Namespace active_env_penthouse
// Params 1
// Checksum 0xab59f0d, Offset: 0x15a3
// Size: 0x4d
function function_583cb3bc3e7cf175( e_bookshelf )
{
    level endon( #"game_ended" );
    e_bookshelf endon( #"bookshelf_used" );
    self waittill( #"trigger", e_player );
    e_bookshelf notify( #"bookshelf_used", e_player );
}

// Namespace active_env_penthouse
// Params 0
// Checksum 0x712d16cd, Offset: 0x15f8
// Size: 0x9a
function function_b1b1d46d0de01a8b()
{
    var_f39d665a82af1c8d = getnoentvolumearray( "no_prone_trigger", #script_noteworthy );
    
    foreach ( var_78d1b7e63c2a3590 in var_f39d665a82af1c8d )
    {
        trigger::makeenterexittrigger( var_78d1b7e63c2a3590, &function_9c1ba6e1f6f5609d, &function_6fd4d0ced44a61f5 );
    }
}

// Namespace active_env_penthouse
// Params 2, eflags: 0x4
// Checksum 0xc0f73959, Offset: 0x169a
// Size: 0x1d
function private function_9c1ba6e1f6f5609d( e_player, trigger )
{
    e_player allowprone( 0 );
}

// Namespace active_env_penthouse
// Params 2, eflags: 0x4
// Checksum 0xc7cf79eb, Offset: 0x16bf
// Size: 0x1e
function private function_6fd4d0ced44a61f5( e_player, trigger )
{
    e_player allowprone( 1 );
}

// Namespace active_env_penthouse
// Params 0, eflags: 0x4
// Checksum 0x769894c0, Offset: 0x16e5
// Size: 0xbc
function private init_metal_detectors()
{
    var_c83b3ac7a0baf6dc = getnoentvolumearray( "metalalarm_penthouse", #script_noteworthy );
    
    foreach ( var_b0f4270e0b5e5b2b in var_c83b3ac7a0baf6dc )
    {
        var_b0f4270e0b5e5b2b.scr_metal_detector = get_metal_detector( var_b0f4270e0b5e5b2b.target );
        
        if ( isdefined( var_b0f4270e0b5e5b2b.scr_metal_detector ) )
        {
            var_b0f4270e0b5e5b2b thread watch_trigger();
        }
    }
}

// Namespace active_env_penthouse
// Params 0, eflags: 0x4
// Checksum 0x7c8526ce, Offset: 0x17a9
// Size: 0x36
function private watch_trigger()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger" );
        
        if ( level.var_d4f797840d571ca1 )
        {
            start_alarm();
        }
    }
}

// Namespace active_env_penthouse
// Params 1, eflags: 0x4
// Checksum 0x5a858bf9, Offset: 0x17e7
// Size: 0x1d
function private get_metal_detector( str_targetname )
{
    return getentitylessscriptablearray( str_targetname, #targetname )[ 0 ];
}

// Namespace active_env_penthouse
// Params 0, eflags: 0x4
// Checksum 0x6b38801b, Offset: 0x180d
// Size: 0x57
function private start_alarm()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self.scr_metal_detector ) )
    {
        return;
    }
    
    self.scr_metal_detector setscriptablepartstate( "root", "on", 1 );
    wait 5;
    self.scr_metal_detector setscriptablepartstate( "root", "off", 1 );
}

