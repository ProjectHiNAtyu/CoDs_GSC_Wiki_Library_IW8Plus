// scripts\mp\common\supers\drone_launcher.gsc  (hash_4d0423a04b5e07d6.gscc) (size: 35240 Bytes / 0x89a8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x52eb1b8d (1391139725)
// size ...... 35240 (0x89a8)
// includes .. 28  (offset: 0x8374)
// strings ... 61  (offset: 0x8454)
// dev strs .. 22  (offset: 0x886c)
// exports ... 74  (offset: 0x5904)
// cseg ...... 0x5a8 + 0x535c (0x5904)
// imports ... 253 (offset: 0x6494)
// animtree1 . 0   (offset: 0x89a8)
// animtree2 . 0   (offset: 0x89a8)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\scriptable;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_roads;
#using scripts\common\vehicle_tracking;
#using scripts\common\weapon;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\equipment_interact;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace drone_launcher;

// Namespace drone_launcher
// Params 0, eflags: 0x5
// Checksum 0xc56ed777, Offset: 0x5c6
// Size: 0x44
function private autoexec main()
{
    level callback::add( #"register_super", &init );
    level callback::add( #"hash_244314ef9125e636", &onplayerdeath );
    level callback::add( #"player_damaged", &onplayerdamaged );
}

// Namespace drone_launcher
// Params 1
// Checksum 0x35f27ac5, Offset: 0x612
// Size: 0x109
function init( params )
{
    if ( !isdefined( supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" ) ) )
    {
        return;
    }
    
    supers_mp::function_48aaa60b2ce7b8a1( "super_drone_launcher", undefined, undefined, &begin_use );
    weapons::registerusedcallback( #"drone_launcher", &used );
    weapons::function_2cd25260a11d5e40( #"drone_launcher", &onpullback );
    utility::registersharedfunc( #"drone_launcher", #"hack", &function_8c26023bd26169c8 );
    utility::registersharedfunc( #"active_drone", #"hack", &function_ea1d633ed41c456e );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    
    if ( bundle.var_b99a5e45cef63605 > 1 )
    {
        level scriptable::scriptable_addnotifycallback( "drone_reload_finished", &on_reload_finished );
    }
    
    setdvarifuninitialized( @"hash_83cd8e0336b8fec", 0, 0, 1 );
    
    if ( level.var_6ee986c6c0f5d22c )
    {
        setdvar( @"hash_83cd8e0336b8fec", 1 );
    }
    
    /#
        level thread function_bc9eba1afe698427();
    #/
}

/#

    // Namespace drone_launcher
    // Params 0
    // Checksum 0xa6bdee73, Offset: 0x723
    // Size: 0x120, Type: dev
    function function_bc9eba1afe698427()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_drone_launcher_debug_draw", 0 ) && level.var_54c2f5dfe418e393.size > 0 )
            {
                foreach ( trigger in level.var_54c2f5dfe418e393 )
                {
                    if ( trigger && trigger.origin && trigger.radius && trigger.height )
                    {
                        cylinder( trigger.origin, trigger.origin + ( 0, 0, trigger.height ), trigger.radius, ( 1, 1, 0 ), 0 );
                    }
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace drone_launcher
// Params 0
// Checksum 0x8f1ea330, Offset: 0x84b
// Size: 0xae
function begin_use()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    self.var_e70fa9aae35c2659 = bundle.var_e70fa9aae35c2659;
    can_spawn_vehicles = vehicle_tracking::can_spawn_vehicle( bundle.var_daf16bc64663e298 ?? 3 );
    
    if ( can_spawn_vehicles && bundle.var_8b9eade13fbfb044 && !callback::exists( #"super_cancel", &cancel ) )
    {
        assert( !callback::exists( #"super_cancel", &cancel ) );
        callback::add( #"super_cancel", &cancel );
    }
    
    return can_spawn_vehicles;
}

// Namespace drone_launcher
// Params 1, eflags: 0x4
// Checksum 0x8128a8ed, Offset: 0x902
// Size: 0x14c
function private cancel( params )
{
    if ( self.drone_launcher_drones )
    {
        foreach ( drone in self.drone_launcher_drones )
        {
            if ( drone )
            {
                drone thread destroy_drone( undefined, undefined, 1 );
            }
        }
        
        self.drone_launcher_drones = undefined;
    }
    
    foreach ( drone_launcher in self.drone_launchers )
    {
        drone_launcher destroy_launcher( undefined, 1 );
        self.drone_launchers = arrayremove( self.drone_launchers, drone_launcher );
    }
    
    self.drone_launchers = undefined;
    self notify( #"hash_1a8fc861af8758cd" );
}

// Namespace drone_launcher
// Params 1, eflags: 0x4
// Checksum 0xfd116d3d, Offset: 0xa56
// Size: 0x25
function private onpullback( params )
{
    if ( weapon::function_ecbdce6df0e16a2a( #"drone_launcher" ) )
    {
        weapons::denyusage();
    }
}

// Namespace drone_launcher
// Params 1
// Checksum 0x7e1a04fd, Offset: 0xa83
// Size: 0x2dc
function used( launcher )
{
    launcher endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    launcher.superref = "super_drone_launcher";
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    launcher.lifetimeendtime = ( ( bundle.var_551a0d886d7e6e9b ?? 1 ) + get_deploy_interval() * ( bundle.var_daf16bc64663e298 ?? 3 ) ) * 1000 + gettime();
    
    if ( bundle.var_c09bcb03233e2db3 == #"drone_launcher_pro_mod" )
    {
        launcher.var_62c15331b77ebc75 = bundle.var_e36b84555e7df1d3 && launcher.weapon_object hasattachmenthash( bundle.var_e36b84555e7df1d3 );
    }
    
    launcher.var_e463b0a79e72711f = [[ level.sharedfuncs[ #"supers" ][ #"hash_dc23d30a02afb5f0" ] ]]();
    launcher thread weapons::watchkillbordercallback( &destroy_launcher );
    launcher childthread equipment_mp::watchwaterdepth( &destroy_launcher );
    thread function_333f4e9897f3ce58( launcher );
    var_e737a16e85eb1aea = launcher.origin;
    launcher waittill( #"missile_stuck", stuckto );
    
    if ( isent( stuckto ) && stuckto ismovingplatform() )
    {
        launcher linkto( stuckto );
    }
    
    if ( bundle.var_e0943ac1082c6f53 || getdvarint( @"hash_83cd8e0336b8fec", 0 ) )
    {
        if ( !ispointonnavmesh( launcher.origin ) )
        {
            var_821eae838b632875 = 1;
        }
    }
    
    var_e089bd58b8948268 = bundle.var_a0ab78391707dca0;
    
    if ( var_e089bd58b8948268 && distancesquared( launcher.origin, var_e737a16e85eb1aea ) >= pow( var_e089bd58b8948268, 2 ) )
    {
        var_821eae838b632875 = 1;
    }
    
    if ( var_821eae838b632875 )
    {
        thread function_1cf869d8f8075549( launcher, undefined, 1 );
        return;
    }
    
    launcher setup_launcher( self );
    launcher thread activate_launcher();
    
    if ( launcher.bundle.var_bead9b1c34058722 )
    {
        var_aacb78da5016573c = launcher.bundle.var_9d83d7a2c4169a01 ?? 0.3;
        destroyrange = launcher.bundle.var_d698fcfe464f1b17 ?? 128;
        hintstring = launcher.bundle.var_dfc5df4b445d78b1 ?? &"super_mp/destroy_super";
        var_15913c55d463f848 = isagent( launcher.owner );
        launcher thread equipment_interact::function_226793772d245e96( var_aacb78da5016573c, destroyrange, hintstring, launcher.team, var_15913c55d463f848 );
    }
}

// Namespace drone_launcher
// Params 1, eflags: 0xc
// Checksum 0x8b5a8ca3, Offset: 0xd67
// Size: 0x133
function private function_333f4e9897f3ce58( launcher )
{
    self notify( #"hash_79bb6c330354030c" );
    self endon( #"hash_79bb6c330354030c" );
    launcher endon( #"death" );
    self waittill( #"disconnect" );
    
    foreach ( drone in self.drone_launcher_drones )
    {
        drone thread destroy_drone( undefined, 0, 0 );
    }
    
    foreach ( drone_launcher in self.drone_launchers )
    {
        drone_launcher thread destroy_launcher( undefined, 0 );
    }
}

// Namespace drone_launcher
// Params 0
// Checksum 0xc380c5cf, Offset: 0xea2
// Size: 0xba
function activate_launcher()
{
    self endon( #"launcher_hacked" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    utility::function_969f9f5596dba07a( self, &destroy_launcher );
    wait self.bundle.var_551a0d886d7e6e9b ?? 1;
    
    if ( !self.owner callback::exists( #"hash_2346898712859996", &on_modify_player_damage ) )
    {
        self.owner callback::add( #"hash_2346898712859996", &on_modify_player_damage );
    }
    
    self.owner thread function_12aa05888f56a090();
    function_c7620170282b567f( self.bundle );
    thread destroy_launcher();
}

// Namespace drone_launcher
// Params 1, eflags: 0x4
// Checksum 0x68faf529, Offset: 0xf64
// Size: 0x13d
function private function_c7620170282b567f( bundle )
{
    num_batches = function_9c96f6af8e94cee1( bundle );
    deploy_interval = get_deploy_interval();
    
    for ( batch_index = 0; batch_index < num_batches ; batch_index++ )
    {
        num_drones = get_num_drones();
        
        for ( drone_index = 0; drone_index < num_drones ; drone_index++ )
        {
            while ( self.var_3e0f12057afe35e5 || self.isjammed )
            {
                waitframe();
            }
            
            thread function_ce2f163c2b3be6c0( drone_index, batch_index );
            self.launched_drone_count = drone_index + 1;
            currentinterval = max( deploy_interval - ( self.var_9e87e3028beb60bf ?? 0 ), 0 );
            wait currentinterval;
        }
        
        if ( batch_index == 0 && ( bundle.var_e0943ac1082c6f53 || getdvarint( @"hash_83cd8e0336b8fec", 0 ) ) )
        {
            initialdelay = 1.2;
            self.owner thread function_8cb2d155e28c8365( initialdelay );
        }
        
        self.var_b51dfec17165959f = batch_index + 1;
        self.launched_drone_count = 0;
        
        if ( num_batches > 1 )
        {
            handle_reload( batch_index, deploy_interval, num_batches, bundle );
        }
    }
}

// Namespace drone_launcher
// Params 4, eflags: 0x4
// Checksum 0x463c6c89, Offset: 0x10a9
// Size: 0xac
function private handle_reload( batch_index, deploy_interval, num_batches, bundle )
{
    var_2b87c262f2f6c703 = bundle.var_d8ef26152c07a5ed;
    var_800b9fce93437d4 = bundle.var_dcaa06deea0d0bb2;
    should_reload = batch_index < num_batches - 1;
    var_49b14135a0cee227 = should_reload ? var_800b9fce93437d4 : deploy_interval + var_800b9fce93437d4;
    
    if ( should_reload )
    {
        wait var_2b87c262f2f6c703;
        self setscriptablepartstate( #"reload", #"active" );
        self waittill( #"reload_finished" );
    }
    
    wait var_49b14135a0cee227;
}

// Namespace drone_launcher
// Params 4, eflags: 0x4
// Checksum 0x6e79edf, Offset: 0x115d
// Size: 0x33
function private on_reload_finished( instance, note, param, var_64ffacba090c91be )
{
    self notify( #"reload_finished" );
}

// Namespace drone_launcher
// Params 0, eflags: 0x4
// Checksum 0xb587a224, Offset: 0x1198
// Size: 0x68
function private get_num_drones()
{
    num_drones = self.bundle.var_daf16bc64663e298 ?? 3;
    
    if ( self.launched_drone_count )
    {
        num_drones -= self.launched_drone_count;
    }
    
    /#
        var_f5a39cd2dd959f70 = getdvarint( @"hash_6a87e9fdaf1b7cdf", 0 );
        
        if ( var_f5a39cd2dd959f70 > 0 )
        {
            num_drones = var_f5a39cd2dd959f70;
        }
    #/
    
    return num_drones;
}

// Namespace drone_launcher
// Params 0, eflags: 0x4
// Checksum 0xa27bf48e, Offset: 0x1209
// Size: 0x8f
function private get_deploy_interval()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    deploy_interval = bundle.drone_launcher_deploy_interval ?? 3.2;
    
    if ( self.bundle.var_c7709714d768097c && self.weapon_object hasattachmenthash( self.bundle.var_c7709714d768097c ) )
    {
        deploy_interval = self.bundle.var_26ff4cdd43ee1417 ?? 2.3;
    }
    
    return deploy_interval;
}

// Namespace drone_launcher
// Params 1, eflags: 0x4
// Checksum 0xaca9aba4, Offset: 0x12a1
// Size: 0x70
function private function_9c96f6af8e94cee1( bundle )
{
    total_batches = bundle.var_b99a5e45cef63605;
    extra_batches = self.owner utility::callsharedfunc( "super_drone_launcher", #"hash_3e5d87be73b16451" ) ?? 0;
    total_batches += extra_batches;
    final_batches = total_batches - ( self.var_b51dfec17165959f ?? 0 );
    return final_batches;
}

// Namespace drone_launcher
// Params 1
// Checksum 0x77ee1318, Offset: 0x131a
// Size: 0x23a
function setup_launcher( owner )
{
    self setscriptablepartstate( #"visibility", #"show", 0 );
    self.bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    self.issuper = 1;
    self.superref = "super_drone_launcher";
    self.superid = self.bundle.id;
    self.owner = owner;
    self.team = owner.team;
    self.var_30656af96b2ac2a4 = [];
    self.add_buff = &add_buff;
    self.remove_buff = &remove_buff;
    namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( self, &function_b0376966cd0c2c6a );
    utility::callsharedfunc( #"jamming_system", #"hash_ca0042e3cac99672", self, &function_f2fdd019aa1d97a6, &function_655bd8caffa5d850 );
    self.angles = vectortoangles( vectornormalize( ( self.origin - self.spawnpos ) * ( 1, 1, 0 ) ) );
    icondata = entityheadicons::function_76fdf2d96729e6eb( self.bundle );
    icondata.offset = 30;
    imageoverride = self.var_30656af96b2ac2a4.size > 0 ? self.bundle.buffedheadicon : undefined;
    self.headiconid = entityheadicons::setheadicon_fieldupgrade( self, imageoverride, undefined, undefined, icondata );
    max_health = self.bundle.maxhealth ?? 150;
    thread damage::monitordamage( max_health, "hitequip", &destroy_launcher, &function_521d276234d66fba );
    
    if ( !isdefined( owner.drone_launchers ) )
    {
        owner.drone_launchers = [];
    }
    
    owner.drone_launchers[ owner.drone_launchers.size ] = self;
    owner weapons::onequipmentplanted( self, "equip_drone_launcher", &destroy_launcher );
    self setscriptablepartstate( #"activate", #"activate", 0 );
    self setscriptablepartstate( #"active", #"active", 0 );
}

// Namespace drone_launcher
// Params 1
// Checksum 0x6fe174f3, Offset: 0x155c
// Size: 0x8d
function function_521d276234d66fba( damage_data )
{
    if ( function_32c96a48256124b0( damage_data ) )
    {
        damage_data.damage *= self.bundle.var_f5bc1a6e115b9d2 ?? 1;
    }
    
    if ( function_dbfd923950baaf9b( damage_data ) )
    {
        damage_data.damage *= self.bundle.var_801b4d7dd03079a3 ?? 1;
    }
    
    return damage_data.damage;
}

// Namespace drone_launcher
// Params 1
// Checksum 0x20c8f949, Offset: 0x15f2
// Size: 0x32, Type: bool
function function_32c96a48256124b0( damage_data )
{
    return damage_data.inflictor && damage_data.inflictor.ownerlauncher == self;
}

// Namespace drone_launcher
// Params 1
// Checksum 0xe5352ccb, Offset: 0x162d
// Size: 0x21, Type: bool
function function_dbfd923950baaf9b( damage_data )
{
    return damage_data.attacker == self.owner;
}

// Namespace drone_launcher
// Params 2
// Checksum 0x52c00dff, Offset: 0x1657
// Size: 0x234
function destroy_launcher( damage_data, skip_destroy )
{
    level endon( #"game_ended" );
    
    if ( self.is_destroyed )
    {
        return;
    }
    
    self.is_destroyed = 1;
    self notify( #"death" );
    utility::callsharedfunc( #"jamming_system", #"hash_c33ceb91d0ca7a9d", self );
    
    if ( isdefined( damage_data.attacker ) && damage_data.attacker != self.owner )
    {
        if ( isplayer( self.owner ) )
        {
            self.owner thread equipment_utility::function_72a91d0610eb601c( self.superref, #"destroyed", #"destroyed_multiple" );
        }
        
        damage_data.attacker thread points::doscoreevent( #"super_drone_launcher_destroyed", damage_data.objweapon, undefined, undefined, self );
    }
    
    if ( self.owner )
    {
        self.owner weapons::removeequip( self );
        
        if ( self.owner.drone_launchers )
        {
            self.owner.drone_launchers = arrayremove( self.owner.drone_launchers, self );
        }
        
        if ( self.owner function_ea9e8cb54098c946() )
        {
            bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
            
            if ( bundle.var_8b9eade13fbfb044 && self.owner callback::exists( #"super_cancel", &cancel ) )
            {
                self.owner callback::remove( #"super_cancel", &cancel );
            }
            
            self.owner notify( #"hash_1a8fc861af8758cd" );
        }
        
        if ( isbrgamemode() )
        {
            self.owner supers_mp::clearsuper();
        }
    }
    
    if ( self )
    {
        if ( !skip_destroy )
        {
            self setscriptablepartstate( #"destroy", #"active", 0 );
            wait self.bundle.var_4094171eef2bdff4 ?? 0.1;
        }
        
        if ( self )
        {
            self delete();
        }
    }
}

// Namespace drone_launcher
// Params 2
// Checksum 0x8a26c8f7, Offset: 0x1893
// Size: 0x211
function function_ce2f163c2b3be6c0( deploy_id, batch_id )
{
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"death" );
    assert( deploy_id <= 2, "<dev string:x24>" );
    var_e91cdbdd691d82d2 = self.bundle.var_18f6603527072ff1;
    assert( isdefined( var_e91cdbdd691d82d2 ), "<dev string:x58>" );
    veh_model = self.drone_launcher_overrides.drone_model ?? self.bundle.var_f54fb8958b991230;
    assert( isdefined( veh_model ), "<dev string:xa2>" );
    var_41aa90a70f0609ea = undefined;
    animtimeoffset = 0;
    
    switch ( deploy_id )
    {
        case 0:
            var_41aa90a70f0609ea = #"hash_e5cbf98c0914874";
            animtimeoffset = 0.4;
            break;
        case 1:
            var_41aa90a70f0609ea = #"hash_e87fd01f4bd6706c";
            animtimeoffset = 0.7;
            break;
        case 2:
            var_41aa90a70f0609ea = #"hash_ceb57c27d2cca25f";
            animtimeoffset = 0.8;
            break;
        default:
            break;
    }
    
    self setscriptablepartstate( var_41aa90a70f0609ea, #"launch" );
    wait animtimeoffset;
    self setscriptablepartstate( var_41aa90a70f0609ea, #"hide" );
    spawnorigin = self gettagorigin( "j_drone_03", 0, 1 );
    spawnangle = self gettagangles( "j_drone_03", 0, 1 );
    
    if ( self.drone_launcher_overrides.callback_deploy_drone )
    {
        return self [[ self.drone_launcher_overrides.callback_deploy_drone ]]( spawnorigin, spawnangle, deploy_id, batch_id );
    }
    
    drone = spawn_drone( spawnorigin, spawnangle, var_e91cdbdd691d82d2, veh_model, deploy_id, batch_id );
    
    if ( drone )
    {
        drone.var_62c15331b77ebc75 = self.var_62c15331b77ebc75;
    }
    
    return drone;
}

// Namespace drone_launcher
// Params 1, eflags: 0x4
// Checksum 0x7328b342, Offset: 0x1aad
// Size: 0x134
function private cleanup_active_drones( drone )
{
    if ( !isdefined( level.var_d4fb6c8f927db90d ) )
    {
        level.var_d4fb6c8f927db90d = [];
    }
    
    level.var_d4fb6c8f927db90d[ level.var_d4fb6c8f927db90d.size ] = drone;
    activedrones = [];
    
    foreach ( var_ab003be494980a36 in level.var_d4fb6c8f927db90d )
    {
        if ( isdefined( var_ab003be494980a36 ) )
        {
            activedrones[ activedrones.size ] = var_ab003be494980a36;
        }
    }
    
    var_c10e71a797c7c859 = getdvarint( @"hash_9411060b797a40d2", function_5426ab0abe3e55b5() );
    
    if ( activedrones.size > var_c10e71a797c7c859 )
    {
        var_65329136b0f53ce2 = max( activedrones.size - var_c10e71a797c7c859, 0 );
        
        for ( droneindex = 0; droneindex < var_65329136b0f53ce2 ; droneindex++ )
        {
            olddrone = activedrones[ droneindex ];
            olddrone detonate_drone();
        }
    }
    
    level.var_d4fb6c8f927db90d = activedrones;
}

// Namespace drone_launcher
// Params 6
// Checksum 0xd32502db, Offset: 0x1be9
// Size: 0x2a6
function spawn_drone( spawn_origin, spawn_angles, var_e91cdbdd691d82d2, veh_model, deploy_id, batch_id )
{
    spawn_data = { #modelname:veh_model, #vehicletype:var_e91cdbdd691d82d2, #targetname:"drone_launcher_bomb_drone_" + batch_id + "-" + deploy_id, #angles:spawn_angles, #origin:spawn_origin };
    fail_data = {};
    drone = vehicle_tracking::spawn_vehicle( spawn_data, fail_data );
    drone.var_e463b0a79e72711f = self.var_e463b0a79e72711f;
    
    if ( !isdefined( drone ) )
    {
        /#
            debug_print( "<dev string:xef>" + spawn_data.targetname + "<dev string:xf1>" + "<dev string:xf4>" + ( fail_data.fail ?? "<dev string:x10b>" ) );
        #/
        
        thread destroy_launcher();
        return;
    }
    
    drone endon( #"death" );
    drone setup_drone( self );
    drone.deploy_id = deploy_id;
    drone.var_4ad7fb4ebf47f686 = gettime();
    drone.birthlocation = drone.origin;
    drone.var_8958572f8db5a345 = 128;
    cleanup_active_drones( drone );
    
    if ( !isdefined( self.activedrones ) )
    {
        self.activedrones = [];
    }
    
    self.activedrones[ self.activedrones.size ] = drone;
    
    if ( !isdefined( self.owner.drone_launcher_drones ) )
    {
        self.owner.drone_launcher_drones = [];
    }
    
    self.owner.drone_launcher_drones[ self.owner.drone_launcher_drones.size ] = drone;
    drone.blackhatref = "active_drone";
    
    if ( level.var_36218e71baa7e689 )
    {
        level.var_89fe7f9fa2bc945d[ level.var_89fe7f9fa2bc945d.size ] = drone;
    }
    
    if ( level.trophy_system_initialized )
    {
        level.var_1a371ac7284992a5[ level.var_1a371ac7284992a5.size ] = drone;
        drone.var_b50582a8004f118e = 1;
    }
    
    drone setnonstick( 1 );
    drone setnodeploy( 1 );
    
    /#
        if ( getdvarint( @"hash_9b840ef118910d45", 0 ) )
        {
            drone thread function_3341654bbbbed6c6();
            return drone;
        }
    #/
    
    drone thread function_27c4a99167818c57();
    drone thread function_4a25a230d1a8efba();
    
    /#
        drone thread debug_destination();
    #/
    
    return drone;
}

// Namespace drone_launcher
// Params 0
// Checksum 0xe3cacc87, Offset: 0x1e98
// Size: 0x92
function function_4a25a230d1a8efba()
{
    self endon( #"death", #"active_drone_hacked" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    
    if ( bundle.var_c862525655439c83 )
    {
        thread function_4c834db1017fc373();
        self waittill( #"found_target" );
    }
    
    thread navigate();
    thread function_65dcfaef5243b7c3();
    thread function_ec50b5e9b6b01216();
    thread function_5f0e1c7e92bea551();
    thread function_b290501e20b2596b();
    thread vehicle_roads::watch_stuck();
    thread vehicle_roads::watch_interrupt();
    wait 2;
    thread function_52075ab2909789f3();
    thread function_2c63939b0117f247();
}

// Namespace drone_launcher
// Params 0, eflags: 0x4
// Checksum 0xd2e24d6b, Offset: 0x1f32
// Size: 0x3d
function private function_52075ab2909789f3()
{
    self endon( #"death", #"active_drone_hacked" );
    
    while ( true )
    {
        utility::waittill_any( "vehicleNavSplineInterrupted", "vehicleStuckNavSpline" );
        self notify( #"reload_path" );
        waitframe();
    }
}

// Namespace drone_launcher
// Params 0, eflags: 0x4
// Checksum 0x56837ae0, Offset: 0x1f77
// Size: 0x7c
function private function_2c63939b0117f247()
{
    self endon( #"death", #"active_drone_hacked" );
    var_ef97a944d7885995 = 10000;
    var_e1b53a0e2422581 = 1;
    
    for ( prevpos = self.origin; true ; prevpos = self.origin )
    {
        wait var_e1b53a0e2422581;
        
        if ( distancesquared( self.origin, prevpos ) < var_ef97a944d7885995 )
        {
            self notify( #"reload_path" );
        }
    }
}

// Namespace drone_launcher
// Params 1
// Checksum 0xadfbf854, Offset: 0x1ffb
// Size: 0x2c2
function setup_drone( launcher )
{
    self.issuper = launcher.issuper;
    self.superref = launcher.superref;
    self.superid = launcher.superid;
    self.owner = launcher.owner;
    self.ownerlauncher = launcher;
    self.var_54ae3a087350bf6f = 1;
    self.drone_launcher_overrides = launcher.drone_launcher_overrides;
    self setotherent( self.owner );
    self.team = launcher.team;
    self setvehicleteam( self.team );
    vehicle_damage::set_can_damage( 1 );
    vehicle_damage::function_f22ce6c0cf2d903b( self );
    self.knockdown_chance = launcher.bundle.var_5b38e3cfff02c448;
    self.weapon_name = launcher.weapon_name;
    self.var_331f7e56b7a9891b = 1;
    self.var_f2e44aa6b74ea18e = launcher.birthtime;
    imageoverride = self.var_30656af96b2ac2a4.size > 0 ? launcher.bundle.buffedheadicon : undefined;
    self.headiconid = entityheadicons::setheadicon_fieldupgrade( self, imageoverride );
    namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( self, &function_ea8d7ef1fa4cc9aa );
    max_health = self.health ?? 50;
    thread damage::monitordamage( max_health, "hitequip", &destroy_drone, &function_4cfd644e92efdde4 );
    self setscriptablepartstate( #"breacher_setup", #"on", 0 );
    function_990752ebe0ad52b5();
    self enableplayermarks( #"equipment" );
    
    if ( level.teambased )
    {
        self filteroutplayermarks( self.owner.team );
    }
    else
    {
        self filteroutplayermarks( self.owner );
    }
    
    killcamentity = spawn( "script_model", self.origin + anglestoforward( self.angles ) * -50 + anglestoup( self.angles ) );
    killcamentity.angles = self.angles;
    killcamentity linkto( self );
    self.killcament = killcamentity;
    
    if ( launcher.bundle.var_26824f9a933a74be )
    {
        self.var_36a62e391219a1b3 = launcher.bundle.var_26824f9a933a74be;
    }
    
    self.prioritize_players = launcher.bundle.var_c74b892376d39dbc;
    vehicle_tracking::register_instance( self );
}

// Namespace drone_launcher
// Params 1
// Checksum 0x17f33452, Offset: 0x22c5
// Size: 0x17
function function_4cfd644e92efdde4( damage_data )
{
    return damage_data.damage;
}

// Namespace drone_launcher
// Params 0, eflags: 0x4
// Checksum 0x8e01dcc4, Offset: 0x22e5
// Size: 0x54, Type: bool
function private function_ea9e8cb54098c946()
{
    var_1216cd60f48e5525 = !self.drone_launcher_drones || self.drone_launcher_drones.size == 0;
    var_c673b91628fc1d05 = !self.drone_launchers || self.drone_launchers.size == 0;
    return var_1216cd60f48e5525 && var_c673b91628fc1d05;
}

// Namespace drone_launcher
// Params 3
// Checksum 0x114492aa, Offset: 0x2342
// Size: 0x22e
function destroy_drone( damage_data, isdetonation, skip_destroy )
{
    level endon( #"game_ended" );
    
    if ( self.is_destroyed )
    {
        return;
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    self setcandamage( 0 );
    self.is_destroyed = 1;
    
    if ( self.owner )
    {
        if ( self.owner.drone_launcher_drones && arraycontains( self.owner.drone_launcher_drones, self ) )
        {
            self.owner.drone_launcher_drones = arrayremove( self.owner.drone_launcher_drones, self );
        }
        
        if ( self.owner function_ea9e8cb54098c946() )
        {
            if ( bundle.var_8b9eade13fbfb044 && self.owner callback::exists( #"super_cancel", &cancel ) )
            {
                self.owner callback::remove( #"super_cancel", &cancel );
            }
            
            self.owner notify( #"hash_1a8fc861af8758cd" );
        }
    }
    
    self notify( #"death" );
    
    if ( isdefined( damage_data.attacker ) && damage_data.attacker != self.owner )
    {
        damage_data.attacker thread points::doscoreevent( #"super_drone_launcher_bomb_destroyed", damage_data.objweapon, undefined, undefined, self );
    }
    
    if ( self.active_target )
    {
        self.active_target.drone_launcher_bomb = undefined;
        self.active_target = undefined;
    }
    
    if ( self )
    {
        if ( !skip_destroy )
        {
            if ( !isdetonation )
            {
                self setscriptablepartstate( #"explode", #"on_nodamage", 0 );
            }
            
            wait bundle.var_33a65d1746d3658d ?? 0.1;
        }
        
        if ( self.killcament )
        {
            self.killcament delete();
        }
        
        if ( self )
        {
            vehicle_tracking::deregister_instance( self );
            vehicle_tracking::delete_vehicle( self );
        }
    }
}

// Namespace drone_launcher
// Params 0
// Checksum 0xbb8f1408, Offset: 0x2578
// Size: 0x256
function function_990752ebe0ad52b5()
{
    if ( !self hascomponent( "p2p" ) )
    {
        self addcomponent( "p2p" );
    }
    
    if ( !self hascomponent( "path" ) )
    {
        self addcomponent( "path" );
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    height_offset = bundle.var_96b019e92f7a68cd ?? 35;
    speed_mph = self vehicle_gettopspeedforward( 1 ) ?? 16;
    self vehicle_setspeed( speed_mph );
    self function_eb88c4e66edbc855( "p2p", "manualSpeed", utility::mph_to_ips( speed_mph ) );
    self function_eb88c4e66edbc855( "p2p", "checkStuck", 1 );
    self function_eb88c4e66edbc855( "p2p", "stuckDistanceThreshold", 5 );
    self function_eb88c4e66edbc855( "p2p", "automaticFast", 0 );
    self function_eb88c4e66edbc855( "p2p", "goalThreshold", 30 );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedThreshold", 2 );
    self function_eb88c4e66edbc855( "p2p", "automaticFastTopspeedFraction", 1 );
    self function_eb88c4e66edbc855( "p2p", "steeringMultiplier", 1 );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarBelow", 1 );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedFarAbove", 4 );
    self function_eb88c4e66edbc855( "p2p", "throttleSpeedClose", 2 );
    self function_eb88c4e66edbc855( "p2p", "vtol3DGoalAngleAlignmentEnable", 1 );
    self function_eb88c4e66edbc855( "p2p", "vtol3DGoalAngleAlignmentInfluenceRange", 40 );
    self function_eb88c4e66edbc855( "p2p", "vtol3DStrafeInputEnable", 1 );
    self function_eb88c4e66edbc855( "p2p", "vtol3DStrafeInputSlowDownDistance", 2 );
    self function_eb88c4e66edbc855( "p2p", "vtol3DReachGoalHeightEnable", 1 );
    self function_eb88c4e66edbc855( "p2p", "vtol3DReachGoalHeightThreshold", 2 );
    self function_eb88c4e66edbc855( "path", "advanceOnStart", 1 );
    self function_eb88c4e66edbc855( "path", "navSplinePathHeightOffset", height_offset );
    self function_eb88c4e66edbc855( "path", "radiusToStep", 125 );
    self function_eb88c4e66edbc855( "path", "warpOnStart", 0 );
    self function_eb88c4e66edbc855( "path", "useManualSpeed", 1 );
    self function_eb88c4e66edbc855( "path", "navSplineUseDroneStepMethod", 1 );
    self function_eb88c4e66edbc855( "path", "stepSpeedFactor", 0 );
    self function_eb88c4e66edbc855( "path", "stepProximityFactor", 0 );
}

// Namespace drone_launcher
// Params 0
// Checksum 0xe20b4134, Offset: 0x27d6
// Size: 0x190
function navigate()
{
    self endon( #"death", #"active_drone_hacked" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    navigation_timeout = 10;
    
    if ( bundle.var_23fbb4496155e025 )
    {
        var_9332fc0f7b588353 = bundle.var_23fbb4496155e025 * bundle.var_23fbb4496155e025;
    }
    
    while ( true )
    {
        set_destination();
        set_spline_path();
        function_e5f07e8eb94f2aca( bundle, var_9332fc0f7b588353 );
        reason = utility::waittill_any_timeout( navigation_timeout, "target_changed", "reached_end_node", "reload_path" );
        
        if ( self.usecatmullrom && reason == "reload_path" )
        {
            var_a31dc6b7db991d76 = 0;
            
            foreach ( trigger in level.var_54c2f5dfe418e393 )
            {
                if ( trigger.type == #"hash_d2c03b65714a93e1" && self istouching( trigger ) )
                {
                    var_a31dc6b7db991d76 = 1;
                    break;
                }
            }
            
            if ( !var_a31dc6b7db991d76 )
            {
                wait 1;
                reason = utility::waittill_any_timeout( navigation_timeout, "target_changed", "reached_end_node", "reload_path" );
            }
        }
        
        function_a21ee9ed362cd22f( reason );
    }
}

// Namespace drone_launcher
// Params 2
// Checksum 0xf49d1ae1, Offset: 0x296e
// Size: 0xc1
function function_e5f07e8eb94f2aca( bundle, var_9332fc0f7b588353 )
{
    if ( !bundle.var_23fbb4496155e025 || !bundle.var_4b8f5d7988084b45 || !bundle.var_78046550d184aaef )
    {
        return;
    }
    
    dist_horizontal = distance2dsquared( self.origin, self.destination );
    dist_vertical = self.destination[ 2 ] - self.origin[ 2 ];
    
    if ( dist_horizontal <= var_9332fc0f7b588353 && dist_vertical > bundle.var_4b8f5d7988084b45 )
    {
        self vehphys_impulse( ( 0, 0, 1 ), bundle.var_78046550d184aaef );
    }
}

// Namespace drone_launcher
// Params 1
// Checksum 0xf19191fb, Offset: 0x2a37
// Size: 0x15e
function function_a21ee9ed362cd22f( reason )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    
    if ( !isdefined( self.var_daddef814cbede91 ) )
    {
        self.var_daddef814cbede91 = bundle.var_b775c533c02fc949 ?? 0;
    }
    
    if ( self.var_daddef814cbede91 > 0 && ( reason == "timeout" || reason == "reload_path" ) )
    {
        if ( !isdefined( self.nav_attempts ) )
        {
            self.nav_attempts = 1;
        }
        
        if ( self.nav_attempts >= self.var_daddef814cbede91 )
        {
            /#
                debug_print( "<dev string:xef>" + self.targetname + "<dev string:xf1>" + "<dev string:x10c>" );
            #/
            
            thread detonate_drone();
        }
        else
        {
            /#
                debug_print( "<dev string:xef>" + self.targetname + "<dev string:xf1>" + "<dev string:x13d>" + reason + "<dev string:x148>" + self.nav_attempts + "<dev string:x14b>" + self.var_daddef814cbede91 + "<dev string:x154>" );
            #/
            
            self.nav_attempts++;
        }
        
        return;
    }
    
    if ( self.targetname && reason )
    {
        /#
            debug_print( "<dev string:xef>" + self.targetname + "<dev string:xf1>" + "<dev string:x13d>" + reason );
        #/
    }
}

// Namespace drone_launcher
// Params 0
// Checksum 0x7cae0f7b, Offset: 0x2b9d
// Size: 0x13d
function set_destination()
{
    if ( self.active_target.origin )
    {
        self.destination = self.active_target.origin;
        return;
    }
    
    if ( !isdefined( level.var_647eed1bc0140154 ) )
    {
        level.var_647eed1bc0140154 = [];
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    num_drones = bundle.var_daf16bc64663e298 ?? 3;
    level.var_647eed1bc0140154[ self.team ] = rotatevector( level.var_647eed1bc0140154[ self.team ] ?? ( 0, 1000, 0 ), vectortoangles( ( 0, 360 / num_drones, 0 ) ) );
    center_point = level.mapcenter;
    var_820f24a3218841c = 2000;
    
    if ( distance( self.origin, center_point + level.var_647eed1bc0140154[ self.team ] ) > var_820f24a3218841c )
    {
        center_point = self.origin;
    }
    
    self.destination = getclosestpointonnavmesh( center_point + level.var_647eed1bc0140154[ self.team ] );
}

// Namespace drone_launcher
// Params 0
// Checksum 0x66b68400, Offset: 0x2ce2
// Size: 0x4bd
function set_spline_path()
{
    if ( !isdefined( level.drone_launcher_spline_throttle ) )
    {
        level.drone_launcher_spline_throttle = throttle::throttle_initialize( "drone_launcher_spline", 1 );
    }
    
    throttle::throttle_wait_in_queue( level.drone_launcher_spline_throttle, self );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    function_bc9229285cf0f009();
    var_acd1d0de24cfedd6 = 50;
    disttodest = distance( self.origin, self.destination );
    
    if ( disttodest < 500 )
    {
        var_acd1d0de24cfedd6 = disttodest / 10;
    }
    
    forward_vector = anglestoforward( self.angles );
    start_position = getclosestpointonnavmesh( self.origin );
    start_direction = forward_vector;
    goal_position = self.destination;
    goal_direction = ( 0, 0, 0 );
    corner_margin = 200;
    preferred_radius = 500;
    lookahead_offset = 50;
    var_8aed07398d240158 = 0.25;
    ignore_obstacles = self.var_d63763ca24363a7a ?? 0;
    ignore_traversals = "drone";
    layer_name = "human";
    search_moving_platforms = 1;
    usecatmullrom = self.usecatmullrom ? 2 : 1;
    
    if ( self.usecatmullrom )
    {
        assert( level.var_c571213f3d764338, "<dev string:x156>" );
    }
    
    var_ad73dc98288cbce5 = distance( start_position, goal_position );
    function_1d44f32bbd313a67( #"hash_961231b82b703b67", var_ad73dc98288cbce5 );
    splinepoints = self findsplinepath( start_position, goal_position, corner_margin, preferred_radius, var_acd1d0de24cfedd6, start_direction, goal_direction, lookahead_offset, var_8aed07398d240158, ignore_obstacles, ignore_traversals, layer_name, search_moving_platforms, usecatmullrom );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    
    if ( !splinepoints )
    {
        ignore_obstacles = 1;
        splinepoints = self findsplinepath( start_position, goal_position, corner_margin, preferred_radius, var_acd1d0de24cfedd6, start_direction, goal_direction, lookahead_offset, var_8aed07398d240158, ignore_obstacles, ignore_traversals, layer_name, search_moving_platforms, usecatmullrom );
        
        if ( !splinepoints )
        {
            if ( bundle.var_e0943ac1082c6f53 || getdvarint( @"hash_83cd8e0336b8fec", 0 ) )
            {
                if ( !self.owner.var_e86b768afd3ad21e )
                {
                    thread detonate_drone();
                }
            }
            else
            {
                errormsg = "No valid path for Drone Launcher Drone from " + ( start_position ?? "undefined" ) + " to " + ( goal_position ?? "undefined" ) + ". Drone is using NAV_LINK_DRONE traversal and NAV_LAYER_HUMAN layer. " + "Did you configure map traversal nodes and nav_modifier (obstacles) properly?";
                assertmsg( errormsg );
                script::function_2e2007575f92910d( errormsg );
                thread detonate_drone();
            }
        }
    }
    
    if ( bundle.var_88d3071e66f14d00 && splinepoints.size <= bundle.var_88d3071e66f14d00 )
    {
        recalculate_path = 1;
        
        if ( splinepoints.size >= 2 && bundle.var_4a6d4306ae110584 )
        {
            path_dist_squared = 0;
            
            for ( i = 1; i < splinepoints.size ; i++ )
            {
                path_dist_squared += distancesquared( splinepoints[ i - 1 ], splinepoints[ i ] );
            }
            
            min_dist_squared = bundle.var_4a6d4306ae110584 * bundle.var_4a6d4306ae110584;
            recalculate_path = path_dist_squared < min_dist_squared;
        }
        
        if ( recalculate_path )
        {
            splinepoints = self findsplinepath( start_position, goal_position, corner_margin, preferred_radius, var_acd1d0de24cfedd6, start_direction, goal_direction, lookahead_offset, var_8aed07398d240158, ignore_obstacles, bundle.var_2960789a1b2f80f9, layer_name, search_moving_platforms, usecatmullrom );
        }
    }
    
    if ( usecatmullrom == 2 )
    {
        canusecatmullrom = 1;
        
        if ( splinepoints.size >= 48 )
        {
            splinepoints = utility::array_slice( splinepoints, 0, 47 );
        }
        else if ( !splinepoints || splinepoints.size < 4 )
        {
            canusecatmullrom = 0;
            splinepoints = self findsplinepath( start_position, goal_position, corner_margin, preferred_radius, var_acd1d0de24cfedd6, start_direction, goal_direction, lookahead_offset, var_8aed07398d240158, ignore_obstacles, ignore_traversals, layer_name, search_moving_platforms, usecatmullrom - 1 );
        }
        
        if ( canusecatmullrom )
        {
            heightoffset = self.var_98c0855bbece064e ?? bundle.var_96b019e92f7a68cd ?? 35;
            
            for ( i = 0; i < splinepoints.size ; i++ )
            {
                splinepoints[ i ] += ( 0, 0, heightoffset );
            }
            
            speedmph = self vehicle_gettopspeedforward() ?? 16;
            speedips = utility::mph_to_ips( speedmph );
            var_f2031896fbadeb97 = function_c3ee0922b548bb43( splinepoints, speedips );
            splineid = function_53253e8ea222ed60( splinepoints, var_f2031896fbadeb97, 0 );
            self setconfigvalue( "path", "catmullRomId", splineid );
            thread function_f9cb2bf4cc4227c4( splinepoints );
        }
    }
    
    /#
        if ( splinepoints && getdvarint( @"scr_drone_launcher_debug_draw", 0 ) )
        {
            thread vehicle_roads::function_2b723e6a5a86a006( splinepoints, ( 1, 0, 0 ) );
        }
    #/
}

// Namespace drone_launcher
// Params 0, eflags: 0x4
// Checksum 0x4c3e7bb9, Offset: 0x31a7
// Size: 0xfb
function private function_bc9229285cf0f009()
{
    if ( !level.var_54c2f5dfe418e393 )
    {
        return;
    }
    
    var_9b3ff8ba891e4292 = 0;
    
    foreach ( trigger in level.var_54c2f5dfe418e393 )
    {
        switch ( trigger.type )
        {
            case #"hash_d2c03b65714a93e1":
                if ( !var_9b3ff8ba891e4292 )
                {
                    level.var_c571213f3d764338 = 1;
                    var_9b3ff8ba891e4292 = 1;
                }
                
                break;
            default:
                assertmsg( "<dev string:x1f2>" );
                break;
        }
    }
    
    if ( var_9b3ff8ba891e4292 )
    {
        self.usecatmullrom = 1;
        return;
    }
    
    self.usecatmullrom = 0;
}

// Namespace drone_launcher
// Params 1, eflags: 0xc
// Checksum 0xc9c51684, Offset: 0x32aa
// Size: 0x3ad
function private function_f9cb2bf4cc4227c4( splinepoints )
{
    self notify( #"hash_2efa329dd98a209c" );
    self endon( #"hash_2efa329dd98a209c" );
    assert( self.usecatmullrom && level.var_c571213f3d764338, "<dev string:x230>" + "<dev string:x156>" );
    self endon( #"death", #"active_drone_hacked" );
    var_f5f0cdb9e21fd885 = 20;
    self.var_fd9f726140780a1d = [];
    self.var_e677af273ecef292 = 0;
    
    for ( i = 0; i < splinepoints.size - 1 ; i++ )
    {
        var_78a9bbaea0e11692 = splinepoints[ i + 1 ][ 2 ] - splinepoints[ i ][ 2 ];
        
        if ( var_78a9bbaea0e11692 > var_f5f0cdb9e21fd885 || var_78a9bbaea0e11692 < var_f5f0cdb9e21fd885 * -1 )
        {
            var_df47dde729f2921c = { #var_78a9bbaea0e11692:var_78a9bbaea0e11692, #topoint:splinepoints[ i + 1 ], #frompoint:splinepoints[ i ] };
            self.var_fd9f726140780a1d[ self.var_fd9f726140780a1d.size ] = var_df47dde729f2921c;
        }
    }
    
    minimpulse = 35;
    var_da7b217523edd9f9 = 0.38;
    var_af30c1f1baf00242 = 0;
    tracecontents = trace::create_contents( 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0 );
    var_5d97acafc6f586f5 = 2500;
    var_352b430571c4ad6f = 200;
    
    while ( self.var_e677af273ecef292 < self.var_fd9f726140780a1d.size )
    {
        if ( distance2dsquared( self.origin, self.var_fd9f726140780a1d[ self.var_e677af273ecef292 ].frompoint ) < var_5d97acafc6f586f5 )
        {
            var_78a9bbaea0e11692 = self.var_fd9f726140780a1d[ self.var_e677af273ecef292 ].var_78a9bbaea0e11692;
            currtime = gettime();
            var_1c505c00c9ab1300 = self.var_8b8127423201d25f ? currtime - self.var_8b8127423201d25f > var_352b430571c4ad6f : 1;
            
            if ( var_78a9bbaea0e11692 < 0 && self.origin[ 2 ] > self.var_fd9f726140780a1d[ self.var_e677af273ecef292 ].topoint[ 2 ] )
            {
                if ( var_af30c1f1baf00242 )
                {
                    impulse = maxint( minimpulse, int( abs( var_78a9bbaea0e11692 * var_af30c1f1baf00242 ) ) );
                    
                    if ( impulse > 255 )
                    {
                        impulse = 255;
                    }
                    
                    self vehphys_impulse( ( 0, 0, -1 ), impulse, 1 );
                }
                else
                {
                    tracestart = self.origin;
                    traceend = self.var_fd9f726140780a1d[ self.var_e677af273ecef292 ].topoint;
                    
                    if ( !trace::ray_trace_passed( tracestart, traceend, self, tracecontents ) && var_1c505c00c9ab1300 )
                    {
                        self.var_8b8127423201d25f = currtime;
                        self vehphys_impulse( ( 0, 0, 1 ), minimpulse, 1 );
                    }
                }
            }
            else if ( var_78a9bbaea0e11692 > 0 && self.origin[ 2 ] < self.var_fd9f726140780a1d[ self.var_e677af273ecef292 ].topoint[ 2 ] )
            {
                if ( var_1c505c00c9ab1300 )
                {
                    self.var_8b8127423201d25f = currtime;
                    impulse = maxint( minimpulse, int( abs( var_78a9bbaea0e11692 * var_da7b217523edd9f9 ) ) );
                    
                    if ( impulse > 255 )
                    {
                        impulse = 255;
                    }
                    
                    self vehphys_impulse( ( 0, 0, 1 ), impulse, 1 );
                }
            }
            
            self.var_e677af273ecef292++;
        }
        
        waitframe();
    }
    
    self.var_fd9f726140780a1d = [];
    self.var_e677af273ecef292 = 0;
}

// Namespace drone_launcher
// Params 2, eflags: 0x4
// Checksum 0x3eb4b01, Offset: 0x365f
// Size: 0x94
function private function_c3ee0922b548bb43( splinepoints, speedips )
{
    durations = [];
    assert( splinepoints.size <= 48 );
    
    if ( splinepoints.size >= 2 )
    {
        for ( index = 0; index < splinepoints.size - 1 ; index++ )
        {
            currentpoint = splinepoints[ index ];
            nextpoint = splinepoints[ index + 1 ];
            durations[ durations.size ] = function_f58660c39afe99d1( currentpoint, nextpoint, speedips );
        }
        
        durations[ durations.size ] = durations[ durations.size - 1 ];
    }
    
    return durations;
}

// Namespace drone_launcher
// Params 3, eflags: 0x4
// Checksum 0xb83b205a, Offset: 0x36fc
// Size: 0x53
function private function_f58660c39afe99d1( startpos, endpos, speed )
{
    segmentlength = distance( startpos, endpos );
    moverate = segmentlength / speed;
    
    if ( moverate < 0.05 )
    {
        moverate = 0.05;
    }
    
    return moverate;
}

// Namespace drone_launcher
// Params 0
// Checksum 0x2adb7b79, Offset: 0x3758
// Size: 0x164
function function_27c4a99167818c57()
{
    self endon( #"death", #"active_drone_hacked" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    
    while ( true )
    {
        new_target = undefined;
        drone_search_radius = bundle.drone_launcher_max_range ?? 2500;
        
        if ( self.prioritize_players )
        {
            nearby_players = getplayersinradius( self.origin, drone_search_radius );
            new_target = get_valid_target( nearby_players );
        }
        
        if ( !new_target )
        {
            var_fdc5e4472f1e2a76 = !self.prioritize_players ? getplayersandaiarrayinradius( self.origin, drone_search_radius ) : getaiarrayinradius( self.origin, drone_search_radius );
            
            if ( bundle.var_bd4ea80813a676b )
            {
                var_88f4e44ddcaef219 = utility::callsharedfunc( #"guild_drone", #"get_in_radius", self.origin, drone_search_radius ) ?? [];
                var_fdc5e4472f1e2a76 = arraycombine( var_fdc5e4472f1e2a76, var_88f4e44ddcaef219 );
            }
            
            new_target = get_valid_target( var_fdc5e4472f1e2a76 );
        }
        
        if ( new_target && new_target.ridingvehicle )
        {
            new_target = new_target.ridingvehicle;
        }
        
        if ( self.var_75cc8e75607ef368 && !new_target )
        {
            new_target = self.owner;
        }
        
        set_active_target( new_target );
        waitframe();
    }
}

// Namespace drone_launcher
// Params 1, eflags: 0x4
// Checksum 0x1962bc9, Offset: 0x38c4
// Size: 0xa8
function private get_valid_target( targets )
{
    targets_sorted = sortbydistance( targets, self.origin );
    
    foreach ( current_target in targets_sorted )
    {
        if ( function_59fb39487166f319( current_target ) )
        {
            self notify( #"found_target" );
            return current_target;
        }
    }
}

// Namespace drone_launcher
// Params 1
// Checksum 0x71ef37f9, Offset: 0x3974
// Size: 0xbd, Type: bool
function function_59fb39487166f319( target )
{
    if ( !isdefined( target ) )
    {
        return false;
    }
    
    if ( !isalive( target ) )
    {
        return false;
    }
    
    if ( target.kfe_ignore )
    {
        return false;
    }
    
    if ( !isdefined( target.team ) || target.team === self.team )
    {
        return false;
    }
    
    if ( isdefined( target.perks[ "specialty_blindeye" ] ) )
    {
        return false;
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    
    if ( !bundle.var_c0b947b65cc33158 && target.drone_launcher_bomb && target.drone_launcher_bomb != self )
    {
        return false;
    }
    
    return true;
}

// Namespace drone_launcher
// Params 1
// Checksum 0xb4c0ae83, Offset: 0x3a3a
// Size: 0x93
function set_active_target( new_target )
{
    if ( !isdefined( new_target ) && !isdefined( self.active_target ) )
    {
        return;
    }
    
    if ( new_target != self.active_target )
    {
        if ( self.active_target.drone_launcher_bomb )
        {
            self.active_target.drone_launcher_bomb = undefined;
        }
        
        self.active_target = new_target;
        
        if ( self.active_target )
        {
            self.active_target.drone_launcher_bomb = self;
        }
        
        self notify( #"target_changed" );
    }
}

// Namespace drone_launcher
// Params 0
// Checksum 0x27a3309d, Offset: 0x3ad5
// Size: 0xf6
function function_36b71e2e67392a98()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    minimapid = objidpoolmanager::createobjective( bundle.var_a5982b5b2d7f67d2, self.team, 1, 0, 0 );
    objidpoolmanager::function_e4d6a71507372662( minimapid, 0 );
    function_38c992e07c477802( minimapid, 0 );
    var_4c49d70cb8b07d56 = getuavstrengthlevelneutral();
    
    foreach ( player in teams::getfriendlyplayers( self.team, 1 ) )
    {
        player thread function_5351b302f159a53b( minimapid, var_4c49d70cb8b07d56 );
    }
    
    level thread function_ccc9ef3293795dc7( minimapid );
    level thread function_f4857bebfa34036b( minimapid );
}

// Namespace drone_launcher
// Params 1
// Checksum 0x109c284a, Offset: 0x3bd3
// Size: 0x44
function function_ccc9ef3293795dc7( minimapid )
{
    level endon( "drone_launcher_returned_objective_id" + minimapid );
    wait self.bundle.var_fa24fe24a9e661e3 ?? 6;
    objidpoolmanager::returnobjectiveid( minimapid );
    level notify( "drone_launcher_returned_objective_id" + minimapid );
}

// Namespace drone_launcher
// Params 1
// Checksum 0xc175de93, Offset: 0x3c1f
// Size: 0x4c
function function_f4857bebfa34036b( minimapid )
{
    level endon( "drone_launcher_returned_objective_id" + minimapid );
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"emp_blast_applied" );
        objidpoolmanager::returnobjectiveid( minimapid );
        level notify( "drone_launcher_returned_objective_id" + minimapid );
    }
}

// Namespace drone_launcher
// Params 2
// Checksum 0xeac99d2e, Offset: 0x3c73
// Size: 0xb0
function function_5351b302f159a53b( minimapid, var_4c49d70cb8b07d56 )
{
    self endon( #"death_or_disconnect" );
    level endon( "drone_launcher_returned_objective_id" + minimapid );
    level endon( #"game_ended" );
    isshown = 1;
    
    while ( true )
    {
        if ( isshown )
        {
            if ( self.radarstrength < var_4c49d70cb8b07d56 || self.empcount )
            {
                objidpoolmanager::objective_playermask_hidefrom( minimapid, self );
                isshown = 0;
            }
        }
        else if ( self.radarstrength >= var_4c49d70cb8b07d56 && !self.empcount )
        {
            objidpoolmanager::objective_playermask_addshowplayer( minimapid, self );
            isshown = 1;
        }
        
        wait 0.5;
    }
}

// Namespace drone_launcher
// Params 0
// Checksum 0xb0d3a29d, Offset: 0x3d2b
// Size: 0x166
function function_65dcfaef5243b7c3()
{
    self endon( #"death" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    detonate_distance = bundle.var_fb31e0ac3f71f0fd ?? 100;
    detonate_distance_squared = detonate_distance * detonate_distance;
    var_5e478c31ce6e6e2d = 0.1;
    var_4631d02733b7547f = 1.2;
    waittimelos = 0;
    
    if ( self.explosiondelay )
    {
        wait self.explosiondelay;
    }
    
    while ( true )
    {
        if ( self.active_target && distancesquared( self.active_target.origin, self.origin ) <= detonate_distance_squared && self.owner != self.active_target )
        {
            if ( !function_3352945073970cb7( self.active_target ) && waittimelos < var_4631d02733b7547f )
            {
                waittimelos += var_5e478c31ce6e6e2d;
                wait var_5e478c31ce6e6e2d;
                continue;
            }
            
            if ( self.var_62c15331b77ebc75 )
            {
                thread function_36b71e2e67392a98();
            }
            
            if ( isplayer( self.active_target ) && self.owner )
            {
                self.active_target.var_898e85ceb5f62e0c[ self.owner getentitynumber() ] = gettime();
            }
            
            thread detonate_drone();
            break;
        }
        
        waitframe();
    }
}

// Namespace drone_launcher
// Params 1, eflags: 0x4
// Checksum 0x54e4d7bf, Offset: 0x3e99
// Size: 0xe7, Type: bool
function private function_3352945073970cb7( target )
{
    if ( !target )
    {
        return false;
    }
    
    tracecontents = trace::create_contents( 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0 );
    tracepoints = [ target.origin ];
    
    if ( isplayer( target ) )
    {
        tracepoints[ tracepoints.size ] = target utility::function_f02ebab438642e16();
        tracepoints[ tracepoints.size ] = target utility::function_68061c3d21a6d57a();
    }
    
    ignorelist = [ self, target ];
    
    for ( i = 0; i < tracepoints.size ; i++ )
    {
        traceresult = trace::ray_trace( self.origin, tracepoints[ i ], ignorelist, tracecontents, 0, 0, 0, undefined, self.team );
        
        if ( traceresult[ "fraction" ] > 0.9 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace drone_launcher
// Params 0
// Checksum 0x3495ab35, Offset: 0x3f89
// Size: 0xf5
function function_ec50b5e9b6b01216()
{
    self endon( #"death", #"active_drone_hacked" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    lockon_distance = ( bundle.var_fb31e0ac3f71f0fd ?? 100 ) + 500;
    lockon_distance_squared = lockon_distance * lockon_distance;
    
    while ( true )
    {
        if ( self.active_target && distancesquared( self.active_target.origin, self.origin ) <= lockon_distance_squared )
        {
            if ( self getscriptablepartstate( #"locked_on" ) != #"on" )
            {
                self setscriptablepartstate( #"locked_on", #"on", 0 );
            }
            
            self waittill( #"target_changed" );
            self setscriptablepartstate( #"locked_on", #"off", 0 );
        }
        
        wait 0.1;
    }
}

// Namespace drone_launcher
// Params 0
// Checksum 0xe00e77a7, Offset: 0x4086
// Size: 0x1d6
function detonate_drone()
{
    if ( self.is_destroyed )
    {
        return;
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    damage_radius = bundle.var_ae42ee7a7f41300f ?? 150;
    var_a45682402aaf604e = bundle.var_5d9fe5771cddee3d ?? 125;
    var_d795e8197507b57b = bundle.var_5ee07d82b5c7c108 ?? 75;
    
    if ( self.drone_launcher_overrides )
    {
        var_a45682402aaf604e = self.drone_launcher_overrides.drone_inner_damage ?? var_a45682402aaf604e;
        var_d795e8197507b57b = self.drone_launcher_overrides.drone_outer_damage ?? var_d795e8197507b57b;
    }
    
    if ( game_utility::function_ae97372c83da7acc() )
    {
        var_a45682402aaf604e *= bundle.var_d6460e66e0cafce9 ?? 1;
        var_d795e8197507b57b *= bundle.var_32ba0b3cbbec1e0c ?? 1;
    }
    
    self radiusdamage( self.origin, damage_radius, var_a45682402aaf604e, var_d795e8197507b57b, self.owner ?? undefined, "MOD_EXPLOSIVE", self.weapon_name );
    
    if ( self.owner )
    {
        self.owner utility::callsharedfunc( "super_drone_launcher", #"hash_a7193167626b402f", { #damage_radius:damage_radius, #deploy_id:self.deploy_id, #origin:self.origin } );
    }
    
    self setscriptablepartstate( #"explode", #"on", 0 );
    
    if ( self.owner )
    {
        self.owner callback::callback( "drone_destroyed", { #drone:self, #origin:self.origin } );
    }
    
    thread destroy_drone( undefined, 1 );
}

// Namespace drone_launcher
// Params 0
// Checksum 0xf8547ffa, Offset: 0x4264
// Size: 0xc4
function function_5f0e1c7e92bea551()
{
    self endon( #"death", #"active_drone_hacked" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    lifetime = bundle.var_8e485d52d7b8b72 ?? 0;
    
    if ( self.forcedlifetime )
    {
        lifetime = self.forcedlifetime;
    }
    
    if ( lifetime <= 0 )
    {
        return;
    }
    
    wait lifetime;
    
    /#
        debug_print( "<dev string:xef>" + self.targetname + "<dev string:x294>" );
    #/
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    detonate_on_timeout = bundle.var_f051da120e9e0b83 ?? 0;
    
    if ( detonate_on_timeout )
    {
        thread detonate_drone();
        return;
    }
    
    thread destroy_drone();
}

// Namespace drone_launcher
// Params 0
// Checksum 0x847650f4, Offset: 0x4330
// Size: 0x18b
function function_b290501e20b2596b()
{
    self endon( #"death", #"active_drone_hacked" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    var_b290501e20b2596b = bundle.var_b38455ab917dca67 ?? 1;
    
    if ( !var_b290501e20b2596b )
    {
        return;
    }
    
    radius = 96;
    
    while ( true )
    {
        var_4049537beff91e38 = getentitylessscriptablearray( undefined, undefined, self.origin, radius, "door" );
        
        foreach ( door in var_4049537beff91e38 )
        {
            if ( door.sliding_door )
            {
                door.sliding_door notify( #"trigger", self );
                continue;
            }
            
            if ( door.var_e958f5af05f687d1 )
            {
                door.var_e958f5af05f687d1 notify( #"trigger", self );
            }
        }
        
        nearestdoor = function_6cf720856f2ecd74( self.origin, radius );
        
        if ( isdefined( nearestdoor ) && nearestdoor isscriptableinstance() && nearestdoor scriptabledoorisclosed() && !nearestdoor function_4f79c45e0fd47b7f() )
        {
            nearestdoor scriptabledooropen( "away", self.origin );
        }
        
        waitframe();
    }
}

// Namespace drone_launcher
// Params 0
// Checksum 0xc826e28f, Offset: 0x44c3
// Size: 0x12f
function function_522dc7652f4c60a6()
{
    self endon( #"death", #"active_drone_hacked" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    var_522dc7652f4c60a6 = bundle.var_4f00f5de25a28042 ?? 1;
    
    if ( !var_522dc7652f4c60a6 )
    {
        return;
    }
    
    self vehphys_enablecollisioncallback( 1 );
    max_collisions = bundle.var_f0fa8d00422b1610 ?? 3;
    self.collisions = 0;
    
    while ( true )
    {
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        
        if ( impulse > 0 )
        {
            self.collisions++;
        }
        
        if ( self.collisions > max_collisions )
        {
            /#
                debug_print( "<dev string:xef>" + self.targetname + "<dev string:x2bc>" );
            #/
            
            thread detonate_drone();
            break;
        }
        
        wait 1;
    }
}

// Namespace drone_launcher
// Params 1, eflags: 0x4
// Checksum 0xa7646525, Offset: 0x45fa
// Size: 0x1a
function private function_f2fdd019aa1d97a6( var_2cf21aecf93cffea )
{
    var_2cf21aecf93cffea.isjammed = 1;
}

// Namespace drone_launcher
// Params 1, eflags: 0x4
// Checksum 0x4317f4ce, Offset: 0x461c
// Size: 0x17
function private function_655bd8caffa5d850( var_2cf21aecf93cffea )
{
    var_2cf21aecf93cffea.isjammed = undefined;
}

// Namespace drone_launcher
// Params 1, eflags: 0x4
// Checksum 0xcbc69033, Offset: 0x463b
// Size: 0x10f
function private function_b0376966cd0c2c6a( data )
{
    self.var_3e0f12057afe35e5 = 1;
    self setscriptablepartstate( #"emped", #"on", 0 );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
    disabletime = bundle.var_bad088ae2f55a5e3 ?? data.inflictor.bundle.var_8a2c2a952c83b5d6 ?? 3;
    
    if ( data.attacker )
    {
        data.attacker thread utility::callsharedfunc( #"player", #"doScoreEvent", #"emped_player" );
    }
    
    if ( get_num_drones() > 0 )
    {
        self.lifetimeendtime += disabletime * 1000;
    }
    
    wait disabletime;
    
    if ( self )
    {
        self.var_3e0f12057afe35e5 = 0;
        self setscriptablepartstate( #"emped", #"off", 0 );
    }
}

// Namespace drone_launcher
// Params 1
// Checksum 0x909edd65, Offset: 0x4752
// Size: 0x1f2
function add_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        self.var_30656af96b2ac2a4[ self.var_30656af96b2ac2a4.size ] = params.combatlink;
        
        if ( !self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] )
        {
            basepoints = rank::getscoreinfovalue( #"hash_1d0c464f713f3bc8" ) ?? 0;
            params.combatlink.owner thread points::doscoreevent( #"hash_1d0c464f713f3bc8", params.combatlink.weapon_object, basepoints * params.combatlink.var_352099d9d2836866 );
            
            if ( !isdefined( self.var_2695e71ddf32816c ) )
            {
                self.var_2695e71ddf32816c = [];
            }
            
            self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] = 1;
        }
        
        if ( params.combatlink.owner != self.owner && !self.var_2b2f786d6b12c032 )
        {
            self.owner thread points::doscoreevent( #"hash_5ffd6a7c85f19d10", params.combatlink.weapon_object );
            self.var_2b2f786d6b12c032 = 1;
        }
        
        if ( self.var_30656af96b2ac2a4.size == 1 )
        {
            if ( isdefined( self.headiconid ) && isdefined( self.bundle.buffedheadicon ) )
            {
                setheadiconimage( self.headiconid, self.bundle.buffedheadicon, 1 );
            }
            
            self.var_9e87e3028beb60bf = params.bundle.var_114136d1aa809113 ?? undefined;
        }
    }
}

// Namespace drone_launcher
// Params 1
// Checksum 0x668db262, Offset: 0x494c
// Size: 0xb8
function remove_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        if ( arraycontains( self.var_30656af96b2ac2a4, params.combatlink ) )
        {
            self.var_30656af96b2ac2a4 = arrayremove( self.var_30656af96b2ac2a4, params.combatlink );
            
            if ( self.var_30656af96b2ac2a4.size <= 0 )
            {
                if ( isdefined( self.headiconid ) && isdefined( level.gamemodebundle.var_a43747faa623d1b0 ) )
                {
                    setheadiconimage( self.headiconid, level.gamemodebundle.var_a43747faa623d1b0, 1 );
                }
                
                self.var_9e87e3028beb60bf = undefined;
            }
        }
    }
}

// Namespace drone_launcher
// Params 1, eflags: 0x4
// Checksum 0x84011dc8, Offset: 0x4a0c
// Size: 0x39
function private function_ea8d7ef1fa4cc9aa( data )
{
    data.attacker thread points::doscoreevent( #"super_drone_launcher_bomb_destroyed", data.objweapon );
    destroy_drone();
}

// Namespace drone_launcher
// Params 2, eflags: 0x4
// Checksum 0x55bd61df, Offset: 0x4a4d
// Size: 0x192
function private function_ea1d633ed41c456e( hackeffect, attacker )
{
    self notify( #"active_drone_hacked" );
    self endon( #"death" );
    
    if ( !hackeffect.var_30e7de3d76d5a085 || !attacker )
    {
        return;
    }
    
    attacker endon( #"disconnect" );
    
    if ( self.owner && isplayer( self.owner ) )
    {
        self.owner thread equipment_utility::function_364a1a0e0c018518( "super_drone_launcher", #"stolen_hacked_drone" );
        self.owner.drone_launcher_drones = arrayremove( self.owner.drone_launcher_drones, self );
    }
    
    self.owner = attacker;
    self setotherent( attacker );
    self.team = attacker.team;
    self setvehicleteam( attacker.team );
    self setscriptablepartstate( #"breacher_setup", #"on", 0 );
    self setscriptablepartstate( #"hacked", #"stolen", 0 );
    self enableplayermarks( #"equipment" );
    
    if ( level.teambased )
    {
        self filteroutplayermarks( self.owner.team );
    }
    else
    {
        self filteroutplayermarks( self.owner );
    }
    
    self.var_70e5107fa80844df = self.ownerlauncher.var_70e5107fa80844df;
    thread function_27c4a99167818c57();
    thread function_4a25a230d1a8efba();
}

// Namespace drone_launcher
// Params 2
// Checksum 0xbd18acf4, Offset: 0x4be7
// Size: 0x2d2
function function_8c26023bd26169c8( hackeffect, attacker )
{
    self notify( #"launcher_hacked" );
    self endon( #"death" );
    
    if ( !hackeffect.var_30e7de3d76d5a085 || !attacker )
    {
        return;
    }
    
    attacker endon( #"disconnect" );
    
    if ( self.owner && isplayer( self.owner ) )
    {
        self.owner thread equipment_utility::function_364a1a0e0c018518( "super_drone_launcher", #"stolen_hacked_launcher" );
    }
    
    equipment_interact::function_2e1b95de8d0440b9();
    
    if ( self.drone_launcher )
    {
        self.drone_launcher thread destroy_launcher();
    }
    
    if ( self.owner )
    {
        self.owner.drone_launchers = arrayremove( self.owner.drone_launchers, self );
    }
    
    self.owner = attacker;
    self.team = attacker.team;
    
    if ( !isdefined( self.owner.drone_launchers ) )
    {
        self.owner.drone_launchers = [];
    }
    
    self.owner.drone_launchers[ self.owner.drone_launchers.size ] = self;
    
    if ( level.teambased )
    {
        self filteroutplayermarks( attacker.team );
    }
    else
    {
        self filteroutplayermarks( attacker );
    }
    
    utility::callsharedfunc( #"jamming_system", #"hash_bdfef7c0d312ab04", self );
    thread activate_launcher();
    self setscriptablepartstate( #"hacked", #"stolen", 0 );
    
    foreach ( var_ab003be494980a36 in self.activedrones )
    {
        var_ab003be494980a36 function_ea1d633ed41c456e( hackeffect, attacker );
    }
    
    if ( self.bundle.var_bead9b1c34058722 )
    {
        var_aacb78da5016573c = self.bundle.var_9d83d7a2c4169a01 ?? 0.3;
        destroyrange = self.bundle.var_d698fcfe464f1b17 ?? 128;
        hintstring = self.bundle.var_dfc5df4b445d78b1 ?? &"super_mp/destroy_super";
        thread equipment_interact::function_226793772d245e96( var_aacb78da5016573c, destroyrange, hintstring, self.team );
    }
}

// Namespace drone_launcher
// Params 0
// Checksum 0x3649c9a5, Offset: 0x4ec1
// Size: 0xaf
function function_4c834db1017fc373()
{
    self endon( #"death", #"active_drone_hacked" );
    self endon( #"found_target" );
    self function_eb88c4e66edbc855( "p2p", "stopAtGoal", 1 );
    self function_eb88c4e66edbc855( "p2p", "goalThreshold", 30 );
    self function_eb88c4e66edbc855( "p2p", "vtol3DReachGoalHeightEnable", 1 );
    origin = self.origin;
    
    while ( true )
    {
        goal_point = origin + ( 0, 0, 52.5 );
        self function_eb88c4e66edbc855( "p2p", "goalPoint", goal_point );
        self waittill( #"near_goal" );
    }
}

// Namespace drone_launcher
// Params 0
// Checksum 0x16be44fa, Offset: 0x4f78
// Size: 0x47
function function_12aa05888f56a090()
{
    self endon( #"death_or_disconnect" );
    self waittill( #"hash_1a8fc861af8758cd" );
    
    if ( callback::exists( #"hash_2346898712859996", &on_modify_player_damage ) )
    {
        callback::remove( #"hash_2346898712859996", &on_modify_player_damage );
    }
}

/#

    // Namespace drone_launcher
    // Params 1
    // Checksum 0x65ecd877, Offset: 0x4fc7
    // Size: 0x27, Type: dev
    function debug_print( message )
    {
        if ( getdvarint( @"scr_drone_launcher_debug_print", 0 ) )
        {
            iprintln( message );
        }
    }

    // Namespace drone_launcher
    // Params 0
    // Checksum 0xb76960a1, Offset: 0x4ff6
    // Size: 0xa9, Type: dev
    function function_3341654bbbbed6c6()
    {
        self endon( #"death" );
        self endon( #"found_target" );
        self function_eb88c4e66edbc855( "<dev string:x2da>", "<dev string:x2de>", 1 );
        self function_eb88c4e66edbc855( "<dev string:x2da>", "<dev string:x2e9>", 30 );
        self function_eb88c4e66edbc855( "<dev string:x2da>", "<dev string:x2f7>", 1 );
        origin = self.origin;
        
        while ( true )
        {
            goal_point = origin + ( 0, 0, 52.5 );
            self function_eb88c4e66edbc855( "<dev string:x2da>", "<dev string:x313>", goal_point );
            self waittill( #"near_goal" );
        }
    }

    // Namespace drone_launcher
    // Params 0
    // Checksum 0x92b122c3, Offset: 0x50a7
    // Size: 0x54, Type: dev
    function debug_destination()
    {
        self endon( #"death" );
        
        while ( true )
        {
            if ( self.active_target )
            {
                line( self.origin, self.active_target.origin, ( 1, 0, 0 ) );
            }
            
            waitframe();
        }
    }

#/

// Namespace drone_launcher
// Params 1
// Checksum 0x95b9ce72, Offset: 0x5103
// Size: 0x184
function onplayerdamaged( data )
{
    if ( data.objweapon.var_25b0062cbe4d9c99 == #"drone_launcher" && data.victim && data.eattacker && player::isreallyalive( data.victim ) )
    {
        if ( !data.victim player_utility::isenemy( data.eattacker ) )
        {
            return;
        }
        
        info = { #var_f2e44aa6b74ea18e:data.einflictor.var_f2e44aa6b74ea18e, #hittime:gettime(), #objweapon:data.objweapon, #player:data.eattacker };
        attackerentnum = data.eattacker.entnum ?? utility::get_entity_number( data.eattacker );
        
        if ( !isdefined( data.victim.var_268c314ec3159b15 ) )
        {
            data.victim.var_268c314ec3159b15 = [];
        }
        
        data.victim.var_268c314ec3159b15[ attackerentnum ] = info;
        data.eattacker thread points::doscoreevent( #"hash_280efb2a42584eca", data.objweapon );
    }
}

// Namespace drone_launcher
// Params 1
// Checksum 0xd6dda234, Offset: 0x528f
// Size: 0x21b
function onplayerdeath( data )
{
    foreach ( entry in data.victim.var_268c314ec3159b15 )
    {
        attacker = entry.player;
        
        if ( !attacker )
        {
            continue;
        }
        
        if ( isnumber( entry.hittime ) && gettime() - entry.hittime < 5000 )
        {
            if ( attacker != data.attacker )
            {
                attacker thread points::doscoreevent( #"super_drone_launcher_assist", undefined );
            }
            
            if ( data.objweapon != entry.objweapon )
            {
                attacker thread gamelogic_mp::threadedsetweaponstatbyname( entry.objweapon, 1, "kills" );
            }
            
            attacker telemetry_mp::function_89a5d8fb8ed3a4fe( data, attacker, entry.var_f2e44aa6b74ea18e, entry.objweapon );
        }
    }
    
    if ( data.victim )
    {
        data.victim.var_48b94f3a701a8500 = [];
    }
    
    inflictor = data.inflictor;
    
    if ( data.objweapon.var_25b0062cbe4d9c99 == #"drone_launcher" && !inflictor.ownerlauncher.firstkillearned )
    {
        if ( inflictor.ownerlauncher && inflictor.owner )
        {
            inflictor.ownerlauncher.firstkillearned = 1;
            inflictor.owner thread points::doscoreevent( #"drone_launcher_3_kills", data.objweapon );
        }
    }
}

// Namespace drone_launcher
// Params 1, eflags: 0x4
// Checksum 0x60f4c5, Offset: 0x54b2
// Size: 0xc3
function private on_modify_player_damage( params )
{
    inflictor = params.einflictor;
    victim = params.victim;
    
    if ( inflictor.superref == "super_drone_launcher" )
    {
        if ( victim.var_e70fa9aae35c2659 && victim == self )
        {
            params.idamage *= victim.var_e70fa9aae35c2659;
            return;
        }
        
        if ( inflictor.var_36a62e391219a1b3 )
        {
            params.idamage *= params.einflictor.var_36a62e391219a1b3;
        }
    }
}

// Namespace drone_launcher
// Params 1, eflags: 0xc
// Checksum 0xeaff4282, Offset: 0x557d
// Size: 0x1c3
function private function_8cb2d155e28c8365( initialdelay )
{
    self notify( #"hash_8e8b419e63818435" );
    self endon( #"hash_8e8b419e63818435" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.var_e86b768afd3ad21e = 1;
    wait initialdelay;
    currenttimems = gettime();
    var_620e4366d89d77e3 = 22500;
    var_f9ded15c54a2f5d0 = 2500;
    var_7b5db0f5f513d3f5 = 1000;
    dronelocations = [];
    var_336b972931b2dc11 = 0;
    
    foreach ( drone in self.drone_launcher_drones )
    {
        dronelocations[ dronelocations.size ] = drone.origin;
        
        if ( !var_336b972931b2dc11 && currenttimems - drone.var_4ad7fb4ebf47f686 > var_7b5db0f5f513d3f5 && distancesquared( drone.birthlocation, drone.origin ) < var_620e4366d89d77e3 )
        {
            var_336b972931b2dc11 = 1;
        }
    }
    
    if ( var_336b972931b2dc11 )
    {
        for ( i = 0; i < dronelocations.size ; i++ )
        {
            for ( j = i + 1; j < dronelocations.size ; j++ )
            {
                if ( distancesquared( dronelocations[ i ], dronelocations[ j ] ) < var_f9ded15c54a2f5d0 )
                {
                    thread function_1cf869d8f8075549( undefined, undefined, 1 );
                    self.var_e86b768afd3ad21e = 0;
                    return;
                }
            }
        }
    }
    
    self.var_e86b768afd3ad21e = undefined;
}

// Namespace drone_launcher
// Params 3, eflags: 0x4
// Checksum 0xd16bdec7, Offset: 0x5748
// Size: 0x1bc
function private function_1cf869d8f8075549( _launcher, _drone, shouldrefund )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( _launcher )
    {
        _launcher thread destroy_launcher( undefined, 0 );
    }
    
    if ( _drone )
    {
        _drone thread detonate_drone();
    }
    
    if ( !_launcher && !_drone )
    {
        foreach ( drone in self.drone_launcher_drones )
        {
            drone thread destroy_drone( undefined, 0, 0 );
        }
        
        self.drone_launcher_drones = undefined;
        
        foreach ( drone_launcher in self.drone_launchers )
        {
            drone_launcher thread destroy_launcher( undefined, 0 );
        }
        
        self.drone_launchers = undefined;
    }
    
    if ( shouldrefund && !isai( self ) )
    {
        supers_mp::refundsuper();
        bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_drone_launcher" );
        
        if ( bundle.var_78b610b38089e834 && isplayer( self ) )
        {
            hud_message::showerrormessage( %"hash_1d00b68283542718" );
        }
    }
}

