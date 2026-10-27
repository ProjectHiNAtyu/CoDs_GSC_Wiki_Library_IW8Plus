// script_16555c1140262e45  (hash_16555c1140262e45.gscc) (size: 13759 Bytes / 0x35bf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2275d1c4 (578146756)
// size ...... 13759 (0x35bf)
// includes .. 9   (offset: 0x33d3)
// strings ... 27  (offset: 0x341b)
// dev strs .. 1   (offset: 0x35b3)
// exports ... 35  (offset: 0x20a7)
// cseg ...... 0x1ad + 0x1efa (0x20a7)
// imports ... 114 (offset: 0x261f)
// animtree1 . 0   (offset: 0x35bf)
// animtree2 . 0   (offset: 0x35bf)
#using script_61b40095fd0502f0;
#using scripts\common\trace;
#using scripts\common\turret;
#using scripts\common\utility;
#using scripts\common\vehicle_compass;
#using scripts\common\vehicle_tracking;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\emp_debuff;

#namespace dawg_turret;

// Namespace dawg_turret
// Params 2
// Checksum 0x8add3cac, Offset: 0x1cb
// Size: 0x24e
function function_32b910e01be89a47( vehicle, xmodel )
{
    dawg = self;
    dawg endon( #"death" );
    spawndata = { #angles:( 0, 0, 0 ), #targetname:vehicle, #vehicletype:vehicle, #modelname:xmodel, #origin:dawg.origin };
    faildata = spawnstruct();
    turret = vehicle_tracking::spawn_vehicle( spawndata, faildata );
    
    if ( !turret )
    {
        assertmsg( "<dev string:x24>" + faildata );
        return;
    }
    
    turret.var_f03df248f063c1c7 = turret gettagorigin( "tag_gunner_flash1" ) - turret.origin;
    turret thread dawg_turret_link( dawg );
    turret.dawg = dawg;
    dawg.turret = turret;
    turret.team = dawg.team;
    turret.script_team = dawg.team;
    turret.killcament = dawg.killcament;
    turret.var_8affbb79c07337fb = 0;
    turret.owner = dawg;
    
    if ( turret.team )
    {
        turret setvehicleteam( turret.team );
    }
    
    turret setnodeploy( 1 );
    turret setturretscriptcontrolled( 1, 0 );
    turret.damagecallback = &dawg_turret_damage_override;
    turret setturrettargetlocalangles( dawg.angles, 0, 1 );
    
    if ( dawg.health > 0 )
    {
        turret function_609516267ed6c6b3();
    }
    
    bundle = self.streakinfo.bundle ?? level.streakglobals.streakbundles[ "dawg" ];
    
    if ( bundle.var_94c8f39d76329f98 )
    {
        dawg emp_debuff::set_apply_emp_callback( &dawg::on_emp_applied );
        emp_debuff::add_emp_ent( dawg );
        dawg emp_debuff::set_clear_emp_callback( &dawg::on_emp_cleared );
    }
    
    turret thread dawg_turret_delete_on_death( dawg );
}

// Namespace dawg_turret
// Params 1
// Checksum 0x451ec6f8, Offset: 0x421
// Size: 0x38
function dawg_turret_link( dawg )
{
    waitframe();
    
    if ( self )
    {
        self linkto( dawg, "tag_turret_null", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
}

// Namespace dawg_turret
// Params 1
// Checksum 0x8434265e, Offset: 0x461
// Size: 0x108
function dawg_turret_set_owner( owner )
{
    turret = self.turret;
    turret.owner = owner;
    turret.team = owner.team;
    turret.script_team = owner.team;
    turret.dawg = self;
    turret setotherent( owner );
    turret setvehicleteam( owner.team );
    level notify( #"highvis_reload_outline", owner.team, [ turret ], 1 );
    turret enableplayermarks( #"killstreak" );
    vehicle_compass::vehicle_show( self.turret );
    
    if ( level.teambased )
    {
        turret filteroutplayermarks( owner.team );
    }
    else
    {
        turret filteroutplayermarks( owner );
    }
    
    if ( self.mode == "inactive" )
    {
        turret dawg_turret_stop();
    }
}

// Namespace dawg_turret
// Params 0
// Checksum 0x19651146, Offset: 0x571
// Size: 0x3a
function function_609516267ed6c6b3()
{
    dawg_turret_stop();
    thread function_a5d5df0778eccb9b();
    thread turret::function_912c602e8d3066fe( 0 );
    thread turret::function_1210e1b3a51df4a( 0 );
    turret::function_99ed6a1bb065a301( 1 );
    utility::function_32b24db3127bff40( "behavior", "idle" );
}

// Namespace dawg_turret
// Params 0
// Checksum 0xd5b580c2, Offset: 0x5b3
// Size: 0x36
function dawg_turret_stop()
{
    self notify( #"stop_turret" );
    turret::function_9a0fa09f3acbc0cd( 0 );
    self.visibletarget = undefined;
    
    if ( isdefined( self ) )
    {
        utility::function_32b24db3127bff40( "behavior", "off" );
    }
}

// Namespace dawg_turret
// Params 0
// Checksum 0xf997bc2, Offset: 0x5f1
// Size: 0xa
function function_1943eb45c441101d()
{
    turret::function_99ed6a1bb065a301( 0 );
}

// Namespace dawg_turret
// Params 0
// Checksum 0x8d08958a, Offset: 0x603
// Size: 0xb
function function_84db7c188ab0137f()
{
    turret::function_99ed6a1bb065a301( 1 );
}

// Namespace dawg_turret
// Params 0
// Checksum 0xad54b98b, Offset: 0x616
// Size: 0x1d
function dawg_turret_reset_turret()
{
    dawg_turret_stop();
    self setturrettargetlocalangles( ( 0, 0, 0 ), 0 );
}

// Namespace dawg_turret
// Params 14, eflags: 0x4
// Checksum 0x40fc8139, Offset: 0x63b
// Size: 0x99
function private dawg_turret_damage_override( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid )
{
    self.dawg dodamage( damage, point, attacker, inflictor, meansofdeath, objweapon, hitloc );
}

// Namespace dawg_turret
// Params 1, eflags: 0x4
// Checksum 0xaedeea5a, Offset: 0x6dc
// Size: 0x27
function private dawg_turret_delete_on_death( dawg )
{
    dawg waittill( #"death" );
    
    if ( isdefined( self ) )
    {
        vehicle_tracking::delete_vehicle( self );
    }
}

// Namespace dawg_turret
// Params 1
// Checksum 0x19d25341, Offset: 0x70b
// Size: 0x294
function function_6fde3b7a86fceb16( dawg )
{
    var_a6cc0e69a3ee461f = dawg.team == "axis" ? dawg.dawgaisettings.var_6a7a70f3ad78ede2 : dawg.dawgaisettings.var_a6cc0e69a3ee461f;
    var_1e5b09e7ee3aa1ca = dawg.team == "axis" ? dawg.dawgaisettings.var_8c93ab488fd24de5 : dawg.dawgaisettings.var_1e5b09e7ee3aa1ca;
    bundle = level.streakglobals.streakbundles[ "dawg" ];
    
    foreach ( model_override in bundle.var_5aec7880d7929a2b )
    {
        if ( getdvarint( model_override.dvarstring, 0 ) )
        {
            var_1e5b09e7ee3aa1ca = ( dawg.team == "axis" ? model_override.var_8c93ab488fd24de5 : model_override.var_1e5b09e7ee3aa1ca ) ?? var_1e5b09e7ee3aa1ca;
            break;
        }
    }
    
    function_32b910e01be89a47( var_a6cc0e69a3ee461f, var_1e5b09e7ee3aa1ca );
    var_5d9554d97272ef8a = combineanglesinverted( dawg.angles, dawg.turret getturretworldangles( 0 ) );
    self.turret setturrettargetlocalangles( var_5d9554d97272ef8a, 0, 1 );
    
    if ( dawg.owner && dawg.owner.team )
    {
        self.turret.owner = dawg.owner;
        self.turret.team = dawg.owner.team;
        self.turret setotherent( dawg.owner );
        self.turret setvehicleteam( dawg.owner.team );
    }
    
    self.turret utility::function_32b24db3127bff40( #"body_damage", #"heavy" );
}

// Namespace dawg_turret
// Params 2
// Checksum 0x15c572f3, Offset: 0x9a7
// Size: 0x206
function dawg_turret_can_see( target, targetpos )
{
    if ( !target || !isalive( target ) || !targetpos )
    {
        return 0;
    }
    
    if ( distancesquared( self.dawg.origin, target.origin ) > self.dawg.dawgaisettings.var_43320c63df966406 * self.dawg.dawgaisettings.var_43320c63df966406 )
    {
        var_29f7e92317bca10d = function_23e7dcb26e87530a( target );
        
        if ( !var_29f7e92317bca10d || !var_29f7e92317bca10d.var_dac2ec922e3d562f )
        {
            return 0;
        }
    }
    
    fov = self.dawg.mode == "sentry" ? self.dawg.dawgaisettings.var_747d367c2f7c580b : self.dawg.dawgaisettings.var_db96981a1cfe18f6;
    
    if ( !withinfov2d( self.dawg.origin, self.dawg.angles, target.origin, cos( fov / 2 ) ) )
    {
        return 0;
    }
    
    if ( isplayer( target ) && isdefined( target.perks[ "specialty_blindeye" ] ) )
    {
        return 0;
    }
    
    if ( !self isturrettargetvalid( target ) )
    {
        return 0;
    }
    
    if ( utility::issharedfuncdefined( #"dawg", #"dawg_turret_can_see" ) )
    {
        var_cea7c9868d7b2738 = utility::callsharedfunc( #"dawg", #"dawg_turret_can_see", target );
        
        if ( !var_cea7c9868d7b2738 )
        {
            return 0;
        }
    }
    
    ignore = target.vehicle ?? target;
    return self vehicle_canturrettargetpoint( targetpos, 1, ignore, self.activeturret );
}

// Namespace dawg_turret
// Params 3
// Checksum 0xf3948f91, Offset: 0xbb6
// Size: 0x141, Type: bool
function function_5127e75d2d0785fc( pos, targetpos, target )
{
    if ( !pos )
    {
        pos = self.dawg.origin;
    }
    
    contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0 );
    ignorelist = [ self.dawg ];
    ignorelist = arraycombine( ignorelist, self.dawg getlinkedchildren( 1 ) );
    
    if ( target )
    {
        ignorelist[ ignorelist.size ] = target;
        ignorelist = arraycombine( ignorelist, target getlinkedchildren( 1 ) );
    }
    
    targetdir = targetpos - pos;
    dirangles = vectortoangles( targetdir );
    offset = rotatevector( self.var_f03df248f063c1c7, dirangles );
    startpos = pos + ( 0, 0, 24 ) + offset;
    endpos = targetpos;
    result = physics_spherecast( startpos, endpos, self.dawg.dawgaisettings.var_ab2742213984266a, contents, ignorelist, "physicsquery_any" );
    return !result;
}

// Namespace dawg_turret
// Params 0, eflags: 0x4
// Checksum 0x5be29439, Offset: 0xd00
// Size: 0x4de
function private function_a5d5df0778eccb9b()
{
    self endon( #"death" );
    dawg = self.dawg;
    bundle = level.streakglobals.streakbundles[ "dawg" ];
    dawg endon( #"death" );
    self endon( #"stop_turret" );
    self.var_c4c081ead807080e = gettime() + self.dawg.dawgaisettings.var_53a9953f93533 * 1000;
    self.var_bc78abf1e3128c84 = 0;
    self.var_5961ea846473b0bc = 0;
    self.activeturret = 0;
    function_832f350dfec1ef64();
    
    while ( true )
    {
        target = function_f56c3efc95431066();
        
        if ( getdvarint( @"hash_354af68d1313857f", 0 ) && self.visibletarget )
        {
            self.activeturret = 1;
        }
        
        targetpos = function_2670602032fe9baa( target );
        
        if ( dawg_turret_can_see( target, targetpos ) )
        {
            self setturrettargetent( target, targetpos - target.origin, 0 );
            
            if ( self.activeturret == 0 )
            {
                if ( !( self.visibletarget === target ) )
                {
                    self function_d143ff6924adc05f( 1, 0 );
                    self.var_bc78abf1e3128c84 = max( self.var_bc78abf1e3128c84, gettime() + function_b3ed6561156c7601( target ) );
                    
                    if ( !function_c1b53b55277dc1cb( target ) && self getscriptablepartstate( "behavior" ) == "idle" )
                    {
                        utility::function_32b24db3127bff40( "behavior", "minigun_warning" );
                    }
                    
                    remember_target( target, 0 );
                }
                
                if ( self getscriptablepartstate( "behavior" ) != "minigun_warning" )
                {
                    utility::function_32b24db3127bff40( "behavior", "minigun_aiming" );
                }
            }
            else if ( self.activeturret == 1 )
            {
                if ( !( self.visibletarget === target ) )
                {
                    remember_target( target, 0 );
                }
                
                self function_d143ff6924adc05f( 1, 0 );
                
                if ( gettime() - function_fc97080ff8390508( target ) > self.dawg.dawgaisettings.var_eba7e927c5c2c8df * 1000 && function_5127e75d2d0785fc( self.dawg dawg::function_9e69e54edba11c79(), targetpos, target ) )
                {
                    self.missiletargetpos = targetpos;
                    self.dawg dawg::function_58c0d015f8ec4204();
                }
            }
            
            self.visibletarget = target;
        }
        else
        {
            if ( self.visibletarget && !self.missiletargetpos )
            {
                utility::function_32b24db3127bff40( "behavior", "disengaged" );
            }
            
            if ( self.missiletargetpos && self.activeturret == 1 )
            {
                self setturrettargetvec( self.missiletargetpos, 0 );
            }
            else if ( self.dawg.mode == "sentry" )
            {
                if ( self getturrettargetent( 0 ) )
                {
                    self clearturrettarget( 0 );
                }
            }
            else
            {
                self setturrettargetlocalangles( ( 0, 0, 0 ), 0 );
            }
            
            self.visibletarget = undefined;
        }
        
        if ( function_f1026959cc5e668e() )
        {
            if ( !self.missilefiring )
            {
                var_13b2c075f2c86e0b = self.dawg asmgetcurrentstate( self.dawg.asmname ) == "sentry_mode";
                
                if ( var_13b2c075f2c86e0b )
                {
                    self.missilefiring = 1;
                    self.var_bc78abf1e3128c84 = max( self.var_bc78abf1e3128c84, gettime() + function_b3ed6561156c7601( target ) );
                    utility::function_32b24db3127bff40( "behavior", "missile_aiming" );
                    self laseron();
                    
                    if ( bundle.var_af1c62a26ad1eacf && isplayer( target ) )
                    {
                        target playsoundtoplayer( bundle.var_af1c62a26ad1eacf, target );
                    }
                }
            }
        }
        else
        {
            self laseroff();
            self.missiletargetpos = undefined;
        }
        
        if ( function_3d898a6e6245584() )
        {
            if ( self.activeturret == 0 )
            {
                self function_d143ff6924adc05f( 0, 0 );
                utility::function_32b24db3127bff40( "behavior", "firing" );
            }
            else if ( self.activeturret == 1 )
            {
                function_2338f8b03601f0ce();
                self.missilefiring = undefined;
                utility::function_32b24db3127bff40( "behavior", "disengaged" );
            }
            
            remember_target( self.visibletarget, 1 );
            self.var_5961ea846473b0bc = gettime();
        }
        
        function_b334d4c618e8aa03();
        
        if ( getdvarint( @"hash_d4ff542145583a4b", 0 ) == 1 )
        {
            if ( self.activeturret == 0 )
            {
                self requestfireweapon( 0 );
            }
        }
        else if ( getdvarint( @"hash_d4ff542145583a4b", 0 ) == 2 )
        {
            self function_d143ff6924adc05f( 1, 0 );
            self.var_c4c081ead807080e = gettime() + 1000;
        }
        
        wait 0.1;
    }
}

// Namespace dawg_turret
// Params 0, eflags: 0x4
// Checksum 0x6a2ef97d, Offset: 0x11e6
// Size: 0x10e
function private function_f56c3efc95431066()
{
    if ( function_ad45319fa35f9caa() )
    {
        if ( !function_93f102af1ac25c29() )
        {
            self.activeturret = 0;
            return self.dawg dawg::function_3f8db38ff773ac8d();
        }
        
        if ( function_f1026959cc5e668e() || function_b1234368dcc2ced7( self.visibletarget ) )
        {
            return self.visibletarget;
        }
        
        self.activeturret = 1;
        
        if ( gettime() - 0.1 < self.var_c4c081ead807080e )
        {
            grouptarget = function_70e979d744427e8b();
            
            if ( grouptarget )
            {
                return grouptarget;
            }
        }
        
        enemy = self.dawg dawg::function_3f8db38ff773ac8d();
        
        if ( enemy )
        {
            if ( function_b1234368dcc2ced7( enemy ) )
            {
                if ( dawg_turret_can_see( enemy ) )
                {
                    return enemy;
                }
            }
            else
            {
                self.activeturret = 0;
                return enemy;
            }
        }
        
        killstreaktarget = function_8fc46193ce84982e();
        
        if ( killstreaktarget )
        {
            return killstreaktarget;
        }
        
        return;
    }
    
    self.activeturret = 0;
    return self.dawg dawg::function_3f8db38ff773ac8d();
}

// Namespace dawg_turret
// Params 1, eflags: 0x4
// Checksum 0xb070185, Offset: 0x12fc
// Size: 0x126
function private function_2670602032fe9baa( target )
{
    if ( self.force_target && target.var_e4951b26b66770ee )
    {
        return target.var_e4951b26b66770ee;
    }
    else if ( isplayer( target ) )
    {
        return ( target gettagorigin( "j_spine4", 1 ) ?? target.origin );
    }
    else if ( isagent( target ) )
    {
        if ( target utility::issharedfuncdefined( #"dawg", #"hash_68c0b8ef4583cbb9" ) )
        {
            target_loc = target utility::callsharedfunc( #"dawg", #"hash_68c0b8ef4583cbb9" );
            
            if ( isdefined( target_loc ) )
            {
                return target_loc;
            }
        }
        
        if ( target.var_1e0c6c188b1cfd56 )
        {
            return target gettagorigin( target.var_1e0c6c188b1cfd56 );
        }
        
        return target getcentroid();
    }
    else if ( target.streakname )
    {
        return function_793940d5a5b11936( target );
    }
    else if ( target && target gettagorigin( "tag_base", 1 ) )
    {
        return target gettagorigin( "tag_base", 1 );
    }
    
    return target.origin;
}

// Namespace dawg_turret
// Params 1, eflags: 0x4
// Checksum 0x6faf4393, Offset: 0x142b
// Size: 0xa1
function private function_793940d5a5b11936( target )
{
    var_29f7e92317bca10d = function_23e7dcb26e87530a( target );
    
    if ( var_29f7e92317bca10d )
    {
        if ( var_29f7e92317bca10d.ref == "remote_robot" )
        {
            return ( target gettagorigin( "j_spine4", 1 ) ?? target.origin );
        }
        
        pos = target.origin;
        
        if ( var_29f7e92317bca10d.shootatcentroid )
        {
            pos = target getcentroid();
        }
        
        pos += var_29f7e92317bca10d.zoffset * ( 0, 0, 1 );
        return pos;
    }
}

// Namespace dawg_turret
// Params 1, eflags: 0x4
// Checksum 0xfa2a178c, Offset: 0x14d5
// Size: 0x156
function private function_b3ed6561156c7601( target )
{
    if ( self.activeturret == 0 )
    {
        targetinfo = function_c1b53b55277dc1cb( target );
        
        if ( getdvarint( @"hash_74ddabe695e8478", 0 ) )
        {
            delay = 0;
        }
        else if ( targetinfo.var_c7c9f000f8a62b38 )
        {
            delay = self.dawg.dawgaisettings.var_d28e878d2a0e2811;
        }
        else if ( gettime() - self.var_5961ea846473b0bc < self.dawg.dawgaisettings.var_661ea1fdb3b0e70d * 1000 )
        {
            delay = self.dawg.dawgaisettings.var_88ee7431f26db99a;
        }
        else
        {
            delay = self.dawg.dawgaisettings.var_908a4957f43e8a8a;
        }
    }
    else if ( self.activeturret == 1 )
    {
        delay = self.dawg.dawgaisettings.var_6e93cfb667806276;
    }
    
    if ( self.dawg.var_af81e0df169020e8 )
    {
        delay *= self.dawg.var_af81e0df169020e8;
    }
    
    return delay * 1000;
}

// Namespace dawg_turret
// Params 0
// Checksum 0x8628bf2, Offset: 0x1634
// Size: 0x7e
function function_3d898a6e6245584()
{
    if ( getdvarint( @"hash_d4ff542145583a4b", 0 ) && self.activeturret == 1 && self.var_bc78abf1e3128c84 < gettime() )
    {
        return 1;
    }
    
    if ( self.var_bc78abf1e3128c84 > gettime() )
    {
        return 0;
    }
    
    if ( self.activeturret == 0 )
    {
        return turret::function_d2a9430b5ab39ab1( 0 );
    }
    else if ( self.activeturret == 1 )
    {
        return self.missilefiring;
    }
    
    return 0;
}

// Namespace dawg_turret
// Params 0, eflags: 0x4
// Checksum 0xe00ec012, Offset: 0x16bb
// Size: 0x46, Type: bool
function private function_ad45319fa35f9caa()
{
    if ( self.missilefiring )
    {
        return true;
    }
    
    return self.canfiremissiles && self.var_c4c081ead807080e && self.var_c4c081ead807080e < gettime() && self function_4a982264b67c1076( 1 ) > 0;
}

// Namespace dawg_turret
// Params 1, eflags: 0x4
// Checksum 0x309b3707, Offset: 0x170a
// Size: 0x70, Type: bool
function private function_b1234368dcc2ced7( target )
{
    return target && distance2dsquared( target.origin, self.dawg.origin ) >= self.dawg.dawgaisettings.var_5d8f188f4860eb1e * self.dawg.dawgaisettings.var_5d8f188f4860eb1e;
}

// Namespace dawg_turret
// Params 0
// Checksum 0x859e3a96, Offset: 0x1783
// Size: 0x1b, Type: bool
function function_f1026959cc5e668e()
{
    return self.activeturret == 1 && self.missiletargetpos;
}

// Namespace dawg_turret
// Params 0, eflags: 0x4
// Checksum 0x5f2a8072, Offset: 0x17a7
// Size: 0x6b, Type: bool
function private function_93f102af1ac25c29()
{
    target = self.visibletarget;
    
    if ( function_f1026959cc5e668e() )
    {
        return true;
    }
    
    lastseen = function_fc97080ff8390508( target );
    
    if ( lastseen && gettime() - lastseen >= self.dawg.dawgaisettings.var_10444dd5203a45b0 * 1000 )
    {
        return false;
    }
    
    return true;
}

// Namespace dawg_turret
// Params 0, eflags: 0x4
// Checksum 0x35e02f93, Offset: 0x181b
// Size: 0x11
function private function_2338f8b03601f0ce()
{
    thread function_fd14050eec2cafe6();
    self fireweapon( 1 );
}

// Namespace dawg_turret
// Params 0, eflags: 0x4
// Checksum 0x141d929d, Offset: 0x1834
// Size: 0x153
function private function_fd14050eec2cafe6()
{
    self waittill( #"vehicle_turret_fire", index, firebarrel, projectile );
    missile = projectile;
    
    if ( missile )
    {
        missile.streakinfo = self.streakinfo;
        missile.killcament = self.killcament;
        
        if ( self.visibletarget )
        {
            missile missile_settargetent( self.visibletarget, function_2670602032fe9baa( self.visibletarget ) - self.visibletarget.origin );
        }
        else if ( self.missiletargetpos )
        {
            missile missile_settargetpos( self.missiletargetpos );
        }
        else
        {
            missile missile_settargetpos( self.origin );
        }
        
        function_9eef91098ee1e371( self function_4a982264b67c1076( 1 ) );
        self.var_c4c081ead807080e = gettime() + self.dawg.dawgaisettings.missilecooldown * 1000;
        self.var_bc78abf1e3128c84 = gettime() + self.dawg.dawgaisettings.var_93d81c17f963b491 * 1000;
    }
    
    self notify( #"hash_42f0748f5698f1b4" );
}

// Namespace dawg_turret
// Params 0, eflags: 0x4
// Checksum 0x66a7df90, Offset: 0x198f
// Size: 0x17d
function private function_70e979d744427e8b()
{
    missileweapon = self getturretweapon( 1 );
    explosionrange = getweaponexplosionradius( missileweapon.basename );
    besttarget = undefined;
    var_9ac785c10d59f6ca = 1;
    targetlist = turret::function_59f86fe04b48ff46( 1 );
    
    foreach ( player in targetlist )
    {
        if ( player.team == self.team )
        {
            continue;
        }
        
        if ( !function_b1234368dcc2ced7( player ) )
        {
            continue;
        }
        
        group = player_utility::script_getplayersinradius( player.origin, explosionrange, player.team );
        
        if ( group.size < var_9ac785c10d59f6ca )
        {
            continue;
        }
        
        if ( group.size == var_9ac785c10d59f6ca && besttarget && distance2dsquared( player.origin, self.origin ) > distance2dsquared( besttarget.origin, self.origin ) )
        {
            continue;
        }
        
        if ( !dawg_turret_can_see( player ) )
        {
            continue;
        }
        
        besttarget = player;
        var_9ac785c10d59f6ca = group.size;
    }
    
    return besttarget;
}

// Namespace dawg_turret
// Params 0, eflags: 0x4
// Checksum 0xa8f8aea1, Offset: 0x1b15
// Size: 0x130
function private function_8fc46193ce84982e()
{
    killstreaklist = [];
    
    foreach ( killstreak in level.activekillstreaks )
    {
        if ( killstreak.team == self.team )
        {
            continue;
        }
        
        killstreaklist[ killstreaklist.size ] = killstreak;
    }
    
    foreach ( killstreak in killstreaklist )
    {
        targetpos = function_793940d5a5b11936( killstreak );
        
        if ( targetpos && dawg_turret_can_see( killstreak, targetpos ) )
        {
            self.var_2e3ef3d421a8ac45 = targetpos;
            return killstreak;
        }
    }
}

// Namespace dawg_turret
// Params 1, eflags: 0x4
// Checksum 0xf788e1e3, Offset: 0x1c4e
// Size: 0x141
function private function_23e7dcb26e87530a( target )
{
    if ( isplayer( target ) && target.isjuggernaut && killstreaks::function_b5fe8b8e8c5ce798( "remote_robot" ) && target.takedamage )
    {
        ref = "remote_robot";
    }
    else if ( target.streakname )
    {
        ref = target.streakname;
    }
    
    if ( self.var_42239aeecd0ca25f.ref == ref )
    {
        return self.var_42239aeecd0ca25f;
    }
    
    if ( ref )
    {
        foreach ( var_29f7e92317bca10d in self.dawg.dawgaisettings.var_2bc63f39aa397507 )
        {
            if ( var_29f7e92317bca10d.ref == ref )
            {
                self.var_42239aeecd0ca25f = var_29f7e92317bca10d;
                return self.var_42239aeecd0ca25f;
            }
        }
    }
}

// Namespace dawg_turret
// Params 1, eflags: 0x4
// Checksum 0xcfc06fad, Offset: 0x1d98
// Size: 0xa0
function private function_9eef91098ee1e371( count )
{
    state = "";
    
    switch ( count )
    {
        case 0:
            state = "zero";
            break;
        case 1:
            state = "one";
            break;
        case 2:
            state = "two";
            break;
        case 3:
            state = "three";
            break;
        default:
            state = "four";
            break;
    }
    
    utility::function_32b24db3127bff40( "missile_count", state );
}

// Namespace dawg_turret
// Params 1
// Checksum 0x5345d598, Offset: 0x1e40
// Size: 0x3c
function function_832f350dfec1ef64( canfiremissiles )
{
    if ( self.dawg.dawgaisettings.canfiremissiles )
    {
        self.canfiremissiles = canfiremissiles ?? 1;
    }
}

// Namespace dawg_turret
// Params 2, eflags: 0x4
// Checksum 0xae24879e, Offset: 0x1e84
// Size: 0xa0
function private remember_target( target, var_c7c9f000f8a62b38 )
{
    if ( !target )
    {
        return;
    }
    
    key = target getentitynumber();
    
    if ( !isdefined( self.var_e700b17ca56d28d2 ) )
    {
        self.var_e700b17ca56d28d2 = [];
    }
    
    self.var_e700b17ca56d28d2[ key ] = spawnstruct();
    self.var_e700b17ca56d28d2[ key ].entity = target;
    self.var_e700b17ca56d28d2[ key ].timestamp = gettime();
    self.var_e700b17ca56d28d2[ key ].var_c7c9f000f8a62b38 = var_c7c9f000f8a62b38;
}

// Namespace dawg_turret
// Params 1, eflags: 0x4
// Checksum 0xae7dfad3, Offset: 0x1f2c
// Size: 0x26
function private function_c1b53b55277dc1cb( target )
{
    if ( target )
    {
        return self.var_e700b17ca56d28d2[ target getentitynumber() ];
    }
    
    return;
}

// Namespace dawg_turret
// Params 1, eflags: 0x4
// Checksum 0x717e43dc, Offset: 0x1f5a
// Size: 0x32, Type: bool
function private function_fc97080ff8390508( target )
{
    info = function_c1b53b55277dc1cb( target );
    return info.timestamp ?? gettime();
}

// Namespace dawg_turret
// Params 0, eflags: 0x4
// Checksum 0x77a73ac4, Offset: 0x1f95
// Size: 0x112
function private function_b334d4c618e8aa03()
{
    if ( !isdefined( self.var_e700b17ca56d28d2 ) )
    {
        self.var_e700b17ca56d28d2 = [];
    }
    
    foreach ( key in getarraykeys( self.var_e700b17ca56d28d2 ) )
    {
        targetinfo = self.var_e700b17ca56d28d2[ key ];
        
        if ( targetinfo.entity == self.visibletarget )
        {
            continue;
        }
        
        if ( !isalive( targetinfo.entity ) || gettime() - targetinfo.timestamp > self.dawg.dawgaisettings.var_c613cf7df77793de * 1000 )
        {
            self.var_e700b17ca56d28d2[ key ] = undefined;
        }
    }
}

