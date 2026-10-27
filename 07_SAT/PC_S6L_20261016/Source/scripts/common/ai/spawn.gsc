// scripts\common\ai\spawn.gsc  (hash_78ee1f1787a2e6a4.gscc) (size: 5408 Bytes / 0x1520 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5774a651 (1467262545)
// size ...... 5408 (0x1520)
// includes .. 3   (offset: 0x1438)
// strings ... 9   (offset: 0x1450)
// dev strs .. 6   (offset: 0x14d8)
// exports ... 6   (offset: 0xf58)
// cseg ...... 0xa7 + 0xeb1 (0xf58)
// imports ... 34  (offset: 0x1048)
// animtree1 . 0   (offset: 0x1520)
// animtree2 . 0   (offset: 0x1520)
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\utility;

#namespace ai;

// Namespace ai
// Params 2
// Checksum 0xd139dae0, Offset: 0xc5
// Size: 0xbfd
function spawner_fields( spawner, skipcleanup )
{
    if ( !skipcleanup )
    {
        spawner spawner_fields_cleanup();
    }
    
    if ( spawner.script_dontshootwhilemoving )
    {
        self.dontshootwhilemoving = 1;
        self.script_dontshootwhilemoving = undefined;
    }
    
    if ( spawner.script_deathflag )
    {
        self.script_deathflag = spawner.script_deathflag;
        thread ai_deathflag();
    }
    
    if ( isdefined( spawner.script_attackeraccuracy ) )
    {
        self.attackeraccuracy = spawner.script_attackeraccuracy;
        self.script_attackeraccuracy = undefined;
    }
    
    if ( spawner.script_startrunning )
    {
        thread spawn_running();
        self.script_startrunning = undefined;
    }
    
    if ( spawner.script_nosurprise )
    {
        disable_surprise();
        self.script_nosurprise = undefined;
    }
    
    if ( spawner.script_nobloodpool )
    {
        self.skipbloodpool = 1;
        self.script_nobloodpool = undefined;
    }
    
    if ( isdefined( spawner.script_animname ) )
    {
        self.animname = spawner.script_animname;
        self.script_animname = undefined;
    }
    
    if ( spawner.script_laser )
    {
        thread laser_on_thread();
    }
    
    if ( isdefined( spawner.script_danger_react ) )
    {
        self.script_danger_react = spawner.script_danger_react;
        time = self.script_danger_react;
        
        if ( time == 1 )
        {
            time = 8;
        }
        
        enable_danger_react( time );
    }
    
    if ( isdefined( spawner.script_faceenemydist ) )
    {
        self.maxfaceenemydist = spawner.script_faceenemydist;
    }
    
    if ( isdefined( spawner.script_forcecolor ) )
    {
        self.script_forcecolor = spawner.script_forcecolor;
        utility::callsharedfunc( #"colors", #"set_force_color", self.script_forcecolor );
    }
    
    if ( spawner.dontdropweapon )
    {
        self.shoulddropweapon = 0;
    }
    
    if ( isdefined( spawner.script_team ) )
    {
        self.script_team = spawner.script_team;
        self.team = self.script_team;
    }
    
    if ( spawner.script_fixednode )
    {
        self.fixednode = spawner.script_fixednode == 1;
        self.script_fixednode = undefined;
    }
    else if ( utility::issp() )
    {
        self.fixednode = self.team == "allies";
    }
    
    self.providecoveringfire = self.team == "allies" && self.fixednode;
    
    if ( spawner.script_no_reorient == 1 )
    {
        self.no_reorient = 1;
        self.script_no_reorient = undefined;
    }
    
    if ( isdefined( spawner.script_goalvolume ) && !( spawner.script_moveoverride == 1 || isdefined( self.script_stealthgroup ) ) )
    {
        self.script_goalvolume = spawner.script_goalvolume;
        thread set_goal_volume_delayed();
    }
    
    if ( isdefined( spawner.script_threatbiasgroup ) )
    {
        self.script_threatbiasgroup = spawner.script_threatbiasgroup;
        createthreatbiasgroup( self.script_threatbiasgroup );
        self setthreatbiasgroup( self.script_threatbiasgroup );
    }
    else if ( self.team == "neutral" )
    {
        if ( !threatbiasgroupexists( "civilian" ) )
        {
            createthreatbiasgroup( "civilian" );
        }
        
        self setthreatbiasgroup( "civilian" );
    }
    else
    {
        if ( !threatbiasgroupexists( self.team ) )
        {
            createthreatbiasgroup( self.team );
        }
        
        self setthreatbiasgroup( self.team );
    }
    
    if ( isdefined( spawner.script_bcdialog ) )
    {
        self.script_bcdialog = spawner.script_bcdialog;
        utility::set_battlechatter( self.script_bcdialog );
    }
    
    if ( isdefined( spawner.script_accuracy ) )
    {
        self.baseaccuracy = spawner.script_accuracy;
        self.script_accuracy = undefined;
    }
    
    if ( spawner.script_ignoreme )
    {
        assert( spawner.script_ignoreme == 1, "<dev string:x24>" );
        set_ignoreme( 1 );
        self.script_ignoreme = undefined;
    }
    
    if ( spawner.script_ignore_suppression )
    {
        assert( spawner.script_ignore_suppression == 1, "<dev string:xa6>" );
        self.ignoresuppression = 1;
        self.script_ignore_suppression = undefined;
    }
    
    if ( spawner.script_ignoreall )
    {
        assert( spawner.script_ignoreall == 1, "<dev string:x132>" );
        set_ignoreall( 1 );
        self clearenemy();
    }
    
    if ( isdefined( spawner.script_offhands ) )
    {
        set_grenadeweapon( spawner.script_offhands );
        self.script_offhands = undefined;
    }
    
    if ( isdefined( spawner.script_favoriteenemy ) )
    {
        if ( spawner.script_favoriteenemy == "player" )
        {
            self.favoriteenemy = function_3b2d106722d4a52e();
        }
    }
    
    if ( isdefined( spawner.script_sightrange ) )
    {
        self.maxsightdistsqrd = squared( spawner.script_sightrange );
        self.script_sightrange = undefined;
    }
    
    if ( isdefined( spawner.script_fightdist ) )
    {
        self.pathenemyfightdist = spawner.script_fightdist;
        self.script_fightdist = undefined;
    }
    
    if ( isdefined( spawner.script_maxdist ) )
    {
        self.pathenemylookahead = spawner.script_maxdist;
        self.script_maxdist = undefined;
    }
    
    if ( isdefined( spawner.script_longdeath ) )
    {
        self.script_longdeath = spawner.script_longdeath;
        
        if ( self.script_longdeath == 0 )
        {
            disable_long_death();
        }
        else if ( self.script_longdeath == 1 )
        {
            enable_long_death();
        }
        else
        {
            enable_long_death();
            self.forcelongdeath = self.script_longdeath;
        }
    }
    
    if ( spawner.script_forcebalconydeath )
    {
        self.forcebalconydeath = 1;
        self.script_forcebalconydeath = undefined;
    }
    
    if ( spawner.script_diequietly )
    {
        assert( spawner.script_diequietly, "<dev string:x1b5>" + self.export );
        self.diequietly = 1;
        self.script_diequietly = undefined;
    }
    
    if ( spawner.script_noragdoll )
    {
        assert( spawner.script_noragdoll, "<dev string:x219>" + self.export );
        self.noragdoll = 1;
        self.script_noragdoll = undefined;
    }
    
    if ( spawner.script_pacifist )
    {
        self.pacifist = 1;
        self.script_pacifist = undefined;
    }
    
    if ( spawner.script_bulletshield )
    {
        assert( spawner.script_bulletshield, "<dev string:x278>" + self.export );
        magic_bullet_shield();
        self.script_bulletshield = undefined;
    }
    
    if ( spawner.script_startinghealth > 0 )
    {
        self.health = spawner.script_startinghealth;
        self.script_startinghealth = undefined;
    }
    
    if ( spawner.script_nodrop )
    {
        self.nodrop = spawner.script_nodrop;
        self.script_nodrop = undefined;
    }
    
    if ( spawner.script_noloot )
    {
        self.noloot = spawner.script_noloot;
        self.script_noloot = undefined;
    }
    
    if ( spawner.script_armored )
    {
        self.armored = spawner.script_armored;
        self.script_armored = undefined;
    }
    
    if ( isdefined( spawner.script_demeanor ) )
    {
        utility::demeanor_override( spawner.script_demeanor );
        self.script_demeanor = undefined;
    }
    
    if ( isdefined( spawner.script_civilian_state ) )
    {
        asm_bb::bb_setcivilianstate( spawner.script_civilian_state );
        self.script_civilian_state = undefined;
    }
    
    if ( isdefined( spawner.script_civilian_control ) )
    {
        self function_2bb28ccf461c72ce( spawner.script_civilian_control, 0 );
        self.script_civilian_control = undefined;
    }
    
    if ( isdefined( spawner.script_speed ) )
    {
        utility::set_movement_speed( spawner.script_speed );
        self.script_speed = undefined;
    }
    
    if ( spawner.script_noflashlight )
    {
        self.noflashlight = spawner.script_noflashlight;
        self.script_noflashlight = undefined;
    }
    
    if ( isdefined( spawner.script_combatmode ) )
    {
        self.combatmode = spawner.script_combatmode;
    }
    
    if ( isdefined( spawner.script_combatbehavior ) )
    {
        self.script_combatbehavior = spawner.script_combatbehavior;
        
        if ( self.script_combatbehavior == "cqb" )
        {
            utility::enable_cqbwalk();
        }
    }
    
    if ( spawner.var_84c8de937675eafa )
    {
        self.var_4d3dee2aa67fa6a0 = spawner.var_84c8de937675eafa;
        self.var_84c8de937675eafa = undefined;
    }
    
    if ( spawner.script_canberevived )
    {
        self.var_38a06ee92c60ee9e = spawner.script_canberevived;
        self.script_canberevived = undefined;
    }
    
    self.spawnpoint = spawner;
    
    if ( !isai( spawner ) )
    {
        self.script_stealth_region_group = spawner.script_stealth_region_group;
        self.script_dialogue = spawner.script_dialogue;
        self.script_noteworthy = spawner.script_noteworthy;
        self.script_parameters = spawner.script_parameters;
        self.script_squadname = spawner.script_squadname;
        self.script_stealthgroup = spawner.script_stealthgroup;
        self.script_linkto = spawner.script_linkto;
        self.script_linkname = spawner.script_linkname;
        self.script_demeanor_post = spawner.script_demeanor_post;
        self.script_goalheight = spawner.script_goalheight;
        self.script_radius = spawner.script_radius;
        self.script_goalradius = spawner.script_goalradius;
        self.dontkilloff = spawner.dontkilloff;
        self.script_patroller = spawner.script_patroller;
        self.equip_helmet = spawner.equip_helmet;
        self.is_on_platform = spawner.is_on_platform;
        self.door_spawner = spawner.door_spawner;
        self.dont_enter_combat = spawner.dont_enter_combat;
        self.script_origin_other = spawner.script_origin_other;
        self.script_forcegoal = spawner.script_forcegoal;
        self.target = spawner.target;
    }
    
    self.aitype = spawner.aitype;
    
    if ( isdefined( spawner.script_noflashlight ) )
    {
        if ( isstring( spawner.script_noflashlight ) && spawner.script_noflashlight != "" )
        {
            self.noflashlight = int( spawner.script_noflashlight );
        }
        else if ( isint( spawner.script_noflashlight ) )
        {
            self.noflashlight = spawner.script_noflashlight;
        }
    }
    
    if ( isdefined( spawner.script_enemyselector ) )
    {
        self.enemyselector = spawner.script_enemyselector;
        self.script_enemyselector = undefined;
    }
}

// Namespace ai
// Params 0, eflags: 0x4
// Checksum 0x761d18dc, Offset: 0xcca
// Size: 0x1ff
function private spawner_fields_cleanup()
{
    if ( utility::issp() )
    {
        return;
    }
    
    if ( self.target == "default" )
    {
        self.target = undefined;
    }
    
    if ( self.script_noteworthy == "default" )
    {
        self.script_noteworthy = undefined;
    }
    
    if ( self.script_forcespawn == 0 )
    {
        self.script_forcespawn = undefined;
    }
    
    if ( self.script_team == "axis" )
    {
        self.script_team = undefined;
    }
    
    if ( self.script_radius == 0 )
    {
        self.script_radius = undefined;
    }
    
    if ( self.script_goalheight == 0 )
    {
        self.script_goalheight = undefined;
    }
    
    if ( self.script_origin_other == ( 0, 0, 0 ) )
    {
        self.script_origin_other = undefined;
    }
    
    if ( self.script_count == 0 )
    {
        self.script_count = undefined;
    }
    
    if ( self.script_timeout == 0 )
    {
        self.script_timeout = undefined;
    }
    
    if ( self.script_dot == 0 )
    {
        self.script_dot = undefined;
    }
    
    if ( self.script_dist_only == 0 )
    {
        self.script_dist_only = undefined;
    }
    
    if ( self.script_demeanor == "default" )
    {
        self.script_demeanor = undefined;
    }
    
    if ( self.script_speed == 0 )
    {
        self.script_speed = undefined;
    }
    
    if ( self.script_linkto == "default" )
    {
        self.script_linkto = undefined;
    }
    
    if ( self.script_linkname == "default" )
    {
        self.script_linkname = undefined;
    }
    
    if ( isdefined( self.script_unload ) )
    {
        if ( isstring( self.script_unload ) && self.script_unload == "-1" )
        {
            self.script_unload = undefined;
            return;
        }
        
        if ( isint( self.script_unload ) && self.script_unload == -1 )
        {
            self.script_unload = undefined;
        }
    }
}

// Namespace ai
// Params 0
// Checksum 0x41d5ec04, Offset: 0xed1
// Size: 0x26
function spawn_running()
{
    self endon( #"death" );
    self.disableexits = 1;
    wait 3;
    self.disableexits = 0;
}

// Namespace ai
// Params 0
// Checksum 0x86c30d8f, Offset: 0xeff
// Size: 0x11
function set_goal_volume_delayed()
{
    waittillframeend();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    thread set_goal_volume();
}

// Namespace ai
// Params 0, eflags: 0x4
// Checksum 0xe0877b9b, Offset: 0xf18
// Size: 0x3f
function private function_3b2d106722d4a52e()
{
    if ( !isdefined( level.players ) )
    {
        return level.player;
    }
    
    sorted = sortbydistance( level.players, self.origin );
    return sorted[ 0 ];
}

