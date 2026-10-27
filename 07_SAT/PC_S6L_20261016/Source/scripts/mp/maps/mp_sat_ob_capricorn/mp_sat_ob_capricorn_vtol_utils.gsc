// scripts\mp\maps\mp_sat_ob_capricorn\mp_sat_ob_capricorn_vtol_utils.gsc  (hash_19f348fd45897bb3.gscc) (size: 18674 Bytes / 0x48f2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd5a34afe (3584248574)
// size ...... 18674 (0x48f2)
// includes .. 18  (offset: 0x4632)
// strings ... 41  (offset: 0x46c2)
// dev strs .. 0   (offset: 0x48f2)
// exports ... 37  (offset: 0x302a)
// cseg ...... 0x351 + 0x2cd9 (0x302a)
// imports ... 135 (offset: 0x35f2)
// animtree1 . 0   (offset: 0x48f2)
// animtree2 . 0   (offset: 0x48f2)
#using script_2304453c69e996e2;
#using script_3455b106458253e7;
#using script_3ec57c71b0b61f00;
#using script_636bd827a012af12;
#using script_6e05fdc2c6f5fa06;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\ai\ai_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\ob\activities\ob_activity_gunship_heli;
#using scripts\mp\ob\activities\ob_activity_heli_takedown;
#using scripts\mp\ob\systems\weapons\ob_damage;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;

#namespace mp_sat_ob_capricorn_vtol_utils;

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 1
// Checksum 0x53110e85, Offset: 0x36f
// Size: 0x37d
function function_f49ccfbbc71553fd( target )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    
    if ( !isdefined( target ) )
    {
        return;
    }
    
    self.playertarget = target;
    childthread function_496838ff66182e37();
    childthread function_db44033aea50eaad();
    childthread function_a196f20a9f739378();
    self.var_a91376b02be4b323 = undefined;
    self.shouldshoot = 1;
    self.var_7d1f6ca04002be2c = 0;
    
    if ( self.attackcounter >= self.var_870d2c8a0d634a5e )
    {
        self.currentstate = "bombing_run";
        self notify( #"state_change" );
    }
    else if ( self.attackcounter == 0 )
    {
        self.var_870d2c8a0d634a5e = randomintrange( 3, 3 );
    }
    
    while ( true )
    {
        while ( self.canreposition )
        {
            waitframe();
        }
        
        if ( level utility::flag_exist( "flag_step_plant_emp_started" ) )
        {
            return;
        }
        
        self setturrettargetvec( self.playertarget.origin );
        self setturretscriptcontrolled( 1, 0 );
        
        if ( function_7c6e2be476afb687( self.playertarget ) )
        {
            self.var_a91376b02be4b323 = undefined;
            function_da5f11bd012f3aac( self.playertarget );
            self.attackcounter++;
            is_missile_attack_enabled = getdvarint( @"hash_cffec8e232ed41ff", 1 ) && self.funcs[ "bombing_run" ];
            
            if ( is_missile_attack_enabled && self.attackcounter >= self.var_870d2c8a0d634a5e && !level.var_3d9fc7aa7b25b565.roof_boss.var_4fe9c7e216477665 )
            {
                self.currentstate = "bombing_run";
                self notify( #"state_change" );
            }
            
            wait level.var_99790c03689d056;
            randomplayers = arrayrandomize( level.players );
            
            foreach ( player in randomplayers )
            {
                if ( self.currenttarget == player.guid )
                {
                    continue;
                }
                
                cantarget = !( namespace_7161222aac9ca916::function_15ef53278f060bfe( player ) || player::isinlaststand( player ) );
                
                if ( cantarget )
                {
                    namespace_7161222aac9ca916::function_c585f17cc1fba955( player, 420 );
                    self.currenttarget = player.guid;
                    self.playertarget = self.threatlist[ self.currenttarget ].player;
                    break;
                }
            }
            
            self.canreposition = 1;
        }
        else
        {
            if ( !self.var_a91376b02be4b323 )
            {
                self.var_a91376b02be4b323 = gettime() + 3000;
            }
            
            if ( !function_3397c6ad45473a58() )
            {
                if ( gettime() > self.var_a91376b02be4b323 )
                {
                    self.canreposition = 1;
                    self.var_a91376b02be4b323 = undefined;
                }
            }
            else if ( self.currenttarget != target.guid )
            {
                self.playertarget = self.threatlist[ self.currenttarget ].player;
            }
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 1, eflags: 0x4
// Checksum 0x8a8b2f15, Offset: 0x6f4
// Size: 0x5e, Type: bool
function private function_7c6e2be476afb687( target )
{
    while ( length( self vehicle_getvelocity() ) * 0.056818 > 5 )
    {
        waitframe();
    }
    
    if ( namespace_7161222aac9ca916::chopper_canseetarget( target ) )
    {
        function_dd1f33638eed1c98( 0 );
        wait 0.1;
        self setscriptablepartstate( "turret_snd", "prefire_snd", 1 );
        wait level.var_146d94309e2e75bb;
        return true;
    }
    
    return false;
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 1, eflags: 0x4
// Checksum 0x995dde67, Offset: 0x75b
// Size: 0x42
function private function_da5f11bd012f3aac( target )
{
    ob_activity_gunship_heli::function_9cde1a77d22afe7f( self, 1 );
    shooting_duration = randomfloatrange( level.var_9275920438b54a87, level.var_9298800438db6aa9 );
    ob_activity_gunship_heli::function_86c1334ea4ea9021( target, shooting_duration );
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0, eflags: 0xc
// Checksum 0x1bbbe6b1, Offset: 0x7a5
// Size: 0x98
function private function_496838ff66182e37()
{
    self notify( #"hash_57e6787b170b4a19" );
    self endon( #"hash_57e6787b170b4a19" );
    current_speed = length( self vehicle_getvelocity() ) * 0.056818;
    
    if ( current_speed > 5 )
    {
        function_dd1f33638eed1c98( 1 );
    }
    
    while ( true )
    {
        cloaking_locked = self.var_49696bc140d789dc || !self.canreposition;
        
        if ( !cloaking_locked )
        {
            current_speed = length( self vehicle_getvelocity() ) * 0.056818;
            
            if ( current_speed > 5 )
            {
                function_dd1f33638eed1c98( 1 );
            }
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0, eflags: 0x4
// Checksum 0x60b6b53b, Offset: 0x845
// Size: 0x15a
function private function_db44033aea50eaad()
{
    while ( true )
    {
        if ( !self.strafing )
        {
            target = self.playertarget;
            
            if ( !target )
            {
                waitframe();
                continue;
            }
            
            contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 0, 0, 1, 1, 1, 0 );
            canseetarget = trace::ray_trace_passed( target.origin, self.origin, self.ignorelist, contentsoverride );
            var_994355e8fda85bfe = distance2dsquared( target.origin, self.origin ) < 2250000;
            abovemaxdistance = distance2dsquared( target.origin, self.origin ) > 20250000;
            var_74e53d893941ec4e = self.canreposition && ( abovemaxdistance || var_994355e8fda85bfe );
            
            if ( self.canreposition || var_74e53d893941ec4e )
            {
                if ( function_c13f4a854b7f6082( target, 3000, 8, randomint( 360 ) ) )
                {
                    self.canreposition = 0;
                    self.var_7d1f6ca04002be2c = 0;
                    self.shouldshoot = 1;
                }
            }
            else
            {
                self.var_7d1f6ca04002be2c = 0;
                self.shouldshoot = 1;
            }
        }
        
        wait 0.5;
    }
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0, eflags: 0x4
// Checksum 0x64e13dde, Offset: 0x9a7
// Size: 0xc2
function private function_a196f20a9f739378()
{
    searching_time_start = gettime();
    var_2c08a47f9e1e8b36 = 0;
    
    while ( true )
    {
        targetplayer = ob_activity_gunship_heli::chopper_getcurrenttargetplayer( self );
        
        if ( namespace_7161222aac9ca916::function_15ef53278f060bfe( targetplayer ) || targetplayer.inlaststand )
        {
            if ( gettime() > searching_time_start + 0 )
            {
                namespace_7161222aac9ca916::function_d3d7a122e05f263a( targetplayer );
                var_2c08a47f9e1e8b36 = 1;
            }
        }
        
        if ( !namespace_7161222aac9ca916::chopper_canseetarget( targetplayer ) )
        {
            if ( gettime() > searching_time_start + 10000 )
            {
                var_2c08a47f9e1e8b36 = 1;
            }
        }
        else
        {
            searching_time_start = gettime();
        }
        
        if ( var_2c08a47f9e1e8b36 )
        {
            if ( !function_3397c6ad45473a58() )
            {
                function_dd1f33638eed1c98( 0 );
                self.currentstate = "patrol";
            }
            
            self notify( #"state_change" );
        }
        
        waitframe();
    }
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 4, eflags: 0x4
// Checksum 0xa6af7dde, Offset: 0xa71
// Size: 0x135, Type: bool
function private function_c13f4a854b7f6082( target, dist, checks, startrot )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    
    if ( !isdefined( startrot ) )
    {
        startrot = 0;
    }
    
    toheli = self gettagorigin( "tag_flash" ) - target.origin;
    toheli = vectornormalize( ( toheli[ 0 ], toheli[ 1 ], 0 ) ) * dist;
    rot = startrot;
    
    while ( rot < startrot + 360 )
    {
        testpos = rotatevector( toheli, ( 0, rot, 0 ) );
        testpos += target.origin + self.heightoffset;
        
        if ( outofbounds::ispointinoutofbounds( testpos ) )
        {
        }
        else
        {
            contentsoverride = trace::create_contents( 0, 1, 0, 1, 0, 0, 0, 1, 1 );
            canseetarget = namespace_7161222aac9ca916::chopper_canseetarget( target, testpos );
            
            if ( canseetarget )
            {
                self setlookatent( target );
                function_7694268097d90a8a( testpos, 1 );
                return true;
            }
        }
        
        rot += 360 / checks;
    }
    
    return false;
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 2, eflags: 0x4
// Checksum 0x84a634a2, Offset: 0xbaf
// Size: 0x87
function private function_7694268097d90a8a( targetorigin, forcestopatgoal )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    self notify( #"stop_shooting" );
    var_f1145fb28d18ff30 = targetorigin[ 2 ];
    diff = self.minheight - var_f1145fb28d18ff30;
    namespace_7161222aac9ca916::chopper_movetolocation( targetorigin, 1, ( 0, 0, diff ) );
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0
// Checksum 0xfcf0a6c1, Offset: 0xc3e
// Size: 0xa0
function function_dd1d8bbc401ca04f()
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    
    if ( level utility::flag_exist( "flag_step_plant_emp_started" ) )
    {
        function_dd1f33638eed1c98( 1 );
        self notify( #"stop_shooting" );
        function_6f77f392c7cd923f();
    }
    else
    {
        childthread function_b1cffc987fa83610();
    }
    
    look_at_center = utility::spawn_script_origin( ( -11945, -47940, 3400 ) );
    self setlookatent( look_at_center );
    self notify( #"stop_shooting" );
    
    while ( true )
    {
        function_b3246a89933b5713();
        wait 2;
    }
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0, eflags: 0x4
// Checksum 0x1ebee591, Offset: 0xce6
// Size: 0x3d
function private function_b1cffc987fa83610()
{
    while ( true )
    {
        if ( function_3397c6ad45473a58() )
        {
            self.canreposition = 0;
            self.currentstate = "attack";
            self notify( #"state_change" );
        }
        
        wait 0.5;
    }
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0, eflags: 0x4
// Checksum 0xe3213231, Offset: 0xd2b
// Size: 0xa4
function private function_b3246a89933b5713()
{
    center_point = ( -11945, -47940, 3400 );
    random_dist = randomintrange( 2000, 4000 );
    var_47a8bf3b386be5a5 = randomint( 360 );
    x = center_point[ 0 ] + random_dist * cos( var_47a8bf3b386be5a5 );
    y = center_point[ 1 ] + random_dist * sin( var_47a8bf3b386be5a5 );
    z = 4000;
    namespace_7161222aac9ca916::chopper_movetolocation( ( x, y, z ), 1, ( 0, 0, 0 ) );
    self waittill( #"near_goal" );
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0
// Checksum 0xe5bb89ed, Offset: 0xdd7
// Size: 0x42
function function_5a4d67a3b86998b()
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    self clearlookatent();
    self.var_b1e200832fd554ae = 1;
    self.var_49696bc140d789dc = 1;
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0
// Checksum 0x74cd9a57, Offset: 0xe21
// Size: 0x3c
function function_a56bb82d86720824()
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    self clearlookatent();
    function_dd1f33638eed1c98( 1 );
    function_f1cfa9d9656a9a34();
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0, eflags: 0x4
// Checksum 0xcda5af96, Offset: 0xe65
// Size: 0x213
function private function_f1cfa9d9656a9a34()
{
    thread function_6f77f392c7cd923f();
    wait 5;
    level.enc_roof = activity_ai_encounters::function_92b671064b0b1ce2( self.var_9f517cd4839d8ab2, 1, 1, 1, 1 );
    level.seek_enabled = 0;
    activity_ai_encounters::function_6bf4ff2fbde584ee( level.enc_roof, &function_2b56d64e18cd9100, self );
    level utility::flag_wait( "flag_reinforcement_spawn_completed" );
    level utility::flag_clear( "flag_reinforcement_spawn_completed" );
    requestdata = function_9b649316adcccbaa( level.enc_roof );
    
    if ( requestdata.ai )
    {
        deployed_enemies = arraycopy( requestdata.ai );
        
        while ( deployed_enemies.size > 0 )
        {
            foreach ( agent in deployed_enemies )
            {
                if ( agent.health < 1 )
                {
                    deployed_enemies = arrayremove( deployed_enemies, agent );
                }
            }
            
            if ( deployed_enemies.size <= 2 && !level.seek_enabled )
            {
                foreach ( agent in deployed_enemies )
                {
                    agent thread ai_utility::player_seek_enable();
                }
                
                level.seek_enabled = 1;
            }
            
            waitframe();
        }
    }
    
    self notify( #"reinforcement_over" );
    level utility::flag_set( "flag_reinforcement_over" );
    self vehicle_setspeed( self.originalspeed, self.originalaccel );
    self.currentstate = "bombing_run";
    self.canreposition = 1;
    self notify( #"state_change" );
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0
// Checksum 0x5217129e, Offset: 0x1080
// Size: 0x1d9
function function_37352202e33dfe63()
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    topspeed = 100;
    accel = 50;
    decel = 5;
    self clearlookatent();
    best_path_data = function_1262e0433f4a5e47();
    var_ec80b561407f6c95 = utility::spawn_script_origin( best_path_data.endpoint );
    function_dd1f33638eed1c98( 0 );
    self setlookatent( var_ec80b561407f6c95 );
    namespace_7161222aac9ca916::chopper_movetolocation( best_path_data.startpoint, 1, ( 0, 0, 0 ) );
    waittime = 1;
    
    foreach ( warningpoint in best_path_data.warningmarkers )
    {
        utility::delaythread( waittime, &function_ea9aca52fed0b7dc, warningpoint );
        waittime++;
    }
    
    level notify( #"vo_bombing_run" );
    wait 2;
    self vehicle_setspeed( topspeed, accel, decel );
    thread namespace_7161222aac9ca916::chopper_movetolocation( best_path_data.endpoint, 0, ( 0, 0, 0 ) );
    childthread function_a6541de05dcea2d( undefined, 0.15, 1, undefined, undefined );
    self waittill( #"near_goal" );
    self notify( #"hash_945bed270c8cb369" );
    ob_activity_gunship_heli::function_9cde1a77d22afe7f( self, 0 );
    self vehicle_setspeed( self.originalspeed, self.originalaccel );
    self.var_870d2c8a0d634a5e = randomintrange( 3, 3 );
    function_51d8823629fa8a69();
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0, eflags: 0x4
// Checksum 0x29d62dee, Offset: 0x1261
// Size: 0x108
function private function_51d8823629fa8a69()
{
    function_dd1f33638eed1c98( 1 );
    yaw_angle = vectortoyaw( self.origin - ( -11945, -47940, 3400 ) );
    yaw_angle = function_63a2ef74ebcc6413( utility::cointoss() ? yaw_angle + 30 : yaw_angle - 30 );
    var_eeff182e14d1f972 = 3000;
    var_51f922b14b7c3517 = ( 0, yaw_angle, 0 );
    var_53436ccfa5409a1c = ( -11945, -47940, 3400 ) + anglestoforward( var_51f922b14b7c3517 ) * var_eeff182e14d1f972;
    var_53436ccfa5409a1c = ( var_53436ccfa5409a1c[ 0 ], var_53436ccfa5409a1c[ 1 ], 4000 );
    namespace_7161222aac9ca916::chopper_movetolocation( var_53436ccfa5409a1c, 1, ( 0, 0, 0 ) );
    self.currentstate = "attack";
    self.attackcounter = 0;
    self.canreposition = !function_3397c6ad45473a58();
    
    if ( !self.canreposition )
    {
        self setlookatent( self.threatlist[ self.currenttarget ].player );
    }
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0, eflags: 0x4
// Checksum 0x7b6e518b, Offset: 0x1371
// Size: 0xc7
function private function_1262e0433f4a5e47()
{
    closestspot = self.bombing_run_path;
    closestdistance = 2147483647;
    
    foreach ( bombing_run_data in self.bombing_run_path )
    {
        currentdist = distancesquared( self.origin, bombing_run_data.startpoint );
        
        if ( currentdist < closestdistance )
        {
            closestspot = bombing_run_data;
            closestdistance = currentdist;
        }
    }
    
    return closestspot;
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 5, eflags: 0x4
// Checksum 0x371ac6e4, Offset: 0x1441
// Size: 0x298
function private function_a6541de05dcea2d( target, fire_rate, alternate_fire, missile_count, missile_targets )
{
    self endon( #"hash_945bed270c8cb369" );
    self endon( #"delete" );
    missiletags = [ "tag_fx_missiles_right", "tag_fx_rockets_right", "tag_fx_missiles_left", "tag_fx_rockets_left" ];
    missilestates = [ "fire_missile_4", "fire_missile_4", "fire_missile_1", "fire_missile_1" ];
    
    if ( !isdefined( alternate_fire ) )
    {
        alternate_fire = getdvarint( @"hash_dff14fb793279d7b", 0 );
    }
    
    if ( !isdefined( missile_count ) )
    {
        missile_count = 2147483647;
    }
    
    if ( !isdefined( fire_rate ) )
    {
        fire_rate = getdvarfloat( @"hash_2b911cdfac237ef", 0.5 );
    }
    
    num_shots = 0;
    
    if ( missile_targets )
    {
        missile_count = missile_targets.size;
    }
    
    while ( num_shots < missile_count )
    {
        forwardvector = vectornormalize2( anglestoforward( self.angles ) );
        var_e804f0a5dce2fe2e = length( self vehicle_getvelocity() ) * 0.056818;
        forwardoffset = forwardvector * var_e804f0a5dce2fe2e * 3;
        var_614260aaf8f69a08 = self gettagorigin( missiletags[ 1 ] ) + forwardoffset;
        var_5d88509d1ece9b99 = ( missile_targets ? missile_targets[ num_shots ] : self gettagorigin( missiletags[ 1 ] ) + anglestoforward( self.angles + ( 35, 0, 0 ) ) * 1000 ) + forwardoffset;
        missileright = weapon_utility::_magicbullet( self.missileweapon, var_614260aaf8f69a08, var_5d88509d1ece9b99, self );
        self setscriptablepartstate( missilestates[ 1 ], "on", 0 );
        num_shots++;
        
        if ( num_shots >= missile_count )
        {
            break;
        }
        
        if ( alternate_fire )
        {
            wait fire_rate;
        }
        
        forwardvector = vectornormalize2( anglestoforward( self.angles ) );
        var_e804f0a5dce2fe2e = length( self vehicle_getvelocity() ) * 0.056818;
        forwardoffset = forwardvector * var_e804f0a5dce2fe2e * 3;
        var_baece2beb8c3f959 = self gettagorigin( missiletags[ 3 ] ) + forwardoffset;
        var_8cac471c45ae8448 = ( missile_targets ? missile_targets[ num_shots ] : self gettagorigin( missiletags[ 3 ] ) + anglestoforward( self.angles + ( 35, 0, 0 ) ) * 1000 ) + forwardoffset;
        missileleft = weapon_utility::_magicbullet( self.missileweapon, var_baece2beb8c3f959, var_8cac471c45ae8448, self );
        self setscriptablepartstate( missilestates[ 3 ], "on", 0 );
        num_shots++;
        wait fire_rate;
    }
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 1, eflags: 0x4
// Checksum 0xd2b6ccd0, Offset: 0x16e1
// Size: 0x58
function private function_ea9aca52fed0b7dc( origin )
{
    marker = spawn( "script_model", origin );
    marker setmodel( "sat_ob_machete_attack_marker" );
    marker setscriptablepartstate( "target", "on", 1 );
    playsoundatpos( origin, "veh_warning_missile_incoming" );
    wait 5;
    marker delete();
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0
// Checksum 0x2d517ac, Offset: 0x1741
// Size: 0xef, Type: bool
function function_3397c6ad45473a58()
{
    randomplayers = arrayrandomize( level.players );
    
    foreach ( player in randomplayers )
    {
        var_b26d3d982589cabb = namespace_7161222aac9ca916::function_15ef53278f060bfe( player );
        var_852fa09935084146 = namespace_7161222aac9ca916::chopper_canseetarget( player );
        var_401412adf638d23c = player::isinlaststand( player );
        
        if ( !var_b26d3d982589cabb && var_852fa09935084146 && !var_401412adf638d23c )
        {
            namespace_7161222aac9ca916::function_c585f17cc1fba955( player, 420 );
            self.currenttarget = player.guid;
            return true;
        }
    }
    
    return false;
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 1
// Checksum 0x667f060f, Offset: 0x1839
// Size: 0x9f
function function_dd1f33638eed1c98( value )
{
    namespace_cf9a4f547edbca10::function_495220db898177a0( value );
    
    foreach ( player in level.players )
    {
        if ( value )
        {
            player ob_story_mission_utils::player_boss_healthbar_immune();
            continue;
        }
        
        player ob_story_mission_utils::player_boss_healthbar_show();
    }
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 14, eflags: 0x4
// Checksum 0x1f65af74, Offset: 0x18e0
// Size: 0xbc
function private function_f5bb5fcff414095f( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid )
{
    if ( self.health - damage <= 0 )
    {
        return;
    }
    
    [[ level.vehicles.damagecallback ]]( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid );
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 14, eflags: 0x4
// Checksum 0x49435857, Offset: 0x19a4
// Size: 0x16b
function private function_cf93665547ce031d( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid )
{
    if ( namespace_7161222aac9ca916::function_bcc82514dd1dd6ff() )
    {
        if ( level.var_9fe4187b1b7cd52e )
        {
            attacker damagefeedback::updatedamagefeedback( "hitimmune", 0, 0 );
        }
        
        return;
    }
    
    if ( attacker == self )
    {
        return;
    }
    
    if ( 1 && objweapon.classname == "rocketlauncher" )
    {
        damage = self.maxhealth * 0.05;
        
        if ( true )
        {
            penalty = 1 + ( level.players.size - 1 ) / 3;
            damage /= max( penalty, 1 );
        }
    }
    
    if ( self.health - damage < self.thresholdhealth )
    {
        damage = self.health - self.thresholdhealth;
        damage = max( damage, 0 );
    }
    
    [[ level.vehicles.damagecallback ]]( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid );
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 11, eflags: 0x4
// Checksum 0x64621d6b, Offset: 0x1b17
// Size: 0xc1
function private function_d158eacdf2995e22( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 )
{
    if ( eattacker == level.var_3d9fc7aa7b25b565.roof_boss && objweapon.classname != "rocketlauncher" )
    {
        damagemultiplier = level.players.size > 2 ? 1.5 : 1;
        return ( idamage * damagemultiplier );
    }
    
    return idamage;
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0, eflags: 0x4
// Checksum 0xd948f175, Offset: 0x1be1
// Size: 0x171
function private function_6f77f392c7cd923f()
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"state_change" );
    self endon( #"reinforcement_over" );
    look_at_center = utility::spawn_script_origin( ( -11945, -47940, 3400 ) );
    self setlookatent( look_at_center );
    angles = vectortoangles( self.origin - look_at_center.origin );
    yaw_degree = angles[ 1 ];
    var_eeff182e14d1f972 = 3000;
    look_at_center.angles = ( 0, yaw_degree, 0 );
    var_53436ccfa5409a1c = look_at_center.origin + anglestoforward( look_at_center.angles ) * var_eeff182e14d1f972;
    var_53436ccfa5409a1c = ( var_53436ccfa5409a1c[ 0 ], var_53436ccfa5409a1c[ 1 ], 5000 );
    namespace_7161222aac9ca916::chopper_movetolocation( var_53436ccfa5409a1c, 0, ( 0, 0, 0 ), 1 );
    self vehicle_setspeed( 20 );
    
    while ( true )
    {
        yaw_degree = function_63a2ef74ebcc6413( yaw_degree + 45 );
        look_at_center.angles = ( 0, yaw_degree, 0 );
        var_ad902e9721904fb3 = look_at_center.origin + anglestoforward( look_at_center.angles ) * var_eeff182e14d1f972;
        var_ad902e9721904fb3 = ( var_ad902e9721904fb3[ 0 ], var_ad902e9721904fb3[ 1 ], 5000 );
        namespace_7161222aac9ca916::chopper_movetolocation( var_ad902e9721904fb3, 0, ( 0, 0, 0 ), 1 );
        waitframe();
    }
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 2, eflags: 0x4
// Checksum 0x9bf90a57, Offset: 0x1d5a
// Size: 0xc3
function private function_d4e592c8fb8f46ef( hack_effect, attacker )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"hash_329b7df83eae9ecf" );
    dealdamage = false ? hack_effect.var_3a75845dc2e014fb : self.maxhealth * 0.1;
    damage = dealdamage / max( level.players.size, 1 );
    function_cf93665547ce031d( attacker, attacker, damage, 0, "MOD_UNKNOWN", attacker.currentweapon, self.origin, undefined, "", 0, 0, "", "tag_origin" );
    thread function_39edc5ccd8031679( hack_effect );
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 1, eflags: 0x4
// Checksum 0x83fa5b4f, Offset: 0x1e25
// Size: 0x7c
function private function_39edc5ccd8031679( hack_effect )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"hash_329b7df83eae9ecf" );
    
    if ( !hack_effect.hackduration )
    {
        return;
    }
    
    self.black_hat_hacked = 1;
    self.var_c3c4d711e69d5ab9 = 1;
    wait hack_effect.hackduration * 0.001;
    self.var_c3c4d711e69d5ab9 = 0;
    self.black_hat_hacked = 0;
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0
// Checksum 0xb02f6bb0, Offset: 0x1ea9
// Size: 0x8c
function healthbar_setup()
{
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_advanced_guild_vtol", self );
        player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
    }
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0
// Checksum 0x311e0383, Offset: 0x1f3d
// Size: 0x7d
function healthbar_update_health()
{
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
    }
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 2
// Checksum 0xa79d9c17, Offset: 0x1fc2
// Size: 0xce
function healthbar_update( damage, max_health )
{
    health_frac = self.health / self.maxhealth;
    
    foreach ( player in level.players )
    {
        if ( self.health > 0 )
        {
            player ob_story_mission_utils::function_e231206f1628d4c6( 1, health_frac * 100, 100 );
            continue;
        }
        
        player ob_story_mission_utils::player_boss_healthbar_hide();
    }
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 1
// Checksum 0xa5c1153f, Offset: 0x2098
// Size: 0xa0
function function_f6098d122e2499e3( hide )
{
    foreach ( player in level.players )
    {
        if ( hide )
        {
            player ob_story_mission_utils::player_boss_healthbar_hide();
            continue;
        }
        
        player ob_story_mission_utils::player_boss_healthbar_show();
        player ob_story_mission_utils::function_e231206f1628d4c6( 0 );
    }
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0
// Checksum 0xb0bda14b, Offset: 0x2140
// Size: 0x3fb
function function_aec87cf75ef5fbc4()
{
    namespace_f2445a4de17ee25::function_316cb76449f3acf7( "vtol", &function_d158eacdf2995e22 );
    ob_activity_gunship_heli::chopper_init();
    function_b4e57201bf2904e3();
    gunship_start = utility::getstruct( "gunship_roofboss_start", "targetname" );
    gunship_path_start = gunship_start namespace_be3150865da9d2f1::get_linked_struct();
    gunship_instance = spawnstruct();
    gunship_instance.var_b2596b0f06a9e7a1 = [];
    gunship_instance.bossname = "chopper";
    gunship_instance.var_cb5c81589a3b29d2 = "veh_sat_mil_vtol_ob_gunship_capricorn";
    gunship_instance.spawned = 0;
    gunship_instance.activity = self;
    gunship_instance.var_8c78435105a9f582 = 1;
    gunship_instance.spawnloc = gunship_start.origin;
    gunship_instance.patrolpath = gunship_path_start;
    gunship_instance ob_activity_gunship_heli::chopper_spawn();
    waitframe();
    gunship_instance.boss healthbar_setup();
    objidpoolmanager::returnobjectiveid( gunship_instance.chopper.objidnum );
    gunship_instance.chopper setturningability( 1 );
    gunship_instance.chopper setyawspeed( 250, 100, 50, 0.1 );
    gunship_instance.chopper.spawndata = gunship_instance;
    vehicle_occupancy::register_instance( gunship_instance.chopper );
    gunship_instance.chopper.attackfunc = &function_f49ccfbbc71553fd;
    gunship_instance.chopper.funcs[ "bombing_run" ] = &function_37352202e33dfe63;
    gunship_instance.chopper.funcs[ "animation" ] = &function_5a4d67a3b86998b;
    gunship_instance.chopper.funcs[ "reinforcement" ] = &function_a56bb82d86720824;
    gunship_instance.chopper.funcs[ "patrol" ] = &function_dd1d8bbc401ca04f;
    gunship_instance.chopper.damagecallback = &function_cf93665547ce031d;
    gunship_instance.chopper.flaresreservecount = 0;
    gunship_instance.chopper function_dd1f33638eed1c98( 0 );
    gunship_instance.chopper.var_9bd743060e96497e = 1;
    gunship_instance.boss.var_39ecac29b0a5f2b = 1;
    gunship_instance.boss.var_eb1bfd65428b7b41 = 1;
    gunship_instance.boss.var_359ce29c63efe084 = [ 0.7, 0.05, 0.02 ];
    gunship_instance.boss.minheight = 4250;
    gunship_instance.boss.var_19a36b17776e8e85 = 1;
    gunship_instance.boss.attackcounter = 0;
    gunship_instance.boss function_614a20fbc0dd7404();
    gunship_instance.boss.originalspeed = 200;
    gunship_instance.boss.originalaccel = 75;
    gunship_instance.boss vehicle_setspeed( gunship_instance.boss.originalspeed, gunship_instance.boss.originalaccel );
    gunship_instance.chopper.missileweapon = makeweapon( "sat_vtol_warship_proj_ob_capricorn" );
    gunship_instance.boss utility::callsharedfunc( #"gametype", #"hash_cbc683d4d23144e5", "veh_sat_mil_vtol_ob_gunship_capricorn" );
    utility::registersharedfunc( #"vtol", #"hack", &function_d4e592c8fb8f46ef );
    return gunship_instance.boss;
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0
// Checksum 0x9423a7c6, Offset: 0x2544
// Size: 0x2aa
function function_1da6426434fdf6b()
{
    ob_activity_heli_takedown::function_fb53b392296c145c();
    var_f4a3774933a4ada = utility::getstruct( "roji_trail_vtol_1", "targetname" );
    roji_intro_vtol = spawnstruct();
    roji_intro_vtol.start_location = var_f4a3774933a4ada;
    roji_intro_vtol.start_location.origin = var_f4a3774933a4ada.origin + ( 0, 0, 10 );
    roji_intro_vtol.var_2a47db6ce749f4a9 = namespace_28acf6540b1bc740::heli_spawn_simple( roji_intro_vtol.start_location, %"hash_3de08ee4ce53144f", 1, 1 );
    roji_intro_vtol.var_2a47db6ce749f4a9 forcenetfieldhighlod( 1 );
    roji_intro_vtol.var_2a47db6ce749f4a9 vehicleshowonminimap( 1 );
    roji_intro_vtol.var_2a47db6ce749f4a9 thread ob_activity_heli_takedown::function_ff5870f68a2a6d1f( 1 );
    roji_intro_vtol.var_2a47db6ce749f4a9 setmaxpitchroll( 15, 15 );
    roji_intro_vtol.var_2a47db6ce749f4a9 setneargoalnotifydist( 128 );
    roji_intro_vtol.var_2a47db6ce749f4a9 setturningability( 0.02 );
    roji_intro_vtol.var_2a47db6ce749f4a9.b_escaping = 0;
    roji_intro_vtol.var_2a47db6ce749f4a9.hover_min_height = 0;
    roji_intro_vtol.var_2a47db6ce749f4a9.heightoffset = ( 0, 0, 0 );
    roji_intro_vtol.var_2a47db6ce749f4a9.damagestate = 0;
    roji_intro_vtol.var_2a47db6ce749f4a9.var_24954f14e27b448d = 0;
    roji_intro_vtol.var_2a47db6ce749f4a9.pathgoaldistance = 256;
    roji_intro_vtol.var_2a47db6ce749f4a9.health = 100000;
    roji_intro_vtol.var_2a47db6ce749f4a9 thread namespace_28acf6540b1bc740::function_7fb408948b1225e0( var_f4a3774933a4ada.origin, 1, undefined, 1, self.var_2a47db6ce749f4a9.angles[ 1 ], 1, 5, 5, undefined, undefined, 1 );
    roji_intro_vtol.var_2a47db6ce749f4a9.damagecallback = &function_f5bb5fcff414095f;
    roji_intro_vtol.var_2a47db6ce749f4a9 setscriptablepartstate( "engine", "on_all", 0 );
    roji_intro_vtol.var_2a47db6ce749f4a9 setscriptablepartstate( "thrusters", "horizontal", 0 );
    roji_intro_vtol.var_2a47db6ce749f4a9 setscriptablepartstate( "spotlight", "on_lightcast" );
    roji_intro_vtol.var_2a47db6ce749f4a9 vehicle_cleardrivingstate();
    roji_intro_vtol.var_2a47db6ce749f4a9 function_d2b8ee2e1275daaf( 1 );
    roji_intro_vtol.var_2a47db6ce749f4a9 vehphys_forcekeyframedmotion();
    return roji_intro_vtol.var_2a47db6ce749f4a9;
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0, eflags: 0x4
// Checksum 0x3b1b510c, Offset: 0x27f7
// Size: 0x167
function private function_b4e57201bf2904e3()
{
    minplayersize = level.players.size > 0 ? level.players.size : 1;
    level.var_adaaa86b7b5a18b6 = 10000 * minplayersize;
    level.var_db391e86c6c1bbc2 = 250;
    level.var_c582f0f1f598788e = 2;
    level.var_da9d0112ff45d16b = 6;
    level.var_1c413c0f520b77a1 = 1000;
    level.var_ef819189ba3c6250 = 15000;
    level.var_1b807c86f79fc8d6 = 32;
    level.var_c15d0d0ad1e767fb = 18;
    level.var_3375c4f7793b4ccb = 8;
    level.var_be17f6f2696e1d1a = 2500;
    level.var_1be27c807e9e9d09 = 5.75;
    level.var_679b2cb4aec6cf81 = 0.7;
    level.var_9275920438b54a87 = 4;
    level.var_9298800438db6aa9 = 4;
    level.var_99790c03689d056 = 1.75;
    level.var_146d94309e2e75bb = 1.2;
    level.var_c915f7191eab3985 = 155;
    level.var_c915f4191eab32ec = 75;
    level.var_c915f5191eab351f = 10;
    level.var_e05429687d6711be = 1;
    level.var_9b32f3255542d1f7 = 12000;
    level.var_89ef72f6589587f0 = 0;
    level.var_99cc0ae0a9c90f54 = 1;
    level.var_a9f499aba9fe4113 = 0;
    level.var_59e1d7f72751378 = 1;
    level.var_6f9c69487979a715 = 1;
    level.var_ac384fdf4664f6cc = 1;
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 0, eflags: 0x4
// Checksum 0xef5a806d, Offset: 0x2966
// Size: 0x691
function private function_614a20fbc0dd7404()
{
    self.bombing_run_path = [];
    self.bombing_run_path[ 0 ] = spawnstruct();
    self.bombing_run_path[ 0 ].startpoint = ( -12355, -51050, 4000 );
    self.bombing_run_path[ 0 ].endpoint = ( -12373, -46100, 4000 );
    self.bombing_run_path[ 0 ].warningmarkers = [];
    self.bombing_run_path[ 0 ].warningmarkers[ 0 ] = ( -12400, -48560, 3344 );
    self.bombing_run_path[ 0 ].warningmarkers[ 1 ] = ( -12375, -47900, 3344 );
    self.bombing_run_path[ 0 ].warningmarkers[ 2 ] = ( -12406, -47250, 3204 );
    self.bombing_run_path[ 4 ] = spawnstruct();
    self.bombing_run_path[ 4 ].startpoint = ( -12373, -46100, 4000 );
    self.bombing_run_path[ 4 ].endpoint = ( -12355, -51050, 4000 );
    self.bombing_run_path[ 4 ].warningmarkers = [];
    self.bombing_run_path[ 4 ].warningmarkers[ 0 ] = ( -12406, -47250, 3204 );
    self.bombing_run_path[ 4 ].warningmarkers[ 1 ] = ( -12375, -47900, 3344 );
    self.bombing_run_path[ 4 ].warningmarkers[ 2 ] = ( -12400, -48560, 3344 );
    self.bombing_run_path[ 1 ] = spawnstruct();
    self.bombing_run_path[ 1 ].startpoint = ( -11684, -45100, 4000 );
    self.bombing_run_path[ 1 ].endpoint = ( -11651, -50900, 4000 );
    self.bombing_run_path[ 1 ].warningmarkers = [];
    self.bombing_run_path[ 1 ].warningmarkers[ 0 ] = ( -11751, -47250, 3204 );
    self.bombing_run_path[ 1 ].warningmarkers[ 1 ] = ( -11751, -47900, 3344 );
    self.bombing_run_path[ 1 ].warningmarkers[ 2 ] = ( -11751, -48560, 3340 );
    self.bombing_run_path[ 5 ] = spawnstruct();
    self.bombing_run_path[ 5 ].startpoint = ( -11651, -50900, 4000 );
    self.bombing_run_path[ 5 ].endpoint = ( -11684, -45100, 4000 );
    self.bombing_run_path[ 5 ].warningmarkers = [];
    self.bombing_run_path[ 5 ].warningmarkers[ 0 ] = ( -11751, -48560, 3340 );
    self.bombing_run_path[ 5 ].warningmarkers[ 1 ] = ( -11751, -47900, 3344 );
    self.bombing_run_path[ 5 ].warningmarkers[ 2 ] = ( -11751, -47250, 3204 );
    self.bombing_run_path[ 2 ] = spawnstruct();
    self.bombing_run_path[ 2 ].startpoint = ( -14051, -47508, 4000 );
    self.bombing_run_path[ 2 ].endpoint = ( -10480, -47600, 4000 );
    self.bombing_run_path[ 2 ].warningmarkers = [];
    self.bombing_run_path[ 2 ].warningmarkers[ 0 ] = ( -12406, -47570, 3204 );
    self.bombing_run_path[ 2 ].warningmarkers[ 1 ] = ( -11760, -47570, 3204 );
    self.bombing_run_path[ 6 ] = spawnstruct();
    self.bombing_run_path[ 6 ].startpoint = ( -10480, -47600, 4000 );
    self.bombing_run_path[ 6 ].endpoint = ( -14051, -47508, 4000 );
    self.bombing_run_path[ 6 ].warningmarkers = [];
    self.bombing_run_path[ 6 ].warningmarkers[ 0 ] = ( -11760, -47570, 3204 );
    self.bombing_run_path[ 6 ].warningmarkers[ 1 ] = ( -12406, -47570, 3204 );
    self.bombing_run_path[ 3 ] = spawnstruct();
    self.bombing_run_path[ 3 ].startpoint = ( -10480, -48420, 4000 );
    self.bombing_run_path[ 3 ].endpoint = ( -13804, -48365, 4000 );
    self.bombing_run_path[ 3 ].warningmarkers = [];
    self.bombing_run_path[ 3 ].warningmarkers[ 0 ] = ( -11686, -48427, 3344 );
    self.bombing_run_path[ 3 ].warningmarkers[ 1 ] = ( -12316, -48420, 3344 );
    self.bombing_run_path[ 7 ] = spawnstruct();
    self.bombing_run_path[ 7 ].startpoint = ( -13804, -48365, 4000 );
    self.bombing_run_path[ 7 ].endpoint = ( -10480, -48420, 4000 );
    self.bombing_run_path[ 7 ].warningmarkers = [];
    self.bombing_run_path[ 7 ].warningmarkers[ 0 ] = ( -12316, -48420, 3344 );
    self.bombing_run_path[ 7 ].warningmarkers[ 1 ] = ( -11686, -48427, 3344 );
}

// Namespace mp_sat_ob_capricorn_vtol_utils
// Params 3, eflags: 0x4
// Checksum 0x316a9876, Offset: 0x2fff
// Size: 0x2b
function private function_2b56d64e18cd9100( requestid, activity_instance, agent )
{
    level utility::flag_set( "flag_reinforcement_spawn_completed" );
}

