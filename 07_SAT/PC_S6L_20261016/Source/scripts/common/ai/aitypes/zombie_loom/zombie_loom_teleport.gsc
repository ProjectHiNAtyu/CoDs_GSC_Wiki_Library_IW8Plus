// scripts\common\ai\aitypes\zombie_loom\zombie_loom_teleport.gsc  (hash_0a6bb89f435fae48.gscc) (size: 5724 Bytes / 0x165c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x71bcf8de (1908209886)
// size ...... 5724 (0x165c)
// includes .. 8   (offset: 0x14f0)
// strings ... 20  (offset: 0x1530)
// dev strs .. 0   (offset: 0x165c)
// exports ... 17  (offset: 0xcb8)
// cseg ...... 0x19d + 0xb1b (0xcb8)
// imports ... 47  (offset: 0xf60)
// animtree1 . 0   (offset: 0x165c)
// animtree2 . 0   (offset: 0x165c)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_loom\zombie_loom_web;
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_stun;
#using scripts\common\utility;
#using scripts\mp\damage;

#namespace zombie_loom_teleport;

// Namespace zombie_loom_teleport
// Params 0
// Checksum 0x599e72e1, Offset: 0x1bb
// Size: 0x3b
function init_global()
{
    damage::register_scripted_damage_override_func( &function_a8069d32df25cbe9 );
    level zombie_utils::function_dfae6a5bd222c586( &function_d93b292d05ce36df );
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_19749c791e00b9c5 );
}

// Namespace zombie_loom_teleport
// Params 0
// Checksum 0x37e59707, Offset: 0x1fe
// Size: 0x201
function init()
{
    self.var_df48eb4a7a89040e = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_febbbaa00d05ba10 * self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_febbbaa00d05ba10;
    self.var_32bc9f9fe42b8b86 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_32bc9f9fe42b8b86;
    self.var_3ece61417224ddf1 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3ece61417224ddf1;
    self.var_340a0698ab4acfb0 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_340a0698ab4acfb0;
    self.var_697a0762533cf0dc = int( utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_697a0762533cf0dc ) );
    self.var_1f020bae64a95ff7 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_1f020bae64a95ff7 / 100;
    self.var_ad475a91b42f4984 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_ad475a91b42f4984;
    self.var_813b86c0b6e0d26a = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_813b86c0b6e0d26a;
    self.var_954c124eabff5788 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_954c124eabff5788;
    self.var_96e97fbe3ea3e89a = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_96e97fbe3ea3e89a;
    self.var_bd5f23704b45a25f = cos( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f14ea59ae00e45b7 );
    self function_786bb6aa1b76c7ee( "in_webbed_chase", 0 );
    self.var_a33ddc0b50b44729 = 0;
    thread function_52f998c396025e4d();
    thread function_c4c9733c9303c883();
    thread function_efb6176e1d82f687();
}

// Namespace zombie_loom_teleport
// Params 10, eflags: 0x4
// Checksum 0x5a9ccc15, Offset: 0x407
// Size: 0x93
function private function_a8069d32df25cbe9( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, psoffsettime )
{
    if ( zombie_loom_web::is_target_webbed( self ) && eattacker.animsetname == #"hash_9f1fe2d32f2efa15" )
    {
        idamage += eattacker.var_340a0698ab4acfb0;
        return idamage;
    }
}

// Namespace zombie_loom_teleport
// Params 1, eflags: 0x4
// Checksum 0x34c955b2, Offset: 0x4a2
// Size: 0x75
function private function_d93b292d05ce36df( params )
{
    idamage = params.idamage;
    
    if ( zombie_loom_web::is_target_webbed( self ) && params.eattacker.animsetname == #"hash_9f1fe2d32f2efa15" )
    {
        idamage = params.idamage + params.eattacker.var_340a0698ab4acfb0;
    }
    
    return idamage;
}

// Namespace zombie_loom_teleport
// Params 0, eflags: 0x4
// Checksum 0x41a03e33, Offset: 0x520
// Size: 0x155
function private function_52f998c396025e4d()
{
    self endon( #"death" );
    waitframe();
    
    while ( isalive( self ) )
    {
        if ( !isdefined( self.var_faf222187d896b76 ) && !self getaiblackboarddynamic( "in_teleport_attack" ) )
        {
            targets = self function_f017e352a29a57a1( self.origin, self.var_32bc9f9fe42b8b86 );
            var_28af1b57e8958345 = 0;
            
            foreach ( target in targets )
            {
                if ( isalive( target ) && zombie_loom_web::is_target_webbed( target ) )
                {
                    if ( distancesquared( target.origin, self.origin ) < self.var_df48eb4a7a89040e )
                    {
                        self function_786bb6aa1b76c7ee( "has_teleport_attack_target", 0 );
                        function_d415e268cb4f42f3( target );
                    }
                    else
                    {
                        self.var_a8ddd3811307cf26 = target;
                        self function_786bb6aa1b76c7ee( "has_teleport_attack_target", 1 );
                    }
                    
                    var_28af1b57e8958345 = 1;
                    break;
                }
            }
            
            if ( !var_28af1b57e8958345 )
            {
                self function_786bb6aa1b76c7ee( "has_teleport_attack_target", 0 );
            }
        }
        
        wait 0.2;
    }
}

// Namespace zombie_loom_teleport
// Params 0, eflags: 0x4
// Checksum 0x625bc48d, Offset: 0x67d
// Size: 0x70
function private function_c4c9733c9303c883()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_f367fd832f60098c" );
        self.var_a33ddc0b50b44729 = self.maxhealth * self.var_1f020bae64a95ff7;
        self function_786bb6aa1b76c7ee( "teleport_canceled", 0 );
        asm::function_7256f5ba459c840b( "teleport_in" );
        self function_786bb6aa1b76c7ee( "teleport_attack_time", gettime() + self.var_697a0762533cf0dc );
    }
}

// Namespace zombie_loom_teleport
// Params 0, eflags: 0x4
// Checksum 0x674cc827, Offset: 0x6f5
// Size: 0xaa
function private function_efb6176e1d82f687()
{
    self endon( #"death" );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "loom_teleport", "cancel_camo", "reset_eyeglow" );
        
        if ( self )
        {
            if ( msg == "loom_teleport" )
            {
                thread function_7924577776811974( self.var_a8ddd3811307cf26 );
                continue;
            }
            
            if ( msg == "reset_eyeglow" )
            {
                if ( self getaiblackboarddynamic( "in_webbed_chase" ) )
                {
                    utility::function_32b24db3127bff40( "eye_glow", "target" );
                }
                else
                {
                    utility::function_32b24db3127bff40( "eye_glow", "default" );
                }
                
                continue;
            }
            
            utility::function_32b24db3127bff40( "camouflage", "off" );
        }
    }
}

// Namespace zombie_loom_teleport
// Params 1, eflags: 0x4
// Checksum 0xefd172b2, Offset: 0x7a7
// Size: 0x53
function private function_19749c791e00b9c5( params )
{
    if ( self.var_a33ddc0b50b44729 > 0 )
    {
        self.var_a33ddc0b50b44729 -= params.idamage;
        
        if ( self.var_a33ddc0b50b44729 <= 0 )
        {
            self function_786bb6aa1b76c7ee( "in_teleport_pain", 1 );
        }
    }
}

// Namespace zombie_loom_teleport
// Params 1, eflags: 0x4
// Checksum 0xa54a2b4, Offset: 0x802
// Size: 0x71
function private function_7924577776811974( target )
{
    if ( !isdefined( target ) )
    {
        return;
    }
    
    teleportpos = function_99af90565a34c9f5( target );
    
    if ( !isdefined( teleportpos ) )
    {
        return;
    }
    
    teleportangles = vectortoangles( target.origin - teleportpos );
    self forceteleport( teleportpos, teleportangles );
    self.var_a33ddc0b50b44729 = 0;
    knockdown_nearby_ai( teleportpos );
    function_d415e268cb4f42f3( target );
}

// Namespace zombie_loom_teleport
// Params 1, eflags: 0x4
// Checksum 0xc502b02a, Offset: 0x87b
// Size: 0x1b1
function private function_99af90565a34c9f5( target )
{
    targetorigin = target.origin;
    targetyaw = target.angles[ 1 ];
    min_yaw = targetyaw - 60;
    max_yaw = targetyaw + 60;
    points = getrandomnavpoints( targetorigin, self.var_ad475a91b42f4984, 6, self, 0, 0, min_yaw, max_yaw, self.var_813b86c0b6e0d26a, "stairs" );
    
    if ( !isdefined( points ) )
    {
        points = getrandomnavpoints( targetorigin, self.var_ad475a91b42f4984, 6, self, 0, 0, undefined, undefined, self.var_813b86c0b6e0d26a, "stairs" );
    }
    
    point = undefined;
    unseenpoint = undefined;
    
    foreach ( p in points )
    {
        if ( p )
        {
            if ( isplayer( target ) )
            {
                forward = anglestoforward( target.angles );
                topoint = vectornormalize( p - target.origin );
                
                if ( vectordot( forward, topoint ) > self.var_bd5f23704b45a25f )
                {
                    point = p;
                    break;
                }
                else
                {
                    unseenpoint = p;
                }
                
                continue;
            }
            
            point = p;
            break;
        }
    }
    
    if ( !point && unseenpoint )
    {
        point = unseenpoint;
    }
    
    return point;
}

// Namespace zombie_loom_teleport
// Params 1, eflags: 0x4
// Checksum 0xb1b4a85c, Offset: 0xa35
// Size: 0xd4
function private knockdown_nearby_ai( origin )
{
    nearbyai = getaiarrayinradius( origin, self.var_954c124eabff5788 );
    
    foreach ( ai in nearbyai )
    {
        if ( ai == self || !isalive( ai ) )
        {
            continue;
        }
        
        if ( ai zombie_knockdown::function_99b2020a564d9c7e( origin ) )
        {
            ai zombie_knockdown::function_6fc167d4a3590991( origin );
            continue;
        }
        
        ai namespace_f4f7019540228268::stun( "loom_teleport", self.var_96e97fbe3ea3e89a, self );
    }
}

// Namespace zombie_loom_teleport
// Params 1, eflags: 0x4
// Checksum 0x6eadc75d, Offset: 0xb11
// Size: 0x6b
function private function_d415e268cb4f42f3( target )
{
    self.var_faf222187d896b76 = target;
    zombie_utils::set_ai_target_priority( target, "web_chase", 3 );
    self function_786bb6aa1b76c7ee( "in_webbed_chase", 1 );
    utility::function_32b24db3127bff40( "eye_glow", "target" );
    self enableavoidance( 0 );
    self.collide_with_ai_allies_smaller = 0;
    function_3c9bdcc1675d46a1();
    thread function_193ee888d7a773dc();
    thread function_606b46ecac572602();
}

// Namespace zombie_loom_teleport
// Params 0, eflags: 0x4
// Checksum 0x924536dc, Offset: 0xb84
// Size: 0x3b
function private function_3c9bdcc1675d46a1()
{
    current = self asmgetcurrentstate( self.asmname );
    
    if ( current == "move_loop" )
    {
        self asmsetstate( self.asmname, "move_in" );
    }
}

// Namespace zombie_loom_teleport
// Params 0, eflags: 0x4
// Checksum 0x97fb1bda, Offset: 0xbc7
// Size: 0x5e
function private function_f2d52b29efb5f778()
{
    self notify( #"hash_c59e324e14dc3eb" );
    self.var_faf222187d896b76 = undefined;
    zombie_utils::set_ai_target_priority( undefined, "web_chase", 3 );
    self function_786bb6aa1b76c7ee( "in_webbed_chase", 0 );
    utility::function_32b24db3127bff40( "eye_glow", "default" );
    self enableavoidance( 1 );
    self.collide_with_ai_allies_smaller = 1;
    function_3c9bdcc1675d46a1();
}

// Namespace zombie_loom_teleport
// Params 0, eflags: 0x4
// Checksum 0xecc09369, Offset: 0xc2d
// Size: 0x2f
function private function_193ee888d7a773dc()
{
    self endon( #"death" );
    self endon( #"hash_c59e324e14dc3eb" );
    wait self.var_3ece61417224ddf1;
    
    if ( self )
    {
        thread function_f2d52b29efb5f778();
    }
}

// Namespace zombie_loom_teleport
// Params 0, eflags: 0x4
// Checksum 0xfe013a37, Offset: 0xc64
// Size: 0x54
function private function_606b46ecac572602()
{
    self endon( #"death" );
    self endon( #"hash_c59e324e14dc3eb" );
    
    while ( isalive( self.var_faf222187d896b76 ) )
    {
        if ( !zombie_loom_web::is_target_webbed( self.var_faf222187d896b76 ) )
        {
            break;
        }
        
        wait 0.2;
    }
    
    if ( self )
    {
        thread function_f2d52b29efb5f778();
    }
}

