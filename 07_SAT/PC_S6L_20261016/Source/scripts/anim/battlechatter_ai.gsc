// scripts\anim\battlechatter_ai.gsc  (hash_0f4e8d02d2f70888.gscc) (size: 5947 Bytes / 0x173b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7d3f3063 (2101293155)
// size ...... 5947 (0x173b)
// includes .. 5   (offset: 0x1623)
// strings ... 17  (offset: 0x164b)
// dev strs .. 1   (offset: 0x172f)
// exports ... 23  (offset: 0xd7f)
// cseg ...... 0x12a + 0xc55 (0xd7f)
// imports ... 44  (offset: 0x1117)
// animtree1 . 0   (offset: 0x173b)
// animtree2 . 0   (offset: 0x173b)
#using script_433d8f78f7e5fb;
#using scripts\anim\battlechatter;
#using scripts\anim\battlechatter_events;
#using scripts\asm\asm;
#using scripts\common\utility;

#namespace battlechatter_ai;

// Namespace battlechatter_ai
// Params 0
// Checksum 0xd0053172, Offset: 0x148
// Size: 0x193
function addtosystem()
{
    if ( !isdefined( level.battlechatter ) )
    {
        return;
    }
    
    self endon( #"death" );
    assert( isdefined( self.squad ) );
    
    if ( !isdefined( self.battlechatterallowed ) )
    {
        self.battlechatterallowed = 1;
    }
    
    if ( isplayer( self ) )
    {
        self.battlechatterallowed = 0;
        self.type = "human";
        return;
    }
    
    if ( self.unittype == "dog" || self.unittype == "zombie" && isbrgamemode() || self.unittype == "juggernaut" && getprojectname() != "T10" && getprojectname() != "SAT" || self.team == "neutral" )
    {
        self.battlechatterallowed = 0;
        return;
    }
    
    if ( level.var_7fd9a527113d4767 )
    {
        self.battlechatterallowed = 0;
        return;
    }
    
    self.battlechatter.friendlyfire_force = 1;
    self.headknob = asm::asm_getxanim( "knobs", asm::asm_lookupanimfromalias( "knobs", "head" ) );
    self.scriptedtalkingknob = asm::asm_getxanim( "knobs", asm::asm_lookupanimfromalias( "knobs", "scripted_talking" ) );
    self.defaulttalk = asm::asm_getxanim( "knobs", asm::asm_lookupanimfromalias( "knobs", "default_talking" ) );
    setvoice();
    thread aiThreadWaiter();
    self.chatinitialized = 1;
}

// Namespace battlechatter_ai
// Params 3
// Checksum 0xee82a16c, Offset: 0x2e3
// Size: 0x97
function setup_mp_hero( var_9582b5184d9de612, combatmapid, stealthmapid )
{
    var_3caaf1badd796942 = tolower( var_9582b5184d9de612 ?? self.script_friendname );
    self.battlechatter.countryid = var_3caaf1badd796942;
    self.battlechatter.npcid = undefined;
    self.battlechatter.ishero = 1;
    anim.var_4ef5299ac30c33e6[ var_3caaf1badd796942 ] = combatmapid;
    anim.var_c285202ed79ffced[ var_3caaf1badd796942 ] = stealthmapid;
}

/#

    // Namespace battlechatter_ai
    // Params 2
    // Checksum 0x997794eb, Offset: 0x382
    // Size: 0x22, Type: dev
    function function_e93e1e260edea53( text, duration )
    {
        thread function_a7f2420b11f54b4d( text, duration );
    }

    // Namespace battlechatter_ai
    // Params 2, eflags: 0x4
    // Checksum 0x7a5b7932, Offset: 0x3ac
    // Size: 0x6f, Type: dev
    function private function_a7f2420b11f54b4d( text, duration )
    {
        self endon( #"death" );
        
        if ( !isdefined( self.var_6d86abb3f23dafe7 ) )
        {
            return;
        }
        
        self.var_6d86abb3f23dafe7[ self.var_6d86abb3f23dafe7.size ] = text;
        
        if ( !isdefined( duration ) )
        {
            return;
        }
        
        wait duration;
        self.var_6d86abb3f23dafe7 = utility::function_d751969553a4bddd( self.var_6d86abb3f23dafe7, text );
    }

    // Namespace battlechatter_ai
    // Params 0, eflags: 0x4
    // Checksum 0xc1e9b216, Offset: 0x423
    // Size: 0xd1, Type: dev
    function private debug_print_lines()
    {
        self endon( #"death" );
        self.var_6d86abb3f23dafe7 = [];
        
        for ( ;; )
        {
            height = 30;
            
            foreach ( debugln in self.var_6d86abb3f23dafe7 )
            {
                print3d( self gettagorigin( "<dev string:x24>" ) + ( 0, 0, height ), debugln, ( 1, 1, 1 ), 1, 0.5, 1, 1 );
                height += 10;
            }
            
            waitframe();
        }
    }

#/

// Namespace battlechatter_ai
// Params 0
// Checksum 0xfaa28891, Offset: 0x4fc
// Size: 0xe4
function clearvoice()
{
    if ( isdefined( self.battlechatter.npcid ) && isdefined( self.voice ) )
    {
        foreach ( usedid in anim.usedids[ self.voice ] )
        {
            if ( usedid.npcid == self.battlechatter.npcid )
            {
                usedid.count--;
                break;
            }
        }
    }
    
    self.battlechatter.npcid = undefined;
}

// Namespace battlechatter_ai
// Params 1
// Checksum 0x5ff8594b, Offset: 0x5e8
// Size: 0x9e
function setvoice( voice )
{
    if ( isdefined( voice ) )
    {
        self.voice = voice;
    }
    
    if ( !isdefined( self.voice ) )
    {
        return;
    }
    
    if ( isdefined( self.battlechatter ) && isdefined( self.battlechatter.npcid ) )
    {
        clearvoice();
    }
    
    self.battlechatter.countryid = anim.countryids[ self.voice ];
    
    if ( !isdefined( self.battlechatter.countryid ) )
    {
        return;
    }
    
    namespace_326cae52b2158981::assign_npcid();
}

// Namespace battlechatter_ai
// Params 0
// Checksum 0x3d6db63f, Offset: 0x68e
// Size: 0x10
function reassignvoiceid()
{
    clearvoice();
    namespace_326cae52b2158981::assign_npcid();
}

// Namespace battlechatter_ai
// Params 1
// Checksum 0x933b1021, Offset: 0x6a6
// Size: 0x1a5
function removefromsystem( squad )
{
    if ( !( isdefined( level.battlechatter ) && isdefined( self ) ) )
    {
        return;
    }
    
    if ( !isalive( self ) && isdefined( self.attacker ) && squad.team != self.attacker.team && squad.team != "neutral" )
    {
        if ( isscriptedai( self.attacker ) )
        {
            self.attacker setbattlechatterflag( "KilledTarget", 1 );
        }
        
        self.attacker thread battlechatter_events::killfirmevent( self, self.attacker.team );
        thread battlechatter_events::casualtyevent( squad.team );
    }
    
    if ( isdefined( self.battlechatter ) && isdefined( self.battlechatter.npcid ) && isdefined( self.voice ) )
    {
        clearvoice();
        
        if ( isdefined( level.stealth ) && isdefined( level.var_ed9f17bb0f80706e ) )
        {
            thread set_corpse_values( squad.team, self.battlechatter.countryid, self.battlechatter.npcid, self.battlechatter.name );
        }
    }
    else if ( isdefined( self.var_8d4f5e01dc1af2e8 ) )
    {
        self.var_8d4f5e01dc1af2e8 notify( #"death" );
        self.var_8d4f5e01dc1af2e8 delete();
    }
    
    self notify( #"hash_c503932d9806162" );
}

// Namespace battlechatter_ai
// Params 4
// Checksum 0xe4f43e55, Offset: 0x853
// Size: 0x1c0
function set_corpse_values( team, countryid, npcid, name )
{
    if ( level.var_c500168c9dd66126 )
    {
        return;
    }
    
    origin = self.origin;
    voice = self.voice;
    
    if ( !utility::issp() )
    {
        function_72df09bab3ab3355();
        return;
    }
    
    entnum = self getentitynumber();
    corpse = undefined;
    
    while ( !isdefined( corpse ) )
    {
        array = [[ level.var_ed9f17bb0f80706e ]]( level.bcs_neardist );
        
        foreach ( corpseent in array )
        {
            if ( corpseent getentitynumber() == entnum )
            {
                corpse = corpseent;
            }
        }
        
        waitframe();
    }
    
    corpse.team = team;
    corpse.voice = voice;
    corpse.battlechatter = spawnstruct();
    corpse.battlechatter.countryid = countryid;
    corpse.battlechatter.npcid = npcid;
    corpse.battlechatter.name = name;
    corpse.battlechatterallowed = 1;
    
    if ( isdefined( level.stealth ) )
    {
        corpse thread corpseloop();
    }
}

// Namespace battlechatter_ai
// Params 0
// Checksum 0x3157474b, Offset: 0xa1b
// Size: 0x2
function function_72df09bab3ab3355()
{
    
}

// Namespace battlechatter_ai
// Params 0
// Checksum 0xb0fadc10, Offset: 0xa25
// Size: 0x2
function corpseloop()
{
    
}

// Namespace battlechatter_ai
// Params 0
// Checksum 0x585d5993, Offset: 0xa2f
// Size: 0xf0
function setnpcid()
{
    assert( !isdefined( self.battlechatter.npcid ) );
    usedids = anim.usedids[ self.voice ];
    numids = usedids.size;
    startindex = randomint( numids );
    lowestid = startindex;
    
    for ( index = 0; index <= numids ; index++ )
    {
        if ( usedids[ ( startindex + index ) % numids ].count < usedids[ lowestid ].count )
        {
            lowestid = ( startindex + index ) % numids;
        }
    }
    
    anim.usedids[ self.voice ][ lowestid ].count++;
    self.battlechatter.npcid = usedids[ lowestid ].npcid;
}

// Namespace battlechatter_ai
// Params 1
// Checksum 0x99242b0d, Offset: 0xb27
// Size: 0x15
function evaluateattackevent( weapon )
{
    battlechatter_events::useevent( weapon );
}

// Namespace battlechatter_ai
// Params 0
// Checksum 0x3f264122, Offset: 0xb44
// Size: 0x5e
function aiThreadWaiter()
{
    self endon( #"death" );
    self endon( #"hash_c503932d9806162" );
    self notify( #"aiThreadWaiter" );
    self endon( #"aiThreadWaiter" );
    childthread waittill_missile_fire();
    childthread waittill_grenade_fire();
    childthread waittill_weapon_fire();
    childthread waittill_move();
    
    if ( function_9cf3c90e5a54e67() > 0 )
    {
        childthread waittill_red_alert();
    }
}

// Namespace battlechatter_ai
// Params 0
// Checksum 0xd5ce0505, Offset: 0xbaa
// Size: 0x53
function waittill_missile_fire()
{
    while ( true )
    {
        self waittill( #"missile_fire", missile, objweapon );
        bcs_subcategory = battlechatter_events::function_e08b029c30762ab3( objweapon );
        
        if ( isdefined( bcs_subcategory ) )
        {
            addbattlechatternotify( self, undefined, "use", bcs_subcategory );
        }
    }
}

// Namespace battlechatter_ai
// Params 0
// Checksum 0x4be76912, Offset: 0xc05
// Size: 0x6d
function waittill_grenade_fire()
{
    while ( true )
    {
        self waittill( #"grenade_fire", grenade );
        
        if ( isdefined( grenade ) && isdefined( grenade.weapon_object ) )
        {
            bcs_subcategory = battlechatter_events::function_e08b029c30762ab3( grenade.weapon_object );
            
            if ( battlechatter::function_1d3591529c0364a9( bcs_subcategory ) )
            {
                addbattlechatternotify( self, grenade, "grenade_danger", bcs_subcategory );
            }
        }
    }
}

// Namespace battlechatter_ai
// Params 0
// Checksum 0x51091ed4, Offset: 0xc7a
// Size: 0x23
function waittill_weapon_fire()
{
    while ( true )
    {
        self waittill( #"weapon_fired" );
        addbattlechatternotify( self, undefined, "attack" );
    }
}

// Namespace battlechatter_ai
// Params 0
// Checksum 0x207804a, Offset: 0xca5
// Size: 0x40
function waittill_move()
{
    while ( true )
    {
        self waittill( #"goal_changed" );
        
        if ( distance2dsquared( self.origin, self.goalpos ) > 10000 )
        {
            addbattlechatternotify( self, undefined, "move" );
        }
    }
}

// Namespace battlechatter_ai
// Params 0
// Checksum 0xf5360a5c, Offset: 0xced
// Size: 0x38
function waittill_red_alert()
{
    var_c17f4750045f3e9e = 0;
    
    while ( true )
    {
        if ( var_c17f4750045f3e9e != getglobalescalation() )
        {
            var_c17f4750045f3e9e = !var_c17f4750045f3e9e;
            
            if ( var_c17f4750045f3e9e )
            {
                addbattlechatternotify( self, undefined, "red_alert" );
            }
        }
        
        waitframe();
    }
}

// Namespace battlechatter_ai
// Params 0
// Checksum 0x88276c78, Offset: 0xd2d
// Size: 0x2
function aivehiclekillwaiter()
{
    
}

// Namespace battlechatter_ai
// Params 6
// Checksum 0x9d00c7b4, Offset: 0xd37
// Size: 0x48
function custom_battlechatter_internal( phrase, sequence, priority, timeout, cooldown, endons )
{
    battlechatter::function_b63bed8df8e4202a( phrase, phrase, priority, timeout, cooldown, endons );
}

