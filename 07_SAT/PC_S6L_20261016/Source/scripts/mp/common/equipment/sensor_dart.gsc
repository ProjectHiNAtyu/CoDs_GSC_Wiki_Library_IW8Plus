// scripts\mp\common\equipment\sensor_dart.gsc  (hash_2b3ba347a4020389.gscc) (size: 8373 Bytes / 0x20b5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfbb367b7 (4222838711)
// size ...... 8373 (0x20b5)
// includes .. 19  (offset: 0x1f2d)
// strings ... 15  (offset: 0x1fc5)
// dev strs .. 0   (offset: 0x20b5)
// exports ... 26  (offset: 0x1121)
// cseg ...... 0x165 + 0xfbc (0x1121)
// imports ... 88  (offset: 0x1531)
// animtree1 . 0   (offset: 0x20b5)
// animtree2 . 0   (offset: 0x20b5)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\chaff_debuff;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\uav_bigmap;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\weapons;

#namespace sensor_dart;

// Namespace sensor_dart
// Params 0, eflags: 0x1
// Checksum 0xb8324962, Offset: 0x183
// Size: 0x46
function autoexec sensordart_init()
{
    utility::flag_wait( "equipment_initialized" );
    weapons::registerusedcallback( "equip_sensor_dart", &sensordart_used );
    weapons::function_345fed126ca0b41d( "equip_sensor_dart", &sensordart_delete );
    level callback::add( #"player_laststand", &function_def1e1d24ede9b70 );
}

// Namespace sensor_dart
// Params 1
// Checksum 0xcd9e7cb, Offset: 0x1d1
// Size: 0x333
function sensordart_used( grenade )
{
    grenade endon( #"death" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    grenade ent_manager::registerspawn( 1, &sensordart_destroy );
    grenade waittill( #"missile_stuck", stuckto );
    ref = equipment_mp::function_fdc4a655fbde0dec( grenade.weapon_name );
    tableinfo = weapon::getequipmenttableinfo( ref );
    grenade.bundle = tableinfo.bundle;
    
    if ( isplayer( stuckto ) )
    {
        grenade.owner weapons::grenadestuckto( grenade, stuckto );
        grenade thread function_91f51d8b9b1ad314( stuckto );
    }
    
    if ( isent( stuckto ) && stuckto ismovingplatform() )
    {
        grenade linkto( stuckto );
    }
    
    grenade.owner = self;
    grenade setentityowner( self );
    grenade setotherent( self );
    grenade setnodeploy( 1 );
    
    if ( !isdefined( self.var_f10bd2952829bace ) )
    {
        self.var_f10bd2952829bace = [];
    }
    
    self.var_f10bd2952829bace[ self.var_f10bd2952829bace.size ] = grenade;
    grenade setscriptablepartstate( #"plant", #"active", 0 );
    weapons::onequipmentplanted( grenade, "equip_sensor_dart", &sensordart_destroy, grenade.bundle.var_92de6d54d7cc5d46 );
    level thread weapons::monitordisownedequipment( self, grenade );
    grenade sentientpoolmanager::registersentient( "Tactical_Static", self );
    grenade function_23931feaa58120cf();
    maxhealth = function_26a776efa38ab276( self );
    grenade thread damage::monitordamage( maxhealth, "hitequip", &function_85c846032ccd4d33, &sensordart_handledamage, 0 );
    var_32745f1dee3c9ef3 = 0;
    
    if ( isdefined( self.perks[ "specialty_uav_buff" ] ) )
    {
        var_32745f1dee3c9ef3 = 1;
    }
    
    grenade thread function_6c7246fbad444eea( var_32745f1dee3c9ef3 );
    grenade thread function_c10485336f303b24( var_32745f1dee3c9ef3 );
    
    if ( grenade.bundle.var_7c4fec31c99e999c )
    {
        grenade.headicon = entityheadicons::setheadicon_equipment( grenade );
        grenade game_utility::questcircle_create( "radarCircleNeutralWhite", grenade.origin, grenade.bundle.var_5984067d11526920 );
        grenade.minimapicon = grenade objidpoolmanager::createobjective_hidden( "saw_ui_icon_map_sensor_dart", 1, 0 );
        objidpoolmanager::function_373aaf492aabde6f( grenade.minimapicon, 255, 255, 255, 1 );
        squad = teams::function_72b89edf6b47c40a( self );
        
        foreach ( player in squad.players )
        {
            grenade game_utility::questcircle_showtoplayer( player );
            objidpoolmanager::objective_playermask_addshowplayer( grenade.minimapicon, player );
        }
    }
    
    grenade sensordart_enable();
}

// Namespace sensor_dart
// Params 1
// Checksum 0xafd14783, Offset: 0x50c
// Size: 0x44
function function_91f51d8b9b1ad314( player )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    level endon( #"game_ended" );
    player waittill( #"death_or_disconnect" );
    self unlink();
}

// Namespace sensor_dart
// Params 0
// Checksum 0x7be15a17, Offset: 0x558
// Size: 0x49
function sensordart_enable()
{
    if ( isdefined( self.owner ) && level.tier1modeenabled )
    {
        self.owner player::showminimap();
    }
    
    self setscriptablepartstate( "pulse", "active", 0 );
    self notify( #"enable_radar" );
}

// Namespace sensor_dart
// Params 0
// Checksum 0x441856fe, Offset: 0x5a9
// Size: 0x49
function sensordart_disable()
{
    if ( isdefined( self.owner ) && level.tier1modeenabled )
    {
        self.owner player::hideminimap();
    }
    
    self setscriptablepartstate( "pulse", "neutral", 0 );
    self notify( #"disable_radar" );
}

// Namespace sensor_dart
// Params 1
// Checksum 0xb5f278e7, Offset: 0x5fa
// Size: 0x4e
function function_6c7246fbad444eea( var_32745f1dee3c9ef3 )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"enable_radar" );
        thread function_c07ea3b80066d078( var_32745f1dee3c9ef3 );
    }
}

// Namespace sensor_dart
// Params 1
// Checksum 0x48ee431d, Offset: 0x650
// Size: 0x313
function function_c07ea3b80066d078( var_32745f1dee3c9ef3 )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    self endon( #"disable_radar" );
    level endon( #"game_ended" );
    wait 0.5;
    sweepinterval = self.bundle.var_60b87640f2d09ccb ?? 2;
    radarradius = self.bundle.var_5984067d11526920 ?? 650;
    var_9e9471f9b493b3b7 = self.bundle.var_fc0e1e2512a9b787 ?? 1;
    var_ee045b40336757c7 = int( var_9e9471f9b493b3b7 * 1000 );
    radarradius = int( radarradius * ( level.var_2ab3ff8456131beb ?? 1 ) );
    self.radarradius = radarradius;
    
    while ( true )
    {
        if ( self.chaffstunned || self.var_d3130663423ace4b )
        {
            wait sweepinterval;
            continue;
        }
        
        if ( isbrgamemode() )
        {
            uav_bigmap::function_c0b3b2a1f1e2ac5e( self.owner.team, self.origin, radarradius, sweepinterval + 0.05 );
        }
        
        if ( level.teambased )
        {
            players = teams::getteamdata( self.owner.team, "players" );
            
            foreach ( player in players )
            {
                player.var_89d5b25e223871b1 = gettime();
                player.var_941af7a9a019e6f6 = gettime() + var_ee045b40336757c7;
                player.var_6b4d649a95f249ce = radarradius;
                player.var_c6cfbc6158d5d71a = self.origin;
            }
            
            triggerportableradarpingteam( self.origin, self.owner.team, radarradius, var_ee045b40336757c7 );
            level notify( #"hash_a933076aaaf7d216", self.origin, self.owner.team, radarradius, var_ee045b40336757c7 );
        }
        else
        {
            self.owner.var_89d5b25e223871b1 = gettime();
            self.owner.var_941af7a9a019e6f6 = gettime() + var_ee045b40336757c7;
            self.owner.var_6b4d649a95f249ce = radarradius;
            self.owner.var_c6cfbc6158d5d71a = self.origin;
            triggerportableradarping( self.origin, self.owner, radarradius, var_ee045b40336757c7 );
            level notify( #"portable_radar_ping", self.origin, self.owner, radarradius, var_ee045b40336757c7 );
        }
        
        wait sweepinterval;
    }
}

// Namespace sensor_dart
// Params 1
// Checksum 0xd92fdc41, Offset: 0x96b
// Size: 0x76
function function_c10485336f303b24( var_32745f1dee3c9ef3 )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    level endon( #"game_ended" );
    waittime = self.bundle.sensordart_timeout ?? 20;
    
    if ( var_32745f1dee3c9ef3 )
    {
        waittime *= level.var_1099f076e66a8a09 ?? 1;
    }
    
    wait waittime;
    sensordart_destroy();
}

// Namespace sensor_dart
// Params 1
// Checksum 0xe808af6, Offset: 0x9e9
// Size: 0xcf
function sensordart_destroy( data )
{
    hasattacker = 0;
    
    if ( isdefined( data ) && isdefined( data.attacker ) )
    {
        hasattacker = 1;
        function_e0f643eb4081243( data.attacker );
    }
    
    if ( self.headicon )
    {
        entityheadicons::setheadicon_deleteicon( self.headicon );
        self.headicon = undefined;
    }
    
    if ( self.minimapicon )
    {
        utility::callsharedfunc( #"game", #"returnobjectiveid", self.minimapicon );
        self.minimapicon = undefined;
    }
    
    game_utility::questcircle_delete();
    thread sensordart_delete( hasattacker );
    self setscriptablepartstate( "destroy", "active", 0 );
    self notify( #"destroyed" );
}

// Namespace sensor_dart
// Params 1
// Checksum 0xa083e2dc, Offset: 0xac0
// Size: 0x8d
function sensordart_delete( wasdestroyed )
{
    self endon( #"death" );
    utility::callsharedfunc( #"jamming_system", #"hash_216d35a250cd860", self );
    self.exploding = 1;
    sensordart_disable();
    
    if ( isdefined( self.owner ) )
    {
        self.owner weapons::removeequip( self );
    }
    
    wait self.bundle.var_80c1b3e85d780034 ?? 2;
    ent_manager::deregisterspawn();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace sensor_dart
// Params 1
// Checksum 0xf4edf493, Offset: 0xb55
// Size: 0x9e
function sensordart_handledamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    modifieddamage = damage;
    modifieddamage = utility::handlemeleedamage( objweapon, type, modifieddamage );
    modifieddamage = damage::handleapdamage( objweapon, type, modifieddamage, attacker );
    weapons::equipmenthit( self.owner, attacker, objweapon, type );
    return modifieddamage;
}

// Namespace sensor_dart
// Params 1
// Checksum 0xec47270a, Offset: 0xbfc
// Size: 0x52
function function_85c846032ccd4d33( data )
{
    attacker = data.attacker;
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker thread points::doscoreevent( #"destroyed_equipment" );
    }
    
    sensordart_destroy( data );
}

// Namespace sensor_dart
// Params 1
// Checksum 0xdd4eb4b8, Offset: 0xc56
// Size: 0x32
function function_e0f643eb4081243( attacker )
{
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker thread points::doscoreevent( #"destroyed_equipment" );
    }
}

// Namespace sensor_dart
// Params 2
// Checksum 0xfb824245, Offset: 0xc90
// Size: 0x84
function function_26a776efa38ab276( bundle, player )
{
    maxhealth = bundle.sensordart_health ?? 75;
    hasrugged = isdefined( self.perks[ "specialty_rugged_eqp" ] );
    modhealth = isdefined( self.perks[ "specialty_mod_health_max" ] );
    
    if ( hasrugged || modhealth )
    {
        maxhealth = bundle.var_2f1c5a868351ca93 ?? 150;
    }
    
    return maxhealth;
}

// Namespace sensor_dart
// Params 0
// Checksum 0x76b3ddef, Offset: 0xd1d
// Size: 0x96
function function_23931feaa58120cf()
{
    emp_debuff::set_apply_emp_callback( &function_9192c9ace310dd5b );
    haywire::function_7f69a1eb3d590f76( &function_972d632fa3af3b2a );
    haywire::function_d7496c23fe4085d4( &function_56490af86230b5d9 );
    
    if ( level.killstreak_emp_initialized )
    {
        self.ksempapplycallback = &sensordart_applyemp;
    }
    
    if ( level.killstreak_emp_initialized )
    {
        self.ksempclearcallback = &function_c25bb499a2a2444f;
    }
    
    chaff_debuff::function_3860212a5ec36b56( &function_41714d4b363562cf );
    chaff_debuff::function_324dd42a2703bc25( &function_e22cfedc39ad8fe4 );
    utility::callsharedfunc( #"jamming_system", #"hash_b99e77a93a09b9d5", self, &function_497e0d525a03652a, &function_bcbef45dbcb09bdc );
}

// Namespace sensor_dart
// Params 1
// Checksum 0x98997aff, Offset: 0xdbb
// Size: 0x39
function sensordart_applyemp( data )
{
    data.victim setscriptablepartstate( "empd", "active", 0 );
    data.victim sensordart_disable();
}

// Namespace sensor_dart
// Params 1
// Checksum 0x45ed0d39, Offset: 0xdfc
// Size: 0x39
function function_c25bb499a2a2444f( data )
{
    data.victim setscriptablepartstate( "empd", "neutral", 0 );
    data.victim sensordart_enable();
}

// Namespace sensor_dart
// Params 1
// Checksum 0xf2b0afc6, Offset: 0xe3d
// Size: 0x4d
function function_9192c9ace310dd5b( data )
{
    data.victim endon( #"destroyed" );
    sensordart_applyemp( data );
    wait self.bundle.var_3c728d9437c00f65 ?? 6;
    function_c25bb499a2a2444f( data );
}

// Namespace sensor_dart
// Params 1
// Checksum 0x918f9da7, Offset: 0xe92
// Size: 0x46
function function_972d632fa3af3b2a( data )
{
    sensordart_applyemp( data );
    
    if ( !data.victim.ishaywire )
    {
        data.victim.ishaywire = 1;
    }
}

// Namespace sensor_dart
// Params 1
// Checksum 0xb4275424, Offset: 0xee0
// Size: 0x42
function function_56490af86230b5d9( data )
{
    function_c25bb499a2a2444f( data );
    
    if ( data.victim.ishaywire )
    {
        data.victim.ishaywire = undefined;
    }
}

// Namespace sensor_dart
// Params 0
// Checksum 0xe7bc7a2a, Offset: 0xf2a
// Size: 0x1e
function function_41714d4b363562cf()
{
    self setscriptablepartstate( "empd", "active", 0 );
    self.chaffstunned = 1;
}

// Namespace sensor_dart
// Params 0
// Checksum 0xa053531f, Offset: 0xf50
// Size: 0x1d
function function_e22cfedc39ad8fe4()
{
    self setscriptablepartstate( "empd", "neutral", 0 );
    self.chaffstunned = 0;
}

// Namespace sensor_dart
// Params 1
// Checksum 0xa340484, Offset: 0xf75
// Size: 0x2c
function function_497e0d525a03652a( grenade )
{
    grenade setscriptablepartstate( "empd", "active", 0 );
    grenade.var_d3130663423ace4b = 1;
}

// Namespace sensor_dart
// Params 1
// Checksum 0x1a589efd, Offset: 0xfa9
// Size: 0x29
function function_bcbef45dbcb09bdc( grenade )
{
    grenade setscriptablepartstate( "empd", "neutral", 0 );
    grenade.var_d3130663423ace4b = undefined;
}

// Namespace sensor_dart
// Params 1, eflags: 0x4
// Checksum 0x301e34f3, Offset: 0xfda
// Size: 0x147
function private function_def1e1d24ede9b70( params )
{
    attacker = params.attacker;
    victim = params.victim;
    
    if ( !isplayer( attacker ) )
    {
        return;
    }
    
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    if ( !attacker.var_f10bd2952829bace )
    {
        return;
    }
    
    attacker.var_f10bd2952829bace = function_5713d46873b29625( attacker.var_f10bd2952829bace );
    
    foreach ( var_7702407f95371789 in attacker.var_f10bd2952829bace )
    {
        if ( var_7702407f95371789.chaffstunned || var_7702407f95371789.var_d3130663423ace4b )
        {
            continue;
        }
        
        if ( utility::ispointinsidecircle( victim.origin, var_7702407f95371789.origin, var_7702407f95371789.radarradius ) )
        {
            attacker.var_47f09ec55dfe6150 = 1;
            break;
        }
    }
}

