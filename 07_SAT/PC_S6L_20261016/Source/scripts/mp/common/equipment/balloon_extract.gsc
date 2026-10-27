// scripts\mp\common\equipment\balloon_extract.gsc  (hash_074322615d12877e.gscc) (size: 8368 Bytes / 0x20b0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xda411622 (3661698594)
// size ...... 8368 (0x20b0)
// includes .. 16  (offset: 0x1e20)
// strings ... 36  (offset: 0x1ea0)
// dev strs .. 4   (offset: 0x207c)
// exports ... 18  (offset: 0x12bc)
// cseg ...... 0x331 + 0xf8b (0x12bc)
// imports ... 74  (offset: 0x158c)
// animtree1 . 0   (offset: 0x20b0)
// animtree2 . 0   (offset: 0x20b0)
#using script_74b851b7aa1ef32d;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_dmz_inventory;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\loot;
#using scripts\mp\equipment;
#using scripts\mp\gametypes\extraction_container;
#using scripts\mp\hud_message;
#using scripts\mp\loot;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\parachute;
#using scripts\mp\supers;

#namespace balloon_extract;

// Namespace balloon_extract
// Params 0
// Checksum 0xdfbe9e4, Offset: 0x34f
// Size: 0x64
function function_9450f115cc82ffbd()
{
    game[ "dialog" ][ "plunder_extract_fail_fulton" ] = "plunder_plunder_extract_fail_fulton";
    level._effect[ "vfx_fulton_explode" ] = loadfxasset( "vfx_iw8_br_gameplay_money_fulton_destr" );
    scriptable::scriptable_addusedcallbackbypart( "balloon_extract_use", &extraction_container::function_e1dbb4b44225d9a2 );
    level.var_f2d497a894123883 = getdvarint( @"scr_balloon_extract_slots", 4 ) - 1;
    level.var_fba02d97c58e7ed4 = [];
}

// Namespace balloon_extract
// Params 1
// Checksum 0x825d2f04, Offset: 0x3bb
// Size: 0x148
function function_c6139d2fb3b87922( grenade )
{
    self endon( #"death_or_disconnect" );
    grenade waittill( #"missile_stuck", stuckto );
    
    if ( isdefined( stuckto ) )
    {
        function_41ac6da0360a6efa( grenade, stuckto );
        
        if ( !isdefined( grenade.moving_platform ) )
        {
            self playlocalsound( "fly_pickup_deny" );
            hud_message::showerrormessage( %"mp/extract_balloon_cannot_place" );
            
            if ( isdefined( self.super ) )
            {
                function_e6d9f4db1a668b68();
            }
            
            grenade delete();
            return;
        }
    }
    
    if ( !function_a111149bd405d1cf( grenade ) )
    {
        self playlocalsound( "fly_pickup_deny" );
        hud_message::showerrormessage( %"mp/extract_balloon_blocked" );
        
        if ( isdefined( self.super ) )
        {
            function_e6d9f4db1a668b68();
        }
        
        grenade delete();
        return;
    }
    else if ( 1 && isdefined( self.balloon ) )
    {
        self playlocalsound( "fly_pickup_deny" );
        hud_message::showerrormessage( %"hash_4e4674435c57efae" );
        
        if ( isdefined( self.super ) )
        {
            function_e6d9f4db1a668b68();
        }
        
        grenade delete();
        return;
    }
    
    if ( isdefined( self.super ) )
    {
        supers_mp::superusefinished( undefined, undefined, undefined, 1 );
    }
    
    function_42102f65fe745e73( grenade );
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
}

// Namespace balloon_extract
// Params 1
// Checksum 0x20e5832f, Offset: 0x50b
// Size: 0xc2
function function_42102f65fe745e73( grenade )
{
    balloon = spawn( "script_model", grenade.origin );
    balloon setautoboxcalculationusingdobj( 1 );
    balloon setmodel( "military_skyhook_far_mp_ballon_extract" );
    balloon.angles = grenade.angles * ( 0, 1, 0 );
    balloon.owner = self;
    balloon.team = self.team;
    
    if ( isdefined( grenade.moving_platform ) )
    {
        balloon.moving_platform = grenade.moving_platform;
    }
    
    self.balloon = balloon;
    balloon function_cf75750831866d79();
}

// Namespace balloon_extract
// Params 0
// Checksum 0xc3fd40d9, Offset: 0x5d5
// Size: 0x5c
function function_cf75750831866d79()
{
    playsoundatpos( self.origin, "iw9_extraction_balloon_drop" );
    thread br::teamsplashbr( "br_fulton_device_placed", self.owner, self.team, undefined, "splash_list_br_plunder_iw9_mp" );
    
    if ( isdefined( self.moving_platform ) )
    {
        self linkto( self.moving_platform );
    }
    
    thread function_5d147145d1d7872f();
}

// Namespace balloon_extract
// Params 0
// Checksum 0x915157ed, Offset: 0x639
// Size: 0x20e
function function_5d147145d1d7872f()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    scriptable = self getlinkedscriptableinstance();
    scriptable.noweaponslot = !getdvarint( @"scr_balloon_extract_use_weapon_slot", 0 );
    self setscriptablepartstate( "anims", "opening" );
    self setscriptablepartstate( "balloon_extract_use", "usable" );
    var_92b4d78b4c27649d = [];
    
    foreach ( player in level.players )
    {
        if ( player.team == self.team )
        {
            var_92b4d78b4c27649d[ var_92b4d78b4c27649d.size ] = player;
            player hud_message::showerrormessage( %"mp/balloon_extract_tip" );
            continue;
        }
        
        scriptable disablescriptableplayeruse( player );
    }
    
    wait function_4bd8c4bf5c27edcb();
    self setscriptablepartstate( "anims", "open" );
    thread function_2eff985fc85715f6( var_92b4d78b4c27649d );
    wait 30;
    self setscriptablepartstate( "balloon_extract_use", "unusable" );
    self setscriptablepartstate( "effects", "neutral" );
    
    foreach ( player in scriptable.playeropen )
    {
        if ( isalive( player ) )
        {
            player setclientomnvar( "loot_container_open", 0 );
        }
    }
    
    self setscriptablepartstate( "anims", "takeoff" );
    wait function_95cb706afbd1b79e();
    scriptable function_619eab9374f41714();
    self delete();
    self notify( #"death" );
}

// Namespace balloon_extract
// Params 0
// Checksum 0xf2e45c20, Offset: 0x84f
// Size: 0x1c6
function function_619eab9374f41714()
{
    if ( !isdefined( self.playeropen ) )
    {
        return;
    }
    
    foreach ( player in self.playeropen )
    {
        if ( !isdefined( self.playercontents ) )
        {
            continue;
        }
        
        println( player getplayerdata( level.var_6f9b00680ed002d8, "<dev string:x24>" ) + "<dev string:x32>" );
        var_7561a7f44b738d86 = function_f9274c3d2a5b23e8( self.playercontents[ player.guid ].contents );
        totalcash = player br_dmz_inventory::function_e342ce3749830a35( var_7561a7f44b738d86, 1 );
        println( player getplayerdata( level.var_6f9b00680ed002d8, "<dev string:x24>" ) + "<dev string:x59>" );
        weaponslotid = player loot_mp::function_6d3e17fbc5d75dde( "loot_container_weapon" );
        var_9ebee770c4d8cd27 = player getplayerdata( level.var_6f9b00680ed002d8, "dmzBankedCash" );
        player setplayerdata( level.var_6f9b00680ed002d8, "dmzBankedCash", var_9ebee770c4d8cd27 + totalcash );
        weaponitem = undefined;
        
        if ( weaponslotid )
        {
            weaponitem = spawnstruct();
            weaponitem.lootid = weaponslotid;
            weaponitem.quantity = 1;
            var_7561a7f44b738d86[ var_7561a7f44b738d86.size ] = weaponitem;
        }
        
        if ( !self.noweaponslot )
        {
            player setclientomnvar( "loot_container_weapon", 0 );
        }
        
        player.ballooncontents = undefined;
    }
}

// Namespace balloon_extract
// Params 0
// Checksum 0x96ac6eb5, Offset: 0xa1d
// Size: 0x12
function function_4bd8c4bf5c27edcb()
{
    return [[ level.var_d98e7957aed6acf1 ]]( "wm_skyhook_ground_open" );
}

// Namespace balloon_extract
// Params 0
// Checksum 0x9c0935a0, Offset: 0xa38
// Size: 0x12
function function_95cb706afbd1b79e()
{
    return [[ level.var_d98e7957aed6acf1 ]]( "wm_skyhook_ground_takeoff" );
}

// Namespace balloon_extract
// Params 2
// Checksum 0xfc2bf542, Offset: 0xa53
// Size: 0x8e
function function_41ac6da0360a6efa( grenade, stuckto )
{
    if ( isdefined( stuckto.linked_brush ) )
    {
        if ( isdefined( stuckto.linked_brush.targetname ) )
        {
            if ( stuckto.linked_brush.targetname == "train_wz" )
            {
                grenade.moving_platform = stuckto;
            }
        }
        
        return;
    }
    
    if ( stuckto.targetname == "train_wz" )
    {
        grenade.moving_platform = stuckto;
    }
}

// Namespace balloon_extract
// Params 0
// Checksum 0x57554df, Offset: 0xae9
// Size: 0x7c
function function_e6d9f4db1a668b68()
{
    self setweaponammoclip( self.super.staticdata.weapon, 1 );
    self notify( #"hash_3cabba3d61f1d3be" );
    self notify( #"super_use_finished" );
    superinfo = supers_mp::getcurrentsuper();
    supers_mp::setsuperisinuse( 0 );
    supers_mp::setsuperexpended( 0 );
    superinfo.wasrefunded = 1;
    supers_mp::setsuperbasepoints( supers_mp::getsuperpointsneeded() );
}

// Namespace balloon_extract
// Params 1
// Checksum 0x92d21aa4, Offset: 0xb6d
// Size: 0xb0, Type: bool
function function_a111149bd405d1cf( grenade )
{
    var_ac4b2840d73fab5a = 25;
    planeflyheight = parachute::getc130height();
    start = grenade.origin + ( 0, 0, var_ac4b2840d73fab5a + 1 );
    end = ( grenade.origin[ 0 ], grenade.origin[ 1 ], planeflyheight );
    contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 0 );
    trc = trace::sphere_trace( start, end, var_ac4b2840d73fab5a, grenade, contents );
    return trc[ "fraction" ] == 1;
}

// Namespace balloon_extract
// Params 1
// Checksum 0x7af7d0d, Offset: 0xc26
// Size: 0xcd
function function_f9274c3d2a5b23e8( contents )
{
    contentsarray = [];
    
    foreach ( key, item in contents )
    {
        contentsarray[ key ] = spawnstruct();
        contentsarray[ key ].lootid = item[ "lootID" ];
        contentsarray[ key ].quantity = item[ "quantity" ];
        contentsarray[ key ].index = item[ "index" ];
    }
    
    return contentsarray;
}

// Namespace balloon_extract
// Params 2
// Checksum 0x6c9c130, Offset: 0xcfc
// Size: 0x2c9
function function_9a4e592232b043e2( itemtype, itemindex )
{
    switch ( itemtype )
    {
        case 0:
            return [ 8395, 5 ];
        case 1:
            if ( itemindex == 2 )
            {
                if ( !common_inventory::function_d33e11a8dda3cb20() )
                {
                    return [ 0, 0, undefined ];
                }
                
                lootid = self getplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "lootItemID" );
                var_f7cb5f756a346f4a = common_inventory::function_7bf60ff8870e96b4();
                return [ lootid, 1, var_f7cb5f756a346f4a ];
            }
            
            var_f7cb5f756a346f4a = br_pickups::function_5ef22d170cdde55e( self, itemindex );
            
            if ( !isdefined( var_f7cb5f756a346f4a ) )
            {
                return [ 0, 0, undefined ];
            }
            
            lootid = weapon::getweaponlootid( var_f7cb5f756a346f4a );
            return [ lootid, 1, var_f7cb5f756a346f4a ];
        case 10:
            lootid = common_inventory::inventory_getlootidatbackpackindex( itemindex );
            quantity = 1;
            
            if ( br_pickups::function_bcc6dc9b2b7365e0( lootid ) )
            {
                quantity = common_inventory::inventory_getquantityatbackpackindex( itemindex );
            }
            
            return [ lootid, quantity ];
        case 2:
            slot = equipment_mp::function_b1928e5713e81b5e( itemindex );
            
            if ( !isdefined( self.equipment[ slot ] ) )
            {
                return [ 0, 0 ];
            }
            
            var_f7e41c4e8421f7d3 = function_f02c63b99c9614c9( level.br_pickups.br_equipname, self.equipment[ slot ] );
            lootid = loot::function_d3e3bcaea591a6a2( var_f7e41c4e8421f7d3 );
            return [ lootid, 1 ];
        case 3:
            if ( !isdefined( self.streakdata.streaks[ 1 ] ) )
            {
                return [ 0, 0 ];
            }
            
            scriptable = level.br_pickups.var_5515c706eaccd3[ self.streakdata.streaks[ 1 ].streakname ];
            lootid = loot::function_d3e3bcaea591a6a2( scriptable );
            return [ lootid, 1 ];
        case 4:
            if ( !isdefined( self.equipment[ "super" ] ) )
            {
                return [ 0, 0 ];
            }
            
            var_f7e41c4e8421f7d3 = function_f02c63b99c9614c9( level.br_pickups.br_equipname, self.equipment[ "super" ] );
            lootid = loot::function_d3e3bcaea591a6a2( var_f7e41c4e8421f7d3 );
            return [ lootid, 1 ];
        default:
            assertmsg( "<dev string:x7e>" + itemtype );
            return;
    }
}

// Namespace balloon_extract
// Params 1
// Checksum 0xc42a21e6, Offset: 0xfcd
// Size: 0x1a4
function function_2eff985fc85715f6( players )
{
    if ( players.size <= 0 )
    {
        level notify( #"balloon_extract_takeoff" );
        return;
    }
    
    if ( !isdefined( level.var_fba02d97c58e7ed4 ) )
    {
        level.var_fba02d97c58e7ed4 = [];
    }
    
    if ( isdefined( level.var_fba02d97c58e7ed4[ self.team ] ) )
    {
        level.var_fba02d97c58e7ed4[ self.team ] notify( #"hash_9edafecf67a4af00" );
    }
    
    level.var_fba02d97c58e7ed4[ self.team ] = self;
    self endon( #"hash_9edafecf67a4af00" );
    level endon( #"game_ended" );
    currenttime = gettime();
    endtime = currenttime + 30000;
    
    while ( currenttime < endtime )
    {
        if ( gettime() - currenttime >= 1000 )
        {
            msgvalue = int( max( 0, ( endtime - gettime() ) / 1000 ) );
            
            foreach ( player in players )
            {
                if ( isalive( player ) && !player br_public::isplayeringulag() )
                {
                    player hud_message::showerrormessage( %"mp/balloon_extract_leaving_in", msgvalue );
                }
            }
            
            currenttime = gettime();
        }
        
        wait 0.05;
    }
    
    if ( isdefined( self ) )
    {
        level.var_fba02d97c58e7ed4[ self.team ] = undefined;
    }
}

// Namespace balloon_extract
// Params 2
// Checksum 0x10be7c00, Offset: 0x1179
// Size: 0x64, Type: bool
function function_f5df9215d8f4efa4( itemtype, lootid )
{
    if ( itemtype == 1 )
    {
        return true;
    }
    
    scriptablename = loot::getScriptableFromLootID( lootid );
    
    if ( scriptablename == "brloot_durable_loot" || isdefined( level.dogtagscriptables ) && arraycontains( level.dogtagscriptables, scriptablename ) )
    {
        return true;
    }
    
    return false;
}

// Namespace balloon_extract
// Params 1
// Checksum 0xa99583b8, Offset: 0x11e6
// Size: 0xab
function function_9580ae29ca4bd565( player )
{
    var_bcee63ad8a80f020 = player common_inventory::function_9cd65c8312048802();
    extracteditem = 0;
    
    for ( i = 0; i < var_bcee63ad8a80f020 ; i++ )
    {
        slotlootid = player common_inventory::inventory_getlootidatbackpackindex( i );
        
        if ( !isdefined( slotlootid ) )
        {
            continue;
        }
        
        lootname = common_inventory::function_a7a3fe2f2b6b7582( slotlootid );
        
        if ( !isdefined( lootname ) )
        {
            continue;
        }
        
        if ( lootname == "brloot_durable_loot" )
        {
            player function_e78151d385b23c9a( i );
            extracteditem = 1;
            return;
        }
    }
    
    if ( extracteditem )
    {
        player namespace_5f4bb62dbf67ff87::doonactionscoreevent( 1, "extractionBalloonDeposit" );
    }
}

// Namespace balloon_extract
// Params 1
// Checksum 0x3d1754f1, Offset: 0x1299
// Size: 0x23
function function_e78151d385b23c9a( slotnum )
{
    thread common_inventory::function_4f226d9d5d61901e( slotnum, 1 );
    thread hud_message::showsplash( "br_durable_loot_item_extracted" );
}

