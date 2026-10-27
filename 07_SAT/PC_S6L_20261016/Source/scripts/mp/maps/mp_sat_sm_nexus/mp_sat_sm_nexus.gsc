// scripts\mp\maps\mp_sat_sm_nexus\mp_sat_sm_nexus.gsc  (hash_0228e85b7decd15d.gscc) (size: 9025 Bytes / 0x2341 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x51b6cd07 (1370934535)
// size ...... 9025 (0x2341)
// includes .. 9   (offset: 0x205d)
// strings ... 46  (offset: 0x20a5)
// dev strs .. 0   (offset: 0x2341)
// exports ... 15  (offset: 0x1609)
// cseg ...... 0x371 + 0x1298 (0x1609)
// imports ... 64  (offset: 0x1861)
// animtree1 . 0   (offset: 0x2341)
// animtree2 . 0   (offset: 0x2341)
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\animation_suite;
#using scripts\mp\common\utility\game;
#using scripts\mp\compass;
#using scripts\mp\load;
#using scripts\mp\maps\mp_sat_sm_nexus\gen\mp_sat_sm_nexus_art;
#using scripts\mp\maps\mp_sat_sm_nexus\mp_sat_sm_nexus_fx;
#using scripts\mp\maps\mp_sat_sm_nexus\mp_sat_sm_nexus_lighting;

#namespace mp_sat_sm_nexus;

// Namespace mp_sat_sm_nexus
// Params 0
// Checksum 0x9b89586d, Offset: 0x38f
// Size: 0xd9
function main()
{
    mp_sat_sm_nexus_art::main();
    namespace_219374b7fecebb98::main();
    mp_sat_sm_nexus_lighting::main();
    load::main();
    level.kill_border_triggers = getentarray( "kill_border_trigger", #targetname );
    level.outofboundstriggers = getentarray( "OutOfBounds", #targetname );
    level.var_750dbf45607817fd = getentarray( "Drone_OutOfBounds", #targetname );
    level.var_f11fa8013d4e241c = getentarray( "VTOL_OutOfBounds", #targetname );
    compass::setupminimap( "compass_map_mp_sat_sm_nexus" );
    game[ "attackers" ] = "allies";
    game[ "defenders" ] = "axis";
    game[ "allies_outfit" ] = "urban";
    game[ "axis_outfit" ] = "woodland";
    level thread animation_suite::animationsuite();
    thread function_75841f0fb4d2dc5b();
}

// Namespace mp_sat_sm_nexus
// Params 0
// Checksum 0x89fb6796, Offset: 0x470
// Size: 0x64b
function function_75841f0fb4d2dc5b()
{
    level endon( #"game_ended" );
    level waittill( #"scriptables_ready" );
    dam_notify_string = "dam";
    var_29b5c0b4a41f5c1a = 30;
    move_time = 15;
    dam_buttons = getentitylessscriptablearray( "river_dam", #script_noteworthy );
    
    foreach ( button in dam_buttons )
    {
        button.sound_ent = spawn( "script_model", button.origin );
        button scriptable::scriptable_addusedcallbackbypart( "arcwire_transmitter", &button_used );
        button scriptable::scriptable_addnotifycallback( "transmitter_damaged", &function_cd7ee8ecd49d8052 );
        button thread function_b4c272a86a25f88f( dam_notify_string, var_29b5c0b4a41f5c1a, dam_buttons );
    }
    
    dam_doors = getentarray( "dam_door", "targetname" );
    
    foreach ( door in dam_doors )
    {
        door.start_pos = door.origin;
        door.target_pos_ent = utility::getstruct( door.target, "targetname" );
        door thread dam_logic( move_time, var_29b5c0b4a41f5c1a, dam_notify_string );
    }
    
    thread function_8a3bc837e2a8e948( dam_notify_string );
    vac_bot_speed = 2;
    level.vac_bots = getentarray( "vac_bot", #targetname );
    
    foreach ( vac_bot in level.vac_bots )
    {
        vac_bot thread function_851b7b95c5548747( vac_bot_speed );
        vac_bot thread damage_watcher();
    }
    
    secret_door_on_notify = "secret_door";
    secret_door_cooldown = 6;
    secret_door_button = getentitylessscriptablearray( "secret_passage", #script_noteworthy );
    secret_doors = getentarray( "secret_door", "targetname" );
    secret_door_decorations = getentarray( "secret_door_deco", "targetname" );
    
    foreach ( door_decoration in secret_door_decorations )
    {
        if ( isdefined( door_decoration.script_noteworthy ) )
        {
            foreach ( door in secret_doors )
            {
                if ( isdefined( door.script_noteworthy ) )
                {
                    if ( door_decoration.script_noteworthy == door.script_noteworthy )
                    {
                        door_decoration linkto( door );
                        
                        if ( isdefined( door_decoration.script_label ) )
                        {
                            door.navmodifier = door_decoration;
                        }
                    }
                }
            }
        }
    }
    
    foreach ( button in secret_door_button )
    {
        button.sound_ent = spawn( "script_model", button.origin );
        button scriptable::scriptable_addusedcallbackbypart( "arcwire_transmitter", &button_used );
        button scriptable::scriptable_addnotifycallback( "transmitter_damaged", &function_cd7ee8ecd49d8052 );
        button thread function_b4c272a86a25f88f( secret_door_on_notify, secret_door_cooldown, secret_door_button );
    }
    
    var_c9d9ea02af4d7fdb = getentarray( "door_custom_interactable", "targetname" );
    
    foreach ( var_13be61a4fe36f167 in var_c9d9ea02af4d7fdb )
    {
        secret_door_button[ secret_door_button.size ] = var_13be61a4fe36f167;
        var_13be61a4fe36f167 thread function_a8988e779e155f32();
    }
    
    foreach ( secret_door in secret_doors )
    {
        secret_door.target_pos_list = [];
        next_target = secret_door;
        
        while ( true )
        {
            if ( !isdefined( next_target.target ) )
            {
                break;
            }
            
            pos = utility::getstruct( next_target.target, "targetname" );
            
            if ( isdefined( pos ) )
            {
                secret_door.target_pos_list[ secret_door.target_pos_list.size ] = pos;
                next_target = pos;
                continue;
            }
            
            break;
        }
        
        secret_door thread secret_door_logic( secret_door_on_notify );
    }
}

// Namespace mp_sat_sm_nexus
// Params 3
// Checksum 0xc63898e2, Offset: 0xac3
// Size: 0x1d1
function function_b4c272a86a25f88f( var_8c51d11f9126b2fd, button_cooldown, var_e3a24a061f88b0cf )
{
    level endon( #"game_ended" );
    var_455207c226282e7a = level.prematchperiodend <= 0;
    
    if ( game_utility_mp::isfirstround() && !var_455207c226282e7a )
    {
        level waittill( #"match_start_real_countdown" );
    }
    
    while ( true )
    {
        level waittill( "activate_" + self.script_noteworthy, e_player );
        
        foreach ( button in var_e3a24a061f88b0cf )
        {
            if ( isdefined( button.custom ) )
            {
                button setusableenabled( 0 );
                continue;
            }
            
            button setscriptablepartstate( "arcwire_transmitter", "activate" );
            button.sound_ent playsound( "sfx_mp_t10_runway_conveyor_button_push" );
        }
        
        if ( isplayer( e_player ) )
        {
            self.e_attacker = e_player;
        }
        
        level notify( var_8c51d11f9126b2fd );
        wait button_cooldown;
        
        foreach ( button in var_e3a24a061f88b0cf )
        {
            if ( isdefined( button.custom ) )
            {
                button setusableenabled( 1 );
                continue;
            }
            
            button setscriptablepartstate( "arcwire_transmitter", "standby" );
        }
    }
}

// Namespace mp_sat_sm_nexus
// Params 6, eflags: 0x4
// Checksum 0x6eec62d7, Offset: 0xc9c
// Size: 0x5d
function private button_used( e_instance, str_part, str_state, e_player, b_auto_use, str_use_string )
{
    button = e_instance;
    level notify( "activate_" + button.script_noteworthy, e_player );
}

// Namespace mp_sat_sm_nexus
// Params 4, eflags: 0x4
// Checksum 0xca9da6ba, Offset: 0xd01
// Size: 0x4b
function private function_cd7ee8ecd49d8052( e_instance, var_fbe21110104b5926, var_acc7ae5f813fa77e, var_533710b0b76c405a )
{
    button = e_instance;
    level notify( "activate_" + button.script_noteworthy, var_533710b0b76c405a );
}

// Namespace mp_sat_sm_nexus
// Params 0
// Checksum 0x2cac5da5, Offset: 0xd54
// Size: 0xc5
function function_a8988e779e155f32()
{
    level endon( #"game_ended" );
    timer = 6;
    self makeusable();
    self setusableenabled( 1 );
    thread string_watcher( timer );
    self setcursorhint( "HINT_BUTTON" );
    self sethintdisplayrange( 110 );
    self sethintdisplayfov( 270 );
    self setuserange( 60 );
    self setusefov( 250 );
    self sethintonobstruction( "show" );
    self.custom = 1;
    
    while ( true )
    {
        self waittill( #"trigger" );
        level notify( "activate_" + self.script_noteworthy );
        
        if ( isdefined( self.script_label ) )
        {
            if ( self.script_label == "book" )
            {
                thread move_book();
            }
        }
        
        wait timer;
    }
}

// Namespace mp_sat_sm_nexus
// Params 0
// Checksum 0xac6f2f8b, Offset: 0xe21
// Size: 0x69
function move_book()
{
    level endon( #"game_ended" );
    self rotateto( self.angles + ( 0, 0, 20 ), 0.75, 0.25, 0.25 );
    wait 1;
    self rotateto( self.angles - ( 0, 0, 20 ), 0.75, 0.25, 0.25 );
}

// Namespace mp_sat_sm_nexus
// Params 1
// Checksum 0xa355b8eb, Offset: 0xe92
// Size: 0x88
function string_watcher( timer )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self sethintstring( &"mp/door_use_open" );
        self setusableenabled( 1 );
        level waittill( "activate_" + self.script_noteworthy );
        self setusableenabled( 0 );
        wait timer;
        self sethintstring( &"mp/door_use_close" );
        self setusableenabled( 1 );
        level waittill( "activate_" + self.script_noteworthy );
        self setusableenabled( 0 );
        wait timer;
    }
}

// Namespace mp_sat_sm_nexus
// Params 3
// Checksum 0xa61fbefc, Offset: 0xf22
// Size: 0x9e
function dam_logic( move_time, dam_cooldown, dam_on_notify )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( dam_on_notify );
        self moveto( self.target_pos_ent.origin, move_time );
        playsoundatpos( ( -757.63, -1729.42, 622.12 ), "evt_nexus_dam_open" );
        wait dam_cooldown;
        level waittill( dam_on_notify );
        self moveto( self.start_pos, move_time );
        playsoundatpos( ( -757.63, -1729.42, 622.12 ), "evt_nexus_dam_close" );
        wait dam_cooldown;
    }
}

// Namespace mp_sat_sm_nexus
// Params 1
// Checksum 0x38ff4e0f, Offset: 0xfc8
// Size: 0xcb
function function_8a3bc837e2a8e948( dam_on_notify )
{
    level endon( #"game_ended" );
    offset = 0;
    maxoffset = 0;
    minoffset = -36;
    var_51f8199c5ea550b9 = 2;
    ticktime = 0.05;
    function_f3a6772c8b060a41( minoffset );
    offset = minoffset;
    thread water_level_screen( dam_on_notify );
    
    while ( true )
    {
        level waittill( dam_on_notify );
        activateworldevent( "water_rising_lights" );
        
        while ( offset <= maxoffset )
        {
            offset += var_51f8199c5ea550b9 * ticktime;
            function_f3a6772c8b060a41( offset );
            wait ticktime;
        }
        
        level waittill( dam_on_notify );
        deactivateworldevent( "water_rising_lights" );
        
        while ( offset >= minoffset )
        {
            offset -= var_51f8199c5ea550b9 * ticktime;
            function_f3a6772c8b060a41( offset );
            wait ticktime;
        }
    }
}

// Namespace mp_sat_sm_nexus
// Params 1
// Checksum 0x9451da5d, Offset: 0x109b
// Size: 0x86
function water_level_screen( dam_on_notify )
{
    screen = utility::function_30dbabe3200518b( "water_level", "targetname" );
    
    while ( true )
    {
        level waittill( dam_on_notify );
        screen setscriptablepartstate( "screen", "low_to_high" );
        wait 9;
        screen setscriptablepartstate( "screen", "high" );
        level waittill( dam_on_notify );
        screen setscriptablepartstate( "screen", "low_to_high" );
        wait 9;
        screen setscriptablepartstate( "screen", "low" );
    }
}

// Namespace mp_sat_sm_nexus
// Params 1
// Checksum 0xfbd4c936, Offset: 0x1129
// Size: 0x2db
function function_851b7b95c5548747( vac_bot_speed )
{
    level endon( #"game_ended" );
    self endon( #"destroyed" );
    
    if ( !isnavmeshloaded() )
    {
        return;
    }
    
    forward_pos = getent( self.target, "targetname" );
    forward_pos linkto( self );
    limit = getent( self.script_noteworthy, "targetname" );
    end = utility::getstruct( self.target, "targetname" );
    var_8670c8edd5bd297e = self.origin;
    inverter = 1;
    self playloopsound( "amb_emt_robot_vacuum_motor_lp" );
    
    while ( true )
    {
        obj_point = getclosestpointonnavmesh( forward_pos.origin );
        
        if ( ispointinvolume( obj_point, limit ) )
        {
            self moveto( ( obj_point[ 0 ], self.origin[ 1 ], self.origin[ 2 ] ), vac_bot_speed );
            wait vac_bot_speed;
        }
        
        if ( 5 >= distance( self.origin, var_8670c8edd5bd297e ) )
        {
            self rotateby( ( 0, inverter * 90, 0 ), vac_bot_speed, vac_bot_speed / 3, vac_bot_speed / 3 );
            wait vac_bot_speed;
            obj_point = getclosestpointonnavmesh( forward_pos.origin );
            self moveto( ( self.origin[ 0 ], obj_point[ 1 ], self.origin[ 2 ] ), vac_bot_speed, vac_bot_speed / 3, vac_bot_speed / 3 );
            wait vac_bot_speed;
            self rotateby( ( 0, inverter * 90, 0 ), vac_bot_speed, vac_bot_speed / 3, vac_bot_speed / 3 );
            wait vac_bot_speed;
            inverter *= -1;
            continue;
        }
        
        if ( isdefined( end ) )
        {
            if ( 20 >= distance( self.origin, end.origin ) )
            {
                obj_point = end.origin;
                self moveto( ( obj_point[ 0 ], self.origin[ 1 ], self.origin[ 2 ] ), vac_bot_speed );
                self rotateto( end.angles, vac_bot_speed );
                wait vac_bot_speed;
                obj_point = utility::getstruct( end.target, "targetname" );
                
                while ( true )
                {
                    if ( isdefined( obj_point ) )
                    {
                        self moveto( ( obj_point.origin[ 0 ], obj_point.origin[ 1 ], self.origin[ 2 ] ), 2 );
                        wait 2;
                        self rotateto( obj_point.angles, 2 );
                        wait 2;
                        
                        if ( isdefined( obj_point.script_noteworthy ) )
                        {
                            wait int( obj_point.script_noteworthy );
                        }
                        
                        if ( isdefined( obj_point.target ) )
                        {
                            obj_point = utility::getstruct( obj_point.target, "targetname" );
                        }
                        else
                        {
                            obj_point = undefined;
                        }
                        
                        continue;
                    }
                    
                    break;
                }
            }
        }
        
        var_8670c8edd5bd297e = self.origin;
    }
}

// Namespace mp_sat_sm_nexus
// Params 0
// Checksum 0xe2d898a8, Offset: 0x140c
// Size: 0xa5
function damage_watcher()
{
    forward_pos = getent( self.target, "targetname" );
    self setcandamage( 1 );
    self waittill( #"damage" );
    self notify( #"destroyed" );
    playfxontag( utility::getfx( "robot_vacuum_death" ), self, "tag_origin" );
    self stoploopsound( "amb_emt_robot_vacuum_motor_lp" );
    self playsoundonmovingent( "dst_vacume_robot" );
    obj_point = getclosestpointonnavmesh( forward_pos.origin );
    self moveto( ( obj_point[ 0 ], obj_point[ 1 ], self.origin[ 2 ] ), 2, 0, 2 );
}

// Namespace mp_sat_sm_nexus
// Params 1
// Checksum 0xefcab352, Offset: 0x14b9
// Size: 0x150
function secret_door_logic( secret_door_on_notify )
{
    level endon( #"game_ended" );
    index = 0;
    
    while ( index < self.target_pos_list.size - 1 )
    {
        index++;
        self moveto( self.target_pos_list[ index ].origin, 3 );
        waitframe();
    }
    
    if ( isdefined( self.navmodifier ) )
    {
    }
    
    for ( var_828cbde1a34a8101 = createnavobstaclebyent( self.navmodifier ); true ; var_828cbde1a34a8101 = createnavobstaclebyent( self.navmodifier ) )
    {
        level waittill( secret_door_on_notify );
        self playsoundonmovingent( "evt_nexus_sliding_doors_close" );
        
        while ( index > 0 )
        {
            index--;
            self moveto( self.target_pos_list[ index ].origin, 3, 1.5, 1.5 );
            wait 3;
        }
        
        if ( isdefined( var_828cbde1a34a8101 ) )
        {
            destroynavobstacle( var_828cbde1a34a8101 );
        }
        
        level waittill( secret_door_on_notify );
        self playsoundonmovingent( "evt_nexus_sliding_doors_open" );
        
        while ( index < self.target_pos_list.size - 1 )
        {
            index++;
            self moveto( self.target_pos_list[ index ].origin, 3, 1.5, 1.5 );
            wait 3;
        }
        
        if ( isdefined( self.navmodifier ) )
        {
        }
    }
}

