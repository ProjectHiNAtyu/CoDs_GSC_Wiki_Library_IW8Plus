// scripts\mp\common\equipment\geiger_counter.gsc  (hash_3290191a2f4fb417.gscc) (size: 10599 Bytes / 0x2967 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3fd152f8 (1070682872)
// size ...... 10599 (0x2967)
// includes .. 5   (offset: 0x280f)
// strings ... 15  (offset: 0x2837)
// dev strs .. 5   (offset: 0x2917)
// exports ... 37  (offset: 0x17bf)
// cseg ...... 0x173 + 0x164c (0x17bf)
// imports ... 89  (offset: 0x1d87)
// animtree1 . 0   (offset: 0x2967)
// animtree2 . 0   (offset: 0x2967)
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\equipment;
#using scripts\mp\hud_util;
#using scripts\mp\weapons;

#namespace geiger_counter;

// Namespace geiger_counter
// Params 0, eflags: 0x1
// Checksum 0xf32272ce, Offset: 0x191
// Size: 0x11b
function autoexec geigercounter_init()
{
    utility::flag_wait( "equipment_initialized" );
    
    if ( isdefined( level.var_b21df2d44bea6f09 ) )
    {
        return;
    }
    
    level.var_b21df2d44bea6f09 = 1;
    level.geigercounterstruct = spawnstruct();
    level.geigercounterstruct.partition = utility::create_partition( [], 4000 );
    level.geigercounterstruct.radiationmaxdist = getdvarint( @"hash_e4a881a4b29b1041", 1000 );
    level.geigercounterstruct.radiationradius = getdvarint( @"hash_37124040df88eccb", 4000 );
    level.geigercounterstruct.var_27049bd920ed4c01 = [];
    level.geigercounterstruct.var_d3766b198217281a = [];
    level.geigercounterstruct.var_a722591d9c5baf8e = [];
    weapons::registerusedcallback( "geiger_counter", &geigercounter_used );
    function_bf789e175884e11c( "geiger_counter", "equip_geigercounter" );
    function_bf789e175884e11c( undefined, "equip_rfid" );
    function_ad1903e0154bb327();
    utility::flag_set( "geiger_counter_initialized" );
}

// Namespace geiger_counter
// Params 0
// Checksum 0x8bbec1e3, Offset: 0x2b4
// Size: 0x20
function function_ad1903e0154bb327()
{
    utility::registersharedfunc( #"geiger_counter", #"hash_436274116a37009a", &_geigercounter_calculategeigercounterpulserate );
}

// Namespace geiger_counter
// Params 1
// Checksum 0xbf53e71c, Offset: 0x2dc
// Size: 0x43
function function_ea6ce6ce5afa8889( weaponref )
{
    if ( weaponref )
    {
        level.geigercounterstruct.var_27049bd920ed4c01 = arraycombineunique( level.geigercounterstruct.var_27049bd920ed4c01, [ weaponref ] );
    }
}

// Namespace geiger_counter
// Params 2
// Checksum 0x42227648, Offset: 0x327
// Size: 0xa9
function function_bf789e175884e11c( weaponref, equipref )
{
    if ( weaponref )
    {
        level.geigercounterstruct.var_d3766b198217281a = arraycombineunique( level.geigercounterstruct.var_d3766b198217281a, [ weaponref ] );
    }
    
    if ( equipref )
    {
        level.geigercounterstruct.var_a722591d9c5baf8e = arraycombineunique( level.geigercounterstruct.var_a722591d9c5baf8e, [ equipref ] );
        equipment_mp::registercallback( equipref, "onGive", &geigercounter_ongive );
        equipment_mp::registercallback( equipref, "onTake", &geigercounter_ontake );
    }
}

// Namespace geiger_counter
// Params 1
// Checksum 0x4bf50c2c, Offset: 0x3d8
// Size: 0x22
function function_1a05f0abe89e076e( dist )
{
    level.geigercounterstruct.radiationmaxdist = dist;
}

// Namespace geiger_counter
// Params 4
// Checksum 0x515b84dc, Offset: 0x402
// Size: 0xa5
function geigercounter_ongive( equipmentref, equipmentslot, variantid, attachments )
{
    if ( !arraycontains( level.geigercounterstruct.var_a722591d9c5baf8e, equipmentref ) )
    {
        return;
    }
    
    geigercounter_init();
    geigertype = equipmentref == "equip_rfid" ? 1 : 0;
    self setclientomnvar( "ui_geigercounter_type", geigertype );
    self notifyonplayercommand( "pullout_gc", "+smoke" );
    self notify( #"geigercounter_take" );
    thread geigercounter_watchfordevicepullout();
    geigercounter_updateuidata( -1 );
}

// Namespace geiger_counter
// Params 2
// Checksum 0x8b4c1e87, Offset: 0x4af
// Size: 0x5b
function geigercounter_ontake( equipmentref, equipmentslot )
{
    if ( !arraycontains( level.geigercounterstruct.var_a722591d9c5baf8e, equipmentref ) )
    {
        return;
    }
    
    self notifyonplayercommandremove( "pullout_gc", "+smoke" );
    self notify( #"geigercounter_take" );
    geigercounter_updateuidata( -1 );
}

// Namespace geiger_counter
// Params 1
// Checksum 0xe92980a9, Offset: 0x512
// Size: 0x2d
function geigercounter_used( grenade )
{
    waitframe();
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
    
    self notify( #"geigercounter_putaway" );
    function_aef2f788a34ca58();
}

// Namespace geiger_counter
// Params 0
// Checksum 0xebdb3d87, Offset: 0x547
// Size: 0x170
function geigercounter_watchfordevicepullout()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self notify( #"geigercounter_watchfordevicepullout" );
    self endon( #"geigercounter_watchfordevicepullout" );
    raceresult = spawnstruct();
    childthread geigercounter_watchracedeath( raceresult );
    childthread geigercounter_watchracetake( raceresult );
    childthread function_a4bd515bb90c7c3e();
    
    while ( true )
    {
        death = istrue( raceresult.death );
        take = istrue( raceresult.take );
        
        if ( death || take )
        {
            self notify( #"hash_21d8215f9a9e4324" );
            return;
        }
        
        if ( self.inlaststand )
        {
            waitframe();
            continue;
        }
        
        if ( !isdefined( self.geigercounterstruct ) )
        {
            self.geigercounterstruct = spawnstruct();
        }
        
        outofrange = 1;
        self.geigercounterstruct.var_cb6b3c508e10d1ae = function_90d03245a023c8c4();
        
        if ( isdefined( self.geigercounterstruct.var_cb6b3c508e10d1ae ) )
        {
            var_3fe15562914a53f1 = function_b1314e2195eaf056( self.geigercounterstruct.var_cb6b3c508e10d1ae );
            
            if ( function_102c06acd9bb12bc( self, var_3fe15562914a53f1 ) )
            {
                outofrange = 0;
                function_7c6820fab551a94b( var_3fe15562914a53f1 );
            }
            else
            {
                outofrange = function_e09f579b02559fdc();
            }
        }
        else
        {
            outofrange = function_e09f579b02559fdc();
        }
        
        if ( outofrange )
        {
            geigercounter_updateuidata( -1 );
        }
        
        waitframe();
    }
}

// Namespace geiger_counter
// Params 0
// Checksum 0x58640893, Offset: 0x6bf
// Size: 0xb2, Type: bool
function function_e09f579b02559fdc()
{
    if ( utility::issharedfuncdefined( #"radiation", #"radiation_isinit" ) && utility::issharedfuncdefined( #"radiation", #"radiation_signeddistancefromradiationcircle" ) )
    {
        if ( [[ utility::getsharedfunc( #"radiation", #"radiation_isinit" ) ]]() )
        {
            var_90e10079802f5e8a = [[ utility::getsharedfunc( #"radiation", #"radiation_signeddistancefromradiationcircle" ) ]]( self.origin );
            
            if ( var_90e10079802f5e8a < level.geigercounterstruct.radiationmaxdist )
            {
                function_7c6820fab551a94b( 99999999999 );
                return false;
            }
        }
    }
    
    return true;
}

// Namespace geiger_counter
// Params 1
// Checksum 0xb1076da7, Offset: 0x77a
// Size: 0x233
function function_7c6820fab551a94b( dist )
{
    if ( function_a1e83f713f4e2259() )
    {
        self.geigercounterstruct.var_614b9fd2d29223e4 = gettime();
        self.geigercounterstruct.var_43cb1c27a49e2dd3 = utility::callsharedfunc( #"geiger_counter", #"hash_436274116a37009a", dist, self.geigercounterstruct.var_cb6b3c508e10d1ae );
        
        if ( !isdefined( self.geigercounterstruct.timesincetick ) )
        {
            self.geigercounterstruct.timesincetick = 0;
        }
        
        if ( isdefined( self.geigercounterstruct.var_cb6b3c508e10d1ae ) )
        {
            object = self.geigercounterstruct.var_cb6b3c508e10d1ae;
            
            if ( isdefined( object.var_e2760f8e538afda0 ) && isdefined( self.team ) && !arraycontains( object.var_f991203116e8f59e, self.team ) )
            {
                minvalue = object.var_179f328895bfca39;
                
                if ( !isdefined( minvalue ) || minvalue <= 1.4 - self.geigercounterstruct.var_43cb1c27a49e2dd3 )
                {
                    challenges::function_37e945722d6497f3( self, object.var_e2760f8e538afda0, 1 );
                    object.var_f991203116e8f59e[ object.var_f991203116e8f59e.size ] = self.team;
                }
            }
        }
        
        geigercounter_updateuidata( clamp( 1.4 - self.geigercounterstruct.var_43cb1c27a49e2dd3, 0, 1.4 ) );
        
        if ( self.geigercounterstruct.timesincetick >= self.geigercounterstruct.var_43cb1c27a49e2dd3 )
        {
            function_1c7a27f983de7d83();
            self.geigercounterstruct.timesincetick = 0;
        }
        
        self.geigercounterstruct.timesincetick += level.framedurationseconds;
        return;
    }
    
    geigercounter_updateuidata( -0.25 );
}

// Namespace geiger_counter
// Params 0
// Checksum 0xd7472826, Offset: 0x9b5
// Size: 0x6d
function function_a1e83f713f4e2259()
{
    weaponbasename = getweaponbasename( self getheldoffhand() );
    isgeigercounter = issubstr( weaponbasename, "geiger_counter" ) && !arraycontains( level.geigercounterstruct.var_27049bd920ed4c01, weaponbasename );
    isgeigercounter = isgeigercounter || arraycontains( level.geigercounterstruct.var_d3766b198217281a, weaponbasename );
    return isgeigercounter;
}

// Namespace geiger_counter
// Params 1
// Checksum 0xaadd472e, Offset: 0xa2b
// Size: 0x3f
function geigercounter_watchracedeath( raceresult )
{
    self endon( #"hash_21d8215f9a9e4324" );
    self waittill( #"death" );
    raceresult.death = 1;
    self notify( #"hash_48b9b2cfbaddec5d" );
}

// Namespace geiger_counter
// Params 1
// Checksum 0x27c52275, Offset: 0xa72
// Size: 0x3f
function geigercounter_watchracetake( raceresult )
{
    self endon( #"hash_21d8215f9a9e4324" );
    self waittill( #"geigercounter_take" );
    raceresult.take = 1;
    self notify( #"hash_48b9b2cfbaddec5d" );
}

// Namespace geiger_counter
// Params 0
// Checksum 0x141d3c8f, Offset: 0xab9
// Size: 0x8e
function function_a4bd515bb90c7c3e()
{
    self endon( #"geigercounter_take" );
    
    /#
        if ( getdvarint( @"hash_9f3f608c5d144762", 0 ) )
        {
            thread function_b5d1e23479c0928();
        }
    #/
    
    while ( true )
    {
        self waittill( #"pullout_gc", weapon );
        
        while ( true )
        {
            if ( function_a1e83f713f4e2259() )
            {
                if ( isdefined( self.geigercounterstruct ) )
                {
                    self.geigercounterstruct.pulledout = 1;
                    break;
                }
            }
            
            waitframe();
        }
    }
    
    self notify( #"hash_48b9b2cfbaddec5d" );
}

// Namespace geiger_counter
// Params 1
// Checksum 0xef2eba65, Offset: 0xb4f
// Size: 0x46
function function_58b314b7f64ec440( raceresult )
{
    self endon( #"hash_21d8215f9a9e4324" );
    
    while ( true )
    {
        if ( function_a1e83f713f4e2259() )
        {
            break;
        }
    }
    
    raceresult.putaway = 1;
    self notify( #"hash_21d8215f9a9e4324" );
}

// Namespace geiger_counter
// Params 0
// Checksum 0xf3c7a71a, Offset: 0xb9d
// Size: 0x46
function function_aef2f788a34ca58()
{
    self notify( #"geigercounter_putaway" );
    
    if ( isdefined( self.geigercounterstruct ) )
    {
        self.geigercounterstruct.pulledout = undefined;
        self.geigercounterstruct = undefined;
        function_b353fa5f309dec29();
        geigercounter_clearuidata();
    }
}

// Namespace geiger_counter
// Params 0
// Checksum 0x2f25f4f6, Offset: 0xbeb
// Size: 0x23, Type: bool
function function_e5e80425969fd34e()
{
    return isdefined( self.geigercounterstruct ) && self.geigercounterstruct.pulledout;
}

// Namespace geiger_counter
// Params 0
// Checksum 0x39bc4b47, Offset: 0xc17
// Size: 0xe
function geigercounter_clearuidata()
{
    self setclientomnvar( "ui_geigercounter_meter", 0 );
}

// Namespace geiger_counter
// Params 1
// Checksum 0x4ad0dd60, Offset: 0xc2d
// Size: 0x19
function geigercounter_setuidata( data )
{
    self setclientomnvar( "ui_geigercounter_meter", data );
}

// Namespace geiger_counter
// Params 0
// Checksum 0x70cfde0, Offset: 0xc4e
// Size: 0x39
function function_1c7a27f983de7d83()
{
    var_33dd4c6d897ee2f1 = self getclientomnvar( "ui_geigercounter_type" );
    
    if ( var_33dd4c6d897ee2f1 == 1 )
    {
        self playlocalsound( "rfid_tick" );
        return;
    }
    
    self playlocalsound( "iw9_geiger_counter_tick" );
}

// Namespace geiger_counter
// Params 0
// Checksum 0x97d99d80, Offset: 0xc8f
// Size: 0x39
function function_b353fa5f309dec29()
{
    var_33dd4c6d897ee2f1 = self getclientomnvar( "ui_geigercounter_type" );
    
    if ( var_33dd4c6d897ee2f1 == 1 )
    {
        self stoplocalsound( "rfid_tick" );
        return;
    }
    
    self stoplocalsound( "iw9_geiger_counter_tick" );
}

// Namespace geiger_counter
// Params 1
// Checksum 0xc9d4c022, Offset: 0xcd0
// Size: 0x38
function geigercounter_updateuidata( overridevalue )
{
    if ( isdefined( overridevalue ) )
    {
        geigercounter_setuidata( overridevalue );
        return;
    }
    
    geigercounter_setuidata( self.geigercounterstruct.var_43cb1c27a49e2dd3 );
}

// Namespace geiger_counter
// Params 1
// Checksum 0x45fb291d, Offset: 0xd10
// Size: 0x28
function function_69cfcbb5ee5bfc98( object )
{
    level.geigercounterstruct.partition utility::add_to_partition( object );
}

// Namespace geiger_counter
// Params 1
// Checksum 0x65626706, Offset: 0xd40
// Size: 0x28
function function_54886797fcd30128( object )
{
    level.geigercounterstruct.partition utility::function_a4a8a4c917fab476( object );
}

// Namespace geiger_counter
// Params 1
// Checksum 0xc77fb86d, Offset: 0xd70
// Size: 0x82, Type: bool
function function_8a07072174c53bf8( object )
{
    if ( !isdefined( object ) || isstruct( object ) )
    {
        return false;
    }
    
    has_parts = isent( object ) && object isscriptable() || !isent( object ) && object isscriptableinstance();
    return has_parts && object isscriptableinstance() && object getscriptablehaspart( "brloot_valuable_fuelrods" ) && object getscriptablepartstate( "brloot_valuable_fuelrods", 1 ) == "hidden";
}

// Namespace geiger_counter
// Params 0
// Checksum 0x881572e7, Offset: 0xdfb
// Size: 0x75
function function_90d03245a023c8c4()
{
    object = level.geigercounterstruct.partition utility::function_93d8eea713f8560d( self.origin );
    
    while ( function_8a07072174c53bf8( object ) )
    {
        function_54886797fcd30128( object );
        object = level.geigercounterstruct.partition utility::function_93d8eea713f8560d( self.origin );
        
        if ( !isdefined( object ) )
        {
            return;
        }
    }
    
    return object;
}

// Namespace geiger_counter
// Params 1
// Checksum 0xf98ef075, Offset: 0xe79
// Size: 0x3e
function function_b1314e2195eaf056( var_91fcc3fa762321dd )
{
    radiationpos = var_91fcc3fa762321dd.origin;
    var_3fe15562914a53f1 = distancesquared( radiationpos, self.origin );
    return var_3fe15562914a53f1;
}

// Namespace geiger_counter
// Params 2
// Checksum 0x72b4c655, Offset: 0xec0
// Size: 0x3f, Type: bool
function function_102c06acd9bb12bc( player, var_3fe15562914a53f1 )
{
    return var_3fe15562914a53f1 < level.geigercounterstruct.radiationradius * level.geigercounterstruct.radiationradius;
}

// Namespace geiger_counter
// Params 2
// Checksum 0x2f48085, Offset: 0xf08
// Size: 0x29c
function _geigercounter_calculategeigercounterpulserate( var_3fe15562914a53f1, object )
{
    self notify( #"_geigercounter_calculategeigercounterpulserate" );
    self endon( #"_geigercounter_calculategeigercounterpulserate" );
    self endon( #"disconnect" );
    minwait = 0.25;
    maxwait = 1.4;
    mindist = 0;
    maxdist = level.geigercounterstruct.radiationradius;
    dist = sqrt( var_3fe15562914a53f1 );
    waittime = minwait;
    total_factor = 0;
    dist_factor = clamp( -1 * ( dist - mindist ) / ( maxdist - mindist ) + 1, 0, 1 );
    radiation_factor = 0;
    
    if ( utility::issharedfuncdefined( #"radiation", #"radiation_isinit" ) && utility::issharedfuncdefined( #"radiation", #"radiation_signeddistancefromradiationcircle" ) )
    {
        if ( [[ utility::getsharedfunc( #"radiation", #"radiation_isinit" ) ]]() )
        {
            var_90e10079802f5e8a = [[ utility::getsharedfunc( #"radiation", #"radiation_signeddistancefromradiationcircle" ) ]]( self.origin );
            in_radiation = var_90e10079802f5e8a <= 0;
            
            if ( in_radiation )
            {
                radiation_factor = 1;
            }
            else
            {
                radiation_factor = clamp( -1 * var_90e10079802f5e8a / level.geigercounterstruct.radiationmaxdist + 1, 0, 1 );
            }
        }
    }
    
    angle_factor = 0;
    
    if ( isdefined( object ) )
    {
        player_forward = anglestoforward( self getplayerangles() );
        vec_to_obj = vectornormalize( object.origin - self.origin );
        dot_vec = vectordot( player_forward, vec_to_obj );
        angle_factor = clamp( 20 * dist_factor, 0, 1 ) * ( dot_vec + 1 ) / 2;
    }
    
    total_factor = clamp( dist_factor * 0.8 + angle_factor * 0.2 + radiation_factor * 1, 0, 1 );
    
    if ( isdefined( object ) && isdefined( object.var_d288c2304107a71d ) )
    {
        total_factor *= object.var_d288c2304107a71d;
    }
    
    waittime = ( -1 * total_factor + 1 ) * maxwait;
    return waittime;
}

// Namespace geiger_counter
// Params 0
// Checksum 0x59a8f9e7, Offset: 0x11ad
// Size: 0x54
function function_7ef758bd5eb9817b()
{
    if ( function_e5e80425969fd34e() && isnumber( self.geigercounterstruct.var_43cb1c27a49e2dd3 ) )
    {
        return ( clamp( 1.4 - self.geigercounterstruct.var_43cb1c27a49e2dd3, 0, 1.4 ) / 1.4 * 10 );
    }
    
    return 0;
}

/#

    // Namespace geiger_counter
    // Params 0, eflags: 0x4
    // Checksum 0x573bbc02, Offset: 0x120a
    // Size: 0x287, Type: dev
    function private function_9b65ad8083a4a0f2()
    {
        bar_elem = hud_util::createbar( ( 0, 1, 0 ), 180, 12, 0.75 );
        bar_elem hud_util::setpoint( "<dev string:x24>", "<dev string:x2b>", 0, -100 );
        bar_elem.archived = 0;
        bar_elem.hidewheninmenu = 1;
        bar_elem.alpha = 0;
        bar_elem.bar.archived = 0;
        bar_elem.bar.hidewheninmenu = 1;
        bar_elem.bar.alpha = 0;
        bar_elem fadeovertime( 0.4 );
        bar_elem.alpha = 1;
        bar_elem.bar fadeovertime( 0.4 );
        bar_elem.bar.alpha = 1;
        bar_elem.bar thread hud_util::flashthread();
        label_elem = hud_util::createfontstring( "<dev string:x32>", 1.1 );
        label_elem settext( "<dev string:x3a>" );
        label_elem hud_util::setpoint( "<dev string:x24>", "<dev string:x2b>", 0, -126 );
        label_elem.archived = 0;
        label_elem.hidewheninmenu = 1;
        label_elem.color = ( 0.7, 1, 0.7 );
        label_elem.alpha = 0;
        label_elem fadeovertime( 0.4 );
        label_elem.alpha = 1;
        value_elem = hud_util::createfontstring( "<dev string:x32>", 1.1 );
        value_elem hud_util::setpoint( "<dev string:x24>", "<dev string:x2b>", 0, -113 );
        value_elem.archived = 0;
        value_elem.hidewheninmenu = 1;
        value_elem.color = ( 1, 1, 1 );
        value_elem.alpha = 0;
        value_elem fadeovertime( 0.4 );
        value_elem.alpha = 1;
        
        if ( !isdefined( self.var_b3f65f96ccbd7135 ) )
        {
            self.var_b3f65f96ccbd7135 = spawnstruct();
        }
        
        self.var_b3f65f96ccbd7135.bar_elem = bar_elem;
        self.var_b3f65f96ccbd7135.label_elem = label_elem;
        self.var_b3f65f96ccbd7135.value_elem = value_elem;
    }

    // Namespace geiger_counter
    // Params 0, eflags: 0x4
    // Checksum 0x3b6a1798, Offset: 0x1499
    // Size: 0xd8, Type: dev
    function private function_2ef546174b16d94a()
    {
        bar_elem = self.var_b3f65f96ccbd7135.bar_elem;
        label_elem = self.var_b3f65f96ccbd7135.label_elem;
        value_elem = self.var_b3f65f96ccbd7135.value_elem;
        thread function_f91acdea99d869f5( bar_elem, 0.4 );
        thread function_f91acdea99d869f5( bar_elem.bar, 0.4 );
        thread function_f91acdea99d869f5( label_elem, 0.4 );
        thread function_f91acdea99d869f5( value_elem, 0.4 );
        self.var_b3f65f96ccbd7135.bar_elem = undefined;
        self.var_b3f65f96ccbd7135.label_elem = undefined;
        self.var_b3f65f96ccbd7135.value_elem = undefined;
    }

    // Namespace geiger_counter
    // Params 2, eflags: 0x4
    // Checksum 0x735ae3c0, Offset: 0x1579
    // Size: 0x2e, Type: dev
    function private function_f91acdea99d869f5( hud_elem, duration )
    {
        hud_elem hud_util::transitionfadeout( duration );
        wait duration;
        hud_elem hud_util::destroyelem();
    }

    // Namespace geiger_counter
    // Params 0, eflags: 0xc
    // Checksum 0x64592d47, Offset: 0x15af
    // Size: 0x19a, Type: dev
    function private function_b5d1e23479c0928()
    {
        self notify( #"hash_b92cdf7fd816f744" );
        self endon( #"hash_b92cdf7fd816f744" );
        self endon( #"death_or_disconnect" );
        level endon( #"game_ended" );
        hud_is_active = 0;
        
        while ( true )
        {
            if ( function_e5e80425969fd34e() )
            {
                if ( !isdefined( self.var_b3f65f96ccbd7135.bar_elem ) )
                {
                    function_9b65ad8083a4a0f2();
                    hud_is_active = 1;
                }
                
                geiger_value = function_7ef758bd5eb9817b();
                current_frac = clamp( geiger_value / 10, 0, 1 );
                self.var_b3f65f96ccbd7135.bar_elem hud_util::updatebar( current_frac, 0 );
                self.var_b3f65f96ccbd7135.bar_elem.bar.color = function_ce8a657011339e33( current_frac );
                
                if ( geiger_value <= 0 )
                {
                    self.var_b3f65f96ccbd7135.value_elem settext( "<dev string:x49>" );
                }
                else
                {
                    self.var_b3f65f96ccbd7135.value_elem setvalue( geiger_value );
                }
                
                self.var_b3f65f96ccbd7135.label_elem.color = vectorlerp( ( 0.7, 1, 0.7 ), ( 1, 0, 0 ), current_frac * current_frac );
            }
            else if ( hud_is_active && isdefined( self.var_b3f65f96ccbd7135.bar_elem ) )
            {
                function_2ef546174b16d94a();
                hud_is_active = 0;
            }
            
            wait 0.1;
        }
    }

    // Namespace geiger_counter
    // Params 1, eflags: 0x4
    // Checksum 0x2766a16e, Offset: 0x1751
    // Size: 0x6e, Type: dev
    function private function_ce8a657011339e33( frac )
    {
        if ( frac < 0.5 )
        {
            return vectorlerp( ( 0, 1, 0 ), ( 1, 0.75, 0 ), frac * 2 );
        }
        
        return vectorlerp( ( 1, 0.75, 0 ), ( 1, 0, 0 ), ( frac - 0.5 ) * 2 );
    }

#/
