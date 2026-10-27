// script_2e008c550c5daf6d  (hash_2e008c550c5daf6d.gscc) (size: 6429 Bytes / 0x191d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4f6e4bc7 (1332628423)
// size ...... 6429 (0x191d)
// includes .. 6   (offset: 0x1751)
// strings ... 17  (offset: 0x1781)
// dev strs .. 0   (offset: 0x191d)
// exports ... 8   (offset: 0x1215)
// cseg ...... 0x17c + 0x1099 (0x1215)
// imports ... 24  (offset: 0x1355)
// animtree1 . 0   (offset: 0x191d)
// animtree2 . 0   (offset: 0x191d)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\challenges\zombie_challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\playerachievements;

#namespace namespace_e9202f9dfde1fc3a;

// Namespace namespace_e9202f9dfde1fc3a
// Params 0, eflags: 0x5
// Checksum 0x71b02531, Offset: 0x19a
// Size: 0x15
function private autoexec __init__system__()
{
    system::register( "zm_rh_validator", undefined, undefined, &init );
}

// Namespace namespace_e9202f9dfde1fc3a
// Params 0
// Checksum 0xc1ef7353, Offset: 0x1b7
// Size: 0x6f
function init()
{
    if ( !game_utility::function_194a17c8979659a5() )
    {
        if ( level.gametype == "zm_guided" )
        {
            level.var_796924378f2ffad4 = 1;
        }
        else
        {
            return;
        }
    }
    
    level callback::add( #"player_connect", &on_player_connect );
    level callback::add( #"hash_22fdd0c3eb081084", &function_faa65c55f256000b );
    level callback::add( #"zm_mq_quest_complete", &function_3b89e2f38d9c3f43 );
}

// Namespace namespace_e9202f9dfde1fc3a
// Params 1, eflags: 0x4
// Checksum 0x4f67864b, Offset: 0x22e
// Size: 0x393
function private on_player_connect( params )
{
    map_name = game_utility::getmapname();
    playerachievements::getstate( self, 75684 );
    playerachievements::getstate( self, 75686 );
    playerachievements::getstate( self, 75688 );
    playerachievements::getstate( self, 75692 );
    playerachievements::getstate( self, 75690 );
    playerachievements::getstate( self, 75693 );
    playerachievements::getstate( self, 75695 );
    playerachievements::getstate( self, 75964 );
    playerachievements::getstate( self, 75697 );
    playerachievements::getstate( self, 54420 );
    playerachievements::getstate( self, 63431 );
    playerachievements::getstate( self, 64034 );
    playerachievements::getstate( self, 64041 );
    playerachievements::getstate( self, 67504 );
    playerachievements::getstate( self, 67506 );
    playerachievements::getstate( self, 69556 );
    playerachievements::getstate( self, 69558 );
    playerachievements::getstate( self, 69565 );
    playerachievements::getstate( self, 69567 );
    playerachievements::getstate( self, 69574 );
    playerachievements::getstate( self, 69576 );
    
    if ( getdvarint( @"enable_scarab_br", 0 ) )
    {
        self.var_a10da01c9aea8bf2 = 1;
        self.var_3815d538690d2f23 = 1;
        
        if ( !level utility::flag( "portal_spawn_rh" ) )
        {
            level utility::flag_set( "portal_spawn_rh" );
            level thread portal_spawn_logic();
        }
    }
    
    self.toy_spawned = [];
    level utility::flag_set( "rh_player_established" );
    
    if ( getdvarint( @"hash_7ae1c9d5cf785e78", 0 ) )
    {
        map_name = game_utility::getmapname();
        
        if ( map_name == "zm_sat_scarab" )
        {
            if ( getdvarint( @"enable_firefly_rh", 0 ) )
            {
                level.var_4d300798a1726ad2 = 1;
                params = spawnstruct();
                params.player = self;
                params.map = "zm_sat_firefly";
                level callback::callback( "rh_toys_set", params );
            }
            
            if ( getdvarint( @"hash_3a67100b9bf066cd", 0 ) )
            {
                level.var_d93b63f886c5b545 = 1;
                params = spawnstruct();
                params.player = self;
                params.map = "zm_sat_ruby";
                level callback::callback( "rh_toys_set", params );
            }
            
            if ( getdvarint( @"enable_mantis_rh", 0 ) )
            {
                level.var_963cb96c03e1302d = 1;
                params = spawnstruct();
                params.player = self;
                params.map = "zm_sat_mantis";
                level callback::callback( "rh_toys_set", params );
            }
            
            if ( getdvarint( @"hash_4283bcfc772f341b", 0 ) )
            {
                level.var_3f180a87ebecbb3a = 1;
                params = spawnstruct();
                params.player = self;
                params.map = "zm_sat_locust";
                level callback::callback( "rh_toys_set", params );
            }
            
            if ( getdvarint( @"hash_a7ecb342705c5659", 0 ) )
            {
                level.var_16ecac42bee4d780 = 1;
                params = spawnstruct();
                params.player = self;
                params.map = "zm_sat_hornet";
                level callback::callback( "rh_toys_set", params );
            }
            
            if ( getdvarint( @"hash_133ef07dad4cf03b", 0 ) )
            {
                level.var_87abced58749b699 = 1;
                params = spawnstruct();
                params.player = self;
                params.map = "zm_sat_scarab";
                level callback::callback( "rh_toys_set", params );
            }
        }
        
        self.var_30a6c57505d1119b = 1;
    }
}

// Namespace namespace_e9202f9dfde1fc3a
// Params 1, eflags: 0x4
// Checksum 0xd7075070, Offset: 0x5c9
// Size: 0x89a
function private function_faa65c55f256000b( params )
{
    map_name = game_utility::getmapname();
    
    if ( level.onlinegame )
    {
        if ( !isdefined( level.rh_enabled ) )
        {
            level.rh_enabled = 0;
        }
        
        if ( params.achievementid == 75684 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 75684, "progress", 0 ) )
            {
                self.var_11f0a190160021dd = 1;
                
                if ( map_name && issubstr( map_name, "scarab" ) && !level.var_796924378f2ffad4 )
                {
                    self.toy_spawned[ self.toy_spawned.size ] = "zm_sat_firefly";
                    params = spawnstruct();
                    params.player = self;
                    params.map = "zm_sat_firefly";
                    level callback::callback( "rh_toys_set", params );
                }
            }
        }
        
        if ( params.achievementid == 75686 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 75686, "progress", 0 ) )
            {
                self.var_1bf107e8638f5574 = 1;
                
                if ( map_name && issubstr( map_name, "scarab" ) && !level.var_796924378f2ffad4 )
                {
                    self.toy_spawned[ self.toy_spawned.size ] = "zm_sat_ruby";
                    params = spawnstruct();
                    params.player = self;
                    params.map = "zm_sat_ruby";
                    level callback::callback( "rh_toys_set", params );
                }
            }
        }
        
        if ( params.achievementid == 75688 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 75688, "progress", 0 ) )
            {
                self.var_5388587ed7a9f314 = 1;
                
                if ( map_name && issubstr( map_name, "scarab" ) && !level.var_796924378f2ffad4 )
                {
                    self.toy_spawned[ self.toy_spawned.size ] = "zm_sat_mantis";
                    params = spawnstruct();
                    params.player = self;
                    params.map = "zm_sat_mantis";
                    level callback::callback( "rh_toys_set", params );
                }
            }
        }
        
        if ( params.achievementid == 75692 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 75692, "progress", 0 ) )
            {
                self.var_7fe31db612cd941a = 1;
                
                if ( map_name && issubstr( map_name, "scarab" ) && !level.var_796924378f2ffad4 )
                {
                    self.toy_spawned[ self.toy_spawned.size ] = "zm_sat_locust";
                    params = spawnstruct();
                    params.player = self;
                    params.map = "zm_sat_locust";
                    level callback::callback( "rh_toys_set", params );
                }
            }
        }
        
        if ( params.achievementid == 75690 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 75690, "progress", 0 ) )
            {
                self.var_4ad88eeba60b1ac = 1;
                
                if ( map_name && issubstr( map_name, "scarab" ) && !level.var_796924378f2ffad4 )
                {
                    self.toy_spawned[ self.toy_spawned.size ] = "zm_sat_hornet";
                    params = spawnstruct();
                    params.player = self;
                    params.map = "zm_sat_hornet";
                    level callback::callback( "rh_toys_set", params );
                }
            }
        }
        
        if ( params.achievementid == 75693 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 75693, "progress", 0 ) )
            {
                self.var_27501a6cf23a6c06 = 1;
                
                if ( map_name && issubstr( map_name, "scarab" ) && !level.var_796924378f2ffad4 )
                {
                    self.toy_spawned[ self.toy_spawned.size ] = "zm_sat_scarab";
                    params = spawnstruct();
                    params.player = self;
                    params.map = "zm_sat_scarab";
                    level callback::callback( "rh_toys_set", params );
                }
            }
        }
        
        if ( params.achievementid == 75695 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 75695, "progress", 0 ) )
            {
                self.var_a10da01c9aea8bf2 = 1;
            }
        }
        
        if ( params.achievementid == 75964 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 75964, "progress", 0 ) )
            {
                self.var_30a6c57505d1119b = 1;
            }
        }
        
        if ( params.achievementid == 54420 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 54420, "progress", 0 ) )
            {
                self.completed_firefly_mq = 1;
            }
        }
        else if ( params.achievementid == 63431 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 63431, "progress", 0 ) )
            {
                self.completed_firefly_mq = 1;
            }
        }
        
        if ( params.achievementid == 64034 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 64034, "progress", 0 ) )
            {
                self.completed_ruby_mq = 1;
            }
        }
        else if ( params.achievementid == 64041 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 64041, "progress", 0 ) )
            {
                self.completed_ruby_mq = 1;
            }
        }
        
        if ( params.achievementid == 67504 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 67504, "progress", 0 ) )
            {
                self.completed_mantis_mq = 1;
            }
        }
        else if ( params.achievementid == 67506 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 67506, "progress", 0 ) )
            {
                self.completed_mantis_mq = 1;
            }
        }
        
        if ( params.achievementid == 69556 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 69556, "progress", 0 ) )
            {
                self.completed_locust_mq = 1;
            }
        }
        else if ( params.achievementid == 69558 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 69558, "progress", 0 ) )
            {
                self.completed_locust_mq = 1;
            }
        }
        
        if ( params.achievementid == 69565 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 69565, "progress", 0 ) )
            {
                self.completed_hornet_mq = 1;
            }
        }
        else if ( params.achievementid == 69567 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 69567, "progress", 0 ) )
            {
                self.completed_hornet_mq = 1;
            }
        }
        
        if ( params.achievementid == 69574 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 69574, "progress", 0 ) )
            {
                self.var_de72f1d573bcf6e9 = 1;
            }
        }
        else if ( params.achievementid == 69576 )
        {
            if ( playerachievements::function_ce48098d17912e1f( self, 69576, "progress", 0 ) )
            {
                self.var_de72f1d573bcf6e9 = 1;
            }
        }
    }
    
    if ( self.completed_firefly_mq && self.completed_ruby_mq && self.completed_mantis_mq && self.completed_locust_mq && self.completed_hornet_mq && self.var_de72f1d573bcf6e9 && !self.var_30a6c57505d1119b )
    {
        level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", #"hash_41fe2d401527b850", [ self ] );
        self.var_30a6c57505d1119b = 1;
    }
    
    if ( self.var_11f0a190160021dd && self.var_1bf107e8638f5574 && self.var_5388587ed7a9f314 && self.var_7fe31db612cd941a && self.var_4ad88eeba60b1ac && self.var_27501a6cf23a6c06 && !self.var_a10da01c9aea8bf2 )
    {
        level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", #"hash_8f4de46115e0d713", [ self ] );
        self.var_a10da01c9aea8bf2 = 1;
    }
    
    if ( self.var_30a6c57505d1119b && !level.var_796924378f2ffad4 )
    {
        level.rh_enabled = 1;
        level utility::flag_set( "rh_validation_set" );
    }
    
    if ( map_name && issubstr( map_name, "scarab" ) && !level.var_796924378f2ffad4 )
    {
        if ( self.var_a10da01c9aea8bf2 )
        {
            self.var_3815d538690d2f23 = 1;
            
            if ( !level utility::flag( "portal_spawn_rh" ) )
            {
                level utility::flag_set( "portal_spawn_rh" );
                level thread portal_spawn_logic();
            }
        }
    }
}

// Namespace namespace_e9202f9dfde1fc3a
// Params 1
// Checksum 0x78d6bb7f, Offset: 0xe6b
// Size: 0x10a, Type: bool
function can_spawn_toys( map )
{
    if ( self.toy_spawned && arraycontains( self.toy_spawned, map ) )
    {
        return true;
    }
    
    if ( level.var_796924378f2ffad4 )
    {
        return false;
    }
    
    switch ( map )
    {
        case #"hash_c22b93e5ab1ca835":
            if ( level.var_4d300798a1726ad2 )
            {
                return true;
            }
            
            break;
        case #"hash_a3b961ca8ff17958":
            if ( level.var_d93b63f886c5b545 )
            {
                return true;
            }
            
            break;
        case #"hash_1957d230149ca5a8":
            if ( level.var_963cb96c03e1302d )
            {
                return true;
            }
            
            break;
        case #"hash_7df2a5f5c99cd50e":
            if ( level.var_3f180a87ebecbb3a )
            {
                return true;
            }
            
            break;
        case #"hash_775f1342bceb7a8":
            if ( level.var_16ecac42bee4d780 )
            {
                return true;
            }
            
            break;
        case #"hash_9dcd979ffcf18d62":
            if ( level.var_87abced58749b699 )
            {
                return true;
            }
            
            break;
        default:
            break;
    }
    
    return false;
}

// Namespace namespace_e9202f9dfde1fc3a
// Params 0
// Checksum 0x7d415b77, Offset: 0xf7e
// Size: 0x29
function portal_spawn_logic()
{
    level utility::flag_wait( "wanna_wingo_eh" );
    level utility::flag_clear( "exfil_window_active" );
    level utility::flag_set( "rh_tb_return" );
}

// Namespace namespace_e9202f9dfde1fc3a
// Params 1
// Checksum 0xced3a15, Offset: 0xfaf
// Size: 0x266
function function_3b89e2f38d9c3f43( params )
{
    var_bddb08d06fd14b82 = namespace_b645faa035c740a7::function_77862a3ac198ca62();
    
    if ( params.is_main_quest && isdefined( var_bddb08d06fd14b82[ #"is_main_quest" ] ) )
    {
        foreach ( player in level.players )
        {
            map_name = game_utility::getmapname();
            map_name = getxhash( map_name );
            
            switch ( map_name )
            {
                case #"zm_sat_firefly":
                    if ( !player.completed_firefly_mq )
                    {
                        player.completed_firefly_mq = 1;
                    }
                    
                    break;
                case #"zm_sat_ruby":
                    if ( !player.completed_ruby_mq )
                    {
                        player.completed_ruby_mq = 1;
                    }
                    
                    break;
                case #"zm_sat_mantis":
                    if ( !player.completed_mantis_mq )
                    {
                        player.completed_mantis_mq = 1;
                    }
                    
                    break;
                case #"zm_sat_locust":
                    if ( !player.completed_locust_mq )
                    {
                        player.completed_locust_mq = 1;
                    }
                    
                    break;
                case #"zm_sat_hornet":
                    if ( !player.completed_hornet_mq )
                    {
                        player.completed_hornet_mq = 1;
                    }
                    
                    break;
                case #"zm_sat_scarab":
                    if ( !player.var_de72f1d573bcf6e9 )
                    {
                        player.var_de72f1d573bcf6e9 = 1;
                    }
                    
                    break;
                default:
                    break;
            }
            
            if ( player.completed_firefly_mq && player.completed_ruby_mq && player.completed_mantis_mq && player.completed_locust_mq && player.completed_hornet_mq && player.var_de72f1d573bcf6e9 )
            {
                level utility::callsharedfunc( #"hash_7305513195fadf7e", #"hash_65886d21168e150a", #"hash_41fe2d401527b850", [ player ] );
            }
        }
    }
}

