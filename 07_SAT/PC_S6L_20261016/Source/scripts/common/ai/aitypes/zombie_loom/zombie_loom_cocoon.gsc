// scripts\common\ai\aitypes\zombie_loom\zombie_loom_cocoon.gsc  (hash_097d8348d617ab4a.gscc) (size: 7775 Bytes / 0x1e5f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x74059c5d (1946524765)
// size ...... 7775 (0x1e5f)
// includes .. 13  (offset: 0x1ceb)
// strings ... 20  (offset: 0x1d53)
// dev strs .. 0   (offset: 0x1e5f)
// exports ... 22  (offset: 0x10f7)
// cseg ...... 0x192 + 0xf65 (0x10f7)
// imports ... 74  (offset: 0x1467)
// animtree1 . 0   (offset: 0x1e5f)
// animtree2 . 0   (offset: 0x1e5f)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\ai\aitypes\zombie_loom\zombie_loom_web;
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_stun;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\zm_utility;

#namespace zombie_loom_cocoon;

// Namespace zombie_loom_cocoon
// Params 1
// Checksum 0x8afe1250, Offset: 0x1b0
// Size: 0x9c
function precache( aitypescriptbundle )
{
    var_22e5e17527a4b653 = getscriptbundle( "zombieaisettings:" + aitypescriptbundle.zombieaisetting );
    
    if ( var_22e5e17527a4b653 )
    {
        var_2239e8b9bfdd4e33 = getscriptbundlefieldvalue( var_22e5e17527a4b653.var_394d3c5e6fa40c50, #"hash_b3f24bff3c6b4f54" );
        var_a1c507b3b4cbfe6b = getscriptbundlefieldvalue( var_22e5e17527a4b653.var_394d3c5e6fa40c50, #"hash_ffdb282c6fad936b" );
    }
    
    if ( var_2239e8b9bfdd4e33 )
    {
        utility::add_fx( "loom_cocoon_oneshot", var_2239e8b9bfdd4e33 );
    }
    
    if ( var_a1c507b3b4cbfe6b )
    {
        utility::add_fx( "loom_cocoon_impact", var_a1c507b3b4cbfe6b );
    }
}

// Namespace zombie_loom_cocoon
// Params 0
// Checksum 0x53915931, Offset: 0x254
// Size: 0x42
function init_global()
{
    callback::get_template( self.animsetname ) callback::add( "out_playable_space", &out_playable_space );
    callback::get_template( self.animsetname ) callback::add( "in_playable_space", &in_playable_space );
}

// Namespace zombie_loom_cocoon
// Params 0
// Checksum 0xeb75fca4, Offset: 0x29e
// Size: 0x1d3
function init()
{
    self.var_99342d1bc5777121 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_99342d1bc5777121;
    self.var_e508d3d150ef12f3 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_e508d3d150ef12f3;
    self.var_21ad7d10138bed0a = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_21ad7d10138bed0a;
    self.var_10ff74dbc3145263 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_10ff74dbc3145263;
    self.cocoonmodel = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.cocoonmodel;
    self.var_80bdd5b7339864bd = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_80bdd5b7339864bd;
    self.var_e3b354d56829a28e = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_e3b354d56829a28e ) );
    self.cocoonduration = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.cocoonduration ) );
    self.var_4016a2314b839e98 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4016a2314b839e98;
    self.var_7e3f71d4e5078658 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7e3f71d4e5078658;
    self.var_117ffe14504a5d0d = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_117ffe14504a5d0d / 100;
    thread monitor_nearby_zombies();
    thread function_fb7caeb9049a7e6();
    thread function_486f2967d62b683d();
}

// Namespace zombie_loom_cocoon
// Params 1, eflags: 0x4
// Checksum 0xe96590da, Offset: 0x479
// Size: 0x2c
function private function_6949346401b6229c( var_f1fbc291f2430b1e )
{
    if ( var_f1fbc291f2430b1e )
    {
        self function_f2df0257c63f229( "disable_cocoon_attack" );
        return;
    }
    
    self function_786bb6aa1b76c7ee( "disable_cocoon_attack", 1 );
}

// Namespace zombie_loom_cocoon
// Params 1, eflags: 0x4
// Checksum 0xa49a390b, Offset: 0x4ad
// Size: 0x14
function private out_playable_space( params )
{
    function_6949346401b6229c( 0 );
}

// Namespace zombie_loom_cocoon
// Params 1, eflags: 0x4
// Checksum 0x8b071e5c, Offset: 0x4c9
// Size: 0x15
function private in_playable_space( params )
{
    function_6949346401b6229c( 1 );
}

// Namespace zombie_loom_cocoon
// Params 2
// Checksum 0x418c6552, Offset: 0x4e6
// Size: 0x54
function function_fa06a29f1f56226a( taskid, params )
{
    if ( self.var_65b01ce7e518592 && !self.cocoontarget )
    {
        self.cocoontarget = self.var_65b01ce7e518592;
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace zombie_loom_cocoon
// Params 0, eflags: 0x4
// Checksum 0xefbf5c1c, Offset: 0x543
// Size: 0x126
function private monitor_nearby_zombies()
{
    self endon( #"death" );
    
    while ( true )
    {
        self.var_65b01ce7e518592 = undefined;
        targets = getaiarrayinradius( self.origin, self.var_99342d1bc5777121, self.team );
        
        foreach ( target in targets )
        {
            if ( isalive( target ) && target.subclass == self.var_e508d3d150ef12f3 && !self.var_8dd8207f122a4702 && !target namespace_b76ff2659823e89d::is_crawling() )
            {
                if ( trace::ray_trace_passed( self.origin, target.origin, [ self, target ] ) )
                {
                    self.var_65b01ce7e518592 = target;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace zombie_loom_cocoon
// Params 0, eflags: 0x4
// Checksum 0xd719c8c4, Offset: 0x671
// Size: 0x80
function private function_fb7caeb9049a7e6()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_110aa6233804f33e" );
        dir = anglestoforward( self.angles );
        
        if ( self.cocoontarget )
        {
            dir = self.cocoontarget.origin - self.origin;
        }
        
        self orientmode( "face direction", dir );
        asm::function_7256f5ba459c840b( "cocoon_attack_in" );
    }
}

// Namespace zombie_loom_cocoon
// Params 0, eflags: 0x4
// Checksum 0x16207c75, Offset: 0x6f9
// Size: 0x2a
function private function_486f2967d62b683d()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_4f47a0bcf1a361ac" );
        fire_cocoon();
    }
}

// Namespace zombie_loom_cocoon
// Params 0, eflags: 0x4
// Checksum 0xd585bbb2, Offset: 0x72b
// Size: 0xaa
function private fire_cocoon()
{
    if ( !isdefined( self ) || !isalive( self.cocoontarget ) )
    {
        return;
    }
    
    start_pos = self gettagorigin( "tag_spinneret", 1 ) ?? ( 0, 0, 0 );
    projectile = spawn( "script_model", start_pos );
    projectile setmodel( self.var_80bdd5b7339864bd );
    projectile.owner = self;
    projectile utility::function_32b24db3127bff40( "spit", "aerial" );
    projectile thread move_projectile();
    self function_786bb6aa1b76c7ee( "cocoon_attack_time", gettime() + self.var_e3b354d56829a28e );
}

// Namespace zombie_loom_cocoon
// Params 0, eflags: 0x4
// Checksum 0xad465f30, Offset: 0x7dd
// Size: 0xfc
function private move_projectile()
{
    self endon( #"detonate" );
    target = self.owner.cocoontarget;
    
    while ( true )
    {
        if ( !isalive( target ) || !isalive( self.owner ) )
        {
            thread detonate_projectile( 0 );
        }
        
        traveldist = 350;
        direction = target getcentroid() - self.origin;
        disttotarget = length( direction );
        traveltime = 0.5;
        
        if ( disttotarget <= traveldist )
        {
            traveltime = disttotarget / 700;
            thread apply_cocoon( self.owner, traveltime, target );
            thread detonate_projectile( traveltime );
        }
        
        endpoint = self.origin + vectornormalize( direction ) * 700 * traveltime;
        self moveto( endpoint, traveltime );
        wait 0.5;
    }
}

// Namespace zombie_loom_cocoon
// Params 1, eflags: 0x4
// Checksum 0x2853bba9, Offset: 0x8e1
// Size: 0x75
function private detonate_projectile( delay )
{
    if ( delay )
    {
        wait delay;
    }
    
    if ( self )
    {
        if ( self.owner )
        {
            self.owner.cocoontarget = undefined;
        }
        
        self notify( #"detonate" );
        impactvfx = utility::getfx( "loom_cocoon_impact" );
        
        if ( impactvfx )
        {
            playfx( impactvfx, self.origin );
        }
        
        self delete();
    }
}

// Namespace zombie_loom_cocoon
// Params 3, eflags: 0x4
// Checksum 0x59d4dbdd, Offset: 0x95e
// Size: 0x126
function private apply_cocoon( owner, delay, target )
{
    target endon( #"death" );
    
    if ( delay )
    {
        wait delay;
    }
    
    target.var_8dd8207f122a4702 = 1;
    target namespace_f4f7019540228268::stun( "cocoon", 2, owner );
    origin = target.origin;
    angles = target.angles;
    cocoonvfx = utility::getfx( "loom_cocoon_oneshot" );
    
    if ( cocoonvfx )
    {
        playfxontag( cocoonvfx, target, #"j_spine4" );
    }
    
    target playsound( #"hash_f0f6c94693442887" );
    wait 2;
    
    if ( isalive( target ) && isalive( owner ) && owner.var_117ffe14504a5d0d )
    {
        spawn_health = int( target.maxhealth * owner.var_117ffe14504a5d0d );
        spawn_cocoon( origin, angles, owner, spawn_health );
        target.nocorpse = 1;
        target kill();
    }
}

// Namespace zombie_loom_cocoon
// Params 4
// Checksum 0xefb908d7, Offset: 0xa8c
// Size: 0xeb
function spawn_cocoon( origin, angles, owner, health )
{
    cocoon = spawn( "script_model", origin );
    cocoon.angles = angles;
    cocoon setmodel( owner.cocoonmodel );
    cocoon setcandamage( 1 );
    cocoon.var_2b5852f808241817 = health;
    cocoon.health = 1000000000;
    owner.cocoon = cocoon;
    cocoon thread function_53e7e1b92391e0( owner.var_7e3f71d4e5078658, owner.cocoonduration, owner );
    cocoon thread function_74a7935515eb6ad7( owner );
    cocoon thread function_aaf0e8188a9e06ae( owner );
    cocoon.var_e24a95dc2c99cedb = createnavobstaclebyent( cocoon );
    owner.var_865aafa52f1e6798 = 1;
    return cocoon;
}

// Namespace zombie_loom_cocoon
// Params 1, eflags: 0x4
// Checksum 0xe5723743, Offset: 0xb80
// Size: 0x206
function private function_74a7935515eb6ad7( owner )
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        self.health = 1000000000;
        
        if ( !isdefined( objweapon ) )
        {
            objweapon = level.weaponnone;
        }
        
        element = zombie_damage::get_element( objweapon, attacker, meansofdeath );
        dmgstruct = zombie_damage::build_damage_struct( inflictor, attacker, damage, idflags, meansofdeath, objweapon, point, direction_vec, undefined, undefined, undefined, undefined, objweapon );
        dmgstruct.idamage = zombie_damage::function_881dfa87252ee0ea( dmgstruct );
        damage = zombie_damage::function_cef159ba09a96f98( dmgstruct );
        self.var_2b5852f808241817 -= int( damage );
        var_c57ed7c52106c0f3 = 0;
        
        if ( self.var_2b5852f808241817 <= 0 )
        {
            var_c57ed7c52106c0f3 = 1;
        }
        
        if ( isplayer( attacker ) )
        {
            attacker namespace_9d8e359c3b1041e5::updatehitmarker_sharedfunc( "standard", var_c57ed7c52106c0f3 );
            
            if ( mp_agent_damage::function_e7d118eb7b017fa4() )
            {
                namespace_9d8e359c3b1041e5::displaydamagenumber_sharedfunc( attacker, self, "none", meansofdeath, objweapon, int( damage ), point ?? self.origin, 0, element, 0, 0 );
            }
        }
        
        if ( var_c57ed7c52106c0f3 )
        {
            attacker callback::callback( #"hash_da77bbca464577cd", { #objweapon:objweapon, #meansofdeath:meansofdeath, #attacker:attacker, #owner:owner, #cocoon:self } );
            thread cocoon_death( 1 );
        }
    }
}

// Namespace zombie_loom_cocoon
// Params 3, eflags: 0x4
// Checksum 0xbf2caecf, Offset: 0xd8e
// Size: 0xca
function private function_53e7e1b92391e0( radius, duration, owner )
{
    self endon( #"death" );
    
    if ( owner.var_659578f5e8d63be4 )
    {
        utility::ent_flag_wait( owner.var_659578f5e8d63be4 );
    }
    
    starttime = gettime();
    endtime = starttime + duration;
    
    while ( endtime > gettime() )
    {
        if ( isai( owner ) )
        {
            targets = owner function_f017e352a29a57a1( self.origin, radius );
        }
        else
        {
            targets = getplayersandaiarrayinradius( self.origin, radius, "allies" );
        }
        
        if ( targets.size )
        {
            break;
        }
        
        wait 0.2;
    }
    
    thread cocoon_explosion( owner );
}

// Namespace zombie_loom_cocoon
// Params 1, eflags: 0x4
// Checksum 0x25ecd274, Offset: 0xe60
// Size: 0x2f
function private function_aaf0e8188a9e06ae( owner )
{
    self endon( #"death" );
    owner waittill( #"death" );
    thread cocoon_death( 1 );
}

// Namespace zombie_loom_cocoon
// Params 1, eflags: 0x4
// Checksum 0xb5c154d1, Offset: 0xe97
// Size: 0x14e
function private cocoon_explosion( owner )
{
    self endon( #"death" );
    utility::function_32b24db3127bff40( "cocoon", "swell" );
    wait owner.var_4016a2314b839e98 ?? 0.2;
    
    if ( self && owner )
    {
        utility::function_32b24db3127bff40( "cocoon", "explode" );
        
        if ( owner.var_ad4d2bf5a002f6b0 )
        {
            owner thread zombie_loom_web::spawn_webbed_area( self.origin );
        }
        
        spawnpoints = get_nav_points_in_circle( self.origin, 8, owner.var_10ff74dbc3145263 );
        
        for ( i = 0; i < owner.var_10ff74dbc3145263 ; i++ )
        {
            active_zombie_count = zm_utility::get_active_zombies_count();
            zombies_capacity = level.var_a009ab14ee0d3223.var_63a0ca44b877a390 - active_zombie_count;
            
            if ( zombies_capacity > 0 )
            {
                zombie = agent_manager::spawn_agent( owner.var_21ad7d10138bed0a, spawnpoints[ i ] );
            }
            else
            {
                continue;
            }
            
            waitframe();
            
            if ( zombie && self.origin )
            {
                zombie zombie_knockdown::knockdown_ai_aerial( self.origin, 300 );
            }
        }
        
        thread cocoon_death( 0 );
    }
}

// Namespace zombie_loom_cocoon
// Params 3, eflags: 0x4
// Checksum 0xca12e06b, Offset: 0xfed
// Size: 0x95
function private get_nav_points_in_circle( center, radius, numpoints )
{
    navpoints = [];
    angleinterval = 360 / numpoints;
    
    for ( i = 0; i < numpoints ; i++ )
    {
        var_4d9eee75dfab990e = angleinterval * i;
        var_55d2772925afb982 = ( cos( var_4d9eee75dfab990e ) * radius, sin( var_4d9eee75dfab990e ) * radius, 0 ) + center;
        var_55d2772925afb982 = getclosestpointonnavmesh( var_55d2772925afb982 );
        navpoints[ navpoints.size ] = var_55d2772925afb982;
    }
    
    return navpoints;
}

// Namespace zombie_loom_cocoon
// Params 1, eflags: 0xc
// Checksum 0x816e60ce, Offset: 0x108b
// Size: 0x6c
function private cocoon_death( changestate )
{
    self notify( #"hash_e655b342b030b57a" );
    self endon( #"hash_e655b342b030b57a" );
    self notify( #"death" );
    
    if ( changestate && self )
    {
        utility::function_32b24db3127bff40( "cocoon", "death" );
    }
    
    if ( self.var_e24a95dc2c99cedb )
    {
        destroynavobstacle( self.var_e24a95dc2c99cedb );
    }
    
    waitframe();
    self delete();
}

