// scripts\mp\common\equipment\throwstar.gsc  (hash_524ceaf9ff217447.gscc) (size: 6414 Bytes / 0x190e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x96f06fd9 (2532339673)
// size ...... 6414 (0x190e)
// includes .. 6   (offset: 0x17da)
// strings ... 18  (offset: 0x180a)
// dev strs .. 1   (offset: 0x1902)
// exports ... 23  (offset: 0xe2a)
// cseg ...... 0x2ab + 0xb7f (0xe2a)
// imports ... 52  (offset: 0x11c2)
// animtree1 . 0   (offset: 0x190e)
// animtree2 . 0   (offset: 0x190e)
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\equipment;

#namespace throwstar;

// Namespace throwstar
// Params 0, eflags: 0x1
// Checksum 0x5cf96667, Offset: 0x2c9
// Size: 0x122
function autoexec throwstar_init()
{
    utility::flag_wait( "equipment_initialized" );
    level.var_b0769ddce23ca4cd = getdvarfloat( @"hash_378f4895fd171e8", 12 );
    level.var_4cd421496c0ccb4d = getdvarfloat( @"hash_85766dcc125edac", 20 );
    level._effect[ "thorwstar_impact_stick" ] = loadfxasset( "vfx_iw9_core_equip_throwstar_impact_stick" );
    level._effect[ "thorwstar_impact_reflect" ] = loadfxasset( "vfx_iw9_core_equip_throwstar_impact_reflect" );
    level._effect[ "thorwstar_impact_flesh" ] = loadfxasset( "vfx_iw9_core_equip_throwstar_impact_flesh" );
    level._effect[ "thorwstar_impact_water" ] = loadfxasset( "vfx_iw9_core_equip_throwstar_impact_water" );
    setdvarifuninitialized( @"scr_throwstar_pickups", 0 );
    utility::callsharedfunc( #"hash_541e9840590e9693", #"init" );
    equipment_mp::registercallback( "equip_throwstar", "onGive", &throwstar_ongive );
    equipment_mp::registercallback( "equip_throwstar", "onTake", &throwstar_ontake );
    equipment_mp::registercallback( "equip_mutation_throwstar", "onGive", &throwstar_ongive );
    equipment_mp::registercallback( "equip_mutation_throwstar", "onTake", &throwstar_ontake );
}

// Namespace throwstar
// Params 4
// Checksum 0xde3f2d56, Offset: 0x3f3
// Size: 0x40
function throwstar_ongive( equipmentref, equipmentslot, variantid, attachments )
{
    utility::callsharedfunc( #"hash_541e9840590e9693", #"ongive" );
}

// Namespace throwstar
// Params 2
// Checksum 0x4321f9cf, Offset: 0x43b
// Size: 0x2e
function throwstar_ontake( equipmentref, equipmentslot )
{
    utility::callsharedfunc( #"hash_541e9840590e9693", #"onTake" );
}

// Namespace throwstar
// Params 1
// Checksum 0x4219edba, Offset: 0x471
// Size: 0xef
function throwstar_used( grenade )
{
    grenade endon( #"death" );
    grenade.bwasunderwater = player_utility::isswimmingunderwater();
    grenade thread function_13ef5d16758bb598();
    grenade makeunusable();
    var_89bb0d1336abd402 = grenade.angles;
    grenade endon( #"hash_267eb02053fcfe0f" );
    grenade waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, hitvelocity, position, hitnormal );
    
    if ( getdvarint( @"scr_throwstar_pickups" ) )
    {
        grenade setscriptablepartstate( "showLocation", "active", 0 );
        grenade throwstar_makepickup();
        return;
    }
    
    thread throwstar_impact( stuckto, stuckpart, var_89bb0d1336abd402, surfacetype, hitvelocity, position, hitnormal );
    grenade delete();
}

// Namespace throwstar
// Params 0
// Checksum 0x94caacf9, Offset: 0x568
// Size: 0x121
function throwstar_makepickup()
{
    self makeunusable();
    trigger = spawn( "trigger_radius", self.origin, 0, 64, 64 );
    trigger enablelinkto();
    trigger linkto( self );
    self.throwstar_trigger = trigger;
    
    if ( !isdefined( level.throwstars ) )
    {
        level.throwstars = [];
    }
    
    temparr = [ self ];
    
    foreach ( throwstar in level.throwstars )
    {
        if ( temparr.size >= level.var_b0769ddce23ca4cd )
        {
            if ( isdefined( throwstar ) )
            {
                throwstar throwstar_deletepickup();
            }
            
            continue;
        }
        
        if ( isdefined( throwstar ) )
        {
            temparr[ temparr.size ] = throwstar;
        }
    }
    
    level.throwstars = temparr;
    thread throwstar_watchpickup();
    thread throwstar_watchpickuptimeout();
}

// Namespace throwstar
// Params 0, eflags: 0x4
// Checksum 0x254cb69a, Offset: 0x691
// Size: 0xed
function private throwstar_watchpickup()
{
    self endon( #"death" );
    isbackpackinventoryenabled = 0;
    
    if ( utility::issharedfuncdefined( #"inventory", #"isbackpackinventoryenabled" ) )
    {
        isbackpackinventoryenabled = [[ utility::getsharedfunc( #"inventory", #"isbackpackinventoryenabled" ) ]]();
    }
    
    while ( true )
    {
        self.throwstar_trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !player player::isreallyalive() )
        {
            continue;
        }
        
        if ( isdefined( self.owner ) && self.owner != player )
        {
            continue;
        }
        
        if ( !player hasweapon( self.weapon_object ) && !isbackpackinventoryenabled )
        {
            continue;
        }
        
        if ( player throwstar_trytopickup( self.equipmentref ) )
        {
            thread throwstar_deletepickup();
        }
    }
}

// Namespace throwstar
// Params 1, eflags: 0x4
// Checksum 0x9c2b2dc5, Offset: 0x786
// Size: 0x65
function private throwstar_trytopickup( equipmentref )
{
    if ( utility::issharedfuncdefined( #"hash_541e9840590e9693", #"trytopickup" ) )
    {
        pickupsuccessful = self [[ utility::getsharedfunc( #"hash_541e9840590e9693", #"trytopickup" ) ]]( equipmentref );
        assert( isdefined( pickupsuccessful ), "<dev string:x24>" );
        return pickupsuccessful;
    }
    
    return 1;
}

// Namespace throwstar
// Params 0, eflags: 0x4
// Checksum 0xdeb5eb88, Offset: 0x7f4
// Size: 0x23
function private throwstar_deletepickup()
{
    if ( isdefined( self.throwstar_trigger ) )
    {
        self.throwstar_trigger delete();
    }
    
    self delete();
}

// Namespace throwstar
// Params 0, eflags: 0x4
// Checksum 0x624c1dd2, Offset: 0x81f
// Size: 0x1f
function private throwstar_watchpickuptimeout()
{
    self endon( #"death" );
    wait level.var_4cd421496c0ccb4d;
    thread throwstar_deletepickup();
}

// Namespace throwstar
// Params 0, eflags: 0x4
// Checksum 0x84523b82, Offset: 0x846
// Size: 0x5f
function private function_13ef5d16758bb598()
{
    self endon( #"explode" );
    self endon( #"death" );
    self endon( #"missile_stuck" );
    
    if ( self.inert )
    {
        return 0;
    }
    
    self waittill( #"missile_water_impact", impactdata );
    self.bwasunderwater = 1;
    thread function_bc6cae8891566c13();
}

// Namespace throwstar
// Params 0, eflags: 0x4
// Checksum 0x36884f63, Offset: 0x8ad
// Size: 0x117
function private function_bc6cae8891566c13()
{
    level endon( #"game_end" );
    self endon( #"missile_stuck" );
    owner = self.owner;
    newspawnpos = self.origin;
    var_49e5d2d92b07bfb = self.weapon_object;
    var_89bb0d1336abd402 = self.angles;
    inertweapon = "throwstar_mp_inert";
    self waittill( #"missile_change_to_dud", dudpos );
    owner notify( #"hash_267eb02053fcfe0f" );
    
    if ( getdvarint( @"scr_throwstar_pickups" ) )
    {
        if ( isdefined( dudpos ) )
        {
            newspawnpos = dudpos;
            replacementstar = owner launchgrenade( inertweapon, newspawnpos, ( 0, 0, 0 ), undefined, undefined );
            replacementstar.inert = 1;
            replacementstar.var_49e5d2d92b07bfb = var_49e5d2d92b07bfb;
            replacementstar.angles = var_89bb0d1336abd402;
        }
        
        return;
    }
    
    if ( isdefined( dudpos ) )
    {
        newspawnpos = dudpos;
        throwstar_water_impact( newspawnpos, var_89bb0d1336abd402 );
    }
}

// Namespace throwstar
// Params 4
// Checksum 0x93742ecb, Offset: 0x9cc
// Size: 0xd6
function function_958668cc77ccb4af( einflictor, victim, idamage, partname )
{
    if ( damage_utility::function_5d1c04cbc4da6bc4( partname ) )
    {
        idamage = 250;
        
        if ( isdefined( victim ) )
        {
            victim.var_49082f50a1e5e854 = 1;
        }
    }
    else if ( isdefined( victim ) )
    {
        victim.var_49082f50a1e5e854 = undefined;
    }
    
    if ( einflictor.bwasunderwater )
    {
        idamage = function_617e5c47c9930a56( victim );
    }
    
    if ( isdefined( victim ) && victim.inlaststand )
    {
        if ( !isdefined( victim.perks[ "specialty_close_quarter" ] ) )
        {
            idamage = victim.health;
        }
        else
        {
            idamage = victim.health <= idamage ? victim.health : idamage;
        }
    }
    
    return idamage;
}

// Namespace throwstar
// Params 0
// Checksum 0xba53093e, Offset: 0xaab
// Size: 0x4
function function_2e8bc5f09830ff4a()
{
    return 130;
}

// Namespace throwstar
// Params 1
// Checksum 0x2e2f07ee, Offset: 0xab8
// Size: 0x55
function function_617e5c47c9930a56( victim )
{
    outdmg = 45;
    var_a0be4a2063c309d5 = victim.health - 45 <= 0;
    
    if ( var_a0be4a2063c309d5 )
    {
        outdmg = int( max( victim.health - 1, 1 ) );
    }
    
    return outdmg;
}

// Namespace throwstar
// Params 7
// Checksum 0x73caf2b0, Offset: 0xb16
// Size: 0x9b
function throwstar_impact( stuckto, stuckpart, grenadeangles, surfacetype, hitvelocity, position, hitnormal )
{
    if ( function_8b152304c1c742fc( stuckto ) )
    {
        function_5f802b98ed6485ba( grenadeangles, position, hitnormal );
        return;
    }
    
    if ( function_a843457905417d2( stuckto, stuckpart, surfacetype ) )
    {
        function_723ff5d66ac43cbc( grenadeangles, hitvelocity, position );
        return;
    }
    
    if ( function_719fd243ffad6435( position ) )
    {
        throwstar_water_impact( position, grenadeangles );
        return;
    }
    
    function_c1accd79ec1fd58f( grenadeangles, hitvelocity, position, hitnormal );
}

// Namespace throwstar
// Params 1, eflags: 0x4
// Checksum 0x6de91662, Offset: 0xbb9
// Size: 0x38
function private function_8b152304c1c742fc( stuckto )
{
    if ( isdefined( stuckto ) && ( isplayer( stuckto ) || isbot( stuckto ) || isagent( stuckto ) ) )
    {
        return 1;
    }
    
    return 0;
}

// Namespace throwstar
// Params 3, eflags: 0x4
// Checksum 0x268b7e58, Offset: 0xbf9
// Size: 0xd5
function private function_a843457905417d2( stuckto, stuckpart, surfacetype )
{
    if ( isdefined( stuckto ) || isdefined( stuckpart ) )
    {
        return 0;
    }
    
    if ( !isdefined( surfacetype ) )
    {
        return 0;
    }
    
    switch ( surfacetype )
    {
        case #"hash_41e04530b0d1a782":
        case #"hash_51929a2eb8e4f743":
        case #"hash_590687995d01030e":
        case #"hash_60c926590a0f6396":
        case #"hash_87a0a54672bcf62d":
        case #"hash_8dede5336d28890d":
        case #"hash_94fae4c6dd8b1184":
        case #"hash_a13dd2b8b51545eb":
        case #"hash_a195e7e44c7eb519":
        case #"hash_c05d848a0e130e97":
        case #"hash_d7db938a07617552":
            return 1;
        default:
            return 0;
    }
}

// Namespace throwstar
// Params 1, eflags: 0x4
// Checksum 0x561dda42, Offset: 0xcd6
// Size: 0x1b, Type: bool
function private function_719fd243ffad6435( position )
{
    if ( utility::ispointinwater( position ) )
    {
        return true;
    }
    
    return false;
}

// Namespace throwstar
// Params 3, eflags: 0x4
// Checksum 0xc5654adb, Offset: 0xcfa
// Size: 0x3b
function private function_5f802b98ed6485ba( grenadeangles, position, hitnormal )
{
    playfx( level._effect[ "thorwstar_impact_flesh" ], position, hitnormal, anglestoup( grenadeangles ) );
}

// Namespace throwstar
// Params 3, eflags: 0x4
// Checksum 0x852175c8, Offset: 0xd3d
// Size: 0x4d
function private function_723ff5d66ac43cbc( grenadeangles, hitvelocity, position )
{
    forward = vectornormalize( hitvelocity );
    playfx( level._effect[ "thorwstar_impact_stick" ], position, forward, anglestoup( grenadeangles ) );
}

// Namespace throwstar
// Params 2, eflags: 0x4
// Checksum 0xc6aaae39, Offset: 0xd92
// Size: 0x37
function private throwstar_water_impact( position, grenadeangles )
{
    playfx( level._effect[ "thorwstar_impact_water" ], position, anglestoforward( grenadeangles ), anglestoup( grenadeangles ) );
}

// Namespace throwstar
// Params 4, eflags: 0x4
// Checksum 0x9b6af60, Offset: 0xdd1
// Size: 0x59
function private function_c1accd79ec1fd58f( grenadeangles, hitvelocity, position, hitnormal )
{
    reflectvec = math::vector_reflect( hitvelocity, hitnormal );
    playfx( level._effect[ "thorwstar_impact_reflect" ], position, reflectvec, anglestoup( grenadeangles ) );
}

