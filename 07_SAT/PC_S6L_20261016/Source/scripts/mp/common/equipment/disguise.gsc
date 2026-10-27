// scripts\mp\common\equipment\disguise.gsc  (hash_45e06723853e90bc.gscc) (size: 10336 Bytes / 0x2860 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd2a295a6 (3533870502)
// size ...... 10336 (0x2860)
// includes .. 9   (offset: 0x264c)
// strings ... 30  (offset: 0x2694)
// dev strs .. 3   (offset: 0x2838)
// exports ... 34  (offset: 0x1638)
// cseg ...... 0x239 + 0x13ff (0x1638)
// imports ... 92  (offset: 0x1b88)
// animtree1 . 0   (offset: 0x2860)
// animtree2 . 0   (offset: 0x2860)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\vision_utility;
#using scripts\mp\disguise_controller;
#using scripts\mp\execution;
#using scripts\mp\hud_message;
#using scripts\mp\operator;

#namespace disguise;

// Namespace disguise
// Params 0
// Checksum 0xbd55f09b, Offset: 0x257
// Size: 0xc4
function disguise_init()
{
    level.disguisedata = spawnstruct();
    function_33f3b3d6ca1b9905();
    
    if ( level.mapname == "mp_br_mechanics" && getdvarint( @"hash_8fa9d384348cb11b", 0 ) )
    {
        concealprefab = getent( "player_conceal", #targetname );
        concealclip = spawn( "script_model", ( 0, 0, 0 ) );
        concealclip.angles = ( 0, 0, 0 );
        concealclip clonebrushmodeltoscriptmodel( concealprefab );
        concealclip dontinterpolate();
        level.disguisedata.concealclip = concealclip;
    }
    
    level.var_472bbfc72aecc961 = &function_7671f848d2296f12;
}

// Namespace disguise
// Params 1, eflags: 0x4
// Checksum 0x8db958cd, Offset: 0x323
// Size: 0x92
function private function_7671f848d2296f12( event )
{
    if ( !isdefined( event.type ) || !isplayer( event.entity ) )
    {
        return;
    }
    
    if ( event.type != "bulletwhizby" && event.type != "damage" )
    {
        return;
    }
    
    if ( !event.entity function_bc13e7208281eb0c() )
    {
        return;
    }
    
    event.entity disguise_finished();
    self setbattlechatterflag( "target_was_disguised", 1, 5 );
}

// Namespace disguise
// Params 0
// Checksum 0x1fb3be93, Offset: 0x3bd
// Size: 0xd2
function function_33f3b3d6ca1b9905()
{
    if ( !isdefined( level.disguisedata ) )
    {
        return;
    }
    
    level.disguisedata.disguises = [];
    function_61441cda31a90067( "alqatala", %"milsim_eastern_1", %"fu_disguise_aq", "vestlight", "milhvygr" );
    function_61441cda31a90067( "shadowcompany", %"milsim_eastern_1", %"fu_disguise_shadow", "nylon", "millghtgr" );
    function_61441cda31a90067( "konnig", %"milsim_eastern_1", %"fu_disguise_konnig", "nylon", "millghtgr" );
    
    if ( utility::issharedfuncdefined( #"disguise", #"hash_5880576d3a19b4e8" ) )
    {
        utility::callsharedfunc( #"disguise", #"hash_5880576d3a19b4e8" );
    }
}

// Namespace disguise
// Params 1
// Checksum 0x6ed10897, Offset: 0x497
// Size: 0x46
function function_505bc569e1ba6100( factionname )
{
    assert( isdefined( level.disguisedata.disguises[ factionname ] ), "<dev string:x24>" );
    return level.disguisedata.disguises[ factionname ];
}

// Namespace disguise
// Params 1
// Checksum 0xb865c036, Offset: 0x4e6
// Size: 0x50
function function_5f908a51fd953cec( factionname )
{
    assert( isdefined( level.disguisedata.disguises[ factionname ] ), "<dev string:x24>" );
    return level.disguisedata.disguises[ factionname ].skin;
}

// Namespace disguise
// Params 5
// Checksum 0xcb4d4c96, Offset: 0x53f
// Size: 0x90
function function_61441cda31a90067( key, operator, skin, cloth, gear )
{
    outfitstruct = spawnstruct();
    outfitstruct.operator = operator;
    outfitstruct.skin = skin;
    outfitstruct.cloth = cloth;
    outfitstruct.gear = gear;
    level.disguisedata.disguises[ key ] = outfitstruct;
}

// Namespace disguise
// Params 0
// Checksum 0xc868e5ba, Offset: 0x5d7
// Size: 0x6f
function function_799e75a619199fb3()
{
    subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", self.origin );
    nationality = ai_mp_controller::function_d8829485c05e8c1();
    
    if ( isdefined( subarea ) && isdefined( subarea.nationalityoverride ) )
    {
        nationality = subarea.nationalityoverride;
    }
    
    return function_505bc569e1ba6100( function_905d11a0b674e207( nationality ) );
}

// Namespace disguise
// Params 1
// Checksum 0x256384db, Offset: 0x64f
// Size: 0xb1
function function_905d11a0b674e207( nationality )
{
    assert( isdefined( nationality ), "<dev string:x72>" );
    
    if ( utility::issharedfuncdefined( #"disguise", #"hash_24e733244cea2100" ) )
    {
        return utility::callsharedfunc( #"disguise", #"hash_24e733244cea2100" );
    }
    
    switch ( nationality )
    {
        case #"hash_916b14e9c168191":
        case #"hash_19b89634f50eeda4":
            return "shadowcompany";
        case #"hash_fa18d1f6bd5790c7":
            return "alqatala";
        case #"hash_fa53bdf6bd853c80":
            return "konnig";
        default:
            return "alqatala";
    }
}

// Namespace disguise
// Params 6
// Checksum 0x297bc4e4, Offset: 0x708
// Size: 0x15c, Type: bool
function disguise_used( itemslotindex, durability, itembundle, var_1f88345b6ac6ff1a, var_48e721d9cc06ade, var_a20a88555a563d28 )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self.operatorcustomization ) )
    {
        return false;
    }
    
    function_d1af3c82def6407e( 1 );
    self.disguised = 1;
    function_5f8ae5d89925e995( 1 );
    function_4a6349f599993a4d( itemslotindex, durability, var_a20a88555a563d28, itembundle );
    self playsound( "fly_dmz_disguise_on" );
    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"hash_342cafdf8a93e06d", [ self ] );
    
    if ( isdefined( var_48e721d9cc06ade ) && !self.carryinghostage )
    {
        self forceplaygestureviewmodel( var_48e721d9cc06ade );
    }
    
    var_5f4537d178f8a049 = getdvarfloat( @"hash_62171a84e10129ab", 0.35 );
    childthread function_56d2e7b88e491789( var_5f4537d178f8a049, 1, var_1f88345b6ac6ff1a );
    childthread function_18a591d9757f496( 1, var_5f4537d178f8a049 );
    thread function_14201426cc125ecc();
    
    if ( utility::issharedfuncdefined( #"disguise", #"disguiseonused" ) )
    {
        utility::callsharedfunc( #"disguise", #"disguiseonused" );
    }
    
    utility::delaythread( var_5f4537d178f8a049, &function_d1af3c82def6407e, 0 );
    return true;
}

// Namespace disguise
// Params 4
// Checksum 0x456f8a84, Offset: 0x86d
// Size: 0x10e
function function_4a6349f599993a4d( itemslotindex, durability, var_a20a88555a563d28, itembundle )
{
    dstruct = spawnstruct();
    dstruct.executionref = execution::execution_getrefbyplayer( self );
    dstruct.operator = self.operatorcustomization.operatorref;
    dstruct.skin = self.operatorcustomization.skinref;
    dstruct.health = durability;
    dstruct.maxhealth = 108;
    
    if ( isdefined( itembundle ) && isdefined( itembundle.maxcount ) )
    {
        dstruct.maxhealth = itembundle.maxcount;
    }
    
    dstruct.backpackslot = itemslotindex;
    dstruct.var_a20a88555a563d28 = var_a20a88555a563d28;
    dstruct.var_d260fc4aa8c9fdef = itembundle.var_b491c072b0b949e4;
    self.var_84e9765a894b2482 = dstruct;
}

// Namespace disguise
// Params 1
// Checksum 0x8c95935c, Offset: 0x983
// Size: 0x35
function function_d3f6e117ed9a1795( newindex )
{
    disguisedata = function_8d106ba9f2beec05();
    
    if ( !isdefined( disguisedata ) )
    {
        return 0;
    }
    
    disguisedata.backpackslot = newindex;
}

// Namespace disguise
// Params 1
// Checksum 0x9f641c40, Offset: 0x9c0
// Size: 0x4b, Type: bool
function function_8452df3e9df17e5a( index )
{
    if ( !self.disguised )
    {
        return false;
    }
    
    disguisedata = function_8d106ba9f2beec05();
    
    if ( !isdefined( disguisedata ) )
    {
        return false;
    }
    
    if ( disguisedata.backpackslot == index )
    {
        return true;
    }
    
    return false;
}

// Namespace disguise
// Params 0
// Checksum 0x950e2dc, Offset: 0xa14
// Size: 0xc
function function_238f475b0a18fa8()
{
    self.var_84e9765a894b2482 = undefined;
}

// Namespace disguise
// Params 0
// Checksum 0x85d90f32, Offset: 0xa28
// Size: 0x22
function function_8d106ba9f2beec05()
{
    assert( isdefined( self.var_84e9765a894b2482 ), "<dev string:xa8>" );
    return self.var_84e9765a894b2482;
}

// Namespace disguise
// Params 1
// Checksum 0x6fc7b9dc, Offset: 0xa53
// Size: 0x50
function function_d1af3c82def6407e( istransitioning )
{
    self.disguisetransition = istransitioning;
    
    if ( istransitioning )
    {
        array = [ "offhand_weapons" ];
        val::set_array( "disguise", array, 0 );
        return;
    }
    
    val::reset_all( "disguise" );
}

// Namespace disguise
// Params 0
// Checksum 0xef076c05, Offset: 0xaab
// Size: 0xc, Type: bool
function function_ef201423b6658dfa()
{
    return istrue( self.disguisetransition );
}

// Namespace disguise
// Params 3
// Checksum 0xa3598bdf, Offset: 0xac0
// Size: 0x69
function disguise_tryuse( itemslotindex, durability, itembundle )
{
    if ( self.disguisecooldown || !disguise_controller::function_c0504b97209f6146() )
    {
        hud_message::showerrormessage( %"MP/CANNOT_USE_GENERIC" );
        return 0;
    }
    
    if ( function_ef201423b6658dfa() )
    {
        return 0;
    }
    
    return disguise_used( itemslotindex, durability, itembundle, undefined, "iw9_vm_ges_disguise_on" );
}

// Namespace disguise
// Params 3
// Checksum 0xed370ce0, Offset: 0xb31
// Size: 0x43
function toggle( player, durability, itembundle )
{
    if ( !player function_bc13e7208281eb0c() )
    {
        player thread disguise_tryuse( undefined, durability, itembundle );
        return;
    }
    
    player function_f7776d7012343e70();
}

// Namespace disguise
// Params 3
// Checksum 0x64eb920b, Offset: 0xb7c
// Size: 0x152
function function_56d2e7b88e491789( delaytime, ison, var_1f88345b6ac6ff1a )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait delaytime;
    
    if ( ison )
    {
        function_528e99891a874a85( 1 );
        
        if ( isdefined( var_1f88345b6ac6ff1a.execution ) )
        {
            execution::_giveexecution( var_1f88345b6ac6ff1a.execution );
        }
        else
        {
            function_6c48f27f6e373236();
        }
        
        disguiseinfo = var_1f88345b6ac6ff1a ?? function_799e75a619199fb3();
        operator::function_44f7d464da13e4f6( disguiseinfo.operator, disguiseinfo.skin );
        self setclothtype( disguiseinfo.cloth );
        self setgeartype( disguiseinfo.gear );
        thread disguise_controller::function_eb742d3b36f4ccf1( var_1f88345b6ac6ff1a );
        utility::delaythread( 1, &function_528e99891a874a85, 0 );
        return;
    }
    
    if ( isdefined( self.var_84e9765a894b2482 ) )
    {
        execution::_giveexecution( self.var_84e9765a894b2482.executionref );
    }
    
    self setscriptablepartstate( "disguise", "off", 0 );
    operator::function_44f7d464da13e4f6( self.operatorcustomization.operatorref, self.operatorcustomization.skinref );
    function_238f475b0a18fa8();
}

// Namespace disguise
// Params 1
// Checksum 0x36b64887, Offset: 0xcd6
// Size: 0x38
function function_528e99891a874a85( ison )
{
    state = ison ? "on" : "off";
    self setscriptablepartstate( "disguise", state, 0 );
}

// Namespace disguise
// Params 0
// Checksum 0xe7f63f9f, Offset: 0xd16
// Size: 0x17
function function_bc13e7208281eb0c()
{
    if ( !self.disguised )
    {
        return 0;
    }
    
    return 1;
}

// Namespace disguise
// Params 1
// Checksum 0x3a73ce00, Offset: 0xd35
// Size: 0x3b
function function_f7776d7012343e70( var_3961c21bd8aa49ae )
{
    if ( !self.disguised || function_ef201423b6658dfa() || !disguise_controller::function_9b4a3491d0fde433() )
    {
        return;
    }
    
    disguise_finished( var_3961c21bd8aa49ae );
}

// Namespace disguise
// Params 1
// Checksum 0x4b99eedd, Offset: 0xd78
// Size: 0x146
function disguise_finished( var_4bea79b57a27413d )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !self.disguised )
    {
        return;
    }
    
    instancedata = function_8d106ba9f2beec05();
    function_d1af3c82def6407e( 1 );
    function_5f8ae5d89925e995( 0 );
    self playsound( "fly_dmz_disguise_off" );
    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"disguise_end", [ self ] );
    currentweapon = self getcurrentweapon();
    
    if ( !self.carryinghostage && isdefined( currentweapon ) && !isnullweapon( currentweapon ) )
    {
        if ( isdefined( instancedata.var_a20a88555a563d28 ) )
        {
            self forceplaygestureviewmodel( instancedata.var_a20a88555a563d28 );
        }
    }
    
    takeoffdelay = getdvarfloat( @"hash_307d1884bcaef28f", 0.45 );
    function_141c01e7aed61b1a( takeoffdelay );
    
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_7cfd736971d32c06 )
    {
        self setclientomnvar( "ui_dmz_disguise_sixth_sense_glow", 0 );
    }
    
    utility::delaythread( takeoffdelay, &function_d1af3c82def6407e, 0 );
    self notify( #"disguise_ended" );
}

// Namespace disguise
// Params 1
// Checksum 0xd29a7511, Offset: 0xec6
// Size: 0x149
function function_141c01e7aed61b1a( takeoffdelay )
{
    childthread function_56d2e7b88e491789( takeoffdelay, 0 );
    childthread function_18a591d9757f496( 0, takeoffdelay );
    self.disguised = undefined;
    
    if ( isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.clothtype ) && self.operatorcustomization.clothtype != "" )
    {
        self setclothtype( self.operatorcustomization.clothtype );
    }
    else
    {
        self setclothtype( "vestlight" );
    }
    
    if ( isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.geartype ) && self.operatorcustomization.geartype != "" )
    {
        self setgeartype( self.operatorcustomization.geartype );
    }
    else
    {
        self setgeartype( "millghtgr" );
    }
    
    self setclientomnvar( "ui_dmz_disguise_sixth_sense_glow", 0 );
    utility::delaythread( takeoffdelay, &function_d1af3c82def6407e, 0 );
    
    if ( utility::issharedfuncdefined( #"disguise", #"disguiseoff" ) )
    {
        utility::callsharedfunc( #"disguise", #"disguiseoff" );
    }
}

// Namespace disguise
// Params 2
// Checksum 0xb9740bf5, Offset: 0x1017
// Size: 0xc0
function function_18a591d9757f496( ison, delay )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait delay;
    
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_7cfd736971d32c06 )
    {
        self setclientomnvar( "ui_dmz_disguise_state", ison );
    }
    
    if ( utility::issharedfuncdefined( #"disguise", #"hash_bd4edd498d37e6e9" ) )
    {
        var_e876a2cf0eb8112e = utility::callsharedfunc( #"disguise", #"hash_bd4edd498d37e6e9" );
    }
    
    if ( isdefined( var_e876a2cf0eb8112e ) )
    {
        if ( ison )
        {
            vision_utility::function_89d3efe42060754c( var_e876a2cf0eb8112e );
            return;
        }
        
        vision_utility::function_6cb9d8e0202ee81( var_e876a2cf0eb8112e );
    }
}

// Namespace disguise
// Params 1
// Checksum 0x828bb61b, Offset: 0x10df
// Size: 0x11d
function function_5f8ae5d89925e995( shouldactivate )
{
    if ( isdefined( level.disguisedata.concealclip ) )
    {
        if ( shouldactivate )
        {
            var_8fedcb5cef093978 = level.disguisedata.concealclip;
            var_8fedcb5cef093978.origin = self.origin;
            var_8fedcb5cef093978.angles = self.angles;
            var_8fedcb5cef093978.owner = self;
            var_8fedcb5cef093978 linkto( self );
            self.disguisestruct.concealclip = var_8fedcb5cef093978;
        }
        else
        {
            self.disguisestruct.concealclip unlink();
            self.disguisestruct.concealclip.origin = ( 0, 0, 0 );
            self.disguisestruct.concealclip.owner = undefined;
            self.disguisestruct.concealclip = undefined;
        }
        
        return;
    }
    
    setstealthdisguised( self, shouldactivate );
}

// Namespace disguise
// Params 0
// Checksum 0xefafffbc, Offset: 0x1204
// Size: 0x40
function function_14201426cc125ecc()
{
    self endon( #"death_or_disconnect" );
    self endon( #"disguise_ended" );
    
    if ( getdvarint( @"hash_8303972c0cfbece0", 1 ) != 1 )
    {
        return;
    }
    
    while ( true )
    {
        function_942240cc1342b62c();
        waitframe();
    }
}

// Namespace disguise
// Params 0
// Checksum 0xc653dffe, Offset: 0x124c
// Size: 0x78
function function_353f336a0e9e77c2()
{
    origin = self.origin;
    radius = getdvarfloat( @"hash_1ef2c1fad9dad02f", 1000 );
    potentialagents = undefined;
    
    if ( level.var_f8f564d5b2b09e05 ?? utility::function_645a77750f1850b5() )
    {
        potentialagents = getentitiesinradiusfrompartitiongrid( origin, radius, createentitytypemask( [ "etype_ai" ] ), undefined, undefined );
    }
    else
    {
        potentialagents = getaiarrayinradius( origin, radius );
    }
    
    return potentialagents;
}

// Namespace disguise
// Params 0
// Checksum 0xc4a8312e, Offset: 0x12cd
// Size: 0x15f
function function_942240cc1342b62c()
{
    process = 0;
    sightmask = 0;
    time = getsystemtimeinmicroseconds();
    
    if ( !isdefined( self ) )
    {
        return 0;
    }
    
    if ( !self.disguised )
    {
        return 0;
    }
    
    potentialagents = function_353f336a0e9e77c2();
    var_f103cd961c74f5cf = utility::function_68061c3d21a6d57a();
    
    foreach ( agent in potentialagents )
    {
        if ( process >= 25 )
        {
            process = 0;
            waitframe();
        }
        
        if ( !function_e7fc5bf76b2ebe83( agent ) )
        {
            continue;
        }
        
        process++;
        threatlevel = agent getthreatsight( self );
        
        if ( threatlevel < 0.25 )
        {
            continue;
        }
        
        sightmask |= function_6af3fbfd54e85755( agent );
    }
    
    function_f7400126e291a80f( sightmask );
    
    if ( sightmask != 0 )
    {
        if ( !isdefined( self.var_d77d39ebb5d2ad58 ) || ( gettime() - self.var_d77d39ebb5d2ad58 ) / 1000 >= 4 )
        {
            self playlocalsound( "iw9_mp_disguise_alert" );
            self.var_d77d39ebb5d2ad58 = gettime();
        }
    }
}

// Namespace disguise
// Params 1
// Checksum 0xe1191212, Offset: 0x1434
// Size: 0x41
function function_e7fc5bf76b2ebe83( agent )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !player::isreallyalive() )
    {
        return 0;
    }
    
    if ( !isdefined( agent ) )
    {
        return 0;
    }
    
    if ( !isalive( agent ) )
    {
        return 0;
    }
    
    if ( utility::isusingremote() )
    {
        return 0;
    }
    
    return 1;
}

// Namespace disguise
// Params 1
// Checksum 0x6116e15b, Offset: 0x147e
// Size: 0x10c
function function_6af3fbfd54e85755( agent )
{
    forward = vectornormalize( anglestoforward( self getplayerangles() ) );
    toenemy = vectornormalize( agent.origin - self.origin );
    dot = vectordot( forward, toenemy );
    
    if ( dot >= 0.92388 )
    {
        return 2;
    }
    
    if ( dot >= 0.707107 )
    {
        return ( utility::isleft2d( self.origin, forward, agent.origin ) ? 4 : 1 );
    }
    
    if ( dot >= 0.5 )
    {
        return ( utility::isleft2d( self.origin, forward, agent.origin ) ? 128 : 64 );
    }
    
    if ( dot >= -0.707107 )
    {
        return ( utility::isleft2d( self.origin, forward, agent.origin ) ? 32 : 8 );
    }
    
    return 16;
}

// Namespace disguise
// Params 1
// Checksum 0x577b8988, Offset: 0x1592
// Size: 0x3d
function function_f7400126e291a80f( sightmask )
{
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_7cfd736971d32c06 )
    {
        self setclientomnvar( "ui_dmz_disguise_sixth_sense_glow", sightmask );
    }
}

// Namespace disguise
// Params 0
// Checksum 0xa52c2d67, Offset: 0x15d7
// Size: 0x61
function function_6c48f27f6e373236()
{
    disguiseindices = [ "000", "001", "022", "023" ];
    randomidx = disguiseindices[ randomint( disguiseindices.size ) ];
    execref = "execution_" + randomidx;
    execution::_giveexecution( execref );
}

