// script_326e44f18084416a  (hash_326e44f18084416a.gscc) (size: 6875 Bytes / 0x1adb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfce77ca0 (4243029152)
// size ...... 6875 (0x1adb)
// includes .. 5   (offset: 0x1a53)
// strings ... 6   (offset: 0x1a7b)
// dev strs .. 0   (offset: 0x1adb)
// exports ... 15  (offset: 0x137f)
// cseg ...... 0xc1 + 0x12be (0x137f)
// imports ... 36  (offset: 0x15d7)
// animtree1 . 0   (offset: 0x1adb)
// animtree2 . 0   (offset: 0x1adb)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\hud_util;

#namespace namespace_6db61cded148a258;

// Namespace namespace_6db61cded148a258
// Params 0, eflags: 0x5
// Checksum 0xb8025899, Offset: 0xdf
// Size: 0x6d
function private autoexec main()
{
    level.var_c267f3cfc720a3be = [];
    level.var_e8baaf9a6a5a10e0 = [];
    level callback::add( #"player_spawned", &function_600f8b7419162a39 );
    level callback::add( #"player_death", &function_98936ace4ab4a08d );
    level callback::add( #"player_disconnect", &function_206cd317b7bfb88b );
    level waittill( #"player_spawned" );
    level thread function_d8ccbe4b018e8e42();
}

// Namespace namespace_6db61cded148a258
// Params 0, eflags: 0xc
// Checksum 0x5e2ab9f0, Offset: 0x154
// Size: 0x5a6
function private function_d8ccbe4b018e8e42()
{
    self notify( #"hash_c0ec1230e3abbc18" );
    self endon( #"hash_c0ec1230e3abbc18" );
    level endon( #"game_ended" );
    var_6bd3f38e74c5e069 = level.gametypebundle.var_2a4f915c8cf0c18 ?? 1;
    
    while ( true )
    {
        var_57c628ef01bc26e9 = level.players;
        
        if ( !var_57c628ef01bc26e9 || var_57c628ef01bc26e9.size == 0 )
        {
            wait 0.05;
            continue;
        }
        
        foreach ( player in var_57c628ef01bc26e9 )
        {
            if ( !player::isreallyalive( player ) || !player.teamperks.size )
            {
                wait 0.05;
                continue;
            }
            
            foreach ( teamperk in player.teamperks )
            {
                allies = teams::getfriendlyplayers( player.team, 1 );
                
                if ( !isdefined( allies ) )
                {
                    wait 0.05;
                    continue;
                }
                
                var_d05dee405244ee21 = level.var_e8baaf9a6a5a10e0[ teamperk.perkname ];
                
                foreach ( ally in allies )
                {
                    if ( ally == player )
                    {
                        continue;
                    }
                    
                    allyentnum = ally getentitynumber();
                    
                    if ( isdefined( teamperk.affectedallies[ allyentnum ] ) && player.var_1828e46f63d057c8[ allyentnum ] > 0 )
                    {
                        if ( isdefined( ally.var_efd27494c014d76f.buffs[ teamperk.perkname ] ) )
                        {
                            ally.var_efd27494c014d76f.buffs[ teamperk.perkname ] notify( #"stop_pulse_tps_hud" );
                            ally.var_efd27494c014d76f.buffs[ teamperk.perkname ] hud_util::showelem();
                        }
                    }
                    
                    player.var_1828e46f63d057c8[ allyentnum ] = 0;
                    
                    if ( isdefined( teamperk.affectedallies[ allyentnum ] ) )
                    {
                        continue;
                    }
                    
                    if ( ally.var_86c4b1b610f8536b[ var_d05dee405244ee21 ] > 0 )
                    {
                        ally.var_86c4b1b610f8536b[ var_d05dee405244ee21 ]++;
                    }
                    else
                    {
                        ally.var_86c4b1b610f8536b[ var_d05dee405244ee21 ] = 1;
                        ally perk::giveperk( var_d05dee405244ee21 );
                        var_3d67f5e4ab052e35 = level.perkbundles[ var_d05dee405244ee21 ].var_fd9b39439920c808 ?? "uin_cer_notify_fieldupgrade_ready";
                        ally playlocalsound( var_3d67f5e4ab052e35 );
                        function_8ef6bf3a8a58cac( ally, ally.var_86c4b1b610f8536b );
                        function_fa87874cd0a700f5( ally, ally.teamperk, ally.var_86c4b1b610f8536b );
                    }
                    
                    teamperk.affectedallies[ allyentnum ] = ally;
                    
                    if ( !isdefined( ally.var_c4b4f21cb358d87c[ var_d05dee405244ee21 ] ) )
                    {
                        ally.var_c4b4f21cb358d87c[ var_d05dee405244ee21 ] = [];
                    }
                    
                    ally.var_c4b4f21cb358d87c[ var_d05dee405244ee21 ] = arraycombineunique( ally.var_c4b4f21cb358d87c[ var_d05dee405244ee21 ], [ player ] );
                    
                    if ( isdefined( teamperk.affectedallies[ allyentnum ] ) )
                    {
                        if ( player.var_1828e46f63d057c8[ allyentnum ] == 0 && ally.var_86c4b1b610f8536b[ var_d05dee405244ee21 ] == 1 )
                        {
                            if ( isdefined( ally.var_efd27494c014d76f.buffs[ teamperk.perkname ] ) && !ally.var_efd27494c014d76f.buffs[ var_d05dee405244ee21 ].hidden )
                            {
                                ally.var_efd27494c014d76f.buffs[ teamperk.perkname ] thread function_dad19e31d30d5fa8( 0 );
                            }
                        }
                        
                        if ( player.var_1828e46f63d057c8[ allyentnum ] >= var_6bd3f38e74c5e069 )
                        {
                            if ( isdefined( ally.var_efd27494c014d76f.buffs[ teamperk.perkname ] ) )
                            {
                                ally.var_efd27494c014d76f.buffs[ teamperk.perkname ] notify( #"stop_pulse_tps_hud" );
                            }
                            
                            player.var_1828e46f63d057c8[ allyentnum ] = 0;
                            teamperk.affectedallies[ allyentnum ] = undefined;
                            ally.var_c4b4f21cb358d87c[ var_d05dee405244ee21 ] = arrayremove( ally.var_c4b4f21cb358d87c[ var_d05dee405244ee21 ], player );
                            level function_ecf040cd334ea790( ally, var_d05dee405244ee21 );
                        }
                        
                        player.var_1828e46f63d057c8[ allyentnum ] += 0.05 * var_57c628ef01bc26e9.size;
                    }
                }
            }
            
            wait 0.05;
        }
    }
}

// Namespace namespace_6db61cded148a258
// Params 1
// Checksum 0xc524624e, Offset: 0x702
// Size: 0x3c
function function_600f8b7419162a39( data )
{
    self.var_c4b4f21cb358d87c = [];
    self.var_1828e46f63d057c8 = [];
    self.var_86c4b1b610f8536b = [];
    function_fa87874cd0a700f5( self, self.teamperk, [] );
}

// Namespace namespace_6db61cded148a258
// Params 1
// Checksum 0x90499e6c, Offset: 0x746
// Size: 0x1a
function function_98936ace4ab4a08d( data )
{
    function_ac9ad18b6b43513c();
    function_ec276fc5265a02a4();
}

// Namespace namespace_6db61cded148a258
// Params 1
// Checksum 0xc2375fe1, Offset: 0x768
// Size: 0x1a
function function_206cd317b7bfb88b( data )
{
    function_ac9ad18b6b43513c();
    function_ec276fc5265a02a4();
}

// Namespace namespace_6db61cded148a258
// Params 0
// Checksum 0x9c416563, Offset: 0x78a
// Size: 0x133
function function_ac9ad18b6b43513c()
{
    foreach ( teamperk in self.teamperks )
    {
        var_623a8bbe14581fee = level.var_e8baaf9a6a5a10e0[ teamperk.perkname ];
        
        foreach ( ally in teamperk.affectedallies )
        {
            if ( ally )
            {
                ally.var_c4b4f21cb358d87c[ var_623a8bbe14581fee ] = arrayremove( ally.var_c4b4f21cb358d87c[ var_623a8bbe14581fee ], self );
                level function_ecf040cd334ea790( ally, var_623a8bbe14581fee );
            }
        }
    }
}

// Namespace namespace_6db61cded148a258
// Params 0
// Checksum 0x44ba2680, Offset: 0x8c5
// Size: 0x1a3
function function_ec276fc5265a02a4()
{
    if ( self.var_86c4b1b610f8536b.size > 0 )
    {
        foreach ( perk in getarraykeys( self.var_86c4b1b610f8536b ) )
        {
            if ( self.var_86c4b1b610f8536b[ perk ] > 0 )
            {
                level function_ecf040cd334ea790( self, perk );
            }
        }
    }
    
    playerentnum = self getentitynumber();
    
    foreach ( player in level.players )
    {
        if ( player != self )
        {
            foreach ( teamperk in player.teamperks )
            {
                teamperk.affectedallies[ playerentnum ] = undefined;
            }
        }
    }
}

// Namespace namespace_6db61cded148a258
// Params 2
// Checksum 0xc88286d6, Offset: 0xa70
// Size: 0x93
function function_ecf040cd334ea790( player, var_bac8b30bd7ce8d6b )
{
    if ( player.var_86c4b1b610f8536b[ var_bac8b30bd7ce8d6b ] > 0 && var_bac8b30bd7ce8d6b != "specialty_null" )
    {
        player.var_86c4b1b610f8536b[ var_bac8b30bd7ce8d6b ]--;
        
        if ( player.var_86c4b1b610f8536b[ var_bac8b30bd7ce8d6b ] == 0 )
        {
            player perk::removeperk( var_bac8b30bd7ce8d6b );
            function_8ef6bf3a8a58cac( player, player.var_86c4b1b610f8536b );
            function_fa87874cd0a700f5( player, player.teamperk, player.var_86c4b1b610f8536b );
        }
    }
}

/#

    // Namespace namespace_6db61cded148a258
    // Params 0, eflags: 0xc
    // Checksum 0xaf66610c, Offset: 0xb0b
    // Size: 0x161, Type: dev
    function private function_2a9b1d464361b8e5()
    {
        self notify( #"hash_84274faf7ebec83" );
        self endon( #"hash_84274faf7ebec83" );
        var_26ec15f9a70d8e05 = level.gametypebundle.var_b1e27964aaf48faa ?? 450;
        var_c88fddf399613d53 = level.gametypebundle.var_8e409e5c9f302892 ?? 550;
        
        while ( true )
        {
            foreach ( player in level.players )
            {
                if ( player::isreallyalive( player ) && isbot( player ) )
                {
                    cylinder( player.origin, player.origin + ( 0, 0, 64 ), var_26ec15f9a70d8e05, ( 0, 0, 1 ) );
                    cylinder( player.origin, player.origin + ( 0, 0, 64 ), var_c88fddf399613d53, ( 1, 0, 0 ) );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace namespace_6db61cded148a258
// Params 2
// Checksum 0x5fd8c1d9, Offset: 0xc74
// Size: 0xeb
function function_8ef6bf3a8a58cac( player, var_86c4b1b610f8536b )
{
    if ( !isdefined( player ) || !isdefined( var_86c4b1b610f8536b ) )
    {
        return;
    }
    
    var_a09831b242434062 = [];
    
    foreach ( buffref, value in var_86c4b1b610f8536b )
    {
        if ( value > 0 )
        {
            var_a09831b242434062[ var_a09831b242434062.size ] = buffref;
        }
    }
    
    for ( omnvarindex = 0; omnvarindex < 2 ; omnvarindex++ )
    {
        omnvarvalue = var_a09831b242434062[ omnvarindex ];
        
        if ( !isdefined( omnvarvalue ) )
        {
            omnvarvalue = "none";
        }
        
        player setclientomnvar( "ui_networked_perk_" + omnvarindex, omnvarvalue );
    }
}

// Namespace namespace_6db61cded148a258
// Params 3
// Checksum 0xa8b39251, Offset: 0xd67
// Size: 0x40e
function function_fa87874cd0a700f5( player, myteamperk, var_86c4b1b610f8536b )
{
    if ( isbot( player ) || isagent( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_efd27494c014d76f ) )
    {
        xoffset = -55;
        yoffset = 85;
        var_87ca48ecebea8b3f = 10;
        player.var_efd27494c014d76f = spawnstruct();
        player.var_efd27494c014d76f.perkchoice = player hud_util::createfontstring( "default", 1 );
        player.var_efd27494c014d76f.perkchoice.color = ( 1, 1, 0 );
        player.var_efd27494c014d76f.perkchoice.alpha = 1;
        player.var_efd27494c014d76f.perkchoice.sort = 1;
        player.var_efd27494c014d76f.perkchoice hud_util::setpoint( "RIGHT", "RIGHT", xoffset, yoffset );
        yoffset += var_87ca48ecebea8b3f;
        player.var_efd27494c014d76f.buffs = [];
        
        foreach ( buff in getarraykeys( level.var_e8baaf9a6a5a10e0 ) )
        {
            player.var_efd27494c014d76f.buffs[ buff ] = player hud_util::createfontstring( "default", 1 );
            player.var_efd27494c014d76f.buffs[ buff ] settext( level.var_c267f3cfc720a3be[ buff ] );
            player.var_efd27494c014d76f.buffs[ buff ].color = ( 0, 0.75, 1 );
            player.var_efd27494c014d76f.buffs[ buff ].alpha = 1;
            player.var_efd27494c014d76f.buffs[ buff ].sort = 1;
            player.var_efd27494c014d76f.buffs[ buff ] hud_util::setpoint( "RIGHT", "RIGHT", xoffset, yoffset );
            yoffset += var_87ca48ecebea8b3f;
        }
    }
    
    if ( isdefined( myteamperk ) && myteamperk != "specialty_null" )
    {
        player.var_efd27494c014d76f.perkchoice settext( level.var_c267f3cfc720a3be[ myteamperk ] );
    }
    
    foreach ( buff in getarraykeys( level.var_e8baaf9a6a5a10e0 ) )
    {
        refname = level.var_e8baaf9a6a5a10e0[ buff ];
        
        if ( var_86c4b1b610f8536b[ refname ] > 0 )
        {
            if ( player.var_efd27494c014d76f.buffs[ buff ].hidden )
            {
                player.var_efd27494c014d76f.buffs[ buff ] thread function_dad19e31d30d5fa8( 1 );
            }
            
            continue;
        }
        
        if ( isdefined( player.var_efd27494c014d76f.buffs[ buff ] ) )
        {
            player.var_efd27494c014d76f.buffs[ buff ] hud_util::hideelem();
        }
    }
}

// Namespace namespace_6db61cded148a258
// Params 1, eflags: 0xc
// Checksum 0x9d544454, Offset: 0x117d
// Size: 0xd6
function private function_dad19e31d30d5fa8( toshow )
{
    self notify( #"hash_3b2d3f7edf630369" );
    self endon( #"hash_3b2d3f7edf630369" );
    self endon( #"stop_pulse_tps_hud" );
    time = 0;
    interval = 0.15;
    totaltime = level.gametypebundle.var_2a4f915c8cf0c18 ?? 1;
    
    if ( toshow )
    {
        interval = 0.25;
        totaltime = 0.5;
    }
    
    while ( time <= totaltime )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( self.hidden )
        {
            hud_util::showelem();
        }
        else
        {
            hud_util::hideelem();
        }
        
        time += interval;
        wait interval;
    }
    
    if ( isdefined( self ) )
    {
        if ( toshow )
        {
            hud_util::showelem();
            return;
        }
        
        hud_util::hideelem();
    }
}

// Namespace namespace_6db61cded148a258
// Params 1
// Checksum 0xd60f6500, Offset: 0x125b
// Size: 0x5e
function set_team_perk( perkname )
{
    teamperk = { #affectedallies:[], #perkname:perkname };
    self.teamperks = arraycombineunique( self.teamperks, [ teamperk ] );
    function_fa87874cd0a700f5( self, perkname, self.var_86c4b1b610f8536b );
}

// Namespace namespace_6db61cded148a258
// Params 1
// Checksum 0xb78b98d, Offset: 0x12c1
// Size: 0xbe
function unset_team_perk( perkname )
{
    foreach ( teamperk in self.teamperks )
    {
        if ( teamperk.perkname == perkname )
        {
            self.teamperks = arrayremove( self.teamperks, teamperk );
            break;
        }
    }
    
    function_fa87874cd0a700f5( self, "specialty_null", self.var_86c4b1b610f8536b );
}

