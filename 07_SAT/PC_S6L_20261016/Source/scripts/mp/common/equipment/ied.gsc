// scripts\mp\common\equipment\ied.gsc  (hash_548343c84a710bdd.gscc) (size: 9493 Bytes / 0x2515 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc52b5939 (3307952441)
// size ...... 9493 (0x2515)
// includes .. 18  (offset: 0x22c5)
// strings ... 28  (offset: 0x2355)
// dev strs .. 3   (offset: 0x24f1)
// exports ... 24  (offset: 0x1369)
// cseg ...... 0x1d6 + 0x1193 (0x1369)
// imports ... 98  (offset: 0x1729)
// animtree1 . 0   (offset: 0x2515)
// animtree2 . 0   (offset: 0x2515)
#using script_16ea1b94f0f381b3;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\perks\perk_equipmentping;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\damagefeedback;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\equipment_interact;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace ied;

// Namespace ied
// Params 0, eflags: 0x1
// Checksum 0x7a14cefb, Offset: 0x1f4
// Size: 0x9
function autoexec main()
{
    ied_init();
}

// Namespace ied
// Params 0
// Checksum 0x2efb3561, Offset: 0x205
// Size: 0x31
function ied_init()
{
    weapons::registerusedcallback( "ied", &ied_used );
    utility::registersharedfunc( #"ied", #"hack", &equip_ied_hack );
}

// Namespace ied
// Params 1
// Checksum 0x91a6ae49, Offset: 0x23e
// Size: 0x2e5
function ied_used( grenade )
{
    ref = equipment_mp::function_fdc4a655fbde0dec( grenade.weapon_name );
    grenade.tableinfo = weapon::getequipmenttableinfo( ref );
    
    if ( !isdefined( grenade.tableinfo.bundle ) )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    else
    {
        self endon( #"death" );
    }
    
    grenade endon( #"death" );
    
    if ( utility::issharedfuncdefined( #"jamming_system", #"hash_ca0042e3cac99672" ) )
    {
        grenade [[ utility::getsharedfunc( #"jamming_system", #"hash_ca0042e3cac99672" ) ]]( grenade );
    }
    
    grenade.bundle = equipment_mp::getEquipmentBundleFromWeaponName( grenade.weapon_name );
    
    /#
        print::printgameaction( "<dev string:x38>", grenade.owner );
    #/
    
    grenade ent_manager::registerspawn( 1, &ied_entmanagerdelete );
    
    if ( !isdefined( self.ieds ) )
    {
        self.ieds = [];
    }
    
    self.ieds[ self.ieds.size ] = grenade;
    grenade.var_736c0b69e68cc5a0 = isdefined( self.perks[ "specialty_rugged_equipment" ] );
    
    if ( isdefined( self.perks[ "specialty_rugged_eqp" ] ) )
    {
        grenade.hasruggedeqp = 1;
    }
    
    grenade thread weapons::minedamagemonitor();
    grenade thread ied_destroyongameend();
    grenade thread function_f79788ba9f23273f();
    grenade thread equipment_interact::remoteinteractsetup( &ied_detonate, 1, 1 );
    thread weapons::monitordisownedgrenade( self, grenade );
    grenade thread function_75d9e7b243c89032();
    grenade waittill( #"missile_stuck" );
    grenade.stucktime = gettime();
    grenade thread function_39029090c62db15d();
    
    if ( grenade.tableinfo.bundle.var_ef25cfaf906824b )
    {
        grenade thread function_228904be9239685f();
    }
    else
    {
        grenade thread function_3f4f2c84dc86e78f();
    }
    
    grenade setotherent( self );
    grenade setnodeploy( 1 );
    weapons::onequipmentplanted( grenade, "equip_ied", &ied_delete );
    thread weapons::monitordisownedequipment( self, grenade );
    grenade sentientpoolmanager::registersentient( "Lethal_Static", grenade.owner, 1 );
    grenade namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( grenade, &ied_empapplied );
    
    if ( level.var_36218e71baa7e689 )
    {
        grenade.var_c5ccf9dff3b5e393 = &ied_empapplied;
    }
    
    grenade thread perk_equipmentping::runequipmentping();
    grenade setscriptablepartstate( "effects", "plant", 0 );
    thread weapons::outlineequipmentforowner( grenade );
    grenade missilethermal();
    grenade missileoutline();
    grenade.headiconid = entityheadicons::setheadicon_equipment( grenade );
    utility::function_969f9f5596dba07a( grenade, &ied_destroy );
}

// Namespace ied
// Params 0, eflags: 0x4
// Checksum 0xd8913bac, Offset: 0x52b
// Size: 0x25
function private function_75d9e7b243c89032()
{
    if ( self isscriptable() )
    {
        wait 0.05;
        
        if ( self )
        {
            self setscriptablepartstate( "visibility", "show", 0 );
        }
    }
}

// Namespace ied
// Params 0
// Checksum 0xc5ba54b4, Offset: 0x558
// Size: 0xc9
function function_39029090c62db15d()
{
    self endon( #"death" );
    activationdelay = self.bundle.ied_activationdelay ?? 0.5;
    wait activationdelay;
    wasinwater = utility::ispointinwater( self.origin );
    self.currtrigger = ied_createtrigger( wasinwater );
    
    while ( true )
    {
        inwater = utility::ispointinwater( self.origin );
        
        if ( wasinwater != inwater )
        {
            if ( isdefined( self.currtrigger ) )
            {
                self.currtrigger unlink();
                self.currtrigger delete();
            }
            
            self.currtrigger = ied_createtrigger( inwater );
            wasinwater = inwater;
        }
        
        waitframe();
    }
}

// Namespace ied
// Params 1
// Checksum 0x2667dc5, Offset: 0x629
// Size: 0x12f
function ied_createtrigger( inwater )
{
    self notify( #"hash_4de093734b77621b" );
    
    if ( inwater )
    {
        trigger = spawn( "trigger_rotatable_radius", self.origin, 0, self.bundle.var_52100fdd7c5e40a ?? 100, ( self.bundle.var_5e6693c13b108c7 ?? 50 ) * 2 );
        trigger enablelinkto();
        trigger linkto( self, "tag_origin", ( 0, 0, -1 * ( self.bundle.var_5e6693c13b108c7 ?? 50 ) ), ( 0, 0, 0 ) );
    }
    else
    {
        trigger = spawn( "trigger_rotatable_radius", self.origin, 0, self.bundle.ied_triggerradius ?? 100, self.bundle.ied_triggerheight ?? 50 );
        trigger enablelinkto();
        trigger linkto( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    thread ied_watchtrigger( trigger );
    return trigger;
}

// Namespace ied
// Params 1
// Checksum 0x9658aba3, Offset: 0x761
// Size: 0x6c
function ied_watchtrigger( trigger )
{
    self endon( #"hash_4de093734b77621b" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( trigger ) )
        {
            return;
        }
        
        trigger waittill( #"trigger", ent );
        assert( isdefined( ent ) );
        self notify( #"trigger_ied", [ ent ] );
    }
}

// Namespace ied
// Params 0
// Checksum 0xf9660689, Offset: 0x7d5
// Size: 0x205
function function_228904be9239685f()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger_ied", ents );
        assert( isdefined( ents ) );
        
        if ( !function_5a5f1beeff362649() )
        {
            continue;
        }
        
        foreach ( ent in ents )
        {
            if ( isagent( ent ) || isplayer( ent ) )
            {
                if ( !player_utility::playersareenemies( self.owner, ent ) )
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
                    delayapplied = equipment_mp::function_84f2f5566ba29655( ent, ent.var_ff102e941e8065c, 100 );
                    
                    if ( delayapplied )
                    {
                        continue;
                    }
                }
                
                victimvelocity = ent getentityvelocity();
                victimstance = "stand";
                
                if ( !isscriptedagent( ent ) )
                {
                    victimstance = ent getstance();
                }
                else if ( isdefined( ent.currentpose ) )
                {
                    victimstance = ent.currentpose;
                }
                
                if ( victimstance == "stand" )
                {
                    if ( int( length2dsquared( victimvelocity ) ) < 16900 && int( abs( victimvelocity[ 2 ] ) ) < 95 )
                    {
                        continue;
                    }
                }
                else if ( int( length2dsquared( victimvelocity ) ) < 32400 && int( abs( victimvelocity[ 2 ] ) ) < 95 )
                {
                    continue;
                }
                
                utility::callsharedfunc( #"weapons", #"explosivetrigger", ent, 0 );
                thread ied_detonate();
                return;
            }
        }
    }
}

// Namespace ied
// Params 0
// Checksum 0x6da4a62f, Offset: 0x9e2
// Size: 0x124
function function_3f4f2c84dc86e78f()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger_ied", ents );
        assert( isdefined( ents ) );
        
        if ( !function_5a5f1beeff362649() )
        {
            continue;
        }
        
        foreach ( ent in ents )
        {
            if ( isagent( ent ) || isplayer( ent ) )
            {
                if ( !player_utility::playersareenemies( self.owner, ent ) )
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
                
                utility::callsharedfunc( #"weapons", #"explosivetrigger", ent, 0 );
                thread ied_detonate();
                return;
            }
        }
    }
}

// Namespace ied
// Params 0
// Checksum 0x26092e7d, Offset: 0xb0e
// Size: 0x32
function function_f79788ba9f23273f()
{
    self endon( #"death" );
    self waittill( #"detonateexplosive", attacker );
    thread ied_destroy( attacker, 1 );
}

// Namespace ied
// Params 1
// Checksum 0x6d109a1b, Offset: 0xb48
// Size: 0xa2
function ied_detonate( attacker )
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    
    if ( isdefined( attacker ) )
    {
        attacker endon( #"disconnect" );
    }
    else
    {
        attacker = self.owner;
    }
    
    self setscriptablepartstate( "danger-icon", "on", 0 );
    self setscriptablepartstate( "effects", "trigger", 0 );
    detonationdelay = self.bundle.ied_detonationdelay ?? 0.5;
    wait detonationdelay;
    thread ied_explode( attacker );
}

// Namespace ied
// Params 1
// Checksum 0x5f730310, Offset: 0xbf2
// Size: 0x235
function ied_explode( attacker )
{
    /#
        print::printgameaction( "<dev string:x43>", self.owner );
    #/
    
    if ( self.owner != attacker && isdefined( self.weapon_object ) )
    {
        self.var_fc45abe6e88f52db = { #explode_attacker:attacker };
        telemetry_mp::function_80a95f340a7c8f67( attacker, attacker, self.weapon_object, self getentitynumber() );
    }
    
    level notify( #"explosion_extinguish", self.origin, 256, self.owner, self );
    deletiondelay = undefined;
    statename = undefined;
    caststart = self.origin;
    contents = trace::create_contents( 0, 1, 1, 0, 1, 1, 0, 0, 0 );
    updot = vectordot( ( 0, 0, 1 ), anglestoup( self.angles ) );
    
    if ( abs( updot ) <= 0.81915 )
    {
        castend = caststart - anglestoup( self.angles ) * 5;
        castresults = physics_raycast( caststart, castend, contents, self, 0, "physicsquery_closest", 1 );
        
        if ( castresults.size > 0 )
        {
            deletiondelay = 5;
            statename = "explode";
        }
    }
    else if ( updot <= -0.96592 )
    {
        castend = caststart - anglestoup( self.angles ) * 5;
        castresults = physics_raycast( caststart, castend, contents, self, 0, "physicsquery_closest", 1 );
        
        if ( castresults.size > 0 )
        {
            deletiondelay = 5;
            statename = "explode";
        }
    }
    
    if ( !isdefined( deletiondelay ) )
    {
        castend = caststart - ( 0, 0, 1 ) * 20;
        castresults = physics_raycast( caststart, castend, contents, self, 0, "physicsquery_closest", 1 );
        
        if ( !isdefined( castresults ) || castresults.size <= 0 )
        {
            deletiondelay = 5;
            statename = "explodeAir";
        }
    }
    
    if ( !isdefined( deletiondelay ) )
    {
        deletiondelay = 5;
        statename = "explode";
    }
    
    thread ied_delete( deletiondelay );
    self setentityowner( attacker );
    self clearscriptabledamageowner();
    self setscriptablepartstate( "effects", statename, 0 );
    self setscriptablepartstate( "danger-icon", "off", 0 );
}

// Namespace ied
// Params 0
// Checksum 0x7a1a6bb1, Offset: 0xe2f
// Size: 0x9
function ied_entmanagerdelete()
{
    thread ied_delete();
}

// Namespace ied
// Params 2
// Checksum 0x367f9121, Offset: 0xe40
// Size: 0x51
function ied_destroy( attacker, fromdamage )
{
    if ( fromdamage )
    {
        thread ied_explode( attacker );
    }
    else
    {
        self setscriptablepartstate( "effects", "destroy", 0 );
        self setscriptablepartstate( "hacked", "neutral", 0 );
    }
    
    thread ied_delete( 5 );
}

// Namespace ied
// Params 1
// Checksum 0x35a01e30, Offset: 0xe99
// Size: 0x18a
function ied_delete( deletiondelay )
{
    self notify( #"death" );
    
    if ( weapon::function_89d2d0588f2def25() )
    {
        weapon::deregistermine();
    }
    
    thread telemetry_mp::function_e097bffa2fd8f2a0( self.var_fc45abe6e88f52db.explode_attacker, self.weapon_object, self getentitynumber(), 0 );
    
    if ( self isscriptable() )
    {
        self setscriptablepartstate( #"hack_usable", #"off", 0 );
    }
    
    self setcandamage( 0 );
    ent_manager::deregisterspawn();
    entityheadicons::setheadicon_deleteicon( self.headiconid );
    self.headiconid = undefined;
    self.exploding = 1;
    
    if ( isdefined( self.currtrigger ) )
    {
        self.currtrigger unlink();
        self.currtrigger delete();
    }
    
    owner = self.owner;
    
    if ( isdefined( owner ) )
    {
        owner weapons::removeequip( self );
    }
    
    thread function_7d459ee43a873bd5();
    
    if ( utility::issharedfuncdefined( #"jamming_system", #"hash_c33ceb91d0ca7a9d" ) )
    {
        self [[ utility::getsharedfunc( #"jamming_system", #"hash_c33ceb91d0ca7a9d" ) ]]( self );
    }
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
    }
    
    if ( isdefined( owner ) && isdefined( owner.ieds ) )
    {
        if ( arraycontains( owner.ieds, self ) )
        {
            owner.ieds = arrayremove( owner.ieds, self );
        }
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace ied
// Params 0
// Checksum 0xc4d67c7d, Offset: 0x102b
// Size: 0x4a
function function_7d459ee43a873bd5()
{
    self endon( #"death" );
    wait 0.5;
    parent = self getlinkedparent();
    
    if ( isdefined( parent ) )
    {
        parent waittill( #"death" );
        self setscriptablepartstate( "effects", "neutral", 0 );
    }
}

// Namespace ied
// Params 1
// Checksum 0xdbb31e19, Offset: 0x107d
// Size: 0x9a
function ied_empapplied( data )
{
    attacker = data.attacker;
    self notify( #"enemy_destroyed_equipment", attacker );
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker equipment_mp::function_ada7da3083a6c593( self );
    }
    
    damagefeedback = "";
    
    if ( self.hasruggedeqp || self.var_736c0b69e68cc5a0 )
    {
        damagefeedback = "hitequip";
    }
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( damagefeedback );
    }
    
    thread ied_destroy( attacker );
}

// Namespace ied
// Params 1
// Checksum 0x2c9b347, Offset: 0x111f
// Size: 0x8c
function ied_haywireapplied( data )
{
    attacker = data.attacker;
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker equipment_mp::function_ada7da3083a6c593( self );
    }
    
    damagefeedback = "";
    
    if ( self.hasruggedeqp || self.var_736c0b69e68cc5a0 )
    {
        damagefeedback = "hitequip";
    }
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( damagefeedback );
    }
    
    ied_explode( attacker );
}

// Namespace ied
// Params 1
// Checksum 0xbe1aa9fd, Offset: 0x11b3
// Size: 0x67
function ied_disable( attacker )
{
    self endon( #"death" );
    attacker thread points::doscoreevent( #"disabled_c4" );
    self.isdisabled = 1;
    self setscriptablepartstate( "emp", "on", 0 );
    wait 6;
    self setscriptablepartstate( "emp", "off", 0 );
    self.isdisabled = 0;
}

// Namespace ied
// Params 0
// Checksum 0xcb88c89c, Offset: 0x1222
// Size: 0x27
function ied_destroyongameend()
{
    self endon( #"death" );
    level utility::waittill_any( "game_ended", "bro_shot_start" );
    thread ied_destroy();
}

// Namespace ied
// Params 0
// Checksum 0xe0a78e59, Offset: 0x1251
// Size: 0x67, Type: bool
function function_5a5f1beeff362649()
{
    if ( self.isdisabled || self.isjammed )
    {
        return false;
    }
    
    activationdelay = self.bundle.ied_activationdelay ?? 0.5;
    return isdefined( self.stucktime ) && ( gettime() - self.stucktime ) / 1000 > activationdelay;
}

// Namespace ied
// Params 1
// Checksum 0x711c5644, Offset: 0x12c1
// Size: 0x20
function ied_onownerchanged( oldowner )
{
    if ( self.exploding )
    {
        return;
    }
    
    thread ied_destroy();
}

// Namespace ied
// Params 2, eflags: 0x4
// Checksum 0xf49b3c63, Offset: 0x12e9
// Size: 0x80
function private equip_ied_hack( hackeffect, attacker )
{
    self notify( #"equip_ied_hacked" );
    
    if ( !hackeffect.var_30e7de3d76d5a085 )
    {
        return;
    }
    
    self.owner thread equipment_utility::function_364a1a0e0c018518( self.equipmentref, #"stolen_hacked" );
    equipment_mp::hackequipment( attacker, hackeffect.var_fe6111ff085b2063 );
    self setscriptablepartstate( #"hacked", #"stolen", 0 );
}

