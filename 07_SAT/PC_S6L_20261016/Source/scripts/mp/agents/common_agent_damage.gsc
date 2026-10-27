// scripts\mp\agents\common_agent_damage.gsc  (hash_1069786fefca321e.gscc) (size: 12469 Bytes / 0x30b5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x286315fa (677582330)
// size ...... 12469 (0x30b5)
// includes .. 12  (offset: 0x2d1d)
// strings ... 42  (offset: 0x2d7d)
// dev strs .. 21  (offset: 0x2fb9)
// exports ... 13  (offset: 0x212d)
// cseg ...... 0x371 + 0x1dbc (0x212d)
// imports ... 80  (offset: 0x2335)
// animtree1 . 0   (offset: 0x30b5)
// animtree2 . 0   (offset: 0x30b5)
#using scripts\common\ai\stealth\utility;
#using scripts\common\debug;
#using scripts\common\shellshock_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_collision;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\armor;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\weapon_utility;

#namespace common_agent_damage;

// Namespace common_agent_damage
// Params 14
// Checksum 0x9bea2e0, Offset: 0x38f
// Size: 0xf8
function callbacksoldieragentdamaged( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    if ( isdefined( self.agent_damage_callback ) )
    {
        idamage = self [[ self.agent_damage_callback ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage );
    }
    
    if ( isdefined( self.callbackdamaged ) )
    {
        [[ self.callbackdamaged ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage );
        return;
    }
    
    common_callbacksoldieragentdamaged( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage );
}

// Namespace common_agent_damage
// Params 2
// Checksum 0x194aeed8, Offset: 0x48f
// Size: 0x64
function function_102097d97d5a0a21( objweapon, idamage )
{
    if ( !isdefined( objweapon ) )
    {
        return idamage;
    }
    
    class = weaponclass( objweapon );
    
    if ( class == "spread" )
    {
        idamagemax = getdvarint( @"hash_877c52caf0f9aa8c", 35 );
        idamage = int( min( idamage, idamagemax ) );
    }
    
    return idamage;
}

// Namespace common_agent_damage
// Params 0, eflags: 0x4
// Checksum 0xfdc35911, Offset: 0x4fc
// Size: 0x3a, Type: bool
function private function_420b8133184e3b50()
{
    self.health += 1;
    
    if ( self.bonus_health )
    {
        self.bonus_health += 1;
    }
    
    return true;
}

// Namespace common_agent_damage
// Params 14
// Checksum 0x4b465128, Offset: 0x53f
// Size: 0xe88
function common_callbacksoldieragentdamaged( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    evictim = self;
    initial_damage = idamage;
    armordelta = 0;
    helmetdelta = 0;
    shouldoneshot = damage_shouldoneshot( objweapon );
    unmodifieddamage = idamage;
    
    if ( !einflictor.var_54c212c5a054f834 && function_2e9c95b91f02d7ea( evictim, eattacker, einflictor, smeansofdeath, objweapon ) )
    {
        return;
    }
    
    if ( !function_e156111d9c0dfc5( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon ) )
    {
        return;
    }
    
    if ( handleriotshielddamage( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon ) )
    {
        return;
    }
    
    if ( smeansofdeath == "MOD_TRIGGER_HURT" )
    {
        if ( isdefined( eattacker ) && eattacker.spawnflags & 2 )
        {
            return;
        }
    }
    
    isplayerdamage = isplayer( eattacker );
    var_63b931cba592af5d = isdefined( eattacker ) && isplayer( eattacker.owner );
    isplayervehicle = isdefined( eattacker ) && eattacker.classname == "script_vehicle" && isplayer( eattacker.owner );
    isplayervehicledamage = isplayervehicle && smeansofdeath == "MOD_CRUSH";
    
    if ( isdefined( evictim.forcehitlocation ) )
    {
        shitloc = evictim.forcehitlocation;
        evictim.forcehitlocation = undefined;
    }
    
    if ( isplayervehicledamage )
    {
        rangeauto = getdvarfloat( @"hash_e58868d4f3626e25", 500 );
        rangesight = getdvarfloat( @"hash_4ca14712d81d0747", 1500 );
        rangeperipheral = getdvarfloat( @"hash_6a6df8e4b30834a2", 1800 );
        
        if ( isdefined( self.stealth ) )
        {
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
        }
        
        if ( !isdefined( rangeauto ) )
        {
            rangeauto = 480;
        }
        
        if ( !isdefined( rangesight ) )
        {
            rangesight = 1200;
        }
        
        if ( !isdefined( rangeperipheral ) )
        {
            rangeperipheral = 1500;
        }
        
        if ( idamage >= self.health )
        {
            stealtheventbroadcast( "ally_hurt_peripheral", self, eattacker.owner, rangeauto, rangeperipheral );
            stealtheventbroadcast( "ally_killed", self, eattacker.owner, rangeauto, rangesight );
        }
    }
    
    if ( utility::issharedfuncdefined( #"gulag", #"hash_a25c970e11ea1746" ) )
    {
        [[ utility::getsharedfunc( #"gulag", #"hash_a25c970e11ea1746" ) ]]( eattacker, idamage );
    }
    
    if ( smeansofdeath == "MOD_CRUSH" && isdefined( einflictor ) && isdefined( einflictor.var_b1e7f946abc78a83 ) )
    {
        idamage = einflictor.var_b1e7f946abc78a83;
    }
    
    if ( getdvarint( @"hash_f40118cb927a0802", 0 ) == 1 )
    {
        idamage = function_102097d97d5a0a21( objweapon, idamage );
    }
    
    headshot = damage_utility::isheadshot( shitloc, smeansofdeath, eattacker );
    
    if ( isplayer( eattacker ) && isdefined( objweapon ) && isdefined( objweapon.basename ) && ( objweapon.basename == "throwingknife_mp" || objweapon.basename == "throwingknife_cp" || objweapon.basename == "shuriken_mp" || objweapon.basename == "throwstar_mp" ) )
    {
        shouldoneshot = istrue( self.var_2517193969180a2e );
        var_a2d76fef7c09dc25 = istrue( self.var_7a6a03beaa00d46c );
        idamage = shouldoneshot ? int( max( 400, self.health + self.armorhealth ) ) : 400;
        
        if ( var_a2d76fef7c09dc25 )
        {
            idamage = var_a2d76fef7c09dc25 ? int( max( 400, self.health / 2 + self.armorhealth / 2 ) ) : 400;
        }
    }
    
    if ( isexplosivedamagemod( smeansofdeath ) )
    {
        if ( utility::issharedfuncdefined( #"thermobaric_grenade", #"thermobaric_additional_explosive_damage" ) )
        {
            idamage += [[ utility::getsharedfunc( #"thermobaric_grenade", #"thermobaric_additional_explosive_damage" ) ]]( evictim, eattacker, idamage );
        }
        
        if ( vehicle::isvehicleweapon( objweapon ) )
        {
            idamage *= 2;
        }
    }
    
    islieutenant = self.bossinstance.bundle.islieutenant;
    var_7c053741bb4c8d3d = headshot && einflictor.headshot_damage_armor.size > 0;
    
    if ( ( !headshot || islieutenant || var_7c053741bb4c8d3d ) && isdefined( self.armorhealth ) && self.armorhealth > 0 && smeansofdeath != "MOD_CRUSH" && ( !isdefined( self.var_f424a6135c1dd01f ) || !( isdefined( einflictor ) && arraycontains( self.var_f424a6135c1dd01f, einflictor ) ) ) )
    {
        [ idamage, lightarmordamage ] = armor::function_4875d04d69b22ae( eattacker, einflictor, evictim, idamage, objweapon, smeansofdeath, shitloc, idflags, initial_damage, unmodifieddamage );
        armordelta = lightarmordamage;
        
        if ( idamage <= 0 && armordelta > 0 )
        {
            idamage = function_420b8133184e3b50();
        }
    }
    
    if ( headshot && !islieutenant && smeansofdeath != "MOD_CRUSH" && !damage_utility::function_9144ab79884c5758( objweapon ) )
    {
        hashelmet = self.helmethealth && self.helmethealth > 0;
        
        if ( hashelmet )
        {
            if ( self.var_3286ca1ac5a94fb )
            {
                helmetdelta = idamage;
                armor::damagehelmet_agent( idamage, 0, eattacker );
                idamage = function_420b8133184e3b50();
            }
            else
            {
                helmetdelta = 1;
                var_63a4a8e4100245fd = 0;
                
                if ( !self.var_4ed7c05ebd0e5d04 )
                {
                    if ( utility::getdamagetype( smeansofdeath ) == #"splash" )
                    {
                        var_63a4a8e4100245fd = 1;
                    }
                    
                    if ( ( sweapon.classname == "sniper" || sweapon.classname == "dmr" ) && idamage > 1000 || sweapon.classname == "turret" )
                    {
                        if ( self.helmethealth == 1 )
                        {
                            var_63a4a8e4100245fd = 1;
                        }
                        
                        if ( self.tier == 3 && getweaponhasperk( sweapon, "specialty_super_sniper" ) )
                        {
                            var_63a4a8e4100245fd = 1;
                        }
                        
                        helmetdelta = self.helmethealth;
                    }
                }
                
                armor::damagehelmet_agent( helmetdelta, 0, eattacker );
                
                if ( !var_63a4a8e4100245fd )
                {
                    idamage = function_420b8133184e3b50();
                }
            }
        }
    }
    
    if ( armordelta == 0 && helmetdelta == 0 && utility::isbulletdamage( smeansofdeath ) && headshot )
    {
        if ( !self.var_87db68283cfc14fb )
        {
            idamage = int( max( idamage, self.health ) );
        }
    }
    
    if ( shouldoneshot || self.tier == 2 && getweaponhasperk( sweapon, "specialty_super_sniper" ) )
    {
        idamage = self.health;
    }
    
    if ( utility::issharedfuncdefined( #"relics", #"modify_agent_damage" ) )
    {
        idamage = self [[ utility::getsharedfunc( #"relics", #"modify_agent_damage" ) ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon );
    }
    
    armorhit = armordelta > 0;
    helmethit = helmetdelta > 0;
    
    if ( armorhit || helmethit )
    {
        idflags |= 512;
    }
    
    if ( armor::armorvest_wasbroke( eattacker ) )
    {
        idflags |= 1024;
    }
    
    if ( getdvarint( @"scr_agent_hitmarkers", 1 ) == 1 || evictim.agentdamagefeedback )
    {
        lightarmordamage = 0;
        heavyarmordamage = 0;
        
        if ( utility::issharedfuncdefined( #"damage", #"hash_d6fbc570c8d76b1b" ) )
        {
            lightarmordamage = [[ utility::getsharedfunc( #"damage", #"hash_d6fbc570c8d76b1b" ) ]]( evictim, initial_damage, armordelta, helmetdelta );
        }
        
        iskillstreakweapon = 0;
        
        if ( utility::issharedfuncdefined( #"killstreak", #"iskillstreakweapon" ) )
        {
            iskillstreakweapon = isdefined( objweapon ) && [[ utility::getsharedfunc( #"killstreak", #"iskillstreakweapon" ) ]]( objweapon.basename );
        }
        
        if ( utility::issharedfuncdefined( #"damage", #"hash_f1088336953cf1b9" ) )
        {
            var_f4a1b0f43f51a2b = utility::getsharedfunc( #"damage", #"hash_f1088336953cf1b9" );
            [[ var_f4a1b0f43f51a2b ]]( einflictor, eattacker, evictim, idamage, smeansofdeath, objweapon, shitloc, idflags, lightarmordamage, heavyarmordamage, iskillstreakweapon, undefined, partname, vpoint );
        }
    }
    
    /#
        weapon_utility::function_926700ffa3fbe9e( idamage, eattacker, evictim, smeansofdeath, shitloc, einflictor, vpoint, armordelta, undefined, helmetdelta );
    #/
    
    if ( evictim.gulagjailer )
    {
        jailerdamage = idamage + armordelta;
        self function_49daa55d713fa879( jailerdamage, eattacker, vdir, vpoint );
        
        if ( isdefined( level.var_f72c8182909c4d ) )
        {
            evictim [[ level.var_f72c8182909c4d ]]( jailerdamage );
        }
    }
    
    if ( eattacker )
    {
        eattacker notify( #"hash_3a789df9d545be13", evictim, einflictor, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc );
    }
    
    if ( isplayerdamage || var_63b931cba592af5d || isplayervehicledamage )
    {
        if ( isdefined( objweapon ) )
        {
            attacker = eattacker;
            
            if ( var_63b931cba592af5d )
            {
                attacker = eattacker.owner;
            }
            
            attacker.pers[ "lastDamageTime" ] = gettime();
            
            if ( isdefined( level.var_74bfb03ca7119ccb ) )
            {
                [[ level.var_74bfb03ca7119ccb ]]( self, attacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, timeoffset, smeansofdeath, lightarmordamage );
            }
            
            var_32dbca3143d9c4a5 = level.sharedfuncs[ #"player" ][ #"hash_7d17db29e2bca918" ];
            
            if ( isdefined( var_32dbca3143d9c4a5 ) )
            {
                attacker thread [[ var_32dbca3143d9c4a5 ]]( objweapon, einflictor, evictim, shitloc, idamage, undefined, smeansofdeath );
            }
            
            if ( isplayer( attacker ) )
            {
                var_23646deaadab01d3 = int( min( idamage, self.health ) );
                
                if ( utility::issharedfuncdefined( #"weaponstats", #"hash_18a9fe38dc1a6794" ) )
                {
                    attacker thread [[ utility::getsharedfunc( #"weaponstats", #"hash_18a9fe38dc1a6794" ) ]]( objweapon, var_23646deaadab01d3, "damage", self );
                }
            }
        }
    }
    
    if ( isdefined( sweapon ) && !sweapon issilenced() )
    {
        evictim.lastnonsilenceddamagetime = gettime();
    }
    
    if ( isdefined( level.battlechatter ) && utility::isbulletdamage( smeansofdeath ) && isalive( evictim ) )
    {
        addbattlechatternotify( evictim, undefined, "wounded" );
    }
    
    var_9daaa0931ca67025 = utility::getsharedfunc( #"damage", #"hash_b1aa5806d45b6c8" );
    
    if ( isfunction( var_9daaa0931ca67025 ) )
    {
        self [[ var_9daaa0931ca67025 ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon );
    }
    
    /#
        if ( getdvarint( @"g_debugdamage" ) != 0 )
        {
            if ( idamage != initial_damage )
            {
                println( "<dev string:x24>" + idamage );
            }
        }
        
        if ( getdvarint( @"hash_81d89e4abec64203", 0 ) != 0 )
        {
            dmg_data = [];
            dmg_data[ "<dev string:x38>" ] = einflictor;
            dmg_data[ "<dev string:x43>" ] = eattacker;
            dmg_data[ "<dev string:x4d>" ] = idamage;
            dmg_data[ "<dev string:x55>" ] = smeansofdeath;
            dmg_data[ "<dev string:x63>" ] = sweapon;
            dmg_data[ "<dev string:x6b>" ] = vpoint;
            dmg_data[ "<dev string:x72>" ] = vdir;
            dmg_data[ "<dev string:x77>" ] = shitloc;
            dmg_data[ "<dev string:x7f>" ] = objweapon;
            dmg_data[ "<dev string:x89>" ] = partname;
            debug::debug_print_damage( dmg_data, initial_damage, 1 );
        }
    #/
    
    if ( isdefined( evictim.unittype ) && isdefined( level.agent_funcs[ evictim.unittype ][ "on_damaged_finished" ] ) )
    {
        evictim [[ level.agent_funcs[ evictim.unittype ][ "on_damaged_finished" ] ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0, modelindex, partname, poisedamage, armorhit );
    }
    else
    {
        if ( !isdefined( evictim.agent_type ) )
        {
            assertmsg( "<dev string:x92>" + evictim getentitynumber() + "<dev string:xb8>" + evictim.classname + "<dev string:xc9>" + isalive( evictim ) + "<dev string:xd7>" + evictim.isactive );
            return;
        }
        
        if ( !isdefined( level.agent_funcs[ evictim.agent_type ][ "on_damaged_finished" ] ) )
        {
            assertmsg( "<dev string:xe6>" + evictim.agent_type );
            return;
        }
        
        evictim [[ level.agent_funcs[ evictim.agent_type ][ "on_damaged_finished" ] ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0, modelindex, partname, poisedamage, armorhit );
    }
    
    if ( evictim utility::is_investigating() || evictim utility::is_hunting() )
    {
        evictim utility::callsharedfunc( #"quickkill", #"hash_999e397b8bdb47c5", evictim );
    }
    
    if ( smeansofdeath == "MOD_MELEE" && idamage > 10 && isplayer( einflictor ) )
    {
        if ( einflictor getcamerathirdperson() )
        {
            einflictor thread shellshock_utility::bloodmeleeeffect( sweapon, vpoint );
        }
        else
        {
            einflictor thread shellshock_utility::bloodmeleeeffect( sweapon );
        }
        
        einflictor playrumbleonentity( "defaultweapon_melee" );
    }
}

// Namespace common_agent_damage
// Params 1
// Checksum 0xe54f8b27, Offset: 0x13cf
// Size: 0x6c
function damage_isexplosive( smeansofdeath )
{
    if ( !isdefined( smeansofdeath ) )
    {
        return 0;
    }
    
    switch ( smeansofdeath )
    {
        case #"hash_3c20f39c73a1422b":
        case #"hash_571e46e17a3cf2e3":
        case #"hash_66cb246f3e55fbe2":
        case #"hash_a911a1880d996edb":
        case #"hash_c22b13f81bed11f0":
            return 1;
        default:
            return 0;
    }
}

// Namespace common_agent_damage
// Params 5
// Checksum 0x72723d0, Offset: 0x1443
// Size: 0x22f
function function_2e9c95b91f02d7ea( agent, attacker, inflictor, smeansofdeath, objweapon )
{
    /#
        var_6bd05934a5a3c885 = getdvarint( @"hash_306a1005db79def2", 0 );
    #/
    
    if ( isdefined( attacker ) && ( attacker.var_d1c265e59db4d5bf || var_6bd05934a5a3c885 ) )
    {
        return 0;
    }
    
    if ( isdefined( inflictor ) && inflictor.var_d1c265e59db4d5bf )
    {
        return 0;
    }
    
    if ( isdefined( attacker ) && isdefined( agent ) && isdefined( agent.team ) )
    {
        if ( attacker.team == agent.team )
        {
            return 1;
        }
        
        if ( isdefined( attacker.owner ) && attacker.owner.team == agent.team )
        {
            return 1;
        }
        
        if ( isdefined( attacker.vehicle ) && attacker.vehicle.team == agent.team )
        {
            return 1;
        }
    }
    
    if ( isdefined( inflictor ) && isdefined( agent ) && isdefined( agent.team ) )
    {
        if ( inflictor.team == agent.team )
        {
            return 1;
        }
        
        if ( isdefined( inflictor.owner ) && inflictor.owner.team == agent.team )
        {
            return 1;
        }
        
        if ( isdefined( inflictor.vehicle ) && inflictor.vehicle.team == agent.team )
        {
            return 1;
        }
    }
    
    if ( isdefined( attacker ) && attacker vehicle::is_vehicle() && vehicle_collision::function_898c68dd6412f983( attacker, agent, smeansofdeath, objweapon ) )
    {
        return 1;
    }
    
    if ( utility::issharedfuncdefined( #"threat_bias", #"hash_cdff8e572590d823" ) )
    {
        return [[ utility::getsharedfunc( #"threat_bias", #"hash_cdff8e572590d823" ) ]]( agent, attacker, inflictor, smeansofdeath );
    }
    
    return 0;
}

// Namespace common_agent_damage
// Params 13
// Checksum 0xc7ac230e, Offset: 0x167b
// Size: 0x201, Type: bool
function function_e156111d9c0dfc5( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon )
{
    var_b06ed2aa4f6915cc = smeansofdeath == "MOD_CRUSH" && isent( einflictor ) && einflictor vehicle::is_vehicle();
    
    if ( var_b06ed2aa4f6915cc )
    {
        minvehiclespeed = 3;
        
        if ( self.var_b3f9400c9a2d96fb && isdefined( einflictor.owner ) )
        {
            minvehiclespeed = 0;
        }
        
        var_b06ed2aa4f6915cc = vehicle_collision::get_speed( einflictor ) <= minvehiclespeed;
    }
    
    var_d2d42561cf1d4380 = isdefined( self.origin ) && isdefined( level.var_cbe4d28d28ae892a ) && distancesquared( level.var_cbe4d28d28ae892a, self.origin ) < 250000;
    isstimpistoldamage = isplayer( eattacker ) && isdefined( sweapon.basename ) && sweapon.basename == "iw9_pi_stimpistol_mp" && utility::isbulletdamage( smeansofdeath );
    var_df2a4b16534a03e2 = isplayer( eattacker ) && utility::callsharedfunc( #"hash_f83d1f091b9a1e8e", #"isdefibrillator", objweapon );
    var_262ca37d18da7525 = isdefined( self.var_61ac0cadde089972 ) && isdefined( self.var_9f2be75059f33907 ) && gettime() >= self.var_9f2be75059f33907 && gettime() < self.var_61ac0cadde089972;
    return !self.invulnerable && !var_b06ed2aa4f6915cc && !var_d2d42561cf1d4380 && !isstimpistoldamage && !var_df2a4b16534a03e2 && !var_262ca37d18da7525;
}

// Namespace common_agent_damage
// Params 2
// Checksum 0x78df56de, Offset: 0x1885
// Size: 0x3b
function function_d1aff350047f9613( agent, attacker )
{
    agent_utils::function_b2aa0272588a7cdb( agent, 0 );
    agent val::set( "name", "heavy_melee_execution_victim", 1 );
    agent function_c868132e8ec37368();
}

// Namespace common_agent_damage
// Params 2
// Checksum 0xa474be4e, Offset: 0x18c8
// Size: 0x236
function function_3384dd53b83c8bf( agent, attacker )
{
    agent_utils::function_b2aa0272588a7cdb( agent, 0 );
    
    if ( !agent.var_ce2f8b4ca895561 )
    {
        if ( isdefined( agent.helmetshatterfx ) )
        {
            fx = agent.helmetshatterfx;
        }
        else if ( agent.subclass == "tier2" )
        {
            fx = utility::getfx( "vfx_gameplay_tier2_helmet_pop" );
        }
        else
        {
            fx = utility::getfx( "vfx_gameplay_tier3_helmet_pop" );
        }
        
        if ( agent.radimmune && !agent.var_3286ca1ac5a94fb )
        {
            agent.radimmune = 0;
        }
    }
    
    if ( isdefined( fx ) )
    {
        playfx( fx, agent gettagorigin( "j_helmet" ) );
    }
    
    if ( !agent.var_f06ef1d953b9fa41 )
    {
        if ( agent.var_3286ca1ac5a94fb && !issubstr( agent.agent_type, "merc" ) )
        {
            if ( agent getscriptablehaspart( "helmet" ) )
            {
                agent setscriptablepartstate( "helmet", "off" );
            }
            
            agent.helmetdamaged = undefined;
            agent.helmetbroken = 1;
        }
        else if ( !agent.var_ce2f8b4ca895561 )
        {
            hidebone = "j_helmet_hide";
            
            if ( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.var_16a376673d098cf ) )
            {
                hidebone = level.gamemodebundle.var_16a376673d098cf;
            }
            
            if ( agent utility::hastag( agent.hatmodel, hidebone ) )
            {
                agent hidepart( hidebone, agent.hatmodel );
            }
            
            if ( agent utility::hastag( agent.headmodel, hidebone ) )
            {
                agent hidepart( hidebone, agent.headmodel );
            }
        }
    }
    
    if ( agent.var_5609d8c260be3f0e && ( !agent isincombat() || agent.var_6002aa8166897fd7 && agent.var_6002aa8166897fd7 != "none" ) )
    {
        agent asmevalpaintransition( self.asmname );
    }
}

// Namespace common_agent_damage
// Params 1
// Checksum 0x4ac06928, Offset: 0x1b06
// Size: 0xb2
function damage_shouldoneshot( objweapon )
{
    shouldoneshot = 0;
    overrideoneshot = getdvarint( @"hash_a5eac9a0f544c3cf", 1 );
    
    if ( overrideoneshot )
    {
        if ( isdefined( objweapon ) && isdefined( objweapon.basename ) )
        {
            agenttier = self.tier;
            agentcategory = self.category;
            
            if ( isdefined( agentcategory ) && isdefined( agenttier ) && agentcategory != "bosses" )
            {
                switch ( objweapon.basename )
                {
                    case #"hash_91a48ebfd2d03a40":
                        shouldoneshot = 1;
                        break;
                }
            }
        }
    }
    
    return shouldoneshot;
}

// Namespace common_agent_damage
// Params 13
// Checksum 0x71969983, Offset: 0x1bc1
// Size: 0x492, Type: bool
function handleriotshielddamage( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon )
{
    if ( !self.bhasriotshieldattached )
    {
        return false;
    }
    
    if ( isdefined( sweapon ) && ( sweapon.basename == "super_laser_charge_mp" || sweapon.basename == "sat_la_mutant_injection_cannon_mp" ) )
    {
        self.forcehitlocation = "none";
        return false;
    }
    else if ( isdefined( self.forcehitlocation ) )
    {
        return false;
    }
    
    weaponbasename = objweapon.basename;
    bthermite = 0;
    
    if ( isdefined( einflictor ) )
    {
        if ( issubstr( weaponbasename, "thermite" ) || isdefined( einflictor.weapon_name ) && issubstr( einflictor.weapon_name, "incendiary" ) )
        {
            bthermite = 1;
            bhitshield = shitloc == "shield";
            
            if ( bhitshield )
            {
                contents = trace::create_character_contents();
                dirnormalized = vectornormalize( vdir );
                startpos = vpoint - dirnormalized * 12;
                endpos = vpoint + dirnormalized * 12;
                results = trace::ray_trace_detail( startpos, endpos, undefined, contents );
                
                if ( results[ "fraction" ] > 0 && results[ "fraction" ] < 1 )
                {
                    metopoint = vpoint - self.origin;
                    metopoint = ( metopoint[ 0 ], metopoint[ 1 ], 0 );
                    
                    if ( vectordot( metopoint, results[ "normal" ] ) < 0 )
                    {
                        bhitshield = 0;
                    }
                }
                else
                {
                    bhitshield = 0;
                }
            }
            
            if ( bhitshield )
            {
                parent = einflictor getlinkedparent();
                
                if ( parent == self )
                {
                    self.bhasthermitestucktoshield = 1;
                    self.thermitestuckpains = 0;
                }
            }
            else if ( shitloc != "none" )
            {
                self.bhasthermitestucktoshield = 0;
                self.thermitestuckpains = undefined;
            }
        }
        else if ( shitloc == "shield" )
        {
            if ( issubstr( weaponbasename, "bunkerbuster" ) )
            {
                einflictor.riotshieldvictim = self;
                einflictor.riotshieldhit = 1;
            }
            else
            {
                self function_b52496840a3096bd( int( idamage ) );
            }
        }
    }
    
    if ( shitloc == "shield" )
    {
        if ( bthermite )
        {
            /#
                if ( getdvarint( @"g_debugdamage" ) != 0 )
                {
                    println( "<dev string:x136>" );
                }
            #/
            
            return true;
        }
    }
    else if ( shitloc == "none" && isdefined( einflictor ) )
    {
        inflictorparent = einflictor getlinkedparent();
        
        if ( self.bhasthermitestucktoshield && bthermite && inflictorparent == self )
        {
            if ( !isdefined( self.thermitestucktoshield ) )
            {
                self.thermitestucktoshield = [ einflictor ];
            }
            else if ( !arraycontains( self.thermitestucktoshield, einflictor ) )
            {
                self.thermitestucktoshield[ self.thermitestucktoshield.size ] = einflictor;
            }
            
            assert( isdefined( self.thermitestuckpains ) );
            
            /#
                if ( getdvarint( @"g_debugdamage" ) != 0 )
                {
                    println( "<dev string:x14f>" );
                }
            #/
            
            self.thermitestuckpains++;
            return true;
        }
        else if ( !level.var_4a6d258c51f26789 )
        {
            if ( issubstr( weaponbasename, "molotov" ) )
            {
                var_eeed8d3785de8f69 = einflictor.origin - self.origin;
                var_f7808546b9e756bf = vectornormalize( ( var_eeed8d3785de8f69[ 0 ], var_eeed8d3785de8f69[ 1 ], 0 ) );
                var_eeed8d3785de8f69 = vectornormalize( var_eeed8d3785de8f69 );
                
                if ( vectordot( anglestoforward( self.angles ), var_f7808546b9e756bf ) > 0.5 && -0.98 < var_eeed8d3785de8f69[ 2 ] && var_eeed8d3785de8f69[ 2 ] < 0.98 )
                {
                    /#
                        if ( getdvarint( @"g_debugdamage" ) != 0 )
                        {
                            println( "<dev string:x16c>" );
                        }
                    #/
                    
                    return true;
                }
            }
        }
    }
    
    if ( smeansofdeath == "MOD_MELEE" && ( eattacker || vpoint ) && !function_892b05acb2029575( shitloc, eattacker, vpoint ) )
    {
        /#
            if ( getdvarint( @"g_debugdamage" ) != 0 )
            {
                println( "<dev string:x18d>" );
            }
        #/
        
        return true;
    }
    
    return false;
}

// Namespace common_agent_damage
// Params 3
// Checksum 0x774989f, Offset: 0x205c
// Size: 0xd0, Type: bool
function function_892b05acb2029575( hit_loc, attacker, var_746a9fdf4795fc76 )
{
    assert( attacker || var_746a9fdf4795fc76, "<dev string:x1b2>" );
    
    if ( hit_loc == "shield" )
    {
        return true;
    }
    
    if ( attacker )
    {
        var_40788b5bf253cc6c = vectornormalize( attacker.origin - self.origin );
    }
    else
    {
        var_40788b5bf253cc6c = vectornormalize( var_746a9fdf4795fc76 - self.origin );
    }
    
    me_forward = anglestoforward( self.angles );
    dot = vectordot( me_forward, var_40788b5bf253cc6c );
    dot = clamp( dot, -1, 1 );
    return acos( dot ) >= getdvarfloat( @"hash_94d69f96be0980bf", 60 );
}

