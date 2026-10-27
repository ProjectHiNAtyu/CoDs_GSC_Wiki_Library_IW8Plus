// scripts\mp\ob\systems\ob_achievements.gsc  (hash_635b466cce8013a7.gscc) (size: 6912 Bytes / 0x1b00 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcc116555 (3423692117)
// size ...... 6912 (0x1b00)
// includes .. 7   (offset: 0x1880)
// strings ... 30  (offset: 0x18b8)
// dev strs .. 18  (offset: 0x1a24)
// exports ... 18  (offset: 0xfb0)
// cseg ...... 0x2b0 + 0xd00 (0xfb0)
// imports ... 49  (offset: 0x1280)
// animtree1 . 0   (offset: 0x1b00)
// animtree2 . 0   (offset: 0x1b00)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\throttle;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace ob_achievements;

// Namespace ob_achievements
// Params 0
// Checksum 0xe02b0d64, Offset: 0x2ce
// Size: 0x10b
function init()
{
    callback::add( #"on_ai_killed", &on_ai_killed );
    callback::add( #"ob_exfil_success", &ob_exfil_success );
    callback::add( "zm_perk_obtained", &function_6b5304265e1dd75d );
    callback::add( "on_tombstone_used_cache", &on_tombstone_used_cache );
    callback::add( #"player_laststand_revived", &function_b0f8cce4da821455 );
    callback::add( "on_hellhound_petted", &on_hellhound_petted );
    callback::add( "ob_act3_completed", &ob_act3_completed );
    callback::add( "ActivitySuccess", &function_85cc74565d8be1e9 );
    level.var_b3056107e47c3858 = getdvarint( @"hash_43d8974a0ee14c9f", 1 );
    level.var_d7e1f58e18cff5f7 = getdvarfloat( @"hash_6610d94e63d88554", 1 );
    
    if ( level.var_b3056107e47c3858 )
    {
        callback::add( #"player_connect", &on_player_connect );
    }
    
    level.throttle_ob_achievements = throttle::throttle_initialize( "ob_achievements", 2 );
    
    /#
        level thread ob_achievement_devgui();
    #/
}

/#

    // Namespace ob_achievements
    // Params 0, eflags: 0x4
    // Checksum 0x98c13785, Offset: 0x3e1
    // Size: 0x1f3, Type: dev
    function private ob_achievement_devgui()
    {
        var_5dfb3cee28ae928a = [ "<dev string:x24>", "<dev string:x39>", "<dev string:x50>", "<dev string:x61>", "<dev string:x73>", "<dev string:x8a>", "<dev string:x9a>", "<dev string:xaf>", "<dev string:xc1>", "<dev string:xd2>", "<dev string:xe8>", "<dev string:xf6>", "<dev string:x106>" ];
        devgui::function_9082edeb5db93280( "<dev string:x11d>" );
        
        foreach ( var_7fbb1b6fdc3285a1 in var_5dfb3cee28ae928a )
        {
            var_b0b5cc8d75c4adc = function_7e39a1e16e129a46( var_7fbb1b6fdc3285a1 );
            
            if ( isdefined( var_b0b5cc8d75c4adc ) )
            {
                var_98bdb906e702ea29 = "<dev string:x138>" + var_7fbb1b6fdc3285a1;
                devgui::function_cd4e263c1f3018ae( var_7fbb1b6fdc3285a1, var_98bdb906e702ea29, &function_cf2d1b056734cdd9 );
            }
        }
        
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x152>" );
        
        foreach ( var_7fbb1b6fdc3285a1 in var_5dfb3cee28ae928a )
        {
            var_b0b5cc8d75c4adc = function_7e39a1e16e129a46( var_7fbb1b6fdc3285a1 );
            
            if ( isdefined( var_b0b5cc8d75c4adc ) )
            {
                var_d0fc8c62a31a8f07 = "<dev string:x16c>" + var_7fbb1b6fdc3285a1 + "<dev string:x185>" + var_b0b5cc8d75c4adc;
            }
            else
            {
                var_d0fc8c62a31a8f07 = "<dev string:x16c>" + var_7fbb1b6fdc3285a1;
            }
            
            devgui::function_cd4e263c1f3018ae( var_7fbb1b6fdc3285a1, var_d0fc8c62a31a8f07, &function_86aacc7361e7f453 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ob_achievements
    // Params 1, eflags: 0x4
    // Checksum 0xc4429966, Offset: 0x5dc
    // Size: 0x60, Type: dev
    function private function_cf2d1b056734cdd9( params )
    {
        var_7fbb1b6fdc3285a1 = params[ 0 ];
        var_f208f4f1a3745e92 = params[ 1 ];
        var_b0b5cc8d75c4adc = function_7e39a1e16e129a46( var_7fbb1b6fdc3285a1 );
        
        if ( var_b0b5cc8d75c4adc > 1 )
        {
            level.players[ 0 ] function_1d246e93faed733d( var_7fbb1b6fdc3285a1, 1, 1, var_b0b5cc8d75c4adc );
        }
    }

    // Namespace ob_achievements
    // Params 1, eflags: 0x4
    // Checksum 0xe8648802, Offset: 0x644
    // Size: 0x72, Type: dev
    function private function_86aacc7361e7f453( params )
    {
        var_7fbb1b6fdc3285a1 = params[ 0 ];
        var_b0b5cc8d75c4adc = params[ 1 ];
        
        if ( isdefined( var_b0b5cc8d75c4adc ) )
        {
            var_b0b5cc8d75c4adc = int( var_b0b5cc8d75c4adc );
        }
        
        if ( var_b0b5cc8d75c4adc > 1 )
        {
            level.players[ 0 ] function_1d246e93faed733d( var_7fbb1b6fdc3285a1, 1, var_b0b5cc8d75c4adc, var_b0b5cc8d75c4adc );
            return;
        }
        
        level.players[ 0 ] function_1d246e93faed733d( var_7fbb1b6fdc3285a1 );
    }

#/

// Namespace ob_achievements
// Params 1, eflags: 0x4
// Checksum 0x1433a3ff, Offset: 0x6be
// Size: 0xdb
function private function_7e39a1e16e129a46( var_7fbb1b6fdc3285a1 )
{
    switch ( var_7fbb1b6fdc3285a1 )
    {
        case #"hash_c668de0e0aa7b10b":
            break;
        case #"hash_19ef00f30250a013":
            break;
        case #"hash_6e9a2470687663d3":
            break;
        case #"hash_7651423ef91c37d3":
            break;
        case #"hash_575532a7b068d9cb":
            break;
        case #"hash_313cf9d5eb4cd33d":
            return 20;
        case #"hash_b50213bb983d6f05":
            break;
        case #"hash_90cba3b822c4768f":
            break;
        case #"hash_52522f4303268b93":
            break;
        case #"hash_678e72fa0bb96fba":
            return 50000;
        case #"hash_3c317b7614468e55":
            break;
        case #"hash_b8a06661976052bd":
            return 500;
        case #"hash_27bde0f50a43f4b0":
            break;
    }
}

// Namespace ob_achievements
// Params 1, eflags: 0x4
// Checksum 0x14f04578, Offset: 0x7a1
// Size: 0x50
function private ob_act3_completed( params )
{
    function_1d246e93faed733d( "jup_ob_theend" );
    a_squad_members = squad_utility::getsquadmembers();
    
    if ( a_squad_members.size >= 6 || level.players.size >= 6 )
    {
        function_1d246e93faed733d( "jup_ob_oneagainstall" );
    }
}

// Namespace ob_achievements
// Params 1, eflags: 0x4
// Checksum 0xceac541c, Offset: 0x7f9
// Size: 0x136
function private function_85cc74565d8be1e9( params )
{
    activity = self;
    playerlist = params.playerlist;
    
    if ( isdefined( playerlist ) && isdefined( activity ) && activity.category == "Contract" )
    {
        foreach ( player in playerlist )
        {
            player function_1d246e93faed733d( "jup_ob_hiredgun", 1, 1, 20 );
            var_8de44035c62f2f4f = region_difficulty_manager::get_region_difficulty( player.origin );
            
            if ( var_8de44035c62f2f4f == "difficulty_hard" )
            {
                if ( !isdefined( player.var_fbc63e43e3edd97b ) )
                {
                    player.var_fbc63e43e3edd97b = 0;
                }
                
                player.var_fbc63e43e3edd97b++;
                
                if ( player.var_fbc63e43e3edd97b == 5 )
                {
                    player function_1d246e93faed733d( "jup_ob_seeingred" );
                }
            }
        }
    }
}

// Namespace ob_achievements
// Params 1, eflags: 0x4
// Checksum 0x2a450557, Offset: 0x937
// Size: 0x70
function private function_6a62ab6f90ccc43a( var_7fbb1b6fdc3285a1 )
{
    if ( level.var_b3056107e47c3858 )
    {
        if ( !isdefined( self.var_6c537664ddf06b11 ) )
        {
            self.var_6c537664ddf06b11 = [];
        }
        
        if ( !isdefined( self.var_6c537664ddf06b11[ var_7fbb1b6fdc3285a1 ] ) )
        {
            self.var_6c537664ddf06b11[ var_7fbb1b6fdc3285a1 ] = 0;
        }
        
        self.var_6c537664ddf06b11[ var_7fbb1b6fdc3285a1 ]++;
        return;
    }
    
    function_1d246e93faed733d( var_7fbb1b6fdc3285a1, 1, 1, function_7e39a1e16e129a46( var_7fbb1b6fdc3285a1 ) );
}

// Namespace ob_achievements
// Params 1, eflags: 0x4
// Checksum 0x7ec11879, Offset: 0x9af
// Size: 0xce
function private on_player_connect( params )
{
    self endon( #"disconnect" );
    self.var_6c537664ddf06b11 = [];
    
    while ( true )
    {
        foreach ( var_7fbb1b6fdc3285a1, var_59419e7814190b1d in self.var_6c537664ddf06b11 )
        {
            if ( var_59419e7814190b1d > 0 )
            {
                function_1d246e93faed733d( var_7fbb1b6fdc3285a1, 1, var_59419e7814190b1d, function_7e39a1e16e129a46( var_7fbb1b6fdc3285a1 ) );
                self.var_6c537664ddf06b11[ var_7fbb1b6fdc3285a1 ] = 0;
            }
        }
        
        wait level.var_d7e1f58e18cff5f7;
    }
}

// Namespace ob_achievements
// Params 1, eflags: 0x4
// Checksum 0xac84e776, Offset: 0xa85
// Size: 0x18
function private on_hellhound_petted( params )
{
    function_1d246e93faed733d( "jup_ob_youcanpetthedog" );
}

// Namespace ob_achievements
// Params 1, eflags: 0x4
// Checksum 0x41abfd83, Offset: 0xaa5
// Size: 0x5f
function private function_b0f8cce4da821455( params )
{
    reviver = params.reviver;
    
    if ( isplayer( reviver ) )
    {
        var_de8570e64356d64c = reviver squad_utility::getsquadmembers();
        
        if ( !arraycontains( var_de8570e64356d64c, self ) && self != reviver )
        {
            reviver function_1d246e93faed733d( "jup_ob_helpfulstranger" );
        }
    }
}

// Namespace ob_achievements
// Params 1, eflags: 0x4
// Checksum 0x9f528b65, Offset: 0xb0c
// Size: 0x18
function private on_tombstone_used_cache( params )
{
    function_1d246e93faed733d( "jup_ob_backfromthedead" );
}

// Namespace ob_achievements
// Params 1, eflags: 0x4
// Checksum 0xc97fc61c, Offset: 0xb2c
// Size: 0x28
function private function_6b5304265e1dd75d( params )
{
    if ( self.perks_active.size == 9 )
    {
        function_1d246e93faed733d( "jup_ob_perkaholic" );
    }
}

// Namespace ob_achievements
// Params 1, eflags: 0x4
// Checksum 0x3b7fdb1e, Offset: 0xb5c
// Size: 0x18
function private ob_exfil_success( params )
{
    function_1d246e93faed733d( "jup_ob_andsoitbegins" );
}

// Namespace ob_achievements
// Params 1, eflags: 0x4
// Checksum 0x643194ea, Offset: 0xb7c
// Size: 0x29a
function private on_ai_killed( params )
{
    if ( self.death_source == "despawn" )
    {
        return;
    }
    
    player = params.eattacker;
    
    if ( isdefined( player ) && !isplayer( player ) && isplayer( player.owner ) )
    {
        player = player.owner;
    }
    
    if ( isplayer( player ) )
    {
        player function_6a62ab6f90ccc43a( "jup_ob_slaughterhouse" );
        currentweapon = params.sweapon;
        
        if ( player common_inventory::function_6c36a0b1022cf8f6( currentweapon ) )
        {
            player function_6a62ab6f90ccc43a( "jup_ob_writeoff" );
        }
        
        if ( isdefined( params.einflictor ) && params.einflictor vehicle::is_vehicle() )
        {
            if ( !isdefined( player.var_fe4a5307f79a855 ) )
            {
                player.var_fe4a5307f79a855 = 0;
            }
            
            player.var_fe4a5307f79a855++;
            
            if ( player.var_fe4a5307f79a855 == 100 )
            {
                player function_1d246e93faed733d( "jup_ob_gravestone" );
            }
        }
        
        if ( isdefined( self.subclass ) )
        {
            if ( self.subclass == "zombie_deathworm" )
            {
                if ( isarray( self.a_n_player_damage ) )
                {
                    foreach ( player in self.a_n_player_damage )
                    {
                        if ( isplayer( player ) )
                        {
                            a_squad_members = player squad_utility::getsquadmembers();
                            
                            if ( a_squad_members.size >= 6 || a_squad_members.size >= getdvarint( @"hash_340b01b20673c44e", 6 ) )
                            {
                                player function_1d246e93faed733d( "jup_ob_oneagainstall" );
                            }
                        }
                    }
                }
                
                return;
            }
            
            if ( issubstr( self.subclass, "warlord" ) )
            {
                if ( isarray( self.a_n_player_damage ) )
                {
                    foreach ( player in self.a_n_player_damage )
                    {
                        if ( isplayer( player ) )
                        {
                            player function_1d246e93faed733d( "jup_ob_conqueror" );
                        }
                    }
                }
            }
        }
    }
}

// Namespace ob_achievements
// Params 4, eflags: 0x4
// Checksum 0xf57e4503, Offset: 0xe1e
// Size: 0x3c
function private function_1d246e93faed733d( var_7fbb1b6fdc3285a1, var_809034657ebd4b56 = 0, var_f208f4f1a3745e92, var_b0b5cc8d75c4adc )
{
    thread function_28bb6a61e8308c06( var_7fbb1b6fdc3285a1, var_809034657ebd4b56, var_f208f4f1a3745e92, var_b0b5cc8d75c4adc );
}

// Namespace ob_achievements
// Params 4, eflags: 0x4
// Checksum 0xd3ca2d5c, Offset: 0xe62
// Size: 0x14e
function private function_28bb6a61e8308c06( var_7fbb1b6fdc3285a1, var_809034657ebd4b56 = 0, var_f208f4f1a3745e92, var_b0b5cc8d75c4adc )
{
    self endon( #"disconnect" );
    
    if ( getdvarint( @"scr_ob_achievements", 1 ) )
    {
        throttle::throttle_wait_in_queue( level.throttle_ob_achievements, self );
        
        if ( var_809034657ebd4b56 )
        {
            var_94459317d204077e = self getplayerdata( level.var_6f9b00680ed002d8, var_7fbb1b6fdc3285a1 );
            n_current_count = var_94459317d204077e + var_f208f4f1a3745e92;
            self setplayerdata( level.var_6f9b00680ed002d8, var_7fbb1b6fdc3285a1, n_current_count );
            self function_1105733d932ce839( var_7fbb1b6fdc3285a1, n_current_count );
            var_71041a80a10ef204 = "==OB UpdateAchievementProgress " + var_7fbb1b6fdc3285a1 + ": " + n_current_count + " of " + var_b0b5cc8d75c4adc + " Required, by " + self.name;
            logstring( var_71041a80a10ef204 );
        }
        else
        {
            self giveachievement( var_7fbb1b6fdc3285a1 );
            var_ada45332c145f330 = "==OB GiveAchievement " + var_7fbb1b6fdc3285a1 + " completed by " + self.name;
            logstring( var_ada45332c145f330 );
        }
    }
    
    /#
        if ( getdvarint( @"hash_6ac2c4ff3a214246", 0 ) )
        {
            if ( var_809034657ebd4b56 && isdefined( var_71041a80a10ef204 ) )
            {
                iprintlnbold( var_71041a80a10ef204 );
                return;
            }
            
            if ( isdefined( var_ada45332c145f330 ) )
            {
                iprintlnbold( var_ada45332c145f330 );
            }
        }
    #/
}

