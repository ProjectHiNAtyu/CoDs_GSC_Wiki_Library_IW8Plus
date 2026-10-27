// scripts\mp\common\supers\gas_trap.gsc  (hash_72b7a9ef90d206fc.gscc) (size: 26068 Bytes / 0x65d4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2b2524ff (723854591)
// size ...... 26068 (0x65d4)
// includes .. 34  (offset: 0x612c)
// strings ... 52  (offset: 0x623c)
// dev strs .. 5   (offset: 0x6598)
// exports ... 68  (offset: 0x3c84)
// cseg ...... 0x447 + 0x383d (0x3c84)
// imports ... 217 (offset: 0x4724)
// animtree1 . 0   (offset: 0x65d4)
// animtree2 . 0   (offset: 0x65d4)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\gasmask;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_mines;
#using scripts\common\weapon;
#using scripts\mp\common\killstreaks\white_phosphorus;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\challenges_super;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\emp_debuff;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\equipment_interact;
#using scripts\mp\hud_message;
#using scripts\mp\movers;
#using scripts\mp\rank;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace gas_trap;

// Namespace gas_trap
// Params 0
// Checksum 0x991c541a, Offset: 0x465
// Size: 0x307
function gas_trap_init()
{
    gasbundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_gas_trap" );
    level.hallucinationeffect = spawnstruct();
    level.hallucinationeffect.maxtime = 0;
    level.hallucinationeffect.dot_damage = 0;
    level.hallucinationeffect.dot_interval = 0.1;
    level.hallucinationeffect.radar_ping_magnitude = 10;
    level.hallucinationeffect.var_8eaac6529c62721a = 6;
    
    if ( isdefined( gasbundle ) )
    {
        level.hallucinationeffect.maxtime = gasbundle.gas_hallucination_settings.var_47a7035712dd1d84 ?? 0;
        level.hallucinationeffect.dot_damage = gasbundle.gas_trap_dot_damage ?? 0;
        level.hallucinationeffect.dot_interval = gasbundle.gas_trap_dot_interval ?? 0.1;
        level.hallucinationeffect.radar_ping_magnitude = gasbundle.var_1f38a26383adfdec ?? 10;
        level.hallucinationeffect.var_b375458270da1d01 = gasbundle.var_64981bd453ce6333 ?? 5;
        level.hallucinationeffect.var_b3983782710045ef = gasbundle.var_64bc31d453f70e4d ?? 10;
        level.hallucinationeffect.var_9811c005edc23ca4 = gasbundle.var_456ad0873038eb73 ?? 500;
        level.hallucinationeffect.var_60977393994277e3 = gasbundle.var_594c3807dc7ffc3a ?? 3000;
        level.hallucinationeffect.var_60bb6993996adc9d = gasbundle.var_cef65a7b7db38e54 ?? 4500;
        
        if ( isdefined( gasbundle.gameplaysfx ) )
        {
            gameplaysfxbundle = getscriptbundle( gasbundle.gameplaysfx );
            
            if ( isdefined( gameplaysfxbundle ) )
            {
                callback::add( #"gameplay_sfx_register", &initgameplaysfx );
            }
        }
        
        level.var_12f7a3af94c52457 = gasbundle.offhandweapon ?? %"t10_gas_trap_plantable_mp";
        
        if ( !isdefined( level.var_35e19e0af705d62e ) )
        {
            level.var_35e19e0af705d62e = [];
        }
        
        level.var_35e19e0af705d62e[ level.var_35e19e0af705d62e.size ] = level.var_12f7a3af94c52457;
    }
    
    callback::add( #"player_laststand", &onplayerlaststand );
    callback::add( #"player_death", &onplayerdeath );
    callback::add( #"player_disconnect", &onplayerdisconnect );
    utility::registersharedfunc( #"gas_trap", #"hack", &hack );
    weapons::registerusedcallback( "equip_gas_trap_plantable", &gas_trap_used );
    weapons::function_2cd25260a11d5e40( #"equip_gas_trap_plantable", &onpullback );
}

// Namespace gas_trap
// Params 2, eflags: 0x4
// Checksum 0x2e33008, Offset: 0x774
// Size: 0x74
function private hack( hackeffect, attacker )
{
    if ( !hackeffect.var_30e7de3d76d5a085 )
    {
        return;
    }
    
    self.owner thread equipment_utility::function_364a1a0e0c018518( self.equipmentref, #"stolen_hacked" );
    self setscriptablepartstate( #"hacked", #"active", 0 );
    equipment_mp::hackequipment( attacker, hackeffect.var_fe6111ff085b2063 );
}

// Namespace gas_trap
// Params 1, eflags: 0x4
// Checksum 0x2fc7a68e, Offset: 0x7f0
// Size: 0x6b
function private initgameplaysfx( params )
{
    gasbundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_gas_trap" );
    gameplaysfxbundle = getscriptbundle( gasbundle.gameplaysfx );
    assert( gameplaysfxbundle, "<dev string:x24>" );
    gameplay_sound_fx::setgameplaysfx( gameplaysfxbundle, 1 );
    callback::remove( #"gameplay_sfx_register", &initgameplaysfx );
}

// Namespace gas_trap
// Params 1
// Checksum 0xa692f532, Offset: 0x863
// Size: 0x2d0
function gas_trap_used( grenade )
{
    self endon( #"disconnect" );
    grenade endon( #"death" );
    grenade.var_30656af96b2ac2a4 = [];
    grenade.add_buff = &add_buff;
    grenade.remove_buff = &remove_buff;
    issuper = 1;
    
    if ( utility::issharedfuncdefined( #"equipment", #"getequipmentbundlefromweaponname" ) )
    {
        equipmentbundle = [[ utility::getsharedfunc( #"equipment", #"getequipmentbundlefromweaponname" ) ]]( grenade.weapon_name );
        issuper = !isdefined( equipmentbundle ) || equipmentbundle.equipmenttype == "super";
    }
    
    grenade.bundle = supers_mp::getsuperbundlefromoffhandweaponname( grenade.weapon_name );
    
    if ( issuper )
    {
        grenade.superref = "super_gas_trap";
        grenade.issuper = 1;
    }
    
    if ( utility::issharedfuncdefined( #"jamming_system", #"hash_ca0042e3cac99672" ) )
    {
        grenade [[ utility::getsharedfunc( #"jamming_system", #"hash_ca0042e3cac99672" ) ]]( grenade );
    }
    
    grenade.var_736c0b69e68cc5a0 = isdefined( self.perks[ "specialty_rugged_equipment" ] );
    
    if ( isdefined( self.perks[ "specialty_rugged_eqp" ] ) )
    {
        grenade.hasruggedeqp = 1;
    }
    
    grenade ent_manager::registerspawn( 2, &function_cf9f8bce8165ccd5 );
    thread weapons::monitordisownedgrenade( self, grenade );
    grenade thread gas_trap_watch_game_end();
    data = spawnstruct();
    data.endonstring = "mine_destroyed";
    data.skipdeath = 1;
    grenade thread movers::handle_moving_platform_touch( data );
    results = grenade utility::waittill_any_return_params( "missile_stuck", "missile_water_impact" );
    message = results[ "message" ];
    stuckto = results[ "0" ];
    
    if ( message == "missile_stuck" && stuckto )
    {
        if ( isent( stuckto ) && utility::is_moving_platform_ent( stuckto ) )
        {
            grenade.origin += ( 0, 0, 1.6 );
        }
        
        grenade linkto( stuckto );
    }
    else if ( message == "missile_water_impact" )
    {
        grenade gas_trap_destroy();
        return;
    }
    else if ( isdefined( results[ 0 ] ) )
    {
        if ( results[ 0 ] vehicle::is_vehicle() )
        {
            hud_message::showerrormessage( %"hash_5de1bfe80c030ae1" );
            thread gas_trap_refund();
            grenade gas_trap_destroy();
            return 0;
        }
    }
    
    utility::function_969f9f5596dba07a( grenade, &gas_trap_destroy );
    thread gas_trap_plant( grenade );
}

// Namespace gas_trap
// Params 1
// Checksum 0x12089509, Offset: 0xb3b
// Size: 0x19c
function gas_trap_plant( grenade )
{
    grenade endon( #"mine_destroyed" );
    grenade endon( #"death" );
    grenade setotherent( self );
    grenade setentityowner( self );
    grenade missilethermal();
    grenade missileoutline();
    grenade setnodeploy( 1 );
    grenade setscriptablepartstate( "plant", "active", 0 );
    weapons::onequipmentplanted( grenade, "equip_gas_trap_plantable", &gas_trap_destroy );
    thread weapons::monitordisownedequipment( self, grenade );
    grenade sentientpoolmanager::registersentient( "Lethal_Static", grenade.owner, 1 );
    maxhits = grenade.bundle.var_48444c8dc09b12ba ?? 1;
    grenade thread weapons::minedamagemonitor( maxhits );
    grenade thread function_556b0144d4037a48();
    grenade function_d121d395c8e80c4c();
    grenade thread equipment_interact::remoteinteractsetup( &gas_trap_destroy, 0, 1 );
    grenade thread function_62ce723a75ff4579();
    wait 0.75;
    
    if ( grenade.touchedmovingplatform )
    {
        grenade thread function_eb188e3bb8deb243();
    }
    
    wait 0.75;
    grenade.allowhack = 1;
    grenade thread gas_trap_watch_trigger();
    
    /#
        if ( getdvarint( @"scr_gas_trap_debug", 0 ) )
        {
            grenade thread function_3bb5690ea032d794();
        }
    #/
    
    thread weapons::outlineequipmentforowner( grenade );
    imageoverride = grenade.var_30656af96b2ac2a4.size > 0 ? grenade.bundle.buffedheadicon : undefined;
    grenade.headiconid = entityheadicons::setheadicon_equipment( grenade, imageoverride );
}

// Namespace gas_trap
// Params 0, eflags: 0x4
// Checksum 0xd8d2599f, Offset: 0xcdf
// Size: 0x26
function private function_d121d395c8e80c4c()
{
    emp_debuff::set_start_emp_callback( &empstarted );
    emp_debuff::set_apply_emp_callback( &empapplied );
    emp_debuff::set_clear_emp_callback( &empcleared );
}

// Namespace gas_trap
// Params 0
// Checksum 0x29debb47, Offset: 0xd0d
// Size: 0x56
function gas_trap_refund()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( self.super.staticdata.ref == "super_gas_trap" )
    {
        thread supers_mp::refundsuper();
        return;
    }
    
    equipment_mp::incrementequipmentslotammo( "secondary" );
}

// Namespace gas_trap
// Params 0
// Checksum 0x76d7da53, Offset: 0xd6b
// Size: 0x51
function function_62ce723a75ff4579()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"mine_destroyed" );
    
    while ( true )
    {
        self waittill( #"hack_successful", hacker );
        thread weapons::monitordisownedequipment( hacker, self );
    }
}

// Namespace gas_trap
// Params 1
// Checksum 0xb971b70a, Offset: 0xdc4
// Size: 0x91
function function_d8a3181bcb41ce5a( vehicle )
{
    gas_trap_name = supers_mp::getsuperweapon( "super_gas_trap" );
    gas_trap_weapon = makeweapon( gas_trap_name );
    vehicle dodamage( 25, self.origin, self.owner, self, "MOD_EXPLOSIVE", gas_trap_weapon );
    ignoredamageid = vehicle damage::non_player_add_ignore_damage_signature( self.owner, gas_trap_weapon, self, "MOD_EXPLOSIVE" );
    thread function_3650076ac9295256();
    waitframe();
    
    if ( isdefined( vehicle ) )
    {
        vehicle damage::non_player_remove_ignore_damage_signature( ignoredamageid );
    }
}

// Namespace gas_trap
// Params 0
// Checksum 0xdc66c0ba, Offset: 0xe5d
// Size: 0x23
function function_3650076ac9295256()
{
    thread gas_trap_delete( 0.2 );
    self setentityowner( self.owner );
    self clearscriptabledamageowner();
}

// Namespace gas_trap
// Params 2
// Checksum 0xe2cb1b59, Offset: 0xe88
// Size: 0x85
function function_42c82d3896bbc5ae( attacker, objweapon )
{
    if ( attacker != self.owner )
    {
        self.owner thread equipment_utility::function_72a91d0610eb601c( self.superref, #"destroyed", #"destroyed_multiple" );
    }
    
    utility::callsharedfunc( #"supers", #"hash_28aeb93023a8a138", attacker, objweapon );
    thread gas_trap_delete( 0.2 );
    self setentityowner( attacker );
    self clearscriptabledamageowner();
}

// Namespace gas_trap
// Params 1
// Checksum 0x4e89a8a, Offset: 0xf15
// Size: 0x18
function gas_trap_destroy( attacker )
{
    thread gas_trap_delete( 0.2 );
}

// Namespace gas_trap
// Params 0, eflags: 0x4
// Checksum 0xd7946e14, Offset: 0xf35
// Size: 0x67
function private disable()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.isdisabled = 1;
    self.var_46c8e804135d46af = 0;
    self.gascoughinprogress = 0;
    self setscriptablepartstate( "effects", "neutral", 0 );
    self setscriptablepartstate( "danger-icon", "off", 0 );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger thread function_6e8382ec77924917();
    }
}

// Namespace gas_trap
// Params 1
// Checksum 0x82e55479, Offset: 0xfa4
// Size: 0x138
function gas_trap_delete( deletiondelay )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( #"death" );
    
    if ( self.mineid )
    {
        weapon::deregistermine();
    }
    
    equipment_interact::function_d5794740325fbfd4();
    disable();
    self setscriptablepartstate( "destroy", "active", 0 );
    weapons::makeexplosiveunusuabletag();
    entityheadicons::setheadicon_deleteicon( self.headiconid );
    self.headiconid = undefined;
    self.exploding = 1;
    
    if ( isdefined( self.dangerzone ) )
    {
        spawnlogic::removespawninfluencer( self.dangerzone );
        self.dangerzone = undefined;
    }
    
    if ( isdefined( self.owner ) )
    {
        self.owner weapons::removeequip( self );
    }
    
    if ( isdefined( self.launchedmine ) )
    {
        self.launchedmine delete();
    }
    
    if ( utility::issharedfuncdefined( #"jamming_system", #"hash_c33ceb91d0ca7a9d" ) )
    {
        self [[ utility::getsharedfunc( #"jamming_system", #"hash_c33ceb91d0ca7a9d" ) ]]( self );
    }
    
    namespace_9d8e359c3b1041e5::emp_debuff_deregister_sharedfunc( self );
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
    }
    
    ent_manager::deregisterspawn();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace gas_trap
// Params 0
// Checksum 0x4e670b4e, Offset: 0x10e4
// Size: 0x86
function function_eb188e3bb8deb243()
{
    self endon( #"mine_triggered" );
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    self.attachedvelocity = ( 0, 0, 0 );
    update_interval = 0.2;
    
    while ( true )
    {
        old_origin = self.origin;
        wait update_interval;
        self.attachedvelocity = 1 / update_interval * ( self.origin - old_origin );
    }
}

// Namespace gas_trap
// Params 1
// Checksum 0x8f9d0c9, Offset: 0x1172
// Size: 0x37, Type: bool
function is_gas_trap_moving( mine )
{
    return isdefined( mine ) && isdefined( mine.attachedvelocity ) && length2dsquared( mine.attachedvelocity ) > 0.01;
}

// Namespace gas_trap
// Params 0
// Checksum 0x7ee73afd, Offset: 0x11b2
// Size: 0x271
function gas_trap_watch_trigger()
{
    self endon( #"mine_triggered" );
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    var_23a82edf24269a34 = isdefined( level.gametypebundle ) && level.gametypebundle.var_23a82edf24269a34;
    
    while ( true )
    {
        self waittill( #"trigger_grenade", entarr );
        assert( isdefined( entarr ) );
        
        if ( self.isdisabled || self.isjammed )
        {
            continue;
        }
        
        foreach ( ent in entarr )
        {
            if ( ent.classname == "script_vehicle" )
            {
                if ( ent vehicle_mines::function_56d954c642e8acea( self ) )
                {
                    continue;
                }
                
                if ( !vehicle_mines::function_60d53a1a3bd504cd( ent, self ) )
                {
                    continue;
                }
                
                self setscriptablepartstate( "trigger", "active", 0 );
                self.istriggered = 1;
                function_b0e2b4eac81608d3();
                vehicle_mines::trigger_mine( ent, self );
                break;
            }
            
            if ( isagent( ent ) || isplayer( ent ) )
            {
                if ( isdefined( ent.vehicle ) )
                {
                    continue;
                }
                
                if ( !player::isreallyalive( ent ) )
                {
                    continue;
                }
                
                if ( isdefined( ent.perks[ "specialty_lightfoot" ] ) )
                {
                    continue;
                }
                
                if ( ent.var_ff102e941e8065c )
                {
                    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_gas_trap" );
                    delayapplied = equipment_mp::function_84f2f5566ba29655( ent, ent.var_ff102e941e8065c, bundle.gas_trap_trigger_radius );
                    
                    if ( delayapplied )
                    {
                        continue;
                    }
                }
                
                if ( var_23a82edf24269a34 && ent.spawnprotection )
                {
                    continue;
                }
                
                headpos = ent utility::function_f02ebab438642e16();
                
                if ( self.origin[ 2 ] > headpos[ 2 ] )
                {
                    continue;
                }
                
                self setscriptablepartstate( "trigger", "active", 0 );
                self.istriggered = 1;
                function_b0e2b4eac81608d3();
                thread gas_trap_player_trigger( ent );
                break;
            }
        }
    }
}

// Namespace gas_trap
// Params 0
// Checksum 0xbba5a8b, Offset: 0x142b
// Size: 0x28
function function_b0e2b4eac81608d3()
{
    if ( self.allowhack )
    {
        self.allowhack = 0;
        self setscriptablepartstate( "hack_usable", "off" );
    }
}

/#

    // Namespace gas_trap
    // Params 0
    // Checksum 0x2f2c10bb, Offset: 0x145b
    // Size: 0x12a, Type: dev
    function function_3bb5690ea032d794()
    {
        self endon( #"mine_triggered" );
        self endon( #"mine_destroyed" );
        self endon( #"death" );
        
        if ( isdefined( self.debug_trig ) )
        {
            self.debug_trig delete();
        }
        
        self.debug_trig = spawn( "<dev string:x91>", self.origin, 0, 48, 48 );
        self.debug_trig enablelinkto();
        self.debug_trig linkto( self );
        cylinder( self.origin, self.origin + ( 0, 0, 48 ), 48, ( 1, 1, 0 ), 0, 100 );
        
        while ( true )
        {
            self.debug_trig waittill( #"trigger", ent );
            assert( isdefined( ent ) );
            self notify( #"trigger_grenade", [ ent ] );
            print3d( self.origin, "<dev string:xa0>", ( 1, 1, 0 ), 1, 0.5, 100, 1 );
        }
    }

#/

// Namespace gas_trap
// Params 1
// Checksum 0x452ff7f6, Offset: 0x158d
// Size: 0x107
function gas_trap_player_trigger( ent )
{
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    self notify( #"mine_triggered" );
    self.triggeredbyplayer = 1;
    self.var_c3c4d711e69d5ab9 = 1;
    weapons::makeexplosiveunusuabletag();
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_gas_trap" );
    
    if ( bundle.var_c7709714d768097c && self.owner supers_mp::function_d45945781d29204a( "super_gas_trap", bundle.var_c7709714d768097c ) )
    {
        self setscriptablepartstate( "effects", "active_prostats", 0 );
    }
    else
    {
        self setscriptablepartstate( "effects", "active", 0 );
    }
    
    self setscriptablepartstate( "danger-icon", "on", 0 );
    position = self.origin + ( 0, 0, 10 );
    thread function_4be67b47a83bb68f( position, self.owner, self.team );
}

// Namespace gas_trap
// Params 2
// Checksum 0x4bbeea8b, Offset: 0x169c
// Size: 0x6b
function gas_trap_vehicle_trigger( vehicle, mine )
{
    mine endon( #"mine_destroyed" );
    mine endon( #"death" );
    mine.owner endon( #"disconnect" );
    mine notify( #"mine_triggered" );
    mine weapons::makeexplosiveunusuabletag();
    wait 0.2;
    mine thread function_d8a3181bcb41ce5a( vehicle );
}

// Namespace gas_trap
// Params 1, eflags: 0x4
// Checksum 0x85c9af31, Offset: 0x170f
// Size: 0x99
function private empstarted( data )
{
    gasbundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_gas_trap" );
    
    if ( !isdefined( gasbundle ) )
    {
        return;
    }
    
    if ( !gasbundle.var_8c54bf22c6559274 && self.istriggered )
    {
        return;
    }
    
    if ( gasbundle.var_2dbcedb5fcf7ebab )
    {
        return;
    }
    
    if ( isdefined( gasbundle.var_40a67cf36089d4 ) && isdefined( gasbundle.var_f877600392019faf ) )
    {
        self setscriptablepartstate( gasbundle.var_40a67cf36089d4, gasbundle.var_f877600392019faf, 0 );
    }
    
    disable();
}

// Namespace gas_trap
// Params 1, eflags: 0x4
// Checksum 0xb8c238b9, Offset: 0x17b0
// Size: 0xcc
function private empapplied( data )
{
    gasbundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_gas_trap" );
    
    if ( !isdefined( gasbundle ) )
    {
        return;
    }
    
    if ( !gasbundle.var_8c54bf22c6559274 && self.istriggered )
    {
        return;
    }
    
    attacker = data.attacker;
    
    if ( gasbundle.var_2dbcedb5fcf7ebab )
    {
        self notify( #"enemy_destroyed_equipment", attacker );
        
        if ( player_utility::playersareenemies( self.owner, attacker ) )
        {
            attacker equipment_mp::function_ada7da3083a6c593( self );
        }
        
        if ( isplayer( attacker ) )
        {
            attacker damagefeedback::updatedamagefeedback( "" );
        }
        
        thread gas_trap_destroy( attacker );
        return;
    }
    
    attacker thread points::doscoreevent( #"disabled_gas_trap" );
}

// Namespace gas_trap
// Params 1, eflags: 0x4
// Checksum 0x78a48734, Offset: 0x1884
// Size: 0x83
function private empcleared( isdeath )
{
    if ( !self.isdisabled )
    {
        return;
    }
    
    self.isdisabled = undefined;
    gasbundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_gas_trap" );
    
    if ( isdefined( gasbundle.var_40a67cf36089d4 ) && isdefined( gasbundle.var_e5845dd3e5ade858 ) )
    {
        self setscriptablepartstate( gasbundle.var_40a67cf36089d4, gasbundle.var_e5845dd3e5ade858, 0 );
    }
    
    if ( !isdeath )
    {
        gas_trap_watch_trigger();
    }
}

// Namespace gas_trap
// Params 0
// Checksum 0xad968017, Offset: 0x190f
// Size: 0x6d
function function_556b0144d4037a48()
{
    self endon( #"death" );
    self waittill( #"detonateexplosive", attacker, objweapon );
    
    if ( isdefined( attacker ) )
    {
        thread function_42c82d3896bbc5ae( attacker, objweapon );
        return;
    }
    
    if ( isdefined( self.owner ) )
    {
        thread function_42c82d3896bbc5ae( self.owner, objweapon );
        return;
    }
    
    thread gas_trap_destroy();
}

// Namespace gas_trap
// Params 0
// Checksum 0xf906d54, Offset: 0x1984
// Size: 0x33
function gas_trap_watch_game_end()
{
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    level utility::waittill_any( "game_ended", "bro_shot_start" );
    thread gas_trap_destroy();
}

// Namespace gas_trap
// Params 1
// Checksum 0xd462358d, Offset: 0x19bf
// Size: 0x2d
function function_b04fca5901f8ae1b( launchedmine )
{
    launchedmine endon( #"death" );
    self waittill( #"death" );
    launchedmine delete();
}

// Namespace gas_trap
// Params 5
// Checksum 0x6bdf0587, Offset: 0x19f4
// Size: 0x211
function function_4be67b47a83bb68f( position, owner, team, duration, scale )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_gas_trap" );
    
    if ( !isdefined( duration ) )
    {
        duration = bundle.gas_trap_gas_duration ?? 2;
    }
    
    duration = self.var_48d6bc4ec1942918 ? duration * self.var_48d6bc4ec1942918 : duration;
    
    if ( bundle.var_c7709714d768097c && self.owner supers_mp::function_d45945781d29204a( "super_gas_trap", bundle.var_c7709714d768097c ) )
    {
        duration *= bundle.var_fe31fa40e9e0ea4e ?? 1.1;
    }
    
    if ( !isdefined( scale ) )
    {
        scale = 1;
    }
    
    triggermaxsize = isdefined( bundle.gas_trap_gas_radius ) ? int( bundle.gas_trap_gas_radius ) : int( 256 * scale );
    trigger = spawn( "trigger_radius", position + ( 0, 0, int( -57.75 * scale ) ), 0, triggermaxsize, int( 175 * scale ) );
    trigger ent_manager::registerspawn( 1, &sweepgas );
    trigger.navobstacleid = createnavbadplacebyent( trigger );
    trigger.owner = owner;
    trigger.team = team;
    trigger.trap = self;
    trigger.playersintrigger = [];
    trigger thread function_d69b4b781298297e( self );
    trigger thread function_53be03d7472c0ea8( self );
    
    if ( bundle.var_e36b84555e7df1d3 && self.owner supers_mp::function_d45945781d29204a( "super_gas_trap", bundle.var_e36b84555e7df1d3 ) )
    {
        trigger thread function_ea70b4c7b9e8a9ec( self );
    }
    
    self.trigger = trigger;
    wait duration;
    thread gas_trap_destroy();
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger thread function_6e8382ec77924917();
    }
}

// Namespace gas_trap
// Params 0
// Checksum 0x4bed051c, Offset: 0x1c0d
// Size: 0x9
function sweepgas()
{
    thread function_6e8382ec77924917();
}

// Namespace gas_trap
// Params 0
// Checksum 0x4c5244d3, Offset: 0x1c1e
// Size: 0xbc
function function_6e8382ec77924917()
{
    foreach ( player in self.playersintrigger )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread function_94ee670a4bf8b6f8( self getentitynumber() );
    }
    
    if ( isdefined( self.navobstacleid ) )
    {
        destroynavobstacle( self.navobstacleid );
        self.navobstacleid = undefined;
    }
    
    ent_manager::deregisterspawn();
    self delete();
}

// Namespace gas_trap
// Params 2
// Checksum 0xf1036a9, Offset: 0x1ce2
// Size: 0x9d
function function_714856f0ed636182( trigger, mine )
{
    self notify( #"hash_f2d7b5607d4b2bbf" );
    
    if ( !isdefined( self.gastriggerstouching ) )
    {
        self.gastriggerstouching = [];
    }
    
    entnum = trigger getentitynumber();
    self.gastriggerstouching[ entnum ] = trigger;
    self.lastgastouchtime = gettime();
    
    if ( !isdefined( self.hallucinationtimer ) )
    {
        thread function_904e879c497ef8ed( trigger, mine );
    }
    else
    {
        self.hallucinationtimer = level.hallucinationeffect.maxtime;
    }
    
    return entnum;
}

// Namespace gas_trap
// Params 1
// Checksum 0x21acfd49, Offset: 0x1d88
// Size: 0x54
function function_94ee670a4bf8b6f8( triggerid )
{
    assert( isdefined( triggerid ), "<dev string:xab>" );
    self.gastriggerstouching[ triggerid ] = undefined;
    self.lastgastouchtime = gettime();
    
    if ( isdefined( self ) && self function_5c766d1d0140b86( "ui_br_player_is_in_gas_from_grenade" ) )
    {
        self setclientomnvar( "ui_br_player_is_in_gas_from_grenade", 0 );
    }
}

// Namespace gas_trap
// Params 1
// Checksum 0x85aa8b7f, Offset: 0x1de4
// Size: 0x14e
function function_d69b4b781298297e( mine )
{
    self endon( #"death" );
    mine endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( player.var_193dad851d6389a4 )
        {
            continue;
        }
        
        if ( player killstreak::isjuggernaut() )
        {
            continue;
        }
        
        if ( function_8de1f4bd0dc11222( player ) )
        {
            continue;
        }
        
        if ( !player player::isreallyalive() )
        {
            continue;
        }
        
        if ( isdefined( self.playersintrigger[ player getentitynumber() ] ) )
        {
            continue;
        }
        
        if ( level.teambased )
        {
            if ( isalive( self.owner ) )
            {
                if ( player != self.owner && !player_utility::playersareenemies( player, self.owner ) )
                {
                    continue;
                }
            }
            else if ( player_utility::isfriendly( self.team, player ) )
            {
                continue;
            }
        }
        
        headpos = player utility::function_f02ebab438642e16();
        
        if ( mine.origin[ 2 ] > headpos[ 2 ] )
        {
            continue;
        }
        
        self.playersintrigger[ player getentitynumber() ] = player;
        player thread function_714856f0ed636182( self, mine );
    }
}

// Namespace gas_trap
// Params 1
// Checksum 0x3dc3cf7b, Offset: 0x1f3a
// Size: 0x212
function function_ea70b4c7b9e8a9ec( mine )
{
    self notify( #"hash_53ae17b52fb3be72" );
    self endon( #"hash_53ae17b52fb3be72" );
    level endon( #"game_ended" );
    self endon( #"death" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_gas_trap" );
    gasdamage = bundle.var_57267f36d49c55e7 ?? 20;
    var_8330395bbba18546 = bundle.var_eb9ed468bf3d7c1d ?? 5;
    var_c0db39d69d09fc9f = bundle.var_c7f05bd39955a196 ?? 1;
    spawnprotectionduration = ( bundle.var_9edc50f41fdecf5f ?? 5 ) * 1000;
    var_5eee3cb7a4f452a4 = mine.weapon_object;
    
    while ( true )
    {
        currenttime = gettime();
        
        foreach ( player in self.playersintrigger )
        {
            if ( !( isdefined( player ) && isdefined( player.origin ) ) )
            {
                continue;
            }
            
            if ( !player::isreallyalive( player ) )
            {
                continue;
            }
            
            if ( currenttime - player.lastspawntime < spawnprotectionduration )
            {
                continue;
            }
            
            if ( !isdefined( player.perks[ "specialty_gas_immunity" ] ) )
            {
                if ( isdefined( player.perks[ "specialty_gas_grenade_resist" ] ) )
                {
                    player dodamage( var_8330395bbba18546, player.origin, self.owner, mine, "MOD_TRIGGER_HURT", var_5eee3cb7a4f452a4 );
                    continue;
                }
                
                player dodamage( gasdamage, player.origin, self.owner, mine, "MOD_TRIGGER_HURT", var_5eee3cb7a4f452a4 );
            }
        }
        
        wait var_c0db39d69d09fc9f;
    }
}

// Namespace gas_trap
// Params 1
// Checksum 0x9537a8c8, Offset: 0x2154
// Size: 0x123
function function_53be03d7472c0ea8( mine )
{
    self endon( #"death" );
    
    while ( true )
    {
        foreach ( id, player in self.playersintrigger )
        {
            if ( !isdefined( player ) )
            {
                self.playersintrigger[ id ] = undefined;
                continue;
            }
            
            if ( !player player::isreallyalive() )
            {
                continue;
            }
            
            headpos = player utility::function_f02ebab438642e16();
            var_9db3dfae950094 = mine.origin[ 2 ] < headpos[ 2 ];
            
            if ( player istouching( self ) && !function_8de1f4bd0dc11222( player ) && var_9db3dfae950094 )
            {
                continue;
            }
            
            self.playersintrigger[ player getentitynumber() ] = undefined;
            player thread function_94ee670a4bf8b6f8( self getentitynumber() );
        }
        
        waitframe();
    }
}

// Namespace gas_trap
// Params 1
// Checksum 0x84c7aa13, Offset: 0x227f
// Size: 0xff
function onplayerlaststand( data )
{
    attacker = data.attacker;
    victim = data.victim;
    
    if ( !function_a9b941cb90e611a8( victim ) )
    {
        return;
    }
    
    attackerentnum = attacker getentitynumber();
    
    if ( !isdefined( victim.var_dc025d4b9929cb1f.attackers[ attackerentnum ] ) )
    {
        return;
    }
    
    if ( !isdefined( attacker.var_5d7ed9f2a7fdd8cb ) )
    {
        attacker.var_5d7ed9f2a7fdd8cb = victim;
    }
    
    var_fe4c2aa5d9ce8829 = {};
    
    if ( !isdefined( data.callbackeventdata ) )
    {
        data.callbackeventdata = [];
    }
    
    data.callbackeventdata[ "equip_gas_trap_plantable" ] = var_fe4c2aa5d9ce8829;
    
    if ( attacker.var_5d7ed9f2a7fdd8cb != victim )
    {
        var_fe4c2aa5d9ce8829.var_53dc082f326bc47 = 1;
        attacker.var_5d7ed9f2a7fdd8cb = undefined;
        return;
    }
    
    attacker thread function_7aa3d6f6363fcdf7();
}

// Namespace gas_trap
// Params 1
// Checksum 0x9fb48f1d, Offset: 0x2386
// Size: 0x14a
function onplayerdeath( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    
    if ( victim.inlaststand )
    {
        laststanddowneddata = victim.laststanddowneddata;
        var_fe4c2aa5d9ce8829 = laststanddowneddata.callbackeventdata[ "equip_gas_trap_plantable" ];
        
        if ( !isdefined( var_fe4c2aa5d9ce8829 ) )
        {
            return;
        }
        
        if ( var_fe4c2aa5d9ce8829.var_53dc082f326bc47 )
        {
            laststanddowneddata.attacker thread points::doscoreevent( #"gas_trap_double" );
        }
    }
    else
    {
        if ( !function_a9b941cb90e611a8( victim ) )
        {
            return;
        }
        
        attackerentnum = attacker getentitynumber();
        
        if ( !isdefined( victim.var_dc025d4b9929cb1f.attackers[ attackerentnum ] ) )
        {
            return;
        }
        
        if ( !isdefined( attacker.var_5d7ed9f2a7fdd8cb ) )
        {
            attacker.var_5d7ed9f2a7fdd8cb = victim;
        }
        
        if ( attacker.var_5d7ed9f2a7fdd8cb != victim )
        {
            attacker thread points::doscoreevent( #"gas_trap_double" );
            attacker.var_5d7ed9f2a7fdd8cb = undefined;
        }
        else
        {
            attacker thread function_7aa3d6f6363fcdf7();
        }
    }
    
    victim challenges::function_ead174660f144273( attacker, "super_gas_trap" );
}

// Namespace gas_trap
// Params 1
// Checksum 0xc34fb31e, Offset: 0x24d8
// Size: 0x8b
function onplayerdisconnect( data )
{
    foreach ( player in level.players )
    {
        player challenges::function_ead174660f144273( self, "super_gas_trap" );
    }
}

// Namespace gas_trap
// Params 1, eflags: 0x4
// Checksum 0x528cb34, Offset: 0x256b
// Size: 0x24, Type: bool
function private function_a9b941cb90e611a8( victim )
{
    return victim.var_dc025d4b9929cb1f.attackers.size > 0;
}

// Namespace gas_trap
// Params 0, eflags: 0xc
// Checksum 0x79eb0103, Offset: 0x2598
// Size: 0x33
function private function_7aa3d6f6363fcdf7()
{
    self notify( #"hash_be61c8e5d33efde0" );
    self endon( #"hash_be61c8e5d33efde0" );
    self endon( #"death_or_disconnect" );
    wait 2;
    self.var_5d7ed9f2a7fdd8cb = undefined;
}

// Namespace gas_trap
// Params 6
// Checksum 0x3681af88, Offset: 0x25d3
// Size: 0x9a
function function_4cf942381e504df5( owner, mine, shock, attacker, gasbundle, attackerentnum )
{
    msg = utility::waittill_any_return( "death", "disconnect", "last_stand_enter", "start_hallucination_immunity" );
    fromdeath = 1;
    
    if ( msg == "start_hallucination_immunity" )
    {
        shock = undefined;
        fromdeath = 0;
    }
    
    if ( fromdeath )
    {
        function_4aaca40714e367aa( owner, mine );
    }
    
    function_1e8c2b46ef66684e( mine, fromdeath, shock, attacker, gasbundle, attackerentnum );
}

// Namespace gas_trap
// Params 2
// Checksum 0x6ebd19ec, Offset: 0x2675
// Size: 0x178
function function_4aaca40714e367aa( owner, mine )
{
    fromdeath = !player::isreallyalive( self );
    fromdown = player::isinlaststand( self );
    
    if ( fromdeath )
    {
        waitframe();
        var_5eee3cb7a4f452a4 = mine.weapon_object;
        
        if ( !( isdefined( self ) && isdefined( self.gastriggerstouching ) && isdefined( self.gastriggerstouching ) ) || self.gastriggerstouching.size < 1 )
        {
            return;
        }
        else if ( isdefined( self.attackers ) )
        {
            var_8f12d39b82e09e5d = self.attackers;
            
            if ( var_8f12d39b82e09e5d.size > 1 )
            {
                var_8f12d39b82e09e5d = arrayremove( var_8f12d39b82e09e5d, owner );
            }
            
            foreach ( attacker in var_8f12d39b82e09e5d )
            {
                if ( isdefined( attacker ) )
                {
                    function_a54fa5aa35be8bd8( attacker, owner, var_5eee3cb7a4f452a4 );
                }
            }
        }
        
        return;
    }
    
    if ( fromdown )
    {
        if ( !( isdefined( self ) && isdefined( self.gastriggerstouching ) && isdefined( self.gastriggerstouching ) ) || self.gastriggerstouching.size < 1 )
        {
            return;
        }
        
        thread waitforfinish( owner, mine );
    }
}

// Namespace gas_trap
// Params 2
// Checksum 0x6384edb5, Offset: 0x27f5
// Size: 0xd8
function waitforfinish( owner, mine )
{
    self endon( #"disconnect" );
    self endon( #"laststand_revived" );
    var_5eee3cb7a4f452a4 = mine.weapon_object;
    self waittill( #"death" );
    waitframe();
    
    if ( isdefined( self.attackers ) )
    {
        foreach ( attacker in self.attackers )
        {
            function_a54fa5aa35be8bd8( attacker, owner, var_5eee3cb7a4f452a4 );
        }
    }
}

// Namespace gas_trap
// Params 3
// Checksum 0x30fc3d5c, Offset: 0x28d5
// Size: 0x81
function function_a54fa5aa35be8bd8( attacker, owner, var_5eee3cb7a4f452a4 )
{
    victim = self;
    
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    if ( !isdefined( damage::_validateattacker( attacker ) ) )
    {
        return;
    }
    
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    if ( attacker == owner )
    {
        owner thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"gas_finished", var_5eee3cb7a4f452a4 );
        return;
    }
    
    owner thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_867f6f6254ec9309", var_5eee3cb7a4f452a4 );
}

// Namespace gas_trap
// Params 2
// Checksum 0x99eb6f52, Offset: 0x295e
// Size: 0x483
function function_904e879c497ef8ed( trigger, mine )
{
    attacker = trigger.owner;
    
    if ( !( isdefined( attacker ) && isdefined( mine ) ) )
    {
        return;
    }
    
    telemetry_mp::function_594cbdc6a4d8098a( self, attacker, mine.weapon_object, mine getentitynumber() );
    attackerentnum = attacker getentitynumber();
    gasbundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_gas_trap" );
    shock = function_e19ac660c03ad8ed();
    thread function_4cf942381e504df5( attacker, mine, shock, attacker, gasbundle, attackerentnum );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( self.perks[ "specialty_tac_mask" ] ) && isdefined( self.perks[ "specialty_gas_immunity" ] ) )
    {
        if ( level.gamemodebundle.var_7aa3d55e72a5c0d1 == #"right" )
        {
            perks::function_142df1226093bce0( "specialty_tac_mask" );
            return;
        }
        
        perks::activateperk( "specialty_tac_mask" );
        return;
    }
    
    if ( isdefined( self.perks[ "specialty_hallucination_immunity" ] ) || isdefined( self.perks[ "specialty_gas_immunity" ] ) )
    {
        return;
    }
    
    if ( isdefined( self.gasmaskhealth ) )
    {
        if ( self.gasmaskhealth > 0 )
        {
            gasmask::processdamage( 10 );
            
            if ( self function_5c766d1d0140b86( "ui_br_player_is_in_gas_from_grenade" ) )
            {
                self setclientomnvar( "ui_br_player_is_in_gas_from_grenade", 1 );
            }
            
            return;
        }
    }
    
    self.hallucinationtimer = level.hallucinationeffect.maxtime;
    
    if ( !isdefined( self.var_dc025d4b9929cb1f ) )
    {
        self.var_dc025d4b9929cb1f = {};
    }
    
    self.var_dc025d4b9929cb1f.weapon = mine.weapon_object;
    self.var_dc025d4b9929cb1f.attackers[ attackerentnum ] = attacker;
    challenges::tracksuper( attacker, "super_gas_trap" );
    
    if ( !isdefined( gasbundle ) )
    {
        return;
    }
    
    if ( isdefined( gasbundle.var_46d73d13fa470612 ) )
    {
        wait gasbundle.var_46d73d13fa470612;
    }
    
    if ( isdefined( mine ) )
    {
        shouldapplyblur = getdvarint( @"hash_65b2a1e4bfb18c81", 0 ) == 0;
        function_dc0f6e5f65b7c0c( shock );
        
        if ( shouldapplyblur )
        {
            function_d76996499c11948a( shock );
        }
    }
    
    self.var_955518e3fd692fbd = 1;
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"gas_hallucination" ][ #"hash_fafb93cf2eff0b4b" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( gasbundle );
    }
    
    if ( self getscriptablehaspart( #"cradle_gas" ) && self getscriptablepartstate( #"cradle_gas", 1, 1 ) != #"enter_gas" )
    {
        self setscriptablepartstate( #"cradle_gas", #"enter_gas" );
    }
    
    while ( self.hallucinationtimer > 0 && isdefined( attacker ) && !self.var_193dad851d6389a4 )
    {
        if ( isdefined( trigger ) && isdefined( trigger.playersintrigger[ self getentitynumber() ] ) )
        {
            damage = level.hallucinationeffect.dot_damage ?? 0;
            
            if ( isdefined( self.var_9a1a934ae5b99d2 ) )
            {
                damage *= self.var_9a1a934ae5b99d2;
                utility::callsharedfunc( #"specialty_gas_trap_resist", #"activate" );
            }
            
            if ( damage > 0 )
            {
                self dodamage( damage, trigger.origin, attacker, trigger.trap, "MOD_GRENADE" );
            }
        }
        
        if ( !self.var_46c8e804135d46af )
        {
            function_2eb097e011333750( 0 );
            childthread function_ecdaac79558cbea0( attacker );
        }
        
        if ( !self.gascoughinprogress )
        {
            function_b40b196978589f78( 0 );
            
            if ( gasbundle.gas_trap_cough )
            {
                childthread function_cb34c58ba3ad40fb( attacker, 0 );
                white_phosphorus::enableloopingcoughaudio();
            }
        }
        
        self.hallucinationtimer -= level.hallucinationeffect.dot_interval;
        
        if ( self.gastriggerstouching.size >= 1 )
        {
            self.hallucinationtimer = max( level.hallucinationeffect.maxtime, self.hallucinationtimer ?? 0 );
            self function_801f1f2c5f789ae1( shock, level.hallucinationeffect.dot_interval );
        }
        
        wait level.hallucinationeffect.dot_interval;
    }
    
    function_1e8c2b46ef66684e( mine, 0, shock, attacker, gasbundle, attackerentnum );
}

// Namespace gas_trap
// Params 1
// Checksum 0x3725eae2, Offset: 0x2de9
// Size: 0x1f3
function add_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        self.var_30656af96b2ac2a4[ self.var_30656af96b2ac2a4.size ] = params.combatlink;
        
        if ( !self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] )
        {
            basepoints = rank::getscoreinfovalue( #"hash_ea84408cd4306f2" ) ?? 0;
            params.combatlink.owner thread points::doscoreevent( #"hash_ea84408cd4306f2", params.combatlink.weapon_object, basepoints * params.combatlink.var_352099d9d2836866 );
            
            if ( !isdefined( self.var_2695e71ddf32816c ) )
            {
                self.var_2695e71ddf32816c = [];
            }
            
            self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] = 1;
        }
        
        if ( params.combatlink.owner != self.owner && !self.var_2b2f786d6b12c032 )
        {
            self.owner thread points::doscoreevent( #"hash_5ffd6a7c85f19d10", params.combatlink.weapon_object );
            self.var_2b2f786d6b12c032 = 1;
        }
        
        if ( self.var_30656af96b2ac2a4.size == 1 )
        {
            if ( isdefined( self.headiconid ) && isdefined( self.bundle.buffedheadicon ) )
            {
                setheadiconimage( self.headiconid, self.bundle.buffedheadicon, 1 );
            }
            
            self.var_48d6bc4ec1942918 = params.bundle.var_66f14d94900daba3 ?? 2;
        }
    }
}

// Namespace gas_trap
// Params 1
// Checksum 0xff6e272a, Offset: 0x2fe4
// Size: 0xb9
function remove_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        if ( arraycontains( self.var_30656af96b2ac2a4, params.combatlink ) )
        {
            self.var_30656af96b2ac2a4 = arrayremove( self.var_30656af96b2ac2a4, params.combatlink );
            
            if ( self.var_30656af96b2ac2a4.size <= 0 )
            {
                if ( isdefined( self.headiconid ) && isdefined( level.gamemodebundle.var_a43747faa623d1b0 ) )
                {
                    setheadiconimage( self.headiconid, level.gamemodebundle.var_a43747faa623d1b0, 1 );
                }
                
                self.var_48d6bc4ec1942918 = 1;
            }
        }
    }
}

// Namespace gas_trap
// Params 1
// Checksum 0xf83f116d, Offset: 0x30a5
// Size: 0x22
function function_2eb097e011333750( fromdeath )
{
    self notify( #"hash_920b86840a2aae7a" );
    self.var_46c8e804135d46af = undefined;
}

// Namespace gas_trap
// Params 0
// Checksum 0xa3240299, Offset: 0x30cf
// Size: 0x130
function function_e19ac660c03ad8ed()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_gas_trap" );
    shock = bundle.var_9e8bf7e91341019e ?? %"cer_gas_trap_heavy_mp";
    
    if ( isdefined( self.perks[ "specialty_gas_trap_resist" ] ) )
    {
        shock = bundle.gas_trap_light_shock ?? %"cer_gas_trap_light_mp";
    }
    else if ( isdefined( self.gastriggerstouching ) )
    {
        foreach ( trigger in self.gastriggerstouching )
        {
            if ( isdefined( trigger ) && trigger.owner == self )
            {
                /#
                    if ( getdvarint( @"hash_6c7fd12a611ca1e8", 0 ) == 1 )
                    {
                        break;
                    }
                #/
                
                shock = bundle.gas_trap_light_shock ?? %"cer_gas_trap_light_mp";
            }
        }
    }
    
    return shock;
}

// Namespace gas_trap
// Params 1
// Checksum 0x45352044, Offset: 0x3208
// Size: 0x186
function function_ecdaac79558cbea0( attacker )
{
    self notify( #"hash_920b86840a2aae7a" );
    self endon( #"hash_920b86840a2aae7a" );
    self.var_46c8e804135d46af = 1;
    numberping = randomintrange( level.hallucinationeffect.var_b375458270da1d01 ?? 5, level.hallucinationeffect.var_b3983782710045ef ?? 10 );
    
    if ( isdefined( attacker ) )
    {
        pinglocationenemyteams( self.origin, attacker.team, self, numberping, level.hallucinationeffect.radar_ping_magnitude ?? 10, self, level.hallucinationeffect.var_9811c005edc23ca4 ?? 500, level.hallucinationeffect.var_60977393994277e3 ?? 3000, level.hallucinationeffect.var_60bb6993996adc9d ?? 4500 );
    }
    
    gunfirex = randomfloatrange( -1000, 1000 );
    gunfirey = randomfloatrange( -1000, 1000 );
    var_7c170ceae0649b57 = [ #"teamselect", self getentitynumber() ];
    gunfireentity = spawnscriptable( "equip_gas_hallucination_gunfire_sat_mp_noentity", self.origin + ( gunfirex, gunfirey, 0 ), undefined, undefined, var_7c170ceae0649b57 );
    gunfireentity thread function_f9e50e2e1cd43f9f();
    wait randomfloatrange( 0.7, 2.2 );
    self.var_46c8e804135d46af = 0;
}

// Namespace gas_trap
// Params 0, eflags: 0x4
// Checksum 0x48d092dd, Offset: 0x3396
// Size: 0x1b
function private function_f9e50e2e1cd43f9f()
{
    self endon( #"death" );
    wait 2;
    
    if ( self )
    {
        self freescriptable();
    }
}

// Namespace gas_trap
// Params 1
// Checksum 0x230cd3cf, Offset: 0x33b9
// Size: 0x26
function function_dc0f6e5f65b7c0c( shock )
{
    shellshock_utility_cpmp::_shellshock( shock, #"stun", 0.75, 0, 100 );
}

// Namespace gas_trap
// Params 1
// Checksum 0xe2ed25e9, Offset: 0x33e7
// Size: 0x8e
function function_d76996499c11948a( shock )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_gas_trap" );
    [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_382df7654f0561bd" ] ]]( { #postfxbundlename:bundle.gastrappbgpostfxbundle ?? %"cer_hallucination_gas" }, 1, 1 );
    shellshock_utility_cpmp::_shellshock( shock, #"gas", level.hallucinationeffect.maxtime, 0 );
}

// Namespace gas_trap
// Params 1
// Checksum 0x180f46e1, Offset: 0x347d
// Size: 0x70
function function_27f4d92797d1ac9f( fromdeath )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_gas_trap" );
    self notify( #"hash_ef682c53bb35ccd5" );
    [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_494b07757cd511a5" ] ]]( { #postfxbundlename:bundle.gastrappbgpostfxbundle ?? %"cer_hallucination_gas" } );
}

// Namespace gas_trap
// Params 2
// Checksum 0xfd243387, Offset: 0x34f5
// Size: 0x9f
function function_cb34c58ba3ad40fb( attacker, fromimpact )
{
    var_f51647acde95eb6d = isdefined( self.perks[ "specialty_gas_grenade_resist" ] );
    var_b660048a0793257a = self == attacker;
    
    if ( !var_b660048a0793257a && var_f51647acde95eb6d )
    {
        return;
    }
    
    isheavy = 0;
    
    if ( fromimpact )
    {
        isheavy = 1;
        
        if ( var_b660048a0793257a )
        {
            isheavy = 0;
            
            /#
                if ( getdvarint( @"hash_6c7fd12a611ca1e8", 0 ) == 1 )
                {
                    isheavy = 1;
                }
            #/
        }
    }
    
    if ( !self.gascoughinprogress || fromimpact )
    {
        thread function_1f9161c782c106ce( isheavy );
    }
}

// Namespace gas_trap
// Params 1
// Checksum 0xc3ae9e3b, Offset: 0x359c
// Size: 0xf4
function function_1f9161c782c106ce( isheavy )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_9edb6e07af04c44b" );
    self endon( #"gas_trap_exited" );
    self notify( #"hash_136c1b3942561ec9" );
    self endon( #"hash_136c1b3942561ec9" );
    var_458c575e2b8c77cf = gettime() + 1000;
    
    while ( function_ebd50160a5376423() )
    {
        waitframe();
    }
    
    if ( isheavy && gettime() > var_458c575e2b8c77cf )
    {
        isheavy = 0;
    }
    
    var_6b728440205d689a = getdvarint( @"hash_827901421ad0679", 1 ) == 1;
    
    if ( var_6b728440205d689a )
    {
        thread function_ef4199d42d78d42c( isheavy );
        return;
    }
    
    self endon( #"hash_8e6f2c6e87a0f551" );
    self.gascoughinprogress = 1;
    
    if ( isheavy )
    {
        self playgestureviewmodel( "iw9_ges_gas_cough_long" );
        wait 3.33;
    }
    else
    {
        self playgestureviewmodel( "iw9_ges_gas_cough" );
        wait 1.833;
    }
    
    self.gascoughinprogress = undefined;
}

// Namespace gas_trap
// Params 1
// Checksum 0xb5d21d78, Offset: 0x3698
// Size: 0x119
function function_ef4199d42d78d42c( isheavy )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_9edb6e07af04c44b" );
    self notify( #"hash_8e6f2c6e87a0f551" );
    self endon( #"hash_8e6f2c6e87a0f551" );
    self.gascoughinprogress = 1;
    
    if ( self hasweapon( makeweapon( "gas_cough_light_mp" ) ) )
    {
        inventory_utility::_takeweapon( "gas_cough_light_mp" );
    }
    
    if ( self hasweapon( makeweapon( "gas_cough_heavy_mp" ) ) )
    {
        inventory_utility::_takeweapon( "gas_cough_heavy_mp" );
    }
    
    weaponobj = isheavy ? makeweapon( "gas_cough_heavy_mp" ) : makeweapon( "gas_cough_light_mp" );
    duration = isheavy ? 3.33 : 1.833;
    self giveandfireoffhand( weaponobj );
    childthread function_fa6a9c966b6a5ca7( weaponobj );
    childthread function_ac0b8263514032e8( weaponobj );
    childthread function_92058a98c3900c89( duration );
    utility::waittill_any( "gas_trap_coughWeaponFired", "gas_trap_coughWeaponTaken", "gas_trap_coughDuration" );
    
    if ( self hasweapon( weaponobj ) )
    {
        inventory_utility::_takeweapon( weaponobj );
    }
    
    self.gascoughinprogress = undefined;
}

// Namespace gas_trap
// Params 1
// Checksum 0x442b5a, Offset: 0x37b9
// Size: 0x2e
function function_696c64600f290435( fromdeath )
{
    self notify( #"hash_136c1b3942561ec9" );
    self notify( #"hash_8e6f2c6e87a0f551" );
    self.gascoughinprogress = undefined;
}

// Namespace gas_trap
// Params 1
// Checksum 0x286ed683, Offset: 0x37ef
// Size: 0xb1
function function_b40b196978589f78( fromdeath )
{
    self notify( #"gas_trap" );
    self notify( #"hash_8e6f2c6e87a0f551" );
    self.gascoughinprogress = undefined;
    white_phosphorus::disableloopingcoughaudio();
    
    if ( !fromdeath )
    {
        var_6b728440205d689a = getdvarint( @"hash_827901421ad0679", 1 ) == 1;
        
        if ( var_6b728440205d689a )
        {
            if ( self hasweapon( makeweapon( "gas_cough_light_mp" ) ) )
            {
                inventory_utility::_takeweapon( "gas_cough_light_mp" );
            }
            
            if ( self hasweapon( makeweapon( "gas_cough_heavy_mp" ) ) )
            {
                inventory_utility::_takeweapon( "gas_cough_heavy_mp" );
            }
            
            return;
        }
        
        self stopgestureviewmodel( "iw9_ges_gas_cough" );
        self stopgestureviewmodel( "iw9_ges_gas_cough_long" );
    }
}

// Namespace gas_trap
// Params 1
// Checksum 0x330910d5, Offset: 0x38a8
// Size: 0x5e
function function_fa6a9c966b6a5ca7( var_2d0bf388453117d1 )
{
    self endon( #"gas_trap_coughWeaponTaken" );
    self endon( #"gas_trap_coughDuration" );
    
    while ( true )
    {
        self waittill( #"offhand_fired", weaponobj );
        
        if ( issameweapon( weaponobj, var_2d0bf388453117d1 ) )
        {
            break;
        }
    }
    
    self notify( #"gas_trap_coughWeaponFired" );
}

// Namespace gas_trap
// Params 1
// Checksum 0x502ad3d1, Offset: 0x390e
// Size: 0x3e
function function_ac0b8263514032e8( var_2d0bf388453117d1 )
{
    self endon( #"gas_trap_coughWeaponFired" );
    self endon( #"gas_trap_coughDuration" );
    
    while ( self hasweapon( var_2d0bf388453117d1 ) )
    {
        waitframe();
    }
    
    self notify( #"gas_trap_coughWeaponTaken" );
}

// Namespace gas_trap
// Params 1
// Checksum 0x5a484c30, Offset: 0x3954
// Size: 0x33
function function_92058a98c3900c89( coughduration )
{
    self endon( #"gas_trap_coughWeaponTaken" );
    self endon( #"gas_trap_coughWeaponFired" );
    wait coughduration;
    self notify( #"gas_trap_coughDuration" );
}

// Namespace gas_trap
// Params 0
// Checksum 0x8e059881, Offset: 0x398f
// Size: 0x27, Type: bool
function function_ebd50160a5376423()
{
    if ( !val::get( "cough_gesture" ) )
    {
        return true;
    }
    
    if ( !val::get( "offhand_weapons" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace gas_trap
// Params 6
// Checksum 0xb6a3680d, Offset: 0x39bf
// Size: 0x258
function function_1e8c2b46ef66684e( mine, fromdeath, shock, attacker, gasbundle, attackerentnum )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"gas_hallucination" ][ #"hash_f00f78b8f103a397" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( gasbundle );
    }
    
    isscriptableinstance = self isscriptableinstance();
    assert( isscriptableinstance, "<dev string:xe8>" + self.name );
    
    if ( isplayer( self ) && isscriptableinstance && self getscriptablehaspart( #"cradle_gas" ) && self getscriptablepartstate( #"cradle_gas", 1, 1 ) != #"exit_gas" )
    {
        self setscriptablepartstate( #"cradle_gas", #"exit_gas" );
    }
    
    if ( isdefined( shock ) && !self.var_193dad851d6389a4 )
    {
        function_dc0f6e5f65b7c0c( shock );
    }
    
    self.var_955518e3fd692fbd = 0;
    
    if ( isdefined( self.var_dc025d4b9929cb1f ) )
    {
        self.var_dc025d4b9929cb1f.attackers[ attackerentnum ] = undefined;
    }
    
    if ( isdefined( attacker ) )
    {
        challenges::function_ead174660f144273( attacker, "super_gas_trap" );
    }
    
    self.hallucinationtimer = undefined;
    function_27f4d92797d1ac9f( fromdeath );
    function_b40b196978589f78( fromdeath );
    function_2eb097e011333750( fromdeath );
    
    if ( isdefined( mine ) )
    {
        telemetry_mp::function_edb43d25c7bd56c6( self, mine.weapon_object, mine getentitynumber() );
    }
    
    if ( isdefined( self.gastriggerstouching ) )
    {
        foreach ( trigger in self.gastriggerstouching )
        {
            if ( !isdefined( trigger ) )
            {
                continue;
            }
            
            trigger.playersintrigger[ self getentitynumber() ] = undefined;
        }
    }
    
    self.gastriggerstouching = undefined;
    
    if ( isdefined( self ) && self function_5c766d1d0140b86( "ui_br_player_is_in_gas_from_grenade" ) )
    {
        self setclientomnvar( "ui_br_player_is_in_gas_from_grenade", 0 );
    }
}

// Namespace gas_trap
// Params 1
// Checksum 0xf6ecb7e, Offset: 0x3c1f
// Size: 0x25, Type: bool
function function_8de1f4bd0dc11222( player )
{
    if ( player function_65267a768ced48a0() )
    {
        return true;
    }
    
    if ( player ismeatshieldvictim() )
    {
        return true;
    }
    
    return false;
}

// Namespace gas_trap
// Params 0
// Checksum 0x703b610, Offset: 0x3c4d
// Size: 0xa
function function_cf9f8bce8165ccd5()
{
    thread gas_trap_delete( 0 );
}

// Namespace gas_trap
// Params 1, eflags: 0x4
// Checksum 0x84e4074d, Offset: 0x3c5f
// Size: 0x25
function private onpullback( params )
{
    if ( weapon::function_ecbdce6df0e16a2a( #"super_gas_trap" ) )
    {
        weapons::denyusage();
    }
}

