// scripts\mp\talking_gun.gsc  (hash_1c1c075eae656377.gscc) (size: 20838 Bytes / 0x5166 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc5b6ce72 (3317091954)
// size ...... 20838 (0x5166)
// includes .. 10  (offset: 0x4f46)
// strings ... 27  (offset: 0x4f96)
// dev strs .. 6   (offset: 0x510e)
// exports ... 70  (offset: 0x364a)
// cseg ...... 0x294 + 0x33b6 (0x364a)
// imports ... 104 (offset: 0x413a)
// animtree1 . 0   (offset: 0x5166)
// animtree2 . 0   (offset: 0x5166)
#using script_13131f7e98f45305;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\drop_event_aggregator;
#using scripts\mp\equipment;
#using scripts\mp\flags;

#namespace talking_gun;

// Namespace talking_gun
// Params 0
// Checksum 0xb42f3a5a, Offset: 0x2b2
// Size: 0x58
function init()
{
    callback::add( #"player_laststand_revived", &onplayerrevived );
    callback::add( #"round_ended", &function_176e3df363e0bba6 );
    level callback::add( #"player_weapon_change", &function_5ebbb1f91e2134c2 );
    level callback::add( #"player_spawned", &onplayerspawn );
}

// Namespace talking_gun
// Params 1
// Checksum 0xf29b74f4, Offset: 0x312
// Size: 0x1b, Type: bool
function function_2def2f1ee721a0ac( event )
{
    return event.delay ?? 0;
}

// Namespace talking_gun
// Params 1
// Checksum 0xeafd1204, Offset: 0x336
// Size: 0x1c, Type: bool
function function_567678816ceef204( event )
{
    return event.cooldown ?? 20;
}

// Namespace talking_gun
// Params 1
// Checksum 0xbdc98105, Offset: 0x35b
// Size: 0x1c, Type: bool
function function_ce9747d77638fa63( event )
{
    return event.globalcooldown ?? 5;
}

// Namespace talking_gun
// Params 1
// Checksum 0x479931fb, Offset: 0x380
// Size: 0x1f, Type: bool
function function_6f35f7c963a0551f( event )
{
    return event.omnvar ?? "ui_talkinggun_faceid";
}

// Namespace talking_gun
// Params 1
// Checksum 0xcc60f5b7, Offset: 0x3a8
// Size: 0x1b, Type: bool
function function_e8a267c4e9cd60c9( event )
{
    return event.value ?? 0;
}

// Namespace talking_gun
// Params 1
// Checksum 0xea0afbbf, Offset: 0x3cc
// Size: 0x6f
function talkinggun_update( weaponobj )
{
    talkinggun_removeplayer( self );
    
    if ( weaponobj )
    {
        var_ce3d2c8f8e6ddc56 = weaponobj.charmscriptbundle.talkinggunbundle;
        
        if ( var_ce3d2c8f8e6ddc56 && var_ce3d2c8f8e6ddc56 != %"" )
        {
            bundle = getscriptbundle( var_ce3d2c8f8e6ddc56 );
            
            if ( bundle )
            {
                function_7240e492db43ecc3( self, bundle, var_ce3d2c8f8e6ddc56 );
            }
        }
    }
}

// Namespace talking_gun
// Params 1
// Checksum 0x6b604829, Offset: 0x443
// Size: 0x1c
function onplayerspawn( params )
{
    talkinggun_update( self.spawnweaponobj );
}

// Namespace talking_gun
// Params 1
// Checksum 0x4bd589bf, Offset: 0x467
// Size: 0x1e
function function_5ebbb1f91e2134c2( params )
{
    talkinggun_update( params.weapon );
}

// Namespace talking_gun
// Params 3
// Checksum 0x93448789, Offset: 0x48d
// Size: 0xb5
function function_2e6782929b6e174a( eventname, stateid, omnvaroverride )
{
    event = level.talkingguntables[ eventname ];
    
    if ( isdefined( event ) && isdefined( event.var_5be5b4bb025603e ) )
    {
        return;
    }
    
    var_7793e6c10e771390 = spawnstruct();
    var_7793e6c10e771390.eventid = stateid;
    var_7793e6c10e771390.omnvar = omnvaroverride ?? "ui_talkinggun_faceid";
    
    if ( !isdefined( level.event ) )
    {
        level.talkingguntables[ eventname ] = spawnstruct();
    }
    
    level.talkingguntables[ eventname ].var_5be5b4bb025603e = var_7793e6c10e771390;
}

// Namespace talking_gun
// Params 0
// Checksum 0x781396c2, Offset: 0x54a
// Size: 0x10b
function function_81d5e4c7a8f3d408()
{
    self.talkinggundata = spawnstruct();
    self.talkinggundata.var_af78e19f3eeaf1d0 = 0;
    self.talkinggundata.var_b485e53e898e4e3a = 0;
    self.talkinggundata.var_9a91eb08d7aa1b0f = [];
    self.talkinggundata.var_4854d2890f7b3624 = 0;
    self.talkinggundata.var_5d55620147102904 = 0;
    self.talkinggundata.var_25559a0ccfa6e87a = 0;
    self.talkinggundata.var_c1a895c956099289 = 0;
    self.talkinggundata.lastdamagedtime = 0;
    self.talkinggundata.var_210a06b1e0340e9f = 1;
    self.talkinggundata.lastdeploy = 0;
    self.talkinggundata.var_fc684e51af8023e4 = [];
}

// Namespace talking_gun
// Params 0
// Checksum 0x1da69809, Offset: 0x65d
// Size: 0xe1
function function_dc5c4f6406506684()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"remove_talking_gun" );
    
    while ( true )
    {
        wait 0.5;
        
        if ( !self.talkinggundata )
        {
            continue;
        }
        
        carryinggameobject = isdefined( self.carryobject );
        touchinggameobject = self.touchinggameobjects.size > 0;
        usinggameobject = self.usinggameobjects.size > 0;
        activeobjective = carryinggameobject || touchinggameobject || usinggameobject;
        
        if ( activeobjective )
        {
            if ( !self.talkinggundata.onobj )
            {
                talkinggun_event( self, #"obj_capture" );
            }
        }
        
        self.talkinggundata.onobj = activeobjective;
    }
}

// Namespace talking_gun
// Params 0
// Checksum 0xc5a3e35b, Offset: 0x746
// Size: 0x24d
function function_3113c666822955ef()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        wait 1;
        time = gettime() / 1000;
        
        foreach ( player in level.talkinggunplayers )
        {
            if ( !( isdefined( player ) && isdefined( player.talkinggundata ) && isdefined( player.pers[ "totalDistTraveled" ] ) ) )
            {
                continue;
            }
            
            if ( !isdefined( player.talkinggundata.currentidletime ) )
            {
                player.talkinggundata.currentidletime = 0;
            }
            
            if ( !isdefined( player.talkinggundata.var_d315b85ea2f06d0b ) )
            {
                player.talkinggundata.var_d315b85ea2f06d0b = player.pers[ "totalDistTraveled" ];
            }
            
            var_23532f086a5e0ad8 = player.pers[ "totalDistTraveled" ] - player.talkinggundata.var_d315b85ea2f06d0b;
            player.talkinggundata.var_d315b85ea2f06d0b = player.pers[ "totalDistTraveled" ];
            var_3cfb7f2fb3a348 = player getstance() == "prone";
            
            if ( var_23532f086a5e0ad8 < 100 )
            {
                player.talkinggundata.currentidletime += 1;
                
                if ( time > player.talkinggundata.var_b485e53e898e4e3a + 30 && !var_3cfb7f2fb3a348 && player.talkinggundata.currentidletime > 15 )
                {
                    talkinggun_event( player, #"idle" );
                }
                
                continue;
            }
            
            player.talkinggundata.currentidletime = 0;
        }
    }
}

// Namespace talking_gun
// Params 0
// Checksum 0x836982c5, Offset: 0x99b
// Size: 0x191
function function_f40d6717a3a7e0bb()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"remove_talking_gun" );
    
    while ( true )
    {
        wait 0.1;
        time = gettime() / 1000;
        
        if ( level.talkinggunplayers.size > 0 )
        {
            foreach ( player in level.talkinggunplayers )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                isinads = player playerads() > 0.3;
                
                if ( isinads )
                {
                    if ( player.talkinggundata.var_4854d2890f7b3624 == 0 )
                    {
                        player.talkinggundata.var_4854d2890f7b3624 = time;
                    }
                    
                    if ( time - player.talkinggundata.var_4854d2890f7b3624 > 4 )
                    {
                        talkinggun_event( player, #"aiming_idle" );
                    }
                    
                    continue;
                }
                
                if ( player.talkinggundata.var_4854d2890f7b3624 != 0 )
                {
                    player.talkinggundata.var_4854d2890f7b3624 = 0;
                }
            }
        }
    }
}

// Namespace talking_gun
// Params 2
// Checksum 0xfdb8c161, Offset: 0xb34
// Size: 0xab, Type: bool
function function_7d5bd14f7fd09859( player, eventname )
{
    if ( !isdefined( player.talkinggundata ) )
    {
        return false;
    }
    
    if ( !isdefined( player.talkinggundata.var_9a91eb08d7aa1b0f[ eventname ] ) )
    {
        return false;
    }
    
    timeseconds = gettime() / 1000;
    cooldown = function_567678816ceef204( player.talkinggundata.bundle.dialogevents[ eventname ] );
    return timeseconds < player.talkinggundata.var_9a91eb08d7aa1b0f[ eventname ] + cooldown;
}

// Namespace talking_gun
// Params 1
// Checksum 0x6397f76e, Offset: 0xbe8
// Size: 0xdc, Type: bool
function function_49e15c53304cb2ca( player )
{
    if ( !isdefined( player.talkinggundata ) )
    {
        return false;
    }
    
    if ( player.talkinggundata.active )
    {
        return true;
    }
    
    if ( function_229286fe84b1abed( player ) )
    {
        if ( function_e7a1d4a0d08b143b( player.primaryweaponobj ) )
        {
            return true;
        }
        
        foreach ( weapon in player.primaryweapons )
        {
            if ( function_e7a1d4a0d08b143b( weapon ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace talking_gun
// Params 1
// Checksum 0xb7e6c688, Offset: 0xccd
// Size: 0x35, Type: bool
function function_229286fe84b1abed( player )
{
    if ( vehicle_occupancy::function_3080323254ba6900( player ) )
    {
        return true;
    }
    
    if ( player utility::isusingremote() )
    {
        return true;
    }
    
    if ( player ishanging() )
    {
        return true;
    }
    
    return false;
}

// Namespace talking_gun
// Params 4
// Checksum 0x4c04070a, Offset: 0xd0b
// Size: 0x6b
function function_9fc28abd5b88d804( player, delay, eventid, globalcooldown )
{
    player endon( #"death_or_disconnect" );
    wait delay;
    player setclientomnvar( "ui_talkinggun_soundid", eventid + 1 );
    wait globalcooldown * 0.5;
    player setclientomnvar( "ui_talkinggun_soundid", 0 );
    player notify( #"hash_ce87ee2e5be4327a" );
}

// Namespace talking_gun
// Params 2
// Checksum 0x7bfc195e, Offset: 0xd7e
// Size: 0x78, Type: bool
function function_96ae8b7a7b92b41f( player, eventname )
{
    if ( !function_49e15c53304cb2ca( player ) )
    {
        return false;
    }
    
    return isdefined( player.talkinggundata.bundleevents[ eventname ] ) && isdefined( player.talkinggundata.bundle.dialogevents[ player.talkinggundata.bundleevents[ eventname ] ] );
}

// Namespace talking_gun
// Params 0
// Checksum 0xa8794c9, Offset: 0xdff
// Size: 0x3a
function function_3d0efc85778691c5()
{
    prematchdone = flags::gameflag( "prematch_done" );
    
    if ( isbrgamemode() && !level.skipprematch && !prematchdone )
    {
        return 1;
    }
    
    return prematchdone;
}

// Namespace talking_gun
// Params 2
// Checksum 0xee3a9d, Offset: 0xe42
// Size: 0x13f, Type: bool
function function_9feae165e52d03d3( player, eventname )
{
    if ( !function_49e15c53304cb2ca( player ) )
    {
        return false;
    }
    
    if ( !function_3d0efc85778691c5() )
    {
        return false;
    }
    
    eventid = player.talkinggundata.bundleevents[ eventname ];
    event = player.talkinggundata.bundle.dialogevents[ eventid ];
    
    if ( !isdefined( event ) )
    {
        return false;
    }
    
    timeseconds = gettime() / 1000;
    
    if ( timeseconds < player.talkinggundata.var_af78e19f3eeaf1d0 )
    {
        return false;
    }
    
    if ( function_7d5bd14f7fd09859( player, eventname ) )
    {
        return false;
    }
    
    delay = function_2def2f1ee721a0ac( event );
    globalcooldown = function_ce9747d77638fa63( event );
    player.talkinggundata.var_af78e19f3eeaf1d0 = timeseconds + globalcooldown + delay;
    player.talkinggundata.var_b485e53e898e4e3a = timeseconds;
    player.talkinggundata.var_9a91eb08d7aa1b0f[ eventname ] = timeseconds + delay;
    return true;
}

// Namespace talking_gun
// Params 2
// Checksum 0x9df1753d, Offset: 0xf8a
// Size: 0x4f
function function_2c84f36aa7cd4b87( player, eventname )
{
    if ( !function_49e15c53304cb2ca( player ) )
    {
        return;
    }
    
    if ( !function_3d0efc85778691c5() )
    {
        return;
    }
    
    return player.talkinggundata.bundle.omnvarevents[ eventname ];
}

// Namespace talking_gun
// Params 2
// Checksum 0x67e853b2, Offset: 0xfe2
// Size: 0x105, Type: bool
function talkinggun_event( player, eventname )
{
    if ( !isxhash( eventname ) )
    {
        assertmsg( "<dev string:x24>" );
        eventname = getxhash( eventname );
    }
    
    screenevent = function_2c84f36aa7cd4b87( player, eventname );
    
    if ( isdefined( screenevent ) )
    {
        player setclientomnvar( function_6f35f7c963a0551f( screenevent ), function_e8a267c4e9cd60c9( screenevent ) );
    }
    
    if ( !function_9feae165e52d03d3( player, eventname ) )
    {
        return false;
    }
    
    /#
        iprintlnbold( "<dev string:x33>" + getxhashsourcename( eventname ) );
    #/
    
    eventid = player.talkinggundata.bundleevents[ eventname ];
    event = player.talkinggundata.bundle.dialogevents[ eventid ];
    
    if ( event )
    {
        delay = function_2def2f1ee721a0ac( event );
        thread function_9fc28abd5b88d804( player, delay, eventid, function_ce9747d77638fa63( event ) );
        return true;
    }
    
    return false;
}

// Namespace talking_gun
// Params 0
// Checksum 0x21729bda, Offset: 0x10f0
// Size: 0xc9
function function_2cb0112543a9536a()
{
    currentstock = self getweaponammostock( self.currentweapon );
    maxstock = weaponmaxammo( self.currentweapon );
    
    if ( isbrgamemode() && utility::issharedfuncdefined( #"hash_42fec1bd4229ade7", #"hash_ec4b6bf4af609d6" ) )
    {
        ammotype = [[ utility::getsharedfunc( #"hash_42fec1bd4229ade7", #"hash_ec4b6bf4af609d6" ) ]]( self.currentweapon );
        
        if ( isdefined( ammotype ) )
        {
            maxstock = level.var_9a6a4b42eba220f6[ ammotype ];
        }
    }
    
    if ( currentstock > maxstock * 0.3 )
    {
        talkinggun_event( self, #"reload_start" );
        return;
    }
    
    talkinggun_event( self, #"ammo_reserve_low" );
}

// Namespace talking_gun
// Params 1
// Checksum 0xe4923cf1, Offset: 0x11c1
// Size: 0x1e
function function_e043166fb3a22498( player )
{
    talkinggun_event( player, #"loot_found" );
}

// Namespace talking_gun
// Params 2
// Checksum 0xe95f1692, Offset: 0x11e7
// Size: 0xe1
function function_8f186d78b8efdebd( team, activity )
{
    if ( isdefined( activity ) && activity.name == "hold" )
    {
        return;
    }
    
    wait 1;
    
    if ( isdefined( level.talkinggunplayers ) )
    {
        foreach ( player in level.talkinggunplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player.team == team )
            {
                talkinggun_event( player, #"contract_start" );
            }
        }
    }
}

// Namespace talking_gun
// Params 1
// Checksum 0xa1ac77e4, Offset: 0x12d0
// Size: 0x24
function function_a151347084cb61ff( player )
{
    wait 2;
    talkinggun_event( player, #"activate_uav" );
}

// Namespace talking_gun
// Params 1
// Checksum 0x8853ad79, Offset: 0x12fc
// Size: 0xb6
function function_5befa9a315d7d134( team )
{
    if ( isdefined( level.talkinggunplayers ) )
    {
        foreach ( player in level.talkinggunplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player.team == team )
            {
                talkinggun_event( player, #"contract_complete" );
            }
        }
    }
}

// Namespace talking_gun
// Params 3
// Checksum 0x2a1ca445, Offset: 0x13ba
// Size: 0x9d
function function_c39c347d10f514d7( player, droppedweapon, soundposition )
{
    eventid = player.talkinggundata.bundleevents[ #"no_user_bark" ];
    alias = player.talkinggundata.bundle.dialogevents[ eventid ].alias;
    
    while ( true )
    {
        wait 20;
        
        if ( !isdefined( droppedweapon ) )
        {
            return;
        }
        
        playsoundatpos( soundposition, alias );
    }
}

// Namespace talking_gun
// Params 3
// Checksum 0xcf9f386, Offset: 0x145f
// Size: 0xe4
function function_2417dd5f3232aaf4( droppedweapon, objweapon, var_96f8a1eb4713445f )
{
    if ( !function_e7a1d4a0d08b143b( objweapon ) )
    {
        return;
    }
    
    if ( !function_9feae165e52d03d3( self, #"dropped" ) )
    {
        return;
    }
    
    if ( isdefined( var_96f8a1eb4713445f ) )
    {
        soundposition = var_96f8a1eb4713445f;
    }
    else if ( droppedweapon.origin )
    {
        soundposition = droppedweapon.origin;
    }
    else
    {
        return;
    }
    
    eventid = self.talkinggundata.bundleevents[ #"dropped" ];
    alias = self.talkinggundata.bundle.dialogevents[ eventid ].alias;
    playsoundatpos( soundposition, alias );
    thread function_c39c347d10f514d7( self, droppedweapon, soundposition );
}

// Namespace talking_gun
// Params 1
// Checksum 0x4381d1ef, Offset: 0x154b
// Size: 0x3a
function function_4fa73e5b1fa9defb( player )
{
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait 2;
    talkinggun_event( player, #"player_death_revived_teammate" );
}

// Namespace talking_gun
// Params 1
// Checksum 0xa561ff78, Offset: 0x158d
// Size: 0x79
function function_4fa7335b1fa9c6ca( player )
{
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( isdefined( player.talkinggundata ) && player.talkinggundata.var_210a06b1e0340e9f )
    {
        player.talkinggundata.var_210a06b1e0340e9f = 0;
    }
    
    wait 2;
    talkinggun_event( player, #"teammate_death_revived_me" );
}

// Namespace talking_gun
// Params 1
// Checksum 0x2fa83c89, Offset: 0x160e
// Size: 0x60f
function talkinggun_onplayerdeath( data )
{
    if ( isdefined( data.victim.talkinggundata ) )
    {
        data.victim.talkinggundata.var_c1a895c956099289 = 0;
        data.victim.talkinggundata.var_9a91eb08d7aa1b0f = [];
        data.victim.talkinggundata.var_210a06b1e0340e9f = 1;
        data.victim.talkinggundata.active = 0;
    }
    
    if ( data.attacker == data.victim )
    {
        return;
    }
    
    if ( !isplayer( data.attacker ) )
    {
        return;
    }
    
    foreach ( otherplayer in level.talkinggunplayers )
    {
        if ( !isdefined( otherplayer ) )
        {
            continue;
        }
        
        if ( otherplayer == data.attacker || otherplayer == data.victim )
        {
            continue;
        }
        
        if ( !isdefined( otherplayer.talkinggundata ) )
        {
            continue;
        }
        
        if ( !isdefined( otherplayer.talkinggundata.var_fc684e51af8023e4[ data.victim.guid ] ) )
        {
            continue;
        }
        
        if ( gettime() / 1000 < otherplayer.talkinggundata.var_fc684e51af8023e4[ data.victim.guid ] + 1 )
        {
            talkinggun_event( otherplayer, #"kill_steal" );
        }
    }
    
    if ( !isdefined( data.attacker.talkinggundata ) )
    {
        return;
    }
    
    data.attacker.talkinggundata.var_c1a895c956099289 += 1;
    
    if ( function_96ae8b7a7b92b41f( data.attacker, #"close_call" ) && gettime() / 1000 < data.attacker.talkinggundata.lastdamagedtime + 2 && data.attacker.health < 50 )
    {
        if ( randomfloat( 1 ) < 0.5 )
        {
            talkinggun_event( data.attacker, #"close_call" );
            return;
        }
    }
    
    if ( isstartstr( data.weaponfullstring, "throwingknife_mp" ) )
    {
        talkinggun_event( data.attacker, #"throwing_knife_kill" );
    }
    
    if ( isdefined( data.attacker.vehicle ) && data.meansofdeath == "MOD_CRUSH" )
    {
        talkinggun_event( data.attacker, #"enemy_rammed" );
    }
    
    if ( !weapon::isspreadweapon( data.objweapon ) && damage_utility::isheadshot( data.hitloc, data.meansofdeath, data.attacker ) )
    {
        talkinggun_event( data.attacker, #"headshot_kill" );
    }
    else if ( data.objweapon issilenced() )
    {
        talkinggun_event( data.attacker, #"stealth_kill" );
    }
    else if ( data.meansofdeath == "MOD_MELEE" )
    {
        talkinggun_event( data.attacker, #"melee_kill" );
    }
    
    if ( data.attacker.recentkillcount > 1 )
    {
        if ( data.attacker.recentkillcount == 2 )
        {
            talkinggun_event( data.attacker, #"killed_enemy_double" );
        }
        else if ( data.attacker.recentkillcount == 3 )
        {
            talkinggun_event( data.attacker, #"killed_enemy_triple" );
        }
        else
        {
            talkinggun_event( data.attacker, #"killed_enemy_multi" );
        }
    }
    
    if ( data.attacker.talkinggundata.var_c1a895c956099289 == 5 )
    {
        talkinggun_event( data.attacker, #"killed_enemy_5x" );
        return;
    }
    
    if ( data.attacker.talkinggundata.var_c1a895c956099289 == 10 )
    {
        talkinggun_event( data.attacker, #"killed_enemy_10x" );
        return;
    }
    
    if ( data.attacker.talkinggundata.var_c1a895c956099289 == 15 )
    {
        talkinggun_event( data.attacker, #"killed_enemy_15x" );
        return;
    }
    
    if ( data.attacker.talkinggundata.var_c1a895c956099289 == 20 )
    {
        talkinggun_event( data.attacker, #"killed_enemy_20x" );
        return;
    }
    
    talkinggun_event( data.attacker, #"killed_enemy" );
}

// Namespace talking_gun
// Params 1
// Checksum 0x429b8b5d, Offset: 0x1c25
// Size: 0x103
function function_176e3df363e0bba6( params )
{
    winner = params.winner;
    
    if ( isdefined( level.talkinggunplayers ) )
    {
        foreach ( player in level.talkinggunplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( !isdefined( player.team ) )
            {
                continue;
            }
            
            if ( isplayer( winner ) ? player == winner : player.team == winner )
            {
                talkinggun_event( player, #"round_won" );
                continue;
            }
            
            talkinggun_event( player, #"round_lost" );
        }
    }
}

// Namespace talking_gun
// Params 2
// Checksum 0xe9f2e53d, Offset: 0x1d30
// Size: 0xf8
function talkinggun_killstreakactivated( player, var_d33f58cfe34f0377 )
{
    if ( var_d33f58cfe34f0377 )
    {
        switch ( var_d33f58cfe34f0377 )
        {
            case #"hash_5197246cbacb498f":
                talkinggun_event( self, #"activate_uav" );
                break;
            case #"hash_8e5ee5ee68a42eee":
                talkinggun_event( self, #"activate_counter_uav" );
                break;
            case #"hash_918e7807231d5e31":
                talkinggun_event( self, #"activate_rided" );
                break;
            case #"hash_a70697e26a75779d":
                talkinggun_event( self, #"activate_guided" );
                break;
            case #"hash_393db1cf20822811":
                talkinggun_event( self, #"activate_drone" );
                break;
            default:
                talkinggun_event( self, #"killstreak_used" );
                break;
        }
        
        return;
    }
    
    talkinggun_event( self, #"killstreak_used" );
}

// Namespace talking_gun
// Params 2
// Checksum 0xd524323a, Offset: 0x1e30
// Size: 0x3e
function function_aa1bbdd1f1aacbb5( player, event )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    wait 2;
    talkinggun_event( player, event );
}

// Namespace talking_gun
// Params 1
// Checksum 0x29a2b117, Offset: 0x1e76
// Size: 0x48
function function_387fb62cdc8a529d( victim )
{
    level endon( #"game_ended" );
    victim endon( #"death_or_disconnect" );
    self endon( #"death_or_disconnect" );
    wait 0.5;
    talkinggun_event( self, #"enemy_armor_depleted" );
}

// Namespace talking_gun
// Params 1
// Checksum 0xfe884c60, Offset: 0x1ec6
// Size: 0x46, Type: bool
function function_92050b7e4e1fc408( objweapon )
{
    weapongroup = utility::callsharedfunc( #"weapons", #"hash_fdfca8c2fd92a9de", objweapon );
    return weapongroup == "weapon_sniper" || weapongroup == "weapon_dmr";
}

// Namespace talking_gun
// Params 1
// Checksum 0x7dd9d560, Offset: 0x1f15
// Size: 0x2a6
function function_5c2d9587eb3a6cd7( params )
{
    victim = params.victim;
    eattacker = params.eattacker;
    objweapon = params.objweapon;
    smeansofdeath = params.smeansofdeath;
    
    if ( !( isdefined( victim ) && isdefined( eattacker ) ) )
    {
        /#
            iprintln( "<dev string:x62>" );
        #/
        
        return;
    }
    
    if ( !function_49e15c53304cb2ca( eattacker ) && !function_49e15c53304cb2ca( victim ) )
    {
        return;
    }
    
    if ( eattacker == victim )
    {
        return;
    }
    
    brcircledamage = objweapon.basename == "danger_circle_br";
    
    if ( brcircledamage )
    {
        return;
    }
    
    sniperdistance = distancesquared( victim.origin, eattacker.origin ) > 250000;
    
    if ( isplayer( victim ) && victim.health > 1 )
    {
        if ( smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE_SPLASH" )
        {
            thread function_aa1bbdd1f1aacbb5( victim, #"player_damaged_explosive" );
        }
        else if ( victim.health < 30 )
        {
            thread function_aa1bbdd1f1aacbb5( victim, #"health_low" );
        }
        else if ( function_92050b7e4e1fc408( objweapon ) && sniperdistance )
        {
            thread function_aa1bbdd1f1aacbb5( victim, #"player_damaged_sniper" );
        }
        else
        {
            thread function_aa1bbdd1f1aacbb5( victim, #"player_damaged" );
        }
        
        if ( isdefined( victim.talkinggundata ) && victim.talkinggundata.var_4854d2890f7b3624 != 0 )
        {
            victim.talkinggundata.var_4854d2890f7b3624 = gettime() / 1000;
        }
        
        if ( isdefined( victim.talkinggundata ) )
        {
            victim.talkinggundata.lastdamagedtime = gettime() / 1000;
        }
    }
    
    if ( isplayer( eattacker ) && victim.health > 1 )
    {
        if ( isdefined( eattacker.talkinggundata ) )
        {
            eattacker.talkinggundata.var_fc684e51af8023e4[ victim.guid ] = gettime() / 1000;
        }
        
        if ( function_92050b7e4e1fc408( objweapon ) && sniperdistance )
        {
            thread function_aa1bbdd1f1aacbb5( eattacker, #"enemy_damaged_sniper" );
            return;
        }
        
        thread function_aa1bbdd1f1aacbb5( eattacker, #"enemy_damaged" );
    }
}

// Namespace talking_gun
// Params 0
// Checksum 0x4aae5749, Offset: 0x21c3
// Size: 0xf5
function function_de4dabdbd259516d()
{
    self endon( #"game_ended" );
    
    while ( true )
    {
        currenttime = gettime() / 1000;
        
        for ( k = 0; k < level.talkinggunplayers.size ; k++ )
        {
            if ( !isplayer( level.talkinggunplayers[ k ] ) )
            {
                continue;
            }
            
            if ( currenttime < level.talkinggunplayers[ k ].talkinggundata.lastdeploy + 10 )
            {
                continue;
            }
            
            if ( level.talkinggunplayers[ k ] issprinting() )
            {
                if ( randomfloat( 1 ) < 0.3 )
                {
                    talkinggun_event( level.talkinggunplayers[ k ], #"sprint" );
                    continue;
                }
                
                function_9feae165e52d03d3( level.talkinggunplayers[ k ], #"sprint" );
            }
        }
        
        wait 0.3;
    }
}

// Namespace talking_gun
// Params 0
// Checksum 0xfeb745d7, Offset: 0x22c0
// Size: 0x1ba
function function_7373f5076527c4de()
{
    self endon( #"disconnect" );
    self endon( #"remove_talking_gun" );
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        firetime = weaponfiretime( self.currentweapon.basename );
        time = gettime() * 0.001;
        
        if ( isdefined( self.talkinggundata ) )
        {
            if ( self.talkinggundata.var_4854d2890f7b3624 != 0 )
            {
                self.talkinggundata.var_4854d2890f7b3624 = time;
            }
            
            if ( self.talkinggundata.var_5d55620147102904 == 0 )
            {
                self.talkinggundata.var_5d55620147102904 = time;
                self.talkinggundata.var_25559a0ccfa6e87a = time + firetime + 0.1;
            }
            else if ( time < self.talkinggundata.var_25559a0ccfa6e87a )
            {
                if ( time > self.talkinggundata.var_5d55620147102904 + 1.5 )
                {
                    talkinggun_event( self, #"war_cry" );
                    self.talkinggundata.var_5d55620147102904 = 0;
                }
                else
                {
                    self.talkinggundata.var_25559a0ccfa6e87a = time + firetime + 0.1;
                }
            }
            else
            {
                self.talkinggundata.var_5d55620147102904 = 0;
            }
        }
        
        if ( self getcurrentweaponclipammo() == 0 && self getweaponammostock( self.currentweapon ) == 0 )
        {
            talkinggun_event( self, #"player_zero_ammo" );
        }
    }
}

// Namespace talking_gun
// Params 0
// Checksum 0x5fa77294, Offset: 0x2482
// Size: 0x40
function function_eac79a089d874fe1()
{
    self endon( #"disconnect" );
    self endon( #"remove_talking_gun" );
    
    while ( true )
    {
        self waittill( #"weapon_inspect" );
        talkinggun_event( self, #"weapon_inspect" );
    }
}

// Namespace talking_gun
// Params 1
// Checksum 0xe8be118, Offset: 0x24ca
// Size: 0x263
function function_10e3936e01d03fc9( sparams )
{
    var_bdaae29beade57cf = isdefined( self.bossname );
    var_8e5b84c2af07fd01 = isdefined( sparams.eattacker ) && sparams.eattacker vehicle::is_vehicle() && isplayer( sparams.eattacker.owner );
    
    if ( !isplayer( sparams.eattacker ) && !var_8e5b84c2af07fd01 )
    {
        return;
    }
    
    if ( var_bdaae29beade57cf )
    {
        talkinggun_event( sparams.eattacker, #"dmz_boss_kill" );
        return;
    }
    
    if ( function_96ae8b7a7b92b41f( sparams.eattacker, #"close_call" ) && gettime() / 1000 < sparams.eattacker.talkinggundata.lastdamagedtime + 2 && sparams.eattacker.health < 50 )
    {
        if ( randomfloat( 1 ) < 0.5 )
        {
            talkinggun_event( sparams.eattacker, #"close_call" );
            return;
        }
        
        return;
    }
    
    if ( var_8e5b84c2af07fd01 && sparams.smeansofdeath == "MOD_CRUSH" )
    {
        talkinggun_event( sparams.eattacker.owner, #"enemy_rammed" );
        return;
    }
    
    if ( !weapon::isspreadweapon( sparams.sweapon ) && damage_utility::isheadshot( sparams.shitloc, sparams.smeansofdeath, sparams.eattacker ) )
    {
        talkinggun_event( sparams.eattacker, #"headshot_kill" );
        return;
    }
    
    if ( sparams.sweapon issilenced() )
    {
        talkinggun_event( sparams.eattacker, #"stealth_kill" );
        return;
    }
    
    if ( sparams.smeansofdeath == "MOD_MELEE" )
    {
        talkinggun_event( sparams.eattacker, #"melee_kill" );
        return;
    }
    
    talkinggun_event( sparams.eattacker, #"player_killed_agent" );
}

// Namespace talking_gun
// Params 0
// Checksum 0x5201a649, Offset: 0x2735
// Size: 0x86
function function_15f68c748db3d286()
{
    self endon( #"death_or_disconnect" );
    self endon( #"remove_talking_gun" );
    self.talkinggundata.lastdeploy = gettime() / 1000;
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        level waittill( #"prematch_done" );
        wait 5;
    }
    
    self.talkinggundata.lastdeploy = gettime() / 1000;
    talkinggun_event( self, #"deploy" );
}

// Namespace talking_gun
// Params 1
// Checksum 0x49e0e09d, Offset: 0x27c3
// Size: 0x18a, Type: bool
function function_e7a1d4a0d08b143b( droppedweapon )
{
    if ( !isdefined( droppedweapon ) )
    {
        return false;
    }
    
    weapontocheck = undefined;
    
    if ( isweapon( droppedweapon ) && !isnullweapon( droppedweapon ) )
    {
        weapontocheck = droppedweapon;
    }
    else if ( isdefined( droppedweapon.objweapon ) )
    {
        if ( isnullweapon( droppedweapon.objweapon ) )
        {
            return false;
        }
        
        weapontocheck = droppedweapon.objweapon;
    }
    else if ( droppedweapon.classname == "scriptable" )
    {
        if ( !isdefined( droppedweapon.customweaponname ) )
        {
            return false;
        }
        
        weapontocheck = droppedweapon.customweaponname;
    }
    else
    {
        /#
            iprintlnbold( "<dev string:x9d>" );
        #/
        
        return false;
    }
    
    var_ce3d2c8f8e6ddc56 = droppedweapon.charmscriptbundle.talkinggunbundle;
    
    if ( var_ce3d2c8f8e6ddc56 && var_ce3d2c8f8e6ddc56 != %"" )
    {
        bundle = getscriptbundle( var_ce3d2c8f8e6ddc56 );
        
        if ( bundle )
        {
            return true;
        }
    }
    
    perks = weapontocheck function_4effdad40704b4c5();
    
    foreach ( perk in perks )
    {
        if ( isstartstr( perk, "specialty_talkinggun" ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace talking_gun
// Params 0
// Checksum 0x5f534220, Offset: 0x2956
// Size: 0x4b
function function_ba392768a27179a5()
{
    self endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"enter_vehicle", vehicle, player );
        talkinggun_event( player, #"vehicle_enter" );
    }
}

// Namespace talking_gun
// Params 0
// Checksum 0x5a0e640c, Offset: 0x29a9
// Size: 0x51
function function_36fa4fb1077758dd()
{
    self endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"exit_vehicle", vehicle, player );
        wait 0.1;
        talkinggun_event( player, #"vehicle_exit" );
    }
}

// Namespace talking_gun
// Params 0
// Checksum 0xc9a4ccfd, Offset: 0x2a02
// Size: 0x9b
function function_697f74e9fbc2e604()
{
    while ( true )
    {
        level waittill( #"br_ending_start", winners );
        
        foreach ( player in level.talkinggunplayers )
        {
            thread function_9ed50af46a3d4091( winners, player );
        }
    }
}

// Namespace talking_gun
// Params 2
// Checksum 0xa46e5397, Offset: 0x2aa5
// Size: 0x6c
function function_9ed50af46a3d4091( winners, player )
{
    player endon( #"disconnect" );
    
    if ( isdefined( winners ) && arraycontains( winners, player ) )
    {
        eventplaying = talkinggun_event( player, #"round_won" );
        
        if ( eventplaying )
        {
            player waittill( #"hash_ce87ee2e5be4327a" );
        }
    }
    
    talkinggun_removeplayer( player );
}

// Namespace talking_gun
// Params 2
// Checksum 0x9b6eba, Offset: 0x2b19
// Size: 0x14b
function function_f91612e697751a26( player, grenade )
{
    issuper = utility::callsharedfunc( #"weapons", #"hash_3ddf0aeed54a2da8", grenade.weapon_object );
    
    if ( issuper )
    {
        talkinggun_event( player, #"equipment_deployed" );
        return;
    }
    
    if ( grenade.equipmentref && equipment_mp::isequipmentlethal( grenade.equipmentref ) )
    {
        if ( grenade.equipmentref != "equip_throwing_knife" )
        {
            talkinggun_event( player, #"grenade_lethal_used" );
        }
        
        return;
    }
    
    if ( grenade.equipmentref && equipment_mp::isequipmenttactical( grenade.equipmentref ) )
    {
        if ( grenade.equipmentref )
        {
            switch ( grenade.equipmentref )
            {
                case #"hash_6d194c409057b2":
                case #"hash_4b4a6458f00d9319":
                case #"hash_7c09786dbc292c05":
                case #"hash_8770d1da0d7395b9":
                case #"hash_e8f9f1a42caca59a":
                    break;
                default:
                    talkinggun_event( player, #"grenade_tactical_used" );
                    break;
            }
        }
    }
}

// Namespace talking_gun
// Params 2, eflags: 0x4
// Checksum 0xed89ea25, Offset: 0x2c6c
// Size: 0xde
function private function_22d1c1bee1118718( bundle, bundlehash )
{
    if ( !isdefined( level.gunscreenevents ) )
    {
        level.gunscreenevents = [];
    }
    
    var_7435776374772945 = level.gunscreenevents[ bundlehash ];
    
    if ( var_7435776374772945 )
    {
        return var_7435776374772945;
    }
    
    var_7435776374772945 = [];
    
    foreach ( i, event in bundle.dialogevents )
    {
        var_7435776374772945[ event.eventname ] = i;
    }
    
    level.gunscreenevents[ bundlehash ] = var_7435776374772945;
    return var_7435776374772945;
}

// Namespace talking_gun
// Params 3
// Checksum 0x381863ab, Offset: 0x2d53
// Size: 0x2b5
function function_7240e492db43ecc3( player, bundle, bundlehash )
{
    playdeploy = !isdefined( player.talkinggundata ) || player.talkinggundata.var_210a06b1e0340e9f;
    
    if ( !isdefined( level.talkinggunplayers ) )
    {
        level.talkinggunplayers = [];
    }
    
    if ( !isdefined( player.talkinggundata ) )
    {
        player function_81d5e4c7a8f3d408();
        
        /#
            player thread function_cecb52613c0364ba();
        #/
    }
    
    player.talkinggundata.bundle = bundle;
    player.talkinggundata.bundleevents = function_22d1c1bee1118718( bundle, bundlehash );
    player.talkinggundata.guntype = bundle.guntype;
    player.talkinggundata.active = 1;
    player.talkinggundata.var_210a06b1e0340e9f = 0;
    level.talkinggunplayers[ level.talkinggunplayers.size ] = player;
    
    if ( !isdefined( level.var_481b5c4b40570bf1 ) )
    {
        level.var_481b5c4b40570bf1 = 1;
        level callback::add( #"player_death", &talkinggun_onplayerdeath );
        drop_event_aggregator::function_d13dd0aff56a8cab( &function_2417dd5f3232aaf4 );
        drop_event_aggregator::function_23f91b1f576c522e( &function_2417dd5f3232aaf4 );
        level callback::add( #"on_ai_killed", &function_10e3936e01d03fc9 );
        level callback::add( #"player_damaged", &function_5c2d9587eb3a6cd7 );
        level thread function_de4dabdbd259516d();
        level thread function_ba392768a27179a5();
        level thread function_36fa4fb1077758dd();
        
        if ( isbrgamemode() )
        {
            namespace_6107ae6ec81b3c5c::function_f13d6a76e92aeee1( &function_2cb0112543a9536a );
            level thread function_697f74e9fbc2e604();
        }
    }
    
    player thread function_7373f5076527c4de();
    player thread function_eac79a089d874fe1();
    player thread function_f40d6717a3a7e0bb();
    player thread function_dc5c4f6406506684();
    weaponname = isnullweapon( player.currentweapon ) ? undefined : getcompleteweaponname( player.currentweapon );
    
    if ( isdefined( weaponname ) && isdefined( player.tookweaponfrom[ weaponname ] ) )
    {
        if ( player.tookweaponfrom[ weaponname ].var_e01941ff17446ef3 == player )
        {
            talkinggun_event( self, #"reunited_deploy" );
        }
        else
        {
            talkinggun_event( self, #"stranger_deploy" );
        }
    }
    else if ( playdeploy )
    {
        player thread function_15f68c748db3d286();
    }
    
    assetindex = function_43b5ed5a14a56573( #"scriptbundle_talkinggun", bundlehash );
    player setclientomnvar( "ui_talkinggun_faceid", assetindex );
}

// Namespace talking_gun
// Params 1
// Checksum 0x3c9d59d6, Offset: 0x3010
// Size: 0xc3
function talkinggun_removeplayer( player )
{
    if ( !isdefined( player.talkinggundata ) )
    {
        return;
    }
    
    player notify( #"remove_talking_gun" );
    player.talkinggundata.active = 0;
    
    for ( k = 0; k < level.talkinggunplayers.size ; k++ )
    {
        if ( level.talkinggunplayers[ k ] == player )
        {
            lasttalkinggun = level.talkinggunplayers.size - 1;
            level.talkinggunplayers[ k ] = level.talkinggunplayers[ lasttalkinggun ];
            level.talkinggunplayers[ lasttalkinggun ] = undefined;
            break;
        }
    }
    
    player setclientomnvar( "ui_talkinggun_faceid", -1 );
}

// Namespace talking_gun
// Params 1
// Checksum 0x37c5907f, Offset: 0x30db
// Size: 0x5a
function onplayerrevived( params )
{
    if ( params.wasselfrevive )
    {
        talkinggun_event( self, #"self_revive" );
        return;
    }
    
    talkinggun_event( self, #"teammate_laststand_revived_me" );
    talkinggun_event( params.reviver, #"player_laststand_revived_teammate" );
}

// Namespace talking_gun
// Params 0
// Checksum 0xfe4d6280, Offset: 0x313d
// Size: 0xa
function unsettalkinggun()
{
    talkinggun_removeplayer( self );
}

// Namespace talking_gun
// Params 0
// Checksum 0xa2a82f93, Offset: 0x314f
// Size: 0x21
function function_36736e40b14d6fa6()
{
    if ( !getdvarint( @"hash_18bf04d5c5766462" ) )
    {
        return;
    }
    
    function_7240e492db43ecc3( self, "announcer" );
}

// Namespace talking_gun
// Params 0
// Checksum 0xaf0aac3e, Offset: 0x3178
// Size: 0x21
function function_36736d40b14d6d73()
{
    if ( !getdvarint( @"hash_18bf04d5c5766462" ) )
    {
        return;
    }
    
    function_7240e492db43ecc3( self, "robot" );
}

// Namespace talking_gun
// Params 0
// Checksum 0x6af7ca8d, Offset: 0x31a1
// Size: 0x21
function function_36736c40b14d6b40()
{
    if ( !getdvarint( @"hash_18bf04d5c5766462" ) )
    {
        return;
    }
    
    function_7240e492db43ecc3( self, "hypeman" );
}

// Namespace talking_gun
// Params 0
// Checksum 0x2a1a5b90, Offset: 0x31ca
// Size: 0x21
function function_36737340b14d7aa5()
{
    if ( !getdvarint( @"hash_18bf04d5c5766462" ) )
    {
        return;
    }
    
    function_7240e492db43ecc3( self, "blackcell" );
}

// Namespace talking_gun
// Params 0
// Checksum 0xf32c17a0, Offset: 0x31f3
// Size: 0xf
function function_6b2a299d4c0ef3c6()
{
    function_7240e492db43ecc3( self, "announcer" );
}

// Namespace talking_gun
// Params 0
// Checksum 0x6ebc5afd, Offset: 0x320a
// Size: 0xf
function function_db94b7f360ebac2d()
{
    function_7240e492db43ecc3( self, "robot" );
}

// Namespace talking_gun
// Params 0
// Checksum 0xf32c17a0, Offset: 0x3221
// Size: 0xf
function function_73c9168087346b36()
{
    function_7240e492db43ecc3( self, "blackcell" );
}

// Namespace talking_gun
// Params 0
// Checksum 0xcfaf7f57, Offset: 0x3238
// Size: 0xf
function function_15e3538fe309e206()
{
    function_7240e492db43ecc3( self, "npc" );
}

// Namespace talking_gun
// Params 0
// Checksum 0x61457b3d, Offset: 0x324f
// Size: 0xf
function function_cd149d8fad91add9()
{
    function_7240e492db43ecc3( self, "cat" );
}

// Namespace talking_gun
// Params 0
// Checksum 0x61457b3d, Offset: 0x3266
// Size: 0xf
function function_bc4d618fa06fea5f()
{
    function_7240e492db43ecc3( self, "dog" );
}

/#

    // Namespace talking_gun
    // Params 0
    // Checksum 0xc9a25060, Offset: 0x327d
    // Size: 0xcf, Type: dev
    function function_cecb52613c0364ba()
    {
        self notify( #"hash_965685986657306a" );
        self endon( #"hash_965685986657306a" );
        
        while ( true )
        {
            eventname = getdvar( @"hash_53cb08e924ea65a4" );
            
            if ( eventname != "<dev string:xea>" )
            {
                eventid = self.talkinggundata.bundleevents[ getxhash( eventname ) ];
                event = self.talkinggundata.bundle.dialogevents[ eventid ];
                
                if ( event )
                {
                    thread function_9fc28abd5b88d804( self, function_2def2f1ee721a0ac( event ), eventid, function_ce9747d77638fa63( event ) );
                }
                
                setdvar( @"hash_53cb08e924ea65a4", "<dev string:xea>" );
            }
            
            wait 0.05;
        }
    }

#/

// Namespace talking_gun
// Params 0
// Checksum 0xbf82c8d8, Offset: 0x3354
// Size: 0x1e1
function function_eb8115c4726caa5a()
{
    /#
        setdevdvarifuninitialized( @"hash_ed477691433d09ec", "<dev string:xea>" );
        thread function_fd2e3fe7435edb71();
    #/
    
    function_7240e492db43ecc3( self, "doom" );
    var_de9fff6aff364c71 = "ui_doomscreen_faceid";
    function_2e6782929b6e174a( #"contract_complete", 1, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"loot_found", 1, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"obj_capture", 1, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"killstreak_used", 1, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"round_won", 1, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"knocked_down_enemy", 1, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"self_apply", 1, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"war_cry", 1, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"highalert_spotted", 2, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"teammate_death_revived_me", 2, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"round_lost", 2, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"sprint", 2, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"player_knocked_down", 3, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"highalert_spotted_left", 7, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"highalert_spotted_right", 8, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"killed_enemy_multi", 9, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"killed_enemy_5x", 9, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"killed_enemy_10x", 9, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"killed_enemy_15x", 9, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"killed_enemy_20x", 9, var_de9fff6aff364c71 );
    function_2e6782929b6e174a( #"nuke_earned", 9, var_de9fff6aff364c71 );
}

// Namespace talking_gun
// Params 0
// Checksum 0x54f6e93d, Offset: 0x353d
// Size: 0x1b
function doomscreen_removeplayer()
{
    talkinggun_removeplayer( self );
    
    if ( isdefined( self ) )
    {
        self notify( #"hash_7d1f09d7b48e6050" );
    }
}

/#

    // Namespace talking_gun
    // Params 0
    // Checksum 0xb1dedeae, Offset: 0x3560
    // Size: 0xea, Type: dev
    function function_fd2e3fe7435edb71()
    {
        self endon( #"hash_7d1f09d7b48e6050" );
        
        while ( true )
        {
            eventname = getdvar( @"hash_ed477691433d09ec" );
            
            if ( eventname != "<dev string:xea>" )
            {
                omnvarval = 0;
                
                switch ( eventname )
                {
                    case #"hash_dd65780f43656833":
                        omnvarval = 1;
                        break;
                    case #"hash_bcd16c32933c3b91":
                        omnvarval = 2;
                        break;
                    case #"hash_1f1d7b3efcb82111":
                        omnvarval = 3;
                        break;
                    case #"hash_95f8d06c03be72f6":
                        omnvarval = 7;
                        break;
                    case #"hash_ec1d2322d127982b":
                        omnvarval = 8;
                        break;
                    case #"hash_379a17913fa2594a":
                        omnvarval = 9;
                        break;
                }
                
                self setclientomnvar( "<dev string:x119>", omnvarval );
                setdvar( @"hash_ed477691433d09ec", "<dev string:xea>" );
            }
            
            wait 0.05;
        }
    }

#/
