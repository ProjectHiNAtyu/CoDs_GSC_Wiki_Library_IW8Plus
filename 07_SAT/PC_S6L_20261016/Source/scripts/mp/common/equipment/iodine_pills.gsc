// scripts\mp\common\equipment\iodine_pills.gsc  (hash_38d4166e7c6f4e4e.gscc) (size: 4661 Bytes / 0x1235 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7dc0020f (2109735439)
// size ...... 4661 (0x1235)
// includes .. 14  (offset: 0x1081)
// strings ... 21  (offset: 0x10f1)
// dev strs .. 4   (offset: 0x1205)
// exports ... 14  (offset: 0x8b1)
// cseg ...... 0x19d + 0x714 (0x8b1)
// imports ... 50  (offset: 0xae1)
// animtree1 . 0   (offset: 0x1235)
// animtree2 . 0   (offset: 0x1235)
#using scripts\common\gasmask;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\loot;
#using scripts\mp\equipment;
#using scripts\mp\juggernaut;
#using scripts\mp\scripted_weapons;
#using scripts\mp\weapons;

#namespace iodine_pills;

// Namespace iodine_pills
// Params 0, eflags: 0x1
// Checksum 0xa14362bb, Offset: 0x1bb
// Size: 0x97
function autoexec iodinepills_init()
{
    utility::flag_wait( "equipment_initialized" );
    val::group_register( "iodineUse", [ "usability", "killstreaks", "supers", "gesture", "weapon_switch", "melee", "armor" ] );
    weapons::registerusedcallback( "iodine_pills", &function_7a744405785fd9e8 );
    equipment_mp::registercallback( "equip_iodine_pills", "onGive", &function_43611857f8c4edf1 );
    equipment_mp::registercallback( "equip_iodine_pills", "onTake", &function_310aea969e05e4db );
}

// Namespace iodine_pills
// Params 4
// Checksum 0x8186e0b3, Offset: 0x25a
// Size: 0x33
function function_43611857f8c4edf1( equipmentref, equipmentslot, variantid, attachments )
{
    if ( equipmentref != "equip_iodine_pills" )
    {
        return;
    }
}

// Namespace iodine_pills
// Params 2
// Checksum 0x24352170, Offset: 0x295
// Size: 0x21
function function_310aea969e05e4db( equipmentref, equipmentslot )
{
    if ( equipmentref != "equip_iodine_pills" )
    {
        return;
    }
}

// Namespace iodine_pills
// Params 2
// Checksum 0xe334cc89, Offset: 0x2be
// Size: 0x3d
function iodinepills_onuse( grenade, lootpickup )
{
    equipuse = undefined;
    
    if ( !isdefined( grenade ) )
    {
        equipuse = 0;
    }
    else
    {
        equipuse = 1;
    }
    
    thread function_360fcac375f17d05( equipuse, lootpickup );
}

// Namespace iodine_pills
// Params 2
// Checksum 0x2d6e21fd, Offset: 0x303
// Size: 0xe5
function function_360fcac375f17d05( equipuse, lootpickup )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !function_eacf829d4f76e04c() )
    {
        return;
    }
    
    if ( !equipuse )
    {
        if ( isdefined( lootpickup ) )
        {
            lootid = loot::function_d3e3bcaea591a6a2( lootpickup.scriptablename );
            br_default_inventory::function_f0398a1e115d3553( lootid, 1 );
        }
        
        thread function_a0a16ba2033b8b2();
        weaponobj = scripted_weapons::get_scripted_weapon_object( #"iodine_pills" );
        self giveandfireoffhand( weaponobj );
        self waittill( #"grenade_fire", grenade, objweapon );
    }
    
    extendduration = 0;
    
    if ( function_4ac5fefa68717ddd( self ) )
    {
        extendduration = 1;
    }
    else
    {
        self.radiationblock = 1;
    }
    
    thread function_f535fc9ce8829850( extendduration );
}

// Namespace iodine_pills
// Params 2
// Checksum 0x824b6815, Offset: 0x3f0
// Size: 0x61
function function_a880610ef6c2556d( duration, var_73fbe15fa3047a95 )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    extendduration = 0;
    
    if ( function_4ac5fefa68717ddd( self ) )
    {
        extendduration = 1;
    }
    else
    {
        self.radiationblock = 1;
    }
    
    thread function_f60bc1c09e11804e( extendduration, duration, var_73fbe15fa3047a95 );
}

// Namespace iodine_pills
// Params 3
// Checksum 0x64cd2b1, Offset: 0x459
// Size: 0x110
function function_f60bc1c09e11804e( extendduration, durationtime, maxduration )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self notify( #"iodinepills_duration" );
    self endon( #"iodinepills_duration" );
    effectduration = durationtime ?? 120;
    var_ae71d435fab9d59d = maxduration ?? 240;
    
    if ( extendduration )
    {
        if ( isdefined( self.var_d2c551eb3d7c6058 ) )
        {
            remainingduration = self.var_d2c551eb3d7c6058;
            newduration = effectduration + remainingduration;
            effectduration = min( newduration, var_ae71d435fab9d59d );
            
            /#
                iprintlnbold( "<dev string:x24>" + effectduration );
            #/
        }
    }
    
    while ( effectduration > 0 )
    {
        if ( !isalive( self ) )
        {
            break;
        }
        
        self.var_d2c551eb3d7c6058 = effectduration;
        effectduration -= 0.05;
        wait 0.05;
    }
    
    self.radiationblock = undefined;
    self.var_a644f3c4a539efc8 = undefined;
    
    /#
        iprintlnbold( "<dev string:x6b>" );
    #/
}

// Namespace iodine_pills
// Params 0
// Checksum 0xe38991a3, Offset: 0x571
// Size: 0xa2, Type: bool
function function_eacf829d4f76e04c()
{
    if ( vehicle_occupancy::function_3080323254ba6900( self ) )
    {
        return false;
    }
    
    if ( utility::isusingremote() )
    {
        return false;
    }
    
    if ( self.insertingarmorplate )
    {
        return false;
    }
    
    if ( self isswitchingweapon() || inventory_utility::isanymonitoredweaponswitchinprogress() )
    {
        return false;
    }
    
    if ( self isinfreefall() || self isparachuting() )
    {
        return false;
    }
    
    if ( self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() || self isgestureplaying() )
    {
        return false;
    }
    
    if ( self islinked() )
    {
        return false;
    }
    
    if ( !val::get( "offhand_weapons" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace iodine_pills
// Params 0
// Checksum 0x49573940, Offset: 0x61c
// Size: 0x42
function function_a0a16ba2033b8b2()
{
    self endon( #"disconnect" );
    val::group_set( "iodineUse", 0 );
    utility::waittill_any( "grenade_fire", "death", "last_stand_enter", "enter_live_ragdoll" );
    val::group_reset( "iodineUse" );
}

// Namespace iodine_pills
// Params 1
// Checksum 0x5bb056d8, Offset: 0x666
// Size: 0x19
function function_7a744405785fd9e8( grenade )
{
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
}

// Namespace iodine_pills
// Params 3
// Checksum 0x631212f3, Offset: 0x687
// Size: 0x131
function function_f535fc9ce8829850( extendduration, durationtime, maxduration )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self notify( #"iodinepills_duration" );
    self endon( #"iodinepills_duration" );
    effectduration = durationtime ?? 120;
    var_ae71d435fab9d59d = maxduration ?? 240;
    
    if ( extendduration )
    {
        if ( isdefined( self.var_d2c551eb3d7c6058 ) )
        {
            remainingduration = self.var_d2c551eb3d7c6058;
            newduration = effectduration + remainingduration;
            effectduration = min( newduration, var_ae71d435fab9d59d );
            
            /#
                iprintlnbold( "<dev string:xba>" + effectduration );
            #/
        }
    }
    
    while ( effectduration > 0 )
    {
        if ( !isalive( self ) )
        {
            break;
        }
        
        self setclientomnvar( "ui_iodine_pills", int( ceil( effectduration ) ) );
        self.var_d2c551eb3d7c6058 = effectduration;
        effectduration -= 0.05;
        wait 0.05;
    }
    
    self setclientomnvar( "ui_iodine_pills", 0 );
    self.radiationblock = undefined;
    self.var_a644f3c4a539efc8 = undefined;
    
    /#
        iprintlnbold( "<dev string:xfc>" );
    #/
}

// Namespace iodine_pills
// Params 1
// Checksum 0xf3214fbb, Offset: 0x7c0
// Size: 0xd0
function function_46beb04b73f111a7( damage )
{
    if ( isdefined( self.var_a644f3c4a539efc8 ) )
    {
        var_ee79f9039ba5e8b6 = self.var_a644f3c4a539efc8 + 2000;
        
        if ( gettime() < var_ee79f9039ba5e8b6 )
        {
            return 0;
        }
    }
    
    player = self;
    
    if ( player killstreak::isjuggernaut() )
    {
        damage = juggernaut::function_9d3c45be0af60321( damage );
    }
    
    damage = max( 1, int( damage * 0.5 ) );
    self.var_a644f3c4a539efc8 = gettime();
    
    if ( gasmask::hasgasmask( player ) )
    {
        return damage;
    }
    
    player dodamage( damage, player.origin, player, undefined, "MOD_TRIGGER_HURT", "danger_circle_br" );
    player armor::damagearmor( damage );
    player thread br_circle::tryplaycoughaudio( randomintrange( 7000, 10000 ) );
    return damage;
}

// Namespace iodine_pills
// Params 1
// Checksum 0x9b0e5bc2, Offset: 0x898
// Size: 0x18, Type: bool
function function_4ac5fefa68717ddd( player )
{
    return istrue( player.radiationblock );
}

