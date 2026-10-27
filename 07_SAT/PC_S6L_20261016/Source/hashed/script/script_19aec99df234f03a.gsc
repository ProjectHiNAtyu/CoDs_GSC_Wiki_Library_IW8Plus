// script_19aec99df234f03a  (hash_19aec99df234f03a.gscc) (size: 11094 Bytes / 0x2b56 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3cd8d652 (1020843602)
// size ...... 11094 (0x2b56)
// includes .. 13  (offset: 0x2a2a)
// strings ... 10  (offset: 0x2a92)
// dev strs .. 2   (offset: 0x2b3e)
// exports ... 33  (offset: 0x1c0a)
// cseg ...... 0x15d + 0x1aad (0x1c0a)
// imports ... 74  (offset: 0x2132)
// animtree1 . 0   (offset: 0x2b56)
// animtree2 . 0   (offset: 0x2b56)
#using scripts\common\callbacks;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\common;
#using scripts\mp\hostmigration;
#using scripts\mp\playerhealth;
#using scripts\mp\weapons;

#namespace namespace_69e3a436b5d8370e;

// Namespace namespace_69e3a436b5d8370e
// Params 0, eflags: 0x1
// Checksum 0x54ed8dff, Offset: 0x17b
// Size: 0xb4
function autoexec init()
{
    if ( !isdefined( level.gametypebundle.awardtiers ) )
    {
        return;
    }
    
    callback::add( #"player_death", &onplayerkilled );
    level callback::add( #"loadout_given", &ongiveloadout );
    
    if ( !level.gametypebundle.var_1f4f2f825cbf7b44 )
    {
        callback::add( #"player_spawned", &function_56546ec688c7da7f );
    }
    
    if ( level.gametypebundle.var_cf50e7dd871bfe66 || level.gametypebundle.var_1f4f2f825cbf7b44 )
    {
        callback::add( #"player_spawned", &onplayerspawned );
    }
}

// Namespace namespace_69e3a436b5d8370e
// Params 1
// Checksum 0x47dd9586, Offset: 0x237
// Size: 0x464
function function_65899efd82f98479( awardtier )
{
    if ( !isdefined( awardtier ) )
    {
        return;
    }
    
    function_323d8c9159939a6d( function_f02c63b99c9614c9( level.gametypebundle.awardtiers, awardtier ) + 1 );
    
    foreach ( tier in awardtier.var_9bc5fa0f0aa30f45 )
    {
        switch ( tier.awardtype )
        {
            case #"movespeed":
                if ( weapons::function_1a21795a419517d7() )
                {
                    common::function_a0f5c85d465c5f0a( "awardTier_superSpeed", float( tier.award ) - 1 );
                }
                else
                {
                    weapons::addextramovespeed( "awardTier_superSpeed", float( tier.award ) - 1 );
                }
                
                weapons::updatemovespeedscale();
                break;
            case #"perk":
                if ( !isdefined( self.perks[ tier.award ] ) )
                {
                    if ( !isdefined( self.var_1da6e93b56206c6b ) )
                    {
                        self.var_1da6e93b56206c6b = [];
                    }
                    
                    self.var_1da6e93b56206c6b[ self.var_1da6e93b56206c6b.size ] = tier.award;
                    perk::giveperk( tier.award );
                }
                
                if ( !isdefined( self.var_14069be3be1a38be ) )
                {
                    self.var_14069be3be1a38be = [];
                }
                
                self.var_14069be3be1a38be[ self.var_14069be3be1a38be.size ] = tier.award;
                break;
            case #"explosionupgrade":
                self.largeexplosion = 1;
                break;
            case #"hash_9dde49d9ed7c681a":
                self.var_1204652ea34834f5 = float( tier.award );
                
                if ( !callback::exists( #"hash_2346898712859996", &function_9687aff95cd24bf8 ) )
                {
                    callback::add( #"hash_2346898712859996", &function_9687aff95cd24bf8 );
                }
                
                break;
            case #"headshotdamage":
                self.var_d222e580804b1a07 = float( tier.award );
                
                if ( !callback::exists( #"hash_2346898712859996", &function_ac413576e0cc913e ) )
                {
                    callback::add( #"hash_2346898712859996", &function_ac413576e0cc913e );
                }
                
                break;
            case #"hash_2190015c8a8134fd":
                self.var_9344a898a306ef7e = int( ( getmatchrulesdata( "commonOption", "maxHealth" ) ?? 100 ) * float( tier.award ) );
                function_3ff6d02d138102ed( self.var_9344a898a306ef7e, 0, 1 );
                break;
            case #"bonus":
            case #"streak":
                switch ( tier.award )
                {
                    case #"hash_148304198d02afc0":
                        self.harpactive = 1;
                        thread function_e794e8af7dca7970();
                        break;
                    case #"hash_5f054fa72e77b8dd":
                        enabledoublejump();
                        break;
                    case #"hash_c2c5f76f15752ab6":
                        self.var_208c55191cf6f7ab = 1;
                        break;
                    case #"hash_c6cc2bcd30793645":
                        self.point_scalar = 2;
                        break;
                    case #"hash_fa6f637d8391884":
                        self.var_97fdb3fabafcbe7b = 1;
                    default:
                        break;
                }
                
                break;
            case #"scoremultiplier":
                self.point_scalar = float( tier.award );
                break;
            case #"hash_a916ca8427ae4624":
                self.headshot_point_scalar = float( tier.award );
                break;
            case #"hash_8e03401d34e9afc3":
                assert( isdefined( self.perks[ "<dev string:x24>" ] ), "<dev string:x43>" );
                val::set( #"awardtiers", "field_upgrade_recharge_mult", float( tier.award ) );
                break;
            default:
                break;
        }
    }
    
    if ( awardtier.var_5379ee530d68241f )
    {
        thread points::doscoreevent( awardtier.var_5379ee530d68241f );
    }
}

// Namespace namespace_69e3a436b5d8370e
// Params 2
// Checksum 0x1054fed9, Offset: 0x6a3
// Size: 0x37c
function removeawardtier( awardtier, var_15e3c4703d170dba )
{
    if ( !isdefined( awardtier ) )
    {
        return;
    }
    
    if ( !var_15e3c4703d170dba )
    {
        function_323d8c9159939a6d( function_f02c63b99c9614c9( level.gametypebundle.awardtiers, awardtier ) + 1, 1 );
    }
    
    foreach ( tier in awardtier.var_9bc5fa0f0aa30f45 )
    {
        switch ( tier.awardtype )
        {
            case #"movespeed":
                if ( weapons::function_1a21795a419517d7() )
                {
                    if ( common::function_8ff835bf23198a0( "awardTier_superSpeed" ) )
                    {
                        common::function_d85a92c557ea5a52( "awardTier_superSpeed" );
                        weapons::updatemovespeedscale();
                    }
                }
                else if ( self.var_2d0e74f429afe5a0[ "awardTier_superSpeed" ] )
                {
                    weapons::removeextramovespeed( "awardTier_superSpeed" );
                    weapons::updatemovespeedscale();
                }
                
                break;
            case #"perk":
                if ( self.var_1da6e93b56206c6b && arraycontains( self.var_1da6e93b56206c6b, tier.award ) )
                {
                    perk::removeperk( tier.award );
                    self.var_1da6e93b56206c6b = arrayremove( self.var_1da6e93b56206c6b, tier.award );
                }
                
                if ( self.var_14069be3be1a38be && arraycontains( self.var_14069be3be1a38be, tier.award ) )
                {
                    self.var_14069be3be1a38be = arrayremove( self.var_14069be3be1a38be, tier.award );
                }
                
                break;
            case #"hash_8e03401d34e9afc3":
                val::reset( #"awardtiers", "field_upgrade_recharge_mult" );
                break;
            case #"explosionupgrade":
                self.largeexplosion = 0;
                break;
            case #"hash_9dde49d9ed7c681a":
                self.var_1204652ea34834f5 = undefined;
                break;
            case #"headshotdamage":
                self.var_d222e580804b1a07 = undefined;
                break;
            case #"hash_2190015c8a8134fd":
                self.var_9344a898a306ef7e = undefined;
                function_3ff6d02d138102ed( int( getmatchrulesdata( "commonOption", "maxHealth" ) ?? 100 ), 0, 1 );
                break;
            case #"bonus":
            case #"streak":
                switch ( tier.award )
                {
                    case #"hash_148304198d02afc0":
                        clearharp();
                        break;
                    case #"hash_5f054fa72e77b8dd":
                        enddoublejump();
                        break;
                    case #"hash_c2c5f76f15752ab6":
                        self.var_208c55191cf6f7ab = undefined;
                        break;
                    case #"hash_c6cc2bcd30793645":
                        self.point_scalar = undefined;
                        break;
                    case #"hash_fa6f637d8391884":
                        self.var_97fdb3fabafcbe7b = undefined;
                    default:
                        break;
                }
                
                break;
            case #"scoremultiplier":
                self.point_scalar = undefined;
                break;
            case #"hash_a916ca8427ae4624":
                self.headshot_point_scalar = undefined;
                break;
            default:
                break;
        }
    }
}

// Namespace namespace_69e3a436b5d8370e
// Params 0
// Checksum 0x4fdd45b6, Offset: 0xa27
// Size: 0xf, Type: bool
function function_8af42f15cd41334c()
{
    return self.awardtierpoints ?? 0;
}

// Namespace namespace_69e3a436b5d8370e
// Params 2
// Checksum 0x25241e71, Offset: 0xa3f
// Size: 0x84
function function_5522ec1a2a1200a5( points, var_f67d3cf06e989539 )
{
    if ( isplayer( self ) )
    {
        if ( !isdefined( self.awardtierpoints ) )
        {
            self.awardtierpoints = 0;
        }
        
        self.awardtierpoints += points;
        self.awardtierpoints = max( self.awardtierpoints, 0 );
        
        if ( !var_f67d3cf06e989539 )
        {
            if ( points > 0 )
            {
                function_8546ae6d0ed43195();
                return;
            }
            
            if ( points < 0 )
            {
                function_5a505b4c7944bceb();
            }
        }
    }
}

// Namespace namespace_69e3a436b5d8370e
// Params 2
// Checksum 0x7d7a3864, Offset: 0xacb
// Size: 0x62
function function_5f06be4b62682c68( points, var_f67d3cf06e989539 )
{
    if ( isplayer( self ) )
    {
        prevpoints = self.awardtierpoints;
        self.awardtierpoints = points;
        
        if ( !var_f67d3cf06e989539 )
        {
            if ( points > prevpoints )
            {
                function_8546ae6d0ed43195();
                return;
            }
            
            if ( points < prevpoints )
            {
                function_5a505b4c7944bceb();
            }
        }
    }
}

// Namespace namespace_69e3a436b5d8370e
// Params 0
// Checksum 0x9d303484, Offset: 0xb35
// Size: 0x170
function function_8546ae6d0ed43195()
{
    if ( !isdefined( self.awardtiercurrent ) )
    {
        self.awardtiercurrent = -1;
    }
    
    prevawardtier = self.awardtiercurrent;
    
    if ( level.gametypebundle.var_d9fd1646a89656d1 )
    {
        awardtiers = level.gametypebundle.awardtiers;
        
        for ( i = prevawardtier + 1; i < awardtiers.size ; i++ )
        {
            awardtier = awardtiers[ i ];
            
            if ( self.awardtierpoints >= awardtier.pointthreshold )
            {
                function_65899efd82f98479( awardtier );
                self.awardtiercurrent = i;
                continue;
            }
            
            break;
        }
    }
    else
    {
        newscore = int( self.awardtierpoints ) - 1;
        
        for ( i = prevawardtier + 1; i <= newscore ; i++ )
        {
            if ( i >= 0 && i < level.gametypebundle.awardtiers.size )
            {
                awardtier = level.gametypebundle.awardtiers[ i ];
                function_65899efd82f98479( awardtier );
            }
        }
        
        self.awardtiercurrent = newscore;
    }
    
    if ( prevawardtier < self.awardtiercurrent )
    {
        function_b2bd3b81e915886d( level.gametypebundle.awardtiers[ self.awardtiercurrent ] );
    }
}

// Namespace namespace_69e3a436b5d8370e
// Params 0
// Checksum 0x7e70663f, Offset: 0xcad
// Size: 0x134
function function_5a505b4c7944bceb()
{
    if ( !isdefined( self.awardtiercurrent ) )
    {
        self.awardtiercurrent = -1;
    }
    
    if ( level.gametypebundle.var_d9fd1646a89656d1 )
    {
        awardtiers = level.gametypebundle.awardtiers;
        
        for ( i = self.awardtiercurrent; i >= 0 ; i-- )
        {
            awardtier = awardtiers[ i ];
            
            if ( self.awardtierpoints < awardtier.pointthreshold )
            {
                removeawardtier( awardtier );
                self.awardtiercurrent = i - 1;
                continue;
            }
            
            break;
        }
        
        return;
    }
    
    newscore = int( self.awardtierpoints ) - 1;
    
    for ( i = self.awardtiercurrent; i > newscore ; i-- )
    {
        if ( i >= 0 && i < level.gametypebundle.awardtiers.size )
        {
            awardtier = level.gametypebundle.awardtiers[ i ];
            removeawardtier( awardtier );
        }
    }
    
    self.awardtiercurrent = newscore;
}

// Namespace namespace_69e3a436b5d8370e
// Params 0
// Checksum 0x1adedcb5, Offset: 0xde9
// Size: 0x10, Type: bool
function function_c6facc0238baaa44()
{
    return self.awardtiercurrent ?? -1;
}

// Namespace namespace_69e3a436b5d8370e
// Params 1
// Checksum 0x3607348c, Offset: 0xe02
// Size: 0x13
function function_56546ec688c7da7f( params )
{
    function_66186e21ab56457c();
}

// Namespace namespace_69e3a436b5d8370e
// Params 1
// Checksum 0x7f52d02c, Offset: 0xe1d
// Size: 0x150
function onplayerspawned( params )
{
    player = params.player;
    
    if ( level.gametypebundle.var_cf50e7dd871bfe66 && !level.gametypebundle.var_1f4f2f825cbf7b44 )
    {
        player.awardtierpoints = 0;
    }
    
    if ( level.gametypebundle.var_1f4f2f825cbf7b44 )
    {
        if ( isdefined( player.var_9344a898a306ef7e ) )
        {
            player function_72188f419f5936d7( params );
        }
        
        foreach ( perk in player.var_14069be3be1a38be )
        {
            if ( !isdefined( player.perks[ perk ] ) )
            {
                if ( !isdefined( player.var_1da6e93b56206c6b ) )
                {
                    player.var_1da6e93b56206c6b = [];
                }
                
                player.var_1da6e93b56206c6b[ player.var_1da6e93b56206c6b.size ] = perk;
                player perk::giveperk( perk );
            }
        }
    }
}

// Namespace namespace_69e3a436b5d8370e
// Params 1
// Checksum 0x53ee5742, Offset: 0xf75
// Size: 0x1ea
function onplayerkilled( params )
{
    victim = params.victim;
    attacker = params.attacker;
    victim.var_1da6e93b56206c6b = undefined;
    
    if ( attacker.var_97fdb3fabafcbe7b )
    {
        primaryequipment = attacker equipment_mp::getcurrentequipment( "primary" );
        secondaryequipment = attacker equipment_mp::getcurrentequipment( "secondary" );
        var_64475d2b78c272c3 = function_5713d46873b29625( [ primaryequipment, secondaryequipment ] );
        
        foreach ( equipment in var_64475d2b78c272c3 )
        {
            var_f0a78fa090433bda = attacker equipment_mp::getequipmentmaxammo( equipment );
            attacker equipment_mp::incrementequipmentammo( equipment, var_f0a78fa090433bda );
        }
    }
    
    if ( !level.gametypebundle.var_1f4f2f825cbf7b44 )
    {
        victim.awardtierpoints = 0;
        victim function_5a505b4c7944bceb();
        victim.var_14069be3be1a38be = undefined;
        
        if ( victim.var_9344a898a306ef7e )
        {
            function_458430b2b3789346();
        }
        
        if ( callback::exists( #"hash_2346898712859996", &function_9687aff95cd24bf8, undefined, 1 ) )
        {
            callback::remove( #"hash_2346898712859996", &function_9687aff95cd24bf8 );
        }
        
        if ( callback::exists( #"hash_2346898712859996", &function_ac413576e0cc913e, undefined, 1 ) )
        {
            callback::remove( #"hash_2346898712859996", &function_ac413576e0cc913e );
        }
    }
    
    if ( level.gametypebundle.var_cf50e7dd871bfe66 )
    {
        function_8a76ec330862ccd3( attacker, victim );
    }
}

// Namespace namespace_69e3a436b5d8370e
// Params 1, eflags: 0x4
// Checksum 0x8c1cf944, Offset: 0x1167
// Size: 0x15f
function private ongiveloadout( params )
{
    if ( self.var_1da6e93b56206c6b )
    {
        foreach ( perk in self.loadoutperks )
        {
            if ( arraycontains( self.var_1da6e93b56206c6b, perk ) )
            {
                self.var_1da6e93b56206c6b = arrayremove( self.var_1da6e93b56206c6b, perk );
            }
        }
    }
    
    foreach ( perk in self.var_14069be3be1a38be )
    {
        if ( !isdefined( self.perks[ perk ] ) )
        {
            if ( !isdefined( self.var_1da6e93b56206c6b ) )
            {
                self.var_1da6e93b56206c6b = [];
            }
            
            self.var_1da6e93b56206c6b[ self.var_1da6e93b56206c6b.size ] = perk;
            perk::giveperk( perk );
        }
    }
}

// Namespace namespace_69e3a436b5d8370e
// Params 2
// Checksum 0x1315bf0f, Offset: 0x12ce
// Size: 0x116
function function_8a76ec330862ccd3( attacker, victim )
{
    if ( player::isreallyalive( attacker ) )
    {
        attacker function_5522ec1a2a1200a5( 1 );
    }
    
    if ( isdefined( victim ) && isdefined( victim.attackers ) && !isdefined( level.assists_disabled ) && level.gamemodebundle.var_2fc669d4ccb1f63e )
    {
        foreach ( player in victim.attackers )
        {
            if ( !isdefined( damage::_validateattacker( player ) ) )
            {
                continue;
            }
            
            if ( player == attacker )
            {
                continue;
            }
            
            if ( victim == player )
            {
                continue;
            }
            
            if ( !player::isreallyalive( player ) )
            {
                continue;
            }
            
            player function_5522ec1a2a1200a5( 1 );
        }
    }
}

// Namespace namespace_69e3a436b5d8370e
// Params 0
// Checksum 0xd2a75512, Offset: 0x13ec
// Size: 0x21
function enabledoublejump()
{
    setdvar( @"hash_b9e0a0a687cd9e51", 1 );
    self allowdoublejump( 1 );
    thread monitordoublejump();
}

// Namespace namespace_69e3a436b5d8370e
// Params 0
// Checksum 0x1e5bd735, Offset: 0x1415
// Size: 0xcb
function monitordoublejump()
{
    self notify( #"hash_aed26a100812ec7b" );
    self endon( #"hash_aed26a100812ec7b" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"djump_end" );
    var_556ab02d13f6aa82 = level.gametypebundle.var_a13ed56b1453e9db;
    
    if ( !var_556ab02d13f6aa82 || !var_556ab02d13f6aa82.part || !var_556ab02d13f6aa82.state || !self getscriptablehaspart( var_556ab02d13f6aa82.part ) )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"doublejumpbegin" );
        self setscriptablepartstate( var_556ab02d13f6aa82.part, var_556ab02d13f6aa82.state, 0 );
    }
}

// Namespace namespace_69e3a436b5d8370e
// Params 0
// Checksum 0x487828a0, Offset: 0x14e8
// Size: 0x15
function enddoublejump()
{
    self notify( #"djump_end" );
    self allowdoublejump( 0 );
}

// Namespace namespace_69e3a436b5d8370e
// Params 0
// Checksum 0x7f5edd41, Offset: 0x1505
// Size: 0x5a
function function_e794e8af7dca7970()
{
    self notify( #"hash_27838d3926885278" );
    self endon( #"hash_27838d3926885278" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_6b336a8fda716b6d" );
    
    while ( true )
    {
        uav::function_2701d7fa650db090();
        level waittill( #"uav_update" );
    }
}

// Namespace namespace_69e3a436b5d8370e
// Params 1
// Checksum 0x3cf3f80, Offset: 0x1567
// Size: 0x83
function function_d7ebd1a661a4248f( waittime )
{
    self notify( #"hash_6c02cd2c865673d7" );
    self endon( #"hash_6c02cd2c865673d7" );
    level endon( #"game_ended" );
    self endon( #"stop_cranked" );
    self endon( #"death_or_disconnect" );
    
    while ( waittime > 0 )
    {
        hostmigration::waitlongdurationwithgameendtimeupdate( 1 );
        waittime--;
    }
    
    self notify( #"hash_6b336a8fda716b6d" );
    self.skipuavupdate = undefined;
    level notify( #"uav_update" );
}

// Namespace namespace_69e3a436b5d8370e
// Params 1
// Checksum 0x7ebb5247, Offset: 0x15f2
// Size: 0xe4
function function_9687aff95cd24bf8( params )
{
    attacker = params.eattacker;
    victim = params.victim;
    meansofdeath = params.smeansofdeath;
    damage = params.idamage;
    
    if ( !isdefined( attacker ) || !isdefined( victim ) || !isdefined( meansofdeath ) || !isdefined( attacker.var_1204652ea34834f5 ) )
    {
        return;
    }
    
    if ( attacker == victim || level.teambased && attacker.team == victim.team )
    {
        return;
    }
    
    if ( meansofdeath == "MOD_MELEE" )
    {
        damage *= attacker.var_1204652ea34834f5;
    }
    
    params.idamage = damage;
}

// Namespace namespace_69e3a436b5d8370e
// Params 1
// Checksum 0xde75a8ca, Offset: 0x16de
// Size: 0x107
function function_ac413576e0cc913e( params )
{
    attacker = params.eattacker;
    victim = params.victim;
    meansofdeath = params.smeansofdeath;
    damage = params.idamage;
    hitlocation = params.shitloc;
    
    if ( !isdefined( attacker ) || !isdefined( victim ) || !isdefined( meansofdeath ) || !isdefined( attacker.var_d222e580804b1a07 ) )
    {
        return;
    }
    
    if ( attacker == victim || level.teambased && attacker.team == victim.team )
    {
        return;
    }
    
    if ( meansofdeath == "MOD_HEAD_SHOT" || damage_utility::isheadshot( hitlocation, meansofdeath, attacker ) )
    {
        damage *= attacker.var_d222e580804b1a07;
    }
    
    params.idamage = damage;
}

// Namespace namespace_69e3a436b5d8370e
// Params 1
// Checksum 0x6cb0182a, Offset: 0x17ed
// Size: 0x1f
function function_72188f419f5936d7( spawndata )
{
    function_3ff6d02d138102ed( self.var_9344a898a306ef7e, 1, 0 );
}

// Namespace namespace_69e3a436b5d8370e
// Params 3
// Checksum 0xe51d1386, Offset: 0x1814
// Size: 0x64
function function_3ff6d02d138102ed( newmaxhealth, var_8d6017cd69685ec9, forceregen )
{
    if ( self.health >= newmaxhealth )
    {
        self.health = newmaxhealth;
    }
    
    self.maxhealth = newmaxhealth;
    
    if ( var_8d6017cd69685ec9 )
    {
        self.health = newmaxhealth;
        return;
    }
    
    if ( forceregen )
    {
        playerhealth::forcehealthregen( self, 0 );
    }
}

// Namespace namespace_69e3a436b5d8370e
// Params 0
// Checksum 0xa7bf0b0, Offset: 0x1880
// Size: 0x22
function function_458430b2b3789346()
{
    function_3ff6d02d138102ed( int( getmatchrulesdata( "commonOption", "maxHealth" ) ?? 100 ), 0, 0 );
}

// Namespace namespace_69e3a436b5d8370e
// Params 2, eflags: 0x4
// Checksum 0x4bb6fcd3, Offset: 0x18aa
// Size: 0x90, Type: bool
function private function_9bddf3ff7af12647( a, b )
{
    if ( !a.var_b24ae3b77ec195fa && !b.var_b24ae3b77ec195fa )
    {
        return ( a.tier < b.tier );
    }
    else if ( a.var_b24ae3b77ec195fa && b.var_b24ae3b77ec195fa )
    {
        return ( a.tier > b.tier );
    }
    
    return !a.var_b24ae3b77ec195fa;
}

// Namespace namespace_69e3a436b5d8370e
// Params 2, eflags: 0x4
// Checksum 0x71bd6174, Offset: 0x1943
// Size: 0x90, Type: bool
function private function_9668fefaa401cadd( a, b )
{
    if ( !a.var_b24ae3b77ec195fa && !b.var_b24ae3b77ec195fa )
    {
        return ( a.index < b.index );
    }
    else if ( a.var_b24ae3b77ec195fa && b.var_b24ae3b77ec195fa )
    {
        return ( a.index > b.index );
    }
    
    return !a.var_b24ae3b77ec195fa;
}

// Namespace namespace_69e3a436b5d8370e
// Params 2
// Checksum 0xe508cb04, Offset: 0x19dc
// Size: 0x9c
function function_323d8c9159939a6d( tier, var_b24ae3b77ec195fa )
{
    var_5f0c4930a4909a71 = spawnstruct();
    var_5f0c4930a4909a71.tier = tier;
    var_5f0c4930a4909a71.var_b24ae3b77ec195fa = var_b24ae3b77ec195fa ?? 0;
    var_5f0c4930a4909a71.index = self.var_eef81eac982815ac.size;
    
    if ( !isdefined( self.var_eef81eac982815ac ) )
    {
        self.var_eef81eac982815ac = [];
    }
    
    self.var_eef81eac982815ac[ self.var_eef81eac982815ac.size ] = var_5f0c4930a4909a71;
    
    if ( !self.var_3395a74e71f61c87 )
    {
        thread function_78cd11baa5e4d679();
    }
}

// Namespace namespace_69e3a436b5d8370e
// Params 0, eflags: 0xc
// Checksum 0xfb108bb9, Offset: 0x1a80
// Size: 0xd8
function private function_78cd11baa5e4d679()
{
    self notify( #"hash_7152a792a91725d0" );
    self endon( #"hash_7152a792a91725d0" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"ui_bonus_tier_reset" );
    self.var_3395a74e71f61c87 = 1;
    wait 0.5;
    function_7a8797a6f7231f23();
    
    while ( self.var_eef81eac982815ac.size > 0 )
    {
        self setclientomnvar( self.var_eef81eac982815ac[ 0 ].var_b24ae3b77ec195fa ? "ui_bonus_remove_tier" : "ui_bonus_tier", self.var_eef81eac982815ac[ 0 ].tier );
        self.var_eef81eac982815ac[ 0 ] = undefined;
        function_cdc669dbc8ea2101( self.var_eef81eac982815ac );
        wait 0.5;
        function_7a8797a6f7231f23();
    }
    
    self.var_3395a74e71f61c87 = 0;
}

// Namespace namespace_69e3a436b5d8370e
// Params 0
// Checksum 0xae09e698, Offset: 0x1b60
// Size: 0x24
function function_66186e21ab56457c()
{
    self notify( #"ui_bonus_tier_reset" );
    self.var_3395a74e71f61c87 = 0;
    self setclientomnvar( "ui_bonus_tier", 0 );
}

// Namespace namespace_69e3a436b5d8370e
// Params 0, eflags: 0x4
// Checksum 0x51b6aa4, Offset: 0x1b8c
// Size: 0x1c
function private function_7a8797a6f7231f23()
{
    self setclientomnvar( "ui_bonus_tier", -1 );
    self setclientomnvar( "ui_bonus_remove_tier", -1 );
}

// Namespace namespace_69e3a436b5d8370e
// Params 0, eflags: 0x4
// Checksum 0x2033f37a, Offset: 0x1bb0
// Size: 0x22
function private clearharp()
{
    self.harpactive = 0;
    self.skipuavupdate = undefined;
    self notify( #"hash_6b336a8fda716b6d" );
}

// Namespace namespace_69e3a436b5d8370e
// Params 1
// Checksum 0xa9f7b62f, Offset: 0x1bda
// Size: 0x30
function function_b2bd3b81e915886d( awardtier )
{
    alias = awardtier.var_8892001be2e1b678;
    
    if ( alias )
    {
        self playlocalsound( alias );
    }
}

