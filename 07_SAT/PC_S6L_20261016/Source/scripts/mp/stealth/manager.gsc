// scripts\mp\stealth\manager.gsc  (hash_27f25067f25f18e3.gscc) (size: 4969 Bytes / 0x1369 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6eacc48a (1856816266)
// size ...... 4969 (0x1369)
// includes .. 6   (offset: 0x120d)
// strings ... 15  (offset: 0x123d)
// dev strs .. 1   (offset: 0x135d)
// exports ... 14  (offset: 0xb89)
// cseg ...... 0x132 + 0xa57 (0xb89)
// imports ... 37  (offset: 0xdb9)
// animtree1 . 0   (offset: 0x1369)
// animtree2 . 0   (offset: 0x1369)
#using scripts\anim\battlechatter;
#using scripts\common\ai\stealth\corpse;
#using scripts\common\ai\stealth\manager;
#using scripts\common\ai\stealth\threat_sight;
#using scripts\common\ai\stealth\utility;
#using scripts\common\utility;

#namespace stealth_manager_cpmp;

// Namespace stealth_manager_cpmp
// Params 0
// Checksum 0x22d06ae1, Offset: 0x150
// Size: 0xe2
function main()
{
    stealth_manager::main();
    assert( isdefined( level.stealth ), "<dev string:x24>" );
    level.stealth.fnaddeventplaybcs = &battlechatter::addeventplaybcs;
    level.fngetcorpsearrayfunc = &get_corpse_array;
    level.stealth.fngetplayerdrone = &get_player_drone;
    level.var_d2acb1f87b1cb3ad = &function_d2acb1f87b1cb3ad;
    level.var_5e2fb909eaff2aac = &function_7740b66d6d42e29;
    level thread function_11d5fb4e16a98798();
    set_detect_ranges();
    set_corpse_detect_ranges();
    level thread threat_sight::threat_sight_set_enabled( 1 );
    level thread manager_thread();
    level thread update_stealth_spotted_thread();
    
    if ( utility::issharedfuncdefined( #"stealth", #"init" ) )
    {
        [[ utility::getsharedfunc( #"stealth", #"init" ) ]]();
    }
}

// Namespace stealth_manager_cpmp
// Params 0
// Checksum 0x66846bc8, Offset: 0x23a
// Size: 0x39
function function_d2acb1f87b1cb3ad()
{
    if ( utility::issharedfuncdefined( #"stealth_enemy", #"init" ) )
    {
        self [[ utility::getsharedfunc( #"stealth_enemy", #"init" ) ]]();
    }
}

// Namespace stealth_manager_cpmp
// Params 1
// Checksum 0x5e22c92b, Offset: 0x27b
// Size: 0x45
function function_7740b66d6d42e29( bspotted )
{
    if ( utility::issharedfuncdefined( #"stealth", #"spotted_event_handler" ) )
    {
        self [[ utility::getsharedfunc( #"stealth", #"spotted_event_handler" ) ]]( bspotted );
    }
}

// Namespace stealth_manager_cpmp
// Params 10
// Checksum 0x342edd7f, Offset: 0x2c8
// Size: 0x5d
function empty( param_1, param_2, param_3, param_4, param_5, param_6, param_7, param_8, param_9, param_10 )
{
    
}

// Namespace stealth_manager_cpmp
// Params 0
// Checksum 0xf0c299a1, Offset: 0x32d
// Size: 0x2
function set_detect_ranges()
{
    
}

// Namespace stealth_manager_cpmp
// Params 0
// Checksum 0xc794ccd5, Offset: 0x337
// Size: 0x35
function set_corpse_detect_ranges()
{
    array[ "sight_dist" ] = 512;
    array[ "detect_dist" ] = 256;
    array[ "found_dist" ] = 128;
    corpse::set_corpse_ranges( array );
}

// Namespace stealth_manager_cpmp
// Params 0
// Checksum 0xa145b24d, Offset: 0x374
// Size: 0x19d
function function_11d5fb4e16a98798()
{
    while ( !isdefined( level.stealth ) )
    {
        waitframe();
    }
    
    hiddenranges[ "prone" ] = 1000;
    hiddenranges[ "crouch" ] = 2000;
    hiddenranges[ "stand" ] = getdvarint( @"hash_113e6612d6e3bb87", 2750 );
    var_cd13efba31ed7919[ "prone" ] = 150;
    var_cd13efba31ed7919[ "crouch" ] = 350;
    var_cd13efba31ed7919[ "stand" ] = 600;
    hiddenranges[ "shadow_prone" ] = 0.05;
    hiddenranges[ "shadow_crouch" ] = 0.05;
    hiddenranges[ "shadow_stand" ] = 0.3;
    spottedranges[ "prone" ] = 1500;
    spottedranges[ "crouch" ] = 2500;
    spottedranges[ "stand" ] = getdvarint( @"hash_4689de43493d4968", 3250 );
    var_961e1ea3c0e00f2e[ "prone" ] = 250;
    var_961e1ea3c0e00f2e[ "crouch" ] = 1000;
    var_961e1ea3c0e00f2e[ "stand" ] = 1800;
    spottedranges[ "shadow_prone" ] = 0.01;
    spottedranges[ "shadow_crouch" ] = 0.02;
    spottedranges[ "shadow_stand" ] = 0.38;
    var_539b732c92b1a610[ "prone" ] = 0;
    var_539b732c92b1a610[ "crouch" ] = 0;
    var_539b732c92b1a610[ "stand" ] = 0;
    var_fb7f8ee8f9e0bc4d[ "prone" ] = 0;
    var_fb7f8ee8f9e0bc4d[ "crouch" ] = 0;
    var_fb7f8ee8f9e0bc4d[ "stand" ] = 0;
    utility::set_detect_ranges( hiddenranges, spottedranges );
    utility::set_min_detect_range_darkness( var_cd13efba31ed7919, var_961e1ea3c0e00f2e );
    utility::set_min_detect_range_shadow( var_539b732c92b1a610, var_fb7f8ee8f9e0bc4d );
    
    if ( isdefined( level.var_73c29b24b6b8b961 ) )
    {
        [[ level.var_73c29b24b6b8b961 ]]();
    }
}

// Namespace stealth_manager_cpmp
// Params 0
// Checksum 0xc93cbf74, Offset: 0x519
// Size: 0x74
function manager_thread()
{
    while ( true )
    {
        utility::flag_wait( "stealth_enabled" );
        threat_sight_set_dvar( 1 );
        utility::flag_wait( "stealth_spotted" );
        
        if ( !utility::flag( "stealth_enabled" ) )
        {
            continue;
        }
        
        stealth_manager::event_change( "spotted" );
        utility::flag_waitopen( "stealth_spotted" );
        
        if ( !utility::flag( "stealth_enabled" ) )
        {
            continue;
        }
        
        stealth_manager::event_change( "hidden" );
        waittillframeend();
    }
}

// Namespace stealth_manager_cpmp
// Params 1
// Checksum 0x8a917f8b, Offset: 0x595
// Size: 0x2b
function threat_sight_set_dvar( enabled )
{
    if ( enabled && !getstealththreatsightenabled() )
    {
        return;
    }
    
    setdvar( @"ai_threatsight", enabled );
}

// Namespace stealth_manager_cpmp
// Params 0
// Checksum 0x3718ba11, Offset: 0x5c8
// Size: 0x22a
function update_stealth_spotted_thread()
{
    waitframe();
    wasspotted = 0;
    
    while ( true )
    {
        bspotted = stealth_manager::anyone_in_combat();
        
        if ( bspotted )
        {
            if ( !wasspotted && isdefined( level.stealth.stealth_spotted_delay ) && level.stealth.stealth_spotted_delay > 0 )
            {
                wait level.stealth.stealth_spotted_delay;
                
                if ( !stealth_manager::anyone_in_combat() )
                {
                    waitframe();
                    continue;
                }
            }
            
            if ( !utility::flag( "stealth_spotted" ) )
            {
                utility::flag_set( "stealth_spotted" );
                
                foreach ( player in level.players )
                {
                    if ( isdefined( player.stealth ) )
                    {
                        if ( isdefined( level.var_5e2fb909eaff2aac ) )
                        {
                            player [[ level.var_5e2fb909eaff2aac ]]( 1 );
                        }
                        
                        mygroupflagname = player utility::get_group_flagname( "stealth_spotted" );
                        utility::flag_set( mygroupflagname );
                    }
                }
            }
        }
        else if ( utility::flag( "stealth_spotted" ) )
        {
            utility::flag_clear( "stealth_spotted" );
            
            foreach ( player in level.players )
            {
                if ( isdefined( player.stealth ) )
                {
                    if ( isdefined( level.var_5e2fb909eaff2aac ) )
                    {
                        player [[ level.var_5e2fb909eaff2aac ]]( 0 );
                    }
                    
                    mygroupflagname = player utility::get_group_flagname( "stealth_spotted" );
                    utility::flag_clear( mygroupflagname );
                }
            }
        }
        
        wasspotted = bspotted;
        waitframe();
    }
}

// Namespace stealth_manager_cpmp
// Params 0
// Checksum 0x63e32349, Offset: 0x7fa
// Size: 0xd8
function get_corpse_array()
{
    if ( !isdefined( level.stealth.corpses ) )
    {
        return [];
    }
    
    foreach ( i, v in level.stealth.corpses )
    {
        if ( !isdefined( level.stealth.corpses[ i ] ) )
        {
            level.stealth.corpses[ i ] = undefined;
        }
    }
    
    return level.stealth.corpses;
}

// Namespace stealth_manager_cpmp
// Params 3
// Checksum 0xc31b5631, Offset: 0x8db
// Size: 0x264
function monitor_death_thread( rangeauto = 480, rangesight = 1200, rangeperipheral = 1500 )
{
    other = undefined;
    team = self.team;
    self waittill( #"death" );
    
    if ( isdefined( self.stealth.override_damage_auto_range ) )
    {
        rangeauto = self.stealth.override_damage_auto_range;
    }
    else if ( isdefined( level.stealth.override_damage_auto_range ) )
    {
        rangeauto = level.stealth.override_damage_auto_range;
    }
    
    if ( isdefined( self.stealth.override_damage_sight_range ) )
    {
        rangesight = self.stealth.override_damage_sight_range;
    }
    else if ( isdefined( level.stealth.override_damage_sight_range ) )
    {
        rangesight = level.stealth.override_damage_sight_range;
    }
    
    if ( isdefined( self.stealth.var_cb5942db012d8899 ) )
    {
        rangeperipheral = self.stealth.var_cb5942db012d8899;
    }
    else if ( isdefined( level.stealth.var_cb5942db012d8899 ) )
    {
        rangeperipheral = level.stealth.var_cb5942db012d8899;
    }
    
    body = self getcorpseentity();
    
    if ( isdefined( body ) )
    {
        level.stealth.corpses[ body getentitynumber() ] = body;
    }
    
    if ( !isdefined( self.lastattacker ) )
    {
        return;
    }
    
    other = self.lastattacker;
    
    if ( !isplayer( other ) && !isplayer( other.owner ) )
    {
        return;
    }
    
    if ( isdefined( other.owner ) )
    {
        other = other.owner;
    }
    
    if ( !isdefined( other.team ) || other.team == team )
    {
        return;
    }
    
    if ( function_db0bfa4e0a29d123( self.damagemod ) )
    {
        stealtheventbroadcast( "ally_hurt_peripheral", self, other, rangeauto, rangeperipheral, self.damagemod );
        stealtheventbroadcast( "ally_killed", self, other, rangeauto, rangesight, self.damagemod );
    }
}

// Namespace stealth_manager_cpmp
// Params 1
// Checksum 0xa20be48c, Offset: 0xb47
// Size: 0x42
function get_player_drone( player )
{
    var_7237854e3be197ca = player.scout_drone;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    var_7237854e3be197ca = player.emp_drone;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
}

