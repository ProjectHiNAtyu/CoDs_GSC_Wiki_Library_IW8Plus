// script_27e384438583cde4  (hash_27e384438583cde4.gscc) (size: 9271 Bytes / 0x2437 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdbe85789 (3689437065)
// size ...... 9271 (0x2437)
// includes .. 14  (offset: 0x22a3)
// strings ... 18  (offset: 0x2313)
// dev strs .. 1   (offset: 0x242b)
// exports ... 24  (offset: 0x15e3)
// cseg ...... 0x21d + 0x13c6 (0x15e3)
// imports ... 78  (offset: 0x19a3)
// animtree1 . 0   (offset: 0x2437)
// animtree2 . 0   (offset: 0x2437)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\bots\bots;
#using scripts\mp\challenges;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\weapons;

#namespace specialty_scavenger;

// Namespace specialty_scavenger
// Params 0, eflags: 0x1
// Checksum 0x7619b1f4, Offset: 0x23b
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_scavenger
// Params 1
// Checksum 0x297b78c, Offset: 0x25b
// Size: 0x48
function registerspecialty( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_scavenger", &setscavenger, &unsetscavenger, [ "specialty_scavenger_equipment" ], &initscavenger );
    }
}

// Namespace specialty_scavenger
// Params 0
// Checksum 0x7e1d2f2b, Offset: 0x2ab
// Size: 0x5c
function initscavenger()
{
    utility::registersharedfunc( #"specialty_scavenger", #"hash_85a3d8cefcd3611c", &function_af82b7da2cc3dc15 );
    utility::registersharedfunc( #"specialty_scavenger", #"hash_191a928603952db2", &scavengergiveammo );
    utility::registersharedfunc( #"specialty_scavenger", #"dropscavengerfordeath", &dropscavengerfordeath );
}

// Namespace specialty_scavenger
// Params 0
// Checksum 0xda46a5d9, Offset: 0x30f
// Size: 0x383
function setscavenger()
{
    if ( !self.var_9842326056fd7207 )
    {
        self.var_9842326056fd7207 = level.perkbundles[ "specialty_scavenger" ];
    }
    
    self.var_9e26dc3dc4946fe9 = self.var_9842326056fd7207.var_9e26dc3dc4946fe9 ?? 0;
    self.var_25fa4170c724a7fe = self.var_9842326056fd7207.var_25fa4170c724a7fe ?? [];
    self.var_adc8a5a0e5bff067 = self.var_9842326056fd7207.var_adc8a5a0e5bff067 ?? 0;
    
    if ( self.var_adc8a5a0e5bff067 )
    {
        self.var_58add62774360654 = [];
    }
    
    self.var_dbc1643a48094e30 = self.var_9842326056fd7207.var_dbc1643a48094e30 ?? 1;
    self.var_f615ee57b85f1e50 = [];
    self.var_3800ec6808fa496d = [];
    self.var_376b16c09c88d092 = self.var_9842326056fd7207.var_376b16c09c88d092 ?? 0;
    self.var_3c4fd5bc49653c60 = self.var_9842326056fd7207.var_3c4fd5bc49653c60 ?? "scavenger_bag_mp";
    self.var_fe25f4465b6c0c4b = self.var_9842326056fd7207.var_fe25f4465b6c0c4b ?? 20;
    self.var_2ec7d9c3b596a87e = self.var_9842326056fd7207.var_2ec7d9c3b596a87e ?? 0;
    
    if ( isdefined( self.var_9842326056fd7207.var_25fa4170c724a7fe ) )
    {
        foreach ( index, entry in self.var_9842326056fd7207.var_25fa4170c724a7fe )
        {
            self.var_25fa4170c724a7fe[ index ] = entry.ref;
            
            if ( self.var_58add62774360654 )
            {
                self.var_58add62774360654[ entry.ref ] = entry.ammo;
            }
        }
    }
    
    if ( self.var_9842326056fd7207.var_f615ee57b85f1e50 && self.var_9842326056fd7207.var_f615ee57b85f1e50.size > 0 )
    {
        foreach ( index, entry in self.var_9842326056fd7207.var_f615ee57b85f1e50 )
        {
            self.var_f615ee57b85f1e50[ index ] = entry.category;
        }
    }
    
    if ( self.var_9842326056fd7207.var_3800ec6808fa496d && self.var_9842326056fd7207.var_3800ec6808fa496d.size > 0 )
    {
        foreach ( index, entry in self.var_9842326056fd7207.var_3800ec6808fa496d )
        {
            self.var_3800ec6808fa496d[ index ] = entry;
        }
    }
}

// Namespace specialty_scavenger
// Params 0
// Checksum 0x4dfc72fc, Offset: 0x69a
// Size: 0x57
function unsetscavenger()
{
    self.var_9e26dc3dc4946fe9 = undefined;
    self.var_5bdb0c7858329c9c = undefined;
    self.var_dbc1643a48094e30 = undefined;
    self.var_3c4fd5bc49653c60 = undefined;
    self.var_fe25f4465b6c0c4b = undefined;
    self.var_2ec7d9c3b596a87e = undefined;
    utility::callsharedfunc( #"scavenger_bag", #"cleanup" );
}

// Namespace specialty_scavenger
// Params 1
// Checksum 0x40ea7d81, Offset: 0x6f9
// Size: 0x260
function onscavengerbagpickup( player )
{
    if ( isdefined( level.onscavengerbagpickup ) )
    {
        [[ level.onscavengerbagpickup ]]( player );
        return;
    }
    
    var_9845ab349fc891ce = player.var_376b16c09c88d092 || player.perks[ "specialty_intel_jacker" ];
    
    if ( var_9845ab349fc891ce )
    {
        player scavengerradarping( player.origin );
        player playlocalsound( #"hash_3044b22f3d41de2e" );
        
        if ( level.teambased )
        {
            allylist = getplayersinradius( player.origin, 700, undefined, undefined, undefined, player.team );
            var_89dfe5377fa543e9 = [];
            
            foreach ( ally in allylist )
            {
                if ( isdefined( ally.var_2cde182e1c9a34ac ) )
                {
                    var_89dfe5377fa543e9 = arraycombineunique( var_89dfe5377fa543e9, ally.var_2cde182e1c9a34ac );
                    
                    if ( ally != player )
                    {
                        var_89dfe5377fa543e9 = arraycombineunique( var_89dfe5377fa543e9, [ ally ] );
                    }
                }
            }
            
            var_89dfe5377fa543e9 = arrayremove( var_89dfe5377fa543e9, player );
            
            foreach ( ent in var_89dfe5377fa543e9 )
            {
                ent scavengerradarping( player.origin );
            }
        }
    }
    
    if ( !player.perks[ "specialty_intel_jacker" ] || player.perks[ "specialty_intel_jacker" ] && player.perks[ "specialty_scavenger_plus" ] )
    {
        scavengergiveammo( player );
        
        if ( function_bd4bd2de10e269f( player ) )
        {
            player function_af82b7da2cc3dc15();
        }
    }
    
    if ( getdvarint( @"hash_3dab3c02bd05b6f1", 0 ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconid );
    }
}

// Namespace specialty_scavenger
// Params 1, eflags: 0x4
// Checksum 0x9d8d4d08, Offset: 0x961
// Size: 0x3b
function private function_bd4bd2de10e269f( player )
{
    var_7617046a37e5a587 = isdefined( player.perks[ "specialty_scavenger_equipment" ] ) && player.var_9e26dc3dc4946fe9;
    return var_7617046a37e5a587;
}

// Namespace specialty_scavenger
// Params 1
// Checksum 0x9c6d37ee, Offset: 0x9a5
// Size: 0x1fd
function handlescavengerbagpickup( scrplayer )
{
    self endon( #"hash_e18980ead4af0b49" );
    level endon( #"game_ended" );
    assert( isdefined( scrplayer ) );
    player = undefined;
    
    while ( true )
    {
        self waittill( #"scavenger", player );
        assert( isdefined( player ) );
        
        if ( !player vehicle::is_in_vehicle() )
        {
            break;
        }
    }
    
    player notify( #"scavenger_pickup" );
    onscavengerbagpickup( player );
    
    if ( !isdefined( player.pers[ "scavengerPickedUp" ] ) )
    {
        player.pers[ "scavengerPickedUp" ] = 0;
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "scavengerPickedUp" ] ) )
        {
            player.leaderboarddata[ "scavengerPickedUp" ] = player.leaderboarddata[ "scavengerPickedUp" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "scavengerPickedUp" ] ) )
        {
            [[ level.leaderboardfunc[ "scavengerPickedUp" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
        
        if ( isdefined( player.pers[ "scavengerPickedUp" ] ) )
        {
            player.pers[ "scavengerPickedUp" ] = player.pers[ "scavengerPickedUp" ] + 1;
        }
    }
    
    var_8547be53f54ab2fb = "specialty_scavenger";
    
    if ( isdefined( level.gamemodebundle.var_f6ccd234bcb21692 ) )
    {
        var_8547be53f54ab2fb = level.gamemodebundle.var_f6ccd234bcb21692;
    }
    
    player perks::activateperk( var_8547be53f54ab2fb );
    challenges::function_fd82c22ff7278c68( player, "specialty_scavenger", undefined );
    ent_manager::deregisterspawn();
    self notify( #"death" );
    self notify( #"hash_e18980ead4af0b49" );
}

// Namespace specialty_scavenger
// Params 0
// Checksum 0x383d211a, Offset: 0xbaa
// Size: 0x34
function function_b65031837a3b7163()
{
    self endon( #"hash_e18980ead4af0b49" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    waittillframeend();
    self notify( #"hash_e18980ead4af0b49" );
}

// Namespace specialty_scavenger
// Params 1
// Checksum 0x69739894, Offset: 0xbe6
// Size: 0x17
function scavengerradarping( location )
{
    triggerportableradarping( location, self, 1300 );
}

// Namespace specialty_scavenger
// Params 1
// Checksum 0x9eff929f, Offset: 0xc05
// Size: 0xba
function scavengergiveammo( player )
{
    primaryweapons = player getweaponslistprimaries();
    var_d11ac61f01d44c8d = player.var_dbc1643a48094e30 ?? 1;
    
    foreach ( primary in primaryweapons )
    {
        addscavengercliptoweapon( player, primary, var_d11ac61f01d44c8d );
    }
    
    player.var_4c52b2420aae9702 = gettime();
}

// Namespace specialty_scavenger
// Params 3
// Checksum 0x86e2f63f, Offset: 0xcc7
// Size: 0x1f9
function addscavengercliptoweapon( player, weapon, numclips )
{
    if ( !weapon::iscacprimaryweapon( weapon ) && !level.scavenger_secondary )
    {
        return;
    }
    
    if ( weapon::iskillstreakweapon( weapon ) )
    {
        return;
    }
    
    if ( weapon.isalternate )
    {
        return;
    }
    
    if ( player.var_f615ee57b85f1e50 )
    {
        if ( arraycontains( player.var_f615ee57b85f1e50, weapon::getweapongroup( weapon ) ) )
        {
            return;
        }
    }
    
    if ( player.var_3800ec6808fa496d )
    {
        foreach ( var_daac0c399fb8788c in player.var_3800ec6808fa496d )
        {
            if ( weapon.basename == var_daac0c399fb8788c.ref )
            {
                return;
            }
        }
    }
    
    if ( weapon.basename == "iw9_pi_stimpistol_mp" )
    {
        return;
    }
    
    addammo = weapons::getammooverride( weapon );
    addammo = int( ceil( numclips * addammo ) );
    
    if ( weapon.isdualwield )
    {
        addammo *= 1;
    }
    
    if ( getdvarint( @"hash_bcc494117c9168d6", level.gamemodebundle.var_95fe0ab63727eb94 ?? 0 ) )
    {
        thread function_65c508765b7b72d3( player, weapon, addammo );
    }
    
    if ( weapon.reloaddisabled )
    {
        maxclipammo = weaponclipsize( weapon );
        new_amount = int( min( player getweaponammoclip( weapon ) + addammo, maxclipammo ) );
        player setweaponammoclip( weapon, new_amount );
        return;
    }
    
    currentstockammo = player getweaponammostock( weapon );
    player setweaponammostock( weapon, currentstockammo + addammo );
}

// Namespace specialty_scavenger
// Params 2
// Checksum 0xcd5fb578, Offset: 0xec8
// Size: 0x60
function function_fe824285804c3e69( gun, var_8bb1b2bde27b267c )
{
    currentstock = self getweaponammostock( gun );
    
    if ( weaponmaxammo( gun ) > currentstock + var_8bb1b2bde27b267c )
    {
        ammogiven = var_8bb1b2bde27b267c;
    }
    else if ( weaponmaxammo( gun ) <= currentstock + var_8bb1b2bde27b267c )
    {
        ammogiven = weaponmaxammo( gun ) - currentstock;
    }
    
    return ammogiven;
}

// Namespace specialty_scavenger
// Params 3
// Checksum 0x48759543, Offset: 0xf31
// Size: 0x1fa
function function_65c508765b7b72d3( player, gun, var_8bb1b2bde27b267c )
{
    rootname = weapon::getweaponrootname( gun );
    weapclass = weapon::function_c37ac3c4f987e506( rootname, #"classdata" );
    ammogiven = player function_fe824285804c3e69( gun, var_8bb1b2bde27b267c );
    
    if ( !isdefined( weapclass ) )
    {
        return;
    }
    
    switch ( weapclass )
    {
        case #"hash_d4f05e450448c3ec":
            lootid = getscriptbundlefieldvalue( %"hash_53c73015627b19da", #"lootid" );
            break;
        case #"hash_341e88ef67be7b97":
            lootid = getscriptbundlefieldvalue( %"hash_53c73015627b19da", #"lootid" );
            break;
        case #"hash_f4b0076c03d93738":
            lootid = getscriptbundlefieldvalue( %"hash_71863656aeac6d62", #"lootid" );
            break;
        case #"hash_c5a1525ba35389fa":
            lootid = getscriptbundlefieldvalue( %"hash_53d81b156289695e", #"lootid" );
            break;
        case #"hash_2f2d546c2247838f":
            lootid = getscriptbundlefieldvalue( %"hash_53d8171562896292", #"lootid" );
            break;
        case #"hash_719417cb1de832b6":
            lootid = getscriptbundlefieldvalue( %"consumable:mp_ammo_pickup_pi", #"lootid" );
            break;
        case #"hash_23209741b93850b5":
            lootid = getscriptbundlefieldvalue( %"hash_5404121562ae94fe", #"lootid" );
            break;
        case #"hash_900cb96c552c5e8e":
            lootid = getscriptbundlefieldvalue( %"hash_5404171562ae9d7d", #"lootid" );
            break;
        case #"hash_6191aaef9f922f96":
            lootid = getscriptbundlefieldvalue( %"hash_5404141562ae9864", #"lootid" );
            break;
        default:
            break;
    }
    
    if ( isdefined( lootid ) )
    {
        player weapons::function_c0653262a9ca772b( lootid, ammogiven );
    }
}

// Namespace specialty_scavenger
// Params 0
// Checksum 0xdd6a6dd2, Offset: 0x1133
// Size: 0x8
function scavenger_budget_delete()
{
    self delete();
}

// Namespace specialty_scavenger
// Params 0, eflags: 0x4
// Checksum 0xe54771cb, Offset: 0x1143
// Size: 0x81
function private function_92fed69d73e9dcaa()
{
    if ( !isdefined( level.gametypebundle.var_a0c4ed14ddb3f40 ) )
    {
        level.gametypebundle.var_a0c4ed14ddb3f40 = #"nowait";
    }
    
    switch ( level.gametypebundle.var_a0c4ed14ddb3f40 )
    {
        case #"nowait":
            return;
        case #"slowprocessing":
        default:
            script::waittillslowprocessallowed( 1, 1 );
            return;
    }
}

// Namespace specialty_scavenger
// Params 2
// Checksum 0x608526f0, Offset: 0x11cc
// Size: 0xac
function dropscavengerfordeath( attacker, meansofdeath )
{
    if ( !shoulddropscavengerbag( attacker ) )
    {
        return;
    }
    
    self endon( #"spawned_player" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    delay = meansofdeath == "MOD_EXECUTION" ? 1.5 : 0;
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    function_92fed69d73e9dcaa();
    
    if ( !shoulddropscavengerbag( attacker ) )
    {
        return;
    }
    
    if ( isdefined( level.var_342a06ce4c8ccba1 ) )
    {
        self [[ level.var_342a06ce4c8ccba1 ]]( attacker );
        return;
    }
    
    dropscavengerfordeathinternal( attacker );
}

// Namespace specialty_scavenger
// Params 1
// Checksum 0x52bc501, Offset: 0x1280
// Size: 0x11c
function dropscavengerfordeathinternal( attacker )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    spawntag = "j_head";
    
    if ( self ismeatshieldvictim() )
    {
        spawntag = "j_spine";
    }
    
    dropbag = self dropscavengerbag( attacker.var_3c4fd5bc49653c60 ?? "scavenger_bag_mp", spawntag );
    
    if ( !isdefined( dropbag ) )
    {
        return;
    }
    
    dropbag.owner = attacker;
    dropbag.team = attacker.team;
    
    if ( getdvarint( @"hash_3dab3c02bd05b6f1", 0 ) )
    {
        dropbag.headiconid = dropbag entityheadicons::setheadicon_singleimage( dropbag.owner, "icon_perk_scavenger_patch", 1, 0, 800, 1.5, 0.1, 1, 0, undefined, 0 );
    }
    
    dropbag ent_manager::registerspawn( 1, &scavenger_budget_delete );
    dropbag setusableenabled( 0 );
    dropbag thread handlescavengerbagpickup( self );
    dropbag thread scavengerbagcleanupthink();
    dropbag thread scavengerbagtimeoutthink();
    dropbag thread function_b65031837a3b7163();
    function_358689d61693f12e( self );
    bots::bot_add_scavenger_bag( dropbag );
}

// Namespace specialty_scavenger
// Params 1
// Checksum 0x73967fa0, Offset: 0x13a4
// Size: 0x20, Type: bool
function shoulddropscavengerbag( attacker )
{
    if ( !isdefined( attacker ) )
    {
        return false;
    }
    
    if ( attacker == self )
    {
        return false;
    }
    
    return true;
}

// Namespace specialty_scavenger
// Params 0
// Checksum 0xafed25c, Offset: 0x13cd
// Size: 0x4b
function scavengerbagcleanupthink()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self.owner utility::waittill_any( "death_or_disconnect", "joined_team", "bag_timeout" );
    
    if ( isdefined( self ) )
    {
        ent_manager::deregisterspawn();
        self delete();
    }
}

// Namespace specialty_scavenger
// Params 0
// Checksum 0xe498c48, Offset: 0x1420
// Size: 0x60
function scavengerbagtimeoutthink()
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    wait self.owner.var_fe25f4465b6c0c4b ?? 20;
    
    if ( isdefined( self ) )
    {
        self.owner notify( #"bag_timeout" );
    }
}

// Namespace specialty_scavenger
// Params 1
// Checksum 0xa3368566, Offset: 0x1488
// Size: 0x51
function function_358689d61693f12e( victim )
{
    if ( !getmatchrulesdata( "brData", "scavengerGiveArmor" ) )
    {
        return;
    }
    
    if ( isdefined( victim ) )
    {
        spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( victim.origin );
        namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_armor_plate", undefined, spawnoptions );
    }
}

// Namespace specialty_scavenger
// Params 0
// Checksum 0xc5a7897d, Offset: 0x14e1
// Size: 0x102
function function_af82b7da2cc3dc15()
{
    foreach ( ref in self.equipment )
    {
        if ( self.var_25fa4170c724a7fe.size > 0 && !arraycontains( self.var_25fa4170c724a7fe, ref ) )
        {
            continue;
        }
        
        tableinfo = weapon::getequipmenttableinfo( ref );
        
        if ( isdefined( tableinfo ) && tableinfo.scavengerammo > 0 || isdefined( self.var_58add62774360654 ) && self.var_58add62774360654[ ref ] )
        {
            equipment_mp::incrementequipmentammo( ref, self.var_58add62774360654[ ref ] ?? tableinfo.scavengerammo );
        }
    }
}

