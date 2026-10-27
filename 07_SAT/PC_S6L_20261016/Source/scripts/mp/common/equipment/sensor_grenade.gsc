// scripts\mp\common\equipment\sensor_grenade.gsc  (hash_3772e1b53b6011dc.gscc) (size: 19141 Bytes / 0x4ac5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x359c4139 (899432761)
// size ...... 19141 (0x4ac5)
// includes .. 24  (offset: 0x4785)
// strings ... 36  (offset: 0x4845)
// dev strs .. 4   (offset: 0x4a95)
// exports ... 40  (offset: 0x2f19)
// cseg ...... 0x3ab + 0x2b6e (0x2f19)
// imports ... 150 (offset: 0x3559)
// animtree1 . 0   (offset: 0x4ac5)
// animtree2 . 0   (offset: 0x4ac5)
#using script_16ea1b94f0f381b3;
#using scripts\anim\utility;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\scripted_widgets;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\rank;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace sensor_grenade;

// Namespace sensor_grenade
// Params 0, eflags: 0x1
// Checksum 0x190c6cb8, Offset: 0x3c9
// Size: 0xa
function autoexec main()
{
    level init();
}

// Namespace sensor_grenade
// Params 0, eflags: 0x4
// Checksum 0xc4496e5d, Offset: 0x3db
// Size: 0x149
function private init()
{
    level callback::add( #"player_spawned", &onplayerspawned );
    level callback::add( #"on_ai_killed", &function_b3453b585143e886 );
    level callback::add( #"player_death", &function_b3453b585143e886 );
    level callback::add( #"hash_2709fd1dd4cef88d", &function_45db61559313c6bf );
    level callback::add( #"hash_eb54ccc016130a88", &onplayerelim );
    level callback::add( #"player_disconnect", &onplayerdisconnect );
    level callback::add( #"hash_244314ef9125e636", &onplayerdeath );
    level callback::add( #"hash_2efd4eae7229b871", &onagentdeath );
    weapons::registerusedcallback( "sensor_grenade", &used );
    utility::add_fx( "sensor_grenade_laser_beam", "vfx_sat_equip_sensor_laser_mp" );
    utility::add_fx( "sensor_grenade_muzzle", "vfx_sat_equip_sensor_dart_muzzle" );
    utility::registersharedfunc( #"sensor_grenade", #"hack", &hack );
    utility::flag_wait( "equipment_initialized" );
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #customhit:1, #equipref:"equip_sensor_grenade" } );
    equipmentinteractinit();
}

// Namespace sensor_grenade
// Params 0
// Checksum 0x22a3a68c, Offset: 0x52c
// Size: 0xab
function equipmentinteractinit()
{
    bundle = level.equipment.table[ "equip_sensor_grenade" ].bundle;
    
    if ( !bundle.equipmentinteractions || !bundle.useweapon )
    {
        return;
    }
    
    utility::registersharedfunc( getxhash( "equip_sensor_grenade" ), #"interactdestroy", &destroy_sensor_grenade );
    utility::registersharedfunc( getxhash( "equip_sensor_grenade" ), #"interactdisable", &equipmentinteractdisable );
    utility::registersharedfunc( getxhash( "equip_sensor_grenade" ), #"interactenable", &equipmentinteractenable );
}

// Namespace sensor_grenade
// Params 1, eflags: 0x4
// Checksum 0x7e7c5ff5, Offset: 0x5df
// Size: 0x2e4
function private used( grenade )
{
    grenade endon( #"death" );
    grenade endon( #"sensor_grenade_water_impact" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( level.sensorgrenadebundle ) )
    {
        ref = equipment_mp::function_fdc4a655fbde0dec( grenade.weapon_name );
        tableinfo = weapon::getequipmenttableinfo( ref );
        level.sensorgrenadebundle = tableinfo.bundle;
        
        if ( !isdefined( level.sensorgrenadebundle ) )
        {
            assertmsg( "<dev string:x24>" );
        }
    }
    
    if ( !isdefined( grenade.var_30656af96b2ac2a4 ) )
    {
        grenade.var_30656af96b2ac2a4 = [];
    }
    
    grenade.add_buff = &addbuff;
    grenade.remove_buff = &removebuff;
    grenade thread function_6502d79c98de182c();
    thread watchwaterimpact( grenade );
    grenade waittill( #"missile_stuck", stuckto );
    utility::function_969f9f5596dba07a( grenade, &destroy_sensor_grenade );
    
    if ( isent( stuckto ) && stuckto ismovingplatform() )
    {
        grenade linkto( stuckto );
    }
    
    grenade.owner = self;
    grenade setentityowner( self );
    grenade setotherent( self );
    grenade.health = level.sensorgrenadebundle.sensor_grenadehealth ?? 25;
    grenade setcandamage( 1 );
    grenade thread damage::monitordamage( grenade.health, "hitequip", &destroy_sensor_grenade );
    grenade sentientpoolmanager::registersentient( "Tactical_Static", grenade.owner );
    grenade setscriptablepartstate( #"plant_fx", #"plant" );
    grenade setscriptablepartstate( #"visual", #"visible" );
    
    if ( !isdefined( self.sensorgrenades ) )
    {
        self.sensorgrenades = [];
    }
    
    self.sensorgrenades[ self.sensorgrenades.size ] = grenade;
    imageoverride = grenade.var_30656af96b2ac2a4.size > 0 ? level.sensorgrenadebundle.buffedheadicon : undefined;
    grenade.headiconid = entityheadicons::setheadicon_equipment( grenade, imageoverride );
    namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( grenade, &onemped );
    utility::callsharedfunc( #"jamming_system", #"hash_ca0042e3cac99672", grenade, &function_7fb670e194c3f1eb, &function_50c48f547b740df9 );
    wait level.sensorgrenadebundle.var_d75b50d3e5e98a51 ?? 1;
    grenade.var_76d4515a04d0ef12 = [];
    weapons::onequipmentplanted( grenade, "equip_sensor_grenade", &destroy_sensor_grenade );
    grenade thread watchenemies( self );
    grenade thread watchdeath( self );
}

// Namespace sensor_grenade
// Params 1
// Checksum 0x5fcbb44c, Offset: 0x8cb
// Size: 0x1f
function equipmentinteractdisable( data )
{
    self.isjammed = 1;
    function_7fb670e194c3f1eb( self );
}

// Namespace sensor_grenade
// Params 1
// Checksum 0x7564233a, Offset: 0x8f2
// Size: 0x1e
function equipmentinteractenable( data )
{
    self.isjammed = 0;
    function_50c48f547b740df9( self );
}

// Namespace sensor_grenade
// Params 1, eflags: 0xc
// Checksum 0x454f364d, Offset: 0x918
// Size: 0x92
function private watchwaterimpact( grenade )
{
    self notify( #"hash_925cd556252baa1b" );
    self endon( #"hash_925cd556252baa1b" );
    grenade endon( #"death" );
    grenade endon( #"missile_stuck" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    msg = utility::waittill_any_timeout( 5, "missile_water_impact" );
    
    if ( msg == "timeout" )
    {
        return;
    }
    
    grenade notify( #"sensor_grenade_water_impact" );
    grenade thread destroy_sensor_grenade( undefined );
}

// Namespace sensor_grenade
// Params 0, eflags: 0xc
// Checksum 0x7a4c83d4, Offset: 0x9b2
// Size: 0x48
function private function_6502d79c98de182c()
{
    self notify( #"hash_ce597b2e581a025e" );
    self endon( #"hash_ce597b2e581a025e" );
    self endon( #"death" );
    wait 0.2;
    
    if ( self )
    {
        self setscriptablepartstate( #"model_visibility", #"visible" );
    }
}

// Namespace sensor_grenade
// Params 1, eflags: 0xc
// Checksum 0x260e3be3, Offset: 0xa02
// Size: 0x5da
function private watchenemies( owner )
{
    self notify( #"hash_9ff83f40021de53" );
    self endon( #"hash_9ff83f40021de53" );
    level endon( #"game_ended" );
    owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"grenade_hacked" );
    awarenessrange = level.sensorgrenadebundle.var_b15981b2658ce613 ?? 700;
    projectilerange = level.sensorgrenadebundle.var_233718f2d68108ff ?? 500;
    
    if ( !isdefined( self.bulletleft ) )
    {
        self.bulletleft = level.sensorgrenadebundle.var_20a9e3c4d4cb07fa ?? 5;
    }
    
    grenadeentnum = self getentitynumber();
    
    if ( self.bundle.var_c7709714d768097c && self.weapon_object hasattachmenthash( self.bundle.var_c7709714d768097c ) )
    {
        var_b2df48f9f91e6cfb = level.sensorgrenadebundle.var_8bf563eac1069f56 ?? 1.2;
        awarenessrange *= var_b2df48f9f91e6cfb;
        projectilerange *= var_b2df48f9f91e6cfb;
    }
    
    if ( self.bundle.var_e36b84555e7df1d3 && self.weapon_object hasattachmenthash( self.bundle.var_e36b84555e7df1d3 ) )
    {
        self.var_1c66fc2ea253c2a4 = 1;
    }
    
    while ( self.bulletleft > 0 && !self.isdying && !self.isjammed )
    {
        var_e9f245b8221e1e45 = 0;
        var_411f2467e9a5214f = 0;
        
        if ( self.var_30656af96b2ac2a4.size > 0 )
        {
            if ( self.var_4c8db6072e69d191 )
            {
                self.var_e9f245b8221e1e45 = self.var_34d5be132068dd5 * self.var_30656af96b2ac2a4.size;
                self.var_411f2467e9a5214f = self.var_31b2148b669e7beb * self.var_30656af96b2ac2a4.size;
            }
            else
            {
                self.var_e9f245b8221e1e45 = self.var_34d5be132068dd5;
                self.var_411f2467e9a5214f = self.var_31b2148b669e7beb;
            }
        }
        
        candidates = self.bundle.var_6c90beb751ba2ced || level.var_6a8434dc97e87103 ? getplayersandaiarrayinradius( self.origin, awarenessrange + var_e9f245b8221e1e45 ) : getplayersinradius( self.origin, awarenessrange + var_e9f245b8221e1e45 );
        
        foreach ( ent in candidates )
        {
            if ( !ent )
            {
                assertmsg( "<dev string:x43>" );
                continue;
            }
            
            if ( ent.isjuggernaut && self.bundle.var_abf9c59406f0d018 )
            {
                continue;
            }
            
            var_877d02ea00dfe071 = 0;
            
            if ( player::isreallyalive( ent ) && owner.team != ent.team && !isdefined( ent.perks[ "specialty_blindeye" ] ) )
            {
                tracepoint = function_65ae3003a19bc5af( ent );
                
                if ( tracepoint )
                {
                    var_877d02ea00dfe071 = 1;
                    
                    if ( !arraycontains( self.var_76d4515a04d0ef12, ent ) )
                    {
                        self.var_76d4515a04d0ef12[ self.var_76d4515a04d0ef12.size ] = ent;
                        owner callback::callback( #"sensor_grenade_watch_enemy", { #objweapon:self.weapon_object, #idamage:0, #inflictor:owner, #attacker:owner, #victim:ent } );
                        starttargeting( ent, projectilerange + var_411f2467e9a5214f );
                    }
                }
            }
            
            if ( !var_877d02ea00dfe071 && ent && arraycontains( self.var_76d4515a04d0ef12, ent ) )
            {
                if ( ent.sensorgrenadelasers[ grenadeentnum ] )
                {
                    ent.sensorgrenadelasers[ grenadeentnum ] delete();
                    ent.sensorgrenadelasers[ grenadeentnum ] = undefined;
                }
                
                self.var_76d4515a04d0ef12 = arrayremove( self.var_76d4515a04d0ef12, ent );
            }
        }
        
        foreach ( ent in self.var_76d4515a04d0ef12 )
        {
            if ( !ent )
            {
                self.var_76d4515a04d0ef12 = arrayremove( self.var_76d4515a04d0ef12, ent );
                continue;
            }
            
            if ( !player::isreallyalive( ent ) )
            {
                self.var_76d4515a04d0ef12 = arrayremove( self.var_76d4515a04d0ef12, ent );
                continue;
            }
            
            if ( distance2dsquared( self.origin, ent.origin ) > squared( awarenessrange + var_e9f245b8221e1e45 ) )
            {
                self.var_76d4515a04d0ef12 = arrayremove( self.var_76d4515a04d0ef12, ent );
                
                if ( ent.sensorgrenadelasers[ grenadeentnum ] )
                {
                    ent.sensorgrenadelasers[ grenadeentnum ] delete();
                    ent.sensorgrenadelasers[ grenadeentnum ] = undefined;
                }
            }
        }
        
        waitframe();
    }
    
    if ( self.isjammed )
    {
        return;
    }
    
    if ( self && !self.isdying )
    {
        thread destroy_sensor_grenade( undefined );
    }
}

// Namespace sensor_grenade
// Params 1, eflags: 0xc
// Checksum 0x7cbb2315, Offset: 0xfe4
// Size: 0xf5
function private watchdeath( owner )
{
    self notify( #"hash_9d3f2b3b6ead9c46" );
    self endon( #"hash_9d3f2b3b6ead9c46" );
    level endon( #"game_ended" );
    owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"grenade_hacked" );
    lifetime = level.sensorgrenadebundle.var_238545fecca4b37 ?? 20;
    
    if ( self.bundle.var_c7709714d768097c && self.weapon_object hasattachmenthash( self.bundle.var_c7709714d768097c ) )
    {
        lifetime *= level.sensorgrenadebundle.var_e46c02e8aea75087 ?? 1.2;
    }
    
    wait lifetime;
    
    if ( self && !self.isdying )
    {
        thread destroy_sensor_grenade( undefined, 1 );
    }
}

// Namespace sensor_grenade
// Params 2, eflags: 0x4
// Checksum 0xbecac489, Offset: 0x10e1
// Size: 0x8f
function private starttargeting( ent, var_f722a3b01f77bcbc )
{
    if ( ent.var_1f4aa153cbdc3919 || ent.sensorgrenadetracker )
    {
        return;
    }
    
    if ( isdefined( ent.var_c9b559b555a97062 ) && gettime() - ent.var_c9b559b555a97062 < ( level.sensorgrenadebundle.var_c7fcce670ae72e53 ?? 60 ) * 1000 )
    {
        return;
    }
    
    ent.var_1f4aa153cbdc3919 = 1;
    thread targetingent( ent, var_f722a3b01f77bcbc );
}

// Namespace sensor_grenade
// Params 2, eflags: 0x4
// Checksum 0x37c5bd42, Offset: 0x1178
// Size: 0x2fb
function private targetingent( ent, var_f722a3b01f77bcbc )
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self endon( #"death", #"grenade_hacked" );
    ent endon( #"death_or_disconnect" );
    time = 0;
    
    if ( !isdefined( ent.sensorgrenadelasers ) )
    {
        ent.sensorgrenadelasers = [];
    }
    
    grenadeentnum = self getentitynumber();
    var_fee77ae7fcaf16f7 = level.sensorgrenadebundle.var_2f8353ce63915c24 ?? 0.4;
    var_cba542ae63a0a2a9 = level.sensorgrenadebundle.var_29738bee72f2fcc4 ?? 0.25;
    var_fc726df3a12ea3ec = var_fee77ae7fcaf16f7 - var_cba542ae63a0a2a9;
    var_3c296a2632f9b39 = level.sensorgrenadebundle.var_1ad2b5356990eeaa ?? 1;
    var_ec97ee52a3013195 = 0;
    ent playlocalsound( "eqp_sensor_grenade_tripped" );
    var_cdb915b4b83f7522 = squared( var_f722a3b01f77bcbc );
    
    while ( true )
    {
        if ( self.isdying || !player::isreallyalive( ent ) || !arraycontains( self.var_76d4515a04d0ef12, ent ) || self.isjammed )
        {
            ent.var_1f4aa153cbdc3919 = 0;
            
            if ( ent.sensorgrenadelasers[ grenadeentnum ] )
            {
                ent.sensorgrenadelasers[ grenadeentnum ] delete();
                ent.sensorgrenadelasers[ grenadeentnum ] = undefined;
            }
            
            return;
        }
        
        if ( time >= var_3c296a2632f9b39 && distance2dsquared( self.origin, ent.origin ) < var_cdb915b4b83f7522 )
        {
            if ( ent.sensorgrenadelasers[ grenadeentnum ] )
            {
                ent.sensorgrenadelasers[ grenadeentnum ] delete();
                ent.sensorgrenadelasers[ grenadeentnum ] = undefined;
            }
            
            break;
        }
        
        if ( !var_ec97ee52a3013195 )
        {
            ent.sensorgrenadelasers[ grenadeentnum ] = function_f5f8abcd7522eee2( level._effect[ "sensor_grenade_laser_beam" ], self.origin, ( ent utility::function_f02ebab438642e16() + ent utility::function_68061c3d21a6d57a() ) * 0.5 );
            time += var_cba542ae63a0a2a9;
            wait var_cba542ae63a0a2a9;
        }
        else
        {
            if ( ent.sensorgrenadelasers[ grenadeentnum ] )
            {
                ent.sensorgrenadelasers[ grenadeentnum ] delete();
                ent.sensorgrenadelasers[ grenadeentnum ] = undefined;
            }
            
            time += var_fc726df3a12ea3ec;
            wait var_fc726df3a12ea3ec;
        }
        
        var_ec97ee52a3013195 = !var_ec97ee52a3013195;
    }
    
    thread utility::callsharedfunc( #"analytics", #"hash_c7076e2f7f3569a0", { #victim:ent, #attacker:self.owner, #grenade:self } );
    self.owner thread function_67e5ebe9004da4ee( self, ent );
}

// Namespace sensor_grenade
// Params 2, eflags: 0x4
// Checksum 0xa007be53, Offset: 0x147b
// Size: 0x3bc
function private function_67e5ebe9004da4ee( grenade, targetent )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    grenade endon( #"grenade_hacked" );
    
    if ( !grenade )
    {
        return;
    }
    
    var_1c66fc2ea253c2a4 = grenade.var_1c66fc2ea253c2a4;
    grenadeentnum = grenade.entnum ?? utility::get_entity_number( grenade );
    grenadeweaponobj = grenade.weapon_object;
    grenade.bulletleft--;
    grenade setscriptablepartstate( #"fx", #"launch" );
    startpoint = grenade.origin;
    var_62f0c02022e3b913 = ( targetent utility::function_f02ebab438642e16() + targetent utility::function_68061c3d21a6d57a() ) * 0.5;
    forwardvector = vectornormalize( var_62f0c02022e3b913 - startpoint );
    playfx( level._effect[ "sensor_grenade_muzzle" ], startpoint, forwardvector );
    targetent.var_1f4aa153cbdc3919 = 0;
    targetent.sensorgrenadetracker = { #weaponobj:grenadeweaponobj, #entityid:grenadeentnum, #enemyowner:self, #owner:targetent };
    telemetry_mp::function_594cbdc6a4d8098a( targetent, self, grenadeweaponobj, grenadeentnum );
    thread gamelogic_mp::threadedsetweaponstatbyname( grenadeweaponobj, 1, "special_hits" );
    wait 0.5;
    
    if ( var_1c66fc2ea253c2a4 )
    {
        aliveallies = teams::getfriendlyplayers( self.team, 1 );
        
        foreach ( ally in aliveallies )
        {
            ally playlocalsound( "eqp_sensor_grenade_tagged" );
        }
    }
    else if ( player::isreallyalive( self ) )
    {
        self playlocalsound( "eqp_sensor_grenade_tagged" );
    }
    
    thread points::doscoreevent( #"hash_e772e4d4e5c99c84", grenadeweaponobj );
    thread damagefeedback::updatedamagefeedback( "hitequip", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 2 );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "sensorGrenadeTags" ] ) )
        {
            self.leaderboarddata[ "sensorGrenadeTags" ] = self.leaderboarddata[ "sensorGrenadeTags" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "sensorGrenadeTags" ] ) )
        {
            [[ level.leaderboardfunc[ "sensorGrenadeTags" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x6f>" );
        
        if ( isdefined( self.pers[ "sensorGrenadeTags" ] ) )
        {
            self.pers[ "sensorGrenadeTags" ] = self.pers[ "sensorGrenadeTags" ] + 1;
        }
    }
    
    hitmarkersoundalias = utility::callsharedfunc( #"hud", #"hash_785d65fc31ffd85", 0 );
    
    if ( hitmarkersoundalias )
    {
        self playlocalsound( hitmarkersoundalias );
    }
    
    if ( !targetent )
    {
        return;
    }
    
    if ( player::isreallyalive( targetent ) )
    {
        if ( isplayer( targetent ) )
        {
            targetent playlocalsound( "eqp_sensor_grenade_online" );
            targetent damage_effects::playerdamageeffects( 1, grenade, self, targetent, "MOD_IMPACT", undefined, 0, undefined, "torso_upper" );
            targetent setclientomnvar( "ui_grenade_tagged_notify", gettime() );
        }
        
        targetent thread function_82a01d3b66219164( self, var_1c66fc2ea253c2a4 );
        return;
    }
    
    targetent thread function_87dedd8a7353a458();
}

// Namespace sensor_grenade
// Params 2, eflags: 0xc
// Checksum 0xae9fa5c5, Offset: 0x183f
// Size: 0x312
function private function_82a01d3b66219164( enemyowner, var_1c66fc2ea253c2a4 )
{
    self notify( #"hash_1473e299df7f8b48" );
    self endon( #"hash_1473e299df7f8b48" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"sensor_grenade_tracker_destroyed" );
    self.var_c9b559b555a97062 = gettime();
    time = 0;
    radius = 20;
    pinginterval = level.sensorgrenadebundle.var_4a65e96e04ecbe3e ?? 2.5;
    fadetime = level.sensorgrenadebundle.var_5684dc2d43329678 ?? 1;
    assert( fadetime < pinginterval, "<dev string:x95>" );
    expiretime = level.sensorgrenadebundle.var_c2cbb198af8df985 ?? 25;
    var_bfad811bac7c2ef3 = 100;
    radarstrength = -1;
    self.var_5d1b8f6d96fc0127 = self.var_5d1b8f6d96fc0127 ?? [];
    
    if ( var_1c66fc2ea253c2a4 )
    {
        var_51b3f2faa57d7ee8 = 1;
        self.var_236adc9556c1eb4f = outline::outlineenableforteam( self, enemyowner.team, "sensor_grenade", "equipment", undefined, undefined, var_51b3f2faa57d7ee8 );
        
        foreach ( p in level.players )
        {
            if ( !isbot( p ) && p.team == enemyowner.team )
            {
                p scripted_widgets::anchored_add( self, "sensor_grenade", "scripted_widget_sensor_scanner_box", "scripted_widget_bounding_box" );
                p scripted_widgets::anchored_set_state( self, "sensor_grenade", "Show" );
                self.var_5d1b8f6d96fc0127[ self.var_5d1b8f6d96fc0127.size ] = p;
                self.var_4193d1557ef26d9[ p getentitynumber() ] = gettime();
            }
        }
    }
    else
    {
        self.var_236adc9556c1eb4f = outline::outlineenableforplayer( self, enemyowner, "sensor_grenade", "equipment" );
        enemyowner scripted_widgets::anchored_add( self, "sensor_grenade", "scripted_widget_sensor_scanner_box", "scripted_widget_bounding_box" );
        enemyowner scripted_widgets::anchored_set_state( self, "sensor_grenade", "Show" );
        self.var_5d1b8f6d96fc0127[ self.var_5d1b8f6d96fc0127.size ] = enemyowner;
        self.var_4193d1557ef26d9[ enemyowner getentitynumber() ] = gettime();
    }
    
    if ( isplayer( self ) )
    {
        thread function_8002e90959fb88e2();
    }
    
    do
    {
        time += pinginterval;
        triggerportableradarpingteam( self.origin, enemyowner.team, radius, var_bfad811bac7c2ef3, radarstrength, fadetime );
        wait pinginterval;
    }
    while ( time < expiretime && enemyowner );
    
    if ( self )
    {
        thread function_87dedd8a7353a458();
    }
}

// Namespace sensor_grenade
// Params 1, eflags: 0x4
// Checksum 0x61651753, Offset: 0x1b59
// Size: 0xbc
function private onplayerspawned( params )
{
    if ( self.sensorgrenades )
    {
        foreach ( sensorgrenade in self.sensorgrenades )
        {
            if ( sensorgrenade )
            {
                sensorgrenade thread destroy_sensor_grenade( undefined );
            }
        }
        
        self.sensorgrenades = undefined;
    }
    
    self.sensorgrenadetracker = undefined;
    self.var_c9b559b555a97062 = undefined;
    function_93f924ef4c23c667();
}

// Namespace sensor_grenade
// Params 0, eflags: 0xc
// Checksum 0x4083c53a, Offset: 0x1c1d
// Size: 0x15f
function private function_8002e90959fb88e2()
{
    self notify( #"hash_d1dd709135bb8a52" );
    self endon( #"hash_d1dd709135bb8a52" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    val::set( "sensor_grenade", "weapon_pickup", 0 );
    var_a2b0f8f03b5f6a5b = ( level.sensorgrenadebundle.var_214c68fdc210d10e ?? 0.15 ) * 1000;
    function_7a92bad2896b40fb( var_a2b0f8f03b5f6a5b );
    var_f8c5b357c370c3c = 0;
    startpresstime = undefined;
    
    while ( self.sensorgrenadetracker )
    {
        currtime = gettime();
        
        if ( self usebuttonpressed() )
        {
            if ( !isdefined( startpresstime ) )
            {
                startpresstime = currtime;
            }
        }
        else
        {
            startpresstime = undefined;
        }
        
        if ( startpresstime && currtime - startpresstime >= var_a2b0f8f03b5f6a5b )
        {
            var_f8c5b357c370c3c = 1;
            thread utility::function_72b6372d2d8c997( "sat_sensor_grenade_tracker_mp" );
            self setmovespeedscale( level.sensorgrenadebundle.var_6bcae2700676d81f ?? 0.5 );
            break;
        }
        
        waitframe();
    }
    
    val::reset( "sensor_grenade", "weapon_pickup" );
    
    if ( var_f8c5b357c370c3c )
    {
        thread points::doscoreevent( #"hash_5760954f61b40374" );
        self playlocalsound( "eqp_sensor_grenade_remove" );
        wait 1;
        wait 0.5;
        self setmovespeedscale( 1 );
    }
    
    if ( self.sensorgrenadetracker )
    {
        thread function_87dedd8a7353a458();
    }
}

// Namespace sensor_grenade
// Params 1, eflags: 0x4
// Checksum 0xe42f963d, Offset: 0x1d84
// Size: 0x6b
function private function_b3453b585143e886( params )
{
    self.sensor_grenade_rapid_kills = undefined;
    
    if ( self.sensorgrenadelasers )
    {
        utility::array_delete( self.sensorgrenadelasers );
        self.sensorgrenadelasers = undefined;
    }
    
    if ( self.sensorgrenadetracker )
    {
        thread function_87dedd8a7353a458();
        self setmovespeedscale( 1 );
        val::reset( "sensor_grenade", "weapon_pickup" );
    }
}

// Namespace sensor_grenade
// Params 1
// Checksum 0xb7376514, Offset: 0x1df7
// Size: 0x1ca
function function_45db61559313c6bf( params )
{
    sensorgrenadetracker = params.victim.sensorgrenadetracker;
    
    if ( sensorgrenadetracker.enemyowner )
    {
        self.modifiers[ "wasSpottedBySensorGrenadeTracker" ] = sensorgrenadetracker;
        
        if ( self == sensorgrenadetracker.enemyowner )
        {
            self.modifiers[ "wasSpottedBySensorGrenade" ] = 1;
            
            if ( !isdefined( self.sensor_grenade_rapid_kills[ sensorgrenadetracker.entityid ] ) )
            {
                self.sensor_grenade_rapid_kills[ sensorgrenadetracker.entityid ] = 0;
            }
            
            self.sensor_grenade_rapid_kills[ sensorgrenadetracker.entityid ]++;
            
            if ( self.sensor_grenade_rapid_kills[ sensorgrenadetracker.entityid ] == 2 )
            {
                self.modifiers[ "wasSecondSensorGrenadeKill" ] = 1;
            }
            
            utility::function_a9cdce367aa4fef5( "sensor_grenade_rapid_kill_" + sensorgrenadetracker.entityid, 2, #"death_or_disconnect", &function_2e1ac3a19ffc1303, sensorgrenadetracker.entityid );
            return;
        }
        
        if ( !player_utility::playersareenemies( sensorgrenadetracker.enemyowner, self ) )
        {
            if ( !isdefined( self.modifiers[ "wasSpottedByAnotherSensorGrenadeList" ] ) )
            {
                self.modifiers[ "wasSpottedByAnotherSensorGrenadeList" ] = [];
            }
            
            if ( !function_978bde7975eb37( self.modifiers[ "wasSpottedByAnotherSensorGrenadeList" ], sensorgrenadetracker.enemyowner ) )
            {
                var_32687339cd7ffa62 = { #sensorgrenadeweapon:sensorgrenadetracker.weaponobj, #player:sensorgrenadetracker.enemyowner };
                self.modifiers[ "wasSpottedByAnotherSensorGrenadeList" ][ self.modifiers[ "wasSpottedByAnotherSensorGrenadeList" ].size ] = var_32687339cd7ffa62;
            }
        }
    }
}

// Namespace sensor_grenade
// Params 1
// Checksum 0xbebb9281, Offset: 0x1fc9
// Size: 0x105
function onplayerelim( params )
{
    if ( self.modifiers[ "wasSpottedBySensorGrenade" ] )
    {
        thread points::doscoreevent( #"hash_22f58dfc42f76fff", self.modifiers[ "wasSpottedBySensorGrenadeTracker" ].weaponobj );
        
        if ( self.modifiers[ "wasSecondSensorGrenadeKill" ] )
        {
            thread points::doscoreevent( #"double_prox_alarm" );
        }
    }
    
    foreach ( struct in self.modifiers[ "wasSpottedByAnotherSensorGrenadeList" ] )
    {
        struct.player thread points::doscoreevent( #"hash_e935d9231c8357cc", struct.sensorgrenadeweapon );
    }
}

// Namespace sensor_grenade
// Params 2
// Checksum 0xa3af2c78, Offset: 0x20d6
// Size: 0x93, Type: bool
function function_978bde7975eb37( structarray, targetplayer )
{
    foreach ( struct in structarray )
    {
        if ( struct.player == targetplayer )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace sensor_grenade
// Params 1, eflags: 0x4
// Checksum 0x5a08efe6, Offset: 0x2172
// Size: 0xc7
function private onplayerdisconnect( params )
{
    if ( self.sensorgrenadelasers )
    {
        utility::array_delete( self.sensorgrenadelasers );
        self.sensorgrenadelasers = undefined;
    }
    
    if ( self.sensorgrenades )
    {
        foreach ( sensorgrenade in self.sensorgrenades )
        {
            if ( sensorgrenade )
            {
                sensorgrenade thread destroy_sensor_grenade( undefined );
            }
        }
        
        self.sensorgrenades = undefined;
    }
}

// Namespace sensor_grenade
// Params 1, eflags: 0x4
// Checksum 0x9cae4325, Offset: 0x2241
// Size: 0x29
function private onplayerdeath( deathdata )
{
    ondeath( deathdata.attacker, deathdata.victim );
}

// Namespace sensor_grenade
// Params 1, eflags: 0x4
// Checksum 0x83198d93, Offset: 0x2272
// Size: 0x29
function private onagentdeath( deathdata )
{
    ondeath( deathdata.eattacker, deathdata.victim );
}

// Namespace sensor_grenade
// Params 2, eflags: 0x4
// Checksum 0x9ac28f5c, Offset: 0x22a3
// Size: 0x5a
function private ondeath( attacker, victim )
{
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    sensorgrenadetracker = victim.sensorgrenadetracker;
    
    if ( !sensorgrenadetracker )
    {
        return;
    }
    
    attacker.var_95a789937b05993d = 1;
}

// Namespace sensor_grenade
// Params 1
// Checksum 0x9ccccb30, Offset: 0x2305
// Size: 0x253
function addbuff( params )
{
    if ( !self || self.isdying || !isarray( self.var_30656af96b2ac2a4 ) )
    {
        return;
    }
    
    self.var_30656af96b2ac2a4[ self.var_30656af96b2ac2a4.size ] = params.combatlink;
    
    if ( !self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] )
    {
        basepoints = rank::getscoreinfovalue( #"hash_8133aa87520f50f6" ) ?? 0;
        params.combatlink.owner thread points::doscoreevent( #"hash_8133aa87520f50f6", params.combatlink.weapon_object, basepoints * params.combatlink.var_352099d9d2836866 );
        
        if ( !isdefined( self.var_2695e71ddf32816c ) )
        {
            self.var_2695e71ddf32816c = [];
        }
        
        self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] = 1;
    }
    
    if ( params.combatlink.owner != self.owner && !self.var_2b2f786d6b12c032 )
    {
        self.owner thread points::doscoreevent( #"hash_25e1629f3588e56f", params.combatlink.weapon_object );
        self.var_2b2f786d6b12c032 = 1;
    }
    
    if ( self.var_30656af96b2ac2a4.size == 1 )
    {
        self.var_34d5be132068dd5 = params.bundle.var_e8ed71e7337d6be5 ?? 100;
        self.var_31b2148b669e7beb = params.bundle.var_d4d519984831ed7b ?? 100;
        self.var_4c8db6072e69d191 = params.bundle.var_be18e85d3d3c1f9c ?? 0;
        
        if ( isdefined( self.headiconid ) && isdefined( level.sensorgrenadebundle.buffedheadicon ) )
        {
            setheadiconimage( self.headiconid, level.sensorgrenadebundle.buffedheadicon, 1 );
        }
    }
}

// Namespace sensor_grenade
// Params 1
// Checksum 0x3e95d68f, Offset: 0x2560
// Size: 0xe3
function removebuff( params )
{
    if ( !self || self.isdying || !isarray( self.var_30656af96b2ac2a4 ) )
    {
        return;
    }
    
    if ( !arraycontains( self.var_30656af96b2ac2a4, params.combatlink ) )
    {
        return;
    }
    
    self.var_30656af96b2ac2a4 = arrayremove( self.var_30656af96b2ac2a4, params.combatlink );
    
    if ( self.var_30656af96b2ac2a4.size <= 0 )
    {
        self.var_34d5be132068dd5 = undefined;
        self.var_31b2148b669e7beb = undefined;
        self.var_4c8db6072e69d191 = undefined;
        
        if ( isdefined( self.headiconid ) && isdefined( level.gamemodebundle.var_b96d2dfbabc4742d ) )
        {
            setheadiconimage( self.headiconid, level.gamemodebundle.var_b96d2dfbabc4742d, 1 );
        }
    }
}

// Namespace sensor_grenade
// Params 2
// Checksum 0xf434f632, Offset: 0x264b
// Size: 0x22f
function destroy_sensor_grenade( damagedata, isexpired )
{
    self notify( #"hash_e1fe702b0f617359" );
    self endon( #"hash_e1fe702b0f617359" );
    
    if ( self && !self.isdying )
    {
        grenadeentnum = self getentitynumber();
        utility::callsharedfunc( #"jamming_system", #"hash_c33ceb91d0ca7a9d", self );
        
        foreach ( ent in self.var_76d4515a04d0ef12 )
        {
            if ( ent.sensorgrenadelasers[ grenadeentnum ] )
            {
                ent.sensorgrenadelasers[ grenadeentnum ] delete();
                ent.sensorgrenadelasers[ grenadeentnum ] = undefined;
            }
            
            ent.var_1f4aa153cbdc3919 = 0;
        }
        
        if ( isdefined( self.headiconid ) )
        {
            entityheadicons::setheadicon_deleteicon( self.headiconid );
        }
        
        if ( damagedata.attacker )
        {
            attackingplayer = function_5a141b233dd73c90( damagedata.attacker, self );
            
            if ( attackingplayer && attackingplayer != self.owner )
            {
                attackingplayer thread points::doscoreevent( #"hash_fc2bc69127096d9e", damagedata.objweapon );
            }
        }
        
        if ( weapon::function_89d2d0588f2def25() )
        {
            weapon::deregistermine();
        }
        
        if ( isexpired )
        {
            self setscriptablepartstate( #"visual", #"expired" );
        }
        else
        {
            self setscriptablepartstate( #"visual", #"explode" );
        }
        
        self setscriptablepartstate( #"model_visibility", #"hidden" );
        self setscriptablepartstate( #"sfx", #"idle_beep_off" );
        self notify( #"death" );
        self.isdying = 1;
        wait 0.1;
        
        if ( self )
        {
            self delete();
        }
    }
}

// Namespace sensor_grenade
// Params 0, eflags: 0xc
// Checksum 0x8f7cb27b, Offset: 0x2882
// Size: 0x7a
function private function_87dedd8a7353a458()
{
    self notify( #"hash_1004725196241c67" );
    self endon( #"hash_1004725196241c67" );
    
    if ( !self.sensorgrenadetracker )
    {
        return;
    }
    
    self notify( #"sensor_grenade_tracker_destroyed" );
    function_d7f43e8d3c70a92();
    function_93f924ef4c23c667();
    telemetry_mp::function_edb43d25c7bd56c6( self, self.sensorgrenadetracker.weaponobj, self.sensorgrenadetracker.entityid );
    self.sensorgrenadetracker = undefined;
}

// Namespace sensor_grenade
// Params 1, eflags: 0x4
// Checksum 0x25728fae, Offset: 0x2904
// Size: 0xd8
function private function_65ae3003a19bc5af( target )
{
    if ( !target )
    {
        return 0;
    }
    
    tracecontents = trace::create_contents( 0, 1, 0, 0, 1, 1, 0, 1 );
    defaultorigin = target.origin;
    headpos = target utility::function_f02ebab438642e16();
    centerpos = target utility::function_68061c3d21a6d57a();
    tracepoints = [ centerpos, headpos, defaultorigin ];
    ignorelist = [ self, target ];
    
    for ( i = 0; i < tracepoints.size ; i++ )
    {
        if ( !trace::ray_trace_passed( self.origin, tracepoints[ i ], ignorelist, tracecontents ) )
        {
            continue;
        }
        
        return tracepoints[ i ];
    }
}

// Namespace sensor_grenade
// Params 2, eflags: 0x4
// Checksum 0x36f863f3, Offset: 0x29e5
// Size: 0x81
function private function_5a141b233dd73c90( attacker, instance )
{
    attackingplayer = undefined;
    
    if ( isplayer( attacker ) )
    {
        attackingplayer = attacker;
    }
    else if ( isplayer( attacker.owner ) )
    {
        attackingplayer = attacker.owner;
    }
    
    if ( !attackingplayer || !instance.owner )
    {
        return;
    }
    
    if ( weapons::friendlyfirecheck( instance.owner, attackingplayer ) )
    {
        return attackingplayer;
    }
}

// Namespace sensor_grenade
// Params 0, eflags: 0x4
// Checksum 0xc71464, Offset: 0x2a6f
// Size: 0xbf
function private function_93f924ef4c23c667()
{
    if ( isdefined( self.var_236adc9556c1eb4f ) )
    {
        outline::outlinedisable( self.var_236adc9556c1eb4f, self );
        self.var_236adc9556c1eb4f = undefined;
    }
    
    if ( self.var_5d1b8f6d96fc0127 )
    {
        foreach ( p in self.var_5d1b8f6d96fc0127 )
        {
            p scripted_widgets::anchored_remove( self, "sensor_grenade" );
        }
        
        self.var_5d1b8f6d96fc0127 = undefined;
    }
}

// Namespace sensor_grenade
// Params 2, eflags: 0x4
// Checksum 0xbb3b415c, Offset: 0x2b36
// Size: 0x176
function private hack( hackeffect, attacker )
{
    self notify( #"grenade_hacked" );
    
    if ( !hackeffect.var_30e7de3d76d5a085 )
    {
        return;
    }
    
    self.owner thread equipment_utility::function_364a1a0e0c018518( self.equipmentref, #"stolen_hacked" );
    self.owner = attacker;
    self.team = attacker.team;
    self setentityowner( attacker );
    self setotherent( attacker );
    
    if ( self.var_76d4515a04d0ef12 )
    {
        foreach ( ent in self.var_76d4515a04d0ef12 )
        {
            self.var_76d4515a04d0ef12 = arrayremove( self.var_76d4515a04d0ef12, ent );
            ent.var_1f4aa153cbdc3919 = 0;
        }
    }
    
    self setscriptablepartstate( #"hacked", #"stolen", 0 );
    thread watchenemies( attacker );
    thread watchdeath( attacker );
    
    if ( level.teambased )
    {
        self filteroutplayermarks( attacker.team );
        return;
    }
    
    self filteroutplayermarks( attacker );
}

// Namespace sensor_grenade
// Params 1, eflags: 0x4
// Checksum 0xdbb351e8, Offset: 0x2cb4
// Size: 0x15
function private onemped( empstruct )
{
    thread destroy_sensor_grenade( empstruct );
}

// Namespace sensor_grenade
// Params 1, eflags: 0x4
// Checksum 0xa6588f49, Offset: 0x2cd1
// Size: 0x53
function private function_7fb670e194c3f1eb( grenade )
{
    if ( grenade && !grenade.isdying )
    {
        grenade setscriptablepartstate( #"visual", #"jammed" );
        grenade setscriptablepartstate( #"sfx", #"idle_beep_off" );
    }
}

// Namespace sensor_grenade
// Params 1, eflags: 0x4
// Checksum 0x4777280d, Offset: 0x2d2c
// Size: 0x4e
function private function_50c48f547b740df9( grenade )
{
    if ( grenade && !grenade.isdying )
    {
        grenade setscriptablepartstate( #"visual", #"visible" );
        grenade thread watchenemies( grenade.owner );
    }
}

// Namespace sensor_grenade
// Params 2, eflags: 0x4
// Checksum 0x2d684613, Offset: 0x2d82
// Size: 0x5e
function private function_4d438c9d0219d9e2( player, hintent )
{
    hintent endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"connected", p );
        
        if ( p != player )
        {
            hintent disableplayeruse( p );
        }
    }
}

// Namespace sensor_grenade
// Params 1, eflags: 0x4
// Checksum 0x7211a4b8, Offset: 0x2de8
// Size: 0xe3
function private function_7a92bad2896b40fb( removeholdtime )
{
    if ( isbot( self ) )
    {
        return;
    }
    
    if ( !self.var_8f89350e2cbd8c50 )
    {
        fov = 360;
        range = 100;
        hintent = spawn( "script_origin", self.origin );
        hintent linkto( self, "tag_origin" );
        hintent makeusable();
        hintent sethintstring( &"sat_equipment/sensor_grenade_remove" );
        hintent sethintonobstruction( "show" );
        hintent sethintdisplayfov( fov );
        hintent setusefov( fov );
        hintent sethintdisplayrange( range );
        hintent setuserange( range );
        hintent setusepriority( -4 );
        hintent disableplayeruseforallplayers();
        hintent enableplayeruse( self );
        
        if ( removeholdtime )
        {
            hintent setuseholdduration( removeholdtime );
        }
        
        thread function_4d438c9d0219d9e2( self, hintent );
        self.var_8f89350e2cbd8c50 = hintent;
    }
}

// Namespace sensor_grenade
// Params 0, eflags: 0x4
// Checksum 0xb38853bf, Offset: 0x2ed3
// Size: 0x26
function private function_d7f43e8d3c70a92()
{
    if ( self.var_8f89350e2cbd8c50 )
    {
        self.var_8f89350e2cbd8c50 delete();
        self.var_8f89350e2cbd8c50 = undefined;
    }
}

// Namespace sensor_grenade
// Params 1
// Checksum 0x50aff445, Offset: 0x2f01
// Size: 0x18
function function_2e1ac3a19ffc1303( sensorgrenadeid )
{
    self.sensor_grenade_rapid_kills[ sensorgrenadeid ] = undefined;
}

