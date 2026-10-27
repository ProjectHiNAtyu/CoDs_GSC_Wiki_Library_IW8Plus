// script_24e2eab2ea4299f8  (hash_24e2eab2ea4299f8.gscc) (size: 4138 Bytes / 0x102a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2918dc08 (689495048)
// size ...... 4138 (0x102a)
// includes .. 7   (offset: 0xf8e)
// strings ... 6   (offset: 0xfc6)
// dev strs .. 0   (offset: 0x102a)
// exports ... 12  (offset: 0x8ea)
// cseg ...... 0xb1 + 0x839 (0x8ea)
// imports ... 41  (offset: 0xaca)
// animtree1 . 0   (offset: 0x102a)
// animtree2 . 0   (offset: 0x102a)
#using script_aa3bac81ad4fc8e;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vehicle_attack;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_bgb_idle_eyes;

// Namespace zm_bgb_idle_eyes
// Params 0, eflags: 0x5
// Checksum 0x257b6d54, Offset: 0xcf
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "idle_eyes", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_idle_eyes
// Params 0
// Checksum 0xc82d002e, Offset: 0xf4
// Size: 0x75
function __init__()
{
    bgb::register( "idle_eyes", "time", 30, &enable, &disable, undefined );
    bgb::function_dbfbba0189f602fa( "idle_eyes", 1 );
    utility::registersharedfunc( #"bgb", #"hash_f48f602e45cbde7f", &function_5933d813eed82780 );
    callback::add( "on_agent_spawned", &on_ai_spawn );
    scene::function_85b13b837056bc8b( &function_231f32d6ac0137ed );
    scene::function_53de0775d8452750( &function_216e9d32999e2894 );
}

// Namespace zm_bgb_idle_eyes
// Params 0
// Checksum 0xa8fbccf3, Offset: 0x171
// Size: 0x25f
function enable()
{
    self endon( #"disconnect" );
    
    if ( !bgb::function_b87991eaf97e2279( "idle_eyes" ) )
    {
        pbgpostfxbundlestart( #"all", %"cer_zm_gobblegum_idle_eyes" );
    }
    
    a_ai = getaiarray();
    
    foreach ( ai in a_ai )
    {
        if ( ai.var_a8fa61d92872fc74 || isdefined( ai.idle_eyes_attractor ) )
        {
            continue;
        }
        
        if ( ai zombie_vehicle_attack::is_in_vehicle_attack() )
        {
            ai zombie_vehicle_attack::function_b6b04d95c27e889b( 0 );
            ai zombie_vehicle_attack::function_22391ae9d7a28a94( 1 );
            ai thread function_c9a6a0f1c5c5bf82();
            continue;
        }
        
        idle_loc = spawnstruct();
        idle_loc.origin = ai.origin;
        idle_loc.angles = ai.angles;
        ai.idle_eyes_attractor = ai zombie_attractor_manager::function_7eb1aaa8bc7cc15( idle_loc, 4 );
    }
    
    a_active_players = utility::get_alive_players();
    
    foreach ( player in a_active_players )
    {
        player playlocalsound( #"hash_42569f8444957b19" );
        
        if ( !isdefined( player.var_c7f27bb76041efea ) )
        {
            player.var_c7f27bb76041efea = spawn( "script_origin", self.origin );
            player.var_c7f27bb76041efea.targetname = "bgb_idle_eyes";
            player.var_c7f27bb76041efea showonlytoplayer( self );
            player.var_c7f27bb76041efea linkto( self );
            player.var_c7f27bb76041efea playloopsound( #"hash_36d20a3eb754d3f9" );
        }
    }
    
    level thread deactivate_on_disconnect( self );
}

// Namespace zm_bgb_idle_eyes
// Params 0
// Checksum 0x63242820, Offset: 0x3d8
// Size: 0x15
function disable()
{
    self notify( #"hash_3ef5c470162991fa" );
    deactivate();
}

// Namespace zm_bgb_idle_eyes
// Params 1
// Checksum 0xd7863bc7, Offset: 0x3f5
// Size: 0x3a
function deactivate_on_disconnect( e_watch )
{
    level endon( #"hash_ef5b314788ab5239" );
    e_watch endon( #"hash_3ef5c470162991fa" );
    e_watch waittill( #"disconnect" );
    deactivate();
}

// Namespace zm_bgb_idle_eyes
// Params 0
// Checksum 0xf02be58e, Offset: 0x437
// Size: 0x1a7
function deactivate()
{
    foreach ( player in level.players )
    {
        player playlocalsound( #"hash_edc6b2e080586688" );
        
        if ( isdefined( player.var_c7f27bb76041efea ) )
        {
            player.var_c7f27bb76041efea delete();
            player.var_c7f27bb76041efea = undefined;
        }
    }
    
    if ( bgb::function_e46a4ef6b724b555( "idle_eyes" ) )
    {
        return;
    }
    
    pbgpostfxbundleend( #"all", %"cer_zm_gobblegum_idle_eyes" );
    a_ai = getaiarray();
    
    foreach ( ai in a_ai )
    {
        if ( !ai.idle_eyes_attractor )
        {
            continue;
        }
        
        if ( ai zombie_vehicle_attack::is_in_vehicle_attack() )
        {
            ai zombie_vehicle_attack::function_b6b04d95c27e889b( 1 );
            ai zombie_vehicle_attack::function_22391ae9d7a28a94( 0 );
            continue;
        }
        
        ai zombie_attractor_manager::function_dcfb4c31f1d97cd2( ai.idle_eyes_attractor );
        ai.idle_eyes_attractor = undefined;
    }
    
    level notify( #"hash_ef5b314788ab5239" );
}

// Namespace zm_bgb_idle_eyes
// Params 1, eflags: 0x4
// Checksum 0x3cc57a35, Offset: 0x5e6
// Size: 0x13e
function private on_ai_spawn( params )
{
    ent = params.agent;
    
    if ( !ent.var_a8fa61d92872fc74 )
    {
        foreach ( e_player in level.players )
        {
            if ( e_player bgb::is_enabled( "idle_eyes" ) )
            {
                ent utility::waittill_any_timeout( level.framedurationseconds, "post_spawn" );
                
                if ( !e_player bgb::is_enabled( "idle_eyes" ) )
                {
                    return;
                }
                
                if ( ent.var_a8fa61d92872fc74 )
                {
                    continue;
                }
                
                idle_loc = spawnstruct();
                idle_loc.origin = ent.origin;
                idle_loc.angles = ent.angles;
                ent.idle_eyes_attractor = ent zombie_attractor_manager::function_7eb1aaa8bc7cc15( idle_loc, 4 );
                return;
            }
        }
    }
}

// Namespace zm_bgb_idle_eyes
// Params 0
// Checksum 0xe39bb3f7, Offset: 0x72c
// Size: 0x19
function function_231f32d6ac0137ed()
{
    pbgpostfxbundlekill( #"all", %"cer_zm_gobblegum_idle_eyes" );
}

// Namespace zm_bgb_idle_eyes
// Params 0
// Checksum 0x5b62b140, Offset: 0x74d
// Size: 0x9a
function function_216e9d32999e2894()
{
    foreach ( player in level.players )
    {
        if ( player bgb::is_enabled( "idle_eyes" ) )
        {
            pbgpostfxbundlestart( #"all", %"cer_zm_gobblegum_idle_eyes" );
            return;
        }
    }
}

// Namespace zm_bgb_idle_eyes
// Params 0, eflags: 0x4
// Checksum 0xd7f5c545, Offset: 0x7ef
// Size: 0x74
function private function_c9a6a0f1c5c5bf82()
{
    self endon( #"death" );
    level endon( #"hash_ef5b314788ab5239" );
    self waittill( #"vehicle_attack_end" );
    idle_loc = spawnstruct();
    idle_loc.origin = self.origin;
    idle_loc.angles = self.angles;
    self.idle_eyes_attractor = zombie_attractor_manager::function_7eb1aaa8bc7cc15( idle_loc, 4 );
}

// Namespace zm_bgb_idle_eyes
// Params 1
// Checksum 0x3c075c0c, Offset: 0x86b
// Size: 0x7f
function function_5933d813eed82780( var_f1fbc291f2430b1e )
{
    if ( var_f1fbc291f2430b1e )
    {
        idle_loc = { #angles:self.angles, #origin:self.origin };
        self.idle_eyes_attractor = zombie_attractor_manager::function_7eb1aaa8bc7cc15( idle_loc, 4 );
        return;
    }
    
    if ( isdefined( self.idle_eyes_attractor ) )
    {
        zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.idle_eyes_attractor );
        self.idle_eyes_attractor = undefined;
    }
}

