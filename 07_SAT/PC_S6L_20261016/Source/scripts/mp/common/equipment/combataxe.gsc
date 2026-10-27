// scripts\mp\common\equipment\combataxe.gsc  (hash_1e8bac323888e21b.gscc) (size: 6351 Bytes / 0x18cf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6241fc25 (1648491557)
// size ...... 6351 (0x18cf)
// includes .. 11  (offset: 0x175b)
// strings ... 21  (offset: 0x17b3)
// dev strs .. 1   (offset: 0x18c3)
// exports ... 17  (offset: 0xe4f)
// cseg ...... 0x1a0 + 0xcaf (0xe4f)
// imports ... 55  (offset: 0x10f7)
// animtree1 . 0   (offset: 0x18cf)
// animtree2 . 0   (offset: 0x18cf)
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\damagefeedback;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\weapons;

#namespace combataxe;

// Namespace combataxe
// Params 0, eflags: 0x1
// Checksum 0x54578167, Offset: 0x1be
// Size: 0xea
function autoexec combataxe_init()
{
    utility::flag_wait( "equipment_initialized" );
    bundledata = level.equipment.table[ "equip_combataxe" ].bundle;
    level.var_b6ceb547ca5547a1 = bundledata.combataxe_maxcount ?? getdvarint( @"hash_a8688fbb87e97cc", 12 );
    level.var_cffb9deb8c1637a8 = bundledata.var_175358e4f9426027 ?? getdvarint( @"hash_34e3329944567447", 12 );
    level.var_329768d4f5bb3bc1 = bundledata.combataxe_timeout ?? getdvarfloat( @"hash_12dae8a7bec5e630", 64 );
    callback::add( #"player_laststand", &onplayerlaststand );
    callback::add( #"hash_244314ef9125e636", &ondeath );
    weapons::registerusedcallback( "combataxe", &combataxe_used );
}

// Namespace combataxe
// Params 1, eflags: 0x4
// Checksum 0xf5904192, Offset: 0x2b0
// Size: 0x91
function private onplayerlaststand( deathdata )
{
    if ( deathdata.inflictor.bounced && isplayer( deathdata.victim ) && isplayer( deathdata.attacker ) )
    {
        if ( !isdefined( deathdata.callbackeventdata ) )
        {
            deathdata.callbackeventdata = [];
        }
        
        deathdata.callbackeventdata[ "combat_axe" ] = 1;
        deathdata.attacker.var_4b8d810f484a22cb = 1;
    }
}

// Namespace combataxe
// Params 1, eflags: 0x4
// Checksum 0xeb258a22, Offset: 0x349
// Size: 0xe8
function private ondeath( deathdata )
{
    if ( deathdata.victim.inlaststand )
    {
        laststanddowneddata = deathdata.victim.laststanddowneddata;
        
        if ( laststanddowneddata.callbackeventdata[ "combat_axe" ] )
        {
            laststanddowneddata.attacker thread points::doscoreevent( #"bankshot_axe" );
        }
        
        return;
    }
    
    if ( deathdata.inflictor.bounced && isplayer( deathdata.victim ) && isplayer( deathdata.attacker ) )
    {
        deathdata.attacker thread points::doscoreevent( #"bankshot_axe" );
        deathdata.attacker.var_4b8d810f484a22cb = 1;
    }
}

// Namespace combataxe
// Params 1
// Checksum 0x1ec33b0c, Offset: 0x439
// Size: 0x28c
function combataxe_used( grenade )
{
    grenade endon( #"death" );
    ref = equipment_mp::function_fdc4a655fbde0dec( grenade.weapon_name );
    grenade.tableinfo = weapon::getequipmenttableinfo( ref );
    grenade.deletefunction = &deletepickup;
    grenade callback::callback( "on_combat_axe_used" );
    
    if ( !isdefined( grenade.tableinfo.bundle ) )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    grenade makeunusable();
    grenade_owner_name = self.name;
    grenade setscriptablepartstate( "onThrow", "active", 0 );
    grenade.owner = self;
    grenade thread watchplayerdeath();
    grenade.bounced = 0;
    grenade thread function_322afe9aaaeac448();
    grenade thread function_859f48a905e4b139();
    grenade thread delay_show( 0.05 );
    grenade waittill( #"missile_stuck", stuckto, stuckpart );
    grenade.var_be6e8f5c5d18acc = 1;
    
    if ( isplayer( stuckto ) )
    {
        stuckto playsoundtoplayer( grenade.tableinfo.bundle.var_56cc79162f31357e ?? #"hash_b80d93d77a00bd38", stuckto, grenade );
        
        foreach ( player in getplayersinradius( grenade.origin, grenade.tableinfo.bundle.var_b9842fbb652728fb ?? 750 ) )
        {
            if ( player != stuckto )
            {
                player playsoundtoplayer( grenade.tableinfo.bundle.var_56c46d162f292f6c ?? #"hash_f7fde9b938e576ab", player, grenade );
            }
        }
    }
    
    level notify( #"hash_f8acd64098a6f03f", grenade, "combataxe_mp", grenade_owner_name );
    grenade setscriptablepartstate( "onThrow", "neutral", 0 );
    
    if ( grenade.owner )
    {
        grenade makepickup();
        return;
    }
    
    grenade deletepickup();
}

// Namespace combataxe
// Params 1, eflags: 0x4
// Checksum 0x8453eea0, Offset: 0x6cd
// Size: 0x2d
function private delay_show( delaytime )
{
    if ( self isscriptable() )
    {
        wait delaytime;
        
        if ( isdefined( self ) )
        {
            self setscriptablepartstate( "visibility", "show", 0 );
        }
    }
}

// Namespace combataxe
// Params 0, eflags: 0x4
// Checksum 0x6360e67f, Offset: 0x702
// Size: 0x26
function private function_322afe9aaaeac448()
{
    self endon( #"death" );
    self waittill( #"missile_bounced" );
    self.bounced = 1;
}

// Namespace combataxe
// Params 0, eflags: 0x4
// Checksum 0x7c4abf8e, Offset: 0x730
// Size: 0x1ac
function private function_859f48a905e4b139()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"projectile_impact_ai", ai );
        
        if ( !isdefined( ai ) )
        {
            continue;
        }
        
        if ( isdefined( self.owner ) )
        {
            self.owner playsoundtoplayer( self.tableinfo.bundle.var_56cc79162f31357e ?? #"hash_b80d93d77a00bd38", self.owner, self );
            
            if ( !isdefined( self.owner.var_ebbf54a154def53a ) )
            {
                self.owner.var_ebbf54a154def53a = int( 0 );
            }
            
            self.owner.var_ebbf54a154def53a++;
            self.hit_ai = 1;
        }
        
        foreach ( player in getplayersinradius( self.origin, self.tableinfo.bundle.var_b9842fbb652728fb ?? 750 ) )
        {
            if ( player != self.owner )
            {
                player playsoundtoplayer( self.tableinfo.bundle.var_56c46d162f292f6c ?? #"hash_f7fde9b938e576ab", player, self );
            }
        }
    }
}

// Namespace combataxe
// Params 0, eflags: 0x4
// Checksum 0x543131b7, Offset: 0x8e4
// Size: 0x239
function private makepickup()
{
    self makeunusable();
    pickuptriggerradius = self.tableinfo.bundle.var_48ca49145a2bd957 ?? 64;
    
    if ( isdefined( self.owner.var_e771ace57fbed908 ) )
    {
        pickuptriggerradius = self.owner.var_e771ace57fbed908;
    }
    
    trigger = spawn( "trigger_radius", self.origin, 0, pickuptriggerradius, pickuptriggerradius );
    trigger.targetname = "dropped_combataxe";
    trigger enablelinkto();
    trigger linkto( self );
    self.combataxe_trigger = trigger;
    
    if ( !isdefined( level.combataxes ) )
    {
        level.combataxes = [];
    }
    
    temparr = [ self ];
    var_b9adfb2b89ed47ec = 0;
    
    foreach ( combataxe in level.combataxes )
    {
        if ( isdefined( combataxe ) )
        {
            if ( combataxe.owner == self.owner )
            {
                var_b9adfb2b89ed47ec++;
            }
            
            if ( temparr.size >= level.var_b6ceb547ca5547a1 || var_b9adfb2b89ed47ec >= level.var_cffb9deb8c1637a8 )
            {
                combataxe deletepickup();
                continue;
            }
            
            temparr[ temparr.size ] = combataxe;
        }
    }
    
    level.combataxes = temparr;
    
    if ( self.bundle.var_e822791f5e55ac6e )
    {
        self hudoutlineenableforclient( self.owner, self.bundle.combataxe_hudoutline ?? "defaulthudoutline" );
    }
    
    thread watchpickup();
    thread watchpickuptimeout();
    thread watchpickupother();
    utility::function_969f9f5596dba07a( self, &function_e4cd87a090982c1d );
    
    if ( !self.hit_ai )
    {
        self.owner.var_ebbf54a154def53a = 0;
    }
    
    self.hit_ai = 0;
}

// Namespace combataxe
// Params 0, eflags: 0x4
// Checksum 0xfb73fde0, Offset: 0xb25
// Size: 0x3f
function private watchplayerdeath()
{
    self endon( #"death" );
    self.owner waittill( #"death" );
    self.owner waittill( #"spawned" );
    deletepickup();
}

// Namespace combataxe
// Params 0, eflags: 0x4
// Checksum 0x552f7e1a, Offset: 0xb6c
// Size: 0x161
function private watchpickup()
{
    self endon( #"death" );
    
    while ( true )
    {
        self.combataxe_trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !player player::isreallyalive() )
        {
            continue;
        }
        
        if ( player != self.owner )
        {
            continue;
        }
        
        if ( !player hasweapon( self.weapon_object ) )
        {
            continue;
        }
        
        trace = trace::ray_trace( player geteye(), self.origin + ( 0, 0, 10 ), self, undefined, 1 );
        
        if ( trace[ "hittype" ] != "hittype_entity" )
        {
            if ( trace[ "hittype" ] != "hittype_none" )
            {
                continue;
            }
        }
        
        if ( player trytopickup( self.equipmentref ) )
        {
            if ( !level.damagefeedbacknosound )
            {
                self setscriptablepartstate( "onPickup", "active", 0 );
            }
            
            if ( self.bundle.var_44cd3fe8142fb788 )
            {
                itembundlename = common_item_database::function_a4f0a21951180013( self.equipmentref );
                itembundle = common_item::function_90c3e0c1fd55d6b6( itembundlename );
                itemcount = 1;
                player thread common_item::function_29cda7adf128f6fb( itembundle, itemcount );
            }
            
            waitframe();
            deletepickup();
        }
    }
}

// Namespace combataxe
// Params 0, eflags: 0x4
// Checksum 0x7a072edf, Offset: 0xcd5
// Size: 0x1f
function private watchpickuptimeout()
{
    self endon( #"death" );
    wait level.var_329768d4f5bb3bc1;
    deletepickup();
}

// Namespace combataxe
// Params 0, eflags: 0x4
// Checksum 0x43e428f, Offset: 0xcfc
// Size: 0x65
function private watchpickupother()
{
    self endon( #"death" );
    
    while ( true )
    {
        self.owner waittill( #"equipment_given", ref, slot );
        
        if ( slot == "primary" )
        {
            if ( ref != self.equipmentref )
            {
                break;
            }
        }
    }
    
    deletepickup();
}

// Namespace combataxe
// Params 0
// Checksum 0x2ff4e865, Offset: 0xd69
// Size: 0x26
function deletepickup()
{
    if ( self.combataxe_trigger )
    {
        self.combataxe_trigger delete();
    }
    
    if ( self )
    {
        self delete();
    }
}

// Namespace combataxe
// Params 1, eflags: 0x4
// Checksum 0xb1df8f4d, Offset: 0xd97
// Size: 0x74, Type: bool
function private trytopickup( equipmentref )
{
    if ( equipment_mp::hasequipment( equipmentref ) && equipment_mp::getequipmentammo( equipmentref ) < equipment_mp::getequipmentmaxammo( equipmentref ) )
    {
        thread function_cec60ff7c3125975();
        equipment_mp::incrementequipmentammo( equipmentref );
        callbackparams = { #equipmentref:equipmentref, #player:self };
        callback::callback( #"equipment_reclaimed", callbackparams );
        return true;
    }
    
    return false;
}

// Namespace combataxe
// Params 0, eflags: 0x4
// Checksum 0x1ef9f4a3, Offset: 0xe14
// Size: 0x2b
function private function_cec60ff7c3125975()
{
    self endon( #"disconnect" );
    damagefeedback::hudicontype( "combataxe" );
    waitframe();
    self setclientomnvar( "damage_feedback_other", "standard" );
}

// Namespace combataxe
// Params 0, eflags: 0x4
// Checksum 0xa3117716, Offset: 0xe47
// Size: 0x8
function private function_e4cd87a090982c1d()
{
    self delete();
}

