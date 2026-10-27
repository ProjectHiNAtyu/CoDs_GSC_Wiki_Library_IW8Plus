// scripts\mp\common\supers\super_laser_charge.gsc  (hash_562c9e2da353c105.gscc) (size: 8821 Bytes / 0x2275 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8c4c3a51 (2353805905)
// size ...... 8821 (0x2275)
// includes .. 14  (offset: 0x1ea1)
// strings ... 52  (offset: 0x1f11)
// dev strs .. 1   (offset: 0x2261)
// exports ... 18  (offset: 0x12b9)
// cseg ...... 0x434 + 0xe85 (0x12b9)
// imports ... 76  (offset: 0x1589)
// animtree1 . 0   (offset: 0x2275)
// animtree2 . 0   (offset: 0x2275)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\common\equipment\temp_v;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\supers;

#namespace super_laser_charge;

// Namespace super_laser_charge
// Params 0, eflags: 0x1
// Checksum 0x61a865ca, Offset: 0x452
// Size: 0x9
function autoexec main()
{
    superlasercharge_init();
}

// Namespace super_laser_charge
// Params 0
// Checksum 0x45e47d3, Offset: 0x463
// Size: 0x1ed
function superlasercharge_init()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_laser_charge", undefined, undefined, &superlasercharge_beginsuper, &superlasercharge_endsuper, undefined, undefined, undefined );
    val::group_register( "laserRaise", [ "allow_jump", "mantle", "melee", "usability", "killstreaks", "supers", "gesture", "allow_movement", "offhand_weapons", "crouch", "prone", "sprint", "execution_attack", "execution_victim" ] );
    val::group_register( "laserFire", [ "allow_jump", "mantle", "melee", "usability", "killstreaks", "supers", "gesture", "weapon_switch", "allow_movement", "offhand_weapons", "crouch", "prone", "sprint", "execution_attack", "execution_victim" ] );
    val::group_register( "laserDrop", [ "allow_jump", "mantle", "melee", "usability", "killstreaks", "supers", "gesture", "allow_movement", "offhand_weapons", "crouch", "prone", "sprint", "execution_attack", "execution_victim" ] );
    utility::registersharedfunc( "super_laser_charge", #"tryuse", &superlasercharge_tryuse );
}

// Namespace super_laser_charge
// Params 0
// Checksum 0xd5fc4897, Offset: 0x658
// Size: 0x1f, Type: bool
function superlasercharge_beginsuper()
{
    result = superlasercharge_tryuse( undefined );
    
    if ( !result )
    {
        return false;
    }
    
    return true;
}

// Namespace super_laser_charge
// Params 1, eflags: 0x4
// Checksum 0x816acc7d, Offset: 0x680
// Size: 0x3e9, Type: bool
function private superlasercharge_tryuse( killstreakbundle )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( self isswimming() )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "SUPER_MP/SUPER_CANNOT_USE_SWIM" );
        }
        
        return false;
    }
    
    if ( !self isonground() )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "SUPER_MP/SUPER_CANNOT_USE_AIR" );
        }
        
        return false;
    }
    
    if ( vehicle::is_in_vehicle( 1 ) )
    {
        return false;
    }
    
    cannotstand = self getstanceblocked( "stand" );
    
    if ( cannotstand )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "SUPER_MP/SUPER_CANNOT_USE_SPACE" );
        }
        
        return false;
    }
    
    starttrace = self.origin + ( 0, 0, 5 );
    endtrace = starttrace + ( 0, 0, 80 );
    contentoverride = trace::create_contents( 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0 );
    heighttrace = trace::ray_trace( starttrace, endtrace, self, contentoverride );
    
    if ( isdefined( heighttrace ) )
    {
        if ( heighttrace[ "hittype" ] != "hittype_none" || !trace::sphere_trace_passed( endtrace, endtrace, 15, self, contentoverride ) )
        {
            /#
                level thread debug_utility::drawline( starttrace, endtrace, 10, ( 1, 0, 0 ) );
                level thread debug_utility::drawsphere( endtrace, 20, 10, ( 1, 0, 0 ) );
                level thread debug_utility::drawsphere( heighttrace[ "<dev string:x24>" ], 5, 10, ( 1, 1, 0 ) );
            #/
            
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"SUPER_MP/SUPER_CANNOT_USE_SPACE" );
            }
            
            return false;
        }
    }
    
    if ( isbrgamemode() )
    {
        self setclientomnvar( "ui_br_inventory_disabled", 1 );
    }
    
    currentstance = self getstance();
    
    if ( currentstance != "stand" )
    {
        self setstance( "stand" );
    }
    
    laststancechange = self.laststancechangetime ?? 0;
    
    if ( isdefined( laststancechange ) )
    {
        stancetimediff = ( gettime() - laststancechange ) / 1000;
        remainingwait = 0;
        
        if ( stancetimediff < 0.8 )
        {
            remainingwait = 0.8 - stancetimediff;
        }
        
        if ( remainingwait > 0 )
        {
            wait remainingwait;
        }
    }
    
    val::group_set( "laserRaise", 0 );
    
    if ( !isdefined( killstreakbundle ) )
    {
        self setclientomnvar( "ui_field_upgrade_use", 0 );
    }
    
    perk::giveperk( "specialty_super_protection" );
    deployweapon = isdefined( killstreakbundle ) && isdefined( killstreakbundle.var_834ff8e7d9def831 ) ? killstreakbundle.var_834ff8e7d9def831 : "super_laser_charge_mp";
    objweapon = makeweapon( deployweapon, [ "lasercustom_super_laser" ] );
    inventory_utility::_giveweapon( objweapon );
    thread function_a4c7b4121549b576();
    self setscriptablepartstate( "superpowers", "laser_charge", 0 );
    deploysuccess = inventory_utility::domonitoredweaponswitch( objweapon, 1, 1 );
    
    if ( !deploysuccess )
    {
        self setscriptablepartstate( "superpowers", "off", 0 );
        perk::removeperk( "specialty_super_protection" );
        val::group_reset( "laserRaise" );
        thread inventory_utility::getridofweapon( objweapon, 1 );
        
        if ( isbrgamemode() )
        {
            self setclientomnvar( "ui_br_inventory_disabled", 0 );
        }
        
        return false;
    }
    
    superlasercharge_fire( objweapon, killstreakbundle );
    return true;
}

// Namespace super_laser_charge
// Params 0, eflags: 0x4
// Checksum 0xa5f426cf, Offset: 0xa72
// Size: 0x5d
function private function_a4c7b4121549b576()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    oldsuit = self.suit;
    newsuit = "iw9_laser_eye_mp";
    player::_setsuit( newsuit );
    self waittill( #"superlasercharge_finished" );
    player::_setsuit( oldsuit );
}

// Namespace super_laser_charge
// Params 2, eflags: 0x4
// Checksum 0x777d541d, Offset: 0xad7
// Size: 0x94
function private superlasercharge_fire( laserweapon, killstreakbundle )
{
    if ( !isdefined( killstreakbundle ) )
    {
        self.super.isactive = 1;
    }
    
    perk::giveperk( "specialty_third_person" );
    function_fcf9f949070ed4c0();
    thread superlasercharge_watchforgameended( killstreakbundle );
    impactent = spawn( "script_model", self gettagorigin( "tag_eye" ) );
    impactent setmodel( "super_laser_charge_impact" );
    impactent dontinterpolate();
    thread function_2ef235a6117cfb2f( laserweapon, impactent, killstreakbundle );
    thread superlasercharge_handleimpact( impactent );
}

// Namespace super_laser_charge
// Params 3, eflags: 0x4
// Checksum 0x841efcb3, Offset: 0xb73
// Size: 0x241
function private function_2ef235a6117cfb2f( laserweapon, impactent, killstreakbundle )
{
    self endon( #"disconnect" );
    val::group_reset( "laserRaise" );
    val::group_set( "laserFire", 0 );
    thread function_b11aa72008e26312( impactent, killstreakbundle );
    thread function_870765e019c1ae10();
    shouldfinish = 0;
    var_54d33954a6007f15 = 0;
    startedfiring = 0;
    shouldrefund = 0;
    maxclipammo = weaponclipsize( laserweapon );
    
    while ( !self.var_b748c9ef4aa807b0 )
    {
        currentweapon = self getcurrentweapon();
        currentammo = self getweaponammoclip( laserweapon );
        
        if ( currentweapon == laserweapon )
        {
            if ( !startedfiring )
            {
                startedfiring = 1;
                self notify( #"superlasercharge_start_fire" );
            }
        }
        
        if ( !function_65d78081f4aa0e93( currentweapon, laserweapon ) )
        {
            var_54d33954a6007f15 = 1;
            
            if ( !player::isreallyalive( self ) || player::isinlaststand( self ) )
            {
                shouldfinish = 1;
            }
            
            if ( startedfiring )
            {
                dontclear = 0;
            }
            else
            {
                shouldrefund = 1;
            }
            
            break;
        }
        
        if ( currentammo <= 10 )
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( #"superLaserCharge_stop_fire" );
    
    if ( var_54d33954a6007f15 || self.var_b748c9ef4aa807b0 )
    {
        val::group_reset( "laserFire" );
        thread inventory_utility::getridofweapon( laserweapon, 1 );
        self notify( #"superlasercharge_finished" );
        perk::removeperk( "specialty_third_person" );
        perk::removeperk( "specialty_super_protection" );
        
        if ( self.var_b748c9ef4aa807b0 )
        {
            self.var_b748c9ef4aa807b0 = undefined;
            self stopforcedfire();
        }
    }
    else
    {
        val::group_reset( "laserFire" );
        val::group_set( "laserDrop", 0 );
        thread inventory_utility::getridofweapon( laserweapon );
        wait 1;
        self notify( #"superlasercharge_finished" );
        perk::removeperk( "specialty_third_person" );
        perk::removeperk( "specialty_super_protection" );
        val::group_reset( "laserDrop" );
    }
    
    if ( isbrgamemode() )
    {
        self setclientomnvar( "ui_br_inventory_disabled", 0 );
    }
    
    temp_v::function_6fde086c9d1330d9( shouldfinish, 0, undefined, isdefined( killstreakbundle ) );
    
    if ( shouldrefund )
    {
        function_3815644fb2cdd141( killstreakbundle );
        return;
    }
    
    if ( isdefined( killstreakbundle ) )
    {
        self notify( #"hash_6cccf8d969a989ec" );
    }
}

// Namespace super_laser_charge
// Params 0, eflags: 0x4
// Checksum 0xa2a33db9, Offset: 0xdbc
// Size: 0x34
function private function_870765e019c1ae10()
{
    self endon( #"disconnect" );
    self endon( #"superlasercharge_start_fire" );
    self endon( #"superLaserCharge_stop_fire" );
    wait 2;
    self.var_b748c9ef4aa807b0 = 1;
}

// Namespace super_laser_charge
// Params 2, eflags: 0x4
// Checksum 0xa24bfa31, Offset: 0xdf8
// Size: 0x76, Type: bool
function private function_65d78081f4aa0e93( currentweapon, laserweapon )
{
    hasgameended = istrue( level.gameended );
    var_564eb1ae6cb2df41 = currentweapon == laserweapon;
    return player::isreallyalive( self ) && self isonground() && var_564eb1ae6cb2df41 && !player::isinlaststand( self ) && !self isswimming() && !self isonladder() && !hasgameended;
}

// Namespace super_laser_charge
// Params 0, eflags: 0x4
// Checksum 0x58b0fd14, Offset: 0xe77
// Size: 0x13e
function private function_fcf9f949070ed4c0()
{
    traceoffset = 50;
    starttrace = self gettagorigin( "j_spineupper" );
    righttraceend = starttrace + anglestoright( self.angles ) * traceoffset;
    rightsidetrace = trace::ray_trace( starttrace, righttraceend, self, trace::create_default_contents( 1 ) );
    
    if ( isdefined( rightsidetrace ) && rightsidetrace[ "hittype" ] != "hittype_none" )
    {
        /#
            level thread debug_utility::drawline( starttrace, righttraceend, 10, ( 1, 0, 0 ) );
            level thread debug_utility::drawsphere( rightsidetrace[ "<dev string:x24>" ], 5, 10, ( 1, 0, 0 ) );
        #/
    }
    
    lefttraceend = starttrace - anglestoright( self.angles ) * traceoffset;
    leftsidetrace = trace::ray_trace( starttrace, lefttraceend, self, trace::create_default_contents( 1 ) );
    
    if ( isdefined( leftsidetrace ) && leftsidetrace[ "hittype" ] != "hittype_none" )
    {
        /#
            level thread debug_utility::drawline( starttrace, lefttraceend, 10, ( 0, 1, 0 ) );
            level thread debug_utility::drawsphere( leftsidetrace[ "<dev string:x24>" ], 5, 10, ( 0, 1, 0 ) );
        #/
    }
}

// Namespace super_laser_charge
// Params 2, eflags: 0x4
// Checksum 0x70276ce7, Offset: 0xfbd
// Size: 0xd8
function private function_b11aa72008e26312( impactent, killstreakbundle )
{
    self endon( #"disconnect" );
    
    /#
        thread function_57a36da2a1d4feed();
    #/
    
    self startforcedfire();
    self playsoundtoplayer( "weap_lasereyes_levitate", self );
    self playsound( "weap_lasereyes_levitate_npc", self, self );
    raiseresult = utility::waittill_any_timeout( 1.5, "superLaserCharge_stop_fire" );
    
    if ( raiseresult != "timeout" )
    {
        self stopforcedfire();
        return;
    }
    
    if ( !isdefined( killstreakbundle ) )
    {
        thread supers_mp::updateusetimedecay();
    }
    
    self playsoundtoplayer( "weap_laser_fire_start", self );
    self playsound( "weap_laser_fire_start_npc", self, self );
    self waittill( #"superLaserCharge_stop_fire" );
    self playsoundtoplayer( "weap_laser_fire_stop", self );
    self playsound( "weap_laser_fire_stop_npc", self, self );
    self stopforcedfire();
    
    if ( isdefined( impactent ) )
    {
        impactent delete();
    }
}

// Namespace super_laser_charge
// Params 1
// Checksum 0xd08ac1cd, Offset: 0x109d
// Size: 0x5a
function superlasercharge_handleimpact( impactent )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( isdefined( impactent ) )
    {
        var_a77c8f7af459c087 = player_utility::getplayerlookatpos( self );
        
        if ( isdefined( var_a77c8f7af459c087 ) )
        {
            impactent.origin = var_a77c8f7af459c087;
        }
        
        wait 0.05;
    }
}

// Namespace super_laser_charge
// Params 1
// Checksum 0xc03a0fc2, Offset: 0x10ff
// Size: 0x59, Type: bool
function superlasercharge_endsuper( fromdeath )
{
    self.super.isactive = 0;
    
    if ( utility::issharedfuncdefined( #"br", #"superslotcleanup" ) )
    {
        self [[ utility::getsharedfunc( #"br", #"superslotcleanup" ) ]]();
    }
    
    return false;
}

// Namespace super_laser_charge
// Params 0
// Checksum 0x16b126ee, Offset: 0x1161
// Size: 0x71
function superlasercharge_onkill()
{
    if ( game_utility::getgametype() != "infect" )
    {
        supers_mp::combatrecordsuperkill( "super_laser_charge" );
        self.var_27577444079baae2++;
        var_3342c97ab2fbac3d = supers_mp::getcombatrecordsupermisc( "super_laser_charge" );
        
        if ( self.var_27577444079baae2 > var_3342c97ab2fbac3d )
        {
            increment = self.var_27577444079baae2 - var_3342c97ab2fbac3d;
            supers_mp::combatrecordsupermisc( "super_laser_charge", increment );
        }
    }
}

// Namespace super_laser_charge
// Params 1, eflags: 0x4
// Checksum 0xc4cf0a64, Offset: 0x11da
// Size: 0x5c
function private superlasercharge_watchforgameended( killstreakbundle )
{
    self endon( #"death_or_disconnect" );
    self endon( #"super_use_finished" );
    self notify( #"superlasercharge_watchforgameended" );
    self endon( #"superlasercharge_watchforgameended" );
    level utility::waittill_any( "game_ended", "prematch_cleanup" );
    
    if ( !isdefined( killstreakbundle ) )
    {
        thread supers_mp::superusefinished();
    }
}

// Namespace super_laser_charge
// Params 1, eflags: 0x4
// Checksum 0x9bebda8d, Offset: 0x123e
// Size: 0x4a
function private function_3815644fb2cdd141( killstreakbundle )
{
    if ( isdefined( killstreakbundle ) )
    {
        self notify( #"superlasercharge_refund" );
        return;
    }
    
    if ( isbrgamemode() )
    {
        br_pickups::_givebrsuper( "equip_laser_charge", "super_laser_charge", 1 );
        return;
    }
    
    perkpackage::perkpackage_giveimmediate( "super_laser_charge" );
}

/#

    // Namespace super_laser_charge
    // Params 0, eflags: 0x4
    // Checksum 0xa4124fd8, Offset: 0x1290
    // Size: 0x29, Type: dev
    function private function_57a36da2a1d4feed()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"superlasercharge_finished" );
        level endon( #"game_ended" );
    }

#/
