// script_163ce0e5a3089995  (hash_163ce0e5a3089995.gscc) (size: 7107 Bytes / 0x1bc3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2327b88c (589805708)
// size ...... 7107 (0x1bc3)
// includes .. 9   (offset: 0x1aa7)
// strings ... 15  (offset: 0x1aef)
// dev strs .. 0   (offset: 0x1bc3)
// exports ... 29  (offset: 0xf67)
// cseg ...... 0x178 + 0xdef (0xf67)
// imports ... 59  (offset: 0x13ef)
// animtree1 . 0   (offset: 0x1bc3)
// animtree2 . 0   (offset: 0x1bc3)
#using script_16ea1b94f0f381b3;
#using script_28903b44edf078c7;
#using script_61b40095fd0502f0;
#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\damage;
#using scripts\mp\mp_agent;

#namespace dawg_safeguard;

// Namespace dawg_safeguard
// Params 0, eflags: 0x1
// Checksum 0xd009f356, Offset: 0x196
// Size: 0xf2
function autoexec main()
{
    utility::registersharedfunc( #"escort", #"escort_ai_spawn", &dawg_safeguard_spawn );
    utility::registersharedfunc( #"escort", #"hash_1416e3f64b880e8d", &function_46df076b7ece3d0f );
    utility::registersharedfunc( #"escort", #"hash_b501f4d1d15bdf75", &function_114a1d08d484202b );
    utility::registersharedfunc( #"escort", #"hash_b2d41febe9815cd5", &function_b952f553074e6937 );
    utility::registersharedfunc( #"escort", #"hash_20041b95f95e7b68", &function_70f328d8d8d8ad31 );
    utility::registersharedfunc( #"escort", #"hash_6edd39baefe275f9", &function_7e69ee4937df3193 );
    utility::registersharedfunc( #"escort", #"hash_b26b29f31e71b27a", &function_26b709ed8c293e8 );
    utility::registersharedfunc( #"escort", #"hash_b33c46a72a3bd370", &function_daeb0a8bf7fe4186 );
}

// Namespace dawg_safeguard
// Params 3
// Checksum 0xaea31bab, Offset: 0x290
// Size: 0x5c
function dawg_safeguard_spawn( origin, angles, team )
{
    if ( team == "axis" )
    {
        aitype = "sat_dawg_safeguard_guild";
    }
    else
    {
        aitype = "sat_dawg_safeguard";
    }
    
    ai = namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( aitype, origin, angles, team );
    return ai;
}

// Namespace dawg_safeguard
// Params 1
// Checksum 0x93c0a7c0, Offset: 0x2f5
// Size: 0x1c8
function function_d240f26407b2ae69( taskid )
{
    level.var_de0074d9320cc42f[ dawg::function_8e41f13f8b7fd338() ] = getscriptbundle( "dawgaisettings:dawgsettings_mp_dawg_safeguard" );
    self.dawgaisettings = level.var_de0074d9320cc42f[ dawg::function_8e41f13f8b7fd338() ];
    callback::add( "on_first_ai_init", &dawg::function_3816177cd7f1739 );
    callback::add( #"on_ai_killed", &dawg::function_3da5bc18fd85ec6b );
    self.agent_damage_callback = &dawg_safeguard_damage_override;
    self.var_e8f6b03121a2f56d = [ &function_f1ef6d672b726c75 ];
    self.var_85111bb9ad8b0dba = [ &function_a95ca15e8d15889b ];
    self.var_c5ccf9dff3b5e393 = &dawg::function_9f089068acd13af1;
    self.var_485899a46494a80f = &dawg::function_115a1f5c5af2816d;
    self.allowstrafe = 0;
    self setcanusecover( 0 );
    self.lookfordoorsalongpath = 1;
    self.checkstop = 0;
    self allowvehiclepredictiveragdoll( 0 );
    self pushplayer( 1 );
    self enableavoidance( 0, 1 );
    self setavoidanceradius( 100 );
    self.var_f9c94f16f6e7c13c = 1;
    self.badplaceawareness = 0;
    self function_2c77f73acbc98a74( 1 );
    self function_92b65f4d4fed5356( 1 );
    
    if ( !level.var_1094bbb6422bd39a )
    {
        self function_90b3ed62e6d125e9( 3 );
    }
    
    self.var_7bd2fc702f01b407 = 1;
    self.mode = "DawgSafeguardStoppedMode";
    self.disablearrivals = 1;
    self.blackhatref = "sat_dawg_safeguard";
    self.script_team = self.team;
    self function_74b305f055e8341d( "metal_thick" );
    createthreatbiasgroup( "dawg" );
    self setthreatbiasgroup( "dawg" );
    thread function_b75457573b23705b();
    self.var_d1167ce565a3e0d4 = 0;
    self.var_501d6c91a13cab0d = 0;
    self.var_9385a2c5dacdad2a = 1;
    return anim.success;
}

// Namespace dawg_safeguard
// Params 1
// Checksum 0x2cf97c00, Offset: 0x4c6
// Size: 0x51
function function_e3304562f513e3b0( taskid )
{
    if ( self.safeguardroute && !self.var_bac46cd9ef72db23 )
    {
        self.mode = "DawgSafeguardMarchMode";
        return "DawgSafeguardMarchMode";
    }
    
    self.mode = "DawgSafeguardStoppedMode";
    return "DawgSafeguardStoppedMode";
}

// Namespace dawg_safeguard
// Params 1
// Checksum 0x2dc5f9a2, Offset: 0x51f
// Size: 0x15
function function_8e4b371cbfa9f9b2( taskid )
{
    return anim.success;
}

// Namespace dawg_safeguard
// Params 1
// Checksum 0xc53ef401, Offset: 0x53d
// Size: 0x1c
function function_ed4c0375677527b1( taskid )
{
    dawg::dawg_set_goal();
    return anim.running;
}

// Namespace dawg_safeguard
// Params 1
// Checksum 0x31f1cf80, Offset: 0x562
// Size: 0x15
function function_24df8ba59bc2c2fa( taskid )
{
    return anim.success;
}

// Namespace dawg_safeguard
// Params 1
// Checksum 0xda8387db, Offset: 0x580
// Size: 0x1c
function function_169ccb9fbc37e2b4( taskid )
{
    function_ef7375d84421eea4();
    return anim.success;
}

// Namespace dawg_safeguard
// Params 1
// Checksum 0x68a55e6f, Offset: 0x5a5
// Size: 0x111
function function_9d2a1492a3b38e57( taskid )
{
    if ( self.safeguardroute && self.var_d1167ce565a3e0d4 < self.safeguardroute.size && self.var_d1167ce565a3e0d4 >= 0 )
    {
        if ( distance2dsquared( self.origin, self.safeguardroute[ self.var_d1167ce565a3e0d4 ] ) < 1225 )
        {
            self.var_501d6c91a13cab0d = self.var_d1167ce565a3e0d4;
            self.var_d1167ce565a3e0d4 += self.var_9385a2c5dacdad2a;
        }
    }
    
    function_ef7375d84421eea4();
    
    /#
        if ( self.safeguardroute && getdvarint( @"hash_5db66820fb05e65", 0 ) == 1 )
        {
            debug_draw_path( self.safeguardroute, ( 0.5, 0, 0 ) );
            
            if ( self.movement_goal )
            {
                sphere( self.movement_goal, 8, ( 0.9, 0.8, 0.2 ), 0, 1 );
            }
        }
    #/
    
    return anim.running;
}

// Namespace dawg_safeguard
// Params 1
// Checksum 0x5220677e, Offset: 0x6bf
// Size: 0x15
function function_16846f2545ef7d0( taskid )
{
    return anim.success;
}

// Namespace dawg_safeguard
// Params 1
// Checksum 0xe45334b9, Offset: 0x6dd
// Size: 0x31
function function_e832a40305cf881f( taskid )
{
    if ( self.mode == "DawgSafeguardDisabledMode" )
    {
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace dawg_safeguard
// Params 1
// Checksum 0xb353bb69, Offset: 0x717
// Size: 0x42
function function_117f7cd740883513( taskid )
{
    if ( isalive( self ) )
    {
        asm::function_7256f5ba459c840b( "stun_in" );
        utility::function_32b24db3127bff40( #"disabled", #"disabled" );
    }
    
    return anim.success;
}

// Namespace dawg_safeguard
// Params 1
// Checksum 0x761d3885, Offset: 0x762
// Size: 0x1c
function function_e9b292873f09d854( taskid )
{
    dawg::dawg_set_goal();
    return anim.running;
}

// Namespace dawg_safeguard
// Params 1
// Checksum 0xe5f3456a, Offset: 0x787
// Size: 0x42
function function_d43a433b64a4578b( taskid )
{
    if ( isalive( self ) )
    {
        asm::function_7256f5ba459c840b( "stun_end" );
        utility::function_32b24db3127bff40( #"disabled", #"rebooted" );
    }
    
    return anim.success;
}

// Namespace dawg_safeguard
// Params 1
// Checksum 0x4964f48e, Offset: 0x7d2
// Size: 0xde
function dawg_safeguard_disable( duration )
{
    attackerlist = [];
    
    foreach ( attackerdata in self.attackerdata )
    {
        attackerlist[ attackerlist.size ] = attackerdata.attackerent;
    }
    
    self notify( #"escort_disabled", attackerlist );
    self.mode = "DawgSafeguardDisabledMode";
    self setcandamage( 0 );
    wait duration;
    self.mode = "DawgSafeguardStoppedMode";
    self setcandamage( 1 );
    self.attackerdata = undefined;
}

/#

    // Namespace dawg_safeguard
    // Params 2
    // Checksum 0xa6bac46a, Offset: 0x8b8
    // Size: 0x62, Type: dev
    function debug_draw_path( path, pathcolor )
    {
        if ( path.size > 0 )
        {
            for ( index = 1; index < path.size ; index++ )
            {
                line( path[ index - 1 ], path[ index ], pathcolor, 1, 0, 1 );
                sphere( path[ index ], 5, pathcolor, 0, 1 );
            }
        }
    }

#/

// Namespace dawg_safeguard
// Params 3
// Checksum 0xe16e16ce, Offset: 0x922
// Size: 0x8b
function function_46df076b7ece3d0f( path, startnode, pathdirection )
{
    self.safeguardroute = path;
    
    if ( pathdirection && self.var_9385a2c5dacdad2a != pathdirection )
    {
        self.var_d1167ce565a3e0d4 += pathdirection;
    }
    
    self.var_d1167ce565a3e0d4 = startnode ?? self.var_d1167ce565a3e0d4;
    self.var_9385a2c5dacdad2a = pathdirection ?? self.var_9385a2c5dacdad2a;
    self.var_bac46cd9ef72db23 = undefined;
}

// Namespace dawg_safeguard
// Params 1, eflags: 0x4
// Checksum 0xff3c2e20, Offset: 0x9b5
// Size: 0xd0
function private function_ef7375d84421eea4( path )
{
    if ( path )
    {
        function_46df076b7ece3d0f( path );
    }
    
    route = self.safeguardroute;
    
    if ( !route || route.size <= self.var_d1167ce565a3e0d4 || self.var_d1167ce565a3e0d4 < 0 )
    {
        return;
    }
    
    nextnode = route[ self.var_d1167ce565a3e0d4 ];
    prevnode = route[ self.var_501d6c91a13cab0d ];
    navhit = navtrace( prevnode, nextnode, self, 1 );
    endpos = navhit[ "position" ];
    endpos = self getclosestreachablepointonnavmesh( endpos, 0 );
    
    if ( endpos )
    {
        if ( getdvarint( @"hash_1ae638cab9d29912", 0 ) == 0 )
        {
            dawg::dawg_set_goal( endpos );
        }
    }
}

// Namespace dawg_safeguard
// Params 0
// Checksum 0x88b07aad, Offset: 0xa8d
// Size: 0xd
function function_114a1d08d484202b()
{
    self.var_bac46cd9ef72db23 = 1;
}

// Namespace dawg_safeguard
// Params 0, eflags: 0x4
// Checksum 0x1e133f58, Offset: 0xaa2
// Size: 0x39
function private function_b75457573b23705b()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    waitframe();
    self.var_7ebcfe2aa6620601 = "walk";
    namespace_aafbaa6bf95d91a9::function_a8ce00e0448cb6f0( self.var_7ebcfe2aa6620601 );
}

// Namespace dawg_safeguard
// Params 14
// Checksum 0x7c3ca9a1, Offset: 0xae3
// Size: 0x1f5
function dawg_safeguard_damage_override( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    attackerplayer = isplayer( eattacker ) ? eattacker : eattacker.owner;
    
    if ( mp_agent::is_friendly_damage( self, eattacker, smeansofdeath, sweapon ) )
    {
        return 0;
    }
    
    if ( isplayer( attackerplayer ) )
    {
        if ( isdefined( level.sharedfuncs[ #"damage" ][ #"updatedamagefeedback" ] ) )
        {
            attackerplayer [[ level.sharedfuncs[ #"damage" ][ #"updatedamagefeedback" ] ]]( "hitequip", 0, 0, "hitequip" );
        }
    }
    
    if ( level.var_deb9d2b3de25799b && isdefined( level.sharedfuncs[ #"killstreak" ][ #"getmodifieddamageusingdamagetuning" ] ) )
    {
        data = damage_utility::packdamagedata( eattacker, self, idamage, sweapon, smeansofdeath, einflictor, vpoint, vdir, modelindex, partname, undefined, idflags, undefined, shitloc );
        idamage = self [[ level.sharedfuncs[ #"killstreak" ][ #"getmodifieddamageusingdamagetuning" ] ]]( eattacker, sweapon, smeansofdeath, idamage, self.maxhealth, self.dawgaisettings.var_9c59609516a7fa81, data );
    }
    
    damage::addattacker( self, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, timeoffset, smeansofdeath );
    
    if ( idamage >= self.health )
    {
        self.health = self.maxhealth;
        idamage = 0;
        thread dawg_safeguard_disable( self.robotRebootTime ?? 15 );
    }
    
    return idamage;
}

// Namespace dawg_safeguard
// Params 1
// Checksum 0x265dc9a8, Offset: 0xce1
// Size: 0xb8
function function_f1ef6d672b726c75( dmgstruct )
{
    dmgstruct.idamage = dawg_safeguard_damage_override( dmgstruct.einflictor, dmgstruct.eattacker, dmgstruct.idamage, dmgstruct.idflags, dmgstruct.smeansofdeath, dmgstruct.sweapon, dmgstruct.vpoint, dmgstruct.vdir, dmgstruct.shitloc, dmgstruct.timeoffset, dmgstruct.modelindex, dmgstruct.partname, dmgstruct.objweapon );
    return dmgstruct.idamage;
}

// Namespace dawg_safeguard
// Params 13
// Checksum 0xee02d393, Offset: 0xda2
// Size: 0xa7
function function_a95ca15e8d15889b( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname )
{
    data = spawnstruct();
    data.escortent = self;
    callback::callback( #"hash_44831cd44167723d", data );
}

// Namespace dawg_safeguard
// Params 2
// Checksum 0x8f831df8, Offset: 0xe51
// Size: 0x55
function function_b952f553074e6937( multiplier, pathdirection )
{
    if ( pathdirection )
    {
        self.var_9385a2c5dacdad2a = pathdirection;
    }
    
    var_b3a8de2a35c57053 = self.dawgaisettings.walkanimrate * ( multiplier ?? 1 );
    asm::function_d82cb83c9c260d49( var_b3a8de2a35c57053 );
}

// Namespace dawg_safeguard
// Params 1
// Checksum 0x102abf1b, Offset: 0xeae
// Size: 0x17
function function_70f328d8d8d8ad31( var_96b7236dcc59e372 )
{
    self.robotRebootTime = var_96b7236dcc59e372;
}

// Namespace dawg_safeguard
// Params 0
// Checksum 0xca383d2d, Offset: 0xecd
// Size: 0x19
function function_7e69ee4937df3193()
{
    if ( !self.safeguardroute )
    {
        return;
    }
    
    return self.var_501d6c91a13cab0d;
}

// Namespace dawg_safeguard
// Params 0
// Checksum 0x5efca0c6, Offset: 0xeef
// Size: 0x19
function function_26b709ed8c293e8()
{
    if ( !self.safeguardroute )
    {
        return;
    }
    
    return self.var_d1167ce565a3e0d4;
}

// Namespace dawg_safeguard
// Params 0
// Checksum 0x148b6eb9, Offset: 0xf11
// Size: 0x55, Type: bool
function function_daeb0a8bf7fe4186()
{
    if ( !self.safeguardroute )
    {
        return false;
    }
    
    return self.var_501d6c91a13cab0d <= 0 && self.var_9385a2c5dacdad2a < 0 || self.var_501d6c91a13cab0d + 1 >= self.safeguardroute.size && self.var_9385a2c5dacdad2a > 0;
}

