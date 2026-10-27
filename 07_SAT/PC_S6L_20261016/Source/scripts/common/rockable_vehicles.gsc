// scripts\common\rockable_vehicles.gsc  (hash_3510835c04d231df.gscc) (size: 6926 Bytes / 0x1b0e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9b43d26 (162807078)
// size ...... 6926 (0x1b0e)
// includes .. 2   (offset: 0x18ea)
// strings ... 38  (offset: 0x18fa)
// dev strs .. 0   (offset: 0x1b0e)
// exports ... 13  (offset: 0x122a)
// cseg ...... 0x267 + 0xfc3 (0x122a)
// imports ... 38  (offset: 0x1432)
// animtree1 . 0   (offset: 0x1b0e)
// animtree2 . 0   (offset: 0x1b0e)
#using scripts\common\utility;
#using scripts\common\vehicle_damage;

#namespace rockable_vehicles;

// Namespace rockable_vehicles
// Params 0
// Checksum 0x3d33f988, Offset: 0x285
// Size: 0x23
function init()
{
    setdvarifuninitialized( @"hash_89dce574801028ad", 0 );
    level utility::delaythread( 0.05, &rockable_cars_init );
}

// Namespace rockable_vehicles
// Params 0
// Checksum 0xab3dcd14, Offset: 0x2b0
// Size: 0x343
function rockable_cars_init()
{
    level.rockablecars = { #cars:[] };
    utility::flag_wait( "scriptables_ready" );
    scriptables = getscriptablearray( "scriptable", #code_classname );
    
    if ( !scriptables.size )
    {
        return;
    }
    
    count = 0;
    
    foreach ( car in scriptables )
    {
        if ( count > 99 )
        {
            count = 0;
            waitframe();
        }
        
        count++;
        
        if ( utility::issp() )
        {
            if ( !car valid_rockable_vehicle() )
            {
                continue;
            }
        }
        
        if ( !car getscriptablehaspart( level.projectbundle.var_b75f0dcfe364fb82 ?? "rootmodelmanager" ) )
        {
            continue;
        }
        
        level.rockablecars.cars[ level.rockablecars.cars.size ] = car;
        car.forward = anglestoforward( car.angles );
        car.right = anglestoright( car.angles );
        
        if ( !utility::issp() )
        {
            car.up = anglestoup( car.angles );
            car.frontpoint = car getpointinbounds( 1, 0, 0 );
            car.backpoint = car getpointinbounds( -1, 0, 0 );
            car.leftpoint = car getpointinbounds( 0, 1, 0 );
            car.rightpoint = car getpointinbounds( 0, -1, 0 );
            car.toppoint = car getpointinbounds( 0, 0, level.projectbundle.var_2a607dbfcdbbded3 ?? -0.15 );
            car.halflength = vectordot( car.forward, car.frontpoint - car.backpoint ) / 2;
            car.halfwidth = vectordot( car.right, car.rightpoint - car.leftpoint ) / 2;
            car.players = [];
            car.touchtimes = [];
            car.rocktimes = [];
            car.var_74b4660926b3c4f3 = car getscriptablehaspart( level.projectbundle.var_123b00100ba4c517 ?? "Anim_PlayerStandRock" );
        }
        
        car thread rockable_car_debug();
        
        if ( getdvarint( @"hash_2448528570ef56f7", 1 ) == 1 )
        {
            car thread rockable_car_watch_damage();
            car thread rockable_car_watch_death();
            continue;
        }
        
        car setscriptablepartstate( level.projectbundle.var_61447c51ce60606e ?? "body", "no_process", 0 );
    }
    
    utility::flag_set( "rockable_cars_init" );
    level thread alarm_cars_init();
}

// Namespace rockable_vehicles
// Params 0
// Checksum 0x4a8804bb, Offset: 0x5fb
// Size: 0x2c, Type: bool
function valid_rockable_vehicle()
{
    if ( self.script_noteworthy == "not_rockable" )
    {
        return false;
    }
    
    if ( self.destructible_type == "vehicle" )
    {
        return true;
    }
    
    return false;
}

// Namespace rockable_vehicles
// Params 0
// Checksum 0xda241dc2, Offset: 0x630
// Size: 0x2b9
function rockable_car_watch_damage()
{
    self endon( #"death" );
    self endon( #"rocked" );
    self setcandamage( 1 );
    self.rockable_last_point = 0;
    self.rockable_last_meansofdeath = "";
    
    while ( true )
    {
        self.health = 999999;
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( level.projectbundle.var_bb8657a9b961b815 && isexplosivedamagemod( meansofdeath ) && objweapon )
        {
            vehicle = { #vehicletype:getxhashasset( level.projectbundle.var_bb8657a9b961b815 ) };
            damage = vehicle_damage::get_hit_damage( damage, vehicle, objweapon );
            maxhealth = vehicle_damage::get_data( level.projectbundle.var_bb8657a9b961b815 ).health;
            ratio = damage / maxhealth;
            burndowntime = vehicle_damage::function_b78d1e92d6ea2ac1( level.projectbundle.var_bb8657a9b961b815, objweapon.basename );
            state = self getscriptablepartstate( level.projectbundle.var_61447c51ce60606e ?? "body", 1 );
            
            if ( ratio >= 1 && state != "onfire" && state != "dead" && state != "swap" )
            {
                self setscriptablepartstate( "splash_listener", "dead", 0 );
                state = self getscriptablepartstate( level.projectbundle.var_61447c51ce60606e ?? "body", 1 );
            }
            
            if ( state == "onfire" && burndowntime < 8 )
            {
                thread function_4a8536be3a743b7f( burndowntime );
            }
        }
        
        self.rockable_last_point = point;
        self.rockable_last_meansofdeath = meansofdeath;
        print3d_debug( self.origin + ( 0, 0, 0 ), "Damage by: " + meansofdeath + " " + damage, ( 1, 1, 1 ), 1, 0.25, 100 );
    }
}

// Namespace rockable_vehicles
// Params 1, eflags: 0x4
// Checksum 0x985b39a6, Offset: 0x8f1
// Size: 0x79
function private function_4a8536be3a743b7f( burndowntime )
{
    if ( self.var_d26fb7e043cde41d )
    {
        return;
    }
    
    self.var_d26fb7e043cde41d = 1;
    wait burndowntime;
    
    if ( self getscriptablepartstate( level.projectbundle.var_61447c51ce60606e ?? "body", 1 ) == "onfire" )
    {
        self setscriptablepartstate( level.projectbundle.var_61447c51ce60606e ?? "body", "dead", 0 );
    }
}

// Namespace rockable_vehicles
// Params 0
// Checksum 0x448cfd11, Offset: 0x972
// Size: 0x300
function rockable_car_watch_death()
{
    self endon( #"death" );
    self waittillmatch( #"scriptablenotification", #"anim_explosion" );
    self notify( #"rocked" );
    
    if ( isexplosivedamagemod( self.rockable_last_meansofdeath ) )
    {
        btwn = self.rockable_last_point - self.origin;
        forwardstr = vectordot( self.forward, btwn ) > 0 ? "front" : "back";
        rightstr = vectordot( self.right, btwn ) > 0 ? "right" : "left";
        self setscriptablepartstate( level.projectbundle.var_fc2f27a9af47060d ?? "anim_explosion", forwardstr + "_" + rightstr, 0 );
        print3d_debug( self.origin + ( 0, 0, -5 ), "Death by: " + self.rockable_last_meansofdeath, ( 1, 0, 0 ), 1, 0.25, 1000 );
        print3d_debug( self.origin + ( 0, 0, 12 ), "Animation: " + forwardstr + "_" + rightstr, ( 1, 1, 1 ), 1, 0.25, 1000 );
    }
    else
    {
        death_anims = [ "front_left", "front_right", "back_left", "back_right" ];
        death_anim = death_anims[ randomint( death_anims.size - 1 ) ];
        self setscriptablepartstate( level.projectbundle.var_fc2f27a9af47060d ?? "anim_explosion", death_anim, 0 );
        print3d_debug( self.origin + ( 0, 0, -5 ), "Death by: " + self.rockable_last_meansofdeath, ( 1, 0, 0 ), 1, 0.25, 1000 );
        print3d_debug( self.origin + ( 0, 0, 5 ), "scripted explosion", ( 1, 0, 0 ), 1, 0.5, 500 );
        print3d_debug( self.origin + ( 0, 0, 10 ), "Animation: " + death_anim, ( 1, 1, 1 ), 1, 0.25, 1000 );
    }
    
    if ( getdvarint( @"hash_e9421533f01288a", 0 ) == 1 )
    {
        wait randomfloatrange( 15, 30 );
        self setscriptablepartstate( level.projectbundle.var_61447c51ce60606e ?? "body", "onfire", 0 );
        thread rockable_car_watch_death();
        return;
    }
    
    self waittillmatch( #"scriptablenotification", #"anim_explosion_complete" );
    thread rockable_car_watch_dead();
}

// Namespace rockable_vehicles
// Params 0
// Checksum 0x60bd601b, Offset: 0xc7a
// Size: 0x17e
function rockable_car_watch_dead()
{
    self endon( #"death" );
    
    while ( true )
    {
        self.health = 999999;
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( isexplosivedamagemod( meansofdeath ) && damage > 10 )
        {
            self setscriptablepartstate( level.projectbundle.var_fc2f27a9af47060d ?? "anim_explosion", "rock", 1 );
        }
        
        print3d_debug( self.origin + ( 0, 0, 7 ), "Death animation: " + "rock", ( 1, 1, 1 ), 1, 0.25, 1000 );
        print3d_debug( self.origin + ( 0, 0, 0 ), "Death damage by: " + meansofdeath + " " + damage, ( 1, 1, 1 ), 1, 0.25, 150 );
    }
}

// Namespace rockable_vehicles
// Params 0
// Checksum 0xefc28144, Offset: 0xe00
// Size: 0x65
function rockable_car_debug()
{
    self endon( #"death" );
    
    if ( getdvarint( @"hash_89dce574801028ad" ) )
    {
        while ( true )
        {
            print3d_debug( self.origin + ( 0, 0, 60 ), "rockable", ( 1, 1, 1 ), 1, 0.5, 2 );
            wait 0.1;
        }
    }
}

// Namespace rockable_vehicles
// Params 0
// Checksum 0x96d1c76b, Offset: 0xe6d
// Size: 0x11c
function alarm_cars_init()
{
    level.alarmcars = { #cars:[] };
    count = 0;
    
    foreach ( car in level.alarmcars.cars )
    {
        if ( count > 99 )
        {
            count = 0;
            waitframe();
        }
        
        count++;
        
        if ( car.script_noteworthy != "veh9_generic_alarm_on" || !isdefined( car getscriptablehaspart( level.projectbundle.var_2bd8ed79a5fc5859 ?? "car_alarm" ) ) )
        {
            continue;
        }
        
        level.alarmcars.cars[ level.alarmcars.cars.size ] = car;
        car thread alarm_car_watch_damage();
    }
}

// Namespace rockable_vehicles
// Params 0
// Checksum 0xff0df8f7, Offset: 0xf91
// Size: 0x1a9
function alarm_car_watch_damage()
{
    self notify( #"hash_90cc4d1193206800" );
    self endon( #"hash_90cc4d1193206800" );
    self endon( #"death" );
    self endon( #"rocked" );
    self endon( #"stop_alarm" );
    self setcandamage( 1 );
    self.alarmdamage = 0;
    thread alarm_car_debug();
    
    while ( true )
    {
        self.health = 999999;
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        print3d_debug( self.origin + ( 0, 0, -7 ), "Alarm damage by: " + meansofdeath + " " + damage, ( 1, 1, 1 ), 1, 0.25, 150 );
        self.alarmdamage += damage;
        waitframe();
        
        if ( self.alarmdamage > 200 )
        {
            self setscriptablepartstate( level.projectbundle.var_2bd8ed79a5fc5859 ?? "car_alarm", "on", 0 );
            level notify( #"veh9_generic_alarm_on", self );
            break;
        }
    }
}

// Namespace rockable_vehicles
// Params 0
// Checksum 0x9d306946, Offset: 0x1142
// Size: 0x87
function alarm_car_debug()
{
    self notify( #"hash_f5f7259d27a46608" );
    self endon( #"hash_f5f7259d27a46608" );
    self endon( #"death" );
    
    if ( getdvarint( @"hash_89dce574801028ad" ) )
    {
        while ( true )
        {
            print3d_debug( self.origin + ( 0, 0, 70 ), "alarm.  dmg: " + self.alarmdamage, ( 1, 1, 1 ), 1, 0.5, 2 );
            wait 0.1;
        }
    }
}

// Namespace rockable_vehicles
// Params 6
// Checksum 0x47f89558, Offset: 0x11d1
// Size: 0x59
function print3d_debug( origin, text, color, alpha, scale, duration )
{
    if ( getdvarint( @"hash_89dce574801028ad" ) )
    {
        /#
            print3d( origin, text, color, alpha, scale, duration );
        #/
    }
}

