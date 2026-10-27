// scripts\mp\augments\y_mod_augments.gsc  (hash_189561ecfa610b10.gscc) (size: 4031 Bytes / 0xfbf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x314e3446 (827208774)
// size ...... 4031 (0xfbf)
// includes .. 9   (offset: 0xe9b)
// strings ... 15  (offset: 0xee3)
// dev strs .. 0   (offset: 0xfbf)
// exports ... 11  (offset: 0x86b)
// cseg ...... 0x143 + 0x728 (0x86b)
// imports ... 39  (offset: 0xa23)
// animtree1 . 0   (offset: 0xfbf)
// animtree2 . 0   (offset: 0xfbf)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\status_effects\status_effects;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\perks\zombie\perk_y_mod;
#using scripts\mp\health_overcharge;
#using scripts\mp\mp_agent;

#namespace y_mod_augments;

// Namespace y_mod_augments
// Params 0, eflags: 0x5
// Checksum 0x815e0a2b, Offset: 0x161
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"y_mod_augments", undefined, &init_y_mod_augments, undefined );
}

// Namespace y_mod_augments
// Params 0
// Checksum 0x4ff4c40a, Offset: 0x182
// Size: 0x7e
function init_y_mod_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    callback::add( "zm_perk_obtained", &function_288f120db5b6defb );
    callback::add( "zm_perk_lost", &function_9e09844df6bf44c7 );
    callback::add( "y_mod_proc", &on_y_mod_proc );
    callback::add( #"player_death", &on_player_death );
    callback::add( "on_zombie_ai_damaged", &on_zombie_ai_damaged );
    callback::add( #"on_ai_killed", &on_zombie_ai_killed );
}

// Namespace y_mod_augments
// Params 1
// Checksum 0x214af05d, Offset: 0x208
// Size: 0xc
function function_288f120db5b6defb( params )
{
    
}

// Namespace y_mod_augments
// Params 1
// Checksum 0x66666c29, Offset: 0x21c
// Size: 0xc
function function_9e09844df6bf44c7( params )
{
    
}

// Namespace y_mod_augments
// Params 1
// Checksum 0x1acb4a21, Offset: 0x230
// Size: 0x6c
function on_y_mod_proc( params )
{
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_y_mod", #"y_mod_web_spinner" ) )
    {
        thread function_38ba0f9fd2923b01();
    }
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_y_mod", #"y_mod_hatchling" ) )
    {
        thread function_19cbf1e0efa92149();
    }
}

// Namespace y_mod_augments
// Params 0
// Checksum 0x3716e3c6, Offset: 0x2a4
// Size: 0x21f
function function_19cbf1e0efa92149()
{
    if ( self.y_mod_hatchling_friend && isalive( self.y_mod_hatchling_friend ) )
    {
        return;
    }
    
    forward_vec = anglestoforward( self.angles );
    forward_vec = vectornormalize( forward_vec );
    forward_vec_1 = forward_vec * 256;
    forward_vec_2 = forward_vec * 128;
    spawn_pos_1 = getclosestpointonnavmesh( self.origin + forward_vec_1 );
    spawn_pos_2 = getclosestpointonnavmesh( self.origin + forward_vec_2 );
    isvalidzone = istrue( utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", spawn_pos_1 ) );
    spawn_pos = spawn_pos_1;
    
    if ( !isvalidzone )
    {
        isvalidzone = istrue( utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", spawn_pos_2 ) );
        spawn_pos = spawn_pos_2;
    }
    
    if ( !isvalidzone )
    {
        spawn_pos = self.origin;
    }
    
    if ( isvalidzone )
    {
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        
        team = self.team;
        duration = level.zombie_augments[ #"y_mod_hatchling" ].duration ?? 15;
        var_bc661ad67960c4e3 = function_b3988325430ce242( "zombie_loom_minion" );
        zombie = mp_agent::spawnnewagentaitype( var_bc661ad67960c4e3, spawn_pos, angles, team );
        
        if ( isdefined( zombie ) )
        {
            playfx( utility::getfx( "y_mod_proc" ), spawn_pos );
            playworldsound( spawn_pos, #"hash_fcc544c13d0e93ab" );
            zombie.var_a13bed1ac47e1b2c = 1;
            zombie.ignore_enemy_count = 1;
            base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", zombie zombie_utils::get_zombie_round_difficulty() );
            zombie zombie_utils::function_f2e381737e46096( self, duration, 1 );
            zombie.var_cab75db7e9e5b64c = base_zombie_maxhealth * 1;
            zombie.var_b7d346480d1fc488 = 1;
            self.y_mod_hatchling_friend = zombie;
        }
    }
}

// Namespace y_mod_augments
// Params 1
// Checksum 0xb8a1888a, Offset: 0x4cb
// Size: 0x29
function on_player_death( sparams )
{
    if ( self.var_4530bbcc704a0955 )
    {
        utility::function_7c10ea82c1e305b8( "y_mod", "off" );
    }
}

// Namespace y_mod_augments
// Params 0
// Checksum 0x80844e52, Offset: 0x4fc
// Size: 0x1de
function function_38ba0f9fd2923b01()
{
    self endon( #"death_or_disconnect" );
    wait 0.5;
    duration = level.zombie_augments[ #"y_mod_web_spinner" ].duration ?? 5;
    duration *= 1000;
    radius = level.zombie_augments[ #"y_mod_web_spinner" ].radius ?? 96;
    var_2f697cc2bd1c8df3 = gettime();
    utility::function_7c10ea82c1e305b8( "y_mod", "web_field_on" );
    self.var_4530bbcc704a0955 = 1;
    
    while ( gettime() - var_2f697cc2bd1c8df3 < duration )
    {
        zombies = getaiarrayinradius( self.origin, radius );
        
        foreach ( zombie in zombies )
        {
            if ( zombie.type == "zombie" && zombie.team != self.team && !zombie_utils::function_bf1464d09f4e4b40() && !zombie status_effects::function_fa35fc2723e956eb( "slow", "y_mod_cocoon" ) )
            {
                web_time = 1;
                var_13552415056c9dda = self.var_8704cc35a218223e ?? 0.5;
                zombie perk_y_mod::y_mod_web_zombie( self, web_time, var_13552415056c9dda );
            }
        }
        
        waitframe();
    }
    
    utility::function_7c10ea82c1e305b8( "y_mod", "off" );
    self playsoundonmovingent( #"hash_e62980c6b9996ede" );
    self.var_4530bbcc704a0955 = undefined;
}

// Namespace y_mod_augments
// Params 1
// Checksum 0x53235b11, Offset: 0x6e2
// Size: 0xbf
function on_zombie_ai_damaged( sparams )
{
    if ( isplayer( sparams.eattacker ) && sparams.eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_y_mod", #"y_mod_widows_bite" ) && sparams.smeansofdeath == "MOD_MELEE" )
    {
        proc_chance = level.zombie_augments[ #"y_mod_web_spinner" ].procchance ?? 0.05;
        proc_chance *= 100;
        
        if ( utility::percent_chance( proc_chance ) )
        {
            sparams.eattacker perk_y_mod::function_bc2f9e6df47d0692( 1 );
        }
    }
}

// Namespace y_mod_augments
// Params 1
// Checksum 0xb4d113b4, Offset: 0x7a9
// Size: 0xc2
function on_zombie_ai_killed( sparams )
{
    if ( isplayer( sparams.eattacker ) && sparams.eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_y_mod", #"y_mod_widows_bite" ) && sparams.smeansofdeath == "MOD_MELEE" )
    {
        if ( status_effects::function_fa35fc2723e956eb( "slow", "y_mod_cocoon" ) )
        {
            overhealamount = level.zombie_augments[ #"y_mod_widows_bite" ].var_96c2f5bdf5f40eb0 ?? 50;
            health_overcharge::function_f6da758a8ee4c988( sparams.eattacker, "y_mod_widows_bite_heal", overhealamount );
        }
    }
}

