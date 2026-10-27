// scripts\mp\ob\skills\skill_permanent_self_revive.gsc  (hash_6f1bd7ed368e7ac6.gscc) (size: 3248 Bytes / 0xcb0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1297de4 (19496420)
// size ...... 3248 (0xcb0)
// includes .. 6   (offset: 0xc44)
// strings ... 3   (offset: 0xc74)
// dev strs .. 2   (offset: 0xc98)
// exports ... 11  (offset: 0x714)
// cseg ...... 0xc1 + 0x653 (0x714)
// imports ... 28  (offset: 0x8cc)
// animtree1 . 0   (offset: 0xcb0)
// animtree2 . 0   (offset: 0xcb0)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;

#namespace skill_permanent_self_revive;

// Namespace skill_permanent_self_revive
// Params 0, eflags: 0x1
// Checksum 0x64377a0c, Offset: 0xdf
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"permanent_self_revive", &init );
}

// Namespace skill_permanent_self_revive
// Params 0
// Checksum 0xd9440493, Offset: 0xfe
// Size: 0x3e
function init()
{
    utility::registersharedfunc( #"permanent_self_revive", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"permanent_self_revive", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_permanent_self_revive
// Params 1, eflags: 0x4
// Checksum 0x7c233b75, Offset: 0x144
// Size: 0x147, Type: bool
function private on_give_skill( skill_bundle )
{
    if ( !isdefined( self.var_66af610e777667ec ) )
    {
        self.var_66af610e777667ec = { #lastrarity:undefined, #var_618741acac419a71:0 };
    }
    
    var_da55798eb12048a0 = self.var_66af610e777667ec;
    var_da55798eb12048a0.bundle = skill_bundle;
    
    if ( var_da55798eb12048a0.lastrarity != skill_bundle.skilllevel && skill_bundle.var_d8659bb63e25f952 )
    {
        var_da55798eb12048a0.lastrarity = skill_bundle.skilllevel;
        var_da55798eb12048a0.var_618741acac419a71 = 0;
    }
    
    if ( !var_da55798eb12048a0.var_618741acac419a71 && skill_bundle.var_280eb79e76fb8b93 )
    {
        assert( !callback::exists( #"hash_652eb614ba902b3d", &function_76e86b709b51b4eb ) );
        callback::add( #"hash_652eb614ba902b3d", &function_76e86b709b51b4eb );
    }
    
    if ( skill_bundle.var_ed58dc69d6b26cae > 0 )
    {
        if ( skill_bundle.var_70f9a519c46cbc6 && !player::isinlaststand() )
        {
            function_9dbbbac58e79c319( skill_bundle.var_ed58dc69d6b26cae, skill_bundle.var_4295b500f23653e5 );
        }
        
        thread function_3539a4e23b7d01( skill_bundle );
    }
    
    return true;
}

// Namespace skill_permanent_self_revive
// Params 1, eflags: 0x4
// Checksum 0xc46fdc2b, Offset: 0x294
// Size: 0x83
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"stop_permanent_self_revive" );
    self.var_66af610e777667ec.bundle = undefined;
    
    if ( callback::exists( #"hash_652eb614ba902b3d", &function_76e86b709b51b4eb ) )
    {
        callback::remove( #"hash_652eb614ba902b3d", &function_76e86b709b51b4eb );
    }
    
    if ( callback::exists( #"player_damaged", &player_damage_callback ) )
    {
        callback::remove( #"player_damaged", &player_damage_callback );
    }
}

// Namespace skill_permanent_self_revive
// Params 1, eflags: 0x4
// Checksum 0x374aecb8, Offset: 0x31f
// Size: 0x16f
function private function_3539a4e23b7d01( skill_bundle )
{
    self endon( #"stop_permanent_self_revive" );
    self endon( #"disconnect" );
    
    if ( !skill_bundle.var_ed58dc69d6b26cae )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    var_6a20c6eb922a4f7d = skill_bundle.var_ed58dc69d6b26cae;
    recharge_time = skill_bundle.var_8e44c3778fab7363;
    item_spawn_entry = skill_bundle.var_4295b500f23653e5;
    childthread function_8137337548bbee5();
    
    while ( true )
    {
        if ( !laststand::hasselfrevivetoken() )
        {
            var_2f8d0f8b5f8e54d5 = gettime();
            var_3031a47e1bb17ee2 = recharge_time;
            
            while ( var_3031a47e1bb17ee2 > 0 )
            {
                msg = utility::waittill_any_in_array_or_timeout( [ "skill_pick_up_self_revive_kit", "last_stand_enter" ], var_3031a47e1bb17ee2 );
                
                switch ( msg )
                {
                    case #"hash_901cfdf0703dc8f0":
                    case #"hash_d4dde12b38318c68":
                        var_3031a47e1bb17ee2 = 0;
                        break;
                    case #"hash_ec32e45981a4acef":
                        var_3031a47e1bb17ee2 -= ( gettime() - var_2f8d0f8b5f8e54d5 ) * 0.001;
                        self waittill( #"last_stand_exit" );
                        var_2f8d0f8b5f8e54d5 = gettime();
                        break;
                    default:
                        assertmsg( "<dev string:x84>" + msg );
                        break;
                }
            }
            
            function_9dbbbac58e79c319( var_6a20c6eb922a4f7d, item_spawn_entry );
        }
        
        wait 0.5;
    }
}

// Namespace skill_permanent_self_revive
// Params 2, eflags: 0x4
// Checksum 0x7ab19e04, Offset: 0x496
// Size: 0x32
function private function_9dbbbac58e79c319( var_6a20c6eb922a4f7d, item_spawn_entry )
{
    if ( !laststand::hasselfrevivetoken() )
    {
        laststand::function_39844c1e879cc048( var_6a20c6eb922a4f7d );
        thread function_bdb79f977770a2b8( item_spawn_entry, var_6a20c6eb922a4f7d );
    }
}

// Namespace skill_permanent_self_revive
// Params 0, eflags: 0x4
// Checksum 0x6a43ee12, Offset: 0x4d0
// Size: 0x20
function private function_8137337548bbee5()
{
    while ( true )
    {
        if ( laststand::hasselfrevivetoken() )
        {
            self notify( #"skill_pick_up_self_revive_kit" );
        }
        
        waitframe();
    }
}

// Namespace skill_permanent_self_revive
// Params 2, eflags: 0x4
// Checksum 0x65c1bdb7, Offset: 0x4f8
// Size: 0x32
function private function_bdb79f977770a2b8( item_spawn_entry, var_6a20c6eb922a4f7d )
{
    var_3c62c451ce8767f8 = getscriptbundle( item_spawn_entry );
    common_item::function_2e0436a8625e3515( var_3c62c451ce8767f8, var_6a20c6eb922a4f7d, undefined );
}

// Namespace skill_permanent_self_revive
// Params 1, eflags: 0x4
// Checksum 0xcf596172, Offset: 0x532
// Size: 0xb8
function private function_76e86b709b51b4eb( params )
{
    if ( self.health - params.idamage > 0 )
    {
        return;
    }
    
    params.idamage = self.health - 1;
    assert( !callback::exists( #"player_damaged", &player_damage_callback ) );
    callback::add( #"player_damaged", &player_damage_callback );
    self.var_66af610e777667ec.var_618741acac419a71 = 1;
    assert( callback::exists( #"hash_652eb614ba902b3d", &function_76e86b709b51b4eb ) );
    callback::remove( #"hash_652eb614ba902b3d", &function_76e86b709b51b4eb );
}

// Namespace skill_permanent_self_revive
// Params 1, eflags: 0x4
// Checksum 0x880f151f, Offset: 0x5f2
// Size: 0x122
function private player_damage_callback( params )
{
    bundle = self.var_66af610e777667ec.bundle;
    
    if ( bundle.var_eac72a1cd79e6d2e > 0 )
    {
        invulnerability_data = { #duration:bundle.var_eac72a1cd79e6d2e, #scriptable_state_off:bundle.var_f9bd997663f4b027, #scriptable_state_on:bundle.var_4e8f005955351cc3, #scriptable_part:bundle.var_68d6cc4b29d19d00, #id:"permanent_self_revive_invulnerability" };
        thread utility::callsharedfunc( #"skills", #"apply_invulnerability", invulnerability_data );
    }
    
    if ( bundle.var_aa024dc9bc7a8c5c > 0 )
    {
        self.health = int( self.maxhealth * bundle.var_aa024dc9bc7a8c5c );
    }
    
    assert( callback::exists( #"player_damaged", &player_damage_callback ) );
    callback::remove( #"player_damaged", &player_damage_callback );
}

