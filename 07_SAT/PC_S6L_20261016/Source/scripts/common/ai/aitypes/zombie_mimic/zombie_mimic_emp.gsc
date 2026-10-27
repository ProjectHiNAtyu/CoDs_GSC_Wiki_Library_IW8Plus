// scripts\common\ai\aitypes\zombie_mimic\zombie_mimic_emp.gsc  (hash_7662020315d2fc27.gscc) (size: 9330 Bytes / 0x2472 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x74dbfe5b (1960574555)
// size ...... 9330 (0x2472)
// includes .. 7   (offset: 0x2252)
// strings ... 33  (offset: 0x228a)
// dev strs .. 0   (offset: 0x2472)
// exports ... 23  (offset: 0x177e)
// cseg ...... 0x29d + 0x14e1 (0x177e)
// imports ... 60  (offset: 0x1b16)
// animtree1 . 0   (offset: 0x2472)
// animtree2 . 0   (offset: 0x2472)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\ai\aitypes\zombie_mimic\zombie_mimic_prop_spawn;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace zombie_mimic_emp;

// Namespace zombie_mimic_emp
// Params 2
// Checksum 0xcb5949ff, Offset: 0x2bb
// Size: 0x112
function precache( classname, aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "emp_mimic_blast_fx", settings.var_90f737911a572452 );
        utility::add_fx( "emp_mimic_destroy_grenade_fx", settings.var_403e79bd6df54446 );
        utility::add_fx( "emp_mimic_small_prop_fx", settings.var_c78245510a2611cc );
        utility::add_fx( "emp_mimic_med_prop_fx", settings.var_5fc5cd598eb138c7 );
        utility::add_fx( "emp_mimic_large_prop_fx", settings.var_f27aa939f66a7ef8 );
    }
    
    if ( !callback::exists( "on_" + aitypescriptbundle.subclass + "_spawned", &function_b90f09f8076a05ea ) )
    {
        level callback::add( "on_" + aitypescriptbundle.subclass + "_spawned", &function_b90f09f8076a05ea );
    }
    
    if ( !callback::exists( "on_mimic_player_grab_end", &function_786315ded8b909aa ) )
    {
        level callback::add( "on_mimic_player_grab_end", &function_786315ded8b909aa );
    }
}

// Namespace zombie_mimic_emp
// Params 1
// Checksum 0x62b20a89, Offset: 0x3d5
// Size: 0x3d
function function_786315ded8b909aa( params )
{
    mimic = params.attacker;
    
    if ( !isdefined( mimic.emptrigger ) )
    {
        return;
    }
    
    mimic electricdischarge_blast();
}

// Namespace zombie_mimic_emp
// Params 1
// Checksum 0xcecfe5a0, Offset: 0x41a
// Size: 0xe2
function function_b90f09f8076a05ea( params )
{
    self.overload_radius = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.overloadradius;
    self.overload_cooldown = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.overloadcooldown;
    thread function_f45939a5aad862af();
    thread function_e4ddfd8e9b7876ae();
    self.grab_screen_fx = undefined;
    self.spawn_prop_count = 1;
    self.var_b17113b985277e83 = 1;
    self.reveal_condition_func = &function_ae8c2d365bb5590f;
    callback::add( "on_entity_revealed", &function_56ff1a815c174b3d );
    callback::add( "on_entity_hidden_in_prop", &function_edfd455ff1b674e5 );
    callback::add( "on_zombie_ai_damaged", &function_2acce069c7661bfa );
    callback::add( "on_brainrot_end", &function_3013b319adad425 );
    self.var_4fde6a8624b2abf0 = 0;
}

// Namespace zombie_mimic_emp
// Params 1, eflags: 0x4
// Checksum 0x1bb0ca4e, Offset: 0x504
// Size: 0x35
function private function_56ff1a815c174b3d( params )
{
    waitframe();
    
    if ( isdefined( self.var_b1f3dccf5a1b9bb7 ) )
    {
        level thread zombie_mimic_prop_spawn::function_c727c09ec08aed83( self.var_b1f3dccf5a1b9bb7 );
        self.var_b1f3dccf5a1b9bb7 = undefined;
    }
}

// Namespace zombie_mimic_emp
// Params 1, eflags: 0x4
// Checksum 0x1728a63a, Offset: 0x541
// Size: 0xd2
function private function_edfd455ff1b674e5( params )
{
    utility::function_7c10ea82c1e305b8( "ambient_emp_vfx", "off" );
    
    if ( isdefined( params.prop ) )
    {
        if ( isdefined( params.prop.var_34cdd5cda21b2ad1 ) )
        {
            prop_fx_name = "emp_mimic_small_prop_fx";
            params.prop.var_34cdd5cda21b2ad1 callback::add( #"on_ping", &function_61b5e60089f327a2 );
        }
        else if ( issubstr( params.prop.model, "machine" ) )
        {
            prop_fx_name = "emp_mimic_large_prop_fx";
        }
        else
        {
            prop_fx_name = "emp_mimic_med_prop_fx";
        }
        
        playfxontag( utility::getfx( prop_fx_name ), params.prop, "tag_origin" );
    }
}

// Namespace zombie_mimic_emp
// Params 1, eflags: 0x4
// Checksum 0x5f63297b, Offset: 0x61b
// Size: 0x1b
function private function_3013b319adad425( params )
{
    if ( isalive( self ) )
    {
        electricdischarge_blast();
    }
}

// Namespace zombie_mimic_emp
// Params 0
// Checksum 0x88f83b53, Offset: 0x63e
// Size: 0x10d
function function_f45939a5aad862af()
{
    self endon( #"death" );
    
    while ( true )
    {
        emp_center = self.origin;
        
        if ( isdefined( self.var_b1f3dccf5a1b9bb7 ) && isdefined( self.hidden_in_prop ) )
        {
            emp_center = self.var_b1f3dccf5a1b9bb7.origin;
        }
        
        players_in_radius = getplayersinradius( emp_center, 1700, 1700 );
        
        foreach ( player in players_in_radius )
        {
            if ( !isplayer( player ) || !isalive( player ) || player.var_d3ead59ec7215318 )
            {
                continue;
            }
            
            player thread function_be0c4cc6af4c531b();
        }
        
        wait 0.5;
    }
}

// Namespace zombie_mimic_emp
// Params 0, eflags: 0xc
// Checksum 0xc312db55, Offset: 0x753
// Size: 0x80
function private function_be0c4cc6af4c531b()
{
    self notify( #"hash_a6f7deff234cbf7c" );
    self endon( #"hash_a6f7deff234cbf7c" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self.var_2cf902925920a7f9 ) )
    {
        self.var_2cf902925920a7f9 = 1;
        utility::function_7c10ea82c1e305b8( "mimic_emp_fx", "on" );
    }
    
    wait 0.8;
    self.var_2cf902925920a7f9 = undefined;
    self playlocalsound( #"hash_9823df072fe474e2" );
    utility::function_7c10ea82c1e305b8( "mimic_emp_fx", "off" );
}

// Namespace zombie_mimic_emp
// Params 1, eflags: 0x4
// Checksum 0xefb00d8f, Offset: 0x7db
// Size: 0x32
function private function_61b5e60089f327a2( params )
{
    if ( isplayer( params.player ) )
    {
        self.ping_player = params.player;
    }
}

// Namespace zombie_mimic_emp
// Params 0, eflags: 0x4
// Checksum 0xc021d067, Offset: 0x815
// Size: 0xd0
function private function_ae8c2d365bb5590f()
{
    if ( self.var_34cdd5cda21b2ad1.ping_player )
    {
        return self.var_34cdd5cda21b2ad1.ping_player;
    }
    
    player = zombie_mimic_prop_spawn::function_284333c6441018ff( 200 );
    
    if ( isdefined( player ) )
    {
        return player;
    }
    
    mimic = self.var_71c219f2ccf139c0[ 0 ];
    
    if ( isalive( mimic ) && isdefined( mimic.overload_radius ) && function_3d59f0aee205231c( self.origin, mimic.overload_radius ) )
    {
        mimic thread electricdischarge_blast( 1 );
        playfx( utility::getfx( "emp_mimic_blast_fx" ), self.origin );
        return function_47c86977a18df38b( level.players, self.origin );
    }
}

// Namespace zombie_mimic_emp
// Params 0, eflags: 0x4
// Checksum 0x16a8bfe5, Offset: 0x8ed
// Size: 0x93
function private function_e4ddfd8e9b7876ae()
{
    self endon( #"death" );
    
    while ( true )
    {
        wait self.overload_cooldown;
        
        if ( self.hidden_in_prop )
        {
            continue;
        }
        
        utility::function_7c10ea82c1e305b8( "ambient_emp_vfx", "on" );
        
        while ( true )
        {
            wait 0.2;
            
            if ( self.hidden_in_prop )
            {
                break;
            }
            
            if ( function_3d59f0aee205231c( self.origin, self.overload_radius ) )
            {
                thread electricdischarge_blast();
                break;
            }
        }
        
        utility::function_7c10ea82c1e305b8( "ambient_emp_vfx", "off" );
    }
}

// Namespace zombie_mimic_emp
// Params 2, eflags: 0x4
// Checksum 0xd5cfaca2, Offset: 0x988
// Size: 0x1c8
function private function_3d59f0aee205231c( origin, radius )
{
    contents = physics_createcontents( [ "physicscontents_explosionclip" ] );
    v_radius = ( radius, radius, radius );
    aabb_min = origin - v_radius;
    aabb_max = origin + v_radius;
    query_results = physics_aabbbroadphasequery( aabb_min, aabb_max, contents );
    var_7fc7551dd3d93c44 = getentitiesinradiusfrompartitiongrid( origin, radius, createentitytypemask( [ "etype_missile" ] ), [] ) ?? [];
    queried_ents = arraycombineunique( var_7fc7551dd3d93c44, query_results );
    var_3ccad4c0856c4003 = 0;
    
    foreach ( target_ent in queried_ents )
    {
        if ( target_ent.classname != "grenade" && !issubstr( target_ent.weapon_name, "smart_seeker" ) )
        {
            continue;
        }
        
        if ( isdefined( target_ent.owner ) && target_ent.owner.team == self.team )
        {
            continue;
        }
        
        if ( target_ent.equipmentref == "equip_combataxe" )
        {
            continue;
        }
        
        if ( target_ent.var_9eb0e951b21fa1ff )
        {
            continue;
        }
        
        playfx( utility::getfx( "emp_mimic_destroy_grenade_fx" ), target_ent.origin );
        target_ent delete();
        var_3ccad4c0856c4003 = 1;
    }
    
    return var_3ccad4c0856c4003;
}

// Namespace zombie_mimic_emp
// Params 1, eflags: 0x4
// Checksum 0x5a06456c, Offset: 0xb59
// Size: 0x296
function private electricdischarge_blast( nofx )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( !nofx )
    {
        thread function_15dbbd79b22e4e51();
    }
    
    self.var_77fbf16cb6eaf1a8 = 1;
    blastorigin = self.origin;
    blastangles = self.angles;
    step = 100;
    maxdist = self.overload_radius;
    waittime = 0.1;
    currentdist = step;
    shockdata = function_23d98e039a552ac9( 1.5 );
    possibleplayers = utility::function_1b1340a94b43b874( self.origin, maxdist );
    var_d51eb95f460b110a = function_1293b51557137296( possibleplayers, blastorigin, shockdata );
    possibleents = namespace_9d8e359c3b1041e5::function_62b4af8718fa499b( blastorigin, maxdist );
    var_54f1799d880f7c72 = function_555f8930e51a1377( possibleents, blastorigin );
    
    while ( currentdist <= maxdist )
    {
        currentdistsq = currentdist * currentdist;
        var_9efdf63bfa0798b1 = [];
        
        foreach ( playerinfo in var_d51eb95f460b110a )
        {
            victim = playerinfo[ "player" ];
            var_a8640e403ed3ee1d = playerinfo[ "distanceSQ" ];
            
            if ( var_a8640e403ed3ee1d <= currentdistsq )
            {
                function_ba95ba871aa9061e( victim, shockdata );
                continue;
            }
            
            var_9efdf63bfa0798b1[ var_9efdf63bfa0798b1.size ] = playerinfo;
        }
        
        var_d51eb95f460b110a = var_9efdf63bfa0798b1;
        var_79b674af5e011569 = [];
        
        foreach ( entinfo in var_54f1799d880f7c72 )
        {
            ent = entinfo[ "entity" ];
            var_a8640e403ed3ee1d = entinfo[ "distanceSQ" ];
            
            if ( var_a8640e403ed3ee1d <= currentdistsq )
            {
                continue;
            }
            
            var_79b674af5e011569[ var_79b674af5e011569.size ] = entinfo;
        }
        
        var_54f1799d880f7c72 = var_79b674af5e011569;
        currentdist += step;
        wait waittime;
    }
    
    wait 1;
    self.var_77fbf16cb6eaf1a8 = 0;
    self notify( #"finished_electric_blast" );
}

// Namespace zombie_mimic_emp
// Params 3
// Checksum 0xa195a779, Offset: 0xdf7
// Size: 0x1a5
function function_2be5813838cfed7( victim, weaponobj, shockdata )
{
    self endon( #"disconnect" );
    victim endon( #"death_or_disconnect" );
    victim endon( #"haywire_cleared" );
    level endon( #"game_ended" );
    var_fe21c79ec13013d3 = shockdata.tableinfo.bundle.shockstick_tickinterval;
    totalshocktime = shockdata.tableinfo.bundle.var_c8bb02c8c8cd0442;
    
    if ( !isdefined( victim.var_99702520a6704748 ) )
    {
        victim.var_99702520a6704748 = 0;
    }
    
    victim.var_99702520a6704748++;
    
    if ( isdefined( victim.var_c3c0ab538286d048 ) )
    {
        if ( ( gettime() - victim.var_c3c0ab538286d048 ) / 1000 <= totalshocktime )
        {
            var_867e471e7074a065 = victim.var_99702520a6704748;
            totalshocktime = int( totalshocktime / var_867e471e7074a065 );
        }
    }
    
    shockendtime = gettime() + totalshocktime * 1000;
    victim.var_c3c0ab538286d048 = gettime();
    thread function_8ccf94dabf0cb177( victim, totalshocktime );
    
    while ( gettime() < shockendtime )
    {
        victim.var_192ff6d823148f9a = 1;
        
        if ( utility::issharedfuncdefined( #"shockstick", #"shockstick_applyhaywire" ) )
        {
            shockdata thread [[ utility::getsharedfunc( #"shockstick", #"shockstick_applyhaywire" ) ]]( victim, shockdata.weapon, 0 );
        }
        
        wait var_fe21c79ec13013d3;
    }
}

// Namespace zombie_mimic_emp
// Params 2
// Checksum 0xe2978c13, Offset: 0xfa4
// Size: 0x74
function function_8ccf94dabf0cb177( victim, totalshocktime )
{
    victim endon( #"disconnect" );
    victim notify( #"hash_9f6a4fabe9d92e6a" );
    victim endon( #"hash_9f6a4fabe9d92e6a" );
    level endon( #"game_ended" );
    victim utility::waittill_any_timeout( totalshocktime, "death", "last_stand_enter" );
    victim.var_192ff6d823148f9a = undefined;
    victim.var_99702520a6704748 = 0;
}

// Namespace zombie_mimic_emp
// Params 2
// Checksum 0x5d6be0a0, Offset: 0x1020
// Size: 0x2b
function function_ba95ba871aa9061e( victim, shockdata )
{
    thread function_2be5813838cfed7( victim, shockdata.weapon, shockdata );
}

// Namespace zombie_mimic_emp
// Params 0
// Checksum 0x9e514c3b, Offset: 0x1053
// Size: 0x107
function function_15dbbd79b22e4e51()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    shakeduration = 0.75;
    var_39bbe706cd34d2ec = 0.25;
    var_39deeb06cd5b2370 = 0.15;
    var_39def506cd5b396e = 0.08;
    radiusscalemax = 200;
    radiusscalemid = 400;
    radiusscalemin = 600;
    
    if ( utility::issharedfuncdefined( #"game", #"artillery_earthquake" ) )
    {
        [[ utility::getsharedfunc( #"game", #"artillery_earthquake" ) ]]( self.origin, shakeduration, var_39bbe706cd34d2ec, var_39deeb06cd5b2370, var_39def506cd5b396e, radiusscalemax, radiusscalemid, radiusscalemin, undefined, 1, 1 );
    }
    
    zombie_vox::function_5ac4bed4a907abf5( "electric_attack" );
    utility::function_7c10ea82c1e305b8( "emp_pulse", "on" );
    self waittill( #"finished_electric_blast" );
    utility::function_7c10ea82c1e305b8( "emp_pulse", "off" );
}

// Namespace zombie_mimic_emp
// Params 1
// Checksum 0xe06a0a38, Offset: 0x1162
// Size: 0x1a4
function function_23d98e039a552ac9( shockduration )
{
    shockdata = spawnstruct();
    shockdata.owner = self;
    shockdata.team = isdefined( self.var_bd22ba6c600a23a3 ) ? self.var_bd22ba6c600a23a3.team : self.team;
    shockdata.origin = self.origin;
    shockdata.weapon = makeweapon( "none" );
    shockdata.tableinfo = {};
    shockdata.tableinfo.bundle = {};
    shockdata.tableinfo.var_f3447a3874df563f = 0;
    shockdata.tableinfo.var_9891ed88bcd38fd2 = 1;
    shockdata.tableinfo.var_c6920ebeb7833310 = 1;
    shockdata.tableinfo.var_cd1e9f6afbf90d3a = 1;
    shockdata.tableinfo.bundle.var_f232776b54e76cfa = 0.3;
    shockdata.tableinfo.bundle.var_860545b754d7ecc0 = shockduration;
    shockdata.tableinfo.bundle.var_c8bb02c8c8cd0442 = shockduration + 0.25;
    shockdata.tableinfo.bundle.shockstick_tickinterval = 0.2;
    return shockdata;
}

// Namespace zombie_mimic_emp
// Params 3
// Checksum 0x8bfab61e, Offset: 0x130f
// Size: 0x12b
function function_1293b51557137296( sourcearray, reforigin, shockdata )
{
    filteredplayers = [];
    
    foreach ( player in sourcearray )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player == self )
        {
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"shockstick", #"shockstick_canbehaywire" ) )
        {
            canbehaywired = player [[ utility::getsharedfunc( #"shockstick", #"shockstick_canbehaywire" ) ]]( shockdata, 1 );
        }
        
        if ( !canbehaywired )
        {
            continue;
        }
        
        index = filteredplayers.size;
        filteredplayers[ index ][ "player" ] = player;
        filteredplayers[ index ][ "distanceSQ" ] = distancesquared( player.origin, reforigin );
    }
    
    return filteredplayers;
}

// Namespace zombie_mimic_emp
// Params 2
// Checksum 0xd0437b59, Offset: 0x1443
// Size: 0x1cb
function function_555f8930e51a1377( sourcearray, reforigin )
{
    filteredents = [];
    
    foreach ( ent in sourcearray )
    {
        if ( !isdefined( ent ) || ent.isdestroyed )
        {
            continue;
        }
        
        if ( ent vehicle::is_vehicle() )
        {
            if ( ent.team == self.team )
            {
                continue;
            }
            
            if ( isdefined( ent.owner ) && ( ent.owner == self || ent.owner.team == self.team ) )
            {
                continue;
            }
        }
        else
        {
            var_7ad50cdbb03c5d89 = undefined;
            var_9c6c16bd6fe37abe = undefined;
            
            if ( isdefined( ent.owner ) )
            {
                var_7ad50cdbb03c5d89 = ent.owner.team;
                var_9c6c16bd6fe37abe = ent.owner;
            }
            else if ( isdefined( ent.team ) )
            {
                var_7ad50cdbb03c5d89 = ent.team;
            }
            
            if ( var_7ad50cdbb03c5d89 == self.team && var_9c6c16bd6fe37abe != self )
            {
                continue;
            }
        }
        
        index = filteredents.size;
        filteredents[ index ][ "entity" ] = ent;
        filteredents[ index ][ "distanceSQ" ] = distancesquared( ent.origin, reforigin );
    }
    
    return filteredents;
}

// Namespace zombie_mimic_emp
// Params 1
// Checksum 0x9938aac6, Offset: 0x1617
// Size: 0x2c
function function_555ee7ae182ba3cc( params )
{
    electricdischarge_blast();
    playfx( utility::getfx( "emp_mimic_blast_fx" ), self.origin );
}

// Namespace zombie_mimic_emp
// Params 14, eflags: 0x4
// Checksum 0xfbf88339, Offset: 0x164b
// Size: 0x132
function private function_2acce069c7661bfa( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid )
{
    var_5e5a2456deacd236 = undefined;
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_weapon_element" ) )
    {
        var_5e5a2456deacd236 = utility::callsharedfunc( #"zombie", #"get_weapon_element", inflictor.sweapon, inflictor.eattacker, inflictor.smeansofdeath );
    }
    
    if ( isdefined( var_5e5a2456deacd236 ) )
    {
        if ( inflictor.smeansofdeath == "MOD_ELEMENTAL_ELEC" && var_5e5a2456deacd236 == "electrical" )
        {
            inflictor.idamage *= 0.6;
        }
    }
    
    return inflictor.idamage;
}

