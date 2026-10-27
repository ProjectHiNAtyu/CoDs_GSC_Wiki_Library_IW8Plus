// scripts\vehicle\pluto\zm_firefly_pluto_head.gsc  (hash_78c27ad5df83d2eb.gscc) (size: 12073 Bytes / 0x2f29 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9daaab89 (2645207945)
// size ...... 12073 (0x2f29)
// includes .. 11  (offset: 0x2be9)
// strings ... 45  (offset: 0x2c41)
// dev strs .. 2   (offset: 0x2f11)
// exports ... 31  (offset: 0x1c09)
// cseg ...... 0x398 + 0x1871 (0x1c09)
// imports ... 89  (offset: 0x20e1)
// animtree1 . 0   (offset: 0x2f29)
// animtree2 . 0   (offset: 0x2f29)
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\damagefeedback;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_utility;

#namespace pluto_veh;

// Namespace pluto_veh
// Params 0
// Checksum 0x71093ca8, Offset: 0x3b6
// Size: 0x132
function function_5314152f5e207d3b()
{
    if ( !level utility::flag( "tedd_attached" ) )
    {
        self.tedd setcandamage( 1 );
        thread tedd_damage_watcher();
        
        /#
            thread function_acded21445342571();
        #/
        
        level callback::add( #"player_vehicle_enter", &function_66dde831fae84340 );
        level callback::add( #"player_vehicle_exit", &function_b1c63cc542f931a );
        level callback::add( "zone_changed", &function_b4cb95c2e8c2f0a7 );
        level callback::add( #"on_ai_killed", &function_d00ccbea4199558 );
        level callback::add( #"hash_e23b3890b0905641", &function_495548a7b8c621b6 );
        level callback::add( #"hash_e90d235499f4f420", &function_f057dcd8ab7b2bb3 );
        thread function_61e3496150dd4214();
        thread function_eca325e05eaef028();
        self.var_99fbc58176c3156c = zm_quest::function_91f9590e98d57ff6( self.origin, undefined, &function_400ca66fe6b78899, "large" );
        self.var_99fbc58176c3156c.var_f723d74c2701f8c3 = 0;
        self.var_99fbc58176c3156c utility::scriptable_setparententity( self, ( 0, 0, 50 ) );
        self.var_99fbc58176c3156c function_7653c765b6c7b815();
        level utility::flag_set( "tedd_attached" );
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x92f14aa5, Offset: 0x4f0
// Size: 0x191
function private tedd_damage_watcher()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.tedd.health = 200;
    self.tedd.var_39ebff52690e88ee = 0;
    
    while ( true )
    {
        self.tedd waittill( #"damage", damage, attacker, direction_vec, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin );
        
        if ( isplayer( attacker ) && !( meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_GRENADE_SPLASH" ) )
        {
            if ( self.tedd utility::ent_flag( "angry_tedd_in_progress" ) )
            {
                attacker damagefeedback::updatehitmarker( "standard", undefined, undefined, 0, undefined );
                continue;
            }
            
            self.tedd.health -= damage;
            attacker damagefeedback::updatehitmarker( "standard", self.tedd.health <= 0, undefined, 0, undefined );
            
            if ( self.tedd.health <= 0 )
            {
                thread function_abcca32e92283f39( attacker );
            }
        }
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x266aa36f, Offset: 0x689
// Size: 0x12a
function private function_abcca32e92283f39( attacker )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.tedd utility::ent_flag_set( "angry_tedd_in_progress" );
    
    if ( self.tedd.var_39ebff52690e88ee == 0 )
    {
        thread function_f9ed0493c24c7c1b();
    }
    
    self.tedd.var_39ebff52690e88ee++;
    thread function_24ef8a939564ad86();
    
    if ( self.tedd.var_39ebff52690e88ee >= 5 )
    {
        function_7157befab060e403( attacker );
    }
    else
    {
        function_d1c73e65446b897a( attacker );
    }
    
    self.tedd.health = 200;
    self.tedd notify( #"hash_14966f1ee9853de9" );
    self.tedd setscriptablepartstate( "body", "default" );
    self.tedd function_df5739f0bfd07279( ( 0, 0, 0 ), 1 );
    self.tedd waittill( #"rotatedone" );
    self.tedd utility::ent_flag_clear( "angry_tedd_in_progress" );
}

// Namespace pluto_veh
// Params 0, eflags: 0xc
// Checksum 0x88e7ae08, Offset: 0x7bb
// Size: 0x7a
function private function_f9ed0493c24c7c1b()
{
    self notify( #"hash_a10d2ad5f1dcc48a" );
    self endon( #"hash_a10d2ad5f1dcc48a" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_7420958ea1826ac" );
    time = 0;
    
    while ( true )
    {
        if ( time >= 60 )
        {
            time = 0;
            self.tedd.var_39ebff52690e88ee = 0;
            return;
        }
        
        time++;
        wait 1;
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x64972c3e, Offset: 0x83d
// Size: 0x4d
function private function_d1c73e65446b897a( attacker )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    thread function_7e9b262a46543a03( attacker );
    function_26b3cc04f515132c( #"hash_7bc6e6d3c209b9f6" );
    wait 3;
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xbcfecdc2, Offset: 0x892
// Size: 0xd4
function private function_24ef8a939564ad86()
{
    thread function_50446efb850a897c();
    self.tedd setscriptablepartstate( "body", "angry" );
    self.tedd movetolinked( ( 0, 0, 2 ), 0.25, 0.2 );
    self.tedd function_f137e973856d34d9( ( 0, 360, 0 ), 0.5, 0.1, 0.3 );
    self.tedd waittill( #"movedone" );
    self.tedd movetolinked( ( 0, 0, 0 ), 0.25, 0, 0.1 );
    self.tedd waittill( #"movedone" );
    self.tedd notify( #"done_spinning" );
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x76ee411, Offset: 0x96e
// Size: 0x7b
function private function_50446efb850a897c()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    utility::ent_flag_set( "tedd_angry_lights" );
    function_7bf6a899c103af99();
    
    for ( i = 0; i < 3 ; i++ )
    {
        function_b68c61fd11774f2a();
        wait 0.15;
        function_8f223ee890499e14();
        wait 0.25;
    }
    
    wait 0.4;
    utility::ent_flag_clear( "tedd_angry_lights" );
    function_80fd264567645bb1();
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xffabb104, Offset: 0x9f1
// Size: 0xa0
function private function_80fd264567645bb1()
{
    if ( self.var_5a9b5363aafb3d3d )
    {
        self setscriptablepartstate( "tag_light_back_left", "on" );
        self setscriptablepartstate( "tag_light_back_right", "on" );
    }
    else
    {
        self setscriptablepartstate( "tag_light_back_left", "off" );
        self setscriptablepartstate( "tag_light_back_right", "off" );
    }
    
    if ( self.enginelightson )
    {
        self setscriptablepartstate( "tag_light_front_left", "on" );
        self setscriptablepartstate( "tag_light_front_right", "on" );
        return;
    }
    
    self setscriptablepartstate( "tag_light_front_left", "off" );
    self setscriptablepartstate( "tag_light_front_right", "off" );
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x8d0728c1, Offset: 0xa99
// Size: 0x22
function private function_b68c61fd11774f2a()
{
    self setscriptablepartstate( "tag_light_front_left", "off" );
    self setscriptablepartstate( "tag_light_front_right", "off" );
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x275dccf3, Offset: 0xac3
// Size: 0x22
function private function_8f223ee890499e14()
{
    self setscriptablepartstate( "tag_light_front_left", "on_angry" );
    self setscriptablepartstate( "tag_light_front_right", "on" );
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x99f3e9f, Offset: 0xaed
// Size: 0x22
function private function_7bf6a899c103af99()
{
    self setscriptablepartstate( "tag_light_back_left", "on" );
    self setscriptablepartstate( "tag_light_back_right", "on" );
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x6a1ea786, Offset: 0xb17
// Size: 0x22
function private function_80e36c07b91428f5()
{
    self setscriptablepartstate( "tag_light_back_left", "off" );
    self setscriptablepartstate( "tag_light_back_right", "off" );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x85b5086b, Offset: 0xb41
// Size: 0x126
function private function_7157befab060e403( attacker )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    attacker endon( #"death_or_disconnect" );
    utility::ent_flag_set( "tedd_eject_player_in_progress" );
    thread function_7e9b262a46543a03( attacker );
    seatid = vehicle_occupancy::get_occupant_seat( self, attacker );
    
    if ( isdefined( seatid ) )
    {
        data = { #exittype:"INVOLUNTARY", #allowairexit:1 };
        level thread vehicle_occupancy::exit( self, seatid, attacker, data, 1 );
        attacker thread function_e39c6e6fdbec5224();
    }
    else
    {
        moving_platform = attacker getmovingplatformparent();
        
        if ( moving_platform == self )
        {
            /#
                iprintlnbold( "<dev string:x2f>" );
            #/
            
            attacker thread function_e39c6e6fdbec5224();
        }
    }
    
    thread function_4a0e186b1b06aeb0( attacker );
    self.tedd.var_39ebff52690e88ee = 0;
    self notify( #"hash_7420958ea1826ac" );
    self setscriptablepartstate( "angry_head", "angry_eject" );
    function_26b3cc04f515132c( #"hash_7019af2da1834a" );
    wait 2;
    utility::ent_flag_clear( "tedd_eject_player_in_progress" );
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x4e92312c, Offset: 0xc6f
// Size: 0xe6
function private function_7e9b262a46543a03( player )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    self.tedd endon( #"hash_14966f1ee9853de9" );
    self.tedd waittill( #"done_spinning" );
    
    while ( true )
    {
        angles_to_player = vectortoangles( vectornormalize( self.tedd.origin - player.origin ) );
        angles_to_player = ( 0, angles_to_player[ 1 ], 0 );
        vehicle_yaw = self.angles[ 1 ];
        local_angles = ( 0, angles_to_player[ 1 ] - vehicle_yaw, 0 );
        self.tedd function_df5739f0bfd07279( local_angles, 0.3 );
        self.tedd waittill( #"rotatedone" );
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0xc1bf9399, Offset: 0xd5d
// Size: 0xeb
function private function_e39c6e6fdbec5224()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isplayer( self ) || self.inlaststand )
    {
        return;
    }
    
    gestureref = "vm_ges_shockstick_react";
    curweapon = self getcurrentweapon();
    
    if ( weapon::isfistweapon( curweapon ) )
    {
        gestureref = "vm_ges_shockstick_react_fists";
    }
    
    while ( !self isgestureplaying( gestureref ) )
    {
        self forceplaygestureviewmodel( gestureref );
        waitframe();
    }
    
    shock_stick::function_904e61c3aefb61c2( 1 );
    self setscriptablepartstate( "shockStickVfx", "vfx_start", 0 );
    shock_stick::function_ef03efbecb279b8a( 1 );
    self setmovespeedscale( 0.8 );
    self setempjammed( 1 );
    wait 3;
    shock_stick::function_904e61c3aefb61c2( 0 );
    self stopgestureviewmodel( gestureref );
    self setscriptablepartstate( "shockStickVfx", "off", 0 );
    shock_stick::function_ef03efbecb279b8a( 0 );
    self setmovespeedscale( 1 );
    self setempjammed( 0 );
}

// Namespace pluto_veh
// Params 1, eflags: 0xc
// Checksum 0xc14bf4a6, Offset: 0xe50
// Size: 0xab
function private function_4a0e186b1b06aeb0( attacker )
{
    self notify( #"hash_7e8b7534a8bb956b" );
    self endon( #"hash_7e8b7534a8bb956b" );
    level endon( #"game_ended" );
    self endon( #"death" );
    attacker endon( #"death_or_disconnect" );
    attacker val::set( "veh_pluto_head", "vehicle_use", 0 );
    self.var_99fbc58176c3156c.var_f723d74c2701f8c3 = gettime();
    self.var_99fbc58176c3156c enablescriptableplayeruse( attacker );
    wait 8;
    attacker val::reset( "veh_pluto_head", "vehicle_use" );
    self.var_99fbc58176c3156c disablescriptableplayeruse( attacker );
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0x4776c14c, Offset: 0xf03
// Size: 0x73
function private function_400ca66fe6b78899( interact, player )
{
    timeleft = int( ceil( 0.001 * ( interact.var_f723d74c2701f8c3 - gettime() ) ) + 8 );
    return { #params:[ timeleft ], #string:&"zm_sat_firefly/pluto_kicked_out", #type:"HINT_NOBUTTON" };
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0x85874da9, Offset: 0xf7f
// Size: 0x155
function private function_26b3cc04f515132c( snd_event, var_376e5ca02b2e31fc = 0 )
{
    veh = self;
    level endon( #"game_ended" );
    veh endon( #"death" );
    
    if ( !veh.tedd )
    {
        return 0;
    }
    
    foreach ( flag in level.var_bbe2ae9963c25f75 )
    {
        if ( level utility::flag( flag ) )
        {
            return 0;
        }
    }
    
    if ( var_376e5ca02b2e31fc )
    {
        level utility::flag_waitopen( "tedd_vo_active" );
        level utility::flag_set( "tedd_vo_active" );
        level zm_quest::function_8934bb2a9028bdc5();
    }
    else
    {
        if ( level utility::flag( "tedd_vo_active" ) || zm_quest::is_vo_active() )
        {
            return 0;
        }
        
        level utility::flag_set( "tedd_vo_active" );
    }
    
    var_db75d3de862ce072 = veh.tedd dialogue::say( snd_event, undefined, undefined, undefined, undefined, undefined, 1 );
    level utility::flag_clear( "tedd_vo_active" );
    return var_db75d3de862ce072;
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x5c97463d, Offset: 0x10dd
// Size: 0x12b
function private function_66dde831fae84340( params )
{
    level endon( #"game_ended" );
    params.vehicle endon( #"death" );
    
    if ( !level utility::flag( "pap_hint_vo_played" ) )
    {
        return;
    }
    
    veh = params.vehicle;
    
    if ( veh.occupants.size == 1 )
    {
        curr_time = gettime();
        
        if ( !veh.tedd.var_58346383f47c5990 || curr_time - veh.tedd.var_58346383f47c5990 >= utility::function_4b74c15943231980( 60 ) )
        {
            if ( utility::percent_chance( 25 ) )
            {
                if ( zm_vo::is_tedd() && utility::percent_chance( 50 ) )
                {
                    veh.tedd.var_58346383f47c5990 = curr_time;
                    veh function_26b3cc04f515132c( #"hash_e0f60dd36aa902fc" );
                    return;
                }
                
                veh.tedd.var_58346383f47c5990 = curr_time;
                veh function_26b3cc04f515132c( #"hash_b35d7cbfc0191b67" );
            }
        }
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0xf1b7fbe2, Offset: 0x1210
// Size: 0x140
function private function_b1c63cc542f931a( params )
{
    level endon( #"game_ended" );
    params.vehicle endon( #"death" );
    veh = params.vehicle;
    
    if ( veh.occupants.size == 0 && veh getscriptablepartstate( "plutoDamage" ) != "enabled" && !veh utility::ent_flag( "tedd_eject_player_in_progress" ) )
    {
        curr_time = gettime();
        
        if ( !veh.tedd.var_bb41d1f7baa81994 || curr_time - veh.tedd.var_bb41d1f7baa81994 >= utility::function_4b74c15943231980( 60 ) )
        {
            if ( utility::percent_chance( 25 ) )
            {
                if ( zm_vo::is_tedd() && utility::percent_chance( 50 ) )
                {
                    veh.tedd.var_bb41d1f7baa81994 = curr_time;
                    veh function_26b3cc04f515132c( #"hash_7482bed3be51bb83" );
                    return;
                }
                
                veh.tedd.var_bb41d1f7baa81994 = curr_time;
                veh function_26b3cc04f515132c( #"hash_b39758bfc04a5682" );
            }
        }
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x1d0634a5, Offset: 0x1358
// Size: 0x1d9
function private function_b4cb95c2e8c2f0a7( params )
{
    level endon( #"game_ended" );
    level.wonder_veh endon( #"death" );
    veh = level.wonder_veh;
    
    if ( veh.occupants[ "driver" ] == self && params.previous_zone_struct )
    {
        prev_zone_name = params.previous_zone_struct.script_zone_name;
        new_zone_name = params.zone_struct.script_zone_name;
        var_db75d3de862ce072 = function_4bff5f27f63a7983( prev_zone_name, new_zone_name, "zone_jplaza", veh.tedd.var_7c0c7bfe5c18c293, #"hash_a248c856072eb0c4" );
        
        if ( !isdefined( var_db75d3de862ce072 ) )
        {
            var_db75d3de862ce072 = function_4bff5f27f63a7983( prev_zone_name, new_zone_name, "zone_farm", veh.tedd.var_3d3b5e288490053a, #"hash_fa1973d378a8fb8c" );
        }
        
        if ( !isdefined( var_db75d3de862ce072 ) )
        {
            var_db75d3de862ce072 = function_4bff5f27f63a7983( prev_zone_name, new_zone_name, "zone_lakefront", veh.tedd.var_5b051790c33730a0, #"hash_a25dba560740f504" );
        }
        
        if ( !isdefined( var_db75d3de862ce072 ) )
        {
            var_db75d3de862ce072 = function_4bff5f27f63a7983( prev_zone_name, new_zone_name, "zone_sunken", veh.tedd.var_48415391ddae7566, #"hash_a267be5607495055" );
        }
        
        if ( !isdefined( var_db75d3de862ce072 ) )
        {
            var_db75d3de862ce072 = function_4bff5f27f63a7983( prev_zone_name, new_zone_name, "zone_launchpad", veh.tedd.var_c9c2279ef11c5e56, #"hash_a25dc85607410cce" );
        }
        
        if ( !isdefined( var_db75d3de862ce072 ) )
        {
            var_db75d3de862ce072 = function_4bff5f27f63a7983( prev_zone_name, new_zone_name, "zone_exit115", veh.tedd.var_9a9db8237a99d8e3, #"hash_8849a27c8452bdfa" );
        }
    }
}

// Namespace pluto_veh
// Params 5, eflags: 0x4
// Checksum 0x599ebd0a, Offset: 0x1539
// Size: 0xfe
function private function_4bff5f27f63a7983( prev_zone_name, new_zone_name, zone_substring, last_time_vo_played, sound_alias )
{
    level endon( #"game_ended" );
    level.wonder_veh endon( #"death" );
    veh = level.wonder_veh;
    last_time_vo_played = function_6f322fe1a908bf68( veh, zone_substring );
    
    if ( !issubstr( prev_zone_name, zone_substring ) && issubstr( new_zone_name, zone_substring ) )
    {
        curr_time = gettime();
        
        if ( !last_time_vo_played || curr_time - last_time_vo_played >= utility::function_4b74c15943231980( 180 ) )
        {
            if ( !level utility::flag( "tedd_arrival_" + zone_substring + "_vo_played" ) || utility::percent_chance( 25 ) )
            {
                level utility::flag_set( "tedd_arrival_" + zone_substring + "_vo_played" );
                function_f6c565fa762ad6a4( veh, zone_substring, curr_time );
                veh function_26b3cc04f515132c( sound_alias );
                return 1;
            }
        }
    }
}

// Namespace pluto_veh
// Params 2, eflags: 0x4
// Checksum 0x9d323c8e, Offset: 0x1640
// Size: 0x10f
function private function_6f322fe1a908bf68( veh, zone_substring )
{
    switch ( zone_substring )
    {
        case #"hash_ab09fc027d603c90":
            last_time_vo_played = veh.tedd.var_7c0c7bfe5c18c293;
            break;
        case #"hash_1df2d741d62467bc":
            last_time_vo_played = veh.tedd.var_3d3b5e288490053a;
            break;
        case #"hash_acbd34ed2971c492":
            last_time_vo_played = veh.tedd.var_5b051790c33730a0;
            break;
        case #"hash_fe20c6654f902798":
            last_time_vo_played = veh.tedd.var_48415391ddae7566;
            break;
        case #"hash_4bf5793e36a85ac":
            last_time_vo_played = veh.tedd.var_c9c2279ef11c5e56;
            break;
        case #"hash_38504856dff2ea41":
            last_time_vo_played = veh.tedd.var_9a9db8237a99d8e3;
            break;
    }
    
    return last_time_vo_played;
}

// Namespace pluto_veh
// Params 3, eflags: 0x4
// Checksum 0x6ed3942, Offset: 0x1758
// Size: 0x112
function private function_f6c565fa762ad6a4( veh, zone_substring, time )
{
    switch ( zone_substring )
    {
        case #"hash_ab09fc027d603c90":
            veh.tedd.var_7c0c7bfe5c18c293 = time;
            break;
        case #"hash_1df2d741d62467bc":
            veh.tedd.var_3d3b5e288490053a = time;
            break;
        case #"hash_acbd34ed2971c492":
            veh.tedd.var_5b051790c33730a0 = time;
            break;
        case #"hash_fe20c6654f902798":
            veh.tedd.var_48415391ddae7566 = time;
            break;
        case #"hash_4bf5793e36a85ac":
            veh.tedd.var_c9c2279ef11c5e56 = time;
            break;
        case #"hash_38504856dff2ea41":
            veh.tedd.var_9a9db8237a99d8e3 = time;
            break;
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x59b37c02, Offset: 0x1872
// Size: 0x133
function private function_d00ccbea4199558( params )
{
    level endon( #"game_ended" );
    level.wonder_veh endon( #"death" );
    
    if ( level utility::flag( "playing_first_time_kill_callisto_vo" ) || level utility::flag( "playing_first_time_kill_shade_vo" ) || level utility::flag( "playing_zm_vehicle_kill_scoreevent_vo" ) )
    {
        return;
    }
    
    if ( isai( self ) && self.team == zm_utility::get_zombie_team() && params.einflictor == level.wonder_veh )
    {
        if ( utility::percent_chance( 15 ) )
        {
            curr_time = gettime();
            
            if ( !level.wonder_veh.tedd.var_12dbb476994c7aea || curr_time - level.wonder_veh.tedd.var_12dbb476994c7aea >= utility::function_4b74c15943231980( 60 ) )
            {
                level.wonder_veh.tedd.var_12dbb476994c7aea = curr_time;
                level.wonder_veh function_26b3cc04f515132c( #"hash_c71b87d35c0dc9b2" );
            }
        }
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x35b87960, Offset: 0x19ad
// Size: 0x31
function private function_495548a7b8c621b6( params )
{
    if ( params.soundtype == #"bc_scoreevent_zm_vehilcekill" )
    {
        level utility::flag_set( "playing_zm_vehicle_kill_scoreevent_vo" );
    }
}

// Namespace pluto_veh
// Params 1, eflags: 0x4
// Checksum 0x6ef65d12, Offset: 0x19e6
// Size: 0x31
function private function_f057dcd8ab7b2bb3( params )
{
    if ( params.soundtype == #"bc_scoreevent_zm_vehilcekill" )
    {
        level utility::flag_clear( "playing_zm_vehicle_kill_scoreevent_vo" );
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x819db0c8, Offset: 0x1a1f
// Size: 0xd6
function private function_61e3496150dd4214()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        curr_time = gettime();
        
        if ( self.occupants.size > 0 )
        {
            if ( self vehicle_getspeed() > 0 )
            {
                var_a678852b008b079f = curr_time;
            }
            
            if ( var_a678852b008b079f && curr_time - var_a678852b008b079f >= utility::function_4b74c15943231980( 60 ) )
            {
                if ( !self.tedd.var_d74bcb6aa9ea22fe || curr_time - self.tedd.var_d74bcb6aa9ea22fe >= utility::function_4b74c15943231980( 300 ) )
                {
                    self.tedd.var_d74bcb6aa9ea22fe = curr_time;
                    function_26b3cc04f515132c( #"hash_10b0d8918c6022ab" );
                }
            }
        }
        else
        {
            var_a678852b008b079f = curr_time;
        }
        
        waitframe();
    }
}

// Namespace pluto_veh
// Params 0, eflags: 0x4
// Checksum 0x104ba14d, Offset: 0x1afd
// Size: 0xb8
function private function_eca325e05eaef028()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( self.occupants.size > 0 )
        {
            if ( !self vehicle_isonground() && utility::percent_chance( 25 ) )
            {
                curr_time = gettime();
                
                if ( !self.tedd.var_7b5b9517d9df5e4e || curr_time - self.tedd.var_7b5b9517d9df5e4e >= utility::function_4b74c15943231980( 300 ) )
                {
                    self.tedd.var_7b5b9517d9df5e4e = curr_time;
                    function_26b3cc04f515132c( #"hash_b39a6bbfc04caca2" );
                }
            }
        }
        
        waitframe();
    }
}

/#

    // Namespace pluto_veh
    // Params 0, eflags: 0x4
    // Checksum 0x5f79bb0c, Offset: 0x1bbd
    // Size: 0x4c, Type: dev
    function private function_acded21445342571()
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_ef2f5254eb1a7add" ) )
            {
                thread function_24ef8a939564ad86();
                setdvar( @"hash_ef2f5254eb1a7add", 0 );
            }
            
            waitframe();
        }
    }

#/
