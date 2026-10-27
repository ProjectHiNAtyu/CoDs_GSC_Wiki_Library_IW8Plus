// scripts\mp\augments\deathperception_augments.gsc  (hash_69461e2a903587c3.gscc) (size: 6150 Bytes / 0x1806 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xda0ee060 (3658408032)
// size ...... 6150 (0x1806)
// includes .. 8   (offset: 0x1692)
// strings ... 21  (offset: 0x16d2)
// dev strs .. 1   (offset: 0x17fa)
// exports ... 15  (offset: 0xe32)
// cseg ...... 0x1e9 + 0xc49 (0xe32)
// imports ... 51  (offset: 0x108a)
// animtree1 . 0   (offset: 0x1806)
// animtree2 . 0   (offset: 0x1806)
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\loot\common_item;

#namespace deathperception_augments;

// Namespace deathperception_augments
// Params 0, eflags: 0x5
// Checksum 0x5dae6677, Offset: 0x207
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"deathperception_augments", undefined, &init_deathperception_augments, undefined );
}

// Namespace deathperception_augments
// Params 0
// Checksum 0x50c4a8c3, Offset: 0x228
// Size: 0x83
function init_deathperception_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    callback::add( "zm_perk_obtained", &function_288f120db5b6defb );
    callback::add( "zm_perk_lost", &function_9e09844df6bf44c7 );
    callback::add( #"on_ai_killed", &on_ai_killed );
    utility::registersharedfunc( #"zombie", #"hash_896b88a46f6a4c15", &function_2c28af8695bac142 );
    utility::registersharedfunc( #"zombie", #"hash_26befc250486510c", &function_a212e61dd8953c31 );
}

// Namespace deathperception_augments
// Params 1
// Checksum 0xf2b5be68, Offset: 0x2b3
// Size: 0xd1
function function_288f120db5b6defb( params )
{
    if ( params.var_ffc1674def575bfa == "specialty_death_perception" )
    {
        if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_death_perception", #"deathperception_sixth_sense" ) )
        {
            thread function_8c24bd598676f9cf();
        }
        
        hasdeathstare = istrue( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_death_perception", #"deathperception_death_stare" ) );
        
        if ( hasdeathstare )
        {
            zombie_utils::function_dfae6a5bd222c586( &function_aea3f6d236ab3633 );
        }
        
        var_6bbfb5f79d746c84 = istrue( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_death_perception", #"deathperception_critical_eye" ) );
        
        if ( var_6bbfb5f79d746c84 )
        {
            thread function_b4b64b08ec7d6636();
        }
    }
}

// Namespace deathperception_augments
// Params 1
// Checksum 0xf6a7cce5, Offset: 0x38c
// Size: 0x38
function function_9e09844df6bf44c7( params )
{
    self notify( #"hash_39e453d8a791005f" );
    update_sixth_sense( 0 );
    self notify( #"hash_7b30e2d30fd3926d" );
    zombie_utils::function_10c0c35c21e3ed9d( &function_aea3f6d236ab3633 );
}

// Namespace deathperception_augments
// Params 0
// Checksum 0xa9e1316c, Offset: 0x3cc
// Size: 0x45
function function_b4b64b08ec7d6636()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_7b30e2d30fd3926d" );
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        self.var_81dcc244c7c4591e = function_f4153837d798924e( self );
        wait 0.05;
    }
}

// Namespace deathperception_augments
// Params 0
// Checksum 0x19fc24e9, Offset: 0x419
// Size: 0x1c1
function function_8c24bd598676f9cf()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_39e453d8a791005f" );
    self.var_12c1ab119730f01b = 0;
    distance = level.zombie_augments[ #"deathperception_sixth_sense" ].var_c47c12ba2587488a ?? 128;
    
    while ( true )
    {
        zombies = getaiarrayinradius( self.origin, distance );
        forward = vectornormalize( anglestoforward( self.angles ) );
        var_5879aa434d715aeb = 1;
        
        foreach ( zombie in zombies )
        {
            if ( zombie.type == "zombie" && !zombie zombie_utils::function_bf1464d09f4e4b40() )
            {
                var_ee6433c31961982d = vectornormalize( ( zombie.origin[ 0 ], zombie.origin[ 1 ], 0 ) - ( self.origin[ 0 ], self.origin[ 1 ], 0 ) );
                dot = vectordot( forward, var_ee6433c31961982d );
                
                if ( dot > 0 )
                {
                    continue;
                }
                
                var_5879aa434d715aeb = 0;
                
                if ( !self.var_12c1ab119730f01b )
                {
                    self.var_12c1ab119730f01b = 1;
                    update_sixth_sense( 1 );
                }
            }
        }
        
        if ( var_5879aa434d715aeb )
        {
            self.var_12c1ab119730f01b = 0;
            update_sixth_sense( 0 );
        }
        
        waitframe();
    }
}

// Namespace deathperception_augments
// Params 1
// Checksum 0x28245d19, Offset: 0x5e2
// Size: 0x7f
function update_sixth_sense( on )
{
    if ( on )
    {
        if ( isplayer( self ) && self isconnected() )
        {
            sightmask = 16;
            self setclientomnvar( "ui_edge_glow", sightmask );
            self setscriptablepartstate( "sixthsense_audio", "on", 0 );
        }
        
        return;
    }
    
    if ( isplayer( self ) && self isconnected() )
    {
        self setclientomnvar( "ui_edge_glow", 0 );
        self setscriptablepartstate( "sixthsense_audio", "off", 0 );
    }
}

// Namespace deathperception_augments
// Params 1
// Checksum 0x2c6d7815, Offset: 0x669
// Size: 0x81, Type: bool
function function_f4153837d798924e( player )
{
    if ( isplayer( player ) )
    {
        currentweapon = player getcurrentweapon();
        
        if ( weapon::iswonderweapon( currentweapon ) )
        {
            return false;
        }
        
        var_21409cf2a41fe1fd = level.zombie_augments[ #"deathperception_critical_eye" ].var_9e1c6830f290e317 ?? 0.05;
        var_428ec8dad9e06370 = var_21409cf2a41fe1fd * 100;
        
        if ( utility::percent_chance( var_428ec8dad9e06370 ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace deathperception_augments
// Params 1
// Checksum 0x124ce1d3, Offset: 0x6f3
// Size: 0x9e
function function_2c28af8695bac142( type )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    offsetvec = vectornormalize( anglestoforward( self.angles ) ) * 50;
    trigger_radius = 42;
    
    if ( type == "magicbox" )
    {
        trigger_radius *= 2;
    }
    
    trigger = spawn( "noent_volume_trigger_rotatable_radius", self.origin + offsetvec, 0, trigger_radius, 64 );
    trigger.targetname = "ec_trigger";
    trigger.var_aba7994c4f6613b7 = self;
    trigger thread function_b88d45b12e454e00();
    return trigger;
}

// Namespace deathperception_augments
// Params 0
// Checksum 0x2d102e7d, Offset: 0x79a
// Size: 0x10f
function function_b88d45b12e454e00()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !isdefined( player.inlaststand ) )
        {
            player.inlaststand = 0;
        }
        
        var_b1f8a9de4c919924 = istrue( player utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_death_perception", #"deathperception_extra_change" ) );
        
        if ( isplayer( player ) && player getstance() == "prone" && !player.inlaststand && var_b1f8a9de4c919924 )
        {
            params = spawnstruct();
            params.scoreevent = #"loose_change";
            player callback::callback( "zombie_score_event", params );
            playsoundatpos( player.origin, "evt_zm_core_loose_change" );
            player playrumbleonentity( "damage_light" );
            break;
        }
        
        wait 0.1;
    }
    
    self delete();
}

// Namespace deathperception_augments
// Params 1, eflags: 0x4
// Checksum 0x9249d61, Offset: 0x8b1
// Size: 0x2e0
function private function_aea3f6d236ab3633( sparams )
{
    assert( isplayer( sparams.eattacker ) );
    damage = sparams.idamage ?? 0;
    
    if ( isalive( self ) && self.aicategory != "boss" )
    {
        player = sparams.eattacker;
        assert( player utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "<dev string:x24>", #"deathperception_death_stare" ) );
        hasdamageshield = val::get( "damageshield" ) || self.magicbulletshield;
        
        if ( !hasdamageshield && isdefined( self.health ) && isdefined( self.maxhealth ) )
        {
            var_f2effb6384f00fd1 = self.health / self.maxhealth;
            deathstarepercent = 0.1;
            
            if ( isdefined( self.aicategory ) )
            {
                if ( self.aicategory == "special" )
                {
                    deathstarepercent = level.zombie_augments[ #"deathperception_death_stare" ].var_4c77a2311f245c3 ?? 0.2;
                }
                
                if ( self.aicategory == "elite" )
                {
                    deathstarepercent = level.zombie_augments[ #"deathperception_death_stare" ].var_e08bb049f59fd707 ?? 0.1;
                }
            }
            
            element = zombie_damage::get_element( sparams.objweapon, player, sparams.smeansofdeath );
            
            if ( isdefined( self.elementalweakness[ element ] ) && var_f2effb6384f00fd1 <= deathstarepercent )
            {
                var_fa00d39e0513d20f = level.zombie_augments[ #"deathperception_death_stare" ].var_c4a6708e29833bac ?? 0.15;
                chance = 100 * var_fa00d39e0513d20f;
                timediff = 0;
                
                if ( isdefined( player.var_ae620cbde84fbfe7 ) )
                {
                    timediff = gettime() - player.var_ae620cbde84fbfe7;
                }
                
                if ( utility::percent_chance( chance ) && ( !isdefined( player.var_ae620cbde84fbfe7 ) || timediff >= 1000 ) )
                {
                    scoreparams = spawnstruct();
                    scoreparams.scoreevent = #"zombie_death_perception_kill";
                    player callback::callback( "zombie_score_event", scoreparams );
                    player.var_ae620cbde84fbfe7 = gettime();
                    player playsoundtoplayer( "evt_perk_aug_dp_deathstare_proc", player );
                    self dodamage( self.maxhealth, self.origin, player, player, sparams.smeansofdeath, sparams.objweapon );
                }
            }
        }
    }
    
    return damage;
}

// Namespace deathperception_augments
// Params 3
// Checksum 0x596d65a5, Offset: 0xb9a
// Size: 0xa7
function function_a212e61dd8953c31( droppos, dropangles, player )
{
    var_fd43da86bd0c6f58 = istrue( player utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_death_perception", #"deathperception_treasure_hunter" ) );
    
    if ( var_fd43da86bd0c6f58 )
    {
        dropchance = level.zombie_augments[ #"deathperception_treasure_hunter" ].var_309e8a2a57ca5c8a ?? 1;
        dropchance = 100 * dropchance;
        
        if ( utility::percent_chance( dropchance ) )
        {
            wait 0.25;
            function_4408b04eed659c22( droppos, dropangles, player );
        }
    }
}

// Namespace deathperception_augments
// Params 3
// Checksum 0x615ba9ab, Offset: 0xc49
// Size: 0x9a
function function_4408b04eed659c22( droppos, dropangles, player )
{
    if ( isplayer( player ) )
    {
        spawn_options = common_item::items_initspawnoptions_spawnfromposition( droppos, dropangles );
        spawn_options.var_c580c0e8b49f1fcc = 1;
        spawn_options.var_90cdc5dbcd319e5d = 1;
        spawn_options.var_4a4b419f66681601 = [];
        spawn_options.var_4a4b419f66681601[ spawn_options.var_4a4b419f66681601.size ] = player;
        item = level common_item::function_38cde6a6acb68ea6( "zm_t10_items_death_perception_treasure_hunter_drops", 1, spawn_options );
    }
}

// Namespace deathperception_augments
// Params 1
// Checksum 0x6e0688cd, Offset: 0xceb
// Size: 0x147
function on_ai_killed( sparams )
{
    playerdamagelist = self.a_n_player_damage;
    
    foreach ( player in playerdamagelist )
    {
        if ( self.aicategory == "elite" || self.aicategory == "special" )
        {
            var_fd43da86bd0c6f58 = istrue( player utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_death_perception", #"deathperception_treasure_hunter" ) );
            
            if ( var_fd43da86bd0c6f58 )
            {
                dropchance = level.zombie_augments[ #"deathperception_treasure_hunter" ].var_e131ee62149069bc ?? 0.5;
                dropchance = 100 * dropchance;
                
                if ( utility::percent_chance( dropchance ) )
                {
                    wait 0.25;
                    function_4408b04eed659c22( self.origin, self.angles, player );
                }
            }
        }
    }
}

