// scripts\mp\ftue\utility\ftue_player.gsc  (hash_35ee5e2cef30eea2.gscc) (size: 9227 Bytes / 0x240b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x56318298 (1446085272)
// size ...... 9227 (0x240b)
// includes .. 7   (offset: 0x22f7)
// strings ... 18  (offset: 0x232f)
// dev strs .. 0   (offset: 0x240b)
// exports ... 60  (offset: 0x13bf)
// cseg ...... 0x1a5 + 0x121a (0x13bf)
// imports ... 49  (offset: 0x1d1f)
// animtree1 . 0   (offset: 0x240b)
// animtree2 . 0   (offset: 0x240b)
#using scripts\common\progression_utility;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\common\utility\player;
#using scripts\mp\currency;
#using scripts\mp\flags;
#using scripts\mp\ftue\utility\ftue_tip;
#using scripts\mp\laststand;

#namespace ftue_player;

// Namespace ftue_player
// Params 2
// Checksum 0x60d45c97, Offset: 0x1c3
// Size: 0x36
function function_41490cf7c642d2dd( position, angles )
{
    assert( isdefined( position ) );
    self setorigin( position );
    
    if ( isdefined( angles ) )
    {
        self setplayerangles( angles );
    }
}

// Namespace ftue_player
// Params 0
// Checksum 0x77d9bc33, Offset: 0x201
// Size: 0x50
function function_ab3a085c454fc0d7()
{
    self endon( #"game_ended" );
    self endon( #"clip_limited" );
    
    while ( true )
    {
        equippedweapon = self getcurrentweapon();
        
        if ( self getweaponammoclip( equippedweapon ) <= 10 )
        {
            self setweaponammoclip( equippedweapon, 20 );
        }
        
        wait 0.3;
    }
}

// Namespace ftue_player
// Params 0
// Checksum 0x54052a56, Offset: 0x259
// Size: 0x59
function function_f89d8d905f739aa7()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        equippedweapon = self getcurrentweapon();
        
        if ( self getweaponammostock( equippedweapon ) <= 30 )
        {
            self setweaponammostock( equippedweapon, 60 );
        }
        
        wait 1;
    }
}

// Namespace ftue_player
// Params 2
// Checksum 0x399eb9d4, Offset: 0x2ba
// Size: 0x47, Type: bool
function function_de7cca2ef9bc611c( player, ally )
{
    return isdefined( player ) && isdefined( ally ) && isalliedsentient( player, ally ) && ( ally.jailed || ally.gulagarena );
}

// Namespace ftue_player
// Params 2
// Checksum 0xc44878f0, Offset: 0x30a
// Size: 0x3e, Type: bool
function function_c9f54f30800af8b( player, var_c5aa610834ef6deb )
{
    ascenders = getentitylessscriptablearray( undefined, undefined, player.origin, var_c5aa610834ef6deb, "ascender" );
    return ascenders.size > 0;
}

// Namespace ftue_player
// Params 1
// Checksum 0xb55a61b6, Offset: 0x351
// Size: 0x4b, Type: bool
function function_390fcdf70be5b88d( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_51c1a72a47d19461 ) );
    dist = params.var_51c1a72a47d19461;
    return function_c9f54f30800af8b( self, dist );
}

// Namespace ftue_player
// Params 2
// Checksum 0x880a71c0, Offset: 0x3a5
// Size: 0x2d
function function_b52c0e78a75611e( player, var_c5aa610834ef6deb )
{
    return getentitylessscriptablearray( undefined, undefined, player.origin, var_c5aa610834ef6deb, "ascender" );
}

// Namespace ftue_player
// Params 2
// Checksum 0xd9d52d40, Offset: 0x3db
// Size: 0xa6
function function_f70f4498bf4bcf36( player, ascenders )
{
    if ( ascenders.size > 0 )
    {
        mindistance = distancesquared( ascenders[ 0 ].origin, player.origin );
        nearestzipline = ascenders[ 0 ];
        
        for ( i = 0; i < ascenders.size ; i++ )
        {
            ziplinedistance = distancesquared( ascenders[ i ].origin, player.origin );
            
            if ( ziplinedistance < mindistance )
            {
                mindistance = ziplinedistance;
                nearestzipline = ascenders[ i ];
            }
        }
        
        return nearestzipline;
    }
}

// Namespace ftue_player
// Params 1
// Checksum 0x14ff6082, Offset: 0x48a
// Size: 0x17
function ftue_player_usezipline( player )
{
    return player.usingascender;
}

// Namespace ftue_player
// Params 0
// Checksum 0x46c6c1ff, Offset: 0x4aa
// Size: 0x1f
function function_22dc863a42b13911()
{
    usezipline = ftue_player_usezipline( self );
    
    if ( isdefined( usezipline ) )
    {
        return usezipline;
    }
    
    return 0;
}

// Namespace ftue_player
// Params 1
// Checksum 0x451f4251, Offset: 0x4d2
// Size: 0x61
function function_db1b212d7b59aeef( positivecallback )
{
    self endon( #"disconnect" );
    assert( isdefined( self ) );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message, value );
        
        if ( message == "ftue_minimap_opened" )
        {
            self [[ positivecallback ]]();
            break;
        }
    }
}

// Namespace ftue_player
// Params 1
// Checksum 0x47ac0695, Offset: 0x53b
// Size: 0x21
function function_fd9740795f948c11( player )
{
    player.var_a25c6ed2c7bf87d6 = 1;
    ftue_tip::function_953a5a3682bc5957();
}

// Namespace ftue_player
// Params 1
// Checksum 0x2e788e57, Offset: 0x564
// Size: 0x15
function function_bcc3cc5dff85283a( positivecallback )
{
    function_1a93783a8512e617( positivecallback );
}

// Namespace ftue_player
// Params 1
// Checksum 0xd2506349, Offset: 0x581
// Size: 0x61
function function_1a93783a8512e617( positivecallback )
{
    self endon( #"disconnect" );
    assert( isdefined( self ) );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message, value );
        
        if ( message == "ftue_minimap_closed" )
        {
            self [[ positivecallback ]]();
            break;
        }
    }
}

// Namespace ftue_player
// Params 1
// Checksum 0xac05d031, Offset: 0x5ea
// Size: 0x22
function function_629037216392e87c( tipref )
{
    if ( tipref == "gasMiniMapCloseTip" )
    {
        self.var_4f2ce020a467a069 = 1;
    }
}

// Namespace ftue_player
// Params 1
// Checksum 0x1c927261, Offset: 0x614
// Size: 0x61
function function_ae0296f83b974598( positivecallback )
{
    self endon( #"disconnect" );
    assert( isdefined( self ) );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message, value );
        
        if ( message == "scoreboard_open" )
        {
            self [[ positivecallback ]]();
            break;
        }
    }
}

// Namespace ftue_player
// Params 1
// Checksum 0xfb2dc4ba, Offset: 0x67d
// Size: 0x61
function function_257c9575891b6d7d( positivecallback )
{
    self endon( #"disconnect" );
    assert( isdefined( self ) );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message, value );
        
        if ( message == "scoreboard_close" )
        {
            self [[ positivecallback ]]();
            break;
        }
    }
}

// Namespace ftue_player
// Params 0
// Checksum 0xe55caa96, Offset: 0x6e6
// Size: 0x20, Type: bool
function function_53c3ebdfa4a34ea4()
{
    return self.br_infil_type == "c130" && flags::gameflag( "br_ready_to_jump" );
}

// Namespace ftue_player
// Params 1
// Checksum 0xe098ca5e, Offset: 0x70f
// Size: 0x3d, Type: bool
function function_9fa2f60745776946( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_1def1d09a4bf1eb1 ) );
    return function_53c3ebdfa4a34ea4() == params.var_1def1d09a4bf1eb1;
}

// Namespace ftue_player
// Params 0
// Checksum 0xb26693c3, Offset: 0x755
// Size: 0x16
function function_bb514ddb0ca45380()
{
    if ( !self.var_600f77e1f23e65d5 )
    {
        function_56be93c4c25490f();
    }
}

// Namespace ftue_player
// Params 0
// Checksum 0xaace5097, Offset: 0x773
// Size: 0x29
function function_56be93c4c25490f()
{
    self endon( #"disconnect" );
    assert( isdefined( self ) );
    
    while ( !self.var_600f77e1f23e65d5 )
    {
        waitframe();
    }
}

// Namespace ftue_player
// Params 1
// Checksum 0x9635b6cb, Offset: 0x7a5
// Size: 0x17
function function_eec6c7a1a3afa365( tipref )
{
    self.var_600f77e1f23e65d5 = 1;
}

// Namespace ftue_player
// Params 0
// Checksum 0x8ebd43ea, Offset: 0x7c4
// Size: 0x33
function function_a0f4359c3f80d594()
{
    self endon( #"disconnect" );
    self endon( #"currentContextualTipCompleted" );
    self endon( #"currentContextualTipAborted" );
    
    while ( !self isparachutedeployed() )
    {
        waitframe();
    }
}

// Namespace ftue_player
// Params 0
// Checksum 0xfc5ff762, Offset: 0x800
// Size: 0x11
function function_6ff60c449cf17224()
{
    return br_circle_util::function_3199bf5530fd0bc2( self.origin );
}

// Namespace ftue_player
// Params 0
// Checksum 0xa74cdaef, Offset: 0x81a
// Size: 0x11
function function_3d0a8e295d333a2e()
{
    return br_circle_util::ispointindangercircle( self.origin );
}

// Namespace ftue_player
// Params 0
// Checksum 0x1c710481, Offset: 0x834
// Size: 0x1f
function function_b940805bdd38cde7()
{
    var_43a4c89bed1f5e53 = function_6ff60c449cf17224();
    
    if ( !isdefined( var_43a4c89bed1f5e53 ) )
    {
        return 0;
    }
    
    return var_43a4c89bed1f5e53;
}

// Namespace ftue_player
// Params 1
// Checksum 0x7bad95f6, Offset: 0x85c
// Size: 0x44
function function_ffe170a3c300b2a1( params )
{
    returnvalue = function_3d0a8e295d333a2e();
    
    if ( isdefined( params ) && isdefined( params.expectedvalue ) )
    {
        return ( returnvalue == params.expectedvalue );
    }
    
    return returnvalue;
}

// Namespace ftue_player
// Params 2
// Checksum 0xbc21cd96, Offset: 0x8a9
// Size: 0x37, Type: bool
function function_18271dbd0d9792bd( minheight, maxheight )
{
    return self.origin[ 2 ] < minheight || self.origin[ 2 ] > maxheight;
}

// Namespace ftue_player
// Params 1
// Checksum 0x795af105, Offset: 0x8e9
// Size: 0x9c, Type: bool
function function_5bc28111ecf756e2( params )
{
    assert( isdefined( params ) );
    assert( isdefined( params.var_36503055e0de9238 ) );
    assert( isdefined( params.minheight ) );
    assert( isdefined( params.maxheight ) );
    
    if ( function_18271dbd0d9792bd( params.minheight, params.maxheight ) )
    {
        return false;
    }
    
    var_36503055e0de9238 = function_d535c191247aa7b8();
    
    if ( isdefined( var_36503055e0de9238 ) )
    {
        return ( var_36503055e0de9238 < params.var_36503055e0de9238 );
    }
    
    return false;
}

// Namespace ftue_player
// Params 2
// Checksum 0x4f7baab2, Offset: 0x98e
// Size: 0x3b, Type: bool
function function_c33975ba2301e813( maxdistance, mindistance )
{
    var_36503055e0de9238 = function_d535c191247aa7b8();
    
    if ( isdefined( var_36503055e0de9238 ) )
    {
        return ( var_36503055e0de9238 < maxdistance && var_36503055e0de9238 > mindistance );
    }
    
    return false;
}

// Namespace ftue_player
// Params 0
// Checksum 0xe3a7c3e7, Offset: 0x9d2
// Size: 0x90
function function_d535c191247aa7b8()
{
    dangercircleent = level.br_circle.dangercircleent;
    
    if ( isdefined( dangercircleent ) )
    {
        dangercircleorigin = ( dangercircleent.origin[ 0 ], dangercircleent.origin[ 1 ], 0 );
        dangercircleradius = dangercircleent.origin[ 2 ];
        
        if ( isdefined( dangercircleorigin ) && isdefined( dangercircleradius ) )
        {
            var_f0b8321b80008a3a = distance2d( self.origin, dangercircleorigin );
            return ( dangercircleradius - var_f0b8321b80008a3a );
        }
    }
}

// Namespace ftue_player
// Params 1
// Checksum 0x7f521755, Offset: 0xa6b
// Size: 0x37
function function_27d751a752a41086( callback )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"last_stand_enter" );
    self [[ callback ]]();
}

// Namespace ftue_player
// Params 1
// Checksum 0xfb4468f4, Offset: 0xaaa
// Size: 0xce
function function_124f4e33959ab7e( callback )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    downed = undefined;
    
    while ( !isdefined( downed ) )
    {
        foreach ( player in level.players )
        {
            if ( isalliedsentient( self, player ) && !player::isreallyalive( player ) )
            {
                downed = player;
                break;
            }
        }
        
        waitframe();
    }
    
    [[ callback ]]( downed );
}

// Namespace ftue_player
// Params 2
// Checksum 0xe815a433, Offset: 0xb80
// Size: 0x1f
function function_ce94da81b25685d7( var_54d6a86de9b2622f, initcallback )
{
    thread function_d1a9546cc3bf20a2( var_54d6a86de9b2622f, initcallback );
}

// Namespace ftue_player
// Params 2
// Checksum 0xd7daa56c, Offset: 0xba7
// Size: 0x79
function function_d1a9546cc3bf20a2( var_54d6a86de9b2622f, initcallback )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"currentContextualTipCompleted" );
    self endon( #"currentContextualTipAborted" );
    assert( isdefined( self ) );
    assert( isdefined( var_54d6a86de9b2622f ) );
    
    if ( isdefined( initcallback ) )
    {
        self [[ initcallback ]]();
    }
    
    while ( !self isskydiving() )
    {
        waitframe();
    }
    
    self [[ var_54d6a86de9b2622f ]]();
}

// Namespace ftue_player
// Params 4
// Checksum 0xfa1e93c0, Offset: 0xc29
// Size: 0x34
function function_4193f4eb7e2f082d( var_41705ea146ebcc5, anglediffgoal, var_54d6a86de9b2622f, initcallback )
{
    thread function_dba6d772f7be1e34( var_41705ea146ebcc5, anglediffgoal, var_54d6a86de9b2622f, initcallback );
}

// Namespace ftue_player
// Params 4
// Checksum 0x2f3a542e, Offset: 0xc65
// Size: 0x10f
function function_dba6d772f7be1e34( var_41705ea146ebcc5, anglediffgoal, var_54d6a86de9b2622f, initcallback )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    assert( isdefined( self ) );
    assert( isdefined( var_54d6a86de9b2622f ) );
    var_dc869ab4ef34d9fb = 0;
    init_pos = self.origin;
    init_angles = self getplayerangles();
    
    while ( !self isparachutedeployed() )
    {
        waitframe();
    }
    
    if ( isdefined( initcallback ) )
    {
        self [[ initcallback ]]();
    }
    
    while ( self isparachuting() )
    {
        diff_pos = distance( ( self.origin[ 0 ], self.origin[ 1 ], 0 ), ( init_pos[ 0 ], init_pos[ 1 ], 0 ) );
        diff_angles = distance( self getplayerangles(), init_angles );
        
        if ( diff_angles >= anglediffgoal && diff_pos * 10 > var_41705ea146ebcc5 )
        {
            var_dc869ab4ef34d9fb = 1;
            break;
        }
        
        waitframe();
    }
    
    self [[ var_54d6a86de9b2622f ]]( var_dc869ab4ef34d9fb );
}

// Namespace ftue_player
// Params 0
// Checksum 0xf3ee643b, Offset: 0xd7d
// Size: 0x9
function function_85cabc92e34e7974()
{
    function_e731c61bdbd45c77();
}

// Namespace ftue_player
// Params 0
// Checksum 0x8d274b97, Offset: 0xd8e
// Size: 0x30
function function_e731c61bdbd45c77()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    assert( isdefined( self ) );
    
    while ( self isparachutedeployed() )
    {
        waitframe();
    }
}

// Namespace ftue_player
// Params 2
// Checksum 0x96c3721, Offset: 0xdc7
// Size: 0xc9
function ftue_player_isplayershotbyenemy( var_89fb940077308f96, initcallback )
{
    self endon( #"entitydeleted" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon );
        
        if ( attacker != self && isdefined( var_89fb940077308f96 ) )
        {
            self [[ var_89fb940077308f96 ]]();
            return;
        }
    }
}

// Namespace ftue_player
// Params 0
// Checksum 0x66bf8cbe, Offset: 0xe98
// Size: 0x2f
function ftue_player_getrank()
{
    xp = self getplayerdata( "common", "mpProgression", "playerLevel", "xp" );
    return progression_utility::getrankforxp( xp );
}

// Namespace ftue_player
// Params 0
// Checksum 0xc8a40d40, Offset: 0xed0
// Size: 0xe, Type: bool
function function_10e127ef0cc3ed41()
{
    if ( self isspectatinganyone() )
    {
        return true;
    }
    
    return false;
}

// Namespace ftue_player
// Params 1
// Checksum 0xa5ce4f24, Offset: 0xee7
// Size: 0x15
function function_3567def35fa5e0e9( positivecallback )
{
    thread function_cb26b5dc047785b4( positivecallback );
}

// Namespace ftue_player
// Params 1
// Checksum 0xdf7c9a6, Offset: 0xf04
// Size: 0x61
function function_cb26b5dc047785b4( positivecallback )
{
    self endon( #"disconnect" );
    assert( isdefined( self ) );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", message, value );
        
        if ( message == "ftue_redeploy_button_clicked" )
        {
            self [[ positivecallback ]]();
            break;
        }
    }
}

// Namespace ftue_player
// Params 1
// Checksum 0xd02196e, Offset: 0xf6d
// Size: 0x15
function function_67b4204431562d76( callback )
{
    function_d9d7a8cda240edf( callback );
}

// Namespace ftue_player
// Params 1
// Checksum 0x37dded35, Offset: 0xf8a
// Size: 0x61
function function_d9d7a8cda240edf( callback )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"luinotifyserver", channel, class );
        
        if ( channel == "ftue_show_revive_ally_button" )
        {
            self [[ callback ]]();
            return;
        }
    }
}

// Namespace ftue_player
// Params 2
// Checksum 0x43906d70, Offset: 0xff3
// Size: 0x1f
function function_364f4b1bdc00e78b( teammate, callback )
{
    function_9e89d14c45363d44( teammate, callback );
}

// Namespace ftue_player
// Params 2
// Checksum 0x56440faa, Offset: 0x101a
// Size: 0x9a
function function_9e89d14c45363d44( teammate, callback )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    
    while ( !isdefined( teammate.inlaststand ) )
    {
        waitframe();
    }
    
    originalstate = teammate.inlaststand;
    
    while ( true )
    {
        if ( !player::isreallyalive( teammate ) )
        {
            self [[ callback ]]( 0 );
            return;
        }
        
        currentvalue = teammate.inlaststand;
        
        if ( originalstate != currentvalue )
        {
            self [[ callback ]]( 1 );
            return;
        }
        
        waitframe();
    }
}

// Namespace ftue_player
// Params 1
// Checksum 0x8b7aa3a6, Offset: 0x10bc
// Size: 0x15
function function_b490bb99b9b11285( positivecallback )
{
    thread function_78ca71f644680434( positivecallback );
}

// Namespace ftue_player
// Params 1
// Checksum 0x5b2dfc6d, Offset: 0x10d9
// Size: 0x6b
function function_78ca71f644680434( positivecallback )
{
    assert( isdefined( self ) );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"hash_4c899cfd503a471b", message, value, optionalvalue );
        
        if ( message == "calloutmarkerping_added" )
        {
            self [[ positivecallback ]]();
            break;
        }
    }
}

// Namespace ftue_player
// Params 0
// Checksum 0x2ba7ce51, Offset: 0x114c
// Size: 0xd, Type: bool
function function_45230091db47a07()
{
    return self.health > 0;
}

// Namespace ftue_player
// Params 0
// Checksum 0x342c6d28, Offset: 0x1162
// Size: 0x9, Type: bool
function function_7995e388b318188c()
{
    return !function_45230091db47a07();
}

// Namespace ftue_player
// Params 1
// Checksum 0xaa483a2a, Offset: 0x1174
// Size: 0x2c
function function_d8744c35fcd8a01a( value )
{
    if ( value )
    {
        level.modifyplayerdamage = &function_eb84e87d10094e0e;
        return;
    }
    
    level.modifyplayerdamage = undefined;
}

// Namespace ftue_player
// Params 0
// Checksum 0xc4728e06, Offset: 0x11a8
// Size: 0x7
function ftue_player_onground()
{
    return self isonground();
}

// Namespace ftue_player
// Params 0
// Checksum 0xd9fbe954, Offset: 0x11b8
// Size: 0x8, Type: bool
function function_dab19a0da9ee57ba()
{
    return laststand::hasselfrevivetoken();
}

// Namespace ftue_player
// Params 11
// Checksum 0x5cfb9a03, Offset: 0x11c9
// Size: 0x108
function function_eb84e87d10094e0e( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 )
{
    if ( !isbot( victim ) || victim.team == level.player.team )
    {
        idamage *= victim.health / 200;
        
        if ( victim.health - idamage <= 0 )
        {
            idamage = 0;
        }
    }
    else if ( isbot( einflictor ) && einflictor.team == level.player.team && smeansofdeath != "MOD_EXECUTION" && smeansofdeath != "MOD_MELEE_TAKEDOWN" )
    {
        idamage = 0;
    }
    
    return idamage;
}

// Namespace ftue_player
// Params 0
// Checksum 0x8cb4e8f7, Offset: 0x12da
// Size: 0x1b
function function_f5ba1ec4aa40289a()
{
    self endon( #"disconnect" );
    
    while ( !self ismantling() )
    {
        waitframe();
    }
}

// Namespace ftue_player
// Params 0
// Checksum 0xe0f53ec1, Offset: 0x12fd
// Size: 0xf, Type: bool
function function_def393581f7b1f15()
{
    return currency::get_currency_amount( "cash" ) > 0;
}

// Namespace ftue_player
// Params 0
// Checksum 0x7262cbd4, Offset: 0x1315
// Size: 0xa9, Type: bool
function function_9d071da696dadadd()
{
    var_79c7a029988a3f16 = !level.usegulag || level.gulag.shutdown;
    var_70c1f4b75530023f = self.var_70c1f4b75530023f;
    return !var_79c7a029988a3f16 && ( var_70c1f4b75530023f || level.gulag.maxuses && self.gulaguses && ( level.gulag.maxuses <= 0 || self.gulaguses < level.gulag.maxuses ) );
}

