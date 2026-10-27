// scripts\mp\common\equipment\emp_grenade.gsc  (hash_10ee8387e1dbb150.gscc) (size: 10533 Bytes / 0x2925 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x47c59720 (1204131616)
// size ...... 10533 (0x2925)
// includes .. 21  (offset: 0x272d)
// strings ... 17  (offset: 0x27d5)
// dev strs .. 3   (offset: 0x2901)
// exports ... 20  (offset: 0x1a65)
// cseg ...... 0x17d + 0x18e8 (0x1a65)
// imports ... 82  (offset: 0x1d85)
// animtree1 . 0   (offset: 0x2925)
// animtree2 . 0   (offset: 0x2925)
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\equipment_common;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\emp_debuff;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\gamescore;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace emp_grenade;

// Namespace emp_grenade
// Params 0, eflags: 0x5
// Checksum 0xa7d453c8, Offset: 0x19b
// Size: 0x14
function private autoexec preinit_emp_grenade()
{
    level callback::add( "init_grenade", &emp_init );
}

// Namespace emp_grenade
// Params 1
// Checksum 0x5a8575f4, Offset: 0x1b7
// Size: 0x106
function emp_init( params )
{
    weapons::registerusedcallback( "emp_grenade", &emp_grenade_used );
    weapons::function_2cd25260a11d5e40( "emp_grenade", &emp_pullback );
    level callback::add( #"hash_2709fd1dd4cef88d", &function_38cf8364e4d8e652 );
    level callback::add( #"hash_eb54ccc016130a88", &on_player_elim );
    
    if ( !isdefined( level.empgrenadesettings ) )
    {
        bundle = level.equipment.table[ "equip_emp" ].bundle;
        level.empgrenadesettings = {};
        level.empgrenadesettings.var_8a2c2a952c83b5d6 = bundle.var_8a2c2a952c83b5d6 ?? 0;
        level.empgrenadesettings.var_9e836a45e10f7a06 = bundle.var_f58fb49064506aa ?? 0;
        level.empgrenadesettings.emp_grenade_do_stun = bundle.emp_grenade_do_stun;
    }
}

// Namespace emp_grenade
// Params 1
// Checksum 0x42505192, Offset: 0x2c5
// Size: 0x7b
function emp_pullback( params )
{
    self.var_552a1754d1897caa = undefined;
    bundle = equipment::function_3637cad9a44ab42( "equip_emp" );
    
    if ( bundle.var_e36b84555e7df1d3 && params.weaponobject hasattachmenthash( bundle.var_e36b84555e7df1d3 ) )
    {
        self setclientomnvar( "ui_show_9bang_submunition_count", 1 );
        self setclientomnvar( "ui_9bang_submunition_count", 0 );
        thread function_1bde04190dd472f0( bundle );
    }
}

// Namespace emp_grenade
// Params 1
// Checksum 0x4538382d, Offset: 0x348
// Size: 0xb4
function function_1bde04190dd472f0( bundle )
{
    self endon( #"disconnect", #"hash_5ba67e0118c2dc6" );
    childthread function_be1ae158dd132d49();
    submunitiondata = bundle.var_b7044fb08a562952 ?? [];
    timepassed = 0;
    
    for ( i = 0; i < submunitiondata.size ; i++ )
    {
        threshold = submunitiondata[ i ].var_4b29cf9954060056;
        var_b18172b327a1026b = threshold - timepassed;
        wait var_b18172b327a1026b;
        timepassed += var_b18172b327a1026b;
        self setclientomnvar( "ui_9bang_submunition_count", i + 1 );
        self.var_552a1754d1897caa = i + 1;
    }
}

// Namespace emp_grenade
// Params 0
// Checksum 0x684c185b, Offset: 0x404
// Size: 0x33
function function_be1ae158dd132d49()
{
    self waittill( #"death" );
    self setclientomnvar( "ui_show_9bang_submunition_count", 0 );
    self setclientomnvar( "ui_9bang_submunition_count", 0 );
    self notify( #"hash_5ba67e0118c2dc6" );
}

// Namespace emp_grenade
// Params 1
// Checksum 0x18fa6f09, Offset: 0x43f
// Size: 0x2fe
function emp_grenade_used( grenade )
{
    self endon( #"disconnect" );
    grenade endon( #"explode_end" );
    grenade thread script::notifyafterframeend( "death", "explode_end" );
    ref = equipment_mp::getequipmentreffromweapon( grenade.weapon_object );
    grenade.tableinfo = equipment_mp::getequipmenttableinfo( ref );
    bundle = grenade.tableinfo.bundle;
    grenade.owner = self;
    grenade setentityowner( self );
    grenade setotherent( self );
    grenade.grenadeid = grenade getentitynumber();
    scoreeventoverride = bundle.var_11063a6198dbd08b ?? 0;
    
    if ( scoreeventoverride )
    {
        grenade.var_7563c9e8d353ca9a = &function_7fc200565a3156d9;
    }
    
    if ( grenade getscriptablepartstate( "windup" ) == "inactive" )
    {
        grenade setscriptablepartstate( "windup", "active" );
    }
    
    damageradius = grenade.weapon_object ? getgrenadedamageradius( grenade.weapon_object ) : getgrenadedamageradius( "emp_grenade_mp" );
    grenade.detonation_radius = damageradius;
    
    if ( bundle.var_c7709714d768097c && grenade.weapon_object hasattachmenthash( bundle.var_c7709714d768097c ) )
    {
        var_b2df48f9f91e6cfb = bundle.var_de96864b85b581a6 ?? 1.2;
        grenade.detonation_radius *= var_b2df48f9f91e6cfb;
    }
    
    if ( bundle.var_e36b84555e7df1d3 && grenade.weapon_object hasattachmenthash( bundle.var_e36b84555e7df1d3 ) )
    {
        grenade.scoreeventlist = [];
        var_75efa27f660c7c41 = 1;
    }
    
    if ( !isweapondetonationtimed( grenade.weapon_object ) )
    {
        fusetime = bundle.var_32ebde154664fc8a ?? ( isai( self ) ? getgrenadefusetimeai( grenade.weapon_object ) : getgrenadefusetime( grenade.weapon_object ) ) * 0.001;
        
        if ( var_75efa27f660c7c41 )
        {
            self notify( #"hash_5ba67e0118c2dc6" );
            self setclientomnvar( "ui_show_9bang_submunition_count", 0 );
            self setclientomnvar( "ui_9bang_submunition_count", 0 );
            thread function_f0d9ea22132f8caa( grenade, bundle, fusetime );
        }
        else
        {
            grenade thread _emp_detonate( fusetime );
        }
    }
    else
    {
        assert( !var_75efa27f660c7c41, "<dev string:x24>" );
    }
    
    grenade waittill( #"explode", position );
    nonplayeremped = emp_apply_effect( grenade, position );
    
    if ( nonplayeremped < 1 )
    {
        return;
    }
    
    challenges::function_3d7a169dbae062fb( ref, self, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ), nonplayeremped );
}

// Namespace emp_grenade
// Params 1, eflags: 0xc
// Checksum 0x3b8aa99e, Offset: 0x745
// Size: 0x3d
function private _emp_detonate( fusetime )
{
    self notify( #"hash_11d71869d608e125" );
    self endon( #"hash_11d71869d608e125" );
    self endon( #"explode" );
    wait fusetime;
    
    if ( self )
    {
        self detonate();
    }
}

// Namespace emp_grenade
// Params 5
// Checksum 0xae631bb3, Offset: 0x78a
// Size: 0x4fb
function emp_apply_effect( grenade, position, issubmunition = 0, ignoreowner = 0, istactical = 1 )
{
    nonplayeremped = 0;
    detonation_radius = grenade.detonation_radius ?? 390;
    ents = emp_debuff::empdebuff_get_emp_ents( position, detonation_radius );
    objweapon = makeweapon( grenade.weapon_object.basenamehash ?? "emp_grenade_mp" );
    
    foreach ( ent in ents )
    {
        entowner = ent.owner;
        
        if ( isdefined( entowner ) )
        {
            if ( !player_utility::playersareenemies( self, entowner ) && !player_utility::playersareenemies( self, ent ) )
            {
                continue;
            }
            
            if ( ignoreowner && ( entowner == self || isdefined( entowner.team ) && isdefined( self.team ) && entowner.team == self.team ) )
            {
                continue;
            }
        }
        else if ( isplayer( ent ) )
        {
            continue;
        }
        
        if ( ignoreowner && ent vehicle::is_vehicle() && isdefined( self.team ) )
        {
            if ( vehicle::function_977daeae4e2f0e30( ent, self.team ) )
            {
                continue;
            }
        }
        
        callback::callback( #"hash_b99dff90394eb45e", { #objweapon:objweapon, #idamage:0, #inflictor:self, #attacker:self, #victim:ent } );
        data = damage_utility::packdamagedata( self, ent, 1, objweapon, "MOD_EXPLOSIVE", grenade, position );
        data.issubmunition = issubmunition;
        data.grenadeid = grenade.grenadeid;
        data.istactical = istactical;
        data.scoreevent = data.victim.bundle.empedscoreevent;
        
        if ( data.victim && isent( data.victim ) && isagent( data.victim ) )
        {
            var_1e11ba5d1468d64f = grenade.bundle.var_110adeca7d528363;
            
            if ( var_1e11ba5d1468d64f )
            {
                data.scoreevent = var_1e11ba5d1468d64f;
            }
        }
        
        thread function_8414fd72ca678da3( data );
        nonplayeremped++;
    }
    
    if ( nonplayeremped >= 3 )
    {
        thread points::doscoreevent( #"emp_triple_disrupt", objweapon );
    }
    
    players = getplayersinradius( position, detonation_radius );
    
    foreach ( player in players )
    {
        if ( ignoreowner && player == self )
        {
            continue;
        }
        
        if ( isdefined( player.perks[ "specialty_tac_mask" ] ) && isdefined( player.perks[ "specialty_emp_immunity" ] ) )
        {
            if ( level.gamemodebundle.var_7aa3d55e72a5c0d1 == #"right" )
            {
                player perks::function_142df1226093bce0( "specialty_tac_mask" );
            }
            else
            {
                player perks::activateperk( "specialty_tac_mask" );
            }
            
            continue;
        }
        else if ( isdefined( player.perks[ "specialty_emp_immunity" ] ) )
        {
            player utility::callsharedfunc( #"specialty_emp_immunity", #"activate" );
            continue;
        }
        
        if ( !player emp_debuff::can_be_empd() )
        {
            continue;
        }
        
        if ( player != self && !player_utility::playersareenemies( self, player ) )
        {
            continue;
        }
        
        data = damage_utility::packdamagedata( self, player, 1, objweapon, "MOD_EXPLOSIVE", grenade, position );
        data.issubmunition = issubmunition;
        data.grenadeid = grenade.grenadeid;
        
        if ( data.grenadeid && player != self )
        {
            data.scoreevent = player.var_7cd86348fc758d00 ?? #"emped_player";
        }
        
        thread _emp_grenade_apply_player( data );
    }
    
    return nonplayeremped;
}

// Namespace emp_grenade
// Params 3, eflags: 0x4
// Checksum 0x34f1f6e1, Offset: 0xc8e
// Size: 0x142
function private function_f0d9ea22132f8caa( grenade, bundle, var_8ca2dc3570ead67f )
{
    grenade endon( #"explode" );
    self endon( #"disconnect" );
    submunitiondata = bundle.var_b7044fb08a562952 ?? [];
    prevthreshold = -1;
    submunitioncount = min( self.var_552a1754d1897caa ?? 0, submunitiondata.size );
    
    for ( i = 0; i < submunitioncount ; i++ )
    {
        threshold = submunitiondata[ i ].var_4b29cf9954060056;
        
        if ( threshold > prevthreshold )
        {
            interval = submunitiondata[ i ].pro_fireinterval ?? 0;
            
            if ( interval > 0 )
            {
                wait interval;
            }
            
            thread function_87231feb546a65e3( grenade, 0.01, ( 0, 0, 0 ) );
            prevthreshold = threshold;
            continue;
        }
        
        assertmsg( "<dev string:x9e>" );
    }
    
    self.var_552a1754d1897caa = undefined;
    
    if ( prevthreshold == -1 )
    {
        interval = var_8ca2dc3570ead67f;
    }
    else
    {
        interval = bundle.var_cdd0b2ae1f1d23e6 ?? 0;
    }
    
    grenade thread _emp_detonate( interval );
}

// Namespace emp_grenade
// Params 3, eflags: 0x4
// Checksum 0x7069d1d3, Offset: 0xdd8
// Size: 0xdf
function private function_87231feb546a65e3( grenade, fusetime, launchvelocity )
{
    grenade endon( #"explode" );
    self endon( #"disconnect" );
    
    if ( grenade.origin )
    {
        var_fad30ec8a2f036ef = grenade.bundle.var_25880029ae607656;
        assert( var_fad30ec8a2f036ef, "<dev string:x122>" );
        submunitiongrenade = magicgrenademanual( var_fad30ec8a2f036ef, grenade.origin, launchvelocity, fusetime, self );
        
        if ( submunitiongrenade )
        {
            submunitiongrenade.owner = self;
            submunitiongrenade setentityowner( self );
            submunitiongrenade setotherent( self );
            submunitiongrenade waittill( #"explode", explodeposition );
            
            if ( grenade )
            {
                emp_apply_effect( grenade, explodeposition, 1 );
            }
        }
    }
}

// Namespace emp_grenade
// Params 1
// Checksum 0xcd9cb469, Offset: 0xebf
// Size: 0x23c
function function_7fc200565a3156d9( data )
{
    issubmunition = data.issubmunition;
    event = data.scoreevent;
    
    if ( data.attacker && data.victim && data.attacker != data.victim )
    {
        if ( isent( data.victim ) )
        {
            victimentnum = data.victim getentitynumber();
        }
        
        if ( !isent( data.victim ) || !isplayer( data.victim ) )
        {
            data.attacker thread damagefeedback::updatedamagefeedback( "hitequip" );
        }
        
        hitmarkersoundalias = utility::callsharedfunc( #"hud", #"hash_785d65fc31ffd85", 0 );
        
        if ( hitmarkersoundalias )
        {
            data.attacker playlocalsound( hitmarkersoundalias );
        }
        
        if ( !event )
        {
            return;
        }
        
        if ( issubmunition )
        {
            if ( data.inflictor.scoreeventlist )
            {
                if ( !data.inflictor.scoreeventlist[ victimentnum ] )
                {
                    if ( data.inflictor )
                    {
                        data.inflictor.scoreeventlist[ victimentnum ] = 1;
                    }
                    
                    data.attacker thread points::doscoreevent( event, data.objweapon );
                }
            }
            
            return;
        }
        
        if ( data.inflictor.scoreeventlist )
        {
            if ( !data.inflictor.scoreeventlist[ victimentnum ] )
            {
                if ( data.inflictor )
                {
                    data.inflictor.scoreeventlist[ victimentnum ] = 1;
                }
                
                data.attacker thread points::doscoreevent( event, data.objweapon );
            }
            
            return;
        }
        
        data.attacker thread points::doscoreevent( event, data.objweapon );
    }
}

// Namespace emp_grenade
// Params 1, eflags: 0x4
// Checksum 0xc0ac662a, Offset: 0x1103
// Size: 0x250
function private function_8414fd72ca678da3( data )
{
    if ( isent( data.victim ) && isagent( data.victim ) && isplayer( data.attacker ) && data.istactical )
    {
        if ( !isdefined( data.victim.var_406b99690f112c ) )
        {
            data.victim.var_406b99690f112c = [];
        }
        
        data.victim.var_406b99690f112c[ data.victim.var_406b99690f112c.size ] = data.attacker.guid;
    }
    
    data.time = level.empgrenadesettings.var_8a2c2a952c83b5d6;
    emp_debuff::apply_emp_struct( data );
    
    if ( isdefined( data.victim.owner ) && player_utility::playersareenemies( data.victim.owner, self ) )
    {
        if ( data.victim vehicle::is_vehicle() && !data.victim vehicle::is_killstreak() )
        {
            killstreaks::givescoreforempedvehicle();
        }
        
        events::killedequipment( data.victim, data.attacker, data.objweapon );
    }
    
    _emp_grenade_end_early( data, level.empgrenadesettings.var_8a2c2a952c83b5d6 );
    
    if ( isent( data.victim ) && isagent( data.victim ) && isplayer( data.attacker ) && data.victim.var_406b99690f112c )
    {
        data.victim.var_406b99690f112c = arrayremove( data.victim.var_406b99690f112c, data.attacker.guid );
    }
    
    if ( isdefined( data.victim ) )
    {
        data.victim emp_debuff::remove_emp();
    }
}

// Namespace emp_grenade
// Params 1, eflags: 0x4
// Checksum 0xfa681188, Offset: 0x135b
// Size: 0x21d
function private _emp_grenade_apply_player( data )
{
    emp_debuff::apply_emp_struct( data, 0, 0, 1 );
    data.victim emp_debuff::play_emp_scramble( 5, 1 );
    
    if ( data.attacker != data.victim )
    {
        gamescore::trackdebuffassist( data.attacker, data.victim, data.objweapon.basename );
        data.victim.emp_grenade_tracker = { #weaponobj:data.objweapon };
        telemetry_mp::function_594cbdc6a4d8098a( data.victim, data.attacker, data.objweapon, data.grenadeid );
    }
    
    if ( level.empgrenadesettings.emp_grenade_do_stun )
    {
        data.victim shellshock_utility_cpmp::_shellshock( %"emp", #"stun", level.empgrenadesettings.var_9e836a45e10f7a06, 1 );
    }
    
    _emp_grenade_end_early( data, level.empgrenadesettings.var_9e836a45e10f7a06 ?? 6 );
    
    if ( isdefined( data.victim ) )
    {
        data.victim.emp_grenade_tracker = undefined;
        data.victim emp_debuff::remove_emp();
        data.victim emp_debuff::stop_emp_scramble( 5, 1 );
        
        if ( data.attacker != data.victim )
        {
            telemetry_mp::function_edb43d25c7bd56c6( data.victim, data.objweapon, data.grenadeid );
            
            if ( player::isreallyalive( data.attacker ) )
            {
                gamescore::untrackdebuffassist( data.attacker, data.victim, data.objweapon.basename );
            }
        }
    }
}

// Namespace emp_grenade
// Params 2, eflags: 0x4
// Checksum 0x3976d17f, Offset: 0x1580
// Size: 0x3a
function private _emp_grenade_end_early( data, duration )
{
    data.victim endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait duration;
}

// Namespace emp_grenade
// Params 1, eflags: 0x4
// Checksum 0xf1f30dfd, Offset: 0x15c2
// Size: 0xd3
function private function_d20a0e50d34fbd9b( params )
{
    attacker = self;
    victim = params.victim;
    
    if ( !isdefined( victim ) || !isplayer( attacker ) )
    {
        return;
    }
    
    foreach ( attackerguid in victim.var_406b99690f112c )
    {
        if ( attackerguid == attacker.guid )
        {
            attacker.var_c6835bd1faf41221 = 1;
        }
    }
}

// Namespace emp_grenade
// Params 1, eflags: 0x4
// Checksum 0xb2790553, Offset: 0x169d
// Size: 0x1fe
function private function_38cf8364e4d8e652( params )
{
    attacker = self;
    victim = params.victim;
    function_d20a0e50d34fbd9b( params );
    
    if ( !isplayer( victim ) || !isplayer( attacker ) )
    {
        return;
    }
    
    if ( !level.teambased )
    {
        return;
    }
    
    if ( victim.team == attacker.team || !victim.emp_grenade_tracker )
    {
        return;
    }
    
    attacker.modifiers[ "emp_finished" ] = victim.emp_grenade_tracker.weaponobj;
    empweapon = equipment_mp::getweaponfromequipmentref( "equip_emp" );
    
    foreach ( var_f13db4ac907aa472 in victim.debuffinfo[ empweapon.basenamehash ?? "emp_grenade_mp" ] )
    {
        var_379a0f39e0147743 = var_f13db4ac907aa472.attacker;
        
        if ( var_379a0f39e0147743 == attacker )
        {
            attacker.var_c6835bd1faf41221 = 1;
            continue;
        }
        
        if ( !isdefined( self.modifiers[ "EMPAssistList" ] ) )
        {
            self.modifiers[ "EMPAssistList" ] = [];
        }
        
        if ( !function_978bde7975eb37( self.modifiers[ "EMPAssistList" ], var_379a0f39e0147743 ) )
        {
            var_32687339cd7ffa62 = spawnstruct();
            var_32687339cd7ffa62.player = var_379a0f39e0147743;
            var_32687339cd7ffa62.empweapon = empweapon;
            self.modifiers[ "EMPAssistList" ][ self.modifiers[ "EMPAssistList" ].size ] = var_32687339cd7ffa62;
        }
    }
}

// Namespace emp_grenade
// Params 1
// Checksum 0x46d36fb4, Offset: 0x18a3
// Size: 0x2f, Type: bool
function is_equipment_ref_emp( instance )
{
    if ( !isdefined( instance.equipmentref ) )
    {
        return false;
    }
    
    return instance.equipmentref == "equip_emp";
}

// Namespace emp_grenade
// Params 1
// Checksum 0x8f61da8e, Offset: 0x18db
// Size: 0xee
function on_player_elim( params )
{
    if ( self.modifiers[ "emp_finished" ] )
    {
        thread points::doscoreevent( #"emp_finished", self.modifiers[ "emp_finished" ] );
    }
    
    if ( self.modifiers[ "EMPAssistList" ].size > 0 )
    {
        foreach ( struct in self.modifiers[ "EMPAssistList" ] )
        {
            struct.player thread points::doscoreevent( #"hash_b4cb181cdefd0ce1", struct.empweapon );
        }
    }
}

// Namespace emp_grenade
// Params 2
// Checksum 0x3e7bc628, Offset: 0x19d1
// Size: 0x93, Type: bool
function function_978bde7975eb37( structarray, targetplayer )
{
    foreach ( struct in structarray )
    {
        if ( struct.player == targetplayer )
        {
            return true;
        }
    }
    
    return false;
}

