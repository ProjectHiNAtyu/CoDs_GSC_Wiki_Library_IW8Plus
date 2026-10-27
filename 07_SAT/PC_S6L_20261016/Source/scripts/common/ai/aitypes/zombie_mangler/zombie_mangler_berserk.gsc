// scripts\common\ai\aitypes\zombie_mangler\zombie_mangler_berserk.gsc  (hash_6be70be4ace2398d.gscc) (size: 3154 Bytes / 0xc52 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x673fef7d (1732243325)
// size ...... 3154 (0xc52)
// includes .. 5   (offset: 0xb6e)
// strings ... 13  (offset: 0xb96)
// dev strs .. 0   (offset: 0xc52)
// exports ... 8   (offset: 0x752)
// cseg ...... 0x14a + 0x608 (0x752)
// imports ... 24  (offset: 0x892)
// animtree1 . 0   (offset: 0xc52)
// animtree2 . 0   (offset: 0xc52)
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_mangler\zombie_mangler_ranged_attack;
#using scripts\common\callbacks;
#using scripts\common\values;

#namespace zombie_mangler_berserk;

// Namespace zombie_mangler_berserk
// Params 2
// Checksum 0xd5143f81, Offset: 0x168
// Size: 0x30
function function_b9a9d04e2d594f7e( taskid, params )
{
    function_dd6d54fa5b6feae8( self.var_1cb013481b1a3e53, 1 );
    return anim.success;
}

// Namespace zombie_mangler_berserk
// Params 0
// Checksum 0x7fd1e65a, Offset: 0x1a1
// Size: 0x141
function init_mangler_berserk()
{
    self.var_f6d3933fd9164ece = 0;
    self.var_2d030a5d0bc533a4 = 0;
    self.var_1cb013481b1a3e53 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_1edc27640ca420c7;
    self.var_a1c821881fc19b42 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_1f80bb250dd51086;
    self.enrage_timer_enabled = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.enragetimerenabled;
    self.var_4086dd0a0115ea82 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.enragetimer;
    self.enrage_timer_health_percentage = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d524d027bc0d3d73;
    self function_786bb6aa1b76c7ee( "proximity_berserk_range", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.proximityberserkrange );
    self function_786bb6aa1b76c7ee( "can_proximity_berserk", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.berserkinrange );
    
    if ( self.enrage_timer_enabled )
    {
        callback::add( "on_zombie_ai_damaged", &mangler_berserk_damage_callback );
    }
}

// Namespace zombie_mangler_berserk
// Params 1
// Checksum 0xd93fd704, Offset: 0x2ea
// Size: 0x4d
function mangler_berserk_damage_callback( params )
{
    if ( self.health / self.maxhealth < self.enrage_timer_health_percentage )
    {
        thread start_enrage_timer( self.var_4086dd0a0115ea82 );
        callback::remove( "on_zombie_ai_damaged", &mangler_berserk_damage_callback );
    }
}

// Namespace zombie_mangler_berserk
// Params 1, eflags: 0x4
// Checksum 0xee4b3a12, Offset: 0x33f
// Size: 0x3e
function private start_enrage_timer( duration )
{
    self endon( #"death" );
    wait duration;
    
    if ( !self.var_f6d3933fd9164ece )
    {
        self function_786bb6aa1b76c7ee( "show_berserk", 1 );
    }
    
    function_dd6d54fa5b6feae8( 0, 0 );
}

// Namespace zombie_mangler_berserk
// Params 2
// Checksum 0x73911a85, Offset: 0x385
// Size: 0xea
function function_dd6d54fa5b6feae8( duration, disable_ranged_attack )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( self.var_2d030a5d0bc533a4 )
    {
        return;
    }
    
    if ( self.var_f6d3933fd9164ece )
    {
        self notify( #"enter_berserk" );
        
        if ( !disable_ranged_attack )
        {
            namespace_aef48b18f1c4d84c::function_2685f4f10e1b1b49( 1 );
        }
    }
    else
    {
        thread function_44b000096c22d8f8();
    }
    
    self.var_f6d3933fd9164ece = 1;
    val::set( "mangler_pain", "pain", 0 );
    self enableavoidance( 0 );
    val::set( "mangler_berserk", "collide_with_ai_allies", 0 );
    self notify( #"vox_berserk" );
    
    if ( disable_ranged_attack )
    {
        namespace_aef48b18f1c4d84c::function_2685f4f10e1b1b49( 0 );
    }
    
    zombie_utils::function_a8ce00e0448cb6f0( "sprint", "mangler_berserk", 30 );
    
    if ( duration > 0 )
    {
        thread function_900eeb446ee8a29d( duration, disable_ranged_attack );
        return;
    }
    
    self.var_2d030a5d0bc533a4 = 1;
    self function_786bb6aa1b76c7ee( "can_proximity_berserk", 0 );
}

// Namespace zombie_mangler_berserk
// Params 2
// Checksum 0x6b694233, Offset: 0x477
// Size: 0xc8
function function_900eeb446ee8a29d( duration, disable_ranged_attack )
{
    self endon( #"death" );
    self endon( #"enter_berserk" );
    wait duration;
    self.var_f6d3933fd9164ece = 0;
    val::set( "mangler_pain", "pain", 1 );
    self notify( #"exit_berserk" );
    val::reset( "mangler_berserk", "collide_with_ai_allies" );
    self enableavoidance( 1 );
    zombie_utils::function_a8ce00e0448cb6f0( undefined, "mangler_berserk", 30 );
    
    if ( disable_ranged_attack )
    {
        namespace_aef48b18f1c4d84c::function_2685f4f10e1b1b49( 1 );
    }
    
    self function_786bb6aa1b76c7ee( "proximity_berserk_timer", gettime() + int( self.var_a1c821881fc19b42 * 1000 ) );
    self function_786bb6aa1b76c7ee( "in_proximity_berserk", 0 );
    self notify( #"vox_calmdown" );
}

// Namespace zombie_mangler_berserk
// Params 0
// Checksum 0xa36d095, Offset: 0x547
// Size: 0x20b
function function_44b000096c22d8f8()
{
    self endon( #"death" );
    self endon( #"exit_berserk" );
    
    while ( isdefined( self ) )
    {
        velocity = self.velocity;
        var_ec649bf9628b9bce = lengthsquared( velocity );
        var_a31efe9e906c523b = var_ec649bf9628b9bce >= 900;
        
        if ( var_a31efe9e906c523b )
        {
            var_e634391cd94f5e81 = 0.2;
            move_vector = velocity * var_e634391cd94f5e81;
            predicted_pos = self getcentroid() + move_vector;
            a_zombies = getaiarrayinradius( predicted_pos, 64 );
            
            foreach ( zombie in a_zombies )
            {
                if ( !isalive( zombie ) || zombie == self )
                {
                    continue;
                }
                
                if ( zombie.type == "zombie" && ( !isdefined( zombie.aicategory ) || zombie.aicategory == "normal" ) )
                {
                    facing_vec = anglestoforward( self.angles );
                    enemy_vec = zombie.origin - self.origin;
                    var_9daa30d9ff167aa7 = ( enemy_vec[ 0 ], enemy_vec[ 1 ], 0 );
                    facing_yaw_vec = ( facing_vec[ 0 ], facing_vec[ 1 ], 0 );
                    var_9daa30d9ff167aa7 = vectornormalize( var_9daa30d9ff167aa7 );
                    facing_yaw_vec = vectornormalize( facing_yaw_vec );
                    enemy_dot = vectordot( facing_yaw_vec, var_9daa30d9ff167aa7 );
                    
                    if ( enemy_dot < 0 )
                    {
                        continue;
                    }
                    
                    if ( !zombie._blackboard.zombieinknockdown )
                    {
                        zombie zombie_knockdown::function_6fc167d4a3590991( self.origin );
                    }
                }
            }
        }
        
        wait 0.2;
    }
}

