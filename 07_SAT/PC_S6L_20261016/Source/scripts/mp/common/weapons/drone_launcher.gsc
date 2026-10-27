// scripts\mp\common\weapons\drone_launcher.gsc  (hash_639c4330199e6077.gscc) (size: 20711 Bytes / 0x50e7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xda7709b6 (3665234358)
// size ...... 20711 (0x50e7)
// includes .. 12  (offset: 0x4bb7)
// strings ... 65  (offset: 0x4c17)
// dev strs .. 0   (offset: 0x50e7)
// exports ... 12  (offset: 0x3eab)
// cseg ...... 0x62a + 0x3881 (0x3eab)
// imports ... 71  (offset: 0x408b)
// animtree1 . 0   (offset: 0x50e7)
// animtree2 . 0   (offset: 0x50e7)
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\entity;
#using scripts\mp\emp_debuff;
#using scripts\mp\weapons;

#namespace drone_launcher;

// Namespace drone_launcher
// Params 0
// Checksum 0xc4e504de, Offset: 0x648
// Size: 0x1b
function init()
{
    level._effect[ "sentry_gun_stun_fx" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_sentry_emp_disable" );
}

// Namespace drone_launcher
// Params 2
// Checksum 0x2866fdf8, Offset: 0x66b
// Size: 0x2199
function function_38bca77bc997c0f7( objweapon, missileent )
{
    level endon( #"game_ended" );
    viewangles = self getplayerangles();
    vieweye = self geteye();
    playerforward = anglestoforward( viewangles );
    traceendposlong = vieweye + playerforward * 6000;
    var_d580bc45005fae9b = 400;
    var_ba14366aee4b134d = getdvarint( @"hash_8a17c968aa5c8fd1", -1 );
    
    if ( var_ba14366aee4b134d > 0 )
    {
        traceendposlong = vieweye + playerforward * var_ba14366aee4b134d;
    }
    
    var_ab4d8e7bfcfccb13 = getdvarint( @"hash_1e45eef33a3b63", -1 );
    
    if ( var_ab4d8e7bfcfccb13 > 0 )
    {
        var_d580bc45005fae9b = var_ab4d8e7bfcfccb13;
    }
    
    var_8e06afb7a79fad51 = trace::create_contents( 1, 0, 0, 0, 0, 1 );
    toweroffset = ( 0, 0, 10 );
    var_1f1573de36c02507 = 0;
    
    if ( isbrgamemode() )
    {
        var_1f1573de36c02507 = getdvarint( @"hash_31c5e6d57a1104e1", 0 );
    }
    
    var_4144b9d42314daed = [];
    var_73b3deeb0879f193 = [];
    var_e2e195b57412786 = trace::sphere_trace_get_all_results( vieweye, traceendposlong, 60, self, var_8e06afb7a79fad51, 0, 1 );
    
    foreach ( result in var_e2e195b57412786 )
    {
        if ( isdefined( result[ "entity" ] ) )
        {
            ent = result[ "entity" ];
            
            if ( sighttracepassed( vieweye, result[ "position" ], 0, ent, undefined, 1 ) )
            {
                if ( isplayer( ent ) && ( isdefined( ent.perks[ "specialty_emp_immunity" ] ) || isdefined( ent.perks[ "specialty_empimmune" ] ) ) && isenemyteam( self.team, ent.team ) && level.teambased )
                {
                    continue;
                }
                
                var_4144b9d42314daed = arraycombineunique( var_4144b9d42314daed, [ ent ] );
            }
        }
    }
    
    if ( getdvarint( @"hash_e11b62d8bc4f25da", 1 ) == 1 )
    {
        var_9280d8aacd85463f = entity::getentitiesinradius( vieweye, var_d580bc45005fae9b, undefined, undefined, trace::create_default_contents( 0 ) );
        
        foreach ( ent in var_9280d8aacd85463f )
        {
            if ( self worldpointinreticle_circle( ent.origin, 65, 120 ) == 1 )
            {
                var_4144b9d42314daed[ var_4144b9d42314daed.size ] = ent;
            }
        }
        
        if ( var_1f1573de36c02507 )
        {
            if ( level.var_5ee9a89b9f9b984b )
            {
                var_b0076a2b1365c6fb = getentitylessscriptablearray( undefined, undefined, vieweye, var_d580bc45005fae9b, "scriptable_uav_tower" );
                
                foreach ( scriptable in var_b0076a2b1365c6fb )
                {
                    if ( isdefined( scriptable.var_5b3dbacfeda0fd01 ) )
                    {
                        if ( self worldpointinreticle_circle( scriptable.origin + toweroffset, 65, 120 ) == 1 )
                        {
                            var_73b3deeb0879f193 = arraycombineunique( var_73b3deeb0879f193, [ scriptable ] );
                        }
                    }
                }
            }
            
            if ( level.br_armory_kiosk.var_e253c9f921155d75 )
            {
                var_9acb6bd1253de842 = getentitylessscriptablearray( undefined, undefined, vieweye, var_d580bc45005fae9b, "br_plunder_box" );
                
                foreach ( scriptable in var_9acb6bd1253de842 )
                {
                    if ( isdefined( scriptable.var_5b3dbacfeda0fd01 ) )
                    {
                        if ( self worldpointinreticle_circle( scriptable.origin + toweroffset, 65, 120 ) == 1 )
                        {
                            var_73b3deeb0879f193 = arraycombineunique( var_73b3deeb0879f193, [ scriptable ] );
                        }
                    }
                }
            }
        }
    }
    
    if ( isdefined( level.activekillstreaks ) )
    {
        foreach ( ent in level.activekillstreaks )
        {
            location = ent.origin;
            
            if ( isdefined( ent.streakname ) )
            {
                switch ( ent.streakname )
                {
                    case #"hash_19dd9a3a4147e09e":
                        location += ( 0, 0, 40 );
                        break;
                    case #"hash_ab5712e297cd430e":
                        location += ( 0, 0, 45 );
                        break;
                }
            }
            
            if ( sighttracepassed( vieweye, location, 0, ent, missileent, 1 ) && self worldpointinreticle_circle( location, 65, 50 ) == 1 )
            {
                var_4144b9d42314daed[ var_4144b9d42314daed.size ] = ent;
            }
        }
    }
    
    foreach ( ent in weapons::getactiveequipmentarray() )
    {
        if ( sighttracepassed( vieweye, ent.origin, 0, missileent, undefined, 1 ) && self worldpointinreticle_circle( ent.origin, 65, 50 ) == 1 )
        {
            var_4144b9d42314daed[ var_4144b9d42314daed.size ] = ent;
        }
    }
    
    foreach ( ent in level.grenades )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( sighttracepassed( vieweye, ( ent.origin[ 0 ], ent.origin[ 1 ], ent.origin[ 2 ] + 5 ), 0, missileent, undefined, 1 ) && self worldpointinreticle_circle( ent.origin, 65, 50 ) == 1 )
        {
            var_4144b9d42314daed[ var_4144b9d42314daed.size ] = ent;
        }
    }
    
    var_4144b9d42314daed = arrayremoveduplicates( var_4144b9d42314daed );
    cystcontents = trace::create_contents( 0, 1, 1, 1 );
    
    if ( isdefined( level.brgametype.cysts ) )
    {
        foreach ( cyst in level.brgametype.cysts )
        {
            if ( distancesquared( self.origin, cyst.origin ) <= 640000 )
            {
                if ( self worldpointinreticle_circle( cyst.origin, 65, 90 ) == 1 )
                {
                    cysttrace = trace::ray_trace( vieweye, cyst.origin, missileent, cystcontents, 0, 1, 1 );
                    
                    if ( isdefined( cysttrace[ "scriptable" ] ) && cysttrace[ "scriptable" ].type == "ob_aethernest_cyst_scriptable" )
                    {
                        var_73b3deeb0879f193[ var_73b3deeb0879f193.size ] = cyst;
                    }
                }
            }
        }
    }
    
    if ( level.var_9385f203880b542a )
    {
        var_712acb57695604d3 = level.var_9385f203880b542a;
        
        foreach ( scriptable in var_712acb57695604d3 )
        {
            if ( self worldpointinreticle_circle( scriptable.origin + ( 0, 0, 45 ), 65, 120 ) == 1 )
            {
                var_73b3deeb0879f193 = arraycombineunique( var_73b3deeb0879f193, [ scriptable ] );
            }
        }
    }
    
    if ( var_1f1573de36c02507 )
    {
        if ( level.var_5ee9a89b9f9b984b )
        {
            foreach ( tower in level.uavtowers )
            {
                if ( distancesquared( self.origin, tower.origin + toweroffset ) <= 3841600 )
                {
                    if ( self worldpointinreticle_circle( tower.origin + toweroffset, 65, 90 ) == 1 )
                    {
                        towertrace = trace::ray_trace( vieweye, tower.origin + toweroffset, missileent, undefined, 0, 1, 1 );
                        
                        if ( isdefined( towertrace[ "scriptable" ] ) && towertrace[ "scriptable" ].type == "scriptable_uav_tower" && isdefined( towertrace[ "scriptable" ].var_5b3dbacfeda0fd01 ) )
                        {
                            var_73b3deeb0879f193 = arraycombineunique( var_73b3deeb0879f193, [ towertrace[ "scriptable" ] ] );
                        }
                    }
                }
            }
        }
        
        if ( level.var_c7c34c7053a29846 )
        {
            foreach ( var_77ae4bc307b47e36 in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
            {
                if ( !var_77ae4bc307b47e36.b_occupied )
                {
                    continue;
                }
                
                if ( distancesquared( self.origin, var_77ae4bc307b47e36.origin ) <= 96884649 )
                {
                    if ( self worldpointinreticle_circle( var_77ae4bc307b47e36.origin, 65, 90 ) == 1 )
                    {
                        dronetrace = trace::ray_trace( vieweye, var_77ae4bc307b47e36.origin, missileent, undefined, 0, 1, 1 );
                        
                        if ( isdefined( dronetrace[ "scriptable" ] ) && dronetrace[ "scriptable" ].type == "scriptable_redeploy_drone" && isdefined( dronetrace[ "scriptable" ].var_5b3dbacfeda0fd01 ) )
                        {
                            var_73b3deeb0879f193 = arraycombineunique( var_73b3deeb0879f193, [ dronetrace[ "scriptable" ] ] );
                        }
                    }
                }
            }
        }
        
        if ( level.br_armory_kiosk.var_e253c9f921155d75 )
        {
            foreach ( buystation in level.br_armory_kiosk.scriptables )
            {
                if ( distancesquared( self.origin, buystation.origin ) <= 3841600 )
                {
                    if ( self worldpointinreticle_circle( buystation.origin, 65, 90 ) == 1 )
                    {
                        buystationtrace = trace::ray_trace( vieweye, buystation.origin, missileent, undefined, 0, 1, 1 );
                        
                        if ( isdefined( buystationtrace[ "scriptable" ] ) && buystationtrace[ "scriptable" ].type == "br_plunder_box" && isdefined( buystationtrace[ "scriptable" ].var_5b3dbacfeda0fd01 ) )
                        {
                            var_73b3deeb0879f193 = arraycombineunique( var_73b3deeb0879f193, [ buystationtrace[ "scriptable" ] ] );
                        }
                    }
                }
            }
        }
    }
    
    foreach ( ent in var_4144b9d42314daed )
    {
        if ( ent vehicle::is_vehicle() )
        {
            if ( vehicle::is_friendly_to_player( ent, self ) )
            {
                continue;
            }
            
            if ( getdvarint( @"hash_be23c0cca5ddca69", 1 ) && !ent.israllypointvehicle )
            {
                occupants = vehicle_occupancy::function_8ed9bcd8e9ea74f5( ent, 0 );
                
                if ( occupants.size == 0 )
                {
                    continue;
                }
            }
        }
        
        if ( ent.team == self.team )
        {
            if ( isplayer( ent ) )
            {
                ent notify( #"hash_14e77dae19b2a4c7", self, self.currentprimaryweapon );
            }
            
            if ( level.teambased )
            {
                continue;
            }
        }
        
        if ( isdefined( ent.owner ) && ent.owner.team == self.team && level.teambased )
        {
            continue;
        }
        
        if ( ent.owner == self )
        {
            continue;
        }
        
        if ( var_1f1573de36c02507 )
        {
            if ( isdefined( ent.domflag.trigger.var_5b3dbacfeda0fd01 ) )
            {
                if ( ent.domflag.trigger.stronghold.capturedteam == self.team )
                {
                    continue;
                }
                
                function_70e6402a56144cb( ent.domflag.trigger );
            }
            
            if ( level.var_c7c34c7053a29846 )
            {
                if ( ent.type == "scriptable_redeploy_drone" && isdefined( ent.var_5b3dbacfeda0fd01 ) )
                {
                    function_70e6402a56144cb( ent );
                }
            }
            
            if ( level.deployablekiosks.var_fe3437bbc52ad866 )
            {
                if ( ent.type == "portable_buy_drone" && isdefined( ent.var_5b3dbacfeda0fd01 ) )
                {
                    function_70e6402a56144cb( ent );
                }
            }
            
            if ( level.deployablekiosks.var_e253c9f921155d75 )
            {
                if ( ent.team == self.team )
                {
                    continue;
                }
                
                if ( ent.type == "deployable_buystation" && isdefined( ent.var_5b3dbacfeda0fd01 ) )
                {
                    function_70e6402a56144cb( ent );
                }
            }
        }
        
        if ( isplayer( ent ) )
        {
            ent thread function_b94c4150864e37e0( self, 5 );
            continue;
        }
        
        if ( isagent( ent ) && isdefined( ent.team ) && ent.team != self.team )
        {
            if ( isdefined( ent.unittype ) )
            {
                if ( ent.unittype == "zombie" )
                {
                    ent val::set( "drone_launcher", "pain", 0 );
                    var_ed082010ef0bae61 = getdvarint( @"scr_dronegun_zombie_damage", 40 );
                    ent dodamage( var_ed082010ef0bae61, self.origin, self, self, "MOD_UNKNOWN", self.currentprimaryweapon );
                    ent val::reset( "drone_launcher", "pain" );
                    continue;
                }
                else if ( ent.unittype == "soldier" )
                {
                    var_3279b0f1f67320e6 = getdvarint( @"hash_7cdb49e8f87074af", 20 );
                    ent dodamage( var_3279b0f1f67320e6, self.origin, self, self, "MOD_UNKNOWN", self.currentprimaryweapon );
                    continue;
                }
            }
        }
        
        if ( isdefined( ent.sourcegrenade ) && ent.sourcegrenade.equipmentref == "equip_butterfly_mine" )
        {
            ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
            continue;
        }
        
        if ( isdefined( ent.streakname ) )
        {
            if ( ent.streakname == "radar_drone_recon" )
            {
                ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
            }
            else if ( ent.streakname == "uav" )
            {
                ent dodamage( 250, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
            }
            else if ( ent.streakname == "missile_turret" )
            {
                ent dodamage( 130, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                
                if ( !ent.ishaywire )
                {
                    function_8adbe087aaa1d967( ent );
                    ent thread function_329c7be4ec4d7c23( self );
                }
            }
            else if ( ent.streakname == "assault_drone" )
            {
                ent dodamage( 1, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                data = damage_utility::packdamagedata( self, ent, 1, self.currentprimaryweapon, "MOD_EXPLOSIVE", self );
                ent thread [[ ent.var_5b3dbacfeda0fd01 ]]( data );
                ent thread function_76a4d7f64c69b91a( self );
            }
            else if ( ent.streakname == "lrad" )
            {
                ent dodamage( 250, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                function_8adbe087aaa1d967( ent );
                ent thread function_76a4d7f64c69b91a( self );
            }
            else if ( ent.streakname == "airdrop" )
            {
                ent dodamage( 10, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
            }
            else if ( ent.streakname == "switchblade_drone" )
            {
                function_8adbe087aaa1d967( ent );
                ent thread function_76a4d7f64c69b91a( self );
            }
            else if ( ent.streakname == "scrambler_drone_guard" )
            {
                ent dodamage( 300, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
            }
            else if ( ent.streakname == "cluster_spike" )
            {
                ent dodamage( 100, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
            }
            else if ( ent.streakname == "cruise_predator" )
            {
                ent dodamage( 1, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                
                if ( getdvarint( @"hash_82fc9d1ee58b396", 1 ) == 1 )
                {
                    function_8adbe087aaa1d967( ent );
                    ent thread function_76a4d7f64c69b91a( self );
                }
            }
            else if ( ent.streakname == "bunker_buster" )
            {
                ent dodamage( 1, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                
                if ( getdvarint( @"hash_82fc9d1ee58b396", 1 ) == 1 )
                {
                    function_8adbe087aaa1d967( ent );
                    ent thread function_76a4d7f64c69b91a( self );
                }
            }
            else if ( ent.streakname == "pac_sentry" )
            {
                ent dodamage( 30, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                data = damage_utility::packdamagedata( self, ent, 1, self.currentprimaryweapon, "MOD_EXPLOSIVE", self );
                
                if ( !ent.dronegundisabled )
                {
                    ent thread utility::callsharedfunc( #"pac_sentry", #"pac_sentry_dronegun_emp", data );
                }
            }
            else if ( ent.streakname == "airdrop_escort" )
            {
                ent dodamage( 5, ( 0, 0, 0 ), self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                function_8adbe087aaa1d967( ent );
                data = damage_utility::packdamagedata( self, ent, 1, self.currentprimaryweapon, "MOD_EXPLOSIVE", self );
                function_8adbe087aaa1d967( ent );
                
                if ( utility::issharedfuncdefined( #"airdrop_escort", #"dronegun_emp" ) )
                {
                    ent thread [[ utility::getsharedfunc( #"airdrop_escort", #"dronegun_emp" ) ]]( data, 5 );
                }
            }
            else if ( ent.streakname == "hover_jet" )
            {
                ent dodamage( 5, ( 0, 0, 0 ), self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                data = damage_utility::packdamagedata( self, ent, 1, self.currentprimaryweapon, "MOD_EXPLOSIVE", self );
                
                if ( utility::issharedfuncdefined( #"hover_jet", #"dronegun_emp" ) )
                {
                    ent thread [[ utility::getsharedfunc( #"hover_jet", #"dronegun_emp" ) ]]( data );
                }
            }
            else if ( ent.streakname == "chopper_gunner" )
            {
                ent dodamage( 10, ( 0, 0, 0 ), self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                data = damage_utility::packdamagedata( self, ent, 1, self.currentprimaryweapon, "MOD_EXPLOSIVE", self );
                
                if ( utility::issharedfuncdefined( #"chopper_gunner", #"dronegun_emp" ) )
                {
                    ent thread [[ utility::getsharedfunc( #"chopper_gunner", #"dronegun_emp" ) ]]( data );
                }
            }
            else if ( ent.streakname == "assault_chopper" )
            {
                ent dodamage( 10, ( 0, 0, 0 ), self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                data = damage_utility::packdamagedata( self, ent, 1, self.currentprimaryweapon, "MOD_EXPLOSIVE", self );
                
                if ( utility::issharedfuncdefined( #"assault_chopper", #"dronegun_emp" ) )
                {
                    ent thread [[ utility::getsharedfunc( #"assault_chopper", #"dronegun_emp" ) ]]( data );
                }
            }
            else if ( ent.streakname == "gunship" )
            {
                ent dodamage( 10, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                data = damage_utility::packdamagedata( self, ent, 1, self.currentprimaryweapon, "MOD_EXPLOSIVE", self );
                
                if ( utility::issharedfuncdefined( #"gunship", #"dronegun_emp" ) )
                {
                    ent [[ utility::getsharedfunc( #"gunship", #"dronegun_emp" ) ]]( data );
                }
            }
            else if ( ent.streakname == "remote_turret" )
            {
                ent dodamage( 140, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                function_8adbe087aaa1d967( ent );
                ent thread function_329c7be4ec4d7c23( self );
            }
            else if ( ent.streakname == "drone_swarm" )
            {
                ent dodamage( 50, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
            }
            
            continue;
        }
        
        if ( isdefined( ent.equipmentref ) && arraycontains( weapons::getactiveequipmentarray(), ent ) )
        {
            equipmentname = ent.equipmentref;
            
            if ( issubstr( ent.equipmentref, "_jup" ) )
            {
                equipmentname = removesubstr( equipmentname, "_jup" );
            }
            
            switch ( ent.equipmentref )
            {
                case #"hash_4320d77f90725183":
                    ent dodamage( 1, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_2354208d9af64220":
                    ent dodamage( 1, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_3995658e01f4fac1":
                    ent dodamage( 1, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_c848458cca24d656":
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_cbcb2b145327e750":
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_29972969a98220a1":
                case #"hash_ecd28780631ff043":
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_91076f076ee682f4":
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_1602aabae23dc4b7":
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_1eeb976ed8edf3e2":
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_f4e4d96da65cbe0c":
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_7c09786dbc292c05":
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_b64c903871503d5d":
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_731f922359382673":
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_c613333b4f1bbb78":
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_33dc79aea3c12e98":
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_1a5a56a6fdfa6d6b":
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_4a85ee2b82965fe2":
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                    break;
                case #"hash_15d06a7d7efafe8":
                    ent thread [[ utility::getsharedfunc( #"decoy_grenade", #"dronegun_emp" ) ]]();
                    break;
                default:
                    break;
            }
            
            continue;
        }
        
        if ( isdefined( ent.classname ) )
        {
            if ( ent.classname == "grenade" && isdefined( ent.equipmentref ) )
            {
                if ( ent.equipmentref == "sonar_pulse_mp" )
                {
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                }
                else if ( ent.equipmentref == "equip_breacher_drone" )
                {
                    ent thread [[ level.sharedfuncs[ #"equip_breacher_drone" ][ #"hash_472c7440eb3590e3" ] ]]( 0 );
                }
                else if ( ent.equipmentref == "equip_snapshot_grenade" )
                {
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                }
                else if ( ent.equipmentref == "equip_decoy" )
                {
                    if ( utility::issharedfuncdefined( #"decoy_grenade", #"dronegun_emp" ) )
                    {
                        ent thread [[ utility::getsharedfunc( #"decoy_grenade", #"dronegun_emp" ) ]]();
                    }
                }
                else if ( ent.equipmentref == "equip_shockstick" )
                {
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                }
                else if ( ent.equipmentref == "equip_tracker_grenade" )
                {
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                }
                else if ( ent.equipmentref == "equip_bunkerbuster" )
                {
                    if ( utility::issharedfuncdefined( #"bunkerbuster", #"dronegun_emp" ) )
                    {
                        ent [[ utility::getsharedfunc( #"bunkerbuster", #"dronegun_emp" ) ]]();
                    }
                }
            }
            else if ( ent.classname == "misc_turret" )
            {
                if ( ent.cameratype == "tacCam" )
                {
                    ent dodamage( 9999, self.origin, self, self, "MOD_EXPLOSIVE", self.currentprimaryweapon );
                }
            }
            else if ( ent.classname == "script_vehicle" )
            {
                ent thread function_329c7be4ec4d7c23( self );
            }
            else if ( ent.classname == "script_model" && isdefined( ent.weapon_name ) && ent.weapon_name == "deployed_decoy_mp" )
            {
                ent dodamage( 50, self.origin, self, self, undefined, self.currentprimaryweapon );
            }
            else if ( ent.classname == "script_model" && isdefined( ent.animname ) && ent.animname == "super_smoke_airdrop" )
            {
                ent dodamage( 50, self.origin, self, self, undefined, self.currentprimaryweapon );
            }
            else if ( ent.classname == "scriptable_bomb_01" )
            {
                ent dodamage( 50, self.origin, self, self, undefined, self.currentprimaryweapon );
            }
            else if ( ent.classname == "scriptable_bomb_c4_large_double_01" )
            {
                ent dodamage( 50, self.origin, self, self, undefined, self.currentprimaryweapon );
            }
            
            continue;
        }
        
        if ( ent.animname == "super_smoke_airdrop" )
        {
            data = damage_utility::packdamagedata( self, ent, 1, self.currentprimaryweapon, "MOD_EXPLOSIVE", self );
            empstartcallback = emp_debuff::function_8b41dd5fdf0e0f7a( ent );
            ent thread [[ empstartcallback ]]( data );
        }
    }
    
    foreach ( scriptable in var_73b3deeb0879f193 )
    {
        if ( issubstr( scriptable.classname, "scriptable" ) )
        {
            if ( scriptable.type == "ob_aethernest_cyst_scriptable" )
            {
                scriptable scriptabledodamage( 200, self, self );
                continue;
            }
            
            if ( scriptable.type == "jup_ob_zombie_control_spore" )
            {
                scriptable scriptabledodamage( 200, self, self );
                continue;
            }
            
            if ( scriptable.type == "weapon_testing_plans_dummy" )
            {
                scriptable scriptabledodamage( 1, self, self, ( 0, 0, 0 ), ( 0, 0, 0 ), "MOD_UNKNOWN", self.currentprimaryweapon );
                continue;
            }
            
            if ( var_1f1573de36c02507 )
            {
                if ( scriptable.type == "scriptable_uav_tower" && level.var_5ee9a89b9f9b984b )
                {
                    if ( scriptable.activeteam == self.team )
                    {
                        continue;
                    }
                    
                    function_70e6402a56144cb( scriptable.towerstruct.uav_station );
                    continue;
                }
                
                if ( level.var_c7c34c7053a29846 && scriptable.type == "scriptable_redeploy_drone" )
                {
                    function_70e6402a56144cb( scriptable );
                    continue;
                }
                
                if ( scriptable.type == "br_plunder_box" && level.br_armory_kiosk.var_e253c9f921155d75 )
                {
                    function_70e6402a56144cb( scriptable );
                }
            }
        }
    }
}

// Namespace drone_launcher
// Params 2
// Checksum 0x5a1b85, Offset: 0x280c
// Size: 0x1175
function function_8ad2a1f5e1172a3b( objweapon, missileent )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    viewangles = self getplayerangles();
    vieweye = self geteye();
    playerforward = anglestoforward( viewangles );
    traceendposob = vieweye + playerforward * 3500;
    var_2c798ab30b46a548 = trace::create_contents( 1, 0, 0, 0, 0, 1 );
    waittillframeend();
    var_ece9762f3b06d2d2 = [];
    var_4144b9d42314daed = [];
    var_73b3deeb0879f193 = [];
    var_a87863ebc3f75564 = trace::sphere_trace_get_all_results( vieweye, traceendposob, 60, self, var_2c798ab30b46a548, 0, 1 );
    
    foreach ( result in var_a87863ebc3f75564 )
    {
        if ( isdefined( result[ "entity" ] ) )
        {
            var_ece9762f3b06d2d2[ var_ece9762f3b06d2d2.size ] = result[ "entity" ];
            continue;
        }
        
        if ( isdefined( result[ "scriptable" ] ) )
        {
            if ( sighttracepassed( vieweye, result[ "position" ], 0, undefined, undefined, 1 ) )
            {
                var_73b3deeb0879f193[ var_73b3deeb0879f193.size ] = result[ "scriptable" ];
            }
        }
    }
    
    var_cc0046911764f879 = 0;
    sortbydistance( var_ece9762f3b06d2d2, self.origin );
    
    foreach ( entdetected in var_ece9762f3b06d2d2 )
    {
        if ( entdetected.team == self.team )
        {
            continue;
        }
        
        if ( isdefined( entdetected.owner ) && entdetected.owner.team == self.team )
        {
            continue;
        }
        
        if ( isdefined( level.var_c8ab615737888686 ) && arraycontains( level.var_c8ab615737888686, entdetected ) )
        {
            continue;
        }
        
        if ( var_cc0046911764f879 < 4 )
        {
            if ( isdefined( entdetected ) )
            {
                hitlocation = entdetected getcentroid();
                hitlocation = ( hitlocation[ 0 ], hitlocation[ 1 ], hitlocation[ 2 ] + entdetected getboundshalfsize()[ 2 ] );
            }
            
            if ( sighttracepassed( vieweye, hitlocation, 0, entdetected, undefined, 1 ) )
            {
                var_4144b9d42314daed[ var_4144b9d42314daed.size ] = entdetected;
                var_cc0046911764f879++;
            }
        }
    }
    
    cystcontents = trace::create_contents( 0, 1, 1, 1 );
    
    if ( isdefined( level.ob.cysts ) )
    {
        foreach ( cyst in level.ob.cysts )
        {
            if ( !( isdefined( cyst ) && isdefined( cyst.origin ) ) )
            {
                continue;
            }
            
            if ( isdefined( cyst.s_cyst ) )
            {
                vup = anglestoup( cyst.s_cyst.angles );
                var_39c4ee2fe90f4842 = cyst.origin + vup * 10;
            }
            else
            {
                var_39c4ee2fe90f4842 = cyst.origin;
            }
            
            if ( distancesquared( self.origin, var_39c4ee2fe90f4842 ) <= 12250000 )
            {
                if ( self worldpointinreticle_circle( var_39c4ee2fe90f4842, 65, 90 ) == 1 )
                {
                    cysttrace = trace::ray_trace( vieweye, var_39c4ee2fe90f4842, missileent, cystcontents, 0, 1, 1 );
                    
                    if ( isdefined( cysttrace[ "scriptable" ] ) && cysttrace[ "scriptable" ].type == "ob_aethernest_cyst_scriptable" )
                    {
                        var_73b3deeb0879f193[ var_73b3deeb0879f193.size ] = cyst;
                    }
                }
            }
        }
    }
    
    if ( isdefined( level.ob.spores ) )
    {
        foreach ( spore in level.ob.spores )
        {
            if ( spore.shielded_state == "inactive" && isdefined( spore.shield ) )
            {
                shield = spore.shield;
                var_13b775363699f56c = ( shield.origin[ 0 ], shield.origin[ 1 ], shield.origin[ 2 ] + 30 );
                
                if ( distancesquared( self.origin, var_13b775363699f56c ) <= 12250000 )
                {
                    if ( self worldpointinreticle_circle( var_13b775363699f56c, 65, 100 ) == 1 )
                    {
                        if ( sighttracepassed( vieweye, var_13b775363699f56c, 0, shield, missileent, 1 ) )
                        {
                            var_4144b9d42314daed[ var_4144b9d42314daed.size ] = shield;
                        }
                    }
                }
            }
        }
    }
    
    if ( isdefined( level.activekillstreaks ) )
    {
        foreach ( ent in level.activekillstreaks )
        {
            if ( ent.team == self.team )
            {
                continue;
            }
            
            if ( isdefined( ent.owner ) && ent.owner.team == self.team )
            {
                continue;
            }
            
            if ( distancesquared( self.origin, ent.origin ) <= 12250000 )
            {
                if ( sighttracepassed( vieweye, ent.origin, 0, ent, missileent, 1 ) && self worldpointinreticle_circle( ent.origin, 65, 50 ) == 1 )
                {
                    var_4144b9d42314daed[ var_4144b9d42314daed.size ] = ent;
                }
            }
        }
    }
    
    foreach ( ent in weapons::getactiveequipmentarray() )
    {
        if ( ent.team == self.team )
        {
            continue;
        }
        
        if ( isdefined( ent.owner ) && ent.owner.team == self.team )
        {
            continue;
        }
        
        entdistsq = distancesquared( self.origin, ent.origin );
        
        if ( entdistsq > 12250000 )
        {
            continue;
        }
        
        if ( entdistsq > 160000 && !sighttracepassed( vieweye, ent.origin, 0, ent, missileent, 1 ) )
        {
            continue;
        }
        
        if ( self worldpointinreticle_circle( ent.origin, 65, 50 ) == 1 )
        {
            var_4144b9d42314daed[ var_4144b9d42314daed.size ] = ent;
        }
    }
    
    foreach ( ent in level.grenades )
    {
        if ( !isdefined( ent ) )
        {
            continue;
        }
        
        if ( ent.team == self.team )
        {
            continue;
        }
        
        if ( isdefined( ent.owner ) && ent.owner.team == self.team )
        {
            continue;
        }
        
        var_2b492b196ee51090 = ( ent.origin[ 0 ], ent.origin[ 1 ], ent.origin[ 2 ] + 15 );
        entdistsq = distancesquared( self.origin, var_2b492b196ee51090 );
        
        if ( entdistsq > 12250000 )
        {
            continue;
        }
        
        if ( entdistsq > 160000 && !sighttracepassed( vieweye, var_2b492b196ee51090, 0, ent, missileent, 1 ) )
        {
            continue;
        }
        
        if ( self worldpointinreticle_circle( var_2b492b196ee51090, 65, 50 ) == 1 )
        {
            var_4144b9d42314daed[ var_4144b9d42314daed.size ] = ent;
        }
    }
    
    if ( isdefined( level.supportdrones ) )
    {
        foreach ( drone in level.supportdrones )
        {
            if ( distancesquared( self.origin, drone.origin ) <= 12250000 )
            {
                if ( sighttracepassed( vieweye, drone.origin, 0, drone, missileent, 1 ) )
                {
                    if ( self worldpointinreticle_circle( drone.origin, 65, 90 ) == 1 )
                    {
                        var_4144b9d42314daed[ var_4144b9d42314daed.size ] = drone;
                    }
                }
            }
        }
    }
    
    if ( isdefined( level.aisentryturrets.spawnedturrets ) )
    {
        foreach ( sentry in level.aisentryturrets.spawnedturrets )
        {
            var_5be75d7b2d92fe = ( sentry.origin[ 0 ], sentry.origin[ 1 ], sentry.origin[ 2 ] + 30 );
            
            if ( distancesquared( self.origin, var_5be75d7b2d92fe ) <= 12250000 )
            {
                if ( sighttracepassed( vieweye, var_5be75d7b2d92fe, 0, sentry, missileent, 1 ) )
                {
                    if ( self worldpointinreticle_circle( var_5be75d7b2d92fe, 65, 120 ) == 1 )
                    {
                        var_4144b9d42314daed[ var_4144b9d42314daed.size ] = sentry;
                    }
                }
            }
        }
    }
    
    if ( isdefined( level.ob.warlord_activity_instances ) )
    {
        foreach ( warlord_activity in level.ob.warlord_activity_instances )
        {
            if ( isdefined( warlord_activity.sentries ) )
            {
                foreach ( sentry in warlord_activity.sentries )
                {
                    if ( isalive( sentry ) )
                    {
                        var_5be75d7b2d92fe = ( sentry.origin[ 0 ], sentry.origin[ 1 ], sentry.origin[ 2 ] + 60 );
                        
                        if ( distancesquared( self.origin, var_5be75d7b2d92fe ) <= 12250000 )
                        {
                            if ( sighttracepassed( vieweye, var_5be75d7b2d92fe, 0, sentry, missileent, 1 ) )
                            {
                                if ( self worldpointinreticle_circle( var_5be75d7b2d92fe, 65, 120 ) == 1 )
                                {
                                    var_4144b9d42314daed[ var_4144b9d42314daed.size ] = sentry;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    if ( isdefined( level.ob.harvesterorbs ) )
    {
        foreach ( var_8f06a9888ecac17 in level.ob.harvesterorbs )
        {
            if ( isdefined( var_8f06a9888ecac17.move ) )
            {
                harvesterorb = var_8f06a9888ecac17.move;
                orborigin = harvesterorb.origin;
                
                if ( distancesquared( self.origin, orborigin ) <= 12250000 )
                {
                    if ( sighttracepassed( vieweye, orborigin, 0, harvesterorb, missileent, 1 ) )
                    {
                        if ( self worldpointinreticle_circle( orborigin, 65, 120 ) == 1 )
                        {
                            var_4144b9d42314daed[ var_4144b9d42314daed.size ] = harvesterorb;
                        }
                    }
                }
            }
        }
    }
    
    var_4144b9d42314daed = arrayremoveduplicates( var_4144b9d42314daed );
    var_4144b9d42314daed = sortbydistance( var_4144b9d42314daed, self.origin );
    dronegunweapon = self.currentprimaryweapon;
    damageorigin = self.origin;
    
    foreach ( ent in var_4144b9d42314daed )
    {
        if ( ent.team == self.team )
        {
            continue;
        }
        
        if ( isdefined( ent.owner ) && ent.owner.team == self.team )
        {
            continue;
        }
        
        if ( isagent( ent ) && isdefined( ent.team ) && ent.team != self.team )
        {
            if ( isdefined( ent.unittype ) )
            {
                if ( ent.unittype == "zombie" )
                {
                    var_ed082010ef0bae61 = getdvarint( @"scr_dronegun_zombie_damage", 40 );
                    ent thread function_404c6187c623e7c7( var_ed082010ef0bae61, self, damageorigin, dronegunweapon, 1 );
                    continue;
                }
                else if ( ent.unittype == "soldier" )
                {
                    var_3279b0f1f67320e6 = getdvarint( @"hash_7cdb49e8f87074af", 20 );
                    ent thread function_404c6187c623e7c7( var_3279b0f1f67320e6, self, damageorigin, dronegunweapon, 0 );
                    continue;
                }
            }
        }
        else if ( isdefined( ent.classname ) )
        {
            if ( ent.classname == "script_vehicle" )
            {
                if ( ent.helperdronetype == "scrambler_drone_guard" )
                {
                    ent dodamage( 250, damageorigin, self, self, "MOD_EXPLOSIVE", dronegunweapon );
                    continue;
                }
                else if ( isdefined( ent.knight_ai ) )
                {
                    ent dodamage( 25, damageorigin, self, self, "MOD_EXPLOSIVE", dronegunweapon );
                    ent thread function_329c7be4ec4d7c23( self );
                    continue;
                }
                else if ( isdefined( ent.subclass ) && issubstr( ent.subclass, "helicopter" ) )
                {
                    ent dodamage( 275, damageorigin, self, self, "MOD_EXPLOSIVE", dronegunweapon );
                    continue;
                }
                else if ( ent.targetname == "remote_tank" )
                {
                    ent dodamage( 275, damageorigin, self, self, "MOD_EXPLOSIVE", dronegunweapon );
                    ent thread function_329c7be4ec4d7c23( self );
                    continue;
                }
                else if ( haywire::function_8238cd34bd133b52( ent ) )
                {
                    ent thread function_329c7be4ec4d7c23( self );
                }
            }
            else if ( ent.classname == "grenade" )
            {
                ent dodamage( 200, damageorigin, self, self, "MOD_EXPLOSIVE", dronegunweapon );
            }
            else if ( ent.classname == "misc_turret" )
            {
                ent dodamage( 200, damageorigin, self, self, "MOD_EXPLOSIVE", dronegunweapon );
                ent thread function_c03d903017d7d60a();
            }
        }
        
        ent dodamage( 200, self.origin, self, self, "MOD_EXPLOSIVE", dronegunweapon );
    }
    
    foreach ( scriptable in var_73b3deeb0879f193 )
    {
        if ( scriptable.classname == "scriptable" )
        {
            if ( scriptable.type == "ob_aethernest_cyst_scriptable" )
            {
                scriptable scriptabledodamage( 300, self, self );
            }
        }
    }
}

// Namespace drone_launcher
// Params 1
// Checksum 0xc99c473f, Offset: 0x3989
// Size: 0x59
function function_70e6402a56144cb( ent )
{
    data = spawnstruct();
    data.time = 5;
    data.attacker = self;
    data.reason = "STORMENDER";
    ent thread [[ ent.var_5b3dbacfeda0fd01 ]]( data );
}

// Namespace drone_launcher
// Params 1
// Checksum 0xb820d66a, Offset: 0x39ea
// Size: 0x94
function function_76a4d7f64c69b91a( attackingplayer )
{
    level endon( #"game_ended" );
    self notify( #"hash_cbd8939cd5d73a8d" );
    self endon( #"hash_cbd8939cd5d73a8d" );
    data = damage_utility::packdamagedata( attackingplayer, self, 1, attackingplayer.currentprimaryweapon, "MOD_EXPLOSIVE", attackingplayer );
    
    if ( isdefined( self.ksempapplycallback ) )
    {
        self thread [[ self.ksempapplycallback ]]( data );
    }
    
    wait 5;
    
    if ( isdefined( self.ksempclearcallback ) )
    {
        self thread [[ self.ksempclearcallback ]]( data );
    }
}

// Namespace drone_launcher
// Params 1
// Checksum 0x6401988b, Offset: 0x3a86
// Size: 0x99
function function_329c7be4ec4d7c23( attackingplayer )
{
    level endon( #"game_ended" );
    self notify( #"hash_cbd8939cd5d73a8d" );
    self endon( #"hash_cbd8939cd5d73a8d" );
    data = damage_utility::packdamagedata( attackingplayer, self, 1, attackingplayer.currentprimaryweapon, "MOD_EXPLOSIVE", attackingplayer );
    var_3166aa89082d16f4 = haywire::function_8238cd34bd133b52( self );
    
    if ( isdefined( var_3166aa89082d16f4 ) )
    {
        self thread [[ var_3166aa89082d16f4 ]]( data );
    }
    
    wait 5;
    var_daaf54b453aef55c = haywire::function_57b88bc7394677d8( self );
    
    if ( var_daaf54b453aef55c )
    {
        self thread [[ var_daaf54b453aef55c ]]( data );
    }
}

// Namespace drone_launcher
// Params 1
// Checksum 0x922cbd2, Offset: 0x3b27
// Size: 0x74
function function_8adbe087aaa1d967( killstreakent )
{
    if ( !isdefined( self.var_470a8b529432a2c6 ) )
    {
        self.var_470a8b529432a2c6 = [];
    }
    
    self.var_470a8b529432a2c6 = function_5713d46873b29625( self.var_470a8b529432a2c6 );
    
    if ( !arraycontains( self.var_470a8b529432a2c6, killstreakent ) )
    {
        self.var_470a8b529432a2c6[ self.var_470a8b529432a2c6.size ] = killstreakent;
        thread killstreaks::givescoreforempedkillstreak();
        thread function_858034a8524f60f1( killstreakent, 3 );
    }
}

// Namespace drone_launcher
// Params 2
// Checksum 0xe704ad90, Offset: 0x3ba3
// Size: 0x5c
function function_858034a8524f60f1( killstreakent, timer )
{
    level endon( #"game_ended" );
    wait timer;
    
    if ( isdefined( self.var_470a8b529432a2c6 ) && arraycontains( self.var_470a8b529432a2c6, killstreakent ) )
    {
        self.var_470a8b529432a2c6 = arrayremove( self.var_470a8b529432a2c6, killstreakent );
    }
}

// Namespace drone_launcher
// Params 0
// Checksum 0x119524b5, Offset: 0x3c07
// Size: 0x63
function function_c03d903017d7d60a()
{
    self endon( #"death" );
    self setmode( "sentry_offline" );
    playfxontag( utility::getfx( "sentry_gun_stun_fx" ), self, "tag_aim_pivot" );
    self laseroff();
    wait 2;
    stopfxontag( level._effect[ "sentry_gun_stun_fx" ], self, "tag_aim_pivot" );
    self setmode( "sentry" );
    self laseron();
}

// Namespace drone_launcher
// Params 5
// Checksum 0xdcaa6aba, Offset: 0x3c72
// Size: 0x93
function function_404c6187c623e7c7( damage, attacker, origin, weapon, shouldallowpain )
{
    self endon( #"death" );
    throttle::throttle_wait_in_queue( level.var_2b4420abc0ce551c, self );
    
    if ( isdefined( attacker ) )
    {
        if ( shouldallowpain )
        {
            val::set( "drone_launcher", "pain", 0 );
        }
        
        self dodamage( damage, origin, attacker, attacker, "MOD_UNKNOWN", weapon );
        
        if ( shouldallowpain )
        {
            val::reset( "drone_launcher", "pain" );
        }
    }
}

// Namespace drone_launcher
// Params 2
// Checksum 0xa89528ce, Offset: 0x3d0d
// Size: 0x19e
function function_b94c4150864e37e0( attacker, time )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( isplayer( self ) && ( isdefined( self.perks[ "specialty_emp_immunity" ] ) || isdefined( self.perks[ "specialty_empimmune" ] ) ) && isenemyteam( attacker.team, self.team ) )
    {
        return;
    }
    
    self dodamage( 1, self.origin, attacker, attacker, "MOD_EXPLOSIVE", attacker.currentprimaryweapon, undefined, undefined );
    
    if ( emp_debuff::can_be_empd() == 1 && !self.var_3edfd0e6cc4a1686 )
    {
        attacker thread killstreaks::givescoreforempedplayer();
        
        if ( utility::issharedfuncdefined( #"emp", #"watch_checkforlauncherweapons" ) )
        {
            self thread [[ utility::getsharedfunc( #"emp", #"watch_checkforlauncherweapons" ) ]]();
        }
        
        self notify( #"emp_started" );
        self notify( #"emp_applied" );
        self.var_3edfd0e6cc4a1686 = 1;
        thread emp_debuff::function_2eb2a0b9290e24a7( self, 2 );
        
        if ( isdefined( self.ksempapplycallback ) )
        {
            self thread [[ self.ksempapplycallback ]]();
        }
    }
    else
    {
        return;
    }
    
    wait time;
    self.var_3edfd0e6cc4a1686 = undefined;
    self notify( #"dronegun_emp_cleared" );
    
    if ( !isdefined( self.var_c7dc16398800176e ) )
    {
        self notify( #"emp_cleared" );
        self notify( #"hash_f226fff401336173" );
        
        if ( isdefined( self.ksempclearcallback ) )
        {
            self [[ self.ksempclearcallback ]]();
        }
    }
}

