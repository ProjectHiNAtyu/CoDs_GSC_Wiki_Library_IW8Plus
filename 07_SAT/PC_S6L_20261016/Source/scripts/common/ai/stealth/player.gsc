// scripts\common\ai\stealth\player.gsc  (hash_4cd4ef577b89a116.gscc) (size: 7261 Bytes / 0x1c5d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xae1eb1d9 (2921247193)
// size ...... 7261 (0x1c5d)
// includes .. 3   (offset: 0x1a2d)
// strings ... 31  (offset: 0x1a45)
// dev strs .. 4   (offset: 0x1c25)
// exports ... 15  (offset: 0x1245)
// cseg ...... 0x23e + 0x1007 (0x1245)
// imports ... 46  (offset: 0x149d)
// animtree1 . 0   (offset: 0x1c5d)
// animtree2 . 0   (offset: 0x1c5d)
#using scripts\common\ai\stealth\manager;
#using scripts\common\ai\stealth\utility;
#using scripts\common\utility;

#namespace player;

// Namespace player
// Params 0
// Checksum 0x675c78bc, Offset: 0x25c
// Size: 0xe5
function main()
{
    if ( isdefined( self.stealth ) )
    {
        return;
    }
    
    self endon( #"death" );
    self endon( #"stealth_disabled" );
    self.stealth = spawnstruct();
    utility::group_flag_init( "stealth_spotted" );
    utility::ent_flag_init( "stealth_enabled" );
    setplayervisibilityflag( "stealth_enabled" );
    utility::ent_flag_init( "stealth_in_shadow" );
    utility::ent_flag_init( "stealth_use_real_lighting" );
    utility::ent_flag_init( "stealth_use_player_camera_movement" );
    utility::group_add();
    
    if ( utility::issp() )
    {
        thread stealthhints_thread();
        
        if ( isdefined( level.stealth.fnsixthsense ) )
        {
            [[ level.stealth.fnsixthsense ]]();
        }
        
        return;
    }
    
    thread stealth_manager::player_grenade_check();
    
    if ( isdefined( level.var_24752081377d1fb5 ) )
    {
        self thread [[ level.var_24752081377d1fb5 ]]();
    }
}

// Namespace player
// Params 1
// Checksum 0x744b55ed, Offset: 0x349
// Size: 0x1f
function setplayervisibilityflag( message )
{
    stealthsetplayervisibilityflag( self, message, 1 );
    utility::ent_flag_set( message );
}

// Namespace player
// Params 1
// Checksum 0x5c5cbd42, Offset: 0x370
// Size: 0x1e
function function_dc59df84a8dcb0e0( message )
{
    stealthsetplayervisibilityflag( self, message, 0 );
    utility::ent_flag_clear( message );
}

// Namespace player
// Params 1
// Checksum 0xef255477, Offset: 0x396
// Size: 0x4ff
function combatstate_thread( enabled = 1 )
{
    if ( !enabled )
    {
        self notify( #"stop_player_combat_state_thread" );
        self.stealth.combatstate = undefined;
        return;
    }
    else if ( isdefined( self.stealth.combatstate ) )
    {
        return;
    }
    
    self endon( #"death" );
    self endon( #"stealth_disabled" );
    self endon( #"stop_player_combat_state_thread" );
    self endon( #"disconnect" );
    childthread playerattackedmonitor();
    childthread combatstate_updatethread();
    self.stealth.combatstate = spawnstruct();
    self.stealth.combatstate.name = "stealth";
    self.stealth.combatstate.type = "idle";
    self.stealth.combatstate.updatefuncs = [];
    oldcombatenemies = [];
    oldhuntenemies = [];
    
    while ( true )
    {
        utility::ent_flag_wait( "stealth_enabled" );
        oldcombatenemies = function_5713d46873b29625( oldcombatenemies );
        oldcombatenemies = function_46f9072493651dc9( oldcombatenemies );
        oldhuntenemies = function_5713d46873b29625( oldhuntenemies );
        oldhuntenemies = function_46f9072493651dc9( oldhuntenemies );
        combatenemies = [];
        huntenemies = [];
        var_3d1005faa0dbf338 = 0;
        
        if ( isdefined( self.lastattackedtime ) && !utility::time_has_passed( self.lastattackedtime, 10 ) )
        {
            var_3d1005faa0dbf338 = 1;
        }
        
        investigating = 0;
        
        foreach ( enemy in getaiarray( "axis" ) )
        {
            if ( !isalive( enemy ) )
            {
                continue;
            }
            
            if ( !arraycontains( oldcombatenemies, enemy ) )
            {
                if ( enemy utility::doinglongdeath() )
                {
                    continue;
                }
                
                if ( enemy.script == "pain" )
                {
                    continue;
                }
            }
            
            if ( enemy [[ enemy.fnisinstealthcombat ]]() )
            {
                if ( isdefined( self.stealth.combatstate.maxcombatdist ) )
                {
                    dist = self.stealth.combatstate.maxcombatdist;
                    
                    if ( distancesquared( self.origin, enemy.origin ) > squared( dist ) )
                    {
                        huntenemies[ huntenemies.size ] = enemy;
                        continue;
                    }
                }
                
                combatenemies[ combatenemies.size ] = enemy;
                
                if ( var_3d1005faa0dbf338 )
                {
                    continue;
                }
                
                if ( enemy.enemy != self )
                {
                    continue;
                }
                
                if ( enemy cansee( self ) )
                {
                    var_3d1005faa0dbf338 = 1;
                }
            }
            else if ( enemy [[ enemy.fnisinstealthhunt ]]() )
            {
                huntenemies[ huntenemies.size ] = enemy;
            }
            
            if ( enemy [[ enemy.fnisinstealthinvestigate ]]() )
            {
                investigating = 1;
            }
        }
        
        lastname = self.stealth.combatstate.name;
        lasttype = self.stealth.combatstate.type;
        name = lastname;
        type = undefined;
        
        if ( name == "stealth" && investigating )
        {
            type = "investigate";
        }
        
        if ( lastname == "combat" )
        {
            if ( combatenemies.size == 0 )
            {
                name = "stealth";
                
                if ( arrayintersection( oldcombatenemies, huntenemies ).size > 0 )
                {
                    type = "hunt";
                }
                else if ( huntenemies.size == 0 )
                {
                    type = "all_clear";
                }
                else
                {
                    type = "combat_clear";
                }
            }
            else if ( lasttype == "unaware" && var_3d1005faa0dbf338 )
            {
                type = "aware";
            }
        }
        else if ( combatenemies.size > 0 )
        {
            name = "combat";
            
            if ( var_3d1005faa0dbf338 )
            {
                type = "aware";
            }
            else
            {
                type = "unaware";
            }
        }
        else if ( lasttype == "hunt" && huntenemies.size == 0 )
        {
            type = "all_clear";
        }
        
        if ( name == "stealth" && !isdefined( type ) && lasttype == "investigate" )
        {
            type = "idle";
        }
        
        if ( name != lastname || isdefined( type ) && type != lasttype )
        {
            self.stealth.combatstate.name = name;
            self.stealth.combatstate.type = type;
            self notify( #"player_combat_state_updated", name, type );
        }
        
        oldcombatenemies = combatenemies;
        oldhuntenemies = huntenemies;
        waitframe();
    }
}

// Namespace player
// Params 0
// Checksum 0x801b2385, Offset: 0x89d
// Size: 0xb8
function combatstate_updatethread()
{
    while ( true )
    {
        self waittill( #"player_combat_state_updated", name, type );
        
        foreach ( func in self.stealth.combatstate.updatefuncs )
        {
            self thread [[ func ]]( name, type );
        }
    }
}

// Namespace player
// Params 2
// Checksum 0xe4fe28a5, Offset: 0x95d
// Size: 0xba
function combatstate_addupdatefunc( key, func )
{
    assert( isplayer( self ) );
    assert( isdefined( self.stealth ) );
    assert( isdefined( self.stealth.combatstate ) );
    assert( isdefined( key ), "<dev string:x24>" );
    assert( !isdefined( self.stealth.combatstate.updatefuncs[ key ] ), "<dev string:x4e>" + key + "<dev string:x6f>" );
    self.stealth.combatstate.updatefuncs[ key ] = func;
}

// Namespace player
// Params 1
// Checksum 0x78da9b45, Offset: 0xa1f
// Size: 0xae
function combatstate_removeupdatefunc( key )
{
    assert( isplayer( self ) );
    assert( isdefined( self.stealth ) );
    assert( isdefined( self.stealth.combatstate ) );
    assert( isdefined( key ), "<dev string:x24>" );
    assert( isdefined( self.stealth.combatstate.updatefuncs[ key ] ), "<dev string:x4e>" + key + "<dev string:x80>" );
    self.stealth.combatstate.updatefuncs[ key ] = undefined;
}

// Namespace player
// Params 0
// Checksum 0xc9a6ce41, Offset: 0xad5
// Size: 0x29
function playerattackedmonitor()
{
    while ( true )
    {
        level utility::waittill_any( "an_enemy_shot", "enemy_grenade_fire" );
        self.lastattackedtime = gettime();
    }
}

// Namespace player
// Params 1
// Checksum 0x7d3b03dd, Offset: 0xb06
// Size: 0x28
function function_27dd5d2c74369543( var_986744a992e6147f )
{
    if ( isdefined( level.var_b653857f5e010681 ) )
    {
        return level.var_b653857f5e010681[ var_986744a992e6147f ];
    }
    
    return -1;
}

// Namespace player
// Params 0
// Checksum 0x7fdb25a, Offset: 0xb37
// Size: 0x1a9
function stealthhints_thread()
{
    self endon( #"stealth_disabled" );
    self.stealth.hints = spawnstruct();
    self.stealth.hints.causeofdeath = undefined;
    self.stealth.hints.investigators = [];
    self.stealth.hints.deathhints[ "footstep_sprint" ] = function_27dd5d2c74369543( %"hash_4440006f6dd71854" );
    self.stealth.hints.deathhints[ "gunshot_suppressed" ] = function_27dd5d2c74369543( %"hash_6edba37d6ef71d47" );
    self.stealth.hints.deathhints[ "proximity_speed" ] = function_27dd5d2c74369543( %"hash_60c0af92f2c2f9cb" );
    self.stealth.hints.deathhints[ "sight_standing" ] = function_27dd5d2c74369543( %"hash_4e3b484fc8be701a" );
    self.stealth.hints.deathhints[ "gunshot" ] = function_27dd5d2c74369543( %"hash_1747bc9a7c8035f6" );
    self.stealth.hints.deathhints[ "footstep_walk" ] = function_27dd5d2c74369543( %"hash_2407b15141d19bb0" );
    childthread stealthhints_eventmonitor();
    childthread stealthhints_deathmonitor();
    childthread stealthhints_combatmonitor();
}

// Namespace player
// Params 0
// Checksum 0xfb6d5f4c, Offset: 0xce8
// Size: 0x293
function stealthhints_eventmonitor()
{
    self endon( #"death" );
    
    while ( isalive( self ) )
    {
        utility::ent_flag_wait( "stealth_enabled" );
        level waittill( #"stealth_event", event, receiver );
        
        if ( !isalive( receiver ) )
        {
            continue;
        }
        
        if ( event.entity != level.player )
        {
            continue;
        }
        
        if ( !utility::ent_flag( "stealth_enabled" ) )
        {
            self.stealth.hints.causeofdeath = undefined;
            self.stealth.hints.investigators = [];
            continue;
        }
        
        if ( utility::any_groups_in_combat() )
        {
            if ( event.type != "combat" )
            {
                continue;
            }
            
            combat_in_progress = 0;
            
            foreach ( guy in getaiarray( receiver.team ) )
            {
                if ( guy == receiver )
                {
                    continue;
                }
                
                if ( guy [[ guy.fnisinstealthcombat ]]() )
                {
                    combat_in_progress = 1;
                    break;
                }
            }
            
            if ( combat_in_progress )
            {
                continue;
            }
        }
        
        eventtype = event.typeorig;
        
        if ( eventtype == "gunshot" && level.hassuppressedweapons )
        {
            eventtype = "gunshot_suppressed";
        }
        else if ( ( eventtype == "sight" || eventtype == "proximity" ) && self issprinting() )
        {
            eventtype = "footstep_sprint";
        }
        else if ( eventtype == "proximity" && length2dsquared( level.player getvelocity() ) > 11025 )
        {
            eventtype = "proximity_speed";
        }
        else if ( eventtype == "sight" && self getstance() == "stand" )
        {
            eventtype = "sight_standing";
        }
        
        if ( !isdefined( self.stealth.hints.deathhints[ eventtype ] ) )
        {
            continue;
        }
        
        if ( arraycontains( self.stealth.hints.investigators, receiver ) )
        {
            continue;
        }
        
        childthread stealthhints_aimonitor( receiver, eventtype );
    }
}

// Namespace player
// Params 2
// Checksum 0x14b24f5, Offset: 0xf83
// Size: 0x183
function stealthhints_aimonitor( ai, eventtype )
{
    self endon( #"combat_started" );
    self endon( #"stealth_enabled" );
    self.stealth.hints.investigators[ self.stealth.hints.investigators.size ] = ai;
    
    if ( ai [[ ai.fnisinstealthhunt ]]() )
    {
        ai utility::delaythread( 10, &utility::send_notify, "stealthHints_timeout" );
        ai utility::waittill_any( "stealth_combat", "death", "stealthHints_timeout" );
    }
    else if ( ai [[ ai.fnisinstealthinvestigate ]]() )
    {
        ai utility::waittill_any( "stealth_idle", "stealth_combat", "death" );
    }
    
    self.stealth.hints.investigators = arrayremove( self.stealth.hints.investigators, ai );
    
    if ( !isalive( ai ) || !ai [[ ai.fnisinstealthcombat ]]() )
    {
        return;
    }
    
    self.stealth.hints.causeofdeath = eventtype;
    self.stealth.hints.investigators = [];
    self notify( #"combat_started" );
}

// Namespace player
// Params 0
// Checksum 0xd1cc77a8, Offset: 0x110e
// Size: 0xa1
function stealthhints_deathmonitor()
{
    self waittill( #"death" );
    
    if ( !utility::ent_flag( "stealth_enabled" ) )
    {
        return;
    }
    
    if ( isdefined( level.custom_death_quote ) )
    {
        return;
    }
    
    if ( !isdefined( self.stealth.hints.causeofdeath ) )
    {
        return;
    }
    
    if ( level.var_81b1b261c9146d1 )
    {
        return;
    }
    
    level.custom_death_quote = self.stealth.hints.deathhints[ self.stealth.hints.causeofdeath ];
}

// Namespace player
// Params 0
// Checksum 0x269746a, Offset: 0x11b7
// Size: 0x8e
function stealthhints_combatmonitor()
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( level.laststandentered )
        {
            self waittill( #"last_stand_exit" );
        }
        else
        {
            utility::ent_flag_wait( "stealth_enabled" );
        }
        
        while ( !isdefined( self.stealth.hints.causeofdeath ) )
        {
            waitframe();
        }
        
        while ( utility::any_groups_in_combat() )
        {
            waitframe();
        }
        
        self.stealth.hints.causeofdeath = undefined;
    }
}

