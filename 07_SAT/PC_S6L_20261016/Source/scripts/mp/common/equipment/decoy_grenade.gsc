// scripts\mp\common\equipment\decoy_grenade.gsc  (hash_72ace123f7289772.gscc) (size: 20850 Bytes / 0x5172 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5e93b79b (1586739099)
// size ...... 20850 (0x5172)
// includes .. 29  (offset: 0x4da2)
// strings ... 40  (offset: 0x4e8a)
// dev strs .. 8   (offset: 0x510e)
// exports ... 52  (offset: 0x313e)
// cseg ...... 0x2d6 + 0x2e68 (0x313e)
// imports ... 170 (offset: 0x395e)
// animtree1 . 0   (offset: 0x5172)
// animtree2 . 0   (offset: 0x5172)
#using script_16ea1b94f0f381b3;
#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\status_effects\status_tracking;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\decoy_common;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\rank;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace decoy_grenade;

// Namespace decoy_grenade
// Params 0, eflags: 0x1
// Checksum 0x66be395a, Offset: 0x2f4
// Size: 0xaf
function autoexec init()
{
    utility::flag_wait( "equipment_initialized" );
    perkfunctions::function_deeb2f40153920c7( "decoy_grenade", &cricketdetonate );
    callback::add( #"hash_244314ef9125e636", &onplayerdeath );
    
    if ( !weapons::getusedcallback( #"decoy_grenade" ) )
    {
        weapons::deregisterusedcallback( #"decoy_grenade" );
        weapons::registerusedcallback( #"decoy_grenade", &used );
    }
    
    utility::registersharedfunc( #"decoy_grenade", #"dronegun_emp", &_destroy );
    utility::registersharedfunc( #"decoy_grenade", #"hack", &hack );
    equipmentinteractinit();
}

// Namespace decoy_grenade
// Params 0
// Checksum 0x29c299d0, Offset: 0x3ab
// Size: 0x5f
function equipmentinteractinit()
{
    bundle = level.equipment.table[ "equip_decoy" ].bundle;
    
    if ( !bundle.equipmentinteractions )
    {
        return;
    }
    
    utility::registersharedfunc( getxhash( "equip_decoy" ), #"interactdestroy", &_destroy );
}

// Namespace decoy_grenade
// Params 0
// Checksum 0x21790f3b, Offset: 0x412
// Size: 0x29
function cricketdetonate()
{
    owner = self.owner;
    
    if ( !owner )
    {
        return 0;
    }
    
    owner thread used( self );
}

// Namespace decoy_grenade
// Params 1
// Checksum 0x2697d221, Offset: 0x443
// Size: 0x3d6
function used( grenade )
{
    grenade endon( #"death" );
    
    if ( utility::issharedfuncdefined( #"jamming_system", #"hash_ca0042e3cac99672" ) )
    {
        grenade [[ utility::getsharedfunc( #"jamming_system", #"hash_ca0042e3cac99672" ) ]]( grenade );
    }
    
    ref = equipment_mp::function_fdc4a655fbde0dec( grenade.weapon_name );
    grenade.tableinfo = weapon::getequipmenttableinfo( ref );
    bundle = grenade.tableinfo.bundle;
    
    if ( !bundle )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    bundle = level.equipment.table[ "equip_decoy" ].bundle;
    
    if ( !isdefined( level.equipment.table[ "equip_decoy" ].effect_duration ) )
    {
        level.equipment.table[ "equip_decoy" ].effect_duration = bundle.var_9ee6ecae29311d3;
    }
    
    grenade.var_30656af96b2ac2a4 = [];
    grenade.add_buff = &add_buff;
    grenade.remove_buff = &remove_buff;
    
    if ( bundle.var_e6fde41e9baeeca6 )
    {
        if ( !self.decoys )
        {
            self.decoys = [];
            
            if ( !callback::exists( "onPlayerSpawn_destroyEquipment", &destroyonrespawn ) )
            {
                callback::add( "onPlayerSpawn_destroyEquipment", &destroyonrespawn );
            }
        }
        
        self.decoys[ self.decoys.size ] = grenade;
    }
    
    /#
        print::printgameaction( "<dev string:x42>", grenade.owner );
    #/
    
    grenade.playersdebuffed = [];
    grenade.decoyassists = 0;
    grenade.var_8cd831a3c0cc9bdc = level status_tracking::function_25399da4af77eea1();
    grenade haywire::function_7f69a1eb3d590f76( &haywireapplied );
    namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( grenade, &empapplied );
    weapons::onequipmentplanted( grenade, "equip_decoy", &_destroy );
    grenade thread weapons::monitordisownedequipment( self, grenade );
    
    if ( bundle.decoy_launchgrenade )
    {
        grenade emp_debuff::allow_emp( 0 );
        wait 0.4;
        grenade emp_debuff::allow_emp( 1 );
        decoymaxhealth = bundle.decoy_maxhealth ?? 19;
        grenade thread damage::monitordamage( decoymaxhealth, "hitequip", &handlefataldamage, &handledamage );
        grenade thread monitorposition();
        wait 0.6;
        endtime = gettime() + 5000;
        var_8c78271730b264a8 = gettime();
        var_f310400656513b71 = 3;
        
        while ( gettime() < endtime )
        {
            if ( gettime() >= var_8c78271730b264a8 )
            {
                var_8c78271730b264a8 = gettime() + 200;
                
                if ( grenade _isonground() )
                {
                    var_f310400656513b71--;
                    
                    if ( var_f310400656513b71 == 0 )
                    {
                        break;
                    }
                }
                else
                {
                    var_f310400656513b71 = 3;
                }
            }
            
            wait 0.2;
        }
    }
    else
    {
        grenade function_c16f57e204f32fda();
        decoymaxhealth = bundle.decoy_maxhealth ?? 19;
        grenade thread damage::monitordamage( decoymaxhealth, "hitequip", &handlefataldamage, &handledamage );
        armtime = bundle.decoy_armtime ?? 0.5;
        wait armtime;
    }
    
    imageoverride = grenade.var_30656af96b2ac2a4.size > 0 ? bundle.buffedheadicon : undefined;
    grenade.headiconid = entityheadicons::setheadicon_equipment( grenade, imageoverride );
    grenade thread monitorfuse();
    grenade thread activated();
    utility::function_969f9f5596dba07a( grenade, &_destroy );
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0x1ceb634c, Offset: 0x821
// Size: 0x164
function private activated()
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    thread function_ade39f91cfd48cbe();
    bundle = self.tableinfo.bundle;
    self setotherent( self.owner );
    
    if ( self.weapon_name == "t10_decoy_grenade_mp" )
    {
        self setscriptablepartstate( "beacon", "t10Active", 0 );
        self setscriptablepartstate( "effects", "active", 0 );
    }
    else
    {
        self setscriptablepartstate( "beacon", "active", 0 );
    }
    
    self.initialfiretype = getfiretype();
    self.sequencedata = [];
    
    if ( bundle.var_28d14e43a5de178f )
    {
        self.sequencedata[ "footFallSoundsPlayedTime" ] = undefined;
    }
    
    self notify( #"hash_c860830af05fa677" );
    challenges::function_3d7a169dbae062fb( "equip_decoy", self.owner, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    self notify( #"decoy_sequence_started", self.origin );
    thread function_efa4348b6b41b914();
    
    if ( bundle.var_332777bc986d8cb )
    {
        distance = bundle.var_d8094f55181b42c4 ?? 800;
        thread function_2482df90f826e63a( distance );
    }
    
    thread monitorsequence();
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0xd99c7949, Offset: 0x98d
// Size: 0x3d
function private function_ade39f91cfd48cbe()
{
    level callback::add( #"player_disconnect", &onplayerdisconnect, self );
    self waittill( #"death" );
    level callback::remove( #"player_disconnect", &onplayerdisconnect, self );
}

// Namespace decoy_grenade
// Params 1, eflags: 0x4
// Checksum 0x500699d9, Offset: 0x9d2
// Size: 0x142
function private function_1723753abb620bcf( firetype )
{
    bundle = self.tableinfo.bundle;
    var_585a71f1ed53aac2 = level.var_ac98e7cc4b10cb11 && self.tableinfo.bundle.var_ae7988074e6b3ff3;
    
    if ( var_585a71f1ed53aac2 )
    {
        var_6489ba1288964306 = bundle.var_e36b84555e7df1d3 && self.weapon_object hasattachmenthash( bundle.var_e36b84555e7df1d3 );
        var_75ee6bb03d41065f = !var_6489ba1288964306;
    }
    
    if ( !isdefined( var_75ee6bb03d41065f ) )
    {
        var_75ee6bb03d41065f = 1;
    }
    
    if ( bundle.var_d2d8944613d2b772 )
    {
        self setscriptablepartstate( "alarmSound", "on", 0 );
    }
    
    if ( bundle.var_28d14e43a5de178f && function_c27cfa665ade13c8() )
    {
        var_ab7bc3900a70139c = randomint( 100 );
        
        if ( bundle.var_63e5fb18919b4657 || var_ab7bc3900a70139c > 35 )
        {
            function_1d97dbe21ae14e8e();
        }
    }
    
    if ( bundle.var_23575e5d2c036555 && var_75ee6bb03d41065f )
    {
        if ( bundle.var_63e5fb18919b4657 )
        {
            thread function_3c71f4d03f94e5b6();
        }
        
        firesequence( firetype );
    }
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0xc12372fc, Offset: 0xb1c
// Size: 0x1b2
function private function_efa4348b6b41b914()
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    bundle = self.tableinfo.bundle;
    
    if ( !bundle.var_db12eb0f8735c1d5 )
    {
        return;
    }
    
    buffradius = getdvarint( @"hash_f2e808f1292f667a", bundle.var_7c4de74bbd9ecfd9 ?? 800 );
    buffinterval = bundle.var_c77ddbc966a5cfd2 ?? 0.5;
    var_f913b3ef1300ba5e = buffradius * buffradius;
    owner = self.owner;
    
    while ( true )
    {
        if ( !self )
        {
            if ( owner.decoybuffs )
            {
                owner thread function_e02eb320a1e3c809();
            }
            
            return;
        }
        
        ownerrange = distancesquared( self.origin, self.owner.origin );
        
        if ( ownerrange <= var_f913b3ef1300ba5e && !self.isjammed )
        {
            if ( !owner.decoybuffs && !isdefined( owner.perks[ "specialty_scout_vest" ] ) )
            {
                owner perk::giveperk( "specialty_scout_vest" );
                owner.decoybuffs = 1;
            }
        }
        else if ( owner.decoybuffs )
        {
            owner thread function_e02eb320a1e3c809();
        }
        
        result = utility::waittill_any_timeout( buffinterval, "death" );
        
        if ( result == "death" && owner.decoybuffs )
        {
            owner thread function_e02eb320a1e3c809();
            return;
        }
    }
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0xbc105779, Offset: 0xcd6
// Size: 0x18
function private function_e02eb320a1e3c809()
{
    perk::removeperk( "specialty_scout_vest" );
    self.decoybuffs = undefined;
}

// Namespace decoy_grenade
// Params 0
// Checksum 0x77f5e7d7, Offset: 0xcf6
// Size: 0x5f
function _destroy()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self setscriptablepartstate( "destroy", "active", 0 );
    self setscriptablepartstate( "beacon", "neutral", 0 );
    self setscriptablepartstate( "effects", "neutral", 0 );
    self setscriptablepartstate( "alarmSound", "off", 0 );
    self stopsounds();
    thread _delete( 0.1 );
}

// Namespace decoy_grenade
// Params 1, eflags: 0x4
// Checksum 0x49fd5a10, Offset: 0xd5d
// Size: 0xf0
function private _delete( delay = 0 )
{
    self notify( #"death" );
    self.exploding = 1;
    namespace_9d8e359c3b1041e5::emp_debuff_deregister_sharedfunc( self );
    damage::monitordamageend();
    function_29475a7989325d71();
    function_404deed96264e14d();
    
    if ( isdefined( self.var_8cd831a3c0cc9bdc ) )
    {
        status_tracking::function_1195d97831be7b57( self.owner, self.var_8cd831a3c0cc9bdc );
    }
    
    wait delay;
    
    if ( self )
    {
        if ( utility::issharedfuncdefined( #"jamming_system", #"hash_c33ceb91d0ca7a9d" ) )
        {
            self [[ utility::getsharedfunc( #"jamming_system", #"hash_c33ceb91d0ca7a9d" ) ]]( self );
        }
        
        entityheadicons::setheadicon_deleteicon( self.headiconid );
        
        if ( self.owner )
        {
            pinglocationenemyteams( self.origin, self.team, self.owner, 0 );
        }
        
        self delete();
    }
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0xc930546c, Offset: 0xe55
// Size: 0xfe
function private function_404deed96264e14d()
{
    if ( self.owner && self.owner.var_5427f122343631e )
    {
        foreach ( victimentnum, _ in self.owner.var_5427f122343631e )
        {
            function_9e4ca1954b6c8e05( victimentnum );
        }
        
        self.owner.var_5427f122343631e = function_f943bef551ff028c( self.owner.var_5427f122343631e );
        
        if ( !self.owner.var_5427f122343631e.size )
        {
            self.owner.var_5427f122343631e = undefined;
        }
    }
}

// Namespace decoy_grenade
// Params 1, eflags: 0x4
// Checksum 0x27581e40, Offset: 0xf5b
// Size: 0xac
function private function_9e4ca1954b6c8e05( victimentnum )
{
    if ( !isdefined( self.playersdebuffed[ victimentnum ] ) )
    {
        return;
    }
    
    self.owner.var_5427f122343631e[ victimentnum ] = arrayremove( self.owner.var_5427f122343631e[ victimentnum ], self.mineid );
    
    if ( !self.owner.var_5427f122343631e[ victimentnum ].size )
    {
        self.owner.var_5427f122343631e[ victimentnum ] = undefined;
    }
    
    self.playersdebuffed[ victimentnum ] = undefined;
    
    if ( isint( victimentnum ) )
    {
        function_cdc669dbc8ea2101( self.playersdebuffed );
    }
}

// Namespace decoy_grenade
// Params 1, eflags: 0x4
// Checksum 0xabf518d1, Offset: 0x100f
// Size: 0xa9
function private destroyonrespawn( params )
{
    if ( !isdefined( self ) || !self.decoys )
    {
        return;
    }
    
    foreach ( decoy in self.decoys )
    {
        if ( decoy )
        {
            decoy _destroy();
        }
    }
    
    self.decoys = undefined;
}

// Namespace decoy_grenade
// Params 1, eflags: 0x4
// Checksum 0xbaf907e0, Offset: 0x10c0
// Size: 0x63
function private firesequence( firetype )
{
    firecount = 1 + randomint( firetype.var_d7b95e5e9b404fc6 );
    
    while ( true )
    {
        firecount--;
        fireevent( firetype );
        
        if ( firecount == 0 )
        {
            break;
        }
        
        wait randomfloatrange( firetype.var_1eef6f1f51438633, firetype.var_3c63317ed5167991 );
    }
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0xcf91c327, Offset: 0x112b
// Size: 0x9b
function private function_1d97dbe21ae14e8e()
{
    self.playingfootsteps = 1;
    var_d2834c7dbc974b5e = function_53bc3d1e6aad7187();
    stepcount = var_d2834c7dbc974b5e.var_16a773f200dee7dd + randomint( var_d2834c7dbc974b5e.var_da02701ac01b3323 );
    
    while ( true )
    {
        stepcount--;
        function_5a714ff3f3b7e855( var_d2834c7dbc974b5e );
        
        if ( stepcount == 0 )
        {
            break;
        }
    }
    
    wait randomfloatrange( var_d2834c7dbc974b5e.var_6b267c7fc6b83a90, var_d2834c7dbc974b5e.var_784cbbdc21a1cf26 );
    self.sequencedata[ "footFallSoundsPlayedTime" ] = gettime();
    self.playingfootsteps = 0;
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0x71011841, Offset: 0x11ce
// Size: 0x83
function private function_3c71f4d03f94e5b6()
{
    owner = self.owner;
    owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"hash_6f8f21a26a9573d9" );
    self.playingfootsteps = 1;
    var_d2834c7dbc974b5e = function_53bc3d1e6aad7187();
    
    while ( true )
    {
        function_5a714ff3f3b7e855( var_d2834c7dbc974b5e );
        wait randomfloatrange( var_d2834c7dbc974b5e.var_6b267c7fc6b83a90, var_d2834c7dbc974b5e.var_784cbbdc21a1cf26 );
    }
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0x23665b89, Offset: 0x1259
// Size: 0x2c
function private function_325878f81b22f692()
{
    self.sequencedata[ "footFallSoundsPlayedTime" ] = gettime();
    self.playingfootsteps = 0;
    self notify( #"hash_6f8f21a26a9573d9" );
}

// Namespace decoy_grenade
// Params 1, eflags: 0x4
// Checksum 0x70c9d985, Offset: 0x128d
// Size: 0x1f2
function private function_2482df90f826e63a( distance )
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    var_2e719a92f5113b47 = 0;
    bundle = self.tableinfo.bundle;
    headicon = bundle.var_1b854536bbe8369a ?? "hud_icon_head_marked";
    headicontime = bundle.var_3721332a5820518b ?? 3;
    
    while ( true )
    {
        nearbyplayers = utility::function_f754506ecfae9afb( self.origin, distance );
        var_65af1664bc038dfe = 0;
        
        foreach ( player in nearbyplayers )
        {
            if ( !isplayer( player ) || !player player::isreallyalive() || !player_utility::playersareenemies( self.owner, player ) )
            {
                continue;
            }
            
            var_65af1664bc038dfe += 1;
        }
        
        if ( var_2e719a92f5113b47 < var_65af1664bc038dfe )
        {
            if ( !isdefined( self.var_54eeebc18a3aa732 ) )
            {
                self.var_54eeebc18a3aa732 = entityheadicons::setheadicon_singleimage( [ self.owner ], headicon, 12, 1, 1600, 800 );
            }
            
            self.var_6b8771f6e9ec730a = gettime();
        }
        
        if ( self.var_6b8771f6e9ec730a && gettime() > self.var_6b8771f6e9ec730a + headicontime * 1000 )
        {
            entityheadicons::setheadicon_deleteicon( self.var_54eeebc18a3aa732 );
            self.var_6b8771f6e9ec730a = undefined;
        }
        
        var_2e719a92f5113b47 = var_65af1664bc038dfe;
        waitframe();
    }
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0x16ab25a1, Offset: 0x1487
// Size: 0xa8
function private function_29475a7989325d71()
{
    if ( !self.var_1d97f591425abc3d )
    {
        return;
    }
    
    foreach ( player in self.var_1d97f591425abc3d )
    {
        self.var_1d97f591425abc3d = arrayremove( self.var_1d97f591425abc3d, player );
    }
    
    entityheadicons::setheadicon_deleteicon( self.var_54eeebc18a3aa732 );
}

// Namespace decoy_grenade
// Params 1, eflags: 0x4
// Checksum 0x283df23a, Offset: 0x1537
// Size: 0x1d4
function private function_5a714ff3f3b7e855( var_362080cdfc4fec2f )
{
    if ( self.tableinfo.bundle.decoy_launchgrenade && !self.tableinfo.bundle.var_5648c2555e3cc3d0 )
    {
        origin = self.origin + ( 0, 0, 1.5 );
        velocity = _getvelocity( origin );
        angles = function_102d2c7d86e8353e( velocity );
        impulse = function_38686fb332bf33ac( velocity, var_362080cdfc4fec2f, angles );
        heldoffhand = self.owner getheldoffhand();
        
        if ( !heldoffhand || getweaponrootstring( heldoffhand ) != "frag_grenade" )
        {
            weaponname = equipment_mp::getweaponfromequipmentref( "equip_decoy" );
            self.owner weapon::_launchgrenade( weaponname, origin, impulse, 100, 1, self );
        }
        
        self setcandamage( 1 );
    }
    
    function_e3d59e41f0a6ec1c();
    var_86e2b043ff95434d = var_362080cdfc4fec2f.var_e5038bf8cb50823c;
    partname = function_66013cd1ca9257c7();
    self setscriptablepartstate( partname, var_86e2b043ff95434d, 0 );
    eventtype = "";
    
    if ( issubstr( tolower( var_86e2b043ff95434d ), "walk" ) )
    {
        eventtype = "footstep_walk";
    }
    else if ( issubstr( tolower( var_86e2b043ff95434d ), "sprint" ) )
    {
        eventtype = "footstep_sprint";
    }
    else
    {
        assertmsg( "<dev string:x56>" + "<dev string:xbb>" + partname + "<dev string:xde>" + var_86e2b043ff95434d + "<dev string:xed>" );
    }
    
    broadcaststealthevent( self.owner, eventtype, undefined, self.origin );
    wait var_362080cdfc4fec2f.var_3d7767677fda3ffe;
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0x5b4adc24, Offset: 0x1713
// Size: 0x69, Type: bool
function private function_66013cd1ca9257c7()
{
    bundle = self.tableinfo.bundle;
    
    if ( self.var_87dba5b41fc4503b )
    {
        self.var_87dba5b41fc4503b = 0;
        return ( bundle.var_d959742695728e5e ?? "footFallPartA" );
    }
    
    self.var_87dba5b41fc4503b = 1;
    return bundle.var_d959732695728c2b ?? "footFallPartB";
}

// Namespace decoy_grenade
// Params 1, eflags: 0x4
// Checksum 0x98231525, Offset: 0x1785
// Size: 0x237
function private fireevent( firetype )
{
    if ( !self.owner )
    {
        return;
    }
    
    if ( self.tableinfo.bundle.decoy_launchgrenade )
    {
        origin = self.origin + ( 0, 0, 1.5 );
        velocity = _getvelocity( origin );
        angles = function_102d2c7d86e8353e( velocity );
        impulse = function_d59e3ed8f789e66d( velocity, firetype, angles );
        heldoffhand = self.owner getheldoffhand();
        
        if ( !heldoffhand || getweaponrootstring( heldoffhand ) != "frag_grenade" )
        {
            weaponname = equipment_mp::getweaponfromequipmentref( "equip_decoy" );
            self.owner weapon::_launchgrenade( weaponname, self.origin, impulse, 100, 1, self );
        }
        
        self setcandamage( 1 );
    }
    
    self setscriptablepartstate( "beacon", "active", 0 );
    self setscriptablepartstate( "weaponFire", firetype.var_32e195bfb23447fb, 0 );
    self setscriptablepartstate( "weaponSounds", firetype.var_32e195bfb23447fb, 0 );
    broadcaststealthevent( self.owner, "gunshot", undefined, self.origin + ( 0, 0, 50 ) );
    numdecoys = self.tableinfo.bundle.var_9df6092f1a465b7f ? self.tableinfo.bundle.var_9aae881aaf87710b ?? 3 : 1;
    magnitude = self.tableinfo.bundle.var_9df6092f1a465b7f ? 1000 : getdvarint( @"hash_4dfc7eaec2bc9ba8" );
    pinglocationenemyteams( self.origin, self.team, self.owner, numdecoys, magnitude, undefined, 0, 0, 0, 1 );
    function_e3d59e41f0a6ec1c( 1 );
    wait firetype.decoy_weaponfiretime;
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0xe82a812, Offset: 0x19c4
// Size: 0x31, Type: bool
function private function_ced9e32d4713072e()
{
    if ( !isdefined( self.sequencedata[ "footFallSoundsPlayedTime" ] ) )
    {
        return true;
    }
    
    return gettime() - self.sequencedata[ "footFallSoundsPlayedTime" ] > 2000;
}

// Namespace decoy_grenade
// Params 1, eflags: 0x4
// Checksum 0xe70f3585, Offset: 0x19fe
// Size: 0x2ee
function private function_e3d59e41f0a6ec1c( gunshotevent )
{
    var_94640fde80beb1eb = self.tableinfo.bundle.var_a04945848a9ca1bc ?? 800;
    var_d6c89337dddab3fc = self.tableinfo.bundle.var_ca694ff612181976 ?? 2000;
    debuffradius = max( var_94640fde80beb1eb, var_d6c89337dddab3fc );
    nearbyenemies = utility::function_f754506ecfae9afb( self.origin, debuffradius );
    currentrange = undefined;
    
    foreach ( enemy in nearbyenemies )
    {
        if ( isplayer( enemy ) && !enemy player::isreallyalive() || !player_utility::playersareenemies( self.owner, enemy ) )
        {
            continue;
        }
        
        if ( isplayer( enemy ) )
        {
            currentrange = distance( enemy.origin, self.origin );
            
            if ( currentrange > var_94640fde80beb1eb )
            {
                continue;
            }
            
            thread debuffenemy( enemy );
        }
        else if ( gunshotevent )
        {
            stealtheventbroadcastsimple( "cover_blown", self.owner, self.origin, 1500 );
        }
        else
        {
            enemy aieventlistenerevent( "decoy_grenade", self, self.origin );
        }
        
        if ( isplayer( self.owner ) )
        {
            self.owner damage::combatrecordtacticalstat( "equip_decoy" );
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self.owner ) ) )
            {
                if ( isdefined( self.owner.leaderboarddata[ "decoyHits" ] ) )
                {
                    self.owner.leaderboarddata[ "decoyHits" ] = self.owner.leaderboarddata[ "decoyHits" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "decoyHits" ] ) )
                {
                    [[ level.leaderboardfunc[ "decoyHits" ] ]]( self.owner, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:xf0>" );
                
                if ( isdefined( self.owner.pers[ "decoyHits" ] ) )
                {
                    self.owner.pers[ "decoyHits" ] = self.owner.pers[ "decoyHits" ] + 1;
                }
            }
        }
    }
}

// Namespace decoy_grenade
// Params 1, eflags: 0x4
// Checksum 0x6b0d9591, Offset: 0x1cf4
// Size: 0x3df
function private debuffenemy( victim )
{
    victim endon( #"disconnect" );
    self endon( #"death" );
    owner = self.owner;
    owner endon( #"disconnect" );
    self endon( #"grenade_hacked" );
    victimentnum = victim getentitynumber();
    self notify( "decoy_debuffEnemy_" + victimentnum );
    self endon( "decoy_debuffEnemy_" + victimentnum );
    
    if ( !self.playersdebuffed[ victimentnum ] )
    {
        self.playersdebuffed[ victimentnum ] = victim;
        challengeparams = { #effectref:"bamboozled", #duration:0, #equipmentref:"equip_decoy", #equipmentent:self, #victim:victim, #attacker:owner };
        callback::callback( #"hash_10e686549630fd9f", challengeparams );
        
        if ( victim != owner )
        {
            namespace_5f4bb62dbf67ff87::doonactionscoreevent( 0, "decoyDebuffed", 0, { #objweapon:self.weapon_object } );
            
            if ( !isdefined( owner.var_5427f122343631e[ victimentnum ] ) )
            {
                owner.var_5427f122343631e[ victimentnum ] = [];
            }
            
            owner.var_5427f122343631e[ victimentnum ][ owner.var_5427f122343631e[ victimentnum ].size ] = self.mineid;
            statusguid = status_tracking::applystatus( victim, owner, self.var_8cd831a3c0cc9bdc, #"decoy_active", { #supportscoreevent:self.tableinfo.bundle.supportscoreevent } );
            thread status_tracking::function_97d762c26d26677b( victim, owner, self.var_8cd831a3c0cc9bdc, statusguid, 5 );
        }
    }
    
    victim.var_514599d62c60d142 = self.weapon_object;
    result = victim utility::waittill_notify_or_timeout_return( "death", 5 );
    self.playersdebuffed[ victim getentitynumber() ] = undefined;
    
    if ( !owner )
    {
        return;
    }
    
    owner.var_5427f122343631e[ victimentnum ] = arrayremove( owner.var_5427f122343631e[ victimentnum ], self.mineid );
    
    if ( !owner.var_5427f122343631e[ victimentnum ].size )
    {
        owner.var_5427f122343631e[ victimentnum ] = undefined;
        owner.var_5427f122343631e = function_f943bef551ff028c( owner.var_5427f122343631e );
        
        if ( !owner.var_5427f122343631e.size )
        {
            owner.var_5427f122343631e = undefined;
        }
    }
    
    attacker = victim.lastkilledby;
    
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    if ( result != "death" )
    {
        return;
    }
    
    if ( attacker == owner )
    {
        owner thread gamelogic_mp::threadedsetweaponstatbyname( self.tableinfo.objweapon, 1, "debuff_kills" );
        owner telemetry_mp::function_89a5d8fb8ed3a4fe( undefined, owner, self.birthtime, self.tableinfo.objweapon );
        return;
    }
    
    if ( !player_utility::playersareenemies( owner, attacker ) )
    {
        if ( level.gamemodebundle.var_9257addc44d0799c )
        {
            return;
        }
        
        if ( !self.tableinfo.bundle.var_423f136ef8e19916 || self.decoyassists < ( self.tableinfo.bundle.var_5f3b001d1b54e591 ?? 3 ) )
        {
            self.decoyassists++;
            owner thread points::doscoreevent( #"assist_decoy", self.tableinfo.objweapon );
            owner thread gamelogic_mp::threadedsetweaponstatbyname( self.tableinfo.objweapon, 1, "debuff_assists" );
        }
    }
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0xa7d4a701, Offset: 0x20db
// Size: 0xa0
function private monitorsequence()
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    self endon( #"grenade_hacked" );
    bundle = self.tableinfo.bundle;
    
    while ( true )
    {
        decoy_common::function_f52dc1fe2728d92a( 1000 );
        
        if ( !self.isjammed )
        {
            function_1723753abb620bcf( self.initialfiretype );
        }
        
        wait randomfloatrange( 1.5, 3.5 );
        
        if ( bundle.var_63e5fb18919b4657 )
        {
            function_325878f81b22f692();
        }
    }
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0xfc4e69c2, Offset: 0x2183
// Size: 0x37
function private monitorposition()
{
    self endon( #"death" );
    
    while ( true )
    {
        oldposition = self.origin;
        waitframe();
        self.oldposition = oldposition;
    }
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0x31b0986c, Offset: 0x21c2
// Size: 0xeb
function private monitorfuse()
{
    self endon( #"death" );
    self endon( #"grenade_hacked" );
    
    if ( self.tableinfo.bundle.var_c7709714d768097c && self.weapon_object hasattachmenthash( self.tableinfo.bundle.var_c7709714d768097c ) )
    {
        var_2bfdfa4e974bd657 = self.tableinfo.bundle.var_85c247cdd076d589;
    }
    
    if ( !isdefined( var_2bfdfa4e974bd657 ) )
    {
        var_2bfdfa4e974bd657 = self.tableinfo.bundle.var_9ee6ecae29311d3 ?? 15;
    }
    
    decoyduration = self.var_226a7f177063c32f ? self.var_226a7f177063c32f + var_2bfdfa4e974bd657 : var_2bfdfa4e974bd657;
    wait decoyduration;
    thread _destroy();
}

// Namespace decoy_grenade
// Params 1
// Checksum 0x5d50a8fa, Offset: 0x22b5
// Size: 0x52
function empapplied( empstruct )
{
    self notify( #"enemy_destroyed_equipment", empstruct.attacker );
    empstruct.victim function_acabeadee049405b( empstruct.attacker );
    empstruct.victim thread _destroy();
}

// Namespace decoy_grenade
// Params 1
// Checksum 0x2da224d5, Offset: 0x230f
// Size: 0x3b
function haywireapplied( data )
{
    data.victim function_acabeadee049405b( data.attacker );
    data.victim thread _destroy();
}

// Namespace decoy_grenade
// Params 1
// Checksum 0x8b7d117d, Offset: 0x2352
// Size: 0x48
function handledamage( data )
{
    weapons::equipmenthit( self.owner, data.attacker, data.objweapon, data.meansofdeath );
    return data.damage;
}

// Namespace decoy_grenade
// Params 1
// Checksum 0x283b4fba, Offset: 0x23a3
// Size: 0x47
function handlefataldamage( data )
{
    self notify( #"enemy_destroyed_equipment", data.attacker );
    function_acabeadee049405b( data.attacker, data.objweapon );
    thread _destroy();
}

// Namespace decoy_grenade
// Params 2, eflags: 0x4
// Checksum 0xcf53cdc7, Offset: 0x23f2
// Size: 0x30
function private onplayerdisconnect( params, grenade )
{
    entnum = self getentitynumber();
    grenade function_9e4ca1954b6c8e05( entnum );
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0xf4b132a5, Offset: 0x242a
// Size: 0xac
function private function_53bc3d1e6aad7187()
{
    totalweightvalue = 0;
    maxweightvalues = [];
    var_5967a101e3c4ce54 = self.tableinfo.bundle.var_4c6037187cc0e1b;
    
    if ( !var_5967a101e3c4ce54 )
    {
        return;
    }
    
    for ( i = 0; i < var_5967a101e3c4ce54.size ; i++ )
    {
        totalweightvalue += var_5967a101e3c4ce54[ i ].var_11b4ceae7d2ca7d2 ?? 0;
        maxweightvalues[ i ] = totalweightvalue;
    }
    
    weightvalue = randomint( totalweightvalue );
    
    for ( i = 0; i < maxweightvalues.size ; i++ )
    {
        if ( weightvalue < maxweightvalues[ i ] )
        {
            return var_5967a101e3c4ce54[ i ];
        }
    }
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0xb22d94ee, Offset: 0x24df
// Size: 0xd9
function private getfiretype()
{
    /#
        dvarfiretype = getdvar( @"hash_621c6f1da92a54d5", "<dev string:x116>" );
        
        if ( dvarfiretype != "<dev string:x116>" )
        {
            return dvarfiretype;
        }
    #/
    
    totalweightvalue = 0;
    maxweightvalues = [];
    firetypes = self.tableinfo.bundle.var_b500cf2527bb4334;
    
    if ( !firetypes )
    {
        return;
    }
    
    for ( i = 0; i < firetypes.size ; i++ )
    {
        totalweightvalue += firetypes[ i ].var_165837d1b611e753 ?? 0;
        maxweightvalues[ i ] = totalweightvalue;
    }
    
    weightvalue = randomint( totalweightvalue );
    
    for ( i = 0; i < maxweightvalues.size ; i++ )
    {
        if ( weightvalue < maxweightvalues[ i ] )
        {
            return firetypes[ i ];
        }
    }
}

// Namespace decoy_grenade
// Params 1, eflags: 0x4
// Checksum 0x6252fa06, Offset: 0x25c1
// Size: 0x31
function private _getvelocity( origin )
{
    if ( !isdefined( self.oldposition ) )
    {
        return;
    }
    
    return ( origin - self.oldposition ) / level.framedurationseconds;
}

// Namespace decoy_grenade
// Params 1, eflags: 0x4
// Checksum 0xee2b109c, Offset: 0x25fb
// Size: 0xc5
function private function_102d2c7d86e8353e( velocity )
{
    angles = undefined;
    
    if ( !isdefined( velocity ) )
    {
        angles = ( 0, randomint( 360 ), 0 );
    }
    else if ( velocity * ( 1, 1, 0 ) == ( 0, 0, 0 ) )
    {
        angles = ( 0, randomint( 360 ), 0 );
    }
    else if ( randomint( 100 ) < 20 )
    {
        angles = ( 0, randomint( 360 ), 0 );
    }
    else
    {
        angles = vectortoangles( velocity * ( 1, 1, 0 ) );
        yaw = angleclamp180( angles[ 1 ] );
        yaw += angleclamp( -30 + randomint( 61 ) );
        angles = ( angles[ 0 ], yaw, angles[ 2 ] );
    }
    
    return angles;
}

// Namespace decoy_grenade
// Params 3, eflags: 0x4
// Checksum 0xea594459, Offset: 0x26c9
// Size: 0xb8
function private function_d59e3ed8f789e66d( velocity, firetype, fireangles )
{
    var_b917da1266a8121a = firetype.var_ac1624ccfd168dbf ?? 0;
    var_5a7bc365bc5d2990 = firetype.var_b7aa30acaba4f17d ?? 0;
    var_de6810ec57ecd2aa = firetype.var_7c03c6218df3fc39 ?? 0;
    var_28de6d31ff3ca310 = firetype.var_ebab43a325b784d7 ?? 0;
    impulse = velocity;
    impulse += anglestoup( fireangles ) * randomfloatrange( var_b917da1266a8121a, var_5a7bc365bc5d2990 );
    impulse += anglestoforward( fireangles ) * randomfloatrange( var_de6810ec57ecd2aa, var_28de6d31ff3ca310 );
    return impulse;
}

// Namespace decoy_grenade
// Params 3, eflags: 0x4
// Checksum 0x2683041b, Offset: 0x278a
// Size: 0xb8
function private function_38686fb332bf33ac( velocity, var_362080cdfc4fec2f, fireangles )
{
    var_b917da1266a8121a = var_362080cdfc4fec2f.var_8560fed883958d32 ?? 0;
    var_5a7bc365bc5d2990 = var_362080cdfc4fec2f.var_af0366790f91e038 ?? 0;
    var_de6810ec57ecd2aa = var_362080cdfc4fec2f.var_6117f3998aeb0882 ?? 0;
    var_28de6d31ff3ca310 = var_362080cdfc4fec2f.var_63e75be3f7382818 ?? 0;
    impulse = velocity;
    impulse += anglestoup( fireangles ) * randomfloatrange( var_b917da1266a8121a, var_5a7bc365bc5d2990 );
    impulse += anglestoforward( fireangles ) * randomfloatrange( var_de6810ec57ecd2aa, var_28de6d31ff3ca310 );
    return impulse;
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0xd0ff7d92, Offset: 0x284b
// Size: 0x40, Type: bool
function private _isonground()
{
    vel = _getvelocity( self.origin );
    
    if ( !isdefined( vel ) || abs( vel[ 2 ] ) <= 200 )
    {
        if ( function_e4fd1a78a99152fd() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0x14b54d42, Offset: 0x2894
// Size: 0x82, Type: bool
function private function_e4fd1a78a99152fd()
{
    contents = trace::create_contents( 0, 1, 0, 0, 1, 1 );
    caststart = self.origin + ( 0, 0, 1 );
    castend = caststart + ( 0, 0, -1 ) * 5;
    castresults = physics_raycast( caststart, castend, contents, self, 0, "physicsquery_closest", 1 );
    
    if ( castresults.size > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace decoy_grenade
// Params 2, eflags: 0x4
// Checksum 0x2c99260d, Offset: 0x291f
// Size: 0x37
function private function_acabeadee049405b( attacker, objweapon )
{
    if ( !player_utility::playersareenemies( self.owner, attacker ) )
    {
        return;
    }
    
    attacker equipment_mp::function_ada7da3083a6c593( self, objweapon );
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0x60fb9e9, Offset: 0x295e
// Size: 0x33, Type: bool
function private function_c27cfa665ade13c8()
{
    if ( self.tableinfo.bundle.var_63e5fb18919b4657 )
    {
        return !self.playingfootsteps;
    }
    
    return function_ced9e32d4713072e();
}

// Namespace decoy_grenade
// Params 0, eflags: 0x4
// Checksum 0x69d4a982, Offset: 0x299a
// Size: 0x9c
function private function_c16f57e204f32fda()
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"missile_impact" );
    self waittill( #"missile_stuck", stuckto, hitentpart, surfacetype, velocity, origin, normal );
    self.stucknormal = normal;
    self notify( #"missile_impact" );
}

// Namespace decoy_grenade
// Params 1, eflags: 0x4
// Checksum 0x3e4c9466, Offset: 0x2a3e
// Size: 0x22b
function private onplayerdeath( params )
{
    attacker = params.attacker;
    victim = params.victim;
    
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    if ( victim.var_514599d62c60d142 )
    {
        victim thread gamelogic_mp::threadedsetweaponstatbyname( victim.var_514599d62c60d142, 1, "killed_while_debuffed_by", undefined, attacker );
        victim.var_514599d62c60d142 = undefined;
    }
    
    if ( !isdefined( attacker.var_5427f122343631e[ victim getentitynumber() ] ) )
    {
        return;
    }
    
    if ( params.iskillstreakweapon && !params.var_1344ad15d2d7bd21 )
    {
        return;
    }
    
    lootid = loot::getlootidfromref( "equip_decoy" );
    
    foreach ( victimentnum, var_ef390e0f60302de4 in attacker.var_5427f122343631e )
    {
        if ( victimentnum != victim getentitynumber() )
        {
            continue;
        }
        
        foreach ( mineid in var_ef390e0f60302de4 )
        {
            if ( !isdefined( attacker.var_cc53581857cbc93a[ mineid ] ) )
            {
                attacker.var_cc53581857cbc93a[ mineid ] = 0;
            }
            
            attacker.var_cc53581857cbc93a[ mineid ]++;
            
            if ( attacker.var_cc53581857cbc93a[ mineid ] == 3 )
            {
                attacker thread points::function_f8a0deb1a12da52e( #"triple_decoy", undefined, lootid );
            }
        }
    }
    
    attacker.var_841452f4ac91f5bd = 1;
    attacker thread points::function_f8a0deb1a12da52e( #"decoy_finished", undefined, lootid );
}

// Namespace decoy_grenade
// Params 1
// Checksum 0xe49b24b0, Offset: 0x2c71
// Size: 0x207
function add_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        self.var_30656af96b2ac2a4[ self.var_30656af96b2ac2a4.size ] = params.combatlink;
        
        if ( !self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] )
        {
            basepoints = rank::getscoreinfovalue( #"hash_b3bcbdb9304829cc" ) ?? 0;
            params.combatlink.owner thread points::doscoreevent( #"hash_b3bcbdb9304829cc", params.combatlink.weapon_object, basepoints * params.combatlink.var_352099d9d2836866 );
            
            if ( !isdefined( self.var_2695e71ddf32816c ) )
            {
                self.var_2695e71ddf32816c = [];
            }
            
            self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] = 1;
        }
        
        if ( params.combatlink.owner != self.owner && !self.var_2b2f786d6b12c032 )
        {
            self.owner thread points::doscoreevent( #"hash_25e1629f3588e56f", params.combatlink.weapon_object );
            self.var_2b2f786d6b12c032 = 1;
        }
        
        if ( self.var_30656af96b2ac2a4.size == 1 )
        {
            if ( isdefined( self.headiconid ) && isdefined( self.tableinfo.bundle.buffedheadicon ) )
            {
                setheadiconimage( self.headiconid, self.tableinfo.bundle.buffedheadicon, 1 );
            }
            
            self.var_226a7f177063c32f = params.bundle.var_2786d6263742cc39 ?? 16;
        }
    }
}

// Namespace decoy_grenade
// Params 1
// Checksum 0x32316ae3, Offset: 0x2e80
// Size: 0xb8
function remove_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        if ( arraycontains( self.var_30656af96b2ac2a4, params.combatlink ) )
        {
            self.var_30656af96b2ac2a4 = arrayremove( self.var_30656af96b2ac2a4, params.combatlink );
            
            if ( self.var_30656af96b2ac2a4.size <= 0 )
            {
                if ( isdefined( self.headiconid ) && isdefined( level.gamemodebundle.var_b96d2dfbabc4742d ) )
                {
                    setheadiconimage( self.headiconid, level.gamemodebundle.var_b96d2dfbabc4742d, 1 );
                }
                
                self.var_226a7f177063c32f = undefined;
            }
        }
    }
}

// Namespace decoy_grenade
// Params 2, eflags: 0x4
// Checksum 0xfebab4a1, Offset: 0x2f40
// Size: 0xe8
function private hack( hackeffect, attacker )
{
    if ( !hackeffect.var_30e7de3d76d5a085 )
    {
        return;
    }
    
    self notify( #"grenade_hacked" );
    function_404deed96264e14d();
    
    if ( self.owner.decoys && self.owner isconnected() )
    {
        self.owner.decoys = arrayremove( self.owner.decoys, self );
    }
    
    self.owner thread equipment_utility::function_364a1a0e0c018518( self.equipmentref, #"stolen_hacked" );
    self setscriptablepartstate( #"hacked", #"stolen", 0 );
    equipment_mp::hackequipment( attacker, hackeffect.var_fe6111ff085b2063 );
    thread monitorfuse();
    thread monitorsequence();
}

/#

    // Namespace decoy_grenade
    // Params 1, eflags: 0x4
    // Checksum 0xe4c81356, Offset: 0x3030
    // Size: 0x4a, Type: dev
    function private function_1793d1952d002500( color )
    {
        self endon( #"death" );
        
        while ( true )
        {
            thread debug::drawsphere( self.origin, 2, level.framedurationseconds, color );
            wait level.framedurationseconds;
        }
    }

    // Namespace decoy_grenade
    // Params 0
    // Checksum 0x41bdf2a6, Offset: 0x3082
    // Size: 0xbc, Type: dev
    function function_cb8dd56d442261e7()
    {
        self endon( #"death" );
        
        while ( true )
        {
            vel = _getvelocity( self.origin );
            
            if ( isdefined( vel ) )
            {
                speed = length( vel );
                
                if ( speed != 0 )
                {
                    velnorm = vel / speed;
                    speed = clamp( speed, 0, 350 );
                    lineratio = speed / 350;
                    thread debug::drawline( self.origin, self.origin + velnorm * lineratio * 25, level.framedurationseconds, ( 0, 0, 1 ) );
                }
            }
            
            wait level.framedurationseconds;
        }
    }

#/
