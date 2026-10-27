// scripts\mp\vehicles\vehicle_upgrade_mp.gsc  (hash_69528c03da3f4e0f.gscc) (size: 27451 Bytes / 0x6b3b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x810cdbfc (2165103612)
// size ...... 27451 (0x6b3b)
// includes .. 17  (offset: 0x67bb)
// strings ... 36  (offset: 0x6843)
// dev strs .. 19  (offset: 0x6a47)
// exports ... 82  (offset: 0x43a3)
// cseg ...... 0x341 + 0x4062 (0x43a3)
// imports ... 188 (offset: 0x5073)
// animtree1 . 0   (offset: 0x6b3b)
// animtree2 . 0   (offset: 0x6b3b)
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\vehicle_upgrade;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\trophy_system;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\flags;
#using scripts\mp\loot\common_inventory_groups;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;

#namespace vehicle_upgrade_mp;

// Namespace vehicle_upgrade_mp
// Params 0
// Checksum 0x95415cb7, Offset: 0x35f
// Size: 0x303
function init()
{
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_709a849183e9aeac", &function_7ace093aa0c51aeb );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_cfb734e8d4dbc90e", &function_54304b649e8f99ef );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_969e1230c993fa5f", &sweep_radar_add );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_b78b0a837c092ec9", &sweep_radar_remove );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_8f2a7f9d99b4781c", &sweep_radar_toggle );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_27e1b3f289df58ae", &function_968176bbd8f28e91 );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_fea4e2b6ae3c3db6", &function_efcfacbdcb0ebdb7 );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_fe4ab6f27fd8b223", &function_9dc6bd75359eed96 );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_7865b38aec589d83", &function_2ac2535942ff6c58 );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_3bbb5a2695442238", &function_69744922d8c68833 );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_3a2675fedf7dd472", &function_8154cc889d56848b );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_e37e653224064a6e", &function_e7574a31a69c84d5 );
    utility::registersharedfunc( #"vehicle_upgrade", #"launch_smoke_screen", &launch_smoke_screen );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_5fa634f22b7339b7", &function_57af00eab0aad5c0 );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_6ce4c060253a4423", &function_d6d9d21e8090b438 );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_935822980d8feac5", &function_5c60429eee32b798 );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_18a511d87bcc9c48", &function_5a27c401f185a9ab );
    utility::registersharedfunc( #"vehicle_upgrade", #"activate_emp", &activate_emp );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_4395b9640285946e", &function_292b0453887972df );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_3ed6ad10d8ca834", &function_b7dbdd81cb1d333b );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_e23f306f65b25de", &function_53646e9ae4f9ce1f );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_5559a03ad8c2a04b", &function_b4a6ff1e58474720 );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_5d621ce51a25bcb1", &function_8f9de6fc66c687bf );
    utility::registersharedfunc( #"vehicle_upgrade", #"hash_44c93c33e390e0cf", &function_a36119c5fa855af6 );
    register_occupant_effects();
    level.var_36be026de354325b = [];
    level callback::add( #"player_spawned", &perception_on_player_respawn );
    
    /#
        thread function_1b31ab6d960e1972();
    #/
}

// Namespace vehicle_upgrade_mp
// Params 0
// Checksum 0xfa26bab7, Offset: 0x66a
// Size: 0x3e
function function_54304b649e8f99ef()
{
    self notify( #"hash_8878732bf2c9f2f4" );
    function_74b08bcdc7ece083( self );
    self.var_b9c298004f109b81 = undefined;
    self.var_53457caf58b17961 = undefined;
    self.var_44ee127a56f17373 = undefined;
    self.vehicle_upgrade_trophy_system = undefined;
}

// Namespace vehicle_upgrade_mp
// Params 1
// Checksum 0x97d7371d, Offset: 0x6b0
// Size: 0x69
function function_7ace093aa0c51aeb( upgradeentry )
{
    config = function_4fe9815033bf1e7b( upgradeentry );
    self.var_b9c298004f109b81 = config;
    self.var_53457caf58b17961 = config.max_ammo;
    self.var_44ee127a56f17373 = 0;
    self.vehicle_upgrade_trophy_system = 1;
    function_ce1258a89fcbbf70();
    thread function_e533822672d35ed();
    thread function_898589543c9a814f();
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0xd53f2505, Offset: 0x721
// Size: 0xb2
function private function_4fe9815033bf1e7b( upgradeentry )
{
    config = spawnstruct();
    config.protection_radius = upgradeentry.trophy_protection_radius ?? 325;
    config.protection_offset = upgradeentry.var_45a93a3dbe74e624 ?? 45;
    config.max_ammo = upgradeentry.trophy_max_ammo ?? 0;
    
    if ( upgradeentry.trophy_laser_fx )
    {
        config.var_73ba4a5d351f5560 = loadfxasset( upgradeentry.trophy_laser_fx );
    }
    
    config.explosion_model = upgradeentry.var_58cc53397845b782;
    return config;
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0xb4b19684, Offset: 0x7dc
// Size: 0x368
function private function_e533822672d35ed()
{
    self endon( #"death" );
    self endon( #"hash_8878732bf2c9f2f4" );
    config = self.var_b9c298004f109b81;
    castcontents = trophy_system::trophy_castcontents();
    protectiondistsqr = config.protection_radius * config.protection_radius;
    
    while ( self.vehicle_upgrade_trophy_system == 1 )
    {
        if ( self.var_44ee127a56f17373 || config.max_ammo > 0 && self.var_53457caf58b17961 <= 0 )
        {
            utility::waittill_any( "veh_trophy_rearmed", "veh_trophy_enabled" );
            continue;
        }
        
        castorigin = self.origin + anglestoup( self.angles ) * config.protection_offset;
        
        /#
            if ( getdvarint( @"hash_68e23fb04bc4a80d", 0 ) )
            {
                debug::sphere( self.origin, config.protection_radius, "<dev string:x24>", 0.05 );
                debug::sphere( castorigin, 5, "<dev string:x2a>", 0.05 );
            }
        #/
        
        arr2d = [];
        arr2d[ 0 ] = level.grenades;
        arr2d[ 1 ] = level.missiles;
        arr2d[ 2 ] = weapon::function_3aafcaf7ff6dea9e();
        arr2d[ 3 ] = level.mortars;
        trophytargets = utility::array_combine_multiple( arr2d );
        
        foreach ( trophytarget in trophytargets )
        {
            if ( !isdefined( trophytarget ) )
            {
                continue;
            }
            
            if ( trophytarget.exploding || trophytarget.destroyed )
            {
                continue;
            }
            
            if ( trophytarget.var_be6e8f5c5d18acc )
            {
                continue;
            }
            
            if ( trophy_system::trophy_checkignorelist( trophytarget ) )
            {
                continue;
            }
            
            trophytargetowner = trophytarget.owner;
            
            if ( !isdefined( trophytargetowner ) && isdefined( trophytarget.vehicle ) )
            {
                trophytargetowner = trophytarget.vehicle.owner;
            }
            
            if ( !isdefined( trophytargetowner ) && isvalidmissile( trophytarget ) )
            {
                trophytargetowner = getmissileowner( trophytarget );
            }
            
            if ( isdefined( trophytargetowner ) && !player_utility::playersareenemies( self, trophytargetowner ) )
            {
                continue;
            }
            
            if ( trophytargetowner && self.occupants && vehicle_occupancy::get_occupant_seat( self, trophytargetowner ) )
            {
                continue;
            }
            
            if ( distancesquared( trophytarget.origin, self.origin ) > trophy_system::trophy_modifiedprotectiondistsqr( trophytarget, protectiondistsqr ) )
            {
                continue;
            }
            
            castresults = physics_raycast( castorigin, trophytarget.origin, castcontents, [ self, trophytarget ], 0, "physicsquery_closest" );
            
            if ( isdefined( castresults ) && castresults.size > 0 )
            {
                continue;
            }
            
            /#
                if ( getdvarint( @"hash_68e23fb04bc4a80d", 0 ) )
                {
                    debug::line( castorigin, trophytarget.origin, "<dev string:x2a>", 1 );
                }
            #/
            
            thread function_3be9c95869be0c62( trophytarget );
        }
        
        waitframe();
    }
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0x2b8f2363, Offset: 0xb4c
// Size: 0x103
function private function_3be9c95869be0c62( trophytarget )
{
    self endon( #"death" );
    self endon( #"hash_8878732bf2c9f2f4" );
    
    if ( !isdefined( trophytarget ) || trophytarget.exploding )
    {
        return;
    }
    
    trophytarget.var_be6e8f5c5d18acc = 1;
    config = self.var_b9c298004f109b81;
    var_17a7eeceb6ffc9a8 = config.max_ammo == 0 || self.var_53457caf58b17961 >= 1;
    
    if ( var_17a7eeceb6ffc9a8 )
    {
        if ( config.max_ammo > 0 )
        {
            self.var_53457caf58b17961--;
        }
        
        castorigin = self.origin + anglestoup( self.angles ) * config.protection_offset;
        function_e9930b6af52c26db( castorigin, trophytarget.origin );
        function_9980c06acdf0d2ca( self, castorigin, trophytarget.origin );
        function_28c185279623b088( trophytarget );
    }
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0x9e7f0c7d, Offset: 0xc57
// Size: 0x5b
function private function_28c185279623b088( trophytarget )
{
    trophytarget setcandamage( 0 );
    trophytarget.exploding = 1;
    trophytarget stopsounds();
    attacker = trophytarget.owner;
    trophytarget delete();
    
    if ( isdefined( attacker ) )
    {
        level notify( #"trophyused", attacker );
    }
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0xe701ea3f, Offset: 0xcba
// Size: 0x35
function private function_898589543c9a814f()
{
    self waittill( #"death" );
    function_74b08bcdc7ece083( self );
    self.var_53457caf58b17961 = undefined;
    self.var_44ee127a56f17373 = undefined;
    self.vehicle_upgrade_trophy_system = undefined;
}

// Namespace vehicle_upgrade_mp
// Params 2, eflags: 0x4
// Checksum 0x76d69409, Offset: 0xcf7
// Size: 0x60
function private function_e9930b6af52c26db( originpos, targetpos )
{
    config = self.var_b9c298004f109b81;
    
    if ( !isdefined( config.var_73ba4a5d351f5560 ) )
    {
        return;
    }
    
    laserpulse = function_f5f8abcd7522eee2( config.var_73ba4a5d351f5560, originpos, targetpos );
    thread function_f736d01b464aaa87( laserpulse );
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0x1b0e8312, Offset: 0xd5f
// Size: 0x1e
function private function_f736d01b464aaa87( laserpulse )
{
    wait 0.25;
    
    if ( laserpulse )
    {
        laserpulse delete();
    }
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0x903d555a, Offset: 0xd85
// Size: 0x7b
function private function_ce1258a89fcbbf70()
{
    config = self.var_b9c298004f109b81;
    
    if ( !config.explosion_model )
    {
        return;
    }
    
    explosion = spawn( "script_model", self.origin );
    explosion setmodel( config.explosion_model );
    explosion.owner = self;
    explosion.explode1available = 1;
    self.var_6aaa17521878a0a = explosion;
}

// Namespace vehicle_upgrade_mp
// Params 3, eflags: 0x4
// Checksum 0xe5a1aa2, Offset: 0xe08
// Size: 0xf7
function private function_9980c06acdf0d2ca( vehicle, castorigin, targetpos )
{
    explosion = vehicle.var_6aaa17521878a0a;
    
    if ( !explosion )
    {
        return;
    }
    
    directionangles = vectortoangles( castorigin - targetpos );
    var_c327662cf8021961 = combineangles( directionangles, ( -90, 0, 0 ) );
    explosion dontinterpolate();
    explosion.origin = targetpos;
    explosion.angles = var_c327662cf8021961;
    
    if ( explosion isscriptable() )
    {
        if ( explosion.explode1available )
        {
            explosion setscriptablepartstate( #"explode1", #"activedirectional", 0 );
            explosion.explode1available = 0;
            return;
        }
        
        explosion setscriptablepartstate( #"explode2", #"activedirectional", 0 );
        explosion.explode1available = 1;
    }
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0x5b97fb76, Offset: 0xf07
// Size: 0x35
function private function_74b08bcdc7ece083( vehicle )
{
    if ( vehicle.var_6aaa17521878a0a )
    {
        vehicle.var_6aaa17521878a0a delete();
        vehicle.var_6aaa17521878a0a = undefined;
    }
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0x98817b08, Offset: 0xf44
// Size: 0x13c
function private set_enemy_outlines()
{
    if ( !isdefined( self.operativeoutlineids ) )
    {
        self.operativeoutlineids = [];
    }
    
    var_6865fca5966be685 = level.sharedfuncs[ #"player" ][ #"isenemy" ];
    var_3e58eb1d414b2ec3 = level.sharedfuncs[ #"outline" ][ #"outlineenableforplayer" ];
    
    if ( !isdefined( var_6865fca5966be685 ) || !isdefined( var_3e58eb1d414b2ec3 ) )
    {
        return;
    }
    
    foreach ( enemy in level.players )
    {
        if ( !isplayer( enemy ) || !self [[ var_6865fca5966be685 ]]( enemy ) )
        {
            continue;
        }
        
        self.operativeoutlineids[ enemy getentitynumber() ] = [[ var_3e58eb1d414b2ec3 ]]( enemy, self, "outlinefill_highvis_nodepth_enemy_deathperception_extended", "level_script" );
    }
    
    level.var_36be026de354325b = arraycombineunique( level.var_36be026de354325b, [ self ] );
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0x4745f4d2, Offset: 0x1088
// Size: 0x15b
function private function_2a6813db1b4befd6()
{
    if ( isdefined( level.var_36be026de354325b ) )
    {
        level.var_36be026de354325b = arrayremove( level.var_36be026de354325b, self );
    }
    
    if ( !isarray( self.operativeoutlineids ) )
    {
        return;
    }
    
    var_6865fca5966be685 = level.sharedfuncs[ #"player" ][ #"isenemy" ];
    outlinedisablefunc = level.sharedfuncs[ #"outline" ][ #"outlinedisable" ];
    
    if ( !isdefined( var_6865fca5966be685 ) || !isdefined( outlinedisablefunc ) )
    {
        return;
    }
    
    foreach ( enemy in level.players )
    {
        if ( !isplayer( enemy ) || !self [[ var_6865fca5966be685 ]]( enemy ) )
        {
            continue;
        }
        
        enemyentnum = enemy getentitynumber();
        
        if ( isdefined( self.operativeoutlineids[ enemyentnum ] ) )
        {
            [[ outlinedisablefunc ]]( self.operativeoutlineids[ enemyentnum ], enemy );
        }
    }
    
    self.operativeoutlineids = undefined;
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0x695fa7f8, Offset: 0x11eb
// Size: 0x187
function private perception_on_player_respawn( params )
{
    player = params.player;
    wait 1;
    
    if ( !isdefined( level.var_36be026de354325b ) || !level.var_36be026de354325b.size )
    {
        return;
    }
    
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return;
    }
    
    var_6865fca5966be685 = level.sharedfuncs[ #"player" ][ #"isenemy" ];
    var_3e58eb1d414b2ec3 = level.sharedfuncs[ #"outline" ][ #"outlineenableforplayer" ];
    
    if ( !isdefined( var_6865fca5966be685 ) || !isdefined( var_3e58eb1d414b2ec3 ) )
    {
        return;
    }
    
    foreach ( var_3fc66ff0c7042929 in level.var_36be026de354325b )
    {
        if ( !isdefined( var_3fc66ff0c7042929 ) )
        {
            continue;
        }
        
        if ( !var_3fc66ff0c7042929 [[ var_6865fca5966be685 ]]( player ) )
        {
            continue;
        }
        
        if ( !isdefined( var_3fc66ff0c7042929.operativeoutlineids ) )
        {
            var_3fc66ff0c7042929.operativeoutlineids = [];
        }
        
        entnum = player getentitynumber();
        var_3fc66ff0c7042929.operativeoutlineids[ entnum ] = [[ var_3e58eb1d414b2ec3 ]]( player, var_3fc66ff0c7042929, "outlinefill_highvis_nodepth_enemy_deathperception_extended", "level_script" );
    }
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0xb1f5000c, Offset: 0x137a
// Size: 0xc9
function private function_ad2aa91f41ab7ac5( effect )
{
    if ( !isdefined( level.var_c1ccc445c80a83c0 ) )
    {
        level.var_c1ccc445c80a83c0 = [];
    }
    
    if ( level.var_c1ccc445c80a83c0[ effect.name ] )
    {
        return;
    }
    
    if ( !level.var_4f9f950b6be730eb )
    {
        level.var_4f9f950b6be730eb = 1;
        level callback::add( "onEnterVehicle", &function_ec13caa61ae04d48 );
        level callback::add( "onExitVehicle", &function_f14158fa586dc746 );
    }
    
    effect.refreshnotify = "veh_occupant_effect_" + effect.name;
    effect.var_49f1289b52dc0a7e = "veh_occupant_auto_deact_" + effect.name;
    level.var_c1ccc445c80a83c0[ effect.name ] = effect;
}

// Namespace vehicle_upgrade_mp
// Params 2
// Checksum 0x73d68bab, Offset: 0x144b
// Size: 0x110
function function_efcfacbdcb0ebdb7( name, upgradeentry )
{
    if ( !isdefined( self.var_c1ccc445c80a83c0 ) )
    {
        self.var_c1ccc445c80a83c0 = [];
    }
    
    state = spawnstruct();
    state.active = 0;
    state.players = [];
    state.var_8657c9dbba98ab75 = upgradeentry.var_c6a21beb6811e32d ?? 1;
    state.var_352973ea3b8ef597 = upgradeentry.var_9cd3f5bf57632c63 ?? 0;
    state.cooldown = upgradeentry.var_f47962feea1863e5 ?? 0;
    state.var_93129250a967ca8d = upgradeentry.var_7e949f3c821983cd ?? 1;
    state.lingerduration = upgradeentry.var_2b026b68f8df54c0 ?? 0;
    state.var_24d082b749054d17 = upgradeentry.var_bbaee3eee3405223 ?? 0;
    self.var_c1ccc445c80a83c0[ name ] = state;
    thread function_540c2aaa0eb3b62d( name );
}

// Namespace vehicle_upgrade_mp
// Params 1
// Checksum 0x21d6f295, Offset: 0x1563
// Size: 0x4d
function function_9dc6bd75359eed96( name )
{
    if ( !self.var_c1ccc445c80a83c0 || !self.var_c1ccc445c80a83c0[ name ] )
    {
        return;
    }
    
    function_e4bd93c0e2665b21( self, name );
    self.var_c1ccc445c80a83c0[ name ].active = 0;
}

// Namespace vehicle_upgrade_mp
// Params 1
// Checksum 0xa5ad9b7e, Offset: 0x15b8
// Size: 0xf0
function function_2ac2535942ff6c58( name )
{
    if ( !self.var_c1ccc445c80a83c0 || !self.var_c1ccc445c80a83c0[ name ] )
    {
        return;
    }
    
    state = self.var_c1ccc445c80a83c0[ name ];
    
    if ( state.active && !state.var_8657c9dbba98ab75 )
    {
        return;
    }
    
    if ( !state.active && state.cooldown > 0 && state.cooldown_until && gettime() < state.cooldown_until )
    {
        return;
    }
    
    state.active = !state.active;
    function_b63e874ca138a37b( self, name );
    
    if ( state.active && state.var_352973ea3b8ef597 > 0 )
    {
        thread function_38aaeca3733d8352( name );
    }
}

// Namespace vehicle_upgrade_mp
// Params 2
// Checksum 0xd974d9d6, Offset: 0x16b0
// Size: 0xac
function function_69744922d8c68833( name, active )
{
    if ( !self.var_c1ccc445c80a83c0 || !self.var_c1ccc445c80a83c0[ name ] )
    {
        return;
    }
    
    state = self.var_c1ccc445c80a83c0[ name ];
    
    if ( state.active == active )
    {
        return;
    }
    
    if ( !active && !state.var_8657c9dbba98ab75 )
    {
        return;
    }
    
    state.active = active;
    function_b63e874ca138a37b( self, name );
    
    if ( active && state.var_352973ea3b8ef597 > 0 )
    {
        thread function_38aaeca3733d8352( name );
    }
}

// Namespace vehicle_upgrade_mp
// Params 2, eflags: 0x4
// Checksum 0x20a476ce, Offset: 0x1764
// Size: 0x16b
function private function_b63e874ca138a37b( vehicle, name )
{
    state = vehicle.var_c1ccc445c80a83c0[ name ];
    effect = level.var_c1ccc445c80a83c0[ name ];
    
    if ( state.active )
    {
        if ( effect.vehicle_activate_func )
        {
            [[ effect.vehicle_activate_func ]]( vehicle );
        }
        
        if ( state.var_24d082b749054d17 )
        {
            occupants = [];
            driver = vehicle_occupancy::get_driver( vehicle, 1 );
            
            if ( driver )
            {
                occupants[ occupants.size ] = driver;
            }
        }
        else
        {
            occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( vehicle, 0 );
        }
        
        foreach ( occupant in occupants )
        {
            if ( isplayer( occupant ) && isalive( occupant ) )
            {
                function_9f56af63d0ce77b1( occupant, vehicle, name, effect, state );
            }
        }
        
        return;
    }
    
    if ( effect.var_5684ad04747e30fc )
    {
        [[ effect.var_5684ad04747e30fc ]]( vehicle );
    }
    
    function_e4bd93c0e2665b21( vehicle, name );
}

// Namespace vehicle_upgrade_mp
// Params 5, eflags: 0x4
// Checksum 0x422cb155, Offset: 0x18d7
// Size: 0x148
function private function_9f56af63d0ce77b1( player, vehicle, name, effect, state )
{
    if ( !isdefined( player.var_cc57ebb12c59c41d ) )
    {
        player.var_cc57ebb12c59c41d = [];
    }
    
    if ( !isdefined( player.var_6b458fc2b966b0a1 ) )
    {
        player.var_6b458fc2b966b0a1 = [];
    }
    
    if ( player.var_cc57ebb12c59c41d[ name ] )
    {
        old_vehicle = player.var_6b458fc2b966b0a1[ name ];
        
        if ( old_vehicle && old_vehicle.var_c1ccc445c80a83c0[ name ] && old_vehicle != vehicle )
        {
            old_state = old_vehicle.var_c1ccc445c80a83c0[ name ];
            old_state.players = arrayremove( old_state.players, player );
        }
    }
    
    player notify( effect.refreshnotify );
    [[ effect.give_func ]]( player, vehicle );
    player.var_cc57ebb12c59c41d[ name ] = 1;
    player.var_6b458fc2b966b0a1[ name ] = vehicle;
    state.players = arraycombineunique( state.players, [ player ] );
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0x242c4a2d, Offset: 0x1a27
// Size: 0x126
function private function_ec13caa61ae04d48( params )
{
    vehicle = params.vehicle;
    player = params.player;
    
    if ( !vehicle.var_c1ccc445c80a83c0 )
    {
        return;
    }
    
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return;
    }
    
    foreach ( name, state in vehicle.var_c1ccc445c80a83c0 )
    {
        if ( !state.active )
        {
            continue;
        }
        
        effect = level.var_c1ccc445c80a83c0[ name ];
        
        if ( state.var_24d082b749054d17 && vehicle_occupancy::get_driver( vehicle, 1 ) != player )
        {
            continue;
        }
        
        function_9f56af63d0ce77b1( player, vehicle, name, effect, state );
    }
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0x160955ae, Offset: 0x1b55
// Size: 0x2ad
function private function_f14158fa586dc746( params )
{
    vehicle = params.vehicle;
    player = params.player;
    
    if ( !vehicle.var_c1ccc445c80a83c0 )
    {
        return;
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    foreach ( name, state in vehicle.var_c1ccc445c80a83c0 )
    {
        if ( !player.var_cc57ebb12c59c41d || !player.var_cc57ebb12c59c41d[ name ] )
        {
            continue;
        }
        
        if ( !player.var_6b458fc2b966b0a1 || player.var_6b458fc2b966b0a1[ name ] != vehicle )
        {
            continue;
        }
        
        effect = level.var_c1ccc445c80a83c0[ name ];
        
        if ( !isalive( player ) || params.data.playerdeath || params.data.playerdisconnect )
        {
            state.players = arrayremove( state.players, player );
            function_f0af5b1a32edae43( player, name, effect );
            continue;
        }
        
        if ( state.lingerduration > 0 )
        {
            player thread function_5e6e5eadf27f8773( vehicle, name );
            continue;
        }
        
        state.players = arrayremove( state.players, player );
        function_f0af5b1a32edae43( player, name, effect );
    }
    
    occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( vehicle, 0 );
    
    if ( occupants.size == 0 )
    {
        foreach ( name, state in vehicle.var_c1ccc445c80a83c0 )
        {
            if ( state.active && state.var_93129250a967ca8d )
            {
                effect = level.var_c1ccc445c80a83c0[ name ];
                state.active = 0;
                
                if ( effect.var_5684ad04747e30fc )
                {
                    [[ effect.var_5684ad04747e30fc ]]( vehicle );
                }
                
                function_e4bd93c0e2665b21( vehicle, name );
            }
        }
    }
}

// Namespace vehicle_upgrade_mp
// Params 3, eflags: 0x4
// Checksum 0xc086e950, Offset: 0x1e0a
// Size: 0x4c
function private function_f0af5b1a32edae43( player, name, effect )
{
    [[ effect.remove_func ]]( player );
    player.var_cc57ebb12c59c41d[ name ] = 0;
    player.var_6b458fc2b966b0a1[ name ] = undefined;
}

// Namespace vehicle_upgrade_mp
// Params 2, eflags: 0x4
// Checksum 0x3f5ca0a8, Offset: 0x1e5e
// Size: 0xe1
function private function_e4bd93c0e2665b21( vehicle, name )
{
    state = vehicle.var_c1ccc445c80a83c0[ name ];
    effect = level.var_c1ccc445c80a83c0[ name ];
    
    foreach ( player in state.players )
    {
        if ( player )
        {
            player notify( effect.refreshnotify );
            function_f0af5b1a32edae43( player, name, effect );
        }
    }
    
    state.players = [];
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0xa8b82587, Offset: 0x1f47
// Size: 0x3e
function private function_540c2aaa0eb3b62d( name )
{
    level endon( #"game_ended" );
    self waittill( #"death" );
    
    if ( self.var_c1ccc445c80a83c0[ name ] )
    {
        function_e4bd93c0e2665b21( self, name );
    }
}

// Namespace vehicle_upgrade_mp
// Params 2, eflags: 0x4
// Checksum 0x6c0c709d, Offset: 0x1f8d
// Size: 0xed
function private function_5e6e5eadf27f8773( vehicle, name )
{
    effect = level.var_c1ccc445c80a83c0[ name ];
    state = vehicle.var_c1ccc445c80a83c0[ name ];
    self endon( effect.refreshnotify );
    level endon( #"game_ended" );
    utility::waittill_any_timeout( state.lingerduration, "death_or_disconnect" );
    
    if ( !self.var_cc57ebb12c59c41d || !self.var_cc57ebb12c59c41d[ name ] )
    {
        return;
    }
    
    if ( vehicle && vehicle.var_c1ccc445c80a83c0[ name ] )
    {
        vehicle.var_c1ccc445c80a83c0[ name ].players = arrayremove( vehicle.var_c1ccc445c80a83c0[ name ].players, self );
    }
    
    function_f0af5b1a32edae43( self, name, effect );
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0x8bc62c89, Offset: 0x2082
// Size: 0xf0
function private function_38aaeca3733d8352( name )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    effect = level.var_c1ccc445c80a83c0[ name ];
    state = self.var_c1ccc445c80a83c0[ name ];
    self notify( effect.var_49f1289b52dc0a7e );
    self endon( effect.var_49f1289b52dc0a7e );
    wait state.var_352973ea3b8ef597;
    
    if ( state.active )
    {
        state.active = 0;
        
        if ( effect.var_5684ad04747e30fc )
        {
            [[ effect.var_5684ad04747e30fc ]]( self );
        }
        
        function_e4bd93c0e2665b21( self, name );
        
        if ( state.cooldown > 0 )
        {
            state.cooldown_until = gettime() + int( state.cooldown * 1000 );
        }
    }
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0x7d71a289, Offset: 0x217a
// Size: 0x178
function private register_occupant_effects()
{
    effect = spawnstruct();
    effect.name = "Constant_Radar";
    effect.give_func = &function_56e4c3eff4355493;
    effect.remove_func = &function_d8b01d293118d4f1;
    function_ad2aa91f41ab7ac5( effect );
    effect = spawnstruct();
    effect.name = "Active_Camo";
    effect.give_func = &function_64e64d10ace1abe3;
    effect.remove_func = &function_425b19b4a12627a1;
    effect.vehicle_activate_func = &active_camo_activate_vehicle;
    effect.var_5684ad04747e30fc = &function_9dd3d33d689b0983;
    function_ad2aa91f41ab7ac5( effect );
    effect = spawnstruct();
    effect.name = "Perception";
    effect.give_func = &function_fc5dd44e61006d27;
    effect.remove_func = &function_f0f54cdef64428dd;
    function_ad2aa91f41ab7ac5( effect );
    effect = spawnstruct();
    effect.name = "Engineer_Perk";
    effect.give_func = &function_2b2a700609b25434;
    effect.remove_func = &function_44fe751d1ea8fa32;
    function_ad2aa91f41ab7ac5( effect );
    effect = spawnstruct();
    effect.name = "See_Safes";
    effect.give_func = &function_52145bb944bdd7ec;
    effect.remove_func = &function_90c9d4176c3e628a;
    function_ad2aa91f41ab7ac5( effect );
}

// Namespace vehicle_upgrade_mp
// Params 2, eflags: 0x4
// Checksum 0x135d3e5a, Offset: 0x22fa
// Size: 0x75
function private function_56e4c3eff4355493( player, vehicle )
{
    player.skipuavupdate = 1;
    player.radarstrength = level.uavnoneid + 1;
    player.isradarblocked = 0;
    player.hasradar = 1;
    player.radarshowenemydirection = 1;
    player.radarmode = "constant_radar";
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0x3d8eea9c, Offset: 0x2377
// Size: 0x25
function private function_d8b01d293118d4f1( player )
{
    player.skipuavupdate = 0;
    level notify( #"uav_update" );
}

// Namespace vehicle_upgrade_mp
// Params 2, eflags: 0x4
// Checksum 0x12414d3f, Offset: 0x23a4
// Size: 0x114
function private function_64e64d10ace1abe3( player, vehicle )
{
    if ( utility::issharedfuncdefined( #"player", #"hash_104a5cd5cbb639b6" ) )
    {
        player thread utility::callsharedfunc( #"player", #"hash_104a5cd5cbb639b6" );
    }
    
    player.ignoreme = 1;
    teams = vehicle get_occupant_teams();
    var_db9eb7b8d975edb0 = 0;
    
    foreach ( team in teams )
    {
        if ( team == player.team )
        {
            var_db9eb7b8d975edb0 = 1;
            break;
        }
    }
    
    if ( !var_db9eb7b8d975edb0 )
    {
        waitframe();
        function_5b006f33979d6909( vehicle, player.team, 1 );
    }
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0x7cfb0d44, Offset: 0x24c0
// Size: 0x172
function private function_425b19b4a12627a1( player )
{
    if ( utility::issharedfuncdefined( #"player", #"hash_64b07f4926bae8f8" ) )
    {
        player thread utility::callsharedfunc( #"player", #"hash_64b07f4926bae8f8" );
    }
    
    player.ignoreme = 0;
    vehicle = player.var_6b458fc2b966b0a1[ "Active_Camo" ];
    
    if ( isdefined( vehicle ) && isdefined( vehicle.var_c1ccc445c80a83c0[ "Active_Camo" ] ) && vehicle.var_c1ccc445c80a83c0[ "Active_Camo" ].active )
    {
        occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( vehicle, 0 );
        var_8ce1c7e27dfa222 = 0;
        
        foreach ( occupant in occupants )
        {
            if ( isplayer( occupant ) && occupant.team == player.team )
            {
                var_8ce1c7e27dfa222 = 1;
                break;
            }
        }
        
        if ( !var_8ce1c7e27dfa222 )
        {
            waitframe();
            function_5b006f33979d6909( vehicle, player.team, 0 );
        }
    }
}

// Namespace vehicle_upgrade_mp
// Params 3, eflags: 0x4
// Checksum 0xfc3f8d7f, Offset: 0x263a
// Size: 0xb8
function private function_5b006f33979d6909( vehicle, team, show )
{
    if ( !isdefined( team ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( function_d2aadc4def6f75fc( team, player ) )
        {
            vehicle vehicleshowonminimapforclient( player, show );
        }
    }
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0x36816e43, Offset: 0x26fa
// Size: 0x37
function private active_camo_activate_vehicle( vehicle )
{
    if ( vehicle getscriptablehaspart( "active_camo" ) )
    {
        vehicle utility::function_7c10ea82c1e305b8( "active_camo", "camo_fx_activate" );
    }
    
    waitframe();
    function_b8cbdf85b4b1e820( vehicle );
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0xbdbb3122, Offset: 0x2739
// Size: 0xb1
function private function_9dd3d33d689b0983( vehicle )
{
    if ( vehicle getscriptablehaspart( "active_camo" ) )
    {
        vehicle utility::function_7c10ea82c1e305b8( "active_camo", "camo_fx_deactivate" );
    }
    
    waitframe();
    
    foreach ( player in level.players )
    {
        if ( isplayer( player ) )
        {
            vehicle vehicleshowonminimapforclient( player, 1 );
        }
    }
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0x90a6b0e6, Offset: 0x27f2
// Size: 0x129
function private function_b8cbdf85b4b1e820( vehicle )
{
    teams = vehicle get_occupant_teams();
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        isfriendly = 0;
        
        foreach ( team in teams )
        {
            if ( function_d2aadc4def6f75fc( team, player ) )
            {
                isfriendly = 1;
                break;
            }
        }
        
        vehicle vehicleshowonminimapforclient( player, isfriendly );
    }
}

// Namespace vehicle_upgrade_mp
// Params 2, eflags: 0x4
// Checksum 0xecae13c7, Offset: 0x2923
// Size: 0x56
function private function_fc5dd44e61006d27( player, vehicle )
{
    player perk::giveperk( "specialty_awareness" );
    player perk::giveperk( "specialty_paranoia" );
    player perk::giveperk( "specialty_squad_link" );
    player perk::giveperk( "specialty_tracker_pro" );
    player set_enemy_outlines();
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0xc815c3af, Offset: 0x2981
// Size: 0x4d
function private function_f0f54cdef64428dd( player )
{
    player perk::removeperk( "specialty_awareness" );
    player perk::removeperk( "specialty_paranoia" );
    player perk::removeperk( "specialty_squad_link" );
    player perk::removeperk( "specialty_tracker_pro" );
    player function_2a6813db1b4befd6();
}

// Namespace vehicle_upgrade_mp
// Params 2, eflags: 0x4
// Checksum 0xc52a9dfe, Offset: 0x29d6
// Size: 0x23
function private function_2b2a700609b25434( player, vehicle )
{
    player perk::giveperk( "specialty_engineer" );
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0xcd2e6b50, Offset: 0x2a01
// Size: 0x1a
function private function_44fe751d1ea8fa32( player )
{
    player perk::removeperk( "specialty_engineer" );
}

// Namespace vehicle_upgrade_mp
// Params 2, eflags: 0x4
// Checksum 0xaad140d1, Offset: 0x2a23
// Size: 0x3a
function private function_52145bb944bdd7ec( player, vehicle )
{
    if ( !isdefined( vehicle.var_fcec16b638cd3151 ) )
    {
        return;
    }
    
    function_295d9752ce30b66a( player, vehicle.var_fcec16b638cd3151 );
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0xd1eba724, Offset: 0x2a65
// Size: 0x27
function private function_90c9d4176c3e628a( player )
{
    if ( !isdefined( player.var_dfeb19718453f917 ) )
    {
        return;
    }
    
    function_295d9752ce30b66a( player, [] );
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0xe8415fbe, Offset: 0x2a94
// Size: 0x15d
function private function_7f6ef8f9d15dfeff( upgradeentry )
{
    config = spawnstruct();
    config.is_team_shared = upgradeentry && upgradeentry.var_eda31f7d0614cc29;
    config.var_67f9e5a5f6aed92 = upgradeentry.var_7d355b9932ae7ea6 ?? 2000;
    config.var_8cac3e368d80309e = upgradeentry.var_10f151023266a122 ?? 2000;
    config.ping_interval = upgradeentry.var_e4335d22cb79d776 ?? 1.5;
    config.strength = upgradeentry.sweep_radar_strength ?? 6;
    config.fade_time = upgradeentry.var_f3cd7baaa29a48a0 ?? 3;
    
    if ( config.is_team_shared )
    {
        config.var_dd9ef83464df09e4 = upgradeentry.var_b193ce3a4bcb2a6c ?? 200;
    }
    
    offset = upgradeentry.var_ca76aac85a35c443;
    
    if ( offset )
    {
        config.center_offset = ( offset.x, offset.y, offset.z );
    }
    else
    {
        config.center_offset = ( 0, 0, 0 );
    }
    
    return config;
}

// Namespace vehicle_upgrade_mp
// Params 1
// Checksum 0x58b48997, Offset: 0x2bfa
// Size: 0x2e
function sweep_radar_add( upgradeentry )
{
    self.var_ca333417ada8e81c = function_7f6ef8f9d15dfeff( upgradeentry );
    self.var_1df5e86bf0b3eeb4 = 0;
    thread function_c801ff0cb3a1f8a2();
}

// Namespace vehicle_upgrade_mp
// Params 0
// Checksum 0x5cb2688d, Offset: 0x2c30
// Size: 0x18
function sweep_radar_remove()
{
    self.var_1df5e86bf0b3eeb4 = 0;
    self notify( #"sweep_radar_stop" );
}

// Namespace vehicle_upgrade_mp
// Params 0
// Checksum 0xbacdd30e, Offset: 0x2c50
// Size: 0x15
function sweep_radar_toggle()
{
    self.var_1df5e86bf0b3eeb4 = !self.var_1df5e86bf0b3eeb4;
}

// Namespace vehicle_upgrade_mp
// Params 1
// Checksum 0x70226aee, Offset: 0x2c6d
// Size: 0x17
function function_968176bbd8f28e91( active )
{
    self.var_1df5e86bf0b3eeb4 = active;
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0xa89ffa03, Offset: 0x2c8c
// Size: 0x2b9
function private function_c801ff0cb3a1f8a2()
{
    self endon( #"death" );
    self endon( #"sweep_radar_stop" );
    config = self.var_ca333417ada8e81c;
    
    while ( true )
    {
        if ( self.var_1df5e86bf0b3eeb4 )
        {
            localoffset = config.center_offset;
            worldoffset = anglestoforward( self.angles ) * localoffset[ 0 ] + anglestoright( self.angles ) * localoffset[ 1 ] + anglestoup( self.angles ) * localoffset[ 2 ];
            scancenter = self.origin + worldoffset;
            
            /#
                if ( getdvarint( @"hash_16f522e7e2aa662d", 0 ) )
                {
                    debug::cylinder( scancenter + ( 0, 0, -500 ), scancenter + ( 0, 0, 500 ), config.var_67f9e5a5f6aed92, "<dev string:x2e>", config.ping_interval );
                    
                    if ( config.is_team_shared )
                    {
                        debug::sphere( scancenter, config.var_dd9ef83464df09e4, "<dev string:x35>", config.ping_interval );
                    }
                }
            #/
            
            if ( config.is_team_shared )
            {
                teams = get_occupant_teams();
                
                foreach ( team in teams )
                {
                    triggerportableradarpingteam( scancenter, team, config.var_67f9e5a5f6aed92, config.var_8cac3e368d80309e, config.strength, config.fade_time, config.var_dd9ef83464df09e4 );
                }
            }
            else
            {
                occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( self, 0 );
                
                foreach ( occupant in occupants )
                {
                    if ( isplayer( occupant ) )
                    {
                        triggerportableradarping( scancenter, occupant, config.var_67f9e5a5f6aed92, config.var_8cac3e368d80309e, undefined, config.fade_time, 1, 0 );
                    }
                }
            }
        }
        
        wait config.ping_interval;
    }
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0xa7ecde08, Offset: 0x2f4d
// Size: 0xf8
function private get_occupant_teams()
{
    teams = [];
    occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( self, 0 );
    
    foreach ( occupant in occupants )
    {
        if ( isplayer( occupant ) && isdefined( occupant.team ) )
        {
            teams = arraycombineunique( teams, [ occupant.team ] );
        }
    }
    
    if ( teams.size == 0 )
    {
        owner = self getvehicleowner();
        
        if ( isdefined( owner ) && isdefined( owner.team ) )
        {
            teams[ teams.size ] = owner.team;
        }
    }
    
    return teams;
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0x89e41cd6, Offset: 0x304e
// Size: 0x2
function private function_5a27c401f185a9ab()
{
    
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0x9c50c092, Offset: 0x3058
// Size: 0x14, Type: bool
function private function_d5cfc267a19855e8()
{
    return gettime() < ( self.var_db6df428c5915f76 ?? 0 );
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0xc
// Checksum 0x6db00a8c, Offset: 0x3075
// Size: 0x11b
function private activate_emp()
{
    self notify( #"hash_7e657f1e332a339a" );
    self endon( #"hash_7e657f1e332a339a" );
    self endon( #"death" );
    level endon( #"game_ended" );
    vehicle = self;
    player = vehicle.occupants[ "driver" ];
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !vehicle function_d5cfc267a19855e8() )
    {
        vehicle setscriptablepartstate( "upgrades", "levelup", 0 );
        player function_41185448faed40ff( vehicle.origin, getdvarint( @"hash_fe576e4e17463cd9", 1250 ), getdvarint( @"hash_9190fa3f88a29f7f", 5 ) );
        vehicle.var_db6df428c5915f76 = gettime() + getdvarint( @"hash_6418505e6f1bdbfe", 5000 );
        return;
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
    {
        player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"MP/CANNOT_USE_GENERIC" );
    }
}

// Namespace vehicle_upgrade_mp
// Params 3, eflags: 0x4
// Checksum 0x9d13462d, Offset: 0x3198
// Size: 0x93
function private function_41185448faed40ff( position, radius, duration )
{
    if ( utility::issharedfuncdefined( #"emp", #"hash_eaae99751be55dfa" ) )
    {
        profilestart();
        var_3d5d737bf9d49f13 = utility::callsharedfunc( #"emp", #"hash_eaae99751be55dfa", position, radius );
        profilestop();
    }
    else
    {
        return;
    }
    
    weaponobj = makeweapon( "emp_grenade_mp" );
    thread function_42d8d47ac22f8ca7( var_3d5d737bf9d49f13, position, weaponobj, duration );
    thread function_97d17619cca670b2( position, radius, weaponobj, duration );
}

// Namespace vehicle_upgrade_mp
// Params 2, eflags: 0x4
// Checksum 0x3274318f, Offset: 0x3233
// Size: 0x54, Type: bool
function private function_d2aadc4def6f75fc( teamtocheck, var_5b415c263e1d902 )
{
    if ( !level.teambased || !isplayer( var_5b415c263e1d902 ) && !isdefined( var_5b415c263e1d902.team ) || teamtocheck != var_5b415c263e1d902.team )
    {
        return false;
    }
    
    return true;
}

// Namespace vehicle_upgrade_mp
// Params 4
// Checksum 0x3b20589d, Offset: 0x3290
// Size: 0x187
function function_97d17619cca670b2( position, radius, weaponobj, duration )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    players = getplayersinradius( position, radius );
    
    foreach ( player in players )
    {
        if ( player == self || player.iszombie || function_d2aadc4def6f75fc( self.team, player ) )
        {
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"emp", #"hash_106f69968890541b" ) )
        {
            var_62e31b5eed893295 = player utility::callsharedfunc( #"emp", #"hash_106f69968890541b" );
        }
        
        if ( !var_62e31b5eed893295 )
        {
            continue;
        }
        
        data = damage_utility::packdamagedata( self, player, 1, weaponobj, "MOD_EXPLOSIVE", undefined, position );
        data.issubmunition = 0;
        data.scoreevent = #"emped_player";
        data.debuffseconds = duration;
        thread applyempplayer( data );
    }
}

// Namespace vehicle_upgrade_mp
// Params 1
// Checksum 0xfda4efd6, Offset: 0x341f
// Size: 0x21
function function_a79afdc5a5701a04( var_ee06a62e6129c73f )
{
    return var_ee06a62e6129c73f * getdvarfloat( @"hash_15b437f546c5016", 0.25 );
}

// Namespace vehicle_upgrade_mp
// Params 4
// Checksum 0x41024791, Offset: 0x3449
// Size: 0x220
function function_42d8d47ac22f8ca7( var_3d5d737bf9d49f13, position, weaponobj, duration )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    foreach ( entity in var_3d5d737bf9d49f13 )
    {
        entowner = entity.owner;
        
        if ( isdefined( entowner ) && function_d2aadc4def6f75fc( self.team, entowner ) )
        {
            continue;
        }
        
        if ( entity vehicle::is_vehicle() )
        {
            var_9e06c404492356f4 = entity vehicle_gettopspeedforward( 1 );
            var_5dbbed941cd21aa3 = entity vehicle_gettopspeedreverse( 1 );
            
            if ( !entity.hasemped )
            {
                entity.hasemped = 1;
                entity vehicle_settopspeedforward( function_a79afdc5a5701a04( var_9e06c404492356f4 ) );
                entity vehicle_settopspeedreverse( function_a79afdc5a5701a04( var_5dbbed941cd21aa3 ) );
                var_c8d21a15de45eac9 = getdvarint( @"hash_9190fa3f88a29f7f", 10 );
                occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( entity, 0 );
                vehicle_omnvar::show_warning( "shockStickAttached", occupants, entity vehicle::get_ref() );
                
                while ( var_c8d21a15de45eac9 > 0 )
                {
                    wait 1;
                    var_c8d21a15de45eac9 -= 1;
                }
                
                entity vehicle_settopspeedforward( var_9e06c404492356f4 );
                entity vehicle_settopspeedreverse( var_5dbbed941cd21aa3 );
                occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( entity, 0 );
                vehicle_omnvar::hide_warning( "shockStickAttached", occupants, entity vehicle::get_ref() );
                entity.hasemped = 0;
            }
            
            continue;
        }
        
        data = damage_utility::packdamagedata( self, entity, 10000, weaponobj, "MOD_EXPLOSIVE", undefined, position );
        data.issubmunition = 0;
        data.debuffseconds = duration;
        thread applyempnonplayer( data );
    }
}

// Namespace vehicle_upgrade_mp
// Params 2, eflags: 0x4
// Checksum 0x9f00b74e, Offset: 0x3671
// Size: 0x31
function private function_f78127dff6faa8fc( victim, durationseconds )
{
    victim endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait durationseconds;
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0xc21b0d32, Offset: 0x36aa
// Size: 0x131
function private applyempplayer( data )
{
    if ( utility::issharedfuncdefined( #"emp", #"hash_5bc4b139d38210ad" ) )
    {
        utility::callsharedfunc( #"emp", #"hash_5bc4b139d38210ad", data );
    }
    
    if ( utility::issharedfuncdefined( #"emp", #"hash_c22686576f84955f" ) )
    {
        data.victim utility::callsharedfunc( #"emp", #"hash_c22686576f84955f", 5 );
    }
    
    data.victim shellshock( "default", data.debuffseconds );
    data.victim playlocalsound( "zxp_emp_impact_plr" );
    data.victim utility::setplayerstunned();
    data.victim thread function_71e0b735fc915bb0( data.debuffseconds );
    function_1ffb4e19af4e9ac5( data );
    
    if ( utility::issharedfuncdefined( #"emp", #"hash_fb0ad9860238a077" ) )
    {
        data.victim utility::callsharedfunc( #"emp", #"hash_fb0ad9860238a077", 5 );
    }
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0x4bb35148, Offset: 0x37e3
// Size: 0x2b
function private function_71e0b735fc915bb0( time )
{
    wait time;
    
    if ( !self || !isdefined( self.isstunned ) )
    {
        return;
    }
    
    utility::setplayerunstunned();
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0x2bfc6fdf, Offset: 0x3816
// Size: 0x4b
function private applyempnonplayer( data )
{
    if ( utility::issharedfuncdefined( #"emp", #"hash_5bc4b139d38210ad" ) )
    {
        utility::callsharedfunc( #"emp", #"hash_5bc4b139d38210ad", data );
    }
    
    function_1ffb4e19af4e9ac5( data );
}

// Namespace vehicle_upgrade_mp
// Params 1, eflags: 0x4
// Checksum 0x3b4e6944, Offset: 0x3869
// Size: 0x79
function private function_1ffb4e19af4e9ac5( data )
{
    function_f78127dff6faa8fc( data.victim, data.debuffseconds );
    
    if ( !isdefined( data.victim ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"emp", #"hash_9330c9a73c217db8" ) )
    {
        data.victim utility::callsharedfunc( #"emp", #"hash_9330c9a73c217db8" );
    }
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0x9485060f, Offset: 0x38ea
// Size: 0x2
function private function_292b0453887972df()
{
    
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0x702ca0cd, Offset: 0x38f4
// Size: 0x22
function private function_b7dbdd81cb1d333b()
{
    if ( !isdefined( level.var_81350fe8269259c3 ) )
    {
        return;
    }
    
    self.var_fcec16b638cd3151 = [];
    thread function_48495f48d4685de6();
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0xe136c563, Offset: 0x391e
// Size: 0x18
function private function_53646e9ae4f9ce1f()
{
    self notify( #"hash_2e968ac04301fa5b" );
    self.var_fcec16b638cd3151 = undefined;
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0x97fcf717, Offset: 0x393e
// Size: 0x2ec
function private function_48495f48d4685de6()
{
    self endon( #"death" );
    self endon( #"hash_2e968ac04301fa5b" );
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    lastorigin = undefined;
    var_b96356d2d70dcc51 = 0;
    
    while ( true )
    {
        state = self.var_c1ccc445c80a83c0[ "See_Safes" ];
        
        if ( !isdefined( state ) || !isdefined( state.players ) || !state.players.size )
        {
            wait 1;
            continue;
        }
        
        opencount = 0;
        
        if ( isdefined( level.opencaches ) )
        {
            opencount = level.opencaches.size;
        }
        
        vehiclemoved = !isdefined( lastorigin ) || distance2dsquared( self.origin, lastorigin ) > 10000;
        cacheschanged = opencount != var_b96356d2d70dcc51;
        
        if ( !vehiclemoved && !cacheschanged )
        {
            wait 1;
            continue;
        }
        
        lastorigin = self.origin;
        var_b96356d2d70dcc51 = opencount;
        sorted = sortbydistance( level.var_81350fe8269259c3, self.origin );
        newclosest = [];
        
        foreach ( marker in sorted )
        {
            if ( !isdefined( marker ) || marker.obj_id == -1 )
            {
                continue;
            }
            
            if ( marker.var_8df89ed250ace0df === 1 )
            {
                continue;
            }
            
            newclosest[ newclosest.size ] = marker;
            
            if ( newclosest.size >= 10 )
            {
                break;
            }
        }
        
        self.var_fcec16b638cd3151 = newclosest;
        prevclosest = self.var_8af08224b892f5e1;
        
        if ( isdefined( prevclosest ) && prevclosest.size == newclosest.size )
        {
            changed = 0;
            
            for ( i = 0; i < newclosest.size ; i++ )
            {
                if ( newclosest[ i ] != prevclosest[ i ] )
                {
                    changed = 1;
                    break;
                }
            }
            
            if ( !changed )
            {
                wait 1;
                continue;
            }
        }
        
        self.var_8af08224b892f5e1 = newclosest;
        
        foreach ( player in state.players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            function_295d9752ce30b66a( player, newclosest );
        }
        
        wait 1;
    }
}

// Namespace vehicle_upgrade_mp
// Params 2, eflags: 0x4
// Checksum 0x3e029823, Offset: 0x3c32
// Size: 0x162
function private function_295d9752ce30b66a( player, newclosest )
{
    shownmarkers = player.var_dfeb19718453f917;
    
    if ( isdefined( shownmarkers ) )
    {
        foreach ( marker in shownmarkers )
        {
            if ( isdefined( marker ) && marker.obj_id != -1 )
            {
                objidpoolmanager::objective_playermask_hidefrom( marker.obj_id, player );
            }
        }
    }
    
    foreach ( marker in newclosest )
    {
        if ( isdefined( marker ) && marker.obj_id != -1 )
        {
            objidpoolmanager::objective_playermask_addshowplayer( marker.obj_id, player );
        }
    }
    
    player.var_dfeb19718453f917 = arraycopy( newclosest );
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0x63382c03, Offset: 0x3d9c
// Size: 0x2
function private function_8154cc889d56848b()
{
    
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0x8b2152e1, Offset: 0x3da6
// Size: 0x2
function private function_e7574a31a69c84d5()
{
    
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0x7cc28c93, Offset: 0x3db0
// Size: 0x88
function private function_57af00eab0aad5c0()
{
    wasactive = 0;
    camostate = undefined;
    
    if ( self.var_c1ccc445c80a83c0 )
    {
        camostate = self.var_c1ccc445c80a83c0[ "Active_Camo" ];
    }
    
    if ( camostate )
    {
        wasactive = camostate.active;
    }
    
    function_2ac2535942ff6c58( "Active_Camo" );
    camostate = self.var_c1ccc445c80a83c0[ "Active_Camo" ];
    
    if ( !wasactive && camostate && camostate.active )
    {
        launch_smoke_screen();
    }
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0xc
// Checksum 0x5ab3cbf7, Offset: 0x3e40
// Size: 0x17e
function private launch_smoke_screen()
{
    self notify( #"hash_b6cb0c03400dc010" );
    self endon( #"hash_b6cb0c03400dc010" );
    self endon( #"death" );
    level endon( #"game_ended" );
    speed = self vehicle_getspeed();
    topspeed = self vehicle_gettopspeedforward();
    normalizedspeed = max( 0, speed / topspeed );
    var_684cbc1836be52ac = getdvarfloat( @"hash_3e9af40cc291f796", 750 );
    var_8b0cc0990f3e2706 = getdvarfloat( @"hash_5bec809047720b24", 1000 );
    tossspeed = mapfloat( 0, 1, var_684cbc1836be52ac, var_8b0cc0990f3e2706, normalizedspeed );
    numoccupants = self.occupants.size;
    
    if ( numoccupants > 0 )
    {
        driver = self.occupants[ "driver" ];
    }
    
    if ( !driver )
    {
        return;
    }
    
    viewdirection = anglestoforward( driver getplayerangles() );
    velocity = self vehicle_getvelocity();
    velocity += viewdirection * tossspeed;
    velocity = ( velocity[ 0 ], velocity[ 1 ], velocity[ 2 ] * getdvarfloat( @"hash_51dd064039040bdc", 0.85 ) );
    magicgrenademanual( "sat_smoke_grenade_wz_hp", self.origin + ( 0, 0, getdvarfloat( @"hash_f410b6520edd6080", 25 ) ), velocity, getdvarfloat( @"hash_ec8020f9a186eb30", 0.005 ) );
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0x19b22775, Offset: 0x3fc6
// Size: 0xd
function private function_d6d9d21e8090b438()
{
    self function_6d2086d31b79dc2b( 999999 );
}

// Namespace vehicle_upgrade_mp
// Params 0, eflags: 0x4
// Checksum 0x62ac5859, Offset: 0x3fdb
// Size: 0x9
function private function_5c60429eee32b798()
{
    self function_6d2086d31b79dc2b( 0 );
}

// Namespace vehicle_upgrade_mp
// Params 1
// Checksum 0x6bc10234, Offset: 0x3fec
// Size: 0x80
function function_8f9de6fc66c687bf( vehicle )
{
    if ( vehicle.currentlevel >= 3 )
    {
        return;
    }
    
    itemindex = function_b4a6ff1e58474720();
    
    if ( self && itemindex != -1 )
    {
        defaultlootid = loot::getlootidfromref( "wz_consumable_vehicle_upgrade_card" );
        
        if ( defaultlootid )
        {
            defaultbundle = common_item::function_b202b16941992cca( defaultlootid );
            vehicle vehicle_upgrade::function_9df9728803989c17();
            common_inventory_groups::function_d493153270fca171( 1, itemindex, defaultbundle, 1 );
        }
    }
}

// Namespace vehicle_upgrade_mp
// Params 0
// Checksum 0x7a0a1d21, Offset: 0x4074
// Size: 0x2
function function_a36119c5fa855af6()
{
    
}

// Namespace vehicle_upgrade_mp
// Params 0
// Checksum 0x79b5e95a, Offset: 0x407e
// Size: 0x61
function function_b4a6ff1e58474720()
{
    if ( !self )
    {
        return -1;
    }
    
    defaultlootid = loot::getlootidfromref( "wz_consumable_vehicle_upgrade_card" );
    
    if ( common_inventory_groups::inventorygroup_enabled() )
    {
        if ( defaultlootid )
        {
            defaultbundle = common_item::function_b202b16941992cca( defaultlootid );
            index = common_inventory_groups::function_e7c426ab761c55e4( 1, defaultbundle, defaultlootid );
            
            if ( isdefined( index ) )
            {
                return index;
            }
        }
    }
    
    return -1;
}

/#

    // Namespace vehicle_upgrade_mp
    // Params 0, eflags: 0x4
    // Checksum 0x82815ef4, Offset: 0x40e8
    // Size: 0x41, Type: dev
    function private function_1b31ab6d960e1972()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_3d95f58f40f2b829", 0 ) )
            {
                function_2d298e5cc01a9051();
                setdvar( @"hash_3d95f58f40f2b829", 0 );
            }
            
            waitframe();
        }
    }

    // Namespace vehicle_upgrade_mp
    // Params 0, eflags: 0x4
    // Checksum 0x1be762aa, Offset: 0x4131
    // Size: 0x272, Type: dev
    function private function_2d298e5cc01a9051()
    {
        vehicles = vehicle_getarray();
        iprintln( "<dev string:x3a>" );
        iprintln( "<dev string:x63>" + vehicles.size + "<dev string:x7e>" );
        iprintln( "<dev string:x3a>" );
        
        foreach ( vehicle in vehicles )
        {
            if ( !vehicle )
            {
                continue;
            }
            
            name = vehicle vehicle::get_ref() ?? "<dev string:x89>";
            entnum = vehicle getentitynumber();
            iprintln( "<dev string:x91>" );
            iprintln( "<dev string:xba>" + entnum + "<dev string:xc6>" + name + "<dev string:xc9>" );
            iprintln( "<dev string:x91>" );
            
            if ( !vehicle.upgradeinstalled || vehicle.upgradeinstalled.size == 0 )
            {
                iprintln( "<dev string:xcb>" );
                continue;
            }
            
            foreach ( upgradetype, var_6596983741e6d9e0 in vehicle.upgradeinstalled )
            {
                if ( !var_6596983741e6d9e0 )
                {
                    continue;
                }
                
                line = "<dev string:xe0>" + upgradetype;
                
                if ( upgradetype == "<dev string:xe9>" && vehicle.vehicle_upgrade_trophy_system == 1 )
                {
                    config = vehicle.var_b9c298004f109b81;
                    ammostring = "<dev string:xf7>";
                    
                    if ( config && config.max_ammo > 0 )
                    {
                        ammostring = vehicle.var_53457caf58b17961 + "<dev string:x100>" + config.max_ammo;
                    }
                    
                    disabled = vehicle.var_44ee127a56f17373;
                    line += "<dev string:x102>" + ammostring + "<dev string:x10e>" + disabled;
                }
                
                iprintln( line );
            }
        }
        
        iprintln( "<dev string:x3a>" );
    }

#/
