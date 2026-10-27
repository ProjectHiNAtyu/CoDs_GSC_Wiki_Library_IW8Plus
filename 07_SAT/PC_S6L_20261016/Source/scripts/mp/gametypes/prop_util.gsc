// scripts\mp\gametypes\prop_util.gsc  (hash_0707c77528d5c41a.gscc) (size: 15402 Bytes / 0x3c2a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2ad8521c (718819868)
// size ...... 15402 (0x3c2a)
// includes .. 16  (offset: 0x395e)
// strings ... 42  (offset: 0x39de)
// dev strs .. 4   (offset: 0x3bfa)
// exports ... 40  (offset: 0x2612)
// cseg ...... 0x2c1 + 0x2351 (0x2612)
// imports ... 111 (offset: 0x2c52)
// animtree1 . 0   (offset: 0x3c2a)
// animtree2 . 0   (offset: 0x3c2a)
#using script_4617bf9ad5301e1a;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damagefeedback;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gametypes\prop_controls;
#using scripts\mp\potg;
#using scripts\mp\potg_events;

#namespace prop_util;

// Namespace prop_util
// Params 0
// Checksum 0xab67e21e, Offset: 0x2df
// Size: 0x93
function function_98c109222275e806()
{
    level.var_bb9ffc6d4ec820d3[ #"xsmall" ] = #"prop_death_xsmall";
    level.var_bb9ffc6d4ec820d3[ #"small" ] = #"prop_death_small";
    level.var_bb9ffc6d4ec820d3[ #"medium" ] = #"prop_death_medium";
    level.var_bb9ffc6d4ec820d3[ #"large" ] = #"prop_death_large";
    level.var_bb9ffc6d4ec820d3[ #"xlarge" ] = #"prop_death_xlarge";
}

// Namespace prop_util
// Params 0
// Checksum 0x5a2e7450, Offset: 0x37a
// Size: 0x3a4
function populateproplist()
{
    level.proplist = [];
    level.var_adae36019be713b6 = [];
    var_c6c711b3f13d7bdf = level.mapinfobundle.var_128921397c49756d != %"" ? level.mapinfobundle.var_128921397c49756d : level.prop_bundle.var_d95ae4b4a1af856;
    additionalhealth = getdvarint( @"hash_71a1de9c0847d49c", 0 );
    var_351962bb86d9021a = getscriptbundle( var_c6c711b3f13d7bdf );
    assert( isdefined( var_351962bb86d9021a ), "<dev string:x24>" );
    
    foreach ( var_456ff2b0d7eb0ece in var_351962bb86d9021a.var_9b87f1a8630cd7ff )
    {
        sizedata = spawnstruct();
        size = var_456ff2b0d7eb0ece.propsize;
        sizedata.health = max( var_456ff2b0d7eb0ece.prophealth + additionalhealth, 1 );
        sizedata.cameraoffset = ( var_456ff2b0d7eb0ece.cameraoffsetx, var_456ff2b0d7eb0ece.cameraoffsety, var_456ff2b0d7eb0ece.cameraoffsetz );
        sizedata.movespeedscale = var_456ff2b0d7eb0ece.movespeedscale;
        sizedata.var_5ed5ba703fac9749 = loadfxasset( var_456ff2b0d7eb0ece.var_5ed5ba703fac9749 );
        sizedata.var_96d53faf2e3aa899 = loadfxasset( var_456ff2b0d7eb0ece.var_96d53faf2e3aa899 );
        sizedata.var_e3ba811e2ff864cb = level.var_bb9ffc6d4ec820d3[ var_456ff2b0d7eb0ece.propsize ];
        
        if ( !isdefined( level.var_adae36019be713b6[ size ] ) )
        {
            level.var_adae36019be713b6[ size ] = sizedata;
        }
    }
    
    var_9ae1884e698a6a80 = getdvar( hashcat( @"hash_aae80d066768319", level.mapname ), "" );
    var_39d1fb4d69ed2f04 = utility::function_b104528d84ca3561( var_9ae1884e698a6a80, "," );
    
    foreach ( index, var_3c1d842bbd0a6881 in var_351962bb86d9021a.var_4e55d3e84a42bfa2 )
    {
        if ( arraycontains( var_39d1fb4d69ed2f04, index ) )
        {
            continue;
        }
        
        propentry = getscriptbundle( var_3c1d842bbd0a6881.var_b7b682ea28a73b17 );
        assert( isdefined( propentry ), "<dev string:x70>" );
        propsize = propentry.propsize;
        
        if ( !isdefined( level.proplist[ propsize ] ) )
        {
            level.proplist[ propsize ] = [];
        }
        
        /#
            if ( !isdefined( level.propindex ) )
            {
                level.propindex = [];
            }
            
            index = level.propindex.size;
            level.propindex[ index ] = [];
            level.propindex[ index ][ 0 ] = propsize;
            level.propindex[ index ][ 1 ] = level.proplist[ propsize ].size;
        #/
        
        level.proplist[ propsize ][ level.proplist[ propsize ].size ] = propentry;
    }
}

// Namespace prop_util
// Params 0
// Checksum 0x6bd05fb9, Offset: 0x726
// Size: 0x1bd
function handleprop()
{
    function_42e4be2c68b13179( 0 );
    self setmovespeedscale( 1.5 );
    self disableexecutionvictim();
    self sethidenameplate( 1 );
    self forcethirdpersonwhenspectating();
    utility::callsharedfunc( #"gametype", #"hash_2bfe88f2d50ff4f7" );
    self function_16332a7775f10aa9();
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        thread function_7a96eeaeddde7e11();
    }
    
    self disableweapons();
    self disableweaponpickup();
    self.var_2742dd3ad4b6d5af = 0;
    self.lock = 0;
    isrespawn = istrue( self.var_cdd796b8829a3b3b );
    self.var_cdd796b8829a3b3b = 0;
    thread setupprop( isrespawn );
    
    if ( !isrespawn )
    {
        self.changesleft = level.prop_bundle.propchanges;
        self.clonesleft = level.prop_bundle.clonesperprop;
        self.abilityleft = level.prop_bundle.abilitycharges;
        self.var_27beb331de1da5b3 = 1;
        self.var_9a7122a34aec5460 = 0;
        self setclientomnvar( o"ui_prop_clones_remaining", self.clonesleft );
        self setclientomnvar( o"ui_prop_changes_remaining", self.changesleft );
        self setclientomnvar( o"ui_prop_ability_remaining", self.abilityleft );
    }
    
    if ( isdefined( level.elevators ) && level.elevators.size > 0 )
    {
        thread function_452c2201bf7cd600();
    }
    
    if ( level.var_adae36019be713b6[ self.prop.info.propsize ].var_96d53faf2e3aa899 )
    {
        thread function_bea17481e1c6b223();
    }
}

// Namespace prop_util
// Params 0
// Checksum 0x9c84e191, Offset: 0x8eb
// Size: 0x28
function function_3dd5ca52fb14c180()
{
    self.isangleoffset = 0;
    handleprop();
    namespace_404586677d964be2::function_8d1d8ac7a51591b4();
    thread namespace_404586677d964be2::function_b359d5089f6b5dd0();
    thread function_a96eb028d23856c1();
}

// Namespace prop_util
// Params 0
// Checksum 0x5b3b533e, Offset: 0x91b
// Size: 0xe5
function function_6c11d155d255c50e()
{
    self notify( #"hash_fda2d08c64f99064" );
    self endon( #"hash_fda2d08c64f99064" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_e79ffe6977c02c64" );
    inwater = undefined;
    damageovertime = 0;
    
    while ( true )
    {
        if ( self isswimming() || self isswimunderwater() || utility::ispointinwater( self.origin ) )
        {
            if ( !inwater )
            {
                damageovertime = ceil( min( self.health / level.prop_bundle.var_a4519a2ba1f1932f, self.maxhealth / level.prop_bundle.var_9ebbb8c05b207d64 ) );
                inwater = 1;
            }
            
            self dodamage( damageovertime, self.origin, self, undefined, "MOD_TRIGGER_HURT" );
        }
        else
        {
            inwater = undefined;
        }
        
        wait 1;
    }
}

// Namespace prop_util
// Params 1
// Checksum 0xddbc25ed, Offset: 0xa08
// Size: 0xdb
function function_42e4be2c68b13179( allow )
{
    if ( !level.var_ba8511461d986478 )
    {
        var_35e019265bca12b9 = [ "prone", "slide", "crouch", "sprint", "melee", "lean", "dtp", "ads", "vehicle_use", "allow_toggle_third_person", "base_jumping", "allow_emote" ];
        
        if ( !level.prop_bundle.var_7282d05f97aeac5e )
        {
            var_35e019265bca12b9[ var_35e019265bca12b9.size ] = "swimming_underwater";
        }
        
        val::group_register( "prop_util", var_35e019265bca12b9 );
        level.var_ba8511461d986478 = 1;
    }
    
    val::group_set( "prop_util", allow );
}

// Namespace prop_util
// Params 0
// Checksum 0x1c2586f4, Offset: 0xaeb
// Size: 0x23
function function_7a96eeaeddde7e11()
{
    level endon( #"game_ended" );
    self waittill( #"hash_193e233f169e993f" );
    function_42e4be2c68b13179( 0 );
}

// Namespace prop_util
// Params 1
// Checksum 0x4de69e60, Offset: 0xb16
// Size: 0x14e
function setupprop( isrespawn )
{
    propinfo = 0;
    
    if ( isrespawn )
    {
        var_e9ffc6db36ed369e = self.var_c87757790d2ceabd - 1;
        
        if ( var_e9ffc6db36ed369e < 0 )
        {
            var_e9ffc6db36ed369e = 2;
        }
        
        propinfo = self.usedprops[ var_e9ffc6db36ed369e ];
    }
    else
    {
        propinfo = getnextprop( self );
    }
    
    self.playeranchor = spawn( "script_model", self.origin, undefined, 1 );
    self.propent = spawn( "script_model", self.origin, undefined, 1 );
    self.propent.targetname = "propEnt";
    self.propent namespace_404586677d964be2::proplinkto( self );
    self.propent setmodel( "tag_origin" );
    namespace_404586677d964be2::function_7a6feea14aa0f83e( propinfo );
    
    if ( !isrespawn )
    {
        self.usedprops[ 0 ] = propinfo;
        self.var_c87757790d2ceabd = 1;
    }
    
    self setsuit( getxhashhexname( level.prop_bundle.propsuit ) );
    self setcamerathirdperson( 1 );
    player_utility::function_dbe5a52a6654a982( 1 );
    player_utility::function_9d378d725bb4831e( "prop_util::setupProp()" );
    self.var_485899a46494a80f = &function_36551aaaa2f6699c;
    self notify( #"prop_setup" );
}

// Namespace prop_util
// Params 0
// Checksum 0xed8a067a, Offset: 0xc6c
// Size: 0x3d
function function_452c2201bf7cd600()
{
    self endon( #"death_or_disconnect", #"hash_e79ffe6977c02c64" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        namespace_404586677d964be2::function_22dfdf977055d577( !self.isinsideelevator );
        waitframe();
    }
}

// Namespace prop_util
// Params 1
// Checksum 0x2f1f968e, Offset: 0xcb1
// Size: 0x1c8
function getnextprop( player )
{
    var_d1d1ed8175f26c7f = function_92c0c3066b47b9c9();
    var_13225a292f46ee52 = getarraykeys( level.proplist );
    var_13225a292f46ee52 = arrayrandomize( var_13225a292f46ee52 );
    propsizes[ 0 ] = var_d1d1ed8175f26c7f;
    
    foreach ( propsize in var_13225a292f46ee52 )
    {
        if ( propsize != var_d1d1ed8175f26c7f )
        {
            propsizes[ propsizes.size ] = propsize;
        }
    }
    
    prop = undefined;
    
    for ( i = 0; i < propsizes.size ; i++ )
    {
        propsize = propsizes[ i ];
        
        if ( !isdefined( level.proplist[ propsize ] ) || !level.proplist[ propsize ].size )
        {
            continue;
        }
        
        var_c5a542ee78d57add = arrayrandomize( level.proplist[ propsize ] );
        
        for ( j = 0; j < var_c5a542ee78d57add.size ; j++ )
        {
            prop = var_c5a542ee78d57add[ j ];
            propused = 0;
            
            if ( isdefined( player.usedprops ) && player.usedprops.size )
            {
                for ( index = 0; index < player.usedprops.size ; index++ )
                {
                    if ( prop namespace_404586677d964be2::function_74370aae7c7fe123() == player.usedprops[ index ] namespace_404586677d964be2::function_74370aae7c7fe123() )
                    {
                        propused = 1;
                        break;
                    }
                }
            }
            
            if ( !propused )
            {
                return prop;
            }
        }
    }
    
    return prop;
}

// Namespace prop_util
// Params 0
// Checksum 0x2dcacf82, Offset: 0xe82
// Size: 0x15b
function function_10284169939e1db8()
{
    var_d1d1ed8175f26c7f = function_92c0c3066b47b9c9();
    var_13225a292f46ee52 = getarraykeys( level.proplist );
    var_13225a292f46ee52 = arrayrandomize( var_13225a292f46ee52 );
    propsizes[ 0 ] = var_d1d1ed8175f26c7f;
    
    foreach ( propsize in var_13225a292f46ee52 )
    {
        if ( propsize != var_d1d1ed8175f26c7f )
        {
            propsizes[ propsizes.size ] = propsize;
        }
    }
    
    foreach ( propsize in propsizes )
    {
        if ( !isdefined( level.proplist[ propsize ] ) || !level.proplist[ propsize ].size )
        {
            continue;
        }
        
        return utility::array_random( level.proplist[ propsize ] );
    }
    
    assertmsg( "<dev string:x83>" );
}

// Namespace prop_util
// Params 0
// Checksum 0x875a9592, Offset: 0xfe5
// Size: 0x12f
function function_92c0c3066b47b9c9()
{
    weight_xsmall = 10 * isdefined( level.proplist[ #"xsmall" ] );
    weight_small = 30 * isdefined( level.proplist[ #"small" ] );
    weight_medium = 40 * isdefined( level.proplist[ #"medium" ] );
    weight_large = 20 * isdefined( level.proplist[ #"large" ] );
    weight_xlarge = 10 * isdefined( level.proplist[ #"xlarge" ] );
    randomrange = weight_xsmall + weight_small + weight_medium + weight_large + weight_xlarge;
    randomval = randomint( randomrange );
    
    if ( randomval < weight_xsmall )
    {
        return #"xsmall";
    }
    
    randomval -= weight_xsmall;
    
    if ( randomval < weight_small )
    {
        return #"small";
    }
    
    randomval -= weight_small;
    
    if ( randomval < weight_medium )
    {
        return #"medium";
    }
    
    randomval -= weight_medium;
    
    if ( randomval < weight_large )
    {
        return #"large";
    }
    
    return #"xlarge";
}

// Namespace prop_util
// Params 1
// Checksum 0x89125f88, Offset: 0x111d
// Size: 0x28b
function propcleanup( shouldrespawn )
{
    if ( !shouldrespawn )
    {
        prop_died = !isalive( self );
        function_77b56b69ceda58cb( prop_died );
    }
    
    function_bb805d327039ae4a();
    self notify( #"hash_e79ffe6977c02c64" );
    self sethidenameplate( 0 );
    self function_b63e3c462f2e452b( ( 0, 0, 0 ) );
    self setpropentity();
    self setsolid( 1 );
    utility::callsharedfunc( #"gametype", #"hash_3f9e7bc9e02f07f7" );
    propents = [ self.prop, self.propent, self.playeranchor ];
    
    foreach ( prop in propents )
    {
        if ( isdefined( prop ) )
        {
            prop unlink();
        }
    }
    
    self setsuit( utility::function_f825237e0eda5adf() );
    propclones = self.propclones;
    waitframe();
    
    foreach ( prop in propents )
    {
        if ( isdefined( prop ) )
        {
            prop delete();
        }
    }
    
    if ( isdefined( propclones ) && !shouldrespawn )
    {
        foreach ( clone in propclones )
        {
            if ( isdefined( clone ) )
            {
                clone delete();
            }
        }
    }
    
    if ( self.var_3df54955122609ce )
    {
        self.var_3df54955122609ce prophuntcontrols::unregister( self, 1 );
        self.var_3df54955122609ce = undefined;
    }
    
    if ( outline::isoutlineenabled( self, self.var_ee2e9aee4d375a6 ) )
    {
        outline::outlinedisable( self.var_ee2e9aee4d375a6, self );
        self.var_ee2e9aee4d375a6 = undefined;
    }
}

// Namespace prop_util
// Params 0
// Checksum 0xdd712f9f, Offset: 0x13b0
// Size: 0x35
function function_bb805d327039ae4a()
{
    if ( !isdefined( self.var_3df54955122609ce ) )
    {
        return;
    }
    
    if ( self.var_3df54955122609ce prophuntcontrols::is_open( self ) )
    {
        self.var_3df54955122609ce prophuntcontrols::close( self );
    }
}

// Namespace prop_util
// Params 0
// Checksum 0xa4788691, Offset: 0x13ed
// Size: 0x96
function function_a96eb028d23856c1()
{
    self endon( #"death_or_disconnect", #"hash_e79ffe6977c02c64" );
    level endon( #"game_ended" );
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level waittill( #"prematch_done" );
    }
    
    var_be9f31666ff840df = level.var_be9f31666ff840df ?? &prophuntcontrols::register;
    
    if ( !isdefined( self.var_3df54955122609ce ) )
    {
        self.var_3df54955122609ce = [[ var_be9f31666ff840df ]]();
    }
    
    wait 2;
    
    if ( isdefined( self.var_3df54955122609ce ) )
    {
        self.var_3df54955122609ce prophuntcontrols::open( self );
    }
}

// Namespace prop_util
// Params 1
// Checksum 0x7dae8afd, Offset: 0x148b
// Size: 0xe0
function function_ab96eb7ce6578a04( damagecallback )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        self thread [[ damagecallback ]]( damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
    }
}

// Namespace prop_util
// Params 14
// Checksum 0x481a4f98, Offset: 0x1573
// Size: 0x2af
function damagewatch( damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor )
{
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    if ( isplayer( attacker ) )
    {
        if ( attacker.pers[ "team" ] == self.owner.pers[ "team" ] )
        {
            return;
        }
        
        attacker thread damagefeedback::updatehitmarker();
    }
    
    var_614504e828077234 = utility::callsharedfunc( #"gametype", #"hash_f402b2e32efea4e" ) ?? 1;
    
    if ( !var_614504e828077234 )
    {
        return;
    }
    
    if ( !self.owner dodamage( damage, point, attacker, attacker, "MOD_TRIGGER_HURT", undefined, "torso_upper", undefined, idflags ) )
    {
        return;
    }
    
    self.owner playrumbleonentity( "damage_light" );
    self.maxhealth = 99999;
    self.health = 99999;
    
    if ( !isdefined( self.owner.var_bb119a65b78df3f6 ) )
    {
        self.owner.var_bb119a65b78df3f6 = gettime();
    }
    
    if ( !isdefined( self.owner.var_c2ef9027b43cb543 ) )
    {
        self.owner.var_c2ef9027b43cb543 = 0;
    }
    
    if ( !isdefined( self.owner.accumulateddamage ) )
    {
        self.owner.accumulateddamage = 0;
    }
    
    self.owner.accumulateddamage += damage;
    
    if ( level.var_f874447e8bd4dd0c && self.owner.var_c2ef9027b43cb543 == 0 )
    {
        thread function_212419bf0f8f0eb7();
    }
    
    while ( self.owner.accumulateddamage >= 10 )
    {
        if ( !level.var_f874447e8bd4dd0c )
        {
            self.owner potg_events::prop_damaged();
        }
        
        self.owner.accumulateddamage -= 10;
        self.owner.var_c2ef9027b43cb543++;
    }
}

// Namespace prop_util
// Params 0
// Checksum 0xfc01920d, Offset: 0x182a
// Size: 0xb5
function function_212419bf0f8f0eb7()
{
    self notify( #"hash_f3636a6340d36919" );
    self endon( #"hash_f3636a6340d36919" );
    var_163ab41da72ccf9a = self.owner;
    level endon( #"game_ended" );
    level endon( #"round_end" );
    var_163ab41da72ccf9a endon( #"death_or_disconnect", #"hash_e79ffe6977c02c64" );
    var_6d57949cd5115502 = potg::getactionscenedurationmax() / 1000;
    wait var_6d57949cd5115502;
    
    if ( isalive( var_163ab41da72ccf9a ) )
    {
        for ( i = 0; i < var_163ab41da72ccf9a.var_c2ef9027b43cb543 ; i++ )
        {
            var_163ab41da72ccf9a potg_events::function_71e3534224b6a56a();
        }
    }
    
    var_163ab41da72ccf9a.var_c2ef9027b43cb543 = 0;
}

// Namespace prop_util
// Params 0
// Checksum 0x205be1a4, Offset: 0x18e7
// Size: 0x17b
function function_f61dfd9ba88dc237()
{
    level endon( #"game_ended" );
    level endon( #"round_end" );
    propteam = utility::callsharedfunc( #"gametype", #"hash_1355093053aab9db" );
    propplayers = teams::getteamdata( propteam, "players" );
    
    while ( true )
    {
        wait 10;
        
        foreach ( player in propplayers )
        {
            if ( isalive( player ) )
            {
                player thread points::doscoreevent( #"hash_a54d23ad56851c3d" );
                
                switch ( player.prop.info.propsize )
                {
                    case #"medium":
                        player thread points::doscoreevent( #"hash_292be6753317810c" );
                        break;
                    case #"large":
                        player thread points::doscoreevent( #"hash_32b8918c573863f2" );
                        break;
                    case #"xlarge":
                        player thread points::doscoreevent( #"hash_a9e26a53eda9e033" );
                        break;
                    default:
                        break;
                }
            }
        }
    }
}

// Namespace prop_util
// Params 0
// Checksum 0xf1be04e5, Offset: 0x1a6a
// Size: 0x1e2
function function_49b508ed4917d47a()
{
    level endon( #"game_ended" );
    level endon( #"round_end" );
    propteam = utility::callsharedfunc( #"gametype", #"hash_1355093053aab9db" );
    propplayers = teams::getteamdata( propteam, "players" );
    hunterteam = utility::callsharedfunc( #"gametype", #"hash_8c57259192ca7aac" );
    hunterplayers = teams::getteamdata( hunterteam, "players" );
    
    while ( true )
    {
        wait level.var_1960687e1bce8e5d ?? 10;
        
        foreach ( player in propplayers )
        {
            if ( isalive( player ) )
            {
                foreach ( hunter in hunterplayers )
                {
                    if ( isalive( hunter ) )
                    {
                        hunterdistance = distancesquared( player.origin, hunter.origin );
                        
                        if ( hunterdistance < ( level.var_9da8a37a5965c985 ?? 10000 ) )
                        {
                            player potg_events::prop_plain_sight();
                            continue;
                        }
                        
                        if ( hunterdistance < level.var_37670aa3579bc807 )
                        {
                            player potg_events::prop_plain_sight_further();
                        }
                    }
                }
            }
        }
    }
}

// Namespace prop_util
// Params 0
// Checksum 0xabe057dd, Offset: 0x1c54
// Size: 0x77
function function_1a8b6bd14e6d9188()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( isdefined( self.owner ) )
    {
        if ( level.prop_bundle.nameplatedisplayduration > 0 )
        {
            while ( true )
            {
                self waittill( #"damage" );
                self.owner thread shownameplate( level.prop_bundle.nameplatedisplayduration );
            }
        }
    }
}

// Namespace prop_util
// Params 1
// Checksum 0x709dc67a, Offset: 0x1cd3
// Size: 0x36
function shownameplate( nameplatedisplayduration )
{
    self notify( #"hash_1c8218d72d9a357e" );
    self endon( #"hash_1c8218d72d9a357e" );
    self sethidenameplate( 0 );
    wait nameplatedisplayduration;
    self sethidenameplate( 1 );
}

// Namespace prop_util
// Params 1
// Checksum 0xe14675b7, Offset: 0x1d11
// Size: 0x2f
function getprophealth( propinfo )
{
    return int( level.var_adae36019be713b6[ propinfo.propsize ].health );
}

// Namespace prop_util
// Params 1
// Checksum 0x5468520, Offset: 0x1d49
// Size: 0x2b
function function_1ec4df8434d4bfbf( propinfo )
{
    return level.var_adae36019be713b6[ propinfo.propsize ].cameraoffset;
}

// Namespace prop_util
// Params 1
// Checksum 0x51f729aa, Offset: 0x1d7d
// Size: 0x2b
function function_91a77abe66add399( propinfo )
{
    return level.var_adae36019be713b6[ propinfo.propsize ].movespeedscale;
}

// Namespace prop_util
// Params 1
// Checksum 0xf8ed6293, Offset: 0x1db1
// Size: 0x2b
function function_20e387c095c036b5( propinfo )
{
    return level.var_adae36019be713b6[ propinfo.propsize ].var_5ed5ba703fac9749;
}

// Namespace prop_util
// Params 1
// Checksum 0x4b5dd45f, Offset: 0x1de5
// Size: 0x2b
function function_8a2676f0bf94537f( propinfo )
{
    return level.var_adae36019be713b6[ propinfo.propsize ].var_e3ba811e2ff864cb;
}

// Namespace prop_util
// Params 1
// Checksum 0xb841a70a, Offset: 0x1e19
// Size: 0x29
function function_c6412bb9ac8de639( health )
{
    self.maxhealth = health;
    self.health = self.maxhealth;
}

// Namespace prop_util
// Params 0
// Checksum 0xcc0494c6, Offset: 0x1e4a
// Size: 0x84, Type: bool
function function_7bf828c229db70fb()
{
    if ( level.prop_bundle.var_d3885ce6e8188696 && utility::callsharedfunc( #"gametype", #"hash_519e79c98383c958" ) )
    {
        return true;
    }
    
    if ( level.prop_bundle.var_3f124b237144d074 && level.prop_bundle.var_3849d902b2b1d595 && ( self isswimming() || utility::ispointinwater( self.origin ) ) )
    {
        return true;
    }
    
    return false;
}

// Namespace prop_util
// Params 0
// Checksum 0xf067d561, Offset: 0x1ed7
// Size: 0x15f
function applyxyzoffset()
{
    if ( !isdefined( self.prop.xyzoffset ) )
    {
        return;
    }
    
    self.prop.angles = self.angles;
    forward = anglestoforward( self.prop.angles ) * self.prop.xyzoffset[ 0 ];
    right = anglestoright( self.prop.angles ) * self.prop.xyzoffset[ 1 ];
    up = anglestoup( self.prop.angles ) * self.prop.xyzoffset[ 2 ];
    self.prop.origin += forward;
    self.prop.origin += right;
    self.prop.origin += up;
}

// Namespace prop_util
// Params 0
// Checksum 0x1c9dcf33, Offset: 0x203e
// Size: 0x7e
function applyanglesoffset()
{
    if ( !isdefined( self.prop.anglesoffset ) )
    {
        return;
    }
    
    self.prop.angles = self.angles;
    self.prop.angles += self.prop.anglesoffset;
    self.isangleoffset = 1;
}

// Namespace prop_util
// Params 2
// Checksum 0x18ef39f5, Offset: 0x20c4
// Size: 0x51
function function_873c1489cc31954( position, propinfo )
{
    effectpos = position + ( 0, 0, 4 );
    gameplay_sound_fx::function_28103d3430792dce( effectpos, function_8a2676f0bf94537f( propinfo ) );
    playfx( function_20e387c095c036b5( propinfo ), effectpos );
}

// Namespace prop_util
// Params 0
// Checksum 0x4d9c790c, Offset: 0x211d
// Size: 0x100
function function_bea17481e1c6b223()
{
    level endon( #"game_ended" );
    level endon( #"round_end" );
    self endon( #"death_or_disconnect", #"hash_e79ffe6977c02c64" );
    
    while ( true )
    {
        var_7fe0add6f24f9540 = events::function_853f2fa3d548d7ec( self ) && !self isonladder() && !self ismantling() && !self isonascender();
        
        if ( var_7fe0add6f24f9540 )
        {
            if ( !isdefined( inairstarttime ) )
            {
                inairstarttime = gettime();
            }
        }
        else if ( inairstarttime )
        {
            if ( self isonground() )
            {
                inairendtime = gettime();
                var_d8235dcc12b188b8 = ( inairendtime - inairstarttime ) * 0.001;
                
                if ( var_d8235dcc12b188b8 > 0.7 )
                {
                    playfx( level.var_adae36019be713b6[ self.prop.info.propsize ].var_96d53faf2e3aa899, self.origin );
                }
            }
            
            inairstarttime = undefined;
        }
        
        waitframe();
    }
}

// Namespace prop_util
// Params 0
// Checksum 0x6f3d3b2b, Offset: 0x2225
// Size: 0x38
function function_12dcd008b74a0e45()
{
    if ( !isdefined( level.prop_bundle ) )
    {
        level.prop_bundle = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_prop" );
    }
    
    assert( level.prop_bundle, "<dev string:xb2>" );
}

// Namespace prop_util
// Params 1
// Checksum 0x8ad2ac02, Offset: 0x2265
// Size: 0x80
function function_36551aaaa2f6699c( trigger )
{
    self.playeranchor.origin = self.origin;
    self.playeranchor.angles = self.angles;
    self.propent.origin = self.origin;
    self.propent.angles = self.angles;
}

// Namespace prop_util
// Params 0
// Checksum 0xf67e6917, Offset: 0x22ed
// Size: 0xb9
function function_b4477812c1c3de58()
{
    propteam = utility::callsharedfunc( #"gametype", #"hash_1355093053aab9db" );
    propplayers = teams::getteamdata( propteam, "players" );
    
    foreach ( player in propplayers )
    {
        if ( isbot( player ) )
        {
            continue;
        }
        
        player thread function_8ed9deb5b7163922();
    }
}

// Namespace prop_util
// Params 0
// Checksum 0xf25f9e6, Offset: 0x23ae
// Size: 0xb2
function function_8ed9deb5b7163922()
{
    self notify( #"hash_9acb02cf45acd2d5" );
    self endon( #"hash_9acb02cf45acd2d5" );
    level endon( #"game_ended" );
    timeouttime = 10;
    level waittill( #"hide_phase_end" );
    
    do
    {
        currenttime = gettime();
        resultmsg = utility::function_f755811828e739dd( timeouttime, level, "round_end", self, "death", self, "disconnect" );
        timeelapsed = gettime() - currenttime;
        timeelapsedseconds = roundint( timeelapsed / 1000 );
        challenges::function_37e945722d6497f3( self, "prop_hunt_survive", timeelapsedseconds );
    }
    while ( resultmsg == "timeout" );
}

// Namespace prop_util
// Params 0
// Checksum 0xa2700c18, Offset: 0x2468
// Size: 0x6e
function function_6cba282b4384d304()
{
    self.var_db8eeffc013a9c37 = 1;
    
    if ( !isdefined( self.var_9a7122a34aec5460 ) )
    {
        self.var_9a7122a34aec5460 = 0;
    }
    
    self.var_9a7122a34aec5460++;
    self.var_ea8868cf0819e786 = gettime();
    self.var_bb119a65b78df3f6 = undefined;
    self.var_b65dbdc2e3036d82 = self.prop.info namespace_404586677d964be2::function_74370aae7c7fe123() ?? "";
}

// Namespace prop_util
// Params 1
// Checksum 0xa0af6ca2, Offset: 0x24de
// Size: 0x134
function function_77b56b69ceda58cb( prop_died )
{
    if ( !isdefined( self.var_db8eeffc013a9c37 ) )
    {
        return;
    }
    
    var_db0e7c158d1aaf6e = int( ( ( level.var_119ea98bc519c6f0 ?? gettime() ) - self.var_ea8868cf0819e786 ) * 0.001 );
    var_b6c7127e6f5feb18 = -1;
    
    if ( self.var_bb119a65b78df3f6 )
    {
        var_b6c7127e6f5feb18 = int( ( self.var_bb119a65b78df3f6 - self.var_ea8868cf0819e786 ) * 0.001 );
    }
    
    roundsplayed = getteamscore( "allies" ) + getteamscore( "axis" );
    self dlog_recordplayerevent( "dlog_event_prop_hunt_prop_info", [ "prop_switch_count", self.var_9a7122a34aec5460, "prop_time_elapsed", var_db0e7c158d1aaf6e, "prop_time_to_first_hit", var_b6c7127e6f5feb18, "prop_died", prop_died, "prop_model", self.var_b65dbdc2e3036d82, "hide_phase_over", istrue( level.hide_phase_over ), "rounds_played", roundsplayed ] );
    self.var_db8eeffc013a9c37 = undefined;
}

