// scripts\mp\common\equipment\monkey_bomb.gsc  (hash_4b6117e9579324ad.gscc) (size: 6892 Bytes / 0x1aec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x385ac6fa (945473274)
// size ...... 6892 (0x1aec)
// includes .. 5   (offset: 0x1994)
// strings ... 21  (offset: 0x19bc)
// dev strs .. 1   (offset: 0x1ae0)
// exports ... 14  (offset: 0x1088)
// cseg ...... 0x1d4 + 0xeb4 (0x1088)
// imports ... 59  (offset: 0x12b8)
// animtree1 . 0   (offset: 0x1aec)
// animtree2 . 0   (offset: 0x1aec)
#using script_13865ca76df87ea;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\equipment;

#namespace monkey_bomb;

// Namespace monkey_bomb
// Params 0
// Checksum 0x87c9456, Offset: 0x1f2
// Size: 0x8d
function monkey_bomb_init()
{
    level.var_643e99d5a18faa82 = [];
    level.var_546d1ce59a4bfdc5 = &monkey_in_bounds;
    weaponname = utility::get_scripted_weapon_name( #"monkey_bomb" );
    level.monkey_bomb_name = weaponname;
    level.var_8c94fee7994936ba = "t10_zm_monkey_bomb_dance_01";
    utility::registersharedfunc( #"monkey_bomb", #"used", &monkey_bomb_used );
    level._effect[ "monkey_bomb_oob" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_monkey_bomb_despawn" );
    level thread function_a0da125b7486ddcd();
}

// Namespace monkey_bomb
// Params 1
// Checksum 0x92733336, Offset: 0x287
// Size: 0x36a
function monkey_bomb_used( grenade )
{
    ref = equipment_mp::getequipmentreffromweapon( grenade.weapon_object );
    grenade.tableinfo = equipment_mp::getequipmenttableinfo( ref );
    
    if ( !isdefined( grenade.tableinfo.bundle ) )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    grenade endon( #"death" );
    
    if ( level.var_b75db25d44709ee || level.var_54d8aed57d6404ed )
    {
        grenade hide();
    }
    else
    {
        grenade hideallparts();
    }
    
    grenade.angles = self.angles;
    monkey_model = spawn( "script_model", grenade.origin );
    monkey_model.angles = grenade.angles;
    blueprintindex = grenade.weapon_object.variantid;
    
    if ( !isdefined( blueprintindex ) )
    {
        blueprintindex = 0;
    }
    
    tableinfo = equipment_mp::getequipmenttableinfo( grenade.equipment_ref ?? "equip_monkey_bomb" );
    bundle = tableinfo.bundle;
    genericblueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, blueprintindex );
    
    if ( isdefined( genericblueprintname ) )
    {
        monkey_model setgenericblueprintmodel( genericblueprintname, #"hash_13239327fd97153e" );
    }
    else
    {
        monkey_model setmodel( "offhand_t10_wm_zmb_monkey_bomb" );
    }
    
    monkey_bomb_team = level.var_b75db25d44709ee ? self.team : undefined;
    monkey_model.grenade = grenade;
    monkey_model.team = self.team;
    monkey_model.owner = self;
    monkey_model.attractor = zombie_attractor_manager::add_attractor( monkey_model, 2, 2000, 0, undefined, &function_3f513fdf297a8d62, 0, monkey_bomb_team, 1 );
    monkey_model.attractor.var_9bc09bc79f28a18e = 1;
    monkey_model.equipmentref = grenade.equipment_ref ?? "equip_monkey_bomb";
    grenade.monkey_model = monkey_model;
    grenade.monkey_model linkto( grenade );
    grenade.monkey_model.var_5d7d37d12e89dcc9 = self;
    grenade.monkey_model utility::function_7c10ea82c1e305b8( "sound", "throw" );
    grenade thread function_eb91977c78c3c6cf( monkey_model, monkey_model.attractor );
    level thread function_dbab8bc7d2a74c3f( grenade );
    grenade waittill( #"missile_stuck", stuckto );
    grenade.monkey_model utility::function_7c10ea82c1e305b8( "sound", "land" );
    
    if ( !isdefined( grenade ) && isent( monkey_model ) )
    {
        monkey_model delete();
    }
    
    if ( grenade.var_5e5d88960cbc785a )
    {
        return;
    }
    
    if ( isdefined( grenade ) && isdefined( grenade.monkey_model ) )
    {
        grenade.monkey_model.closest_navmesh_point = getclosestpointonnavmesh( grenade.monkey_model.origin, isai( self ) ? self : undefined );
        level.var_643e99d5a18faa82[ level.var_643e99d5a18faa82.size ] = grenade.monkey_model;
    }
}

// Namespace monkey_bomb
// Params 1
// Checksum 0x62a15e80, Offset: 0x5f9
// Size: 0x93
function function_dbab8bc7d2a74c3f( grenade )
{
    grenade endon( #"missile_stuck" );
    msg = grenade utility::waittill_any_timeout( 10, "death" );
    
    if ( msg == "death" )
    {
        if ( isdefined( grenade.monkey_model ) )
        {
            if ( isdefined( grenade.monkey_model.attractor ) )
            {
                zombie_attractor_manager::remove_attractor( grenade.monkey_model.attractor );
            }
            
            grenade.monkey_model delete();
        }
    }
}

// Namespace monkey_bomb
// Params 2
// Checksum 0xa7c44eb7, Offset: 0x694
// Size: 0xa0
function function_3f513fdf297a8d62( attractor, zombie )
{
    if ( zombie.b_ignore_monkey_bomb )
    {
        return 0;
    }
    
    if ( !val::get( "allow_secondary_attack_damage" ) )
    {
        return 0;
    }
    
    if ( zombie.var_840153567385cc6b )
    {
        return 0;
    }
    
    if ( zombie.aicategory == "normal" || zombie.aicategory == "special" )
    {
        if ( zombie.team != attractor.source.team )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 0;
}

// Namespace monkey_bomb
// Params 2
// Checksum 0xe7709e93, Offset: 0x73c
// Size: 0x92
function function_eb91977c78c3c6cf( monkey_model, attractor )
{
    self endon( #"missile_stuck" );
    level endon( #"game_ended" );
    childthread function_9c709124510af0c8();
    msg = utility::waittill_any_timeout( 13, "monkey_bomb_throw_into_teleport_back_area", "missile_water_impact" );
    
    if ( msg == "missile_water_impact" )
    {
        wait 1;
    }
    
    if ( isdefined( attractor ) )
    {
        zombie_attractor_manager::remove_attractor( attractor );
    }
    
    if ( !isdefined( self ) )
    {
        if ( isdefined( monkey_model ) )
        {
            monkey_model delete();
        }
        
        return;
    }
    
    level thread grenade_stolen_by_sam( self, undefined );
}

// Namespace monkey_bomb
// Params 1, eflags: 0x4
// Checksum 0xad0789e1, Offset: 0x7d6
// Size: 0x8f, Type: bool
function private function_aa2c8c826e715283( player )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"game", #"isCommonItemEnabled" ) )
    {
        if ( !utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
        {
            return false;
        }
        
        if ( !( utility::issharedfuncdefined( #"game", #"hash_6a1940cb87219089" ) && utility::issharedfuncdefined( #"game", #"getItemBundleNameFromRef" ) ) )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace monkey_bomb
// Params 0
// Checksum 0x6413b9b5, Offset: 0x86e
// Size: 0x10d
function function_9c709124510af0c8()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    var_c20ec125db5ff99d = isarray( level.var_dcdf2aa7cb419ad4 ) ? level.var_dcdf2aa7cb419ad4 : [];
    
    while ( self )
    {
        return_volumes = utility::callsharedfunc( #"equipment", #"hash_1b48910965b8556e" ) ?? [];
        check_volumes = arraycombineunique( var_c20ec125db5ff99d, return_volumes );
        
        if ( check_volumes.size > 0 )
        {
            foreach ( check_volume in check_volumes )
            {
                if ( self istouching( check_volume ) )
                {
                    self notify( #"monkey_bomb_throw_into_teleport_back_area" );
                    return;
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace monkey_bomb
// Params 2
// Checksum 0x7329c431, Offset: 0x983
// Size: 0x3a1
function grenade_stolen_by_sam( grenade, e_actor )
{
    if ( !isdefined( grenade.monkey_model ) )
    {
        return;
    }
    
    if ( isdefined( level.var_d49f16537ce71aee ) )
    {
        should_refund = grenade [[ level.var_d49f16537ce71aee ]]( grenade.monkey_model );
    }
    else
    {
        should_refund = 1;
    }
    
    grenade.var_5e5d88960cbc785a = 1;
    monkey_model = grenade.monkey_model;
    direction = grenade.monkey_model.origin;
    direction = ( direction[ 1 ], direction[ 0 ], 0 );
    
    if ( direction[ 1 ] < 0 || direction[ 0 ] > 0 && direction[ 1 ] > 0 )
    {
        direction = ( direction[ 0 ], direction[ 1 ] * -1, 0 );
    }
    else if ( direction[ 0 ] < 0 )
    {
        direction = ( direction[ 0 ] * -1, direction[ 1 ], 0 );
    }
    
    grenade.monkey_model utility::function_7c10ea82c1e305b8( "sound", "stolen" );
    grenade.monkey_model utility::function_7c10ea82c1e305b8( "vfx", "stolen" );
    grenade.monkey_model unlink();
    waitframe();
    
    if ( !isdefined( grenade ) )
    {
        if ( isdefined( monkey_model ) )
        {
            monkey_model delete();
        }
        
        return;
    }
    
    if ( !isdefined( grenade.monkey_model ) )
    {
        return;
    }
    
    total_time = 1;
    grenade.monkey_model vibrate( direction, 1.5, 2.5, total_time );
    
    if ( grenade.monkey_model.angles[ 2 ] != 0 )
    {
        grenade.monkey_model rotateroll( 0 - grenade.monkey_model.angles[ 2 ], 0.25 );
        total_time -= 0.25;
        wait 0.25;
        
        if ( !isdefined( grenade ) )
        {
            if ( isdefined( monkey_model ) )
            {
                monkey_model delete();
            }
            
            return;
        }
    }
    
    if ( should_refund )
    {
        grenade.monkey_model movez( 60, total_time, 0.25, 0.25 );
    }
    
    wait total_time;
    
    if ( !isdefined( grenade ) )
    {
        if ( isdefined( monkey_model ) )
        {
            monkey_model delete();
        }
        
        return;
    }
    
    if ( isdefined( grenade.monkey_model ) )
    {
        grenade.monkey_model delete();
    }
    
    if ( should_refund )
    {
        if ( isdefined( level.var_6f5cbfe6aee65f4 ) && isdefined( grenade.equipmentref ) && isdefined( grenade.owner ) )
        {
            grenade.owner [[ level.var_6f5cbfe6aee65f4 ]]( grenade.equipmentref, "secondary", 1 );
        }
        else if ( function_aa2c8c826e715283( grenade.owner ) )
        {
            itembundlename = utility::callsharedfunc( #"game", #"getItemBundleNameFromRef", grenade.equipmentref );
            
            if ( !isdefined( itembundlename ) )
            {
                return;
            }
            
            itembundle = getscriptbundle( itembundlename );
            fakeitem = spawnstruct();
            fakeitem.count = 1;
            fakeitem.type = itembundle.scriptable;
            grenade.owner utility::callsharedfunc( #"game", #"hash_6a1940cb87219089", fakeitem, 0 );
        }
    }
    
    if ( isdefined( e_actor ) )
    {
        e_actor delete();
    }
    
    if ( isdefined( grenade ) )
    {
        if ( isdefined( grenade.damagearea ) )
        {
            grenade.damagearea delete();
        }
        
        grenade delete();
    }
}

// Namespace monkey_bomb
// Params 0
// Checksum 0x74210174, Offset: 0xd2c
// Size: 0x10e
function function_a0da125b7486ddcd()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( monkey_model in level.var_643e99d5a18faa82 )
        {
            if ( !isdefined( monkey_model ) || monkey_model.dancing )
            {
                continue;
            }
            
            if ( !isdefined( monkey_model.grenade ) )
            {
                if ( isdefined( monkey_model.attractor ) )
                {
                    zombie_attractor_manager::remove_attractor( monkey_model.attractor );
                }
                
                monkey_model utility::function_7c10ea82c1e305b8( "sound", "off" );
                monkey_model delete();
                continue;
            }
            
            monkey_model thread function_777dbc018301fea2();
            waitframe();
        }
        
        level.var_643e99d5a18faa82 = function_5713d46873b29625( level.var_643e99d5a18faa82 );
        waitframe();
    }
}

// Namespace monkey_bomb
// Params 1
// Checksum 0xe4ec27bb, Offset: 0xe42
// Size: 0x3f, Type: bool
function monkey_in_bounds( checkloc )
{
    if ( !isdefined( self.closest_navmesh_point ) )
    {
        return false;
    }
    
    squaredist = distancesquared( checkloc, self.closest_navmesh_point );
    return squaredist <= 40000;
}

// Namespace monkey_bomb
// Params 0
// Checksum 0x35cf0c74, Offset: 0xe8a
// Size: 0x1a2
function function_777dbc018301fea2()
{
    self endon( #"death" );
    waitframe();
    self.dancing = 1;
    
    if ( level.var_546d1ce59a4bfdc5 && ![[ level.var_546d1ce59a4bfdc5 ]]( self.origin ) )
    {
        if ( self.attractor )
        {
            zombie_attractor_manager::remove_attractor( self.attractor );
        }
        
        level thread grenade_stolen_by_sam( self.grenade, self );
        return;
    }
    
    thread function_f6ff25e05fd68bd1();
    utility::function_7c10ea82c1e305b8( "sound", "song" );
    self scriptmodelplayanim( isstring( level.var_8c94fee7994936ba ) ? level.var_8c94fee7994936ba : "t10_zm_monkey_bomb_dance_01" );
    bundle = self.grenade.tableinfo.bundle;
    totalduration = bundle.monkey_bomb_fuse_time ?? 8.5;
    totalduration = getdvarfloat( @"monkey_bomb_fuse_time", totalduration );
    self.fuse_start_time = gettime();
    self.fuse_end_time = self.fuse_start_time + utility::function_4b74c15943231980( totalduration );
    
    while ( gettime() < self.fuse_end_time )
    {
        if ( !isdefined( self.grenade ) )
        {
            break;
        }
        
        wait 0.5;
        
        if ( level.var_546d1ce59a4bfdc5 && ![[ level.var_546d1ce59a4bfdc5 ]]( self.origin ) )
        {
            if ( self.attractor )
            {
                zombie_attractor_manager::remove_attractor( self.attractor );
            }
            
            break;
        }
    }
    
    monkey_detonate_immediate();
}

// Namespace monkey_bomb
// Params 0
// Checksum 0xffb3d625, Offset: 0x1034
// Size: 0x25
function function_f6ff25e05fd68bd1()
{
    self endon( #"death" );
    wait 0.15;
    utility::function_7c10ea82c1e305b8( "vfx", "active" );
}

// Namespace monkey_bomb
// Params 0
// Checksum 0xf7ddffec, Offset: 0x1061
// Size: 0x27
function monkey_detonate_immediate()
{
    if ( isdefined( self.grenade ) )
    {
        self.grenade detonate();
    }
    
    self.dancing = 0;
}

