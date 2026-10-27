// scripts\mp\player\grapple.gsc  (hash_63155964030ba08f.gscc) (size: 9539 Bytes / 0x2543 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xedaf32 (15576882)
// size ...... 9539 (0x2543)
// includes .. 11  (offset: 0x23fb)
// strings ... 17  (offset: 0x2453)
// dev strs .. 1   (offset: 0x2537)
// exports ... 33  (offset: 0x1413)
// cseg ...... 0x1f5 + 0x121e (0x1413)
// imports ... 90  (offset: 0x193b)
// animtree1 . 0   (offset: 0x2543)
// animtree2 . 0   (offset: 0x2543)
#using script_53651341190c5aab;
#using scripts\asm\asm;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_interact;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\challenges;

#namespace grapple;

// Namespace grapple
// Params 0
// Checksum 0x19790b90, Offset: 0x213
// Size: 0x35
function initdvars()
{
    setdvarifuninitialized( @"hash_25da7e472740e1b7", 2500 );
    setdvarifuninitialized( @"hash_5c86617c97658e74", 1 );
    
    /#
        setdvarifuninitialized( @"hash_628e57d55bcbc0a", 0 );
    #/
}

// Namespace grapple
// Params 0, eflags: 0x4
// Checksum 0xff2e7dd1, Offset: 0x250
// Size: 0x1b, Type: bool
function private function_1c21e8b109ee89ab()
{
    return function_8dc5b104b1dc3d3d() && getdvarint( @"hash_5c86617c97658e74", 1 );
}

// Namespace grapple
// Params 0, eflags: 0x4
// Checksum 0xf9e12e82, Offset: 0x274
// Size: 0x10
function private function_8dc5b104b1dc3d3d()
{
    return getdvarint( @"hash_32a63a36d6fdae72", 0 );
}

// Namespace grapple
// Params 5
// Checksum 0xddcdb75e, Offset: 0x28d
// Size: 0xa5
function function_a0d6ef86f55e7cfd( player, var_6d77615d413e473, var_5f6c4852cd132f94, var_10e74ff0f4e2f89f, var_804822edb660c8fc )
{
    if ( !function_1c21e8b109ee89ab() )
    {
        return;
    }
    
    function_a94e14b573700765( player );
    
    if ( !isdefined( player.grapple ) )
    {
        player.grapple = {};
    }
    
    thread function_f462f5469cfd9cc6( player, "grapple_fire_success" );
    thread function_f462f5469cfd9cc6( player, "grapple_fire_fail" );
    thread function_f462f5469cfd9cc6( player, "grapple_takeoff" );
    thread function_f462f5469cfd9cc6( player, "grapple_detach" );
    thread function_f462f5469cfd9cc6( player, "grapple_end" );
}

// Namespace grapple
// Params 1
// Checksum 0x9e4c05a1, Offset: 0x33a
// Size: 0x24
function function_a94e14b573700765( player )
{
    if ( !function_1c21e8b109ee89ab() )
    {
        return;
    }
    
    player notify( #"hash_15ffb00814c5d5bb" );
}

// Namespace grapple
// Params 4, eflags: 0x4
// Checksum 0x90d01bc9, Offset: 0x366
// Size: 0x99
function private function_e322c36b9f9d70aa( player, var_5f6c4852cd132f94, var_10e74ff0f4e2f89f, var_804822edb660c8fc )
{
    player endon( #"disconnect" );
    player endon( #"game_ended" );
    player endon( #"grapple_cleanup" );
    
    while ( true )
    {
        waittillframeend();
        
        if ( !isplayervalid( player ) )
        {
            return;
        }
        
        donegrappling = function_a971773db1e139c2( player, var_5f6c4852cd132f94, var_10e74ff0f4e2f89f, var_804822edb660c8fc );
        
        if ( donegrappling )
        {
            resetnotifies( player );
            return;
        }
        
        player waittill( #"hash_b770976aeaa918d4" );
    }
}

// Namespace grapple
// Params 2, eflags: 0x4
// Checksum 0x715759db, Offset: 0x407
// Size: 0xda
function private function_f462f5469cfd9cc6( player, notifyname )
{
    player endon( #"disconnect" );
    player endon( #"game_ended" );
    player endon( #"hash_15ffb00814c5d5bb" );
    singletoncheck = "watching_notify_" + notifyname;
    player notify( singletoncheck );
    player endon( singletoncheck );
    
    while ( true )
    {
        player waittill( notifyname );
        
        if ( !isdefined( player.grapple.notifiesreceived ) )
        {
            player.grapple.notifiesreceived = [];
        }
        
        if ( !isdefined( player.grapple.notifiesreceived[ notifyname ] ) )
        {
            player.grapple.notifiesreceived[ notifyname ] = 1;
        }
        
        player notify( #"hash_b770976aeaa918d4" );
    }
}

// Namespace grapple
// Params 2, eflags: 0x4
// Checksum 0xbdfe4361, Offset: 0x4e9
// Size: 0x4e, Type: bool
function private consumenotify( player, notifyname )
{
    if ( player.grapple.notifiesreceived[ notifyname ] )
    {
        player.grapple.notifiesreceived[ notifyname ] = 0;
        return true;
    }
    
    return false;
}

// Namespace grapple
// Params 1, eflags: 0x4
// Checksum 0x87f023e4, Offset: 0x540
// Size: 0x23
function private resetnotifies( player )
{
    player.grapple.notifiesreceived = [];
}

// Namespace grapple
// Params 1, eflags: 0x4
// Checksum 0x8c97f841, Offset: 0x56b
// Size: 0x21
function private function_176097a37d5ba128( player )
{
    player.grapple.ispulling = undefined;
}

// Namespace grapple
// Params 4, eflags: 0x4
// Checksum 0x89155b0b, Offset: 0x594
// Size: 0xb4, Type: bool
function private function_a971773db1e139c2( player, var_5f6c4852cd132f94, var_10e74ff0f4e2f89f, var_804822edb660c8fc )
{
    if ( consumenotify( player, "grapple_fire_fail" ) )
    {
        function_b804753244fcec7f( player, var_5f6c4852cd132f94 );
        return true;
    }
    
    if ( consumenotify( player, "grapple_fire_success" ) )
    {
        function_4301831c56cf187e( player );
    }
    
    if ( consumenotify( player, "grapple_takeoff" ) )
    {
        ontakeoff( player, var_10e74ff0f4e2f89f );
    }
    
    if ( consumenotify( player, "grapple_detach" ) )
    {
        ondetach( player, var_804822edb660c8fc );
        return true;
    }
    else if ( consumenotify( player, "grapple_end" ) )
    {
        function_176097a37d5ba128( player );
        return true;
    }
    
    return false;
}

// Namespace grapple
// Params 4
// Checksum 0x2cfd89f6, Offset: 0x651
// Size: 0x4d
function function_17da84fdf0008ba6( player, var_5f6c4852cd132f94, var_10e74ff0f4e2f89f, var_804822edb660c8fc )
{
    if ( function_1c21e8b109ee89ab() )
    {
        thread function_e322c36b9f9d70aa( player, var_5f6c4852cd132f94, var_10e74ff0f4e2f89f, var_804822edb660c8fc );
        return;
    }
    
    thread function_22186b20639ad072( player, var_5f6c4852cd132f94, var_10e74ff0f4e2f89f, var_804822edb660c8fc );
}

// Namespace grapple
// Params 4, eflags: 0x4
// Checksum 0xf67a1e45, Offset: 0x6a6
// Size: 0xb1
function private function_22186b20639ad072( player, var_5f6c4852cd132f94, var_10e74ff0f4e2f89f, var_804822edb660c8fc )
{
    player notify( #"grapple_fire" );
    player endon( #"grapple_fire" );
    player endon( #"grapple_cleanup" );
    thread monitorcleanup( player );
    player endon( #"disconnect" );
    player endon( #"game_ended" );
    
    if ( !player isgrapplefiring() )
    {
        function_b804753244fcec7f( player, var_5f6c4852cd132f94 );
        return;
    }
    
    function_4301831c56cf187e( player );
    function_e9d7fa91dc050661( player, var_5f6c4852cd132f94, var_10e74ff0f4e2f89f );
    
    if ( !function_9db6a267e90b4b54( player ) )
    {
        return;
    }
    
    function_5cf0aa7b9f630cc7( player, var_804822edb660c8fc );
}

// Namespace grapple
// Params 1, eflags: 0x4
// Checksum 0xd8be9c18, Offset: 0x75f
// Size: 0xbf
function private function_2ae01d849a1278a0( player )
{
    startorigin = player.grapple.startorigin;
    endorigin = player.origin;
    dist = int( distance( startorigin, endorigin ) ) ?? 0;
    
    if ( level.var_3e31ac1c46a58193 )
    {
        var_adc0155d1bded646 = 0.0254;
        dist = int( math::round_float( var_adc0155d1bded646 * dist, 2 ) );
    }
    
    challenges::function_3d7a169dbae062fb( "equip_grappling_hook", player, dist, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ) );
    player.var_a0a222315f11cfef = gettime();
}

// Namespace grapple
// Params 1
// Checksum 0x5bc6429b, Offset: 0x826
// Size: 0x24
function forcecleanup( player )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    player notify( #"grapple_cleanup" );
}

// Namespace grapple
// Params 1, eflags: 0x4
// Checksum 0x485931eb, Offset: 0x852
// Size: 0x58
function private monitorcleanup( player )
{
    player endon( #"disconnect" );
    player endon( #"game_ended" );
    player endon( #"grapple_fire_fail" );
    player endon( #"grapple_detach" );
    player waittill( #"grapple_cleanup" );
    function_9ed1092657f1b471( player, 0 );
}

// Namespace grapple
// Params 3, eflags: 0x4
// Checksum 0x1dedcf80, Offset: 0x8b2
// Size: 0x70
function private function_e9d7fa91dc050661( player, var_5f6c4852cd132f94, var_10e74ff0f4e2f89f )
{
    starttime = gettime();
    
    while ( true )
    {
        if ( !isplayervalid( player ) )
        {
            return;
        }
        
        if ( player function_4606504606c25e36() )
        {
            ontakeoff( player, var_10e74ff0f4e2f89f );
            return;
        }
        else if ( !player isgrapplefiring() )
        {
            function_b804753244fcec7f( player, var_5f6c4852cd132f94 );
            return;
        }
        
        waitframe();
    }
}

// Namespace grapple
// Params 2, eflags: 0x4
// Checksum 0x1e9f7934, Offset: 0x92a
// Size: 0x40
function private function_5cf0aa7b9f630cc7( player, var_804822edb660c8fc )
{
    while ( true )
    {
        if ( !isplayervalid( player ) )
        {
            return;
        }
        
        if ( !player function_41360f0bcfc012aa() )
        {
            ondetach( player, var_804822edb660c8fc );
            return;
        }
        
        waitframe();
    }
}

// Namespace grapple
// Params 2, eflags: 0x4
// Checksum 0x64ca121b, Offset: 0x972
// Size: 0x2e
function private function_2120dd6529a4cd1b( player, function )
{
    if ( isfunction( function ) && isplayer( player ) )
    {
        player thread [[ function ]]();
    }
}

// Namespace grapple
// Params 1, eflags: 0x4
// Checksum 0x9b8c8e6b, Offset: 0x9a8
// Size: 0x1c, Type: bool
function private isplayervalid( player )
{
    return isplayer( player ) && isalive( player );
}

// Namespace grapple
// Params 1, eflags: 0x4
// Checksum 0x974747, Offset: 0x9cd
// Size: 0x38, Type: bool
function private function_9db6a267e90b4b54( player )
{
    isvalid = isplayervalid( player );
    var_598f30435a876fa5 = player function_41360f0bcfc012aa();
    return isvalid && var_598f30435a876fa5;
}

// Namespace grapple
// Params 2, eflags: 0x4
// Checksum 0xd191b74b, Offset: 0xa0e
// Size: 0x44
function private function_b804753244fcec7f( player, var_5f6c4852cd132f94 )
{
    player telemetry_utils::function_bce6584b90db3f0d( "grapple_miss" );
    
    if ( !function_8dc5b104b1dc3d3d() )
    {
        player notify( #"grapple_fire_fail" );
    }
    
    function_2120dd6529a4cd1b( player, var_5f6c4852cd132f94 );
}

// Namespace grapple
// Params 1, eflags: 0x4
// Checksum 0x7ff8c475, Offset: 0xa5a
// Size: 0x48
function private function_4301831c56cf187e( player )
{
    if ( !isdefined( player.grapple ) )
    {
        player.grapple = {};
    }
    
    player.grapple.startorigin = player.origin;
}

// Namespace grapple
// Params 2, eflags: 0x4
// Checksum 0x27f35719, Offset: 0xaaa
// Size: 0xce
function private ontakeoff( player, var_10e74ff0f4e2f89f )
{
    player.grapple.ispulling = 1;
    player telemetry_utils::function_bce6584b90db3f0d( "grapple_hit" );
    
    if ( !function_8dc5b104b1dc3d3d() )
    {
        player notify( #"grapple_takeoff" );
    }
    
    player callback::callback( #"player_aerial", { #end:"grapple_detach" } );
    player callback::callback( #"hash_38e04a6ab5e82438", { #origin:player function_ed43d0f767c7f26b() } );
    thread function_3db18e3d5265f586( player );
    thread function_701bd4842cdf2b48( player );
    
    /#
        if ( getdvarint( @"hash_85c254b804bf6882", 0 ) )
        {
            thread function_52074f0089356a7( player );
        }
    #/
    
    function_2120dd6529a4cd1b( player, var_10e74ff0f4e2f89f );
}

// Namespace grapple
// Params 2, eflags: 0x4
// Checksum 0x84c72afc, Offset: 0xb80
// Size: 0x5d
function private ondetach( player, var_804822edb660c8fc )
{
    player.grapple.ispulling = undefined;
    
    if ( !function_8dc5b104b1dc3d3d() )
    {
        player notify( #"grapple_detach" );
    }
    
    thread preventfalldamage( player );
    function_2120dd6529a4cd1b( player, var_804822edb660c8fc );
    function_2ae01d849a1278a0( player );
}

// Namespace grapple
// Params 1, eflags: 0x4
// Checksum 0xd1f23d67, Offset: 0xbe5
// Size: 0x1a4
function private function_3db18e3d5265f586( player )
{
    targetentity = player getgrappletargetentity();
    
    if ( !isdefined( targetentity ) || !targetentity vehicle::is_vehicle() || targetentity vehicle::is_husk() )
    {
        return;
    }
    
    var_7f038a4600b5167e = utility::function_edc4cc03e9e60b3e( @"hash_14f66953f663e919", 0, level.gametypebundle.var_70b3b8bc26607242 ) || targetentity vehicle::ishelicopter() && utility::function_edc4cc03e9e60b3e( @"hash_43ee34d5444b33a", 0, level.gametypebundle.var_8646351c4f5e0357 );
    
    if ( !var_7f038a4600b5167e )
    {
        return;
    }
    
    player endon( #"death_or_disconnect" );
    var_b00ddbe0b1111263 = function_f32665645dc08c( player );
    
    if ( !var_b00ddbe0b1111263 )
    {
        return;
    }
    
    if ( !isdefined( targetentity ) )
    {
        return;
    }
    
    if ( !vehicle_interact::function_a6656fc74b98d1c9( player, targetentity ) )
    {
        return;
    }
    
    if ( getdvarint( @"hash_da6da5029c0d1c9b", 1 ) == 1 )
    {
        player function_b14dead5d492aa48( 1 );
    }
    
    driverseat = vehicle_occupancy::get_driver_seat( targetentity );
    
    if ( vehicle_occupancy::is_seat_available( targetentity, driverseat, player ) )
    {
        thread vehicle_occupancy::enter( targetentity, driverseat, player );
    }
    else
    {
        closestseat = vehicle_interact::get_closest_seat( player, targetentity, driverseat );
        thread vehicle_occupancy::enter( targetentity, closestseat, player );
    }
    
    if ( getdvarint( @"hash_da6da5029c0d1c9b", 1 ) == 1 )
    {
        currtime = 0;
        
        while ( !player vehicle::is_in_vehicle() )
        {
            if ( currtime >= 3 )
            {
                player function_b14dead5d492aa48( 0 );
                return;
            }
            
            wait 0.1;
            currtime += 0.1;
        }
        
        player function_b14dead5d492aa48( 0 );
    }
}

// Namespace grapple
// Params 1, eflags: 0x4
// Checksum 0x84b1bd69, Offset: 0xd91
// Size: 0x4f, Type: bool
function private function_f32665645dc08c( player )
{
    var_16f6d4858b0ab403 = undefined;
    
    while ( player function_41360f0bcfc012aa() )
    {
        var_16f6d4858b0ab403 = player function_ed43d0f767c7f26b();
        waitframe();
    }
    
    if ( !isdefined( var_16f6d4858b0ab403 ) )
    {
        return false;
    }
    
    return distancesquared( player.origin, var_16f6d4858b0ab403 ) <= squared( 80 );
}

// Namespace grapple
// Params 1, eflags: 0x4
// Checksum 0xe5b4f926, Offset: 0xde9
// Size: 0x1c9
function private function_701bd4842cdf2b48( player )
{
    targetent = player getgrappletargetentity();
    
    if ( isalive( targetent ) )
    {
        targetent endon( #"death" );
        
        if ( targetent.unittype == "soldier" && !targetent.bhasriotshieldattached && targetent.var_5609d8c260be3f0e && !targetent function_1b4c437a6367712b() && !targetent.doinglongdeath && !targetent isonascender() && !targetent isonladder() && !isdefined( targetent.sceneobjectdata ) )
        {
            if ( !isdefined( targetent.grappleendtime ) || targetent.grappleendtime < gettime() )
            {
                pullangle = vectortoyaw( player.origin - targetent.origin );
                anglediff = angleclamp180( targetent.angles[ 1 ] - pullangle );
                
                if ( abs( anglediff ) < 45 )
                {
                    targetent.grappleddirection = "forward";
                }
                else if ( anglediff > 0 && anglediff < 135 )
                {
                    targetent.grappleddirection = "right";
                }
                else if ( anglediff < 0 && anglediff > -135 )
                {
                    targetent.grappleddirection = "left";
                }
                else
                {
                    targetent.grappleddirection = "back";
                }
                
                targetent.grappleendtime = gettime() + 3000;
                
                if ( targetent getinteractionid() )
                {
                    targetent interaction_common::leaveskit();
                    waitframe();
                    
                    if ( targetent getinteractionid() )
                    {
                        return;
                    }
                }
                
                targetent asm::function_7256f5ba459c840b( "pain_grappled_transition" );
            }
        }
    }
}

// Namespace grapple
// Params 1, eflags: 0xc
// Checksum 0x15c6d84d, Offset: 0xfba
// Size: 0x163
function private preventfalldamage( player )
{
    self notify( #"hash_81ac69d08eb7fd3a" );
    self endon( #"hash_81ac69d08eb7fd3a" );
    player endon( #"disconnect" );
    player endon( #"game_ended" );
    player endon( #"grapple_cleanup" );
    function_9ed1092657f1b471( player, 1 );
    durationms = getdvarint( @"hash_25da7e472740e1b7", 2500 );
    starttime = gettime();
    
    for ( timeelapsed = 0; timeelapsed < durationms ; timeelapsed = gettime() - starttime )
    {
        if ( !isplayervalid( player ) )
        {
            return;
        }
        
        /#
            if ( getdvarint( @"hash_628e57d55bcbc0a", 0 ) )
            {
                timeremaining = durationms - timeelapsed;
                debugtext = "<dev string:x24>" + round( float( timeremaining ) / 1000, 0.001 );
                printtoscreen2d( 100, 400, debugtext, ( 0, 1, 0 ), 2, 1 );
            }
        #/
        
        if ( player isonground() )
        {
            break;
        }
        
        player.grapple.var_202834a73e3cf7a8 = max( player.grapple.var_202834a73e3cf7a8, player.origin[ 2 ] );
        waitframe();
    }
    
    function_9ed1092657f1b471( player, 0 );
}

// Namespace grapple
// Params 2, eflags: 0x4
// Checksum 0x2e0efd29, Offset: 0x1125
// Size: 0xbf
function private function_9ed1092657f1b471( player, enabled )
{
    if ( !isdefined( player.grapple ) )
    {
        player.grapple = {};
    }
    
    player.grapple.var_202834a73e3cf7a8 = enabled ? player.origin[ 2 ] : undefined;
    
    if ( enabled )
    {
        if ( !isdefined( player.falldamagemodifiers ) )
        {
            player.falldamagemodifiers = [];
        }
        
        player.falldamagemodifiers[ #"grapple" ] = &modifyfalldamage;
        return;
    }
    
    if ( isdefined( player.falldamagemodifiers ) )
    {
        player.falldamagemodifiers[ #"grapple" ] = undefined;
    }
}

// Namespace grapple
// Params 4, eflags: 0x4
// Checksum 0xbb69dfe1, Offset: 0x11ec
// Size: 0x185
function private modifyfalldamage( victim, idamage, idflags, smeansofdeath )
{
    var_cb08085fd9740d37 = utility::function_49a778e73bbb0f58( @"hash_380d9283fc76b65b", "no_damage", level.gametypebundle.var_17dd031edc3cec24 );
    
    switch ( var_cb08085fd9740d37 )
    {
        case #"hash_a67986d15c801ae":
            return 0;
        case #"hash_f77803ae169585f7":
            distancefallen = victim.grapple.var_202834a73e3cf7a8 - victim.origin[ 2 ];
            falldamageminheight = utility::function_48f723fdc612ec65( @"hash_79205e8ca5a95c94", -1, level.gametypebundle.var_d6e2298787c67052 ?? getdvarfloat( @"bg_falldamageminheight", 185 ) );
            falldamagemaxheight = utility::function_48f723fdc612ec65( @"hash_5e29b365643ec236", -1, level.gametypebundle.var_13a6c675bfeb2de4 ?? getdvarfloat( @"bg_falldamagemaxheight", 300 ) );
            assert( falldamagemaxheight != falldamageminheight );
            damagescale = clamp( ( distancefallen - falldamageminheight ) / ( falldamagemaxheight - falldamageminheight ), 0, 1 );
            return minint( idamage, int( victim.maxhealth * damagescale ) );
    }
    
    throw( "grapple::modifyFallDamage reached end of switch(); level.gameTypeBundle.grappleFallDamageProtectionBehavior has an unsupported value." );
    return idamage;
}

/#

    // Namespace grapple
    // Params 1, eflags: 0x4
    // Checksum 0x1b2ca29e, Offset: 0x137a
    // Size: 0x99, Type: dev
    function private function_52074f0089356a7( player )
    {
        player endon( #"death_or_disconnect" );
        player endon( #"grapple_detach" );
        
        while ( true )
        {
            if ( player function_1984b449042336ef() )
            {
                sphere( player function_ed43d0f767c7f26b(), 20 );
                line( player.origin, player function_ed43d0f767c7f26b() );
                sphere( player function_ed43d0f767c7f26b(), 80, ( 0, 1, 0 ) );
            }
            
            if ( player function_b93a5ea643456f57() )
            {
                drawentitybounds( player getgrappletargetentity(), ( 1, 0, 0 ) );
            }
            
            waitframe();
        }
    }

#/
