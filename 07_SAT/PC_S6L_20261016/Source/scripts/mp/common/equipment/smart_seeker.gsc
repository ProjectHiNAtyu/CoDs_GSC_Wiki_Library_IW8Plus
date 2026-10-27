// scripts\mp\common\equipment\smart_seeker.gsc  (hash_6367c716a6f4211a.gscc) (size: 24616 Bytes / 0x6028 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb3c50cda (3016035546)
// size ...... 24616 (0x6028)
// includes .. 24  (offset: 0x5c3c)
// strings ... 52  (offset: 0x5cfc)
// dev strs .. 0   (offset: 0x6028)
// exports ... 54  (offset: 0x3d94)
// cseg ...... 0x43b + 0x3959 (0x3d94)
// imports ... 182 (offset: 0x4604)
// animtree1 . 0   (offset: 0x6028)
// animtree2 . 0   (offset: 0x6028)
#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using scripts\common\active_env\utility;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\targetmarkergroups;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\trophy_system;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\rank;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\weapons;

#namespace smart_seeker;

// Namespace smart_seeker
// Params 0, eflags: 0x5
// Checksum 0xadbb815b, Offset: 0x459
// Size: 0x14
function private autoexec preinit()
{
    level callback::add( "init_grenade", &init );
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0x7109c4e8, Offset: 0x475
// Size: 0x103
function private init( params )
{
    if ( !equipment_mp::function_ae4237ff60a6e452( "equip_smart_seeker" ) )
    {
        return;
    }
    
    weapons::function_cda458ca9f121037( "smart_seeker" );
    weapons::function_2cd25260a11d5e40( "smart_seeker", &pulled_back );
    weapons::deregisterusedcallback( "smart_seeker" );
    weapons::registerusedcallback( "smart_seeker", &used );
    utility::registersharedfunc( #"smart_seeker", #"hack", &smart_seeker_hack );
    utility::registersharedfunc( #"smart_seeker", #"teleport_values", &teleport_values );
    utility::add_fx( "smart_seeker_dud_explosion", "vfx_sat_core_equip_smart_seeker_dud" );
    tableinfo = equipment_mp::getequipmenttableinfo( "equip_smart_seeker" );
    bundle = tableinfo.bundle;
    
    if ( isdefined( bundle ) )
    {
        equipment_mp::function_e08050aec5516278( "equip_smart_seeker", bundle.smart_seeker_projectile );
        equipment_mp::function_e08050aec5516278( "equip_smart_seeker", bundle.var_ce8088a39738aaf2 );
    }
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0xfc11bc90, Offset: 0x580
// Size: 0x109
function private pulled_back( params )
{
    ref = equipment_mp::function_fdc4a655fbde0dec( params.weaponobject.basename );
    tableinfo = weapon::getequipmenttableinfo( ref );
    bundle = tableinfo.bundle;
    
    if ( !( bundle.var_e36b84555e7df1d3 && params.weaponobject hasattachmenthash( bundle.var_e36b84555e7df1d3 ) ) )
    {
        return;
    }
    
    self endon( #"death", #"disconnect", #"smart_seeker_used", #"hash_602e9d468d45f50b" );
    var_2f2dd4bb7c3aec90 = bundle.var_77fb140004f5c3d3 ?? 1;
    wait var_2f2dd4bb7c3aec90;
    self.var_adecaeda0d274153 = targetmarkergroups::targetmarkergroup_on( %"overlaytargetmarkerenemy", self, [], self );
    self.var_e99de523bf045777 = undefined;
    thread function_73d738c79200b589();
    thread function_2f3fecf73a24a431();
    thread watch_cleanup_target_marker();
}

// Namespace smart_seeker
// Params 0, eflags: 0x4
// Checksum 0x90e2f06b, Offset: 0x691
// Size: 0x44
function private watch_cleanup_target_marker()
{
    utility::waittill_any( "grenade_fire", "offhand_end", "death", "disconnect" );
    
    if ( isdefined( self.var_adecaeda0d274153 ) )
    {
        targetmarkergroups::targetmarkergroup_off( self.var_adecaeda0d274153 );
        self.var_adecaeda0d274153 = undefined;
    }
}

// Namespace smart_seeker
// Params 0, eflags: 0x4
// Checksum 0x40acd9ad, Offset: 0x6dd
// Size: 0x90
function private function_73d738c79200b589()
{
    self endon( #"death_or_disconnect" );
    self endon( #"grenade_fire" );
    
    while ( true )
    {
        self waittill( #"smart_seeker_target_changed", var_9adc9a4de72ceac5, new_target );
        
        if ( isdefined( var_9adc9a4de72ceac5 ) && isdefined( self.var_adecaeda0d274153 ) )
        {
            targetmarkergroups::targetmarkergroup_unmarkentity( var_9adc9a4de72ceac5, self.var_adecaeda0d274153 );
        }
        
        if ( isdefined( new_target ) && isdefined( self.var_adecaeda0d274153 ) )
        {
            targetmarkergroups::targetmarkergroup_markentity( new_target, self.var_adecaeda0d274153 );
        }
        
        waitframe();
    }
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0xf7c286b2, Offset: 0x775
// Size: 0x23b
function private used( grenade )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( grenade ) )
    {
        return;
    }
    
    self notify( #"smart_seeker_used" );
    ref = equipment_mp::function_fdc4a655fbde0dec( grenade.weapon_name );
    grenade.tableinfo = weapon::getequipmenttableinfo( ref );
    bundle = grenade.tableinfo.bundle;
    grenade.owner = self;
    grenade.var_30656af96b2ac2a4 = [];
    grenade.add_buff = &add_buff;
    grenade.remove_buff = &remove_buff;
    
    if ( bundle.var_c7709714d768097c && grenade.weapon_object && grenade.weapon_object hasattachmenthash( bundle.var_c7709714d768097c ) )
    {
        grenade.var_7ee550b53f0a7079 = 2;
    }
    
    if ( !isdefined( self.smart_seekers ) )
    {
        self.smart_seekers = [];
    }
    
    if ( self.smart_seekers.size >= 2 )
    {
        self.smart_seekers[ 0 ] function_16e1c3f278107106( undefined );
    }
    
    if ( !grenade || !self )
    {
        return;
    }
    
    utility::callsharedfunc( #"jamming_system", #"hash_b99e77a93a09b9d5", grenade, &function_f2fdd019aa1d97a6, &function_655bd8caffa5d850 );
    
    if ( self.var_e99de523bf045777 && self.var_e99de523bf045777.superref != #"super_jammer" )
    {
        bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_smart_seeker" );
        targetoffset = function_60b52d62b5b116cc();
        grenade thread throw_locked_on( self.var_e99de523bf045777, bundle, targetoffset );
    }
    else if ( grenade.isjammed )
    {
        grenade thread throw_dud();
    }
    else
    {
        grenade thread throw_loitering( bundle );
    }
    
    if ( isdefined( self.var_e99de523bf045777 ) && isdefined( self.var_adecaeda0d274153 ) )
    {
        targetmarkergroups::targetmarkergroup_unmarkentity( self.var_e99de523bf045777, self.var_adecaeda0d274153 );
    }
    
    self.var_e99de523bf045777 = undefined;
}

// Namespace smart_seeker
// Params 0, eflags: 0xc
// Checksum 0xe44af59f, Offset: 0x9b8
// Size: 0x5e
function private function_6db172297f174188()
{
    self notify( #"hash_a6dd9cd646f62ec9" );
    self endon( #"hash_a6dd9cd646f62ec9" );
    self endon( #"death", #"seeker_hacked" );
    utility::waittill_any_ents( level, "game_ended", level, "round_end", self.owner, "disconnect", self, "touching_platform" );
    thread function_16e1c3f278107106( undefined );
}

// Namespace smart_seeker
// Params 2, eflags: 0x4
// Checksum 0x86a098f1, Offset: 0xa1e
// Size: 0x42, Type: bool
function private function_ccbf32628731535d( potential_target_key, potential_target_value )
{
    if ( !isdefined( potential_target_value.candidate ) || potential_target_value.candidate.destroyed )
    {
        return false;
    }
    
    return true;
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0xf9751fc, Offset: 0xa69
// Size: 0x1e1, Type: bool
function private function_eb91e92259126d37( target )
{
    if ( !target || !player_utility::playersareenemies( target, self ) )
    {
        return false;
    }
    
    distance_bonus = self.var_43b23ff1f20921af ? self.var_2013887cc06524c9 : 0;
    data = get_smart_seeker_data();
    var_62173a0431eae70d = abs( target.origin[ 2 ] - self.origin[ 2 ] ) > data.var_8b75eec1ab0bcba0;
    
    if ( var_62173a0431eae70d )
    {
        if ( abs( self.origin[ 2 ] - target.origin[ 2 ] ) > distance_bonus + data.var_420537fce3d874c3 )
        {
            return false;
        }
    }
    else if ( distancesquared( self.origin, target.origin ) > ( distance_bonus + data.var_e36f80fa0739a49d ) * ( distance_bonus + data.var_e36f80fa0739a49d ) )
    {
        return false;
    }
    
    if ( isplayer( self ) )
    {
        origin = self geteye();
        fov = self playergetzoomfov();
        
        if ( !self worldpointinreticle_circle( target.origin, fov, 150 ) )
        {
            return false;
        }
    }
    else
    {
        origin = self.origin;
    }
    
    if ( isscriptedai( target ) )
    {
        target_pos = target getcentroid();
    }
    else
    {
        target_pos = target.origin + function_60b52d62b5b116cc( target );
    }
    
    ignorearray = [ self, target ];
    
    if ( target.decoy )
    {
        ignorearray[ ignorearray.size ] = target.decoy;
    }
    
    trace = trace::ray_trace_passed( origin, target_pos, ignorearray, data.tracecontents );
    
    if ( !trace )
    {
        waitframe();
        return false;
    }
    
    return true;
}

// Namespace smart_seeker
// Params 0, eflags: 0x4
// Checksum 0x9bb7cd13, Offset: 0xc53
// Size: 0x526
function private function_74a5b8fe744da49e()
{
    foreach ( killstreak in level.playerkillstreaks )
    {
        if ( killstreak.vehiclename == "drone_formation_swarm" )
        {
            if ( function_eb91e92259126d37( killstreak ) )
            {
                var_8b8da69164d7e6b9 = killstreak;
                break;
            }
            
            continue;
        }
        
        if ( killstreak.streakname == "vtol_warship" )
        {
            if ( function_eb91e92259126d37( killstreak ) )
            {
                vtolwarship = killstreak;
                break;
            }
            
            continue;
        }
        
        if ( killstreak.streakname == "skybreak" )
        {
            if ( function_eb91e92259126d37( killstreak ) )
            {
                skybreak = killstreak;
                break;
            }
            
            continue;
        }
        
        if ( killstreak.streakname == "ground_drone_unit" )
        {
            if ( function_eb91e92259126d37( killstreak ) )
            {
                var_d3abd0f8786e27c7 = killstreak;
                break;
            }
            
            continue;
        }
        
        if ( killstreak.streakname == "radiation_blast" )
        {
            if ( function_eb91e92259126d37( killstreak ) )
            {
                radiationblast = killstreak;
                break;
            }
        }
    }
    
    if ( radiationblast )
    {
        return radiationblast;
    }
    else if ( var_8b8da69164d7e6b9 )
    {
        return var_8b8da69164d7e6b9;
    }
    else if ( vtolwarship )
    {
        return vtolwarship;
    }
    else if ( skybreak )
    {
        return skybreak;
    }
    
    foreach ( heli in level.helis )
    {
        if ( heli.streakname == "airdrop_escort" )
        {
            if ( function_eb91e92259126d37( heli ) )
            {
                escorthelo = heli;
            }
        }
    }
    
    if ( escorthelo )
    {
        return escorthelo;
    }
    
    foreach ( killstreak in level.remotekillstreaks )
    {
        if ( killstreak.usingremote == "remote_robot" )
        {
            if ( function_eb91e92259126d37( killstreak ) )
            {
                var_e61da7ff045c2808 = killstreak;
            }
            
            continue;
        }
        
        if ( killstreak.streakname == "rcxd" )
        {
            if ( function_eb91e92259126d37( killstreak ) )
            {
                rcxd = killstreak;
            }
            
            continue;
        }
        
        if ( killstreak.streakname == "sniper_drone" )
        {
            if ( function_eb91e92259126d37( killstreak ) )
            {
                sniperDrone = killstreak;
            }
        }
    }
    
    if ( var_e61da7ff045c2808 )
    {
        return var_e61da7ff045c2808;
    }
    
    foreach ( dawg in level.dawgs )
    {
        if ( function_eb91e92259126d37( dawg ) )
        {
            return dawg;
        }
    }
    
    if ( var_d3abd0f8786e27c7 )
    {
        return var_d3abd0f8786e27c7;
    }
    
    foreach ( turret in level.turrets )
    {
        if ( function_eb91e92259126d37( turret ) )
        {
            return turret;
        }
    }
    
    foreach ( enemy_team in team_utility::getenemyteams( self.team ) )
    {
        foreach ( uav in level.uavmodels[ enemy_team ] )
        {
            if ( function_eb91e92259126d37( uav ) )
            {
                return uav;
            }
        }
    }
    
    if ( rcxd )
    {
        return rcxd;
    }
    
    if ( sniperDrone )
    {
        return sniperDrone;
    }
}

// Namespace smart_seeker
// Params 0, eflags: 0x4
// Checksum 0xc9f55042, Offset: 0x1182
// Size: 0xf4
function private function_528262eb73036be0()
{
    mines = {};
    
    foreach ( mine in weapon::function_3aafcaf7ff6dea9e() )
    {
        if ( mine == self || !mine.bundle.var_37ba1c2c079afabd )
        {
            continue;
        }
        
        if ( mine.issuper )
        {
            if ( function_eb91e92259126d37( mine ) )
            {
                mines.super = mine;
                break;
            }
            
            continue;
        }
        
        if ( mine.isequipment )
        {
            if ( function_eb91e92259126d37( mine ) )
            {
                mines.equipment = mine;
            }
        }
    }
    
    return mines;
}

// Namespace smart_seeker
// Params 0, eflags: 0x4
// Checksum 0x7d819ceb, Offset: 0x127f
// Size: 0xe9
function private function_632a31e89fec4813()
{
    var_65f4b9373161df91 = entity::function_cd55d7a649cb9c44( self.origin, 8, undefined, self.owner );
    
    foreach ( enemy in var_65f4b9373161df91 )
    {
        if ( !isai( enemy ) || enemy.aicategory != "normal" )
        {
            continue;
        }
        
        if ( enemy.var_dea940150826c88d || enemy.team == self.team )
        {
            continue;
        }
        
        if ( enemy istouching( self ) )
        {
            return enemy;
        }
    }
}

// Namespace smart_seeker
// Params 0, eflags: 0x4
// Checksum 0xf4693ee0, Offset: 0x1370
// Size: 0x177
function private function_cb21b4523be25bec()
{
    selected_enemies = [];
    var_c7000bc50f762320 = [ "hvt", "elite", "special" ];
    
    foreach ( ai in getaiarray() )
    {
        if ( ai.var_dea940150826c88d )
        {
            continue;
        }
        
        if ( !ai.aicategory || !arraycontains( var_c7000bc50f762320, ai.aicategory ) )
        {
            continue;
        }
        
        if ( !selected_enemies[ ai.aicategory ] && function_eb91e92259126d37( ai ) )
        {
            selected_enemies[ ai.aicategory ] = ai;
        }
    }
    
    foreach ( category in var_c7000bc50f762320 )
    {
        if ( selected_enemies[ category ] )
        {
            return selected_enemies[ category ];
        }
    }
}

// Namespace smart_seeker
// Params 0, eflags: 0x4
// Checksum 0xb92899c2, Offset: 0x14ef
// Size: 0x2d2
function private function_c6892a066b37bc6f()
{
    enemykillstreaks = killstreak::function_5158f3269030d0fc( self.team );
    enemymines = weapon::function_84ab82bdba5dfb9d( self.team );
    enemyai = getaiarray();
    alltargets = [];
    alltargets = arraycombine( alltargets, enemykillstreaks );
    alltargets = arraycombine( alltargets, enemymines );
    alltargets = arraycombine( alltargets, enemyai );
    distance_bonus = self.var_43b23ff1f20921af ? self.var_2013887cc06524c9 : 0;
    bestdot = -1;
    besttarget = undefined;
    fov = self playergetzoomfov();
    data = get_smart_seeker_data();
    
    foreach ( target in alltargets )
    {
        if ( target.bundle.var_37ba1c2c079afabd || target.streakinfo.bundle.var_37ba1c2c079afabd || isai( target ) )
        {
            var_62173a0431eae70d = abs( target.origin[ 2 ] - self.origin[ 2 ] ) > data.var_8b75eec1ab0bcba0;
            
            if ( var_62173a0431eae70d )
            {
                var_4f3293d6bbea6450 = ( distance_bonus + data.var_420537fce3d874c3 ) * ( distance_bonus + data.var_420537fce3d874c3 );
            }
            else
            {
                var_4f3293d6bbea6450 = ( distance_bonus + data.var_e36f80fa0739a49d ) * ( distance_bonus + data.var_e36f80fa0739a49d );
            }
            
            distsquared = distancesquared( self.origin, target.origin );
            
            if ( distsquared > var_4f3293d6bbea6450 )
            {
                continue;
            }
            
            if ( !trace::ray_trace_passed( self geteye(), target.origin, [ self, target ], data.tracecontents ) )
            {
                continue;
            }
            
            if ( !self worldpointinreticle_circle( target.origin, fov, 150 ) )
            {
                continue;
            }
            
            playerangles = self getgunangles();
            playerforward = vectornormalize( anglestoforward( playerangles ) );
            playertotarget = vectornormalize( target.origin - self geteye() );
            newdot = vectordot( playerforward, playertotarget );
            
            if ( newdot > bestdot )
            {
                bestdot = newdot;
                besttarget = target;
            }
        }
        
        waitframe();
    }
    
    return besttarget;
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0x9fe00c9f, Offset: 0x17ca
// Size: 0x87
function private function_a566f4729cfd0e0a( var_3ae0a72f04cfb502 )
{
    killstreak = function_74a5b8fe744da49e();
    
    if ( killstreak )
    {
        return killstreak;
    }
    
    mines = function_528262eb73036be0();
    
    if ( mines.super )
    {
        return mines.super;
    }
    
    if ( mines.equipment )
    {
        return mines.equipment;
    }
    
    if ( var_3ae0a72f04cfb502 )
    {
        var_7654d704b9415bab = function_cb21b4523be25bec();
        
        if ( var_7654d704b9415bab )
        {
            return var_7654d704b9415bab;
        }
    }
}

// Namespace smart_seeker
// Params 0, eflags: 0x4
// Checksum 0x779e6f38, Offset: 0x185a
// Size: 0xfa
function private get_smart_seeker_data()
{
    if ( !level.var_6f76745668c9054 )
    {
        bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_smart_seeker" );
        var_e36f80fa0739a49d = bundle.var_893f52e4ed1a3963 ?? 5000;
        var_8b75eec1ab0bcba0 = bundle.var_8c05b6ce5dd9df46 ?? 1000;
        var_420537fce3d874c3 = bundle.var_21dc9b193e22d5 ?? 8000;
        character = 0;
        _world = 1;
        glass = 0;
        shotclip = 1;
        tracecontents = trace::create_contents( character, _world, glass, shotclip );
        level.var_6f76745668c9054 = { #tracecontents:tracecontents, #var_420537fce3d874c3:var_420537fce3d874c3, #var_8b75eec1ab0bcba0:var_8b75eec1ab0bcba0, #var_e36f80fa0739a49d:var_e36f80fa0739a49d };
    }
    
    return level.var_6f76745668c9054;
}

// Namespace smart_seeker
// Params 0, eflags: 0x4
// Checksum 0xf1121a51, Offset: 0x195d
// Size: 0xce
function private function_19e7fbf9b8dd989c()
{
    self endon( #"death" );
    bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_smart_seeker" );
    
    while ( true )
    {
        contacted_ai = function_632a31e89fec4813();
        
        if ( contacted_ai )
        {
            projectile_asset = bundle.smart_seeker_projectile;
            projectile_damage = bundle.smart_seeker_target_damage ?? 100;
            target_offset = ( 0, 0, self.origin[ 2 ] - contacted_ai.origin[ 2 ] );
            function_dddff59a21be57ef( contacted_ai, projectile_asset, projectile_damage, target_offset );
            return;
        }
        
        if ( !isdefined( self.var_e99de523bf045777 ) )
        {
            self.var_e99de523bf045777 = function_a566f4729cfd0e0a( bundle.var_c9ed0245d2570566 );
        }
        
        waitframe();
    }
}

// Namespace smart_seeker
// Params 0, eflags: 0x4
// Checksum 0xfdfa7820, Offset: 0x1a33
// Size: 0x67
function private function_2f3fecf73a24a431()
{
    self endon( #"death_or_disconnect" );
    self endon( #"grenade_fire" );
    
    while ( true )
    {
        newtarget = function_c6892a066b37bc6f();
        
        if ( !( newtarget === self.var_e99de523bf045777 ) )
        {
            self notify( #"smart_seeker_target_changed", self.var_e99de523bf045777, newtarget );
        }
        
        self.var_e99de523bf045777 = newtarget;
        waitframe();
    }
}

// Namespace smart_seeker
// Params 0, eflags: 0x4
// Checksum 0x8e17ab73, Offset: 0x1aa2
// Size: 0x3a, Type: bool
function private function_57f7b92e0f211fa3()
{
    if ( !self )
    {
        return false;
    }
    
    if ( !self.owner )
    {
        utility::callsharedfunc( #"jamming_system", #"hash_216d35a250cd860", self );
        self delete();
        return false;
    }
    
    return true;
}

// Namespace smart_seeker
// Params 3, eflags: 0x4
// Checksum 0x872c591d, Offset: 0x1ae5
// Size: 0xc5
function private throw_locked_on( var_fedb756c7bd56e3b, bundle, targetoffset )
{
    projectile_asset = bundle.smart_seeker_projectile;
    var_dba99861ab7a867 = bundle.var_ce8088a39738aaf2;
    var_1597e9e61ab05409 = get_smart_seeker_data().var_420537fce3d874c3;
    var_8466f11c251ee111 = bundle.smart_seeker_target_damage ?? 100;
    var_3dd46440a38dc970 = projectile_asset;
    
    if ( isdefined( var_dba99861ab7a867 ) && self.origin[ 2 ] * var_fedb756c7bd56e3b.origin[ 2 ] > var_1597e9e61ab05409 * var_1597e9e61ab05409 )
    {
        var_3dd46440a38dc970 = var_dba99861ab7a867;
    }
    
    function_dddff59a21be57ef( var_fedb756c7bd56e3b, var_3dd46440a38dc970, var_8466f11c251ee111, targetoffset );
}

// Namespace smart_seeker
// Params 4, eflags: 0x4
// Checksum 0xa6df1d61, Offset: 0x1bb2
// Size: 0x2aa
function private function_151c7421d39b435b( initial_location, forward, var_b7fb4f2153c73ee9, loitering_offset )
{
    computed_forward = forward;
    initial_right = vectorcross( forward, ( 0, 0, 1 ) );
    var_5993f238ab705a35 = initial_location + ( 0, 0, loitering_offset * 2 );
    var_34382a1b9d766e56 = initial_location - ( 0, 0, loitering_offset );
    var_24535b0a582d3e57 = initial_location + initial_right * loitering_offset;
    var_7a73dbd9bf08e3fe = initial_location - initial_right * loitering_offset;
    forward_trace_dest = initial_location + forward * loitering_offset;
    var_4afb5c66788e6fba = initial_location - forward * loitering_offset;
    upper_trace = trace::sphere_trace( initial_location, var_5993f238ab705a35, 10, var_b7fb4f2153c73ee9 );
    lower_trace = trace::sphere_trace( initial_location, var_34382a1b9d766e56, 10, var_b7fb4f2153c73ee9 );
    right_trace = trace::sphere_trace( initial_location, var_24535b0a582d3e57, 10, var_b7fb4f2153c73ee9 );
    left_trace = trace::sphere_trace( initial_location, var_7a73dbd9bf08e3fe, 10, var_b7fb4f2153c73ee9 );
    
    if ( upper_trace[ "hittype" ] == "hittype_world" )
    {
        var_5993f238ab705a35 = upper_trace[ "position" ];
    }
    
    if ( lower_trace[ "hittype" ] == "hittype_world" )
    {
        var_34382a1b9d766e56 = lower_trace[ "position" ];
    }
    
    if ( right_trace[ "hittype" ] == "hittype_world" )
    {
        var_24535b0a582d3e57 = right_trace[ "position" ];
    }
    
    if ( left_trace[ "hittype" ] == "hittype_world" )
    {
        var_7a73dbd9bf08e3fe = left_trace[ "position" ];
    }
    
    var_3d5633c0e865061 = ( var_5993f238ab705a35 + var_34382a1b9d766e56 ) * 0.5;
    var_e41c0dc0ed39b66b = ( var_24535b0a582d3e57 + var_7a73dbd9bf08e3fe ) * 0.5;
    forward_trace = trace::sphere_trace( ( var_e41c0dc0ed39b66b[ 0 ], var_e41c0dc0ed39b66b[ 1 ], var_3d5633c0e865061[ 2 ] ), forward_trace_dest, 10, var_b7fb4f2153c73ee9 );
    backward_trace = trace::sphere_trace( ( var_e41c0dc0ed39b66b[ 0 ], var_e41c0dc0ed39b66b[ 1 ], var_3d5633c0e865061[ 2 ] ), var_4afb5c66788e6fba, 10, var_b7fb4f2153c73ee9 );
    
    if ( forward_trace[ "hittype" ] == "hittype_world" )
    {
        forward_trace_dest = forward_trace[ "position" ];
        var_aca8b29b03ce9116 = vectordot( forward_trace[ "normal" ], forward );
        
        if ( var_aca8b29b03ce9116 < 0 )
        {
            computed_forward = vectornormalize( vectorlerp( forward, forward_trace[ "normal" ], var_aca8b29b03ce9116 * -0.5 ) );
        }
    }
    
    if ( backward_trace[ "hittype" ] == "hittype_world" )
    {
        var_4afb5c66788e6fba = backward_trace[ "position" ];
    }
    
    var_2c9e9f0a9a5fe8ce = ( forward_trace_dest + var_4afb5c66788e6fba ) * 0.5;
    var_e41c0dc0ed39b66b += var_2c9e9f0a9a5fe8ce - initial_location;
    return [ ( var_e41c0dc0ed39b66b[ 0 ], var_e41c0dc0ed39b66b[ 1 ], var_3d5633c0e865061[ 2 ] ), computed_forward ];
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0xc51f4255, Offset: 0x1e65
// Size: 0x436
function private throw_loitering( bundle )
{
    var_a54b4b58f70d5d90 = self.origin + anglestoforward( self.owner getgunangles() ) * 40;
    loitering_model = spawn( "script_model", var_a54b4b58f70d5d90 );
    loitering_model endon( #"smart_seeker_dud" );
    loitering_model endon( #"death" );
    loitering_model.var_82cef52e6b226cef = self.origin;
    loitering_model.var_7ee550b53f0a7079 = self.var_7ee550b53f0a7079;
    loitering_model setotherent( self.owner );
    loitering_model.var_30656af96b2ac2a4 = [];
    loitering_model.add_buff = &add_buff;
    loitering_model.remove_buff = &remove_buff;
    loitering_model.owner = self.owner;
    loitering_model.team = self.team;
    loitering_model.angles = self.angles;
    loitering_model.weapon_name = self.weapon_name;
    loitering_model setnonstick( 1 );
    imageoverride = loitering_model.var_30656af96b2ac2a4.size > 0 ? self.tableinfo.bundle.buffedheadicon : undefined;
    loitering_model.headiconid = entityheadicons::setheadicon_equipment( loitering_model, imageoverride );
    loitering_model.weaponobj = self.weapon_object;
    loitering_model makeentitynomeleetarget();
    scriptmodelsetweapon( loitering_model, loitering_model.weaponobj );
    utility::callsharedfunc( #"jamming_system", #"hash_216d35a250cd860", self );
    self delete();
    loitering_model.projectile_asset = bundle.smart_seeker_projectile;
    loitering_model.var_8466f11c251ee111 = bundle.smart_seeker_target_damage ?? 100;
    loitering_model.var_1597e9e61ab05409 = get_smart_seeker_data().var_420537fce3d874c3;
    loitering_model.var_dba99861ab7a867 = bundle.var_ce8088a39738aaf2;
    blueprintindex = self.weapon_object.variantid;
    
    if ( blueprintindex > 0 )
    {
        modelname = namespace_de7b719e85d98dcc::function_4854a08f7de8f427( namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, blueprintindex ), #"xmodel", "loiter_model" );
        loitering_model setmodel( modelname );
    }
    else
    {
        loitering_model setmodel( bundle.smart_seeker_loiter_model );
    }
    
    loitering_model setcandamage( 1 );
    loitering_model thread damage::monitordamage( bundle.smart_seeker_loiter_health ?? 30, "hitequip", &function_16e1c3f278107106, &loitering_on_damage );
    loitering_model.var_86aa957ae630982b = 1;
    utility::callsharedfunc( #"jamming_system", #"hash_ca0042e3cac99672", loitering_model, &function_f2fdd019aa1d97a6, &function_655bd8caffa5d850 );
    loitering_model sentientpoolmanager::registersentient( "Tactical_Static", loitering_model.owner );
    loitering_model thread function_65dcc22f6a64f410();
    loitering_model thread function_6db172297f174188();
    loitering_model setscriptablepartstate( #"loiter_effects", #"visible" );
    loitering_model function_7eacf48993cfffe9( bundle );
    var_74b8918d075c659e = bundle.var_8b1182c0e7e6b0c7 ?? 0.2;
    wait var_74b8918d075c659e;
    loitering_model setscriptablepartstate( #"animations", #"hover" );
    loitering_model thread function_2b2cddb04f18e269( bundle.var_ecf8f727380702fb ?? 10 );
    loitering_model thread function_19e7fbf9b8dd989c();
    loitering_model smart_seeker_trophy_system();
    loitering_model.owner.smart_seekers[ loitering_model.owner.smart_seekers.size ] = loitering_model;
    loitering_model.owner callback::add( "onPlayerSpawn_destroyEquipment", &loitering_on_respawn, loitering_model );
    loitering_model namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( loitering_model, &smart_seeker_empapplied );
    loitering_model.owner weapons::onequipmentplanted( loitering_model, "equip_smart_seeker", &function_16e1c3f278107106 );
    utility::function_969f9f5596dba07a( loitering_model, &function_16e1c3f278107106 );
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0x8412f6b9, Offset: 0x22a3
// Size: 0x105
function private throw_dud( traceinfo )
{
    self notify( #"smart_seeker_dud" );
    self setscriptablepartstate( #"destruction", #"dud" );
    
    if ( !traceinfo )
    {
        playfx( level._effect[ "smart_seeker_dud_explosion" ], self.origin );
    }
    else
    {
        upvec = traceinfo[ "normal" ];
        
        if ( abs( upvec[ 2 ] ) < 0.9 )
        {
            refvec = ( 0, 0, 1 );
        }
        else
        {
            refvec = ( 1, 0, 0 );
        }
        
        forwardvec = vectorcross( refvec, upvec );
        playfx( level._effect[ "smart_seeker_dud_explosion" ], traceinfo[ "position" ], forwardvec, upvec );
    }
    
    self radiusdamagestepped( self.origin, 5, 15, 15, 10, 25, 5, self, "MOD_PROJECTILE", undefined, 0, 1, 0, 0 );
    waitframe();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace smart_seeker
// Params 0, eflags: 0x4
// Checksum 0xfaee4801, Offset: 0x23b0
// Size: 0x23
function private function_274eccd5f20234a3()
{
    if ( level.var_a3139b1cc47b12c6 == gettime() )
    {
        return level.smart_seeker_partition;
    }
    
    return function_77d3f37c5e8631d();
}

// Namespace smart_seeker
// Params 0, eflags: 0x4
// Checksum 0xf168374b, Offset: 0x23dc
// Size: 0x47
function private function_77d3f37c5e8631d()
{
    var_c4c5220f222277d2 = function_be0dd53539a68b65( level.grenades );
    level.smart_seeker_partition = utility::create_partition( var_c4c5220f222277d2, 500, 1 );
    level.var_a3139b1cc47b12c6 = gettime();
    return level.smart_seeker_partition;
}

// Namespace smart_seeker
// Params 4, eflags: 0x4
// Checksum 0x35db91, Offset: 0x242c
// Size: 0xde
function private function_dddff59a21be57ef( target, projectile_asset, var_8466f11c251ee111, targetoffset )
{
    target_pos = target.origin + targetoffset;
    var_4afaff7eba049a9b = vectornormalize( target_pos - self.origin );
    missile = magicbullet( projectile_asset, self.origin, self.origin + vectornormalize( var_4afaff7eba049a9b ), self.owner );
    missile.var_7ee550b53f0a7079 = self.var_7ee550b53f0a7079;
    missile missile_settargetent( target, targetoffset );
    missile missile_setflightmodedirect();
    thread function_fc11928444f4b05d( target, self.owner, self.weaponobj );
    missile thread function_1a06a59b7da40cce( target, var_8466f11c251ee111 );
    self delete();
}

// Namespace smart_seeker
// Params 3, eflags: 0x4
// Checksum 0x4c4f4e89, Offset: 0x2512
// Size: 0x9b
function private function_fc11928444f4b05d( target, owner, weaponobj )
{
    if ( !( isdefined( target ) && isdefined( owner ) && isdefined( weaponobj ) ) )
    {
        return;
    }
    
    result = target utility::waittill_any_timeout( 2, "death" );
    
    if ( result == "timeout" )
    {
        return;
    }
    
    if ( owner )
    {
        owner thread gamelogic_mp::threadedsetweaponstatbyname( weaponobj, 1, "equipment_destructions" );
    }
    
    if ( target.owner )
    {
        target.owner thread gamelogic_mp::threadedsetweaponstatbyname( weaponobj, 1, "equipment_destroyed_by" );
    }
}

// Namespace smart_seeker
// Params 2, eflags: 0x4
// Checksum 0x9ee51e0b, Offset: 0x25b5
// Size: 0x199
function private function_1a06a59b7da40cce( target, var_8466f11c251ee111 )
{
    self setscriptablepartstate( #"locked_on", #"locked_on" );
    self waittill( #"explode", position );
    playsoundatpos( position, "eqp_sat_smart_seeker_drone_exp" );
    
    if ( !isdefined( target ) )
    {
        return;
    }
    
    if ( isscriptedai( target ) )
    {
        var_8a6c617436cf9c7 = target getboundshalfsize();
        acceptable_dist = var_8a6c617436cf9c7[ 0 ] + 10;
        var_ceaaf3a3fa856a07 = distance2dsquared( position, target.origin );
        
        if ( var_ceaaf3a3fa856a07 <= acceptable_dist * acceptable_dist )
        {
            target_centroid = target getcentroid();
            vertical_offset = abs( target_centroid[ 2 ] - position[ 2 ] );
            
            if ( vertical_offset < var_8a6c617436cf9c7[ 2 ] + 10 )
            {
                target dodamage( var_8466f11c251ee111, position, self.owner, self, "MOD_EXPLOSIVE" );
            }
        }
        
        return;
    }
    
    character = 1;
    _world = 1;
    glass = 0;
    shotclip = 1;
    item = 1;
    vehicle = 1;
    contents = trace::create_contents( character, _world, glass, shotclip, item, vehicle );
    hit = physics_spherecastents( position, position, 10, contents, [ target ], "physicsquery_any", undefined, 1 );
    
    if ( hit )
    {
        target dodamage( var_8466f11c251ee111, position, self.owner, self, "MOD_EXPLOSIVE" );
    }
}

// Namespace smart_seeker
// Params 2, eflags: 0x4
// Checksum 0x55dd28ba, Offset: 0x2756
// Size: 0x67
function private get_look_at_angles( origin, target )
{
    forward = vectornormalize( target - origin );
    right = vectornormalize( vectorcross( forward, ( 0, 0, 1 ) ) );
    up = vectornormalize( vectorcross( right, forward ) );
    return axistoangles( forward, right, up );
}

// Namespace smart_seeker
// Params 1, eflags: 0xc
// Checksum 0xdd409814, Offset: 0x27c6
// Size: 0x2c2
function private function_7eacf48993cfffe9( bundle )
{
    self notify( #"hash_113fa48fe83dc722" );
    self endon( #"hash_113fa48fe83dc722" );
    self endon( #"death" );
    self.owner endon( #"death_or_disconnect" );
    self endon( #"seeker_hacked" );
    self endon( #"hash_88deafbf231222e5" );
    end_distance = bundle.var_418a90bbdad3b9d5 ?? 180;
    time_to_move = bundle.var_31cab209237ef4e5 ?? 0.351;
    var_db9e33a8831c62c4 = time_to_move * 0.7;
    destination = self.origin + anglestoforward( self.owner getgunangles() ) * end_distance + self.owner getvelocity() * var_db9e33a8831c62c4;
    accel_time = bundle.var_91c9251b3309ab6c ?? 0.0781;
    decel_time = bundle.var_e9f7487cf36e445f ?? 0.21;
    contents = physics_createcontents( [ "physicscontents_characterproxy", "physicscontents_clipshot", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item", "physicscontents_glass", "physicscontents_trigger" ] );
    thread utility::translate_to( destination, time_to_move, accel_time, decel_time );
    var_6f028c8b82108f32 = time_to_move * 0.5;
    var_ce52e54947cca3bb = time_to_move - var_6f028c8b82108f32;
    childthread reset_pitch( var_6f028c8b82108f32, var_ce52e54947cca3bb );
    endtimems = gettime() + time_to_move * 1000;
    traceref = {};
    
    if ( function_6c6c14686cccb3d0( contents, traceref, self.var_82cef52e6b226cef, self.origin ) )
    {
        thread throw_dud( traceref.traceinfo );
    }
    
    while ( gettime() < endtimems )
    {
        waitframe();
        
        if ( self.var_a3dd6a7de0efa18f )
        {
            self.var_a3dd6a7de0efa18f = 0;
            self notify( #"translate_stop" );
            waitframe();
            destination_delta = destination - self.origin;
            destination_delta = utility::function_6b6c127afa12d17( ( 0, 0, 0 ), destination_delta, self.var_27a3cee5a1f6137 );
            destination = self.var_8b64287f361f306c + destination_delta;
            self.origin = self.var_8b64287f361f306c;
            time_to_move = ( endtimems - gettime() ) * 0.001;
            thread utility::translate_to( destination, time_to_move, 0, decel_time );
        }
        
        if ( function_6c6c14686cccb3d0( contents, traceref, self.origin, self.origin ) )
        {
            thread throw_dud( traceref.traceinfo );
        }
    }
}

// Namespace smart_seeker
// Params 4, eflags: 0x4
// Checksum 0x4d27aaf, Offset: 0x2a90
// Size: 0x14c, Type: bool
function private function_6c6c14686cccb3d0( contents, traceref, starttrace, endtrace )
{
    var_ab3e1c6b6c053625 = trace::sphere_trace_get_all_results( starttrace, endtrace, 10, [ self, self.owner ], contents );
    has_debug = isdefined( var_ab3e1c6b6c053625[ #"debugdata" ] ) + isdefined( var_ab3e1c6b6c053625[ var_ab3e1c6b6c053625.size - 1 ][ "type" ] );
    
    for ( i = 0; i < var_ab3e1c6b6c053625.size - has_debug ; i++ )
    {
        traceinfo = var_ab3e1c6b6c053625[ i ];
        
        switch ( traceinfo[ "hittype" ] )
        {
            case #"hash_d84d255da86c9bed":
                traceref.traceinfo = traceinfo;
                return true;
            case #"hash_c9ca635313f9bc38":
                traced_entity = traceinfo[ "entity" ];
                
                if ( !issubstr( traced_entity.code_classname, "trigger" ) )
                {
                    traceref.traceinfo = traceinfo;
                    return true;
                }
                
                if ( traced_entity.script_noteworthy === "portal_grenade_catcher" )
                {
                    traced_entity notify( #"portal", self );
                    return false;
                }
                
                break;
            default:
                break;
        }
    }
    
    return false;
}

// Namespace smart_seeker
// Params 2, eflags: 0xc
// Checksum 0x2f6c2e5f, Offset: 0x2be5
// Size: 0xfa
function private reset_pitch( resettime, delay )
{
    self notify( #"hash_fa3b806827bb4772" );
    self endon( #"hash_fa3b806827bb4772" );
    wait delay;
    var_2ae05ee64f07451c = self.angles[ 0 ];
    endpitch = var_2ae05ee64f07451c > 180 ? 360 : 0;
    timepassed = 0;
    
    while ( true )
    {
        timepassed += level.framedurationseconds;
        lerpfraction = timepassed / resettime;
        
        if ( lerpfraction < 1 )
        {
            modifiedpitch = math::lerp( var_2ae05ee64f07451c, endpitch, lerpfraction );
            self.angles = ( modifiedpitch, self.angles[ 1 ], self.angles[ 2 ] );
        }
        else
        {
            self.angles = ( 0, self.angles[ 1 ], self.angles[ 2 ] );
            return;
        }
        
        waitframe();
    }
}

// Namespace smart_seeker
// Params 2
// Checksum 0x5cabce2f, Offset: 0x2ce7
// Size: 0x36
function teleport_values( var_8b64287f361f306c, var_27a3cee5a1f6137 )
{
    self.var_a3dd6a7de0efa18f = 1;
    self.var_8b64287f361f306c = var_8b64287f361f306c;
    self.var_27a3cee5a1f6137 = var_27a3cee5a1f6137;
}

// Namespace smart_seeker
// Params 1, eflags: 0xc
// Checksum 0x5e787a58, Offset: 0x2d25
// Size: 0x66
function private function_2b2cddb04f18e269( var_f14b50f7e9ed84f0 )
{
    self notify( #"hash_73105b7fd2b46de3" );
    self endon( #"hash_73105b7fd2b46de3" );
    self endon( #"death" );
    self.owner endon( #"death_or_disconnect" );
    self endon( #"hash_88deafbf231222e5" );
    
    while ( true )
    {
        self rotateyaw( 360, var_f14b50f7e9ed84f0 );
        wait var_f14b50f7e9ed84f0;
    }
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0xd5f274, Offset: 0x2d93
// Size: 0x2d6
function private function_60b52d62b5b116cc( targetoverride )
{
    bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_smart_seeker" );
    target = targetoverride ?? self.var_e99de523bf045777;
    targetoffset = ( 0, 0, 0 );
    
    foreach ( offsetdata in bundle.var_a4ba273564ead162 )
    {
        if ( offsetdata.grenadeweapon == target.weapon_object.basenamehash )
        {
            targetoffset += ( 0, 0, 1 ) * anglestoup( target.angles ) * ( offsetdata.upoffset ?? 0 );
            break;
        }
    }
    
    foreach ( offsetdata in bundle.var_601de361992001be )
    {
        if ( offsetdata.weaponname == target.streakinfo.weaponname )
        {
            targetoffset += ( 0, 0, 1 ) * anglestoup( target.angles ) * ( offsetdata.upoffset ?? 0 );
            break;
        }
    }
    
    if ( targetoffset == ( 0, 0, 0 ) && isscriptedai( target ) )
    {
        foreach ( offsetdata in bundle.var_4c4800609974e552 )
        {
            if ( isstartstr( target.subclass, offsetdata.subclass ) )
            {
                targetoffset += ( 0, 0, 1 ) * anglestoup( target.angles ) * ( offsetdata.upoffset ?? 0 );
                break;
            }
        }
        
        if ( targetoffset == ( 0, 0, 0 ) )
        {
            targetoffset = ( 0, 0, target getboundshalfsize()[ 2 ] );
        }
    }
    
    return targetoffset;
}

// Namespace smart_seeker
// Params 0, eflags: 0xc
// Checksum 0xb10839c, Offset: 0x3072
// Size: 0x224
function private function_65dcc22f6a64f410()
{
    self notify( #"hash_1abc755ce758ab44" );
    self endon( #"hash_1abc755ce758ab44" );
    self endon( #"death" );
    self.owner endon( #"death_or_disconnect" );
    self endon( #"seeker_hacked" );
    
    while ( true )
    {
        if ( !self.isjammed && self.var_e99de523bf045777 && !self.var_e99de523bf045777.isdestroyed )
        {
            self notify( #"hash_88deafbf231222e5" );
            bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_smart_seeker" );
            targetoffset = function_60b52d62b5b116cc();
            var_c00222e77932e298 = get_look_at_angles( self.origin, self.var_e99de523bf045777.origin + targetoffset );
            var_26bbef08a6cd6ea1 = bundle.var_b8c5916339260730 ?? 0.332;
            self rotateto( var_c00222e77932e298, var_26bbef08a6cd6ea1, bundle.var_b9c194263bb16279 ?? 0, bundle.var_89ee30bd4f75edb2 ?? 0 );
            entityheadicons::setheadicon_deleteicon( self.headiconid );
            self.headiconid = undefined;
            self.owner.smart_seekers = utility::function_d751969553a4bddd( self.owner.smart_seekers, self );
            self setscriptablepartstate( #"animations", #"wings_close" );
            self setscriptablepartstate( #"loiter_effects", #"hidden" );
            wait var_26bbef08a6cd6ea1;
            
            if ( !self.isjammed && self.var_e99de523bf045777 )
            {
                thread throw_locked_on( self.var_e99de523bf045777, bundle, targetoffset );
                return;
            }
            else
            {
                self.var_e99de523bf045777 = undefined;
                self setscriptablepartstate( #"animations", #"hover" );
                self setscriptablepartstate( #"loiter_effects", #"visible" );
                thread function_2b2cddb04f18e269( bundle.var_ecf8f727380702fb ?? 10 );
            }
        }
        
        waitframe();
    }
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0xbde6d279, Offset: 0x329e
// Size: 0x17
function private loitering_on_damage( damage_data )
{
    return damage_data.damage;
}

// Namespace smart_seeker
// Params 2, eflags: 0x4
// Checksum 0xe6e98327, Offset: 0x32be
// Size: 0x32
function private loitering_on_respawn( var_2989ee6003bd55ec, loitering_smart_seeker )
{
    callback::remove( "onPlayerSpawn_destroyEquipment", &loitering_on_respawn, loitering_smart_seeker );
    loitering_smart_seeker function_16e1c3f278107106( undefined );
}

// Namespace smart_seeker
// Params 1
// Checksum 0x55eda23b, Offset: 0x32f8
// Size: 0x168
function function_16e1c3f278107106( damage_data )
{
    if ( self.isdying )
    {
        return;
    }
    
    utility::callsharedfunc( #"jamming_system", #"hash_216d35a250cd860", self );
    
    if ( isdefined( damage_data ) && isdefined( damage_data.attacker ) )
    {
        attackingplayer = function_e74fc496c6756ae7( damage_data.attacker, self );
        
        if ( isdefined( attackingplayer ) && player_utility::playersareenemies( self.owner, attackingplayer ) )
        {
            attackingplayer thread points::doscoreevent( #"hash_e789a973b4965424", damage_data.objweapon );
        }
    }
    
    if ( self.owner.smart_seekers.size && isdefined( self.owner ) )
    {
        self.owner.smart_seekers = utility::function_d751969553a4bddd( self.owner.smart_seekers, self );
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self setscriptablepartstate( #"loiter_effects", #"hidden", 1 );
    self setscriptablepartstate( #"destruction", #"exploding", 1 );
    entityheadicons::setheadicon_deleteicon( self.headiconid );
    self.headiconid = undefined;
    self notify( #"death" );
    self.isdying = 1;
    waitframe();
    
    if ( self )
    {
        self delete();
    }
}

// Namespace smart_seeker
// Params 2, eflags: 0x4
// Checksum 0xa2df75ef, Offset: 0x3468
// Size: 0x81
function private function_e74fc496c6756ae7( attacker, instance )
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
    
    if ( !( isdefined( attackingplayer ) && isdefined( instance.owner ) ) )
    {
        return;
    }
    
    if ( weapons::friendlyfirecheck( instance.owner, attackingplayer ) )
    {
        return attackingplayer;
    }
}

// Namespace smart_seeker
// Params 2, eflags: 0x4
// Checksum 0x6f5eccf1, Offset: 0x34f2
// Size: 0x15a
function private smart_seeker_hack( hackeffect, attacker )
{
    loitering_model = self;
    
    if ( hackeffect.var_30e7de3d76d5a085 )
    {
        loitering_model.owner thread equipment_utility::function_364a1a0e0c018518( loitering_model.equipmentref, #"stolen_hacked" );
        loitering_model notify( #"seeker_hacked" );
        loitering_model.owner.smart_seekers = utility::function_d751969553a4bddd( loitering_model.owner.smart_seekers, loitering_model );
        loitering_model.owner callback::remove( "onPlayerSpawn_destroyEquipment", &loitering_on_respawn, loitering_model );
        loitering_model setscriptablepartstate( #"hacked", #"stolen", 0 );
        loitering_model equipment_mp::hackequipment( attacker, hackeffect.var_fe6111ff085b2063 );
        loitering_model setscriptablepartstate( #"loiter_lights", #"update_for_new_owner", 0 );
        
        if ( !isdefined( attacker.smart_seekers ) )
        {
            attacker.smart_seekers = [];
        }
        
        attacker.smart_seekers[ attacker.smart_seekers.size ] = loitering_model;
        attacker callback::add( "onPlayerSpawn_destroyEquipment", &loitering_on_respawn, loitering_model );
        loitering_model thread function_65dcc22f6a64f410();
        loitering_model thread function_6db172297f174188();
    }
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0xec4f668, Offset: 0x3654
// Size: 0x2f
function private smart_seeker_empapplied( empstruct )
{
    self dodamage( self.maxhealth, self.origin, empstruct.attacker );
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0x6f804541, Offset: 0x368b
// Size: 0x204
function private add_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        self.var_30656af96b2ac2a4[ self.var_30656af96b2ac2a4.size ] = params.combatlink;
        
        if ( !self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] )
        {
            basepoints = rank::getscoreinfovalue( #"hash_1e0024b349f80d1c" ) ?? 0;
            params.combatlink.owner thread points::doscoreevent( #"hash_1e0024b349f80d1c", params.combatlink.weapon_object, basepoints * params.combatlink.var_352099d9d2836866 );
            
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
            bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_smart_seeker" );
            
            if ( isdefined( self.headiconid ) && isdefined( bundle.buffedheadicon ) )
            {
                setheadiconimage( self.headiconid, bundle.buffedheadicon, 1 );
            }
            
            self.var_43b23ff1f20921af = 1;
            self.var_2013887cc06524c9 = params.bundle.var_92bbde266b6943a9 ?? 300;
        }
    }
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0x35ec0861, Offset: 0x3897
// Size: 0xc2
function private remove_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        if ( arraycontains( self.var_30656af96b2ac2a4, params.combatlink ) )
        {
            self.var_30656af96b2ac2a4 = arrayremove( self.var_30656af96b2ac2a4, params.combatlink );
            
            if ( self.var_30656af96b2ac2a4.size <= 0 )
            {
                if ( isdefined( self.headiconid ) && isdefined( level.gamemodebundle.var_b96d2dfbabc4742d ) )
                {
                    setheadiconimage( self.headiconid, level.gamemodebundle.var_b96d2dfbabc4742d, 1 );
                }
                
                self.var_43b23ff1f20921af = undefined;
                self.var_2013887cc06524c9 = undefined;
            }
        }
    }
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0x2b0e9d, Offset: 0x3961
// Size: 0x34
function private function_f2fdd019aa1d97a6( jammedseeker )
{
    jammedseeker setscriptablepartstate( #"jammed", #"on", 0 );
    jammedseeker.isjammed = 1;
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0x70ec41ec, Offset: 0x399d
// Size: 0x31
function private function_655bd8caffa5d850( jammedseeker )
{
    jammedseeker setscriptablepartstate( #"jammed", #"off", 0 );
    jammedseeker.isjammed = undefined;
}

// Namespace smart_seeker
// Params 1
// Checksum 0xb5d25fa2, Offset: 0x39d6
// Size: 0x3e
function function_d9c6bb8e07645f91( trophytarget )
{
    if ( trophytarget.equipmentref == "equip_smart_seeker" )
    {
        return 1;
    }
    
    if ( trophytarget.bundle.var_f69a3e88b8ed87f )
    {
        return 1;
    }
}

// Namespace smart_seeker
// Params 0, eflags: 0x4
// Checksum 0x148e67fd, Offset: 0x3a1c
// Size: 0x136
function private smart_seeker_trophy_system()
{
    self.trophycharges = 1;
    self.var_a09a369201eaecdc = spawn( "script_model", self.origin );
    self.var_a09a369201eaecdc.killcament = self;
    self.var_a09a369201eaecdc.owner = self.owner;
    self.var_a09a369201eaecdc.team = self.team;
    self.var_a09a369201eaecdc setotherent( self.owner );
    self.var_a09a369201eaecdc setentityowner( self.owner );
    bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_smart_seeker" );
    self.var_a09a369201eaecdc setmodel( bundle.smart_seeker_trophy_explosion );
    thread utility::delete_on_death( self.var_a09a369201eaecdc, 1 );
    checkignorelistfuncs = [ &function_d9c6bb8e07645f91, &trophy_system::trophy_checkignorelist ];
    thread trophy_system::trophy_watchprotection( bundle.var_f92b73d9dfcd0b86 ?? 0, bundle.var_81972a3b6f30ae3d ?? 120, &function_62d7dc968a149042, &function_9f1320feb6efb058, checkignorelistfuncs );
}

// Namespace smart_seeker
// Params 0, eflags: 0x4
// Checksum 0xc1111888, Offset: 0x3b5a
// Size: 0xd, Type: bool
function private function_62d7dc968a149042()
{
    return self.trophycharges > 0;
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0xcbb156c2, Offset: 0x3b70
// Size: 0x35
function private function_9f1320feb6efb058( trophytarget )
{
    function_d6d321111ebbbfdf( trophytarget );
    self.trophycharges--;
    
    if ( self.trophycharges <= 0 )
    {
        thread function_16e1c3f278107106( undefined );
    }
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0xa4b714d, Offset: 0x3bad
// Size: 0x66
function private function_b8be01cfffd2b0dc( trophytarget )
{
    if ( !isplayer( trophytarget.owner ) )
    {
        return;
    }
    
    if ( damagefeedback::isusingstackablehitmarker() )
    {
        trophytarget.owner damagefeedback::updatedamagefeedback( "hitsmartseekertrophysystem", undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 2 );
        return;
    }
    
    trophytarget.owner damagefeedback::updatedamagefeedback( "hitsmartseekertrophysystem" );
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0x7662c1ab, Offset: 0x3c1b
// Size: 0xbf
function private function_d6d321111ebbbfdf( trophytarget )
{
    trophytarget setcandamage( 0 );
    trophytarget stopsounds( 0 );
    function_9d896fcffb545eac( trophytarget );
    
    if ( self.owner )
    {
        self.owner thread gamelogic_mp::threadedsetweaponstatbyname( self.weaponobj, 1, "equipment_destructions" );
        self.owner thread points::doscoreevent( #"smart_seeker_trophy_defense", self.weaponobj );
    }
    
    function_b8be01cfffd2b0dc( trophytarget );
    
    if ( trophytarget.owner )
    {
        trophytarget.owner thread gamelogic_mp::threadedsetweaponstatbyname( self.weaponobj, 1, "equipment_destroyed_by" );
    }
    
    if ( !trophytarget equipment_mp::ondestroyedbytrophy() )
    {
        trophytarget delete();
    }
}

// Namespace smart_seeker
// Params 1, eflags: 0x4
// Checksum 0x32c87b44, Offset: 0x3ce2
// Size: 0xb2
function private function_9d896fcffb545eac( trophytarget )
{
    self.var_a09a369201eaecdc dontinterpolate();
    self.var_a09a369201eaecdc.origin = vectorlerp( trophytarget.origin, self.origin, 0.2 );
    self.var_a09a369201eaecdc.angles = combineangles( vectortoangles( self.origin - self.var_a09a369201eaecdc.origin ), ( -90, 0, 0 ) );
    self.var_a09a369201eaecdc setscriptablepartstate( #"explosion", #"explode", 0 );
}

