// script_4512042d85a380ca  (hash_4512042d85a380ca.gscc) (size: 7883 Bytes / 0x1ecb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6580a52c (1702929708)
// size ...... 7883 (0x1ecb)
// includes .. 7   (offset: 0x1cc3)
// strings ... 22  (offset: 0x1cfb)
// dev strs .. 14  (offset: 0x1e23)
// exports ... 11  (offset: 0x14df)
// cseg ...... 0x221 + 0x12be (0x14df)
// imports ... 48  (offset: 0x1697)
// animtree1 . 0   (offset: 0x1ecb)
// animtree2 . 0   (offset: 0x1ecb)
#using scripts\common\callbacks;
#using scripts\common\scripted_widgets;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\outline;
#using scripts\mp\equipment;
#using scripts\mp\supers;

#namespace specialty_special_target_info;

// Namespace specialty_special_target_info
// Params 0, eflags: 0x1
// Checksum 0x277bb684, Offset: 0x23f
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_special_target_info
// Params 1
// Checksum 0x2eeaf24b, Offset: 0x25f
// Size: 0x226
function registerspecialty( params )
{
    bundle = level.perkbundles[ "specialty_engineer_minimap" ];
    
    if ( !bundle )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_special_target_info", &function_68cc1328585f74b4, &function_cc417767af658ac3 );
    }
    
    level.var_62461e178f2b4f02 = bundle.var_62461e178f2b4f02 ?? 1;
    level.var_522c3521601d2336 = squared( level.var_62461e178f2b4f02 );
    level.var_f29127b7adc37bad = bundle.var_f29127b7adc37bad ?? 1;
    level.var_a22423ba2d528ff1 = squared( level.var_f29127b7adc37bad );
    level.var_5b0c229e72eb2634 = cos( bundle.var_ee28aead8b5d729c ?? 1 );
    level.var_60e09e74c8c6384c = ( bundle.var_96fae71799931040 ?? 0.5 ) * 1000;
    level.var_fd017426e0dec098 = [ "equip_combataxe", "equip_semtex", "equip_bunkerbuster", "equip_frag", "equip_thermobaric_grenade", "equip_flash", "equip_concussion", "equip_smoke", "equip_gas_grenade", "equip_emp", "equip_cluster_grenade", "equip_chakram" ];
    level.var_578877120b871600 = [ "drone_formation_swarm", "napalm_strike" ];
    level.var_d8e5e13e0a2b3f02 = [];
    
    foreach ( struct in bundle.var_d8e5e13e0a2b3f02 )
    {
        level.var_d8e5e13e0a2b3f02[ struct.ref ] = struct.value;
    }
}

// Namespace specialty_special_target_info
// Params 0, eflags: 0x4
// Checksum 0x3f62a0fd, Offset: 0x48d
// Size: 0x1e
function private function_68cc1328585f74b4()
{
    thread function_b9a94dfeeb77400a();
    callback::add( #"player_death", &onplayerdeath );
}

// Namespace specialty_special_target_info
// Params 0, eflags: 0x4
// Checksum 0xccd107c5, Offset: 0x4b3
// Size: 0x23
function private function_cc417767af658ac3()
{
    self notify( #"specialty_special_target_info_unset" );
    callback::remove( #"player_death", &onplayerdeath );
}

// Namespace specialty_special_target_info
// Params 0, eflags: 0xc
// Checksum 0x3b847770, Offset: 0x4de
// Size: 0xbfd
function private function_b9a94dfeeb77400a()
{
    self notify( #"hash_3b35f48b9459b675" );
    self endon( #"hash_3b35f48b9459b675" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect", #"specialty_special_target_info_unset" );
    var_c6518c0a61c66918 = 0;
    omnvarentnum = undefined;
    omnvarent = undefined;
    durationendtime = undefined;
    widgetcreated = 0;
    prevtarget = undefined;
    besttarget = undefined;
    var_252ae8f58fc536a4 = undefined;
    var_911c5c007c7cf79c = level.perkbundles[ "specialty_engineer_minimap" ].var_b35c27567be4cf99;
    
    while ( true )
    {
        /#
            debug = getdvarint( @"scr_debug_specialty_special_target_info", 0 );
        #/
        
        prevtarget = besttarget;
        besttarget = undefined;
        var_f96432e53b73a5bc = var_911c5c007c7cf79c ? self adsbuttonpressed() : 1;
        
        if ( var_f96432e53b73a5bc )
        {
            potentialtargets = function_601e774b5e836df6();
        }
        else
        {
            potentialtargets = undefined;
        }
        
        if ( var_f96432e53b73a5bc && potentialtargets.size )
        {
            var_4cd6ab94aaff14dc = -1;
            playerangles = self getplayerangles();
            playerlookforward = anglestoforward( playerangles );
            playereye = self geteye();
            playerorigin = self.origin;
            
            foreach ( target in potentialtargets )
            {
                if ( target.team == self.team )
                {
                    continue;
                }
                
                if ( !target.superref && !target.equipmentref && !target.streakinfo && !target.juggcontext )
                {
                    continue;
                }
                
                targetorigin = target.origin;
                ref = target.streakinfo.streakname ?? target.juggcontext.streakinfo.streakname ?? target.superref ?? target.equipmentref;
                
                if ( level.var_d8e5e13e0a2b3f02[ ref ] )
                {
                    verticaloffset = level.var_d8e5e13e0a2b3f02[ ref ];
                    targetorigin += ( 0, 0, verticaloffset );
                }
                
                /#
                    if ( getdvarint( @"hash_4b38882f1e56ced", 0 ) )
                    {
                        sphere( target.origin, 10, ( 1, 0, 0 ), 0, 10 );
                        
                        if ( targetorigin != target.origin )
                        {
                            sphere( targetorigin, 10, ( 0, 1, 0 ), 0, 10 );
                        }
                    }
                #/
                
                if ( !withinfov( playereye, playerangles, targetorigin, level.var_5b0c229e72eb2634 ) )
                {
                    continue;
                }
                
                totarget = targetorigin - playerorigin;
                
                if ( target.streakinfo )
                {
                    if ( target.isairkillstreak )
                    {
                        if ( lengthsquared( totarget ) >= level.var_a22423ba2d528ff1 )
                        {
                            continue;
                        }
                    }
                    else if ( lengthsquared( totarget ) >= level.var_522c3521601d2336 )
                    {
                        continue;
                    }
                    
                    if ( arraycontains( level.var_578877120b871600, target.streakinfo.streakname ?? "" ) )
                    {
                        continue;
                    }
                }
                else if ( target.juggcontext )
                {
                    if ( lengthsquared( totarget ) >= level.var_522c3521601d2336 )
                    {
                        continue;
                    }
                }
                else if ( target.equipmentref )
                {
                    if ( arraycontains( level.var_fd017426e0dec098, target.equipmentref ) )
                    {
                        continue;
                    }
                }
                
                totargetdir = vectornormalize( totarget );
                var_d5ebf497249afbdd = vectordot( playerlookforward, totargetdir );
                
                /#
                    if ( debug )
                    {
                        switch ( debug )
                        {
                            case 1:
                                print3d( targetorigin, "<dev string:x24>" + var_d5ebf497249afbdd, ( 1, 0, 0 ), 1, 1, 1, 1 );
                                break;
                            default:
                                break;
                        }
                    }
                #/
                
                if ( var_d5ebf497249afbdd > var_4cd6ab94aaff14dc )
                {
                    besttarget = target;
                    var_4cd6ab94aaff14dc = var_d5ebf497249afbdd;
                }
            }
        }
        
        if ( besttarget && var_f96432e53b73a5bc )
        {
            /#
                function_781ee6cab2be5f57( debug, besttarget );
            #/
            
            currtime = gettime();
            
            if ( prevtarget != besttarget || !isdefined( var_252ae8f58fc536a4 ) )
            {
                var_252ae8f58fc536a4 = currtime;
                lockedOn = 0;
            }
            else if ( currtime - var_252ae8f58fc536a4 < level.var_60e09e74c8c6384c )
            {
                lockedOn = 0;
            }
            else
            {
                lockedOn = 1;
            }
            
            if ( !lockedOn )
            {
                if ( widgetcreated )
                {
                    if ( omnvarent )
                    {
                        scripted_widgets::anchored_remove( omnvarent, "specialty_special_target_info" );
                    }
                    
                    widgetcreated = 0;
                }
                
                if ( self.var_d4c9070e465d2506 )
                {
                    outline::outlinedisable( self.var_d4c9070e465d2506, omnvarent );
                    self.var_d4c9070e465d2506 = undefined;
                }
                
                wait 0.1;
                continue;
            }
            
            var_94de056663f5d48e = besttarget getentitynumber();
            
            if ( var_94de056663f5d48e != omnvarentnum )
            {
                self setclientomnvar( o"ui_special_target_info_entnum", var_94de056663f5d48e );
                omnvarentnum = var_94de056663f5d48e;
                
                if ( widgetcreated )
                {
                    if ( omnvarent )
                    {
                        scripted_widgets::anchored_remove( omnvarent, "specialty_special_target_info" );
                    }
                    
                    widgetcreated = 0;
                }
                
                if ( self.var_d4c9070e465d2506 )
                {
                    outline::outlinedisable( self.var_d4c9070e465d2506, omnvarent );
                    self.var_d4c9070e465d2506 = undefined;
                }
                
                omnvarent = besttarget;
                self.var_8a07e491476f6970 = omnvarent;
            }
            
            if ( !widgetcreated )
            {
                scripted_widgets::anchored_add( omnvarent, "specialty_special_target_info", "scripted_widget_special_target_info", "scripted_widget_bounding_box_clamped" );
                scripted_widgets::anchored_set_state( omnvarent, "specialty_special_target_info", "Show" );
                widgetcreated = 1;
            }
            
            var_bc5d7435cc03331 = 1;
            
            if ( !self.var_d4c9070e465d2506 )
            {
                self.var_d4c9070e465d2506 = outline::outlineenableforplayer( besttarget, self, "sat_special_target_info", "perk" );
            }
            
            lifetimeendtime = besttarget.lifetimeendtime ?? besttarget.juggcontext.lifetimeendtime;
            
            if ( lifetimeendtime > 0 )
            {
                if ( lifetimeendtime != durationendtime )
                {
                    durationendtime = lifetimeendtime;
                }
                
                var_bc5d7435cc03331 = 0;
                self setclientomnvar( o"ui_special_target_info_duration_timer", int( max( durationendtime - currtime, 0 ) ) );
            }
            else if ( durationendtime != 0 )
            {
                self setclientomnvar( o"ui_special_target_info_duration_timer", 0 );
                durationendtime = 0;
            }
            
            if ( besttarget.superref || besttarget.equipmentref )
            {
                self setclientomnvar( o"ui_special_target_info_health_percentage_toggle", 0 );
            }
            else if ( ( besttarget.damagetaken || besttarget.currenthealth || besttarget.health ) && besttarget.maxhealth )
            {
                if ( besttarget.damagetaken )
                {
                    currenthealth = besttarget.maxhealth - besttarget.damagetaken;
                }
                else
                {
                    currenthealth = besttarget.currenthealth ?? besttarget.health;
                }
                
                healthratio = currenthealth / besttarget.maxhealth;
                var_c274873eab0b16 = int( clamp( healthratio * 100, 0, 100 ) );
                self setclientomnvar( o"ui_special_target_info_health_percentage", var_c274873eab0b16 );
                self setclientomnvar( o"ui_special_target_info_health_percentage_toggle", 1 );
                var_bc5d7435cc03331 = 0;
            }
            
            if ( besttarget.superref )
            {
                if ( besttarget.bundle.var_c7709714d768097c && besttarget.owner supers_mp::function_d45945781d29204a( besttarget.superref, besttarget.bundle.var_c7709714d768097c ) )
                {
                    self setclientomnvar( o"ui_special_target_info_is_overclocked", 1 );
                    var_bc5d7435cc03331 = 0;
                }
                else if ( besttarget.bundle.var_e36b84555e7df1d3 && besttarget.owner supers_mp::function_d45945781d29204a( besttarget.superref, besttarget.bundle.var_e36b84555e7df1d3 ) )
                {
                    self setclientomnvar( o"ui_special_target_info_is_overclocked", 1 );
                    var_bc5d7435cc03331 = 0;
                }
                else
                {
                    self setclientomnvar( o"ui_special_target_info_is_overclocked", 0 );
                }
            }
            else if ( besttarget.equipmentref )
            {
                if ( besttarget.var_f468780bc04d014a )
                {
                    if ( besttarget.bundle.var_c7709714d768097c && besttarget.owner equipment_mp::function_e6b75548c2c3c6cf( besttarget.equipmentref, besttarget.bundle.var_c7709714d768097c ) )
                    {
                        self setclientomnvar( o"ui_special_target_info_is_overclocked", 1 );
                        var_bc5d7435cc03331 = 0;
                    }
                    
                    if ( besttarget.bundle.var_e36b84555e7df1d3 && besttarget.owner equipment_mp::function_e6b75548c2c3c6cf( besttarget.equipmentref, besttarget.bundle.var_e36b84555e7df1d3 ) )
                    {
                        self setclientomnvar( o"ui_special_target_info_is_overclocked", 1 );
                        var_bc5d7435cc03331 = 0;
                    }
                }
            }
            else if ( besttarget.streakinfo || besttarget.juggcontext.streakinfo )
            {
                self setclientomnvar( o"ui_special_target_info_is_overclocked", ( besttarget.streakinfo.bundle.var_f088013d20169bf3 ?? #"none" ) != #"none" );
                bundle = besttarget.streakinfo.bundle ?? besttarget.juggcontext.streakinfo.bundle;
                
                if ( ( bundle.var_f088013d20169bf3 ?? #"none" ) == #"none" )
                {
                    self setclientomnvar( o"ui_special_target_info_is_overclocked", 0 );
                }
                else
                {
                    self setclientomnvar( o"ui_special_target_info_is_overclocked", 1 );
                    var_bc5d7435cc03331 = 0;
                }
            }
            
            if ( besttarget.var_30656af96b2ac2a4.size > 0 )
            {
                self setclientomnvar( o"hash_7eb74f64da4ed9aa", 1 );
                var_bc5d7435cc03331 = 0;
            }
            else
            {
                self setclientomnvar( o"hash_7eb74f64da4ed9aa", 0 );
            }
            
            targetdist = length( besttarget.origin - playerorigin );
            self setclientomnvar( o"ui_special_target_info_dist", targetdist );
            
            if ( var_c6518c0a61c66918 )
            {
                var_c6518c0a61c66918 = 0;
            }
            
            if ( widgetcreated && var_bc5d7435cc03331 )
            {
                widgetcreated = 0;
                scripted_widgets::anchored_remove( omnvarent, "specialty_special_target_info" );
            }
        }
        else
        {
            var_252ae8f58fc536a4 = undefined;
            
            if ( !var_c6518c0a61c66918 )
            {
                self setclientomnvar( o"ui_special_target_info_entnum", 2047 );
                omnvarentnum = 2047;
                self setclientomnvar( o"ui_special_target_info_is_overclocked", 0 );
                self setclientomnvar( o"hash_7eb74f64da4ed9aa", 0 );
                self setclientomnvar( o"ui_special_target_info_duration_timer", 0 );
                durationendtime = 0;
                self setclientomnvar( o"ui_special_target_info_health_percentage", 0 );
                self setclientomnvar( o"ui_special_target_info_dist", 0 );
                
                if ( widgetcreated )
                {
                    if ( omnvarent )
                    {
                        scripted_widgets::anchored_remove( omnvarent, "specialty_special_target_info" );
                    }
                    
                    widgetcreated = 0;
                }
                
                if ( self.var_d4c9070e465d2506 )
                {
                    outline::outlinedisable( self.var_d4c9070e465d2506, omnvarent );
                    self.var_d4c9070e465d2506 = undefined;
                }
                
                omnvarent = undefined;
                self.var_8a07e491476f6970 = undefined;
                var_c6518c0a61c66918 = 1;
            }
        }
        
        /#
            if ( debug )
            {
                waitframe();
                continue;
            }
        #/
        
        wait 0.1;
    }
}

// Namespace specialty_special_target_info
// Params 0, eflags: 0x4
// Checksum 0xd0ecb640, Offset: 0x10e3
// Size: 0xbd
function private function_601e774b5e836df6()
{
    partition = function_dd14d136bd635c56();
    var_f379ad68c32ddaa6 = [];
    var_e0804f6f6e8df13e = partition utility::function_92fef8fe5211a388( self.origin );
    
    foreach ( array in var_e0804f6f6e8df13e )
    {
        var_f379ad68c32ddaa6 = arraycombine( var_f379ad68c32ddaa6, array );
    }
    
    var_f379ad68c32ddaa6 = arraycombine( var_f379ad68c32ddaa6, level.activekillstreaks );
    return var_f379ad68c32ddaa6;
}

// Namespace specialty_special_target_info
// Params 0, eflags: 0x4
// Checksum 0x9f2cacf6, Offset: 0x11a9
// Size: 0x23
function private function_dd14d136bd635c56()
{
    if ( level.var_e52ad86d834caebe == gettime() )
    {
        return level.specialty_special_target_info_partition;
    }
    
    return function_358c15a49caed11a();
}

// Namespace specialty_special_target_info
// Params 0, eflags: 0x4
// Checksum 0xccb8dcb6, Offset: 0x11d5
// Size: 0x5c
function private function_358c15a49caed11a()
{
    var_f972b164b6f08612 = function_be0dd53539a68b65( level.grenades, level.missiles, weapon::function_3aafcaf7ff6dea9e() );
    level.specialty_special_target_info_partition = utility::create_partition( var_f972b164b6f08612, level.var_62461e178f2b4f02, 1 );
    level.var_e52ad86d834caebe = gettime();
    return level.specialty_special_target_info_partition;
}

// Namespace specialty_special_target_info
// Params 1, eflags: 0x4
// Checksum 0x1dc28921, Offset: 0x123a
// Size: 0xc8
function private onplayerdeath( params )
{
    self setclientomnvar( o"ui_special_target_info_entnum", 2047 );
    self setclientomnvar( o"ui_special_target_info_is_overclocked", 0 );
    self setclientomnvar( o"hash_7eb74f64da4ed9aa", 0 );
    self setclientomnvar( o"ui_special_target_info_duration_timer", 0 );
    self setclientomnvar( o"ui_special_target_info_health_percentage", 0 );
    self setclientomnvar( o"ui_special_target_info_dist", 0 );
    
    if ( self.var_8a07e491476f6970 )
    {
        if ( self.var_d4c9070e465d2506 )
        {
            outline::outlinedisable( self.var_d4c9070e465d2506, self.var_8a07e491476f6970 );
            self.var_d4c9070e465d2506 = undefined;
        }
        
        scripted_widgets::anchored_remove( self.var_8a07e491476f6970, "specialty_special_target_info" );
        self.var_8a07e491476f6970 = undefined;
    }
}

/#

    // Namespace specialty_special_target_info
    // Params 2, eflags: 0x4
    // Checksum 0x760bddad, Offset: 0x130a
    // Size: 0x1d5, Type: dev
    function private function_781ee6cab2be5f57( debug, besttarget )
    {
        if ( debug )
        {
            sphere( besttarget.origin + ( 0, 0, 20 ), 10, ( 1, 0.5, 0 ) );
            
            switch ( debug )
            {
                case 2:
                    print3d( besttarget.origin, "<dev string:x2a>" + self getclientomnvar( "<dev string:x33>" ), ( 1, 0, 0 ), 1, 1, 1, 1 );
                    break;
                case 3:
                    print3d( besttarget.origin, "<dev string:x51>" + self getclientomnvar( "<dev string:x5b>" ), ( 1, 0, 0 ), 1, 1, 1, 1 );
                    break;
                case 4:
                    print3d( besttarget.origin, "<dev string:x81>" + self getclientomnvar( "<dev string:x8a>" ) + "<dev string:xb3>", ( 1, 0, 0 ), 1, 1, 1, 1 );
                    break;
                case 5:
                    print3d( besttarget.origin, self getclientomnvar( "<dev string:xb5>" ) == 0 ? "<dev string:xdb>" : "<dev string:xeb>", ( 1, 0, 0 ), 1, 1, 1, 1 );
                    break;
                case 6:
                    print3d( besttarget.origin, self getclientomnvar( "<dev string:xf7>" ) == 0 ? "<dev string:x127>" : "<dev string:x130>", ( 1, 0, 0 ), 1, 1, 1, 1 );
                    break;
                default:
                    break;
            }
        }
    }

#/
