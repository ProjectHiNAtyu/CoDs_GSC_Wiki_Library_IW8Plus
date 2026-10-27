// scripts\mp\zm\ztron\ztron_bgb_machine.gsc  (hash_1e39fdab579d98bd.gscc) (size: 4797 Bytes / 0x12bd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8a4ebe17 (2320416279)
// size ...... 4797 (0x12bd)
// includes .. 10  (offset: 0x11a9)
// strings ... 9   (offset: 0x11f9)
// dev strs .. 7   (offset: 0x1269)
// exports ... 14  (offset: 0xad9)
// cseg ...... 0x142 + 0x997 (0xad9)
// imports ... 41  (offset: 0xd09)
// animtree1 . 0   (offset: 0x12bd)
// animtree2 . 0   (offset: 0x12bd)
#using script_4478f81b31480314;
#using script_aa3bac81ad4fc8e;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_bgb_machine;

// Namespace ztron_bgb_machine
// Params 0
// Checksum 0xdcd3db06, Offset: 0x160
// Size: 0x25
function init()
{
    level thread overridesharedfunc();
    ztron_sound::function_4ac735395b173fe( "ztron_bgb_machine_spawn", "evt_ztron_bgb_machine_appear" );
    
    /#
        function_ac7ee3673d6e340d();
    #/
}

// Namespace ztron_bgb_machine
// Params 0, eflags: 0x4
// Checksum 0x39b8db2c, Offset: 0x18d
// Size: 0x21
function private overridesharedfunc()
{
    waitframe();
    utility::registersharedfunc( #"bgb_machine", #"hash_aafc637a8f249873", &function_714b45076a2319e );
}

// Namespace ztron_bgb_machine
// Params 2
// Checksum 0xc1997ddd, Offset: 0x1b6
// Size: 0x52
function function_5034678ef8c91a09( origin, angles )
{
    gobblegummachine = spawnstruct();
    gobblegummachine.angles = angles;
    gobblegummachine.origin = origin;
    gobblegummachine bgb_machine::function_9a3e81eb8357ad32( undefined, "sat_zm_gobblegum_machine_ztron" );
    return gobblegummachine;
}

// Namespace ztron_bgb_machine
// Params 0
// Checksum 0x65e5858d, Offset: 0x211
// Size: 0xbb
function function_a6356b4f4c66e255()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( arraycontains( level.var_e0910c7bd4aab6fc, self ) )
    {
        level.var_e0910c7bd4aab6fc = arrayremove( level.var_e0910c7bd4aab6fc, self );
    }
    
    if ( self.mdl_bgb_machine )
    {
        if ( arraycontains( level.interacts, self.mdl_bgb_machine.interact ) )
        {
            level.interacts = arrayremove( level.interacts, self.mdl_bgb_machine.interact );
        }
        
        destroynavobstacle( self.navobstruction );
        self.mdl_bgb_machine freescriptable();
        self.mdl_bgb_machine = undefined;
    }
    
    self notify( #"ztron_bgb_machine_delete" );
}

// Namespace ztron_bgb_machine
// Params 0, eflags: 0x4
// Checksum 0x6fc557c7, Offset: 0x2d4
// Size: 0x4, Type: bool
function private can_purchase()
{
    return true;
}

// Namespace ztron_bgb_machine
// Params 1, eflags: 0x4
// Checksum 0x348113b4, Offset: 0x2e1
// Size: 0x182
function private function_714b45076a2319e( player )
{
    var_23f5dda23530d048 = undefined;
    var_c54c030e4bd2dd2e = -1;
    
    if ( isdefined( player.bgb ) && isdefined( level.bgb[ player.bgb ] ) )
    {
        var_c54c030e4bd2dd2e = level.bgb[ player.bgb ].item_index;
    }
    
    var_23f5dda23530d048 = gettime();
    
    if ( self.disabled )
    {
        wait 0.1;
        return;
    }
    
    cost = 0;
    
    if ( namespace_af5a2e4a7277c1d::function_f37cfdf04b932a03( player ) && can_purchase() )
    {
        self.bgb_machine_user = player;
        self.var_15d2744d244af3ed = cost;
    }
    else
    {
        return;
    }
    
    if ( isdefined( level.var_fae6e4a3f78b3a15 ) )
    {
        player thread [[ level.var_fae6e4a3f78b3a15 ]]();
    }
    
    player thread bgb_machine::cooldown_timer();
    player.var_71280c614e54bce2++;
    self.bgb_machine_user = player;
    self.bgb_machine_open = 1;
    self.var_8c58cdcaa8138341 = bgb_machine::function_7a24f6084a281eac( player );
    thread bgb_machine::set_bgb_machine_state( "open" );
    
    if ( self.var_8c58cdcaa8138341 && isdefined( self.selected_bgb ) )
    {
        player callback::callback( "on_gobblegum_purchased", { #cost:cost, #name:self.selected_bgb } );
    }
    
    self waittill( #"gumball_available" );
    self.var_871b76b970146df8 = 1;
}

// Namespace ztron_bgb_machine
// Params 2
// Checksum 0x9857361e, Offset: 0x46b
// Size: 0x2a9
function spawn_bgb_machine( origin, angles = ( 0, 0, 0 ) )
{
    assert( !level.ztron.var_95d8c7a469393957, "<dev string:x24>" );
    
    if ( !level.ztron.gobblegumsenabled )
    {
        return;
    }
    
    /#
        if ( !isdefined( origin ) )
        {
            if ( level.ztron.slayer.active_arena )
            {
                origin = level.ztron.slayer.active_arena.workbenchloc.origin;
            }
            else
            {
                currentarena = level.ztron.arenas[ level.ztron.currentarena ];
                origin = currentarena.center.origin;
            }
        }
    #/
    
    assert( isdefined( origin ), "<dev string:x3c>" );
    playerobstacle = [];
    
    foreach ( player in level.players )
    {
        navobstacle = createnavobstaclebybounds( player.origin, ( 20, 20, 100 ), ( 0, 0, 0 ) );
        playerobstacle[ playerobstacle.size ] = navobstacle;
    }
    
    waitframe();
    ztron_sound::ztron_playsound( "ztron_bgb_machine_spawn", origin );
    spawnpoint = ztron_util::function_4693a81423b56106( origin );
    bgbmachine = function_5034678ef8c91a09( spawnpoint, angles );
    bgbmachine thread function_e5415cea85370f7();
    
    foreach ( navobstacle in playerobstacle )
    {
        destroynavobstacle( navobstacle );
    }
    
    bgbmachine.navobstruction = createnavobstaclebybounds( bgbmachine.origin, ( 15, 15, 100 ), ( 0, 0, 0 ) );
    return bgbmachine;
}

// Namespace ztron_bgb_machine
// Params 0, eflags: 0xc
// Checksum 0xfcba0a17, Offset: 0x71d
// Size: 0x11c
function private function_e5415cea85370f7()
{
    self notify( #"hash_e8234e94d933d422" );
    self endon( #"hash_e8234e94d933d422" );
    self endon( #"ztron_bgb_machine_delete" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( player.ztron.var_a4c2f70bbc713f98 )
            {
                continue;
            }
            
            if ( player.ztron.var_5b9eb7a0800a4844 )
            {
                continue;
            }
            
            if ( !player bgb::function_c0286238eba807() )
            {
                continue;
            }
            
            if ( distancesquared( self.mdl_bgb_machine.origin, player.origin ) <= 6400 )
            {
                player thread function_4efc07d870b51ebf( self );
            }
        }
        
        wait 0.1;
    }
}

// Namespace ztron_bgb_machine
// Params 1, eflags: 0xc
// Checksum 0x5b13bfa4, Offset: 0x841
// Size: 0xd7
function private function_4efc07d870b51ebf( bgbmachine )
{
    self notify( #"hash_c91c15e39f6a4f9f" );
    self endon( #"hash_c91c15e39f6a4f9f" );
    self endon( #"disconnect" );
    level endon( #"papa_intro_begin" );
    level endon( #"slayer_intro_begin" );
    ztron_camera::function_79d64be315aa51c9( 0, 0, 0 );
    self.ztron.var_5b9eb7a0800a4844 = bgbmachine;
    thread function_2f6966aa48dc4be6( bgbmachine );
    thread function_2a75e193ee9ca9b5( bgbmachine );
    utility::waittill_any_ents( bgbmachine, "ztron_bgb_machine_delete", self, "ztron_bgb_machine_out_of_distance" );
    self.ztron.var_5b9eb7a0800a4844 = undefined;
    
    if ( !self.ztron.var_a4c2f70bbc713f98 )
    {
        if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
        {
            ztron_camera::function_9d5a55b239f1315a( 0 );
            return;
        }
        
        ztron_camera::function_9d2ce447580a6290( 0 );
    }
}

// Namespace ztron_bgb_machine
// Params 1, eflags: 0xc
// Checksum 0xda03653b, Offset: 0x920
// Size: 0x7e
function private function_2f6966aa48dc4be6( bgbmachine )
{
    self notify( #"hash_e5d4a34134e6388b" );
    self endon( #"hash_e5d4a34134e6388b" );
    self endon( #"disconnect" );
    
    while ( isdefined( bgbmachine.mdl_bgb_machine ) )
    {
        if ( distancesquared( bgbmachine.mdl_bgb_machine.origin, self.origin ) > 6400 )
        {
            self notify( #"ztron_bgb_machine_out_of_distance" );
            return;
        }
        
        wait 0.1;
    }
}

// Namespace ztron_bgb_machine
// Params 1, eflags: 0xc
// Checksum 0xf52370ca, Offset: 0x9a6
// Size: 0x87
function private function_2a75e193ee9ca9b5( bgbmachine )
{
    self notify( #"hash_d4f638ed6e6e99bf" );
    self endon( #"hash_d4f638ed6e6e99bf" );
    
    if ( !isdefined( bgbmachine ) )
    {
        if ( isdefined( self ) )
        {
            self.ztron.var_5b9eb7a0800a4844 = undefined;
        }
        
        return;
    }
    
    self endon( #"disconnect" );
    bgbmachine endon( #"ztron_bgb_machine_delete" );
    level utility::waittill_any( "papa_intro_begin", "slayer_intro_begin" );
    
    if ( isdefined( self ) )
    {
        self.ztron.var_5b9eb7a0800a4844 = undefined;
    }
}

/#

    // Namespace ztron_bgb_machine
    // Params 0, eflags: 0x4
    // Checksum 0x66f38a00, Offset: 0xa35
    // Size: 0x44, Type: dev
    function private function_ac7ee3673d6e340d()
    {
        devgui::function_9082edeb5db93280( "<dev string:x57>" );
        devgui::add_devgui_func( "<dev string:x64>", "<dev string:x7c>", &spawn_bgb_machine );
        devgui::add_devgui_func( "<dev string:x8e>", "<dev string:xae>", &function_ca59376f1844192d );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ztron_bgb_machine
    // Params 0
    // Checksum 0x83fd32cc, Offset: 0xa81
    // Size: 0x58, Type: dev
    function function_ca59376f1844192d()
    {
        if ( !isdefined( level.ztron.var_f8ed1f37b6e13f4c ) )
        {
            level.ztron.var_f8ed1f37b6e13f4c = 0;
        }
        
        level.ztron.var_f8ed1f37b6e13f4c = !level.ztron.var_f8ed1f37b6e13f4c;
    }

#/
