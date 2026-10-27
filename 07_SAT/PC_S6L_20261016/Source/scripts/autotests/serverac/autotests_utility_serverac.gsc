// scripts\autotests\serverac\autotests_utility_serverac.gsc  (hash_1c11c2bfe421dedc.gscc) (size: 14439 Bytes / 0x3867 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd17f797 (219674519)
// size ...... 14439 (0x3867)
// includes .. 14  (offset: 0x333f)
// strings ... 72  (offset: 0x33af)
// dev strs .. 17  (offset: 0x378b)
// exports ... 23  (offset: 0x242b)
// cseg ...... 0x7a9 + 0x1c82 (0x242b)
// imports ... 86  (offset: 0x27c3)
// animtree1 . 0   (offset: 0x3867)
// animtree2 . 0   (offset: 0x3867)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_player;
#using scripts\autotests\autotests_utility_scriptables;
#using scripts\autotests\mp\autotests_utility_content;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\dev;
#using scripts\mp\loot\common_item;

#namespace autotests_utility_serverac;

// Namespace autotests_utility_serverac
// Params 1, eflags: 0x4
// Checksum 0xc28387d7, Offset: 0x7c7
// Size: 0x1c
function private serverac_print( msg )
{
    println( "<dev string:x24>" + msg );
}

// Namespace autotests_utility_serverac
// Params 0
// Checksum 0xab61ffa6, Offset: 0x7eb
// Size: 0x31e
function test_setup()
{
    var_ac1febe8503ca3d4 = 2;
    
    while ( level.players.size < var_ac1febe8503ca3d4 )
    {
        wait 1;
    }
    
    var_69a85af2ec510fd0 = 0;
    var_2ef2dcdf839644de = 0;
    playersspawned = [];
    
    while ( !var_69a85af2ec510fd0 )
    {
        foreach ( player in level.players )
        {
            if ( !player.hasspawned )
            {
                break;
            }
            
            playersspawned[ var_2ef2dcdf839644de ] = player;
            var_2ef2dcdf839644de++;
            
            if ( var_2ef2dcdf839644de >= var_ac1febe8503ca3d4 )
            {
                var_69a85af2ec510fd0 = 1;
            }
        }
        
        wait 1;
    }
    
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Players found?", playersspawned, "scripts/autotests/serverac/autotests_utility_serverac.gsc", 92 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Player 1 found?", playersspawned[ 0 ], "scripts/autotests/serverac/autotests_utility_serverac.gsc", 93 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Player 2 found?", playersspawned[ 1 ], "scripts/autotests/serverac/autotests_utility_serverac.gsc", 94 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    if ( isbot( playersspawned[ 0 ] ) && !isbot( playersspawned[ 1 ] ) )
    {
        temp = playersspawned[ 0 ];
        playersspawned[ 0 ] = playersspawned[ 1 ];
        playersspawned[ 1 ] = temp;
    }
    
    foreach ( player in playersspawned )
    {
        if ( isbot( player ) )
        {
            player function_3a7598d6982eb648( 1 );
        }
    }
    
    level.autotests.test_runtime.player1 = playersspawned[ 0 ];
    level.autotests.test_runtime.player2 = playersspawned[ 1 ];
    level.autotests.test_runtime.testplayers = playersspawned;
    offset = 0;
    
    foreach ( player in playersspawned )
    {
        player.var_976d61c8b7b2c70e = ( offset, 0, 0 );
        offset += 30;
    }
    
    return 0;
}

// Namespace autotests_utility_serverac
// Params 2, eflags: 0x4
// Checksum 0xbc800375, Offset: 0xb12
// Size: 0x6b
function private function_8e7d72203172adad( attacker, mitigation )
{
    attacker function_2ce35403a16a495e( mitigation );
    attacker.spawnprotection = 1;
    attacker thread function_71902e5e9c51721c();
    attacker function_ffb0711adb6d8d0d();
    wait 0.1;
    attacker function_3a7598d6982eb648( 1 );
    serverac_print( "Attacker setup complete: mitigation( " + mitigation + " ) + god mode + autopilot applied to " + attacker.name );
}

// Namespace autotests_utility_serverac
// Params 2, eflags: 0x4
// Checksum 0xbe2d8363, Offset: 0xb85
// Size: 0x5f
function private function_fdda98ad19fdad94( attacker, mitigation )
{
    attacker notify( #"hash_8e22188f5b00eea6" );
    attacker playerexitautopilotmode();
    attacker.spawnprotection = 0;
    attacker function_e3339b3b54abf4a5( mitigation );
    serverac_print( "Attacker teardown complete: mitigation( " + mitigation + " ) + god mode + autopilot removed from " + attacker.name );
}

// Namespace autotests_utility_serverac
// Params 0, eflags: 0x4
// Checksum 0x275a036a, Offset: 0xbec
// Size: 0x54
function private function_71902e5e9c51721c()
{
    self endon( #"disconnect" );
    self endon( #"hash_8e22188f5b00eea6" );
    player = self;
    
    for ( ;; )
    {
        self waittill( #"death" );
        level waittill( #"player_spawned", player );
        self function_ffb0711adb6d8d0d();
        self function_3a7598d6982eb648( 1 );
    }
}

// Namespace autotests_utility_serverac
// Params 1
// Checksum 0x880058ba, Offset: 0xc48
// Size: 0x8b, Type: bool
function function_ffa6a2f7eac3c7a4( player )
{
    current_weapon = player getcurrentweapon();
    var_b830706d0d69bc5a = weapon::getweapongroup( current_weapon );
    var_9aef7ce90509ebc2 = var_b830706d0d69bc5a == "weapon_melee" || var_b830706d0d69bc5a == "weapon_melee2";
    var_7b92b568a7f91fc1 = weapon::isfistweapon( current_weapon );
    isnoneweapon = getweaponbasename( current_weapon ) == "none";
    
    if ( var_9aef7ce90509ebc2 || var_7b92b568a7f91fc1 || isnoneweapon )
    {
        return true;
    }
    
    return false;
}

// Namespace autotests_utility_serverac
// Params 1
// Checksum 0x8eee3132, Offset: 0xcdc
// Size: 0x274, Type: bool
function function_a4e48481317ca099( players )
{
    assert( players.size >= 2, "<dev string:x36>" );
    player1 = players[ 0 ];
    player2 = players[ 1 ];
    
    if ( player1.team == player2.team )
    {
        foreach ( player in players )
        {
            if ( player1.team != player.team )
            {
                player2 = player;
                break;
            }
        }
    }
    
    player1 function_2ce35403a16a495e( 1 );
    serverac_print( "Applied Damage Mitigate to " + player1.name );
    
    if ( weapon::getweapongroup( player1.primaryweapon ) == "weapon_sniper" )
    {
        player1 switchtoweaponimmediate( player1.secondaryweapon );
    }
    else
    {
        player1 switchtoweaponimmediate( player1.primaryweapon );
    }
    
    wait 1;
    
    if ( function_ffa6a2f7eac3c7a4( player1 ) )
    {
        weaponnames = autotests_utility::function_fc09add23c4398c1( "ar" );
        
        if ( !isdefined( weaponnames ) )
        {
            assertmsg( "<dev string:x69>" );
        }
        else
        {
            weapon_name = weaponnames[ 0 ];
            weaponobj = weapon::buildweapon( weapon_name );
            
            if ( !isdefined( weaponobj ) )
            {
                assertmsg( "<dev string:x9e>" + weapon_name + "<dev string:xa6>" );
            }
            else
            {
                player1 giveweapon( weaponobj, 0, 0, 0, 1, 1 );
            }
        }
    }
    
    /#
        if ( dev_mp::function_79f8301425abd200( player1 ) )
        {
            player1 val::reset_all( "<dev string:xb2>" );
        }
    #/
    
    wait 1;
    var_d1a5e5d4bb6fe9df = player2 getplayerangles();
    player1 autotests_utility_player::set_player_location( player2, 60, anglestoforward( var_d1a5e5d4bb6fe9df ) );
    wait 1;
    player1 autotests_utility_player::function_a29ba7836e10842e( player2, ( 0, 0, 0 ) );
    wait 1;
    victimdied = 0;
    victimdied = autotests_utility_player::function_46f72ef9b143f2f1( player1, player2 );
    
    /#
        if ( dev_mp::function_79f8301425abd200( player1 ) )
        {
            player1 val::set( "<dev string:xb2>", "<dev string:xc1>", 0 );
        }
    #/
    
    if ( victimdied )
    {
        assertmsg( "<dev string:xc6>" );
        return true;
    }
    
    return false;
}

// Namespace autotests_utility_serverac
// Params 1
// Checksum 0xa83a2c18, Offset: 0xf59
// Size: 0x44d, Type: bool
function function_e17c9be06527a2bc( players )
{
    assert( players.size >= 2, "<dev string:xf7>" );
    attacker = players[ 0 ];
    victim = players[ 1 ];
    
    if ( attacker.team == victim.team )
    {
        foreach ( player in players )
        {
            if ( attacker.team != player.team )
            {
                victim = player;
                break;
            }
        }
    }
    
    var_312992579532e304 = [ "equip_frag", "equip_combataxe", "equip_semtex", "equip_sticky_grenade" ];
    stickylethals = [ "equip_combataxe", "equip_semtex", "equip_sticky_grenade" ];
    serverac_print( "Lethal test: Setting up attacker " + attacker.name );
    function_8e7d72203172adad( attacker, 1 );
    wait 1;
    
    foreach ( lethalref in var_312992579532e304 )
    {
        if ( !isdefined( level.equipment.table[ lethalref ] ) )
        {
            serverac_print( "Lethal " + lethalref + " not in equipment table, skipping." );
            continue;
        }
        
        serverac_print( "Testing lethal mitigation: " + lethalref );
        var_e3003f9351311ad0 = victim.health;
        victimangles = victim getplayerangles();
        attacker autotests_utility_player::set_player_location( victim, 250, anglestoforward( victimangles ) );
        attacker setplayerangles( vectortoangles( victim gettagorigin( "j_spine4" ) - attacker geteye() ) );
        wait 0.5;
        attacker utility::callsharedfunc( #"equipment", #"hash_54e1244070e4625c", lethalref, "primary" );
        wait 0.5;
        lethalinfo = level.equipment.table[ lethalref ];
        issticky = arraycontains( stickylethals, lethalref );
        
        if ( !issticky )
        {
            attacker thread function_a31581acba6f06e( victim.origin, ( 0, 0, 20 ) );
        }
        
        attacker botpressbutton( "lethal", 0.5 );
        fusetime = 0;
        
        if ( isdefined( lethalinfo.objweapon ) )
        {
            rawfuse = getgrenadefusetime( lethalinfo.objweapon );
            
            if ( isdefined( rawfuse ) && rawfuse > 0 )
            {
                fusetime = rawfuse / 1000;
            }
        }
        
        wait fusetime + 2;
        
        if ( !isalive( victim ) )
        {
            assertmsg( "<dev string:x131>" + lethalref + "<dev string:x155>" );
            function_fdda98ad19fdad94( attacker, 1 );
            return true;
        }
        
        alloweddamage = getdvarint( @"hash_c02ee33d016d32e6", 0 );
        
        if ( alloweddamage == 0 && victim.health < var_e3003f9351311ad0 )
        {
            damagetaken = var_e3003f9351311ad0 - victim.health;
            serverac_print( "Lethal " + lethalref + " dealt " + damagetaken + " damage to victim. Mitigation Failed." );
            assertmsg( "<dev string:x170>" + damagetaken + "<dev string:x188>" + lethalref + "<dev string:x19d>" );
            function_fdda98ad19fdad94( attacker, 1 );
            return true;
        }
        
        serverac_print( "Lethal " + lethalref + " mitigation OK. Victim alive." );
        victim.health = victim.maxhealth;
        wait 0.5;
    }
    
    function_fdda98ad19fdad94( attacker, 1 );
    serverac_print( "Lethal Damage Mitigation test passed." );
    return false;
}

// Namespace autotests_utility_serverac
// Params 2, eflags: 0x4
// Checksum 0x1ba35aa6, Offset: 0x13af
// Size: 0x6a
function private function_a31581acba6f06e( location, offset = ( 0, 0, 20 ) )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self waittill( #"grenade_fire", grenade );
    grenade.origin = location + offset;
}

// Namespace autotests_utility_serverac
// Params 3
// Checksum 0x63810dd7, Offset: 0x1421
// Size: 0x247, Type: bool
function function_bbcca9e23639037c( players, ignoredkillstreaks, var_bd7847d9c87fa03b )
{
    assert( players.size >= 2, "<dev string:x1e8>" );
    attacker = players[ 0 ];
    victim = players[ 1 ];
    
    if ( attacker.team == victim.team )
    {
        foreach ( player in players )
        {
            if ( attacker.team != player.team )
            {
                victim = player;
                break;
            }
        }
    }
    
    killstreakrefs = function_f49fc52b8cd7974c();
    
    if ( !isdefined( killstreakrefs ) || killstreakrefs.size == 0 )
    {
        serverac_print( "No killstreaks found. Skipping killstreak mitigation test." );
        return false;
    }
    
    killstreakslot = 0;
    
    if ( isbrgamemode() )
    {
        killstreakslot = 1;
    }
    
    serverac_print( "Killstreak test: Setting up attacker " + attacker.name );
    function_8e7d72203172adad( attacker, 1 );
    
    foreach ( killstreakref in killstreakrefs )
    {
        if ( !arraycontains( var_bd7847d9c87fa03b, killstreakref ) )
        {
            serverac_print( "Killstreak " + killstreakref + " is not in the known good list, skipping." );
            continue;
        }
        
        if ( arraycontains( ignoredkillstreaks, killstreakref ) )
        {
            serverac_print( "Killstreak " + killstreakref + " is in the ignore list, skipping." );
            continue;
        }
        
        result = attacker function_b7ffc85ac735170c( killstreakref, victim, killstreakslot );
        
        if ( result == 1 )
        {
            function_fdda98ad19fdad94( attacker, 1 );
            return true;
        }
    }
    
    function_fdda98ad19fdad94( attacker, 1 );
    serverac_print( "Killstreak Damage Mitigation test passed." );
    return false;
}

// Namespace autotests_utility_serverac
// Params 1, eflags: 0x4
// Checksum 0x9ee27ef9, Offset: 0x1671
// Size: 0x1dc
function private _setup_killstreak( killstreakref )
{
    if ( isbrgamemode() && !common_item::items_isenabled() )
    {
        killstreaks::awardkillstreak( killstreakref, "other", undefined, undefined, undefined, 1 );
        wait 0.5;
    }
    else
    {
        equipresult = autotests_utility_content::equipcontent( self, killstreakref );
        
        if ( !equipresult.result )
        {
            return;
        }
    }
    
    killstreakslot = isbrgamemode() || common_item::items_isenabled() ? 1 : 0;
    streakitem = killstreaks::getkillstreakinslot( killstreakslot );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Killstreak " + killstreakref + " equipped?", streakitem, "scripts/autotests/serverac/autotests_utility_serverac.gsc", 591 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    if ( !isdefined( streakitem ) || !streakitem.available )
    {
        autotests::report_info( "Killstreak unavailable: " + streakitem.streakname );
        return;
    }
    
    var_17180d6e00540903 = killstreaks::getkillstreaksetupinfo( streakitem.streakname );
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Found in level.killstreakSetups?", var_17180d6e00540903, "scripts/autotests/serverac/autotests_utility_serverac.gsc", 600 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e4dbfc06e59fa0cb( "Found in level.streakGlobals.streakIndexByRef?", killstreak_utility::getkillstreakindex( streakitem.streakname ), -1, "scripts/autotests/serverac/autotests_utility_serverac.gsc", 601 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    serverac_print( "Killstreak setup OK: " + killstreakref );
    setup = spawnstruct();
    setup.killstreakslot = killstreakslot;
    setup.streakitem = streakitem;
    return setup;
}

// Namespace autotests_utility_serverac
// Params 1, eflags: 0x4
// Checksum 0xf8ff41f0, Offset: 0x1856
// Size: 0x352
function private function_95d69564b101f0a7( streakitem )
{
    weaponname = streakitem.streaksetupinfo.weaponname;
    serverac_print( "Using killstreak weapon handling logic: " + weaponname );
    
    if ( self.currentweapon.basename == weaponname )
    {
        autotests::report_info( "Killstreak Weapon Equipped" );
    }
    else
    {
        utility::waittill_any_timeout( 2, "weapon_change" );
        wait 2;
    }
    
    thread force_ads( self );
    ammoinclip = self getcurrentweaponclipammo();
    weapon = self getcurrentweapon();
    clipcount = self getweaponammostock( weapon ) + 1;
    var_d644ecc40ed007f1 = weaponisauto( weapon );
    firetime = weaponfiretime( weapon );
    pressduration = function_f51fd80a47c20b1b( weaponname );
    var_6320808f07ece387 = undefined;
    serverac_print( "Total clips: " + clipcount + " ammoInClip: " + ammoinclip + " auto? " + var_d644ecc40ed007f1 + " fireTime: " + firetime );
    
    for ( clip = 0; clip < clipcount ; clip++ )
    {
        if ( clip > 0 )
        {
            var_128561c5ead9d55e = gettime();
            
            while ( self getcurrentweaponclipammo() <= 0 && gettime() - var_128561c5ead9d55e < 10000 )
            {
                waitframe();
            }
            
            if ( self getcurrentweapon().basename != weaponname || self getcurrentweaponclipammo() <= 0 )
            {
                serverac_print( "Launcher not ready for clip " + clip + ", stopping." );
                break;
            }
        }
        
        if ( var_d644ecc40ed007f1 )
        {
            var_b89a0a28a5ce3891 = ammoinclip * firetime + 5;
            self botpressbutton( "ATTACK", var_b89a0a28a5ce3891 );
            var_6320808f07ece387 = utility::waittill_any_timeout( var_b89a0a28a5ce3891, "weapon_switch_started" );
            self botclearbutton( "ATTACK" );
            continue;
        }
        
        retrycount = 0;
        
        for ( curshot = 0; curshot < ammoinclip ; curshot++ )
        {
            expectedammo = self getcurrentweaponclipammo() - 1;
            self botpressbutton( "ATTACK", pressduration );
            utility::waittill_any_timeout( pressduration + 1, "weapon_fired" );
            self botclearbutton( "ATTACK" );
            wait firetime + level.framedurationseconds;
            pollstart = gettime();
            
            while ( self getcurrentweaponclipammo() > expectedammo && gettime() - pollstart < 1000 )
            {
                wait 0.05;
            }
            
            if ( self getcurrentweaponclipammo() > expectedammo )
            {
                retrycount++;
                
                if ( retrycount >= 3 )
                {
                    serverac_print( "Shot " + curshot + " failed after 3 retries, stopping" );
                    break;
                }
                
                serverac_print( "Shot " + curshot + " failed (ammo=" + self getcurrentweaponclipammo() + "), retry " + retrycount );
                curshot--;
                continue;
            }
            
            retrycount = 0;
        }
        
        serverac_print( "The weapon " + weaponname + " had remaining ammo in clip: " + self getcurrentweaponclipammo() );
    }
    
    self notify( #"stop_ads" );
    
    if ( var_d644ecc40ed007f1 && var_6320808f07ece387 != "weapon_switch_started" )
    {
        var_63a718d91714219d = autotests::function_e50d1006e5d65c04( "Shot all ammo?", self getcurrentweaponclipammo(), 0, "scripts/autotests/serverac/autotests_utility_serverac.gsc", 729 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
}

// Namespace autotests_utility_serverac
// Params 3, eflags: 0x4
// Checksum 0x366eb03c, Offset: 0x1bb0
// Size: 0x2ad
function private function_b7ffc85ac735170c( killstreakref, victim, killstreakslot )
{
    attacker = self;
    setup = attacker _setup_killstreak( killstreakref );
    
    if ( !isdefined( setup ) )
    {
        return 5;
    }
    
    killstreakslot = setup.killstreakslot;
    streakitem = setup.streakitem;
    attackerangles = attacker getplayerangles();
    victim function_d8783c17de5388f6( attacker.origin, anglestoforward( attackerangles ), 750 );
    wait 0.5;
    
    if ( !function_ae90d122cb506ad( attacker, streakitem ) )
    {
        attacker thread function_f55f36002704f7f0( victim );
    }
    
    var_e3003f9351311ad0 = victim.health;
    attacker thread monitor_trigger_killstreak( streakitem, killstreakslot );
    wait 1;
    
    if ( isdefined( streakitem.streaksetupinfo ) && level.var_4295719b442b453d[ streakitem.streaksetupinfo.weaponname ] )
    {
        serverac_print( "Firing logic killstreak: " + killstreakref );
        attacker function_95d69564b101f0a7( streakitem );
    }
    else
    {
        serverac_print( "Deploy-type killstreak: " + killstreakref );
        handle_killstreak_use( attacker, streakitem );
    }
    
    starttime = gettime();
    
    while ( streakitem.available != 0 && gettime() - starttime < 15000 )
    {
        wait 0.5;
    }
    
    endtime = gettime();
    var_e4e5c88c91cdb304 = endtime - starttime;
    serverac_print( "Killstreak " + killstreakref + " resolved in: " + var_e4e5c88c91cdb304 + "ms" );
    attacker notify( #"hash_a047ce162160299" );
    
    if ( !isalive( victim ) )
    {
        assertmsg( "<dev string:x226>" + killstreakref + "<dev string:x155>" );
        return 1;
    }
    
    alloweddamage = getdvarint( @"hash_c02ee33d016d32e6", 0 );
    
    if ( alloweddamage == 0 && victim.health < var_e3003f9351311ad0 )
    {
        damagetaken = var_e3003f9351311ad0 - victim.health;
        serverac_print( "Killstreak " + killstreakref + " dealt " + damagetaken + " damage to victim. Mitigation Failed." );
        assertmsg( "<dev string:x170>" + damagetaken + "<dev string:x24e>" + killstreakref + "<dev string:x19d>" );
        return 1;
    }
    
    serverac_print( "Killstreak " + killstreakref + " mitigation OK. Victim alive." );
    victim.health = victim.maxhealth;
    wait 0.5;
    autotests_utility_scriptables::function_9902d3be8a6f6a01( attacker );
    cleanup_killstreaks( attacker, streakitem );
    return 0;
}

// Namespace autotests_utility_serverac
// Params 1, eflags: 0xc
// Checksum 0xfd89fb28, Offset: 0x1e66
// Size: 0x52
function private force_ads( attacker )
{
    self notify( #"hash_853e888783452a44" );
    self endon( #"hash_853e888783452a44" );
    level endon( #"end_test" );
    attacker endon( #"stop_ads" );
    
    while ( true )
    {
        attacker botpressbutton( "ADS" );
        waitframe();
    }
}

// Namespace autotests_utility_serverac
// Params 2, eflags: 0xc
// Checksum 0xea1ad452, Offset: 0x1ec0
// Size: 0xc4
function private monitor_trigger_killstreak( streakitem, killstreakslot )
{
    self notify( #"hash_84165e512e64cca" );
    self endon( #"hash_84165e512e64cca" );
    level endon( #"end_test" );
    level endon( #"test_finished" );
    serverac_print( "Triggering killstreak: " + streakitem.streakname + " in slot " + killstreakslot );
    result = killstreaks::triggerkillstreak( streakitem, killstreakslot );
    wait 0.2;
    
    if ( !result )
    {
        var_63a718d91714219d = autotests::function_d84657f448aaeef6( "Killstreak failed to trigger", 0, "scripts/autotests/serverac/autotests_utility_serverac.gsc", 865 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
}

// Namespace autotests_utility_serverac
// Params 2, eflags: 0x4
// Checksum 0x715a2afb, Offset: 0x1f8c
// Size: 0x5f, Type: bool
function private function_ae90d122cb506ad( attacker, streakitem )
{
    switch ( streakitem.streakname )
    {
        case #"hash_b0491209df7b4b5c":
            attackerangles = attacker getplayerangles();
            attacker setplayerangles( ( 45, attackerangles[ 1 ], attackerangles[ 2 ] ) );
            return true;
    }
    
    return false;
}

// Namespace autotests_utility_serverac
// Params 1, eflags: 0x4
// Checksum 0xc49a9239, Offset: 0x1ff4
// Size: 0x3f
function private function_f51fd80a47c20b1b( weaponname )
{
    switch ( weaponname )
    {
        case #"hash_bdec0638bdbef471":
            return 2;
        case #"hash_2af86d97d9c03afa":
            return 1;
    }
    
    return 0.1;
}

// Namespace autotests_utility_serverac
// Params 2, eflags: 0x4
// Checksum 0xa93fbc89, Offset: 0x203c
// Size: 0x117
function private handle_killstreak_use( attacker, streakitem )
{
    switch ( streakitem.streakname )
    {
        case #"hash_ab5712e297cd430e":
            attacker botpressbutton( "ATTACK", 2 );
            attacker utility::waittill_any_timeout( 5, "owner_place_successful" );
            turret = undefined;
            
            if ( isdefined( attacker.placedsentries ) )
            {
                turret = attacker.placedsentries[ "remote_turret" ][ 0 ];
            }
            
            if ( isdefined( turret ) )
            {
                result = turret utility::waittill_any_timeout( 20, "remote_sentry_death" );
                
                if ( result != "remote_sentry_death" )
                {
                    serverac_print( "Attempting to clean up remote_turret early" );
                    turret notify( #"kill_turret", 0, 0, 0, 0 );
                    turret utility::waittill_any_timeout( 3, "remote_sentry_death" );
                }
            }
            
            break;
        default:
            attacker botpressbutton( "ADS", 2 );
            attacker botpressbutton( "ATTACK", 2 );
            break;
    }
}

// Namespace autotests_utility_serverac
// Params 1, eflags: 0x4
// Checksum 0x947f0a5c, Offset: 0x215b
// Size: 0x70
function private function_f55f36002704f7f0( target )
{
    self endon( #"hash_a047ce162160299" );
    self endon( #"hash_8e22188f5b00eea6" );
    self endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"end_test" );
    
    while ( isalive( target ) )
    {
        self setplayerangles( vectortoangles( target gettagorigin( "j_spine4" ) - self geteye() ) );
        waitframe();
    }
}

// Namespace autotests_utility_serverac
// Params 3, eflags: 0x4
// Checksum 0xa7180da1, Offset: 0x21d3
// Size: 0x7a
function private function_d8783c17de5388f6( baseorigin, direction, distance )
{
    targetpos = baseorigin + direction * distance;
    navmeshpos = utility::function_5918594658d3ffba( targetpos );
    
    if ( isdefined( navmeshpos ) )
    {
        self setorigin( navmeshpos );
        return;
    }
    
    groundpos = utility::drop_to_ground( targetpos );
    
    if ( isdefined( groundpos ) )
    {
        self setorigin( groundpos );
        return;
    }
    
    self setorigin( baseorigin );
}

// Namespace autotests_utility_serverac
// Params 0, eflags: 0x4
// Checksum 0xeb35fbec, Offset: 0x2255
// Size: 0xd1
function private function_f49fc52b8cd7974c()
{
    datasource = level.killstreakbundles ?? level.streakglobals.streakbundles ?? level.streakglobals;
    
    if ( !isdefined( datasource ) )
    {
        return;
    }
    
    availablerefs = [];
    
    foreach ( killstreakname, value in datasource )
    {
        if ( isdefined( value ) && value.var_883566fc1e9d2da3 )
        {
            availablerefs[ availablerefs.size ] = killstreakname;
        }
    }
    
    return availablerefs;
}

// Namespace autotests_utility_serverac
// Params 2, eflags: 0x4
// Checksum 0x7fe58106, Offset: 0x232f
// Size: 0xfc
function private cleanup_killstreaks( player, streakitem )
{
    player killstreakdeploy::streakdeploy_cancelalldeployments();
    
    switch ( streakitem.streakname )
    {
        case #"hash_a34aaabd92f0ff28":
            if ( player.fireteam )
            {
                foreach ( agent in player.fireteam )
                {
                    if ( isalive( agent ) )
                    {
                        agent notify( #"merc_killed" );
                        wait 0.05;
                        
                        if ( isalive( agent ) )
                        {
                            agent kill( player.origin, player );
                        }
                    }
                }
                
                wait 1;
            }
            
            break;
    }
}

