// script_7381472113d2aa0b  (hash_7381472113d2aa0b.gscc) (size: 7022 Bytes / 0x1b6e)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa1b556a8 (2713015976)
// size ...... 7022 (0x1b6e)
// includes .. 2   (offset: 0x19be)
// strings ... 28  (offset: 0x19ce)
// dev strs .. 1   (offset: 0x1b62)
// exports ... 24  (offset: 0x118e)
// cseg ...... 0x2b4 + 0xeda (0x118e)
// imports ... 37  (offset: 0x154e)
// animtree1 . 0   (offset: 0x1b6e)
// animtree2 . 0   (offset: 0x1b6e)
#using script_685ed28b9335d913;
#using script_764691b6e910fd4;

#namespace analytics;

// Namespace analytics
// Params 0
// Checksum 0x26103834, Offset: 0x2d2
// Size: 0x89
function init()
{
    if ( false )
    {
        return;
    }
    
    var_915884b697f87ded = analyticsisenabled();
    
    if ( !var_915884b697f87ded )
    {
        return;
    }
    
    var_f967a08b24aac8fb = getdvarint( @"hash_1db220c08cce912b", 1 );
    
    if ( !var_f967a08b24aac8fb )
    {
        return;
    }
    
    level.var_f72e312e8d48a549 = 1;
    assert( level.var_f72e312e8d48a549, "<dev string:x24>" );
    level.delayedeventtypes = [];
    
    if ( true )
    {
        analyticsreset();
    }
    
    analytics_player::init();
    analytics_ai::init();
    level thread onendgame();
}

// Namespace analytics
// Params 2
// Checksum 0xc111375c, Offset: 0x363
// Size: 0x3e
function function_9c8e2881a39732fb( info, var_5c371065f365077d )
{
    if ( isdedicatedserver() )
    {
        setdvar( @"hash_bd87b6ef2da571db", info );
    }
    
    if ( var_5c371065f365077d )
    {
        logstring( "[KEY_MOMENT] " + info );
    }
}

// Namespace analytics
// Params 0
// Checksum 0x175a3046, Offset: 0x3a9
// Size: 0x14
function geteventtimestamp()
{
    time = gettime();
    return time;
}

// Namespace analytics
// Params 6
// Checksum 0xa2758c37, Offset: 0x3c6
// Size: 0xc0
function function_d31c748cc33a7667( type, origin, state, time, data, entnum )
{
    if ( !level.var_f72e312e8d48a549 )
    {
        return;
    }
    
    if ( !isstring( data ) )
    {
        data = "";
    }
    
    if ( true )
    {
        analyticsaddevent( origin, type, state, time, data, entnum );
    }
    
    if ( 0 && type != "breadcrumb" )
    {
        logstring( "[GAE]," + time + "," + entnum + "," + origin[ 0 ] + "," + origin[ 1 ] + "," + type + "," + state + "," + data );
    }
}

// Namespace analytics
// Params 5
// Checksum 0x610bc1fa, Offset: 0x48e
// Size: 0xb1
function addevent( type, origin, state, data, ent )
{
    if ( !level.var_f72e312e8d48a549 )
    {
        return;
    }
    
    if ( !isdefined( origin ) )
    {
        origin = ( 0, 0, 0 );
    }
    
    if ( !isdefined( state ) )
    {
        state = 0;
    }
    
    if ( !isdefined( data ) )
    {
        data = "";
    }
    
    entnum = -1;
    
    if ( isdefined( ent ) )
    {
        entnum = ent getentitynumber();
    }
    
    time = geteventtimestamp();
    function_d31c748cc33a7667( type, origin, state, time, data, entnum );
    
    if ( isdefined( ent ) )
    {
        ent updatebreadcrumb( time );
    }
}

// Namespace analytics
// Params 2
// Checksum 0xd870c940, Offset: 0x547
// Size: 0x39
function function_4bbfa25d7918b8d8( type, ent )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    addevent( type, ent.origin, 0, "", ent );
}

// Namespace analytics
// Params 4
// Checksum 0x34964b9f, Offset: 0x588
// Size: 0x47
function function_8a366d2fb782aedb( type, ent, state, data )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    addevent( type, ent.origin, state, data, ent );
}

// Namespace analytics
// Params 4
// Checksum 0x7885acdd, Offset: 0x5d7
// Size: 0x11f
function addeventdelayed( type, origin, ent, data )
{
    if ( !level.var_f72e312e8d48a549 )
    {
        return;
    }
    
    assert( isdefined( level.delayedeventtypes ) );
    assert( isdefined( type ) );
    assert( isdefined( origin ) );
    assert( isdefined( ent ) );
    
    if ( !isdefined( data ) )
    {
        data = "";
    }
    
    if ( !isdefined( level.delayedeventtypes[ type ] ) )
    {
        level.delayedeventtypes[ type ] = [];
    }
    
    evt = spawnstruct();
    evt.type = type;
    evt.origin = origin;
    evt.ent = ent;
    evt.data = data;
    evt.state = 0;
    evt.time = geteventtimestamp();
    evtindex = level.delayedeventtypes[ type ].size;
    level.delayedeventtypes[ type ][ evtindex ] = evt;
}

// Namespace analytics
// Params 3
// Checksum 0xc9de34b8, Offset: 0x6fe
// Size: 0xef
function seteventdelayedstate( type, ent, state )
{
    if ( !level.var_f72e312e8d48a549 )
    {
        return;
    }
    
    if ( !( isdefined( type ) && isdefined( ent ) && isdefined( level.delayedeventtypes[ type ] ) ) )
    {
        return;
    }
    
    foreach ( evt in level.delayedeventtypes[ type ] )
    {
        if ( evt.ent == ent )
        {
            evt.time = geteventtimestamp();
            evt.state = state;
            return;
        }
    }
}

// Namespace analytics
// Params 0
// Checksum 0xd6396470, Offset: 0x7f5
// Size: 0x130
function onendgame()
{
    level waittill( #"start_game_ended" );
    
    foreach ( typearray in level.delayedeventtypes )
    {
        foreach ( ev in typearray )
        {
            function_d31c748cc33a7667( ev.type, ev.origin, ev.state, ev.time, ev.data, -1 );
        }
    }
    
    if ( true )
    {
        analyticswritecsv();
    }
}

// Namespace analytics
// Params 0
// Checksum 0x9ec92383, Offset: 0x92d
// Size: 0x19, Type: bool
function function_18b384fcbf135f0e()
{
    if ( isplayer( self ) )
    {
        return true;
    }
    
    if ( isagent( self ) )
    {
        return true;
    }
    
    return false;
}

// Namespace analytics
// Params 0
// Checksum 0x14b6458c, Offset: 0x94f
// Size: 0x1bc
function function_310556bfd82dfd6a()
{
    if ( !level.var_f72e312e8d48a549 )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isagent( self ) )
    {
        self endon( #"death" );
    }
    
    entnum = self getentitynumber();
    state = 0;
    data = "";
    nextstate = 0;
    nextdata = "";
    
    while ( true )
    {
        wait level.gametypebundle.var_46f94aac2d4f85db ?? 30;
        
        if ( !isalive( self ) )
        {
            continue;
        }
        
        if ( isagent( self ) )
        {
            if ( isdefined( self.enemy ) )
            {
                nextstate = self.enemy getentitynumber();
            }
            else
            {
                nextstate = 0;
            }
            
            if ( isdefined( self.behaviorpackage ) )
            {
                nextdata = self.behaviorpackage.behavior;
            }
            else if ( isdefined( self.agent_type ) )
            {
                nextdata = self.agent_type;
            }
            else
            {
                nextdata = "";
            }
            
            if ( isdefined( self.spawn_source ) )
            {
                nextdata += " - Spawn Source: " + self.spawn_source;
            }
        }
        
        time = geteventtimestamp();
        
        if ( self.var_20e64768236c78cf < time - ( level.gametypebundle.var_46f94aac2d4f85db ?? 30 ) || state != nextstate || data != nextdata )
        {
            self.var_20e64768236c78cf = time;
            state = nextstate;
            data = nextdata;
            function_d31c748cc33a7667( "breadcrumb", self.origin, state, time, data, entnum );
        }
    }
}

// Namespace analytics
// Params 1
// Checksum 0xa7b54f58, Offset: 0xb13
// Size: 0x53
function updatebreadcrumb( time )
{
    if ( !level.var_f72e312e8d48a549 )
    {
        return;
    }
    
    if ( !function_18b384fcbf135f0e() )
    {
        return;
    }
    
    if ( !isdefined( self.var_20e64768236c78cf ) )
    {
        self.var_20e64768236c78cf = time;
        thread function_310556bfd82dfd6a();
        return;
    }
    
    self.var_20e64768236c78cf = time;
}

// Namespace analytics
// Params 1
// Checksum 0xa54651fc, Offset: 0xb6e
// Size: 0xc3
function _getdeathstatecode( deathtype )
{
    if ( !isdefined( deathtype ) )
    {
        return -1;
    }
    
    switch ( deathtype )
    {
        case #"hash_fea1e712b5740278":
            data = 6;
            break;
        case #"hash_1184b43822fe56f0":
            data = 3;
            break;
        case #"hash_c03eabf71149f406":
            data = 5;
            break;
        case #"hash_e97320d8279bef45":
            data = 4;
            break;
        case #"hash_ce250de499ae9603":
            data = 2;
            break;
        case #"hash_a9f265ec10b615d":
            data = 1;
            break;
        case #"hash_90436d3d95a3c6b7":
            data = 0;
            break;
        default:
            data = -1;
            break;
    }
    
    return data;
}

// Namespace analytics
// Params 1
// Checksum 0x4ff9f429, Offset: 0xc3a
// Size: 0xde, Type: bool
function function_7dd239dfcb717b4b( attacker )
{
    return !isdefined( attacker ) || !( isagent( attacker ) || isplayer( attacker ) ) || !isdefined( attacker.classname ) || attacker.classname == "worldspawn" || attacker.classname == "script_vehicle" || attacker.classname == "script_model" || attacker.classname == "misc_turret" || attacker.classname == "misc_samsite" || attacker.classname == "trigger_hurt" || attacker.classname == "trigger_multiple" || attacker.classname == "script_origin";
}

// Namespace analytics
// Params 2
// Checksum 0x765ca7ab, Offset: 0xd21
// Size: 0x1fd
function function_b6ed56a5b524eec1( params, attacker )
{
    if ( isdefined( params.inflictor ) && isdefined( params.inflictor.var_ebb661010747899 ) )
    {
        return params.inflictor.var_ebb661010747899;
    }
    
    if ( isdefined( params.inflictor ) && isdefined( params.inflictor.owner ) && isdefined( params.inflictor.owner.var_ebb661010747899 ) )
    {
        return params.inflictor.owner.var_ebb661010747899;
    }
    
    if ( isdefined( attacker ) && isdefined( attacker.var_ebb661010747899 ) )
    {
        return attacker.var_ebb661010747899;
    }
    
    if ( isdefined( attacker ) && isdefined( attacker.owner ) && isdefined( attacker.owner.var_ebb661010747899 ) )
    {
        return attacker.owner.var_ebb661010747899;
    }
    
    if ( isdefined( params.meansofdeath ) )
    {
        switch ( params.meansofdeath )
        {
            case #"hash_b15027ffbdc0ecb":
                return "world_falling";
            case #"hash_e5033ccbb2f0e988":
                return "world_bump";
            case #"hash_abb1587cdc6def23":
                return "world_crush";
            case #"hash_8fdafd3a15f78cf8":
                return "world_trigger_hurt";
        }
    }
    
    if ( isdefined( params.inflictor ) && isdefined( params.inflictor.classname ) )
    {
        return ( "world_" + params.inflictor.classname );
    }
    
    if ( isdefined( attacker ) && isdefined( attacker.classname ) )
    {
        return ( "world_" + attacker.classname );
    }
    
    return "world";
}

// Namespace analytics
// Params 0
// Checksum 0x2df069bd, Offset: 0xf27
// Size: 0x15
function function_392e3a042a5c9beb()
{
    return level.gametypebundle.var_4ef3fd8944a23ac9;
}

// Namespace analytics
// Params 3
// Checksum 0x9733e0fc, Offset: 0xf45
// Size: 0x3c
function function_70d5ce15078d923a( params, victim, attacker )
{
    if ( function_392e3a042a5c9beb() )
    {
        return function_d8ad97e09a9ca2a( params, victim, attacker );
    }
    
    return function_ddeb5675ed5ed8cc( params, victim, attacker );
}

// Namespace analytics
// Params 3
// Checksum 0x51d7edf9, Offset: 0xf8a
// Size: 0x56
function function_ddeb5675ed5ed8cc( params, victim, attacker )
{
    if ( isdefined( victim.death_source ) )
    {
        return victim.death_source;
    }
    
    if ( function_7dd239dfcb717b4b( attacker ) )
    {
        return function_b6ed56a5b524eec1( params, attacker );
    }
    
    return function_90cba1b7b711b34e( attacker );
}

// Namespace analytics
// Params 3
// Checksum 0x43cb9426, Offset: 0xfe9
// Size: 0x96
function function_d8ad97e09a9ca2a( params, victim, attacker )
{
    causecategory = function_89f46e1b2d927b7d( params, victim, attacker );
    attackerentnum = "-1";
    attackerweaponname = "";
    
    if ( !function_7dd239dfcb717b4b( attacker ) )
    {
        if ( isdefined( attacker ) )
        {
            attackerentnum = "" + attacker getentitynumber();
        }
        
        attackerweaponname = function_90cba1b7b711b34e( attacker );
    }
    
    return "c=" + causecategory + "|ae=" + attackerentnum + "|w=" + attackerweaponname;
}

// Namespace analytics
// Params 3
// Checksum 0x4bafd2a0, Offset: 0x1088
// Size: 0x56
function function_89f46e1b2d927b7d( params, victim, attacker )
{
    if ( isdefined( victim.death_source ) )
    {
        return victim.death_source;
    }
    
    if ( function_7dd239dfcb717b4b( attacker ) )
    {
        return function_b6ed56a5b524eec1( params, attacker );
    }
    
    return function_43012ec77dcf53cb( attacker );
}

// Namespace analytics
// Params 1
// Checksum 0x7c419096, Offset: 0x10e7
// Size: 0x4c
function function_43012ec77dcf53cb( attacker )
{
    if ( isdefined( attacker ) && isplayer( attacker ) )
    {
        if ( isbot( attacker ) )
        {
            return "killer_bot";
        }
        
        return "killer_player";
    }
    
    if ( isdefined( attacker ) && isagent( attacker ) )
    {
        return "killer_agent";
    }
    
    return "killer_other";
}

// Namespace analytics
// Params 1
// Checksum 0x7a0f911f, Offset: 0x113c
// Size: 0x51
function function_90cba1b7b711b34e( attacker )
{
    if ( !isdefined( attacker ) )
    {
        return "";
    }
    
    attackerweapon = attacker getcurrentweapon();
    
    if ( isdefined( attackerweapon ) && isdefined( attackerweapon.basename ) )
    {
        return attackerweapon.basename;
    }
    
    return "";
}

