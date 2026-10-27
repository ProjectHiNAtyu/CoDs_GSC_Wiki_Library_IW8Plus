// script_14b386d73d058eb8  (hash_14b386d73d058eb8.gscc) (size: 1925 Bytes / 0x785 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2b9e6d24 (731802916)
// size ...... 1925 (0x785)
// includes .. 3   (offset: 0x749)
// strings ... 3   (offset: 0x761)
// dev strs .. 0   (offset: 0x785)
// exports ... 5   (offset: 0x425)
// cseg ...... 0x85 + 0x3a0 (0x425)
// imports ... 21  (offset: 0x4ed)
// animtree1 . 0   (offset: 0x785)
// animtree2 . 0   (offset: 0x785)
#using scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_wound;
#using scripts\common\math;
#using scripts\common\utility;

#namespace namespace_5a283ea68822d457;

// Namespace namespace_5a283ea68822d457
// Params 0
// Checksum 0x6b105c65, Offset: 0xa3
// Size: 0x2
function init_zombie_callisto_claw_attack()
{
    
}

// Namespace namespace_5a283ea68822d457
// Params 3
// Checksum 0x3a722f70, Offset: 0xad
// Size: 0x25
function start_claw_attack( asmname, statename, params )
{
    thread watch_claw_swipe();
}

// Namespace namespace_5a283ea68822d457
// Params 3
// Checksum 0xdde8b863, Offset: 0xda
// Size: 0x3c
function stop_claw_attack( asmname, statename, params )
{
    self notify( #"claw_attack_stop" );
    self clearpath();
    self function_786bb6aa1b76c7ee( "in_claw_attack", 0 );
}

// Namespace namespace_5a283ea68822d457
// Params 0, eflags: 0x4
// Checksum 0x7f215d60, Offset: 0x11e
// Size: 0x307
function private watch_claw_swipe()
{
    self endon( #"death" );
    self endon( #"claw_attack_stop" );
    utility::waittill_notify_or_timeout( "claw_swipe", 2 );
    body_center = self getcentroid();
    body_direction = anglestoforward( self.angles );
    swipe_range = self.var_72438d00bd2b6b24;
    radius = swipe_range / 1.5;
    radiussqrd = radius * radius;
    damage_center = body_center + body_direction * radius;
    targets = getplayersandaiarrayinradius( damage_center, radius * 1.5 );
    
    /#
        if ( getdvarint( @"hash_76626df25007facd" ) )
        {
            debug_color = targets.size == 0 ? ( 1, 1, 1 ) : ( 1, 0, 0 );
            sphere( damage_center, radius, ( 1, 1, 1 ), 1, 60 );
        }
    #/
    
    self radiusdamage( damage_center, radius, self.claw_attack_damage, self.claw_attack_damage, self, "MOD_MELEE" );
    
    foreach ( target in targets )
    {
        if ( !target || distancesquared( damage_center, target getcentroid() ) > radiussqrd )
        {
            continue;
        }
        
        if ( target.team == self.team )
        {
            target notify( #"hash_a0c8fe3d0fbe8d85" );
            continue;
        }
        
        if ( target isvehicleactive() )
        {
            continue;
        }
        
        zombie_callisto_wound::apply_wound( target );
        
        if ( isplayer( target ) )
        {
            target utility::knockback_flat( target.origin - body_center, 900 );
        }
    }
    
    vehicles = vehicle_getarrayinradius( damage_center, radius * 3 );
    var_3b76cacbe27598f3 = 0;
    
    foreach ( vehicle in vehicles )
    {
        boundshalfsize = vehicle getboundshalfsize();
        closestpoint = math::function_1243a6cc6a030f2a( self.origin, vehicle getcentroid(), boundshalfsize, vehicle.angles );
        
        if ( distancesquared( closestpoint, damage_center ) <= radiussqrd )
        {
            if ( !var_3b76cacbe27598f3 )
            {
                self setscriptablepartstate( #"clawvfx", #"on_veh", 0 );
                var_3b76cacbe27598f3 = 1;
            }
            
            zombie_callisto_wound::function_afb37cb1e8cf8ab8( damage_center, vehicle );
        }
    }
}

