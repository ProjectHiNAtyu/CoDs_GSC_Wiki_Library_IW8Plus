// script_23b580b08abe064f  (hash_23b580b08abe064f.gscc) (size: 15559 Bytes / 0x3cc7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x25893726 (629749542)
// size ...... 15559 (0x3cc7)
// includes .. 10  (offset: 0x3a87)
// strings ... 33  (offset: 0x3ad7)
// dev strs .. 1   (offset: 0x3cbb)
// exports ... 38  (offset: 0x2567)
// cseg ...... 0x27c + 0x22eb (0x2567)
// imports ... 118 (offset: 0x2b57)
// animtree1 . 0   (offset: 0x3cc7)
// animtree2 . 0   (offset: 0x3cc7)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm_bb;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_traverse;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\interaction;

#namespace zombie_hellhound_pet_asm;

// Namespace zombie_hellhound_pet_asm
// Params 0
// Checksum 0x216789c3, Offset: 0x29a
// Size: 0x20
function init_zombie_hellhound_pet()
{
    callback::add( "on_turned", &function_f4995d07e42a7545 );
    self function_786bb6aa1b76c7ee( "howl_after_pet_end", 1 );
}

// Namespace zombie_hellhound_pet_asm
// Params 3
// Checksum 0x89af6eee, Offset: 0x2c2
// Size: 0xc2
function function_ca029f3959fb5e65( playerowner, var_c96fc65946d3967c, var_4984cef9c237bb15 = 1 )
{
    self function_786bb6aa1b76c7ee( "howl_after_pet_end", 0 );
    self function_786bb6aa1b76c7ee( "petting", 0 );
    
    if ( isdefined( self.set_health_fn ) )
    {
        self [[ self.set_health_fn ]]( var_c96fc65946d3967c );
    }
    
    self.var_43d79e31059e0e5b = 1;
    self.var_697a0762533cf0dc = 10;
    self.reviving = 0;
    self.pet_owner = playerowner;
    playerowner.var_b93d6394e79d80e9 = self;
    
    if ( var_4984cef9c237bb15 )
    {
        thread function_710615b2b5071a8a();
    }
    
    thread function_bedfbff7fdbd7f6f();
    thread function_f3533c61865ae21c();
    thread function_af18a7db49f2633f();
    thread function_c0508357cca000ad();
    thread function_2d904f1f02c922d();
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0x6b870ffb, Offset: 0x38c
// Size: 0x1ff
function private function_c0508357cca000ad()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait 0.5;
    wait_time = 0.5;
    
    while ( isalive( self ) )
    {
        if ( self.reviving )
        {
            wait 2;
            continue;
        }
        
        if ( self.pet_owner.var_22bd8935826c4bc5 )
        {
            function_30c40921ccda56ba();
            waitframe();
            continue;
        }
        
        if ( distancesquared( self.pet_owner.origin, self.origin ) >= squared( 3000 ) && self.var_697a0762533cf0dc >= 10 && !self.pet_owner.inlaststand )
        {
            teleport_to_point( self.pet_owner.origin );
            continue;
        }
        
        isincombat = !update_petting();
        
        if ( isincombat )
        {
            if ( self.petting && !self.being_pet )
            {
                end_petting();
            }
            
            if ( distancesquared( self.pet_owner.origin, self.origin ) > squared( 950 ) )
            {
                function_ddece66a374aa66e( self.pet_owner );
            }
        }
        else if ( isdefined( self.pet_owner ) )
        {
            can_pet = !self.petting;
            
            if ( distancesquared( self.pet_owner.origin, self.origin ) > 90000 )
            {
                if ( self.petting )
                {
                    end_petting();
                }
                
                can_pet = function_ddece66a374aa66e( self.pet_owner );
            }
            
            if ( can_pet && start_petting( self.pet_owner ) )
            {
                thread function_9c0ee83c37112c7f();
            }
        }
        
        wait_time = self.petting ? 0.1 : 0.5;
        wait wait_time;
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0x9b27fa45, Offset: 0x593
// Size: 0x13d
function private function_30c40921ccda56ba()
{
    self endon( #"death" );
    player = self.pet_owner;
    
    if ( isalive( player ) )
    {
        player endon( #"hash_50e6f4d741bee789" );
        player endon( #"death_or_disconnect" );
    }
    
    if ( isdefined( player.var_a10f7b74f982f0f0 ) && isdefined( player.var_a10f7b74f982f0f0.s_exfil ) )
    {
        player.var_a10f7b74f982f0f0.s_exfil waittill( #"exfil_complete_timeout" );
        vh_exfil = player.var_a10f7b74f982f0f0;
        
        if ( isdefined( vh_exfil ) )
        {
            forward_angles = anglestoforward( vh_exfil.angles );
            var_1a7695c54572fa18 = invertangles( forward_angles );
            var_b718a4324486dcc = var_1a7695c54572fa18 * 1200 + vh_exfil.origin;
            teleport_to_point( var_b718a4324486dcc );
            zombie_utils::update_bt_goal( self.origin, 2 );
            thread function_9ee14c71f30efa28();
            thread function_85170e0e8f85cf3b();
            player utility::waittill_notify_or_timeout( "exfil_fully_completed", 20 );
            
            if ( isalive( self ) )
            {
                function_377582546b8be51b();
                self kill();
            }
        }
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0xacc68b8d, Offset: 0x6d8
// Size: 0x30
function private function_85170e0e8f85cf3b()
{
    thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "howl", "howl" );
    self setscriptablepartstate( "heal_audio", "on" );
    wait 1.75;
    asm_bb::bb_clearanimscripted();
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0xa13ae084, Offset: 0x710
// Size: 0x30
function private function_2a026fd9a5053c6c()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_c64c119677118a2c" );
    wait 8;
    function_7d1be7a0bd47907e();
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0xb92fe4a8, Offset: 0x748
// Size: 0x5c
function private function_bedfbff7fdbd7f6f()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage" );
        
        if ( utility::ent_flag( "healing" ) )
        {
            utility::ent_flag_clear( "healing" );
        }
        
        self notify( #"hash_c64c119677118a2c" );
        thread function_2a026fd9a5053c6c();
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0x2e80efaa, Offset: 0x7ac
// Size: 0xa2
function private function_7d1be7a0bd47907e()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    utility::ent_flag_set( "healing" );
    
    while ( utility::ent_flag( "healing" ) )
    {
        if ( self.health >= self.maxhealth )
        {
            utility::ent_flag_clear( "healing" );
            return;
        }
        
        var_79bbea74d8069d69 = int( self.maxhealth * 0.005 );
        self.health = int( min( self.maxhealth, self.health + var_79bbea74d8069d69 ) );
        wait 1;
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0x78d7492c, Offset: 0x856
// Size: 0x49
function private function_f3533c61865ae21c()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"melee_started" );
        
        if ( isdefined( self.set_melee_fn ) )
        {
            self [[ self.set_melee_fn ]]();
        }
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 1, eflags: 0x4
// Checksum 0x9be95620, Offset: 0x8a7
// Size: 0x120
function private teleport_to_point( point )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    safeorigin = getclosestpointonnavmesh( point, self );
    
    if ( isdefined( safeorigin ) )
    {
        playsoundatpos( self.origin + ( 0, 0, 50 ), "evt_ai_hellhound_friendly_teleport_out" );
        tag_origin = utility::spawn_tag_origin( self.origin );
        self linkto( tag_origin );
        tag_origin.origin = safeorigin + ( 0, 0, -15000 );
        wait 0.5;
        thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "spawn", "spawn_end", safeorigin, self.angles, "spawn_animating" );
        tag_origin.origin = safeorigin;
        tag_origin delete();
        wait 1.5;
        playsoundatpos( safeorigin + ( 0, 0, 50 ), "evt_ai_hellhound_friendly_teleport_in" );
        self notify( #"dog_teleported" );
        self.var_697a0762533cf0dc = 0;
        thread function_c9b3cff3c01665b4();
        self notify( #"hash_383911d9e31b7523" );
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0xb65b3fbd, Offset: 0x9cf
// Size: 0x179
function private function_af18a7db49f2633f()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    player = self.pet_owner;
    
    if ( isdefined( player ) )
    {
        player endon( #"death_or_disconnect" );
        
        while ( true )
        {
            playerteam = player.team;
            playersquadindex = player.sessionsquadid;
            
            if ( isdefined( playerteam ) && isdefined( playersquadindex ) && isdefined( level.squaddata[ playerteam ][ playersquadindex ] ) && isdefined( level.squaddata[ playerteam ][ playersquadindex ].players ) )
            {
                squadmembers = level.squaddata[ playerteam ][ playersquadindex ].players;
                
                foreach ( member in squadmembers )
                {
                    if ( isalive( member ) )
                    {
                        if ( member.inlaststand && !self.reviving )
                        {
                            function_1f673ec054bb2880( member );
                            function_377582546b8be51b();
                            self.reviving = 0;
                        }
                    }
                }
            }
            
            wait 1;
        }
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0xfcb7f7a8, Offset: 0xb50
// Size: 0x39
function private function_710615b2b5071a8a()
{
    self endon( #"death" );
    
    if ( isplayer( self.pet_owner ) )
    {
        self.pet_owner waittill( #"death_or_disconnect" );
        self kill();
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 1, eflags: 0x4
// Checksum 0x7b93fa16, Offset: 0xb91
// Size: 0x268
function private function_1f673ec054bb2880( player )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    player endon( #"death_or_disconnect" );
    self.reviving = 1;
    wait 7;
    
    if ( distancesquared( self.origin, player.origin ) >= 90000 )
    {
        safeorigin = get_pet_target_origin( player );
        
        if ( isdefined( safeorigin ) )
        {
            self forceteleport( safeorigin );
        }
    }
    
    target = player.origin - self.origin;
    target = vectornormalize( target );
    angles = vectortoangles( target );
    self orientmode( "face angle", angles[ 1 ] );
    zombie_utils::update_bt_goal( self.origin, 2 );
    wait 0.5;
    thread function_85170e0e8f85cf3b();
    wait 1.25;
    playerteam = player.team;
    playersquadindex = player.sessionsquadid;
    squadmembers = level.squaddata[ playerteam ][ playersquadindex ].players;
    var_d47589113434a712 = 0;
    
    foreach ( member in squadmembers )
    {
        if ( member.inlaststand )
        {
            var_d47589113434a712 = 1;
        }
    }
    
    if ( isdefined( self.var_311f52a17726b14e ) && var_d47589113434a712 )
    {
        var_c88f3518c64127e8 = int( self.health / 3 );
        
        foreach ( member in squadmembers )
        {
            member [[ self.var_311f52a17726b14e ]]();
        }
        
        self dodamage( var_c88f3518c64127e8, self.origin );
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 1, eflags: 0x4
// Checksum 0xf6ecd579, Offset: 0xe01
// Size: 0x2db, Type: bool
function private function_ddece66a374aa66e( player )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( player.var_22bd8935826c4bc5 )
    {
        return false;
    }
    
    self clearbtgoal( 2 );
    self.previous_move_type = self._blackboard.movetype;
    zombie_utils::function_a8ce00e0448cb6f0( "run", "turned", 26 );
    safeorigin = get_pet_target_origin( player );
    
    if ( isdefined( safeorigin ) )
    {
        self clearpath();
        zombie_utils::update_bt_goal( safeorigin, 2 );
        var_437a8e1e2b785e79 = player.origin;
        var_d1b50eaedcb189a6 = 0;
        waitframe();
        
        while ( true )
        {
            if ( player.var_22bd8935826c4bc5 )
            {
                function_377582546b8be51b();
                self clearpath();
                return false;
            }
            
            if ( self.reviving )
            {
                function_377582546b8be51b();
                return false;
            }
            
            if ( !isdefined( self ) )
            {
                return false;
            }
            
            if ( isdefined( self.enemy ) && distancesquared( self.origin, player.origin ) <= squared( 700 ) )
            {
                function_377582546b8be51b();
                return false;
            }
            
            if ( !isalive( player ) || player.inlaststand )
            {
                function_377582546b8be51b();
                return false;
            }
            
            if ( !isdefined( self.goalpos ) || self function_c607805e62ad17af() > 2000 )
            {
                function_377582546b8be51b();
                return false;
            }
            
            if ( !zombie_traverse::is_traversing() && isdefined( self.goalpos ) && distancesquared( self.goalpos, safeorigin ) > 1024 )
            {
                self clearpath();
                zombie_utils::update_bt_goal( safeorigin, 2 );
                waitframe();
                continue;
            }
            
            if ( distancesquared( player.origin, var_437a8e1e2b785e79 ) > 2304 && distancesquared( player.origin, self.origin ) < squared( 3000 ) )
            {
                safeorigin = get_pet_target_origin( player );
                var_437a8e1e2b785e79 = player.origin;
                
                if ( isdefined( safeorigin ) )
                {
                    self clearpath();
                    zombie_utils::update_bt_goal( safeorigin, 2 );
                    waitframe();
                    continue;
                }
            }
            else if ( distancesquared( player.origin, self.origin ) >= squared( 3000 ) && self.var_697a0762533cf0dc >= 10 )
            {
                teleport_to_point( self.pet_owner.origin );
                function_377582546b8be51b();
                break;
            }
            
            if ( distancesquared( self.goalpos, self.origin ) < 2304 )
            {
                var_d1b50eaedcb189a6 = 1;
            }
            
            if ( var_d1b50eaedcb189a6 && !zombie_traverse::is_traversing() )
            {
                function_377582546b8be51b();
                break;
            }
            
            waitframe();
        }
    }
    
    self notify( #"hash_383911d9e31b7523" );
    return true;
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0xa840a5c1, Offset: 0x10e5
// Size: 0x46
function private update_petting()
{
    self._blackboard.var_8791b0d4cb49ab89 = !isalive( self.enemy ) && !isdefined( self.target_attractor );
    return self._blackboard.var_8791b0d4cb49ab89;
}

// Namespace zombie_hellhound_pet_asm
// Params 1, eflags: 0x4
// Checksum 0x2f46e7ab, Offset: 0x1134
// Size: 0x3f
function private function_f4995d07e42a7545( attacker )
{
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.pettingenabled )
    {
        self function_786bb6aa1b76c7ee( "petting", 0 );
        thread pet_watcher();
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0xee6e822b, Offset: 0x117b
// Size: 0xf2
function private pet_watcher()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    wait 0.5;
    wait_time = 0.5;
    
    if ( self.var_8a4ce02f2bfc45a9 )
    {
        return;
    }
    
    while ( isalive( self ) && !self.collared )
    {
        isincombat = !update_petting();
        
        if ( isincombat )
        {
            if ( self.petting && !self.being_pet )
            {
                end_petting();
            }
        }
        else if ( !self.petting )
        {
            player = move_to_player();
            
            if ( self actorgetgroundslope() >= 0.98 )
            {
                if ( isdefined( player ) )
                {
                    if ( start_petting( player ) )
                    {
                        thread function_558e8201ab50c1c4();
                    }
                }
            }
        }
        
        wait_time = self.petting ? 0.1 : 0.5;
        wait wait_time;
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0x548a56b2, Offset: 0x1275
// Size: 0x22b
function private move_to_player()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.previous_move_type = self._blackboard.movetype;
    zombie_utils::function_a8ce00e0448cb6f0( "run", "turned", 26 );
    closestplayer = function_6c0182e951281eab();
    
    if ( !isplayer( closestplayer ) )
    {
        return;
    }
    
    self clearbtgoal( 2 );
    
    if ( distancesquared( closestplayer.origin, self.origin ) > 90000 )
    {
        safeorigin = get_pet_target_origin( closestplayer );
        
        if ( isdefined( safeorigin ) )
        {
            self clearpath();
            zombie_utils::update_bt_goal( safeorigin, 2 );
            var_437a8e1e2b785e79 = closestplayer.origin;
            var_d1b50eaedcb189a6 = 0;
            waitframe();
            
            while ( true )
            {
                if ( !isdefined( self ) )
                {
                    return;
                }
                
                if ( isdefined( self.enemy ) )
                {
                    function_377582546b8be51b();
                    return;
                }
                
                if ( !isalive( closestplayer ) || closestplayer.inlaststand )
                {
                    function_377582546b8be51b();
                    self clearpath();
                    return;
                }
                
                if ( !isdefined( self.goalpos ) || self function_c607805e62ad17af() > 2000 )
                {
                    function_377582546b8be51b();
                    self clearpath();
                    return;
                }
                
                if ( !zombie_traverse::is_traversing() && isdefined( self.goalpos ) && distancesquared( self.goalpos, safeorigin ) > 1024 )
                {
                    self clearpath();
                    zombie_utils::update_bt_goal( safeorigin, 2 );
                    waitframe();
                    continue;
                }
                
                if ( distancesquared( closestplayer.origin, var_437a8e1e2b785e79 ) > 2304 )
                {
                    safeorigin = get_pet_target_origin( closestplayer );
                    var_437a8e1e2b785e79 = closestplayer.origin;
                    
                    if ( isdefined( safeorigin ) )
                    {
                        self clearpath();
                        zombie_utils::update_bt_goal( safeorigin, 2 );
                        waitframe();
                        continue;
                    }
                }
                
                if ( distancesquared( self.goalpos, self.origin ) < 2304 )
                {
                    var_d1b50eaedcb189a6 = 1;
                }
                
                if ( var_d1b50eaedcb189a6 && !zombie_traverse::is_traversing() )
                {
                    function_377582546b8be51b();
                    break;
                }
                
                waitframe();
            }
        }
    }
    
    self notify( #"hash_383911d9e31b7523" );
    self clearpath();
    return closestplayer;
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0xddd296ff, Offset: 0x14a9
// Size: 0x3b
function private function_c9b3cff3c01665b4()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"dog_teleported" );
    
    while ( true )
    {
        self.var_697a0762533cf0dc++;
        wait 1;
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 1, eflags: 0x4
// Checksum 0xc8d7ed04, Offset: 0x14ec
// Size: 0x8f
function private get_pet_target_origin( player )
{
    forward = self.origin - player.origin;
    forward = vectornormalize( forward );
    targetorigin = player.origin + ( forward[ 0 ], forward[ 1 ], 0 ) * 150;
    safeorigin = self getclosestreachablepointonnavmesh( targetorigin );
    safeorigin = getgroundposition( safeorigin, 15 );
    level thread debug_utility::drawsphere( safeorigin, 15, 3, ( 1, 0, 1 ) );
    return safeorigin;
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0xf7474638, Offset: 0x1584
// Size: 0xd2
function private function_38273ee573983b01()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( isdefined( self.pet_badplace_id ) )
    {
        return;
    }
    
    for ( asmstate = self asmgetcurrentstate( self.asmname ); asmstate == "pet_intro" ; asmstate = self asmgetcurrentstate( self.asmname ) )
    {
        wait 0.1;
        
        if ( isalive( self.enemy ) || self.target_attractor )
        {
            end_petting();
            return 0;
        }
    }
    
    self.pet_badplace_id = function_8bf6c5fe849106c4( self.origin, ( 0, 0, 0 ), 8, 35, 35 );
    
    if ( isdefined( self.pet_badplace_id ) )
    {
        thread function_61488ce105d0011f( self.pet_badplace_id );
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 1, eflags: 0x4
// Checksum 0x96c8ce2a, Offset: 0x165e
// Size: 0x6f
function private function_61488ce105d0011f( var_8de6f80b3674ce04 )
{
    level endon( #"game_ended" );
    msg = utility::waittill_any_in_array_return( [ "death", "pet_finished" ] );
    
    if ( isdefined( var_8de6f80b3674ce04 ) )
    {
        destroynavobstacle( var_8de6f80b3674ce04 );
    }
    
    if ( msg != "death" && self.pet_badplace_id == var_8de6f80b3674ce04 )
    {
        self.pet_badplace_id = undefined;
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0x84cf26db, Offset: 0x16d5
// Size: 0xa
function private function_377582546b8be51b()
{
    self clearbtgoal( 2 );
}

// Namespace zombie_hellhound_pet_asm
// Params 1, eflags: 0x4
// Checksum 0x66c573f, Offset: 0x16e7
// Size: 0x168, Type: bool
function private start_petting( closestplayer )
{
    if ( !isalive( closestplayer ) || closestplayer.inlaststand )
    {
        return false;
    }
    
    self clearbtgoal( 2 );
    startpos = self.origin + ( 0, 0, 20 );
    delta = anglestoforward( self.angles ) * 100;
    endpos = startpos + delta;
    contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 1 );
    trace = trace::capsule_trace( startpos, endpos, 15, 30, undefined, [ self ], contents, 1 );
    
    if ( trace[ "fraction" ] < 1 )
    {
        return false;
    }
    
    self clearpath();
    self function_786bb6aa1b76c7ee( "petting", 1 );
    self.petting = 1;
    
    for ( asmstate = self asmgetcurrentstate( self.asmname ); asmstate != "pet_intro" ; asmstate = self asmgetcurrentstate( self.asmname ) )
    {
        wait 0.1;
        
        if ( isalive( self.enemy ) || self.target_attractor )
        {
            end_petting();
            return false;
        }
    }
    
    function_38273ee573983b01();
    
    if ( !isdefined( self.pet_interact ) )
    {
        delay_spawn_interact( 3 );
    }
    
    return true;
}

// Namespace zombie_hellhound_pet_asm
// Params 1, eflags: 0x4
// Checksum 0xb617cb4, Offset: 0x1858
// Size: 0xd0
function private delay_spawn_interact( time )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"pet_finished" );
    wait time;
    
    if ( isalive( self ) )
    {
        self.pet_interact = interaction::register_interact( self.origin + ( 0, 0, 32 ), 80, &on_pet_interact );
        self.pet_interact interaction::set_interact_hint_callback( &pet_interact_per_player_hint );
        self.pet_interact linkto( self, "tag_origin", ( 0, 0, 32 ), ( 0, 0, 0 ) );
        thread utility::delete_on_death( self.pet_interact );
        self.pet_interact.dog = self;
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0xf818b711, Offset: 0x1930
// Size: 0x9e
function private function_9ee14c71f30efa28()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"pet_finished" );
    
    while ( true )
    {
        if ( !self.being_pet )
        {
            if ( isdefined( self.pet_owner ) )
            {
                target = self.pet_owner.origin - self.origin;
                target = vectornormalize( target );
                angles = vectortoangles( target );
                self orientmode( "face angle", angles[ 1 ] );
            }
        }
        
        wait 0.2;
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0x1289be5b, Offset: 0x19d6
// Size: 0xa2
function private function_f6d833e0c75ad4c5()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"pet_finished" );
    
    while ( true )
    {
        if ( !self.being_pet )
        {
            closestplayer = function_6c0182e951281eab();
            
            if ( isplayer( closestplayer ) )
            {
                target = closestplayer.origin - self.origin;
                target = vectornormalize( target );
                angles = vectortoangles( target );
                self orientmode( "face angle", angles[ 1 ] );
            }
        }
        
        wait 0.2;
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 0
// Checksum 0xd67c31ef, Offset: 0x1a80
// Size: 0xc2
function function_6c0182e951281eab()
{
    alive_players = [];
    
    foreach ( player in level.players )
    {
        if ( isalive( player ) && !player.inlaststand )
        {
            alive_players[ alive_players.size ] = player;
        }
    }
    
    sortedplayers = sortbydistance( alive_players, self.origin );
    
    if ( sortedplayers.size == 0 )
    {
        return;
    }
    
    return sortedplayers[ 0 ];
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0xa006765c, Offset: 0x1b4b
// Size: 0x55
function private function_9c0ee83c37112c7f()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"pet_finished" );
    
    while ( true )
    {
        wait 1;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        closestplayer = function_6c0182e951281eab();
        
        if ( !isplayer( closestplayer ) )
        {
            return;
        }
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0x46787fa3, Offset: 0x1ba8
// Size: 0x7d
function private function_558e8201ab50c1c4()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"pet_finished" );
    
    while ( true )
    {
        wait 1;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        closestplayer = function_6c0182e951281eab();
        
        if ( !isplayer( closestplayer ) )
        {
            return;
        }
        
        if ( distancesquared( closestplayer.origin, self.origin ) > 90000 )
        {
            end_petting();
        }
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0x58fb9404, Offset: 0x1c2d
// Size: 0x6d
function private end_petting()
{
    if ( isdefined( self.pet_interact ) )
    {
        self.pet_interact delete();
    }
    
    if ( isdefined( self.previous_move_type ) )
    {
        zombie_utils::function_a8ce00e0448cb6f0( self.previous_move_type, "turned", 26 );
        self.previous_move_type = undefined;
    }
    
    self function_786bb6aa1b76c7ee( "petting", 0 );
    self.petting = undefined;
    self notify( #"pet_finished" );
}

// Namespace zombie_hellhound_pet_asm
// Params 2, eflags: 0x4
// Checksum 0x2c0ff6bc, Offset: 0x1ca2
// Size: 0xb1
function private pet_interact_per_player_hint( usable, player )
{
    if ( isdefined( player ) && isdefined( usable ) )
    {
        if ( !usable can_pet_interact( player ) )
        {
            return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
        }
        
        return { #var_26bbd300351fde34:0, #string:&"ai/hellhound_pet_hint", #type:"HINT_BUTTON" };
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
}

// Namespace zombie_hellhound_pet_asm
// Params 1, eflags: 0x4
// Checksum 0xb9b19fe9, Offset: 0x1d5c
// Size: 0x197, Type: bool
function private can_pet_interact( player )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( !player isonground() )
    {
        return false;
    }
    
    if ( !isalive( self.dog ) )
    {
        return false;
    }
    
    if ( player.inlaststand )
    {
        return false;
    }
    
    if ( utility::flag( "timetravel_ongoing" ) )
    {
        return false;
    }
    
    if ( self.dog.being_pet )
    {
        return false;
    }
    
    if ( player.var_6b5c16c263b6b7ac )
    {
        return false;
    }
    
    if ( player isreloading() || player isgestureplaying() || player isviewmodelanimplaying() || !isnullweapon( player.highpriorityweapon ) )
    {
        return false;
    }
    
    player_forward = anglestoforward( player.angles );
    dog_forward = anglestoforward( self.dog.angles );
    dot = vectordot( player_forward, dog_forward );
    
    if ( dot > 0 )
    {
        return false;
    }
    else if ( abs( dot ) < 0.8 )
    {
        return false;
    }
    
    if ( isdefined( player.origin ) && isdefined( self.dog.origin ) )
    {
        interact_diff = abs( player.origin[ 2 ] - self.dog.origin[ 2 ] );
        
        if ( interact_diff > 12 )
        {
            return false;
        }
    }
    
    if ( player is_pet_blocked( self.dog ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zombie_hellhound_pet_asm
// Params 1
// Checksum 0x17973995, Offset: 0x1efc
// Size: 0x5c
function on_pet_interact( player )
{
    if ( !can_pet_interact( player ) )
    {
        return;
    }
    
    println( "<dev string:x24>" + self.dog getentitynumber() );
    self.dog function_786bb6aa1b76c7ee( "pet_interact", 1 );
    player thread function_3b4023a072e16fff( self.dog, self );
}

// Namespace zombie_hellhound_pet_asm
// Params 2
// Checksum 0x88201915, Offset: 0x1f60
// Size: 0x319
function function_3b4023a072e16fff( dog, interact )
{
    level endon( #"game_ended" );
    interact disableplayeruseforallplayers();
    dog.being_pet = 1;
    self.is_petting = 1;
    var_6c61d6f6ea7c3e11 = utility::spawn_model( "tag_origin", dog gettagorigin( "tag_player" ), ( 0, 180, 0 ) );
    var_6c61d6f6ea7c3e11 linkto( dog, "tag_player", ( 0, 0, 0 ), ( 0, 180, 0 ) );
    var_7259e1e041d483a0 = vectornormalize( dog.origin - self.origin );
    nearbyai = getplayersandaiarrayinradius( dog.origin, 100 );
    
    foreach ( ent in nearbyai )
    {
        if ( ent == self || ent == dog )
        {
            continue;
        }
        
        dot = vectordot( vectornormalize( ent.origin - self.origin ), var_7259e1e041d483a0 );
        
        if ( isplayer( ent ) && dot > 0.5 )
        {
            if ( !ent.is_petting )
            {
                ent knockback( vectornormalize( ent.origin - self.origin ), 550 );
            }
            
            continue;
        }
        
        if ( isagent( ent ) && !ent.being_pet && dot > 0.5 )
        {
            ent zombie_knockdown::function_6fc167d4a3590991( ent.origin );
        }
    }
    
    self setstance( "stand" );
    self playerlinktoblend( var_6c61d6f6ea7c3e11, "tag_origin", 0.1, 0.1, 0.05 );
    self freezecontrols( 1 );
    time = self playviewmodelanim( "jup_con_van_pet_vm" );
    time *= 0.001;
    self playanimscriptsceneevent( "scripted_scene", "jup_zm_con_dog_pet" );
    var_6c61d6f6ea7c3e11 utility::delaycall( 0.05, &unlink );
    callback::callback( "on_hellhound_petted", { #dog:dog } );
    dog notify( #"hound_petting" );
    
    if ( !level.zm_mode_modifiers.var_43c8defc5fca8698 )
    {
        dog utility::waittill_notify_or_timeout( "death", time );
    }
    else
    {
        utility::function_f755811828e739dd( time, dog, "death", self, "last_stand_enter", self, "death_or_disconnect" );
    }
    
    if ( isdefined( self ) )
    {
        self.is_petting = 0;
        self freezecontrols( 0 );
        self unlink();
    }
    
    if ( isdefined( var_6c61d6f6ea7c3e11 ) )
    {
        var_6c61d6f6ea7c3e11 delete();
    }
    
    if ( isdefined( dog ) )
    {
        dog.being_pet = undefined;
    }
    
    if ( isdefined( interact ) )
    {
        interact enableplayeruseforallplayers();
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 0, eflags: 0x4
// Checksum 0x7f463991, Offset: 0x2281
// Size: 0xb8
function private function_2d904f1f02c922d()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    player = self.pet_owner;
    player endon( #"death_or_disconnect" );
    self function_fa32376aaa88a7a2( player.origin, 700 );
    player_last_pos = undefined;
    
    while ( true )
    {
        if ( !isdefined( player_last_pos ) )
        {
            player_last_pos = player.origin;
        }
        else if ( distancesquared( player_last_pos, player.origin ) >= 90000 )
        {
            self function_fa32376aaa88a7a2( player.origin, 700 );
            player_last_pos = player.origin;
        }
        
        wait 1;
    }
}

// Namespace zombie_hellhound_pet_asm
// Params 1, eflags: 0x4
// Checksum 0xa7b23c12, Offset: 0x2341
// Size: 0x225, Type: bool
function private is_pet_blocked( dog )
{
    var_7259e1e041d483a0 = vectornormalize( dog.origin - self.origin );
    nearbyai = getplayersandaiarrayinradius( dog.origin, 100 );
    
    foreach ( ent in nearbyai )
    {
        if ( ent == self || ent == dog )
        {
            continue;
        }
        
        dot = vectordot( vectornormalize( ent.origin - self.origin ), var_7259e1e041d483a0 );
        
        if ( isplayer( ent ) && dot > 0.5 )
        {
            if ( !ent.is_petting )
            {
                return true;
            }
            
            continue;
        }
        
        if ( isagent( ent ) && dot > 0.5 )
        {
            if ( ent.being_pet )
            {
                return true;
            }
            
            if ( !ent zombie_knockdown::function_99b2020a564d9c7e( ent.origin ) )
            {
                return true;
            }
        }
    }
    
    forward = vectornormalize( anglestoforward( self.angles ) );
    forward *= 32;
    backward = forward * -1;
    var_82f0fb6dc1c89261 = self getcentroid();
    end_back_pos = var_82f0fb6dc1c89261 + backward;
    end_forward_pos = var_82f0fb6dc1c89261 + forward;
    ignore_ents = [ 1:dog, 0:self ];
    contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 1 );
    passed_backwards = trace::sphere_trace_passed( var_82f0fb6dc1c89261, end_back_pos, 32, ignore_ents, contents );
    passed_forwards = trace::sphere_trace_passed( var_82f0fb6dc1c89261, end_forward_pos, 32, ignore_ents, contents );
    
    if ( !passed_backwards || !passed_forwards )
    {
        return true;
    }
    
    return false;
}

