// scripts\mp\zm\ztron\ztron_health_bar.gsc  (hash_0fb7329659c768f6.gscc) (size: 10192 Bytes / 0x27d0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3b1d8095 (991789205)
// size ...... 10192 (0x27d0)
// includes .. 2   (offset: 0x25f0)
// strings ... 9   (offset: 0x2600)
// dev strs .. 15  (offset: 0x2714)
// exports ... 18  (offset: 0x1dd4)
// cseg ...... 0x142 + 0x1c92 (0x1dd4)
// imports ... 35  (offset: 0x20a4)
// animtree1 . 0   (offset: 0x27d0)
// animtree2 . 0   (offset: 0x27d0)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;

#namespace ztron_health_bar;

// Namespace ztron_health_bar
// Params 0
// Checksum 0xddb0f38d, Offset: 0x160
// Size: 0x3c
function init()
{
    level.var_16b97e459c9b33b2 = createentitytypemask( [ "etype_ai", "etype_scriptmover" ] );
    level callback::add( "killed_body_cloned", &on_killed_body_cloned );
    level thread function_13778446559ef08f();
}

// Namespace ztron_health_bar
// Params 0
// Checksum 0xe1a715be, Offset: 0x1a4
// Size: 0x246
function function_e3d2dc1ba03e14e3()
{
    self.ztron.healthbararray = [];
    self.ztron.playerhealthbar = undefined;
    
    /#
        if ( !isbot( self ) && getdvarint( @"hash_f1b6a73da4c16959", 0 ) )
        {
            logstring( "<dev string:x24>" + self.name );
        }
    #/
    
    self.ztron.var_4546033d5cbbc00b = {};
    self.ztron.var_4546033d5cbbc00b.var_87b3453045339a3c = [];
    self.ztron.var_4546033d5cbbc00b.var_a8836183392e24d4 = [];
    self.ztron.var_4546033d5cbbc00b.typearray = [];
    self.ztron.var_4546033d5cbbc00b.statearray = [];
    self.ztron.var_4546033d5cbbc00b.percentarray = [];
    
    for ( i = 0; i < 40 ; i++ )
    {
        healthbarinfo = spawnstruct();
        healthbarinfo.index = i + 1;
        healthbarinfo.inuse = 0;
        healthbarinfo.targetentity = undefined;
        healthbarinfo.percentvalue = 0;
        healthbarinfo.state = 0;
        healthbarinfo.var_dd450b05ffe139f7 = -1;
        healthbarinfo.type = 0;
        function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_entity_num_", -1 );
        function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_percent_", 0 );
        function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_state_", 0 );
        function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_corpse_entity_num_", -1 );
        function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_type_", 0 );
        self.ztron.healthbararray[ self.ztron.healthbararray.size ] = healthbarinfo;
    }
    
    thread function_839ccc6864f6de35();
    thread function_20005c77e96e4bae();
}

// Namespace ztron_health_bar
// Params 1
// Checksum 0x3d9426d5, Offset: 0x3f2
// Size: 0x16d
function on_killed_body_cloned( params )
{
    foreach ( player in level.players )
    {
        foreach ( healthbarinfo in player.ztron.healthbararray )
        {
            if ( healthbarinfo.targetentity == self )
            {
                corpse = zombie_utils::function_4e99fb1239980783( params );
                
                if ( isdefined( corpse ) )
                {
                    var_dd450b05ffe139f7 = corpse getentitynumber();
                    player function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_corpse_entity_num_", var_dd450b05ffe139f7 );
                    healthbarinfo.var_dd450b05ffe139f7 = var_dd450b05ffe139f7;
                }
                
                player thread function_de22954f6b8e1914( healthbarinfo.index, healthbarinfo );
            }
        }
    }
}

// Namespace ztron_health_bar
// Params 1
// Checksum 0xc81f5857, Offset: 0x567
// Size: 0x15b
function function_9388be3599d2c7a9( corpse )
{
    foreach ( player in level.players )
    {
        foreach ( healthbarinfo in player.ztron.healthbararray )
        {
            if ( healthbarinfo.targetentity == self )
            {
                if ( isdefined( corpse ) )
                {
                    var_dd450b05ffe139f7 = corpse getentitynumber();
                    player function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_corpse_entity_num_", var_dd450b05ffe139f7 );
                    healthbarinfo.var_dd450b05ffe139f7 = var_dd450b05ffe139f7;
                }
                
                player thread function_de22954f6b8e1914( healthbarinfo.index, healthbarinfo );
            }
        }
    }
}

// Namespace ztron_health_bar
// Params 0
// Checksum 0x3f8ca530, Offset: 0x6ca
// Size: 0x796
function function_20005c77e96e4bae()
{
    self endon( #"disconnect" );
    level endon( #"ztron_game_is_over" );
    
    while ( true )
    {
        if ( self.sessionstate != "playing" )
        {
            waitframe();
            continue;
        }
        
        var_34b6c0a10624c4a5 = 0;
        
        foreach ( healthbarinfo in self.ztron.healthbararray )
        {
            if ( healthbarinfo.inuse )
            {
                prevalue = healthbarinfo.percentvalue;
                
                if ( isdefined( healthbarinfo.targetentity ) && !isplayer( healthbarinfo.targetentity ) )
                {
                    distance = distance( self.origin, healthbarinfo.targetentity.origin );
                    
                    if ( distance > 1000 || healthbarinfo.targetentity.forceclearhealthbar )
                    {
                        thread function_de22954f6b8e1914( healthbarinfo.index, healthbarinfo );
                    }
                    else
                    {
                        if ( isdefined( healthbarinfo.targetentity.using_fake_health ) )
                        {
                            healthbarinfo.percentvalue = int( healthbarinfo.targetentity.var_cce7c67ea2da8902 / healthbarinfo.targetentity.var_d165d33ad4f00e17 * 10000 );
                        }
                        else if ( healthbarinfo.targetentity.health == 0 )
                        {
                            healthbarinfo.percentvalue = 0;
                        }
                        else
                        {
                            healthbarinfo.percentvalue = int( healthbarinfo.targetentity.health / healthbarinfo.targetentity.maxhealth * 10000 );
                        }
                        
                        if ( healthbarinfo.percentvalue == 0 )
                        {
                            thread function_de22954f6b8e1914( healthbarinfo.index, healthbarinfo );
                        }
                        
                        healthbarinfo.percentvalue = int( max( healthbarinfo.percentvalue, 0 ) );
                        
                        if ( prevalue != healthbarinfo.percentvalue )
                        {
                            function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_percent_", healthbarinfo.percentvalue );
                        }
                    }
                }
                else if ( isplayer( healthbarinfo.targetentity ) )
                {
                    if ( isdefined( healthbarinfo.targetentity.using_fake_health ) )
                    {
                        healthbarinfo.percentvalue = int( healthbarinfo.targetentity.var_cce7c67ea2da8902 / healthbarinfo.targetentity.var_d165d33ad4f00e17 * 10000 );
                    }
                    else if ( healthbarinfo.targetentity.health == 0 )
                    {
                        healthbarinfo.percentvalue = 0;
                    }
                    else
                    {
                        healthbarinfo.percentvalue = int( healthbarinfo.targetentity.health / healthbarinfo.targetentity.maxhealth * 10000 );
                    }
                    
                    healthbarinfo.percentvalue = int( max( healthbarinfo.percentvalue, 0 ) );
                    
                    if ( prevalue != healthbarinfo.percentvalue )
                    {
                        function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_percent_", healthbarinfo.percentvalue );
                    }
                    
                    if ( healthbarinfo.targetentity == self )
                    {
                        if ( healthbarinfo.targetentity.inlaststand )
                        {
                            if ( !healthbarinfo.targetentity.var_b0293dea30f2b97e )
                            {
                                healthbarinfo.targetentity.var_b0293dea30f2b97e = healthbarinfo.targetentity.inlaststand;
                                function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_state_", 3 );
                                healthbarinfo.state = 3;
                            }
                        }
                        else
                        {
                            if ( healthbarinfo.targetentity.var_b0293dea30f2b97e )
                            {
                                healthbarinfo.targetentity.var_b0293dea30f2b97e = undefined;
                                function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_state_", 2 );
                                healthbarinfo.state = 2;
                            }
                            
                            if ( healthbarinfo.targetentity.ztron.vehicle )
                            {
                                if ( !healthbarinfo.targetentity.var_c39a28d0f54f8132 )
                                {
                                    healthbarinfo.targetentity.var_c39a28d0f54f8132 = 1;
                                    function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_state_", 0 );
                                    healthbarinfo.state = 0;
                                }
                            }
                            else if ( healthbarinfo.targetentity.var_c39a28d0f54f8132 )
                            {
                                healthbarinfo.targetentity.var_c39a28d0f54f8132 = undefined;
                                function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_state_", 2 );
                                healthbarinfo.state = 2;
                            }
                        }
                    }
                    else if ( !healthbarinfo.targetentity.inlaststand )
                    {
                        thread function_de22954f6b8e1914( healthbarinfo.index, healthbarinfo, 1 );
                    }
                }
                else
                {
                    thread function_de22954f6b8e1914( healthbarinfo.index, healthbarinfo, 1 );
                }
                
                continue;
            }
            
            var_34b6c0a10624c4a5 = 1;
        }
        
        waitframe();
        
        if ( var_34b6c0a10624c4a5 )
        {
            foreach ( player in level.players )
            {
                if ( player == self )
                {
                    continue;
                }
                
                if ( player.inlaststand )
                {
                    alreadyshow = function_4c96228ea5774dd2( player );
                    
                    if ( alreadyshow )
                    {
                        continue;
                    }
                    
                    healthbarinfo = function_5ef67c8ef04d1dc();
                    
                    if ( !isdefined( healthbarinfo ) )
                    {
                        break;
                    }
                    
                    function_aa973380aea575e0( healthbarinfo, player, 3 );
                }
            }
            
            var_7fdb3d6b269c1829 = getentitiesinradiusfrompartitiongrid( self.origin, 1000, level.var_16b97e459c9b33b2, [ self ] );
            
            foreach ( ent in var_7fdb3d6b269c1829 )
            {
                if ( !ent.var_63c94fe1b2260b34 )
                {
                    continue;
                }
                
                alreadyshow = function_4c96228ea5774dd2( ent );
                
                if ( alreadyshow )
                {
                    continue;
                }
                
                healthbarinfo = function_5ef67c8ef04d1dc();
                
                if ( !isdefined( healthbarinfo ) )
                {
                    break;
                }
                
                healthbarstate = 1;
                
                if ( ent.var_36dfdbd7ab796f0f )
                {
                    healthbarstate = ent.var_36dfdbd7ab796f0f;
                }
                
                function_aa973380aea575e0( healthbarinfo, ent, healthbarstate );
            }
        }
    }
}

// Namespace ztron_health_bar
// Params 0
// Checksum 0x3e9618b4, Offset: 0xe68
// Size: 0x175
function function_839ccc6864f6de35()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self.ztron.var_4546033d5cbbc00b.var_87b3453045339a3c = function_a2d84ae974b76edc( self.ztron.var_4546033d5cbbc00b.var_87b3453045339a3c, "ui_ztron_health_bar_entity_num_" );
        self.ztron.var_4546033d5cbbc00b.var_a8836183392e24d4 = function_a2d84ae974b76edc( self.ztron.var_4546033d5cbbc00b.var_a8836183392e24d4, "ui_ztron_health_bar_corpse_entity_num_" );
        self.ztron.var_4546033d5cbbc00b.typearray = function_a2d84ae974b76edc( self.ztron.var_4546033d5cbbc00b.typearray, "ui_ztron_health_bar_type_" );
        self.ztron.var_4546033d5cbbc00b.statearray = function_a2d84ae974b76edc( self.ztron.var_4546033d5cbbc00b.statearray, "ui_ztron_health_bar_state_" );
        self.ztron.var_4546033d5cbbc00b.percentarray = function_a2d84ae974b76edc( self.ztron.var_4546033d5cbbc00b.percentarray, "ui_ztron_health_bar_percent_" );
        waitframe();
    }
}

// Namespace ztron_health_bar
// Params 2
// Checksum 0x5e8a8ddb, Offset: 0xfe5
// Size: 0x177
function function_a2d84ae974b76edc( array, omnvarname )
{
    if ( !self isconnected() )
    {
        return array;
    }
    
    syncedarray = [];
    
    for ( i = 0; i < 5 ; i++ )
    {
        if ( i >= array.size )
        {
            break;
        }
        
        _info = array[ i ];
        var_8f03b58983fedc00 = i + 1;
        var_7a817348b08335f = omnvarname + var_8f03b58983fedc00;
        var_da2d39ec3e03f885 = self getclientomnvar( var_7a817348b08335f );
        var_444830535c8fa86b = int( mod( mod( var_da2d39ec3e03f885, 10 ) + 1, 10 ) );
        var_444830535c8fa86b = ( var_444830535c8fa86b + 10 ) % 10;
        var_97ce77173c9068ab = _info.value * 1000 + _info.index * 10 + var_444830535c8fa86b;
        
        /#
            if ( !isbot( self ) && getdvarint( @"hash_f1b6a73da4c16959", 0 ) )
            {
                logstring( "<dev string:x58>" + self.name + "<dev string:x87>" + var_7a817348b08335f + "<dev string:x95>" + var_97ce77173c9068ab + "<dev string:xa4>" + _info.value + "<dev string:xb2>" + _info.index + "<dev string:xc0>" + var_444830535c8fa86b + "<dev string:xd5>" + var_da2d39ec3e03f885 );
            }
        #/
        
        self setclientomnvar( var_7a817348b08335f, var_97ce77173c9068ab );
        syncedarray[ syncedarray.size ] = _info;
    }
    
    array = arrayremove( array, syncedarray );
    return array;
}

// Namespace ztron_health_bar
// Params 0
// Checksum 0xc61a6cbb, Offset: 0x1165
// Size: 0x138
function function_381204d14efffd6f()
{
    foreach ( healthbarinfo in self.ztron.healthbararray )
    {
        if ( healthbarinfo.inuse )
        {
            function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_entity_num_", healthbarinfo.targetentity getentitynumber() );
            function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_percent_", healthbarinfo.percentvalue );
            function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_state_", healthbarinfo.state );
            function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_corpse_entity_num_", healthbarinfo.var_dd450b05ffe139f7 );
            function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_type_", healthbarinfo.type );
        }
    }
}

// Namespace ztron_health_bar
// Params 1
// Checksum 0xa05f948a, Offset: 0x12a5
// Size: 0xba
function function_4c96228ea5774dd2( targetent )
{
    alreadyshow = 0;
    
    foreach ( healthbarinfo in self.ztron.healthbararray )
    {
        if ( healthbarinfo.inuse && healthbarinfo.targetentity == targetent )
        {
            alreadyshow = 1;
            break;
        }
    }
    
    return alreadyshow;
}

// Namespace ztron_health_bar
// Params 0
// Checksum 0xb0f08df7, Offset: 0x1368
// Size: 0x8f
function function_5ef67c8ef04d1dc()
{
    foreach ( healthbarinfo in self.ztron.healthbararray )
    {
        if ( healthbarinfo.inuse == 0 )
        {
            return healthbarinfo;
        }
    }
}

// Namespace ztron_health_bar
// Params 3
// Checksum 0xf1f6844, Offset: 0x1400
// Size: 0x17d
function function_de22954f6b8e1914( index, healthbarinfo, immediately = 0 )
{
    self endon( #"disconnect" );
    healthbarinfo.targetentity = undefined;
    healthbarinfo.percentvalue = 0;
    healthbarinfo.state = 0;
    healthbarinfo.var_dd450b05ffe139f7 = -1;
    healthbarinfo.type = 0;
    function_934fa6a7581740c1( index, "ui_ztron_health_bar_percent_", 0 );
    
    /#
        if ( !isbot( self ) && getdvarint( @"hash_f1b6a73da4c16959", 0 ) )
        {
            logstring( "<dev string:xe5>" + self.name + "<dev string:x119>" + index );
        }
    #/
    
    if ( !immediately )
    {
        wait 4;
    }
    
    /#
        if ( !isbot( self ) && getdvarint( @"hash_f1b6a73da4c16959", 0 ) )
        {
            logstring( "<dev string:x121>" + self.name + "<dev string:x119>" + index );
        }
    #/
    
    if ( self.ztron.playerhealthbar == healthbarinfo )
    {
        self.ztron.playerhealthbar = undefined;
    }
    
    function_934fa6a7581740c1( index, "ui_ztron_health_bar_entity_num_", -1 );
    function_934fa6a7581740c1( index, "ui_ztron_health_bar_state_", 0 );
    function_934fa6a7581740c1( index, "ui_ztron_health_bar_type_", 0 );
    function_934fa6a7581740c1( index, "ui_ztron_health_bar_corpse_entity_num_", -1 );
    wait 0.1;
    healthbarinfo.inuse = 0;
}

// Namespace ztron_health_bar
// Params 3
// Checksum 0xbb7acceb, Offset: 0x1585
// Size: 0x1fb
function function_aa973380aea575e0( healthbarinfo, targetentity, state )
{
    healthbarinfo.targetentity = targetentity;
    
    if ( targetentity.using_fake_health )
    {
        healthbarinfo.percentvalue = int( targetentity.var_cce7c67ea2da8902 / targetentity.var_d165d33ad4f00e17 * 10000 );
    }
    else
    {
        healthbarinfo.percentvalue = int( targetentity.health / targetentity.maxhealth * 10000 );
    }
    
    healthbarinfo.percentvalue = int( max( healthbarinfo.percentvalue, 0 ) );
    healthbarinfo.inuse = 1;
    targetentity.var_b0293dea30f2b97e = undefined;
    healthbarstate = 1;
    
    if ( isdefined( state ) )
    {
        healthbarstate = state;
    }
    
    /#
        if ( !isbot( self ) && getdvarint( @"hash_f1b6a73da4c16959", 0 ) )
        {
            logstring( "<dev string:x155>" + self.name + "<dev string:x119>" + healthbarinfo.index + "<dev string:x184>" + targetentity getentitynumber() + "<dev string:x194>" + healthbarinfo.percentvalue );
        }
    #/
    
    function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_entity_num_", targetentity getentitynumber() );
    function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_percent_", healthbarinfo.percentvalue );
    function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_state_", healthbarstate );
    healthbarinfo.state = healthbarstate;
    type = 0;
    
    if ( isdefined( targetentity.var_818c06f9a89fb0ba ) )
    {
        type = targetentity.var_818c06f9a89fb0ba;
    }
    
    function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_type_", type );
    healthbarinfo.type = type;
}

// Namespace ztron_health_bar
// Params 3
// Checksum 0xcdf903ab, Offset: 0x1788
// Size: 0x1ba
function function_934fa6a7581740c1( index, omnvarname, value )
{
    if ( omnvarname == "ui_ztron_health_bar_entity_num_" )
    {
        self.ztron.var_4546033d5cbbc00b.var_87b3453045339a3c = function_93250914575761f1( self.ztron.var_4546033d5cbbc00b.var_87b3453045339a3c, index, omnvarname, value );
        return;
    }
    
    if ( omnvarname == "ui_ztron_health_bar_percent_" )
    {
        self.ztron.var_4546033d5cbbc00b.percentarray = function_93250914575761f1( self.ztron.var_4546033d5cbbc00b.percentarray, index, omnvarname, value );
        return;
    }
    
    if ( omnvarname == "ui_ztron_health_bar_state_" )
    {
        self.ztron.var_4546033d5cbbc00b.statearray = function_93250914575761f1( self.ztron.var_4546033d5cbbc00b.statearray, index, omnvarname, value );
        return;
    }
    
    if ( omnvarname == "ui_ztron_health_bar_corpse_entity_num_" )
    {
        self.ztron.var_4546033d5cbbc00b.var_a8836183392e24d4 = function_93250914575761f1( self.ztron.var_4546033d5cbbc00b.var_a8836183392e24d4, index, omnvarname, value );
        return;
    }
    
    if ( omnvarname == "ui_ztron_health_bar_type_" )
    {
        self.ztron.var_4546033d5cbbc00b.typearray = function_93250914575761f1( self.ztron.var_4546033d5cbbc00b.typearray, index, omnvarname, value );
    }
}

// Namespace ztron_health_bar
// Params 4
// Checksum 0x3cec9c2f, Offset: 0x194a
// Size: 0xfa
function function_93250914575761f1( array, index, omnvarname, value )
{
    _find = 0;
    
    foreach ( _info in array )
    {
        if ( _info.index == index )
        {
            _info.value = value;
            _find = 1;
        }
    }
    
    if ( !_find )
    {
        _info = {};
        _info.index = index;
        _info.omnvarname = omnvarname;
        _info.value = value;
        array[ array.size ] = _info;
    }
    
    return array;
}

// Namespace ztron_health_bar
// Params 0
// Checksum 0xeaacf303, Offset: 0x1a4d
// Size: 0x88
function function_1ebb7cfeb9967ff6()
{
    if ( isdefined( self.ztron.playerhealthbar ) )
    {
        return;
    }
    
    healthbarinfo = function_5ef67c8ef04d1dc();
    
    if ( !isdefined( healthbarinfo ) )
    {
        /#
            if ( !isbot( self ) && getdvarint( @"hash_f1b6a73da4c16959", 0 ) )
            {
                logstring( "<dev string:x1a3>" + self.name );
            }
        #/
        
        return;
    }
    
    self.ztron.playerhealthbar = healthbarinfo;
    function_aa973380aea575e0( healthbarinfo, self, 2 );
}

// Namespace ztron_health_bar
// Params 0
// Checksum 0x235e129d, Offset: 0x1add
// Size: 0x15d
function clearplayerhealthbar()
{
    if ( !isdefined( self.ztron.playerhealthbar ) )
    {
        return;
    }
    
    self.ztron.playerhealthbar.targetentity = undefined;
    self.ztron.playerhealthbar.percentvalue = 0;
    self.ztron.playerhealthbar.state = 0;
    self.ztron.playerhealthbar.var_dd450b05ffe139f7 = -1;
    self.ztron.playerhealthbar.type = 0;
    self.ztron.playerhealthbar.inuse = 0;
    index = self.ztron.playerhealthbar.index;
    function_934fa6a7581740c1( index, "ui_ztron_health_bar_percent_", 0 );
    function_934fa6a7581740c1( index, "ui_ztron_health_bar_entity_num_", -1 );
    function_934fa6a7581740c1( index, "ui_ztron_health_bar_state_", 0 );
    function_934fa6a7581740c1( index, "ui_ztron_health_bar_type_", 0 );
    function_934fa6a7581740c1( index, "ui_ztron_health_bar_corpse_entity_num_", -1 );
    self.ztron.playerhealthbar = undefined;
}

// Namespace ztron_health_bar
// Params 0
// Checksum 0x12e70084, Offset: 0x1c42
// Size: 0x192
function function_13778446559ef08f()
{
    level endon( #"ztron_game_is_over" );
    level waittill( #"start_game_ended" );
    
    foreach ( player in level.players )
    {
        player clearplayerhealthbar();
        
        foreach ( healthbarinfo in player.ztron.healthbararray )
        {
            player function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_percent_", 0 );
            player function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_entity_num_", -1 );
            player function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_state_", 0 );
            player function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_type_", 0 );
            player function_934fa6a7581740c1( healthbarinfo.index, "ui_ztron_health_bar_corpse_entity_num_", -1 );
        }
    }
}

