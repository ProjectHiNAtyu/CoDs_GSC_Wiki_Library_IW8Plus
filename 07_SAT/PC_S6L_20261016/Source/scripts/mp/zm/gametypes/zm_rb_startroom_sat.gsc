// scripts\mp\zm\gametypes\zm_rb_startroom_sat.gsc  (hash_6c949ab597646715.gscc) (size: 6792 Bytes / 0x1a88 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x25f7a0fc (636985596)
// size ...... 6792 (0x1a88)
// includes .. 6   (offset: 0x1964)
// strings ... 16  (offset: 0x1994)
// dev strs .. 2   (offset: 0x1a70)
// exports ... 11  (offset: 0x134c)
// cseg ...... 0x16b + 0x11e1 (0x134c)
// imports ... 30  (offset: 0x1504)
// animtree1 . 0   (offset: 0x1a88)
// animtree2 . 0   (offset: 0x1a88)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\hud_message;
#using scripts\mp\zm\gametypes\zm_rb;
#using scripts\mp\zm\systems\zone_manager;

#namespace zm_rb_startroom_sat;

// Namespace zm_rb_startroom_sat
// Params 0, eflags: 0x5
// Checksum 0x1fcd7a74, Offset: 0x189
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_rb_startroom_sat", undefined, &pre_main, &post_main );
}

// Namespace zm_rb_startroom_sat
// Params 0
// Checksum 0x170368cf, Offset: 0x1ae
// Size: 0x24
function main()
{
    if ( !is_mode_startroom() )
    {
        return;
    }
    
    zm_rb::main();
    level thread intro_sequence();
    level thread function_49f9310474109401();
}

// Namespace zm_rb_startroom_sat
// Params 0, eflags: 0x4
// Checksum 0xa2f89aa0, Offset: 0x1da
// Size: 0x51
function private pre_main()
{
    if ( !is_mode_startroom() )
    {
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x24>" );
    #/
    
    level.livingworld_disabled = 1;
    level.disable_fasttravel = 1;
    level.var_96d4f8dc0c3cfea3 = 1;
    level.disable_zm_exfil = 1;
    level.var_9317e385dbcadec8 = 1;
}

// Namespace zm_rb_startroom_sat
// Params 0, eflags: 0x4
// Checksum 0x9c8ec67e, Offset: 0x233
// Size: 0x25
function private post_main()
{
    if ( !is_mode_startroom() )
    {
        return;
    }
    
    /#
        iprintlnbold( "<dev string:x3e>" );
    #/
    
    level.var_5542fc8f8eafa0c0 = 1;
}

// Namespace zm_rb_startroom_sat
// Params 0
// Checksum 0x4fe99abb, Offset: 0x260
// Size: 0xe, Type: bool
function is_mode_startroom()
{
    return game_utility::getgametype() == "zm_rb_startroom";
}

// Namespace zm_rb_startroom_sat
// Params 0, eflags: 0x4
// Checksum 0x12db80e0, Offset: 0x277
// Size: 0x91
function private intro_sequence()
{
    level utility::flag_wait( "begin_round_logic" );
    
    foreach ( player in level.players )
    {
        player thread hud_message::showsplash( #"zm_rb_startroom_sat" );
    }
}

// Namespace zm_rb_startroom_sat
// Params 0
// Checksum 0x29b40ab, Offset: 0x310
// Size: 0xa
function function_7ff4cf75757ec51()
{
    level thread function_49f9310474109401();
}

// Namespace zm_rb_startroom_sat
// Params 0, eflags: 0x4
// Checksum 0x2d582268, Offset: 0x322
// Size: 0xfbd
function private function_49f9310474109401()
{
    utility::flag_wait( "begin_round_logic" );
    
    if ( !level.gametypebundle.var_72ac15a3b4f37f80 )
    {
        var_609b50508c1ded90 = getentarray( "trial_col", #targetname );
        
        foreach ( col in var_609b50508c1ded90 )
        {
            col connectpaths();
            col delete();
        }
    }
    
    wait 2;
    
    foreach ( s_ammo_cache in level._ammo_cache_info.var_ea07e36d8fd28578 )
    {
        if ( isent( s_ammo_cache.mdl_ammo_cache ) && !is_inside_enabled_zone( s_ammo_cache.mdl_ammo_cache.origin ) )
        {
            s_ammo_cache.mdl_ammo_cache delete();
            
            if ( isdefined( s_ammo_cache.ammocache_trigger ) )
            {
                s_ammo_cache.ammocache_trigger freescriptable();
            }
        }
        
        if ( s_ammo_cache.ammocache_trigger isscriptableinstance() && !is_inside_enabled_zone( s_ammo_cache.ammocache_trigger.var_a3338cc37b82b7b3.origin ) )
        {
            s_ammo_cache.ammocache_trigger notify( #"death" );
            s_ammo_cache.ammocache_trigger freescriptable();
        }
    }
    
    foreach ( s_arsenal in level.var_52e94a468e66d601 )
    {
        if ( level.var_14327a33af94412c )
        {
            continue;
        }
        
        if ( isdefined( s_arsenal.script_index ) )
        {
            continue;
        }
        
        if ( isent( s_arsenal.mdl_arsenal ) && !is_inside_enabled_zone( s_arsenal.mdl_arsenal.origin ) )
        {
            s_arsenal.mdl_arsenal delete();
        }
    }
    
    foreach ( s_bgb_machine in level.var_e0910c7bd4aab6fc )
    {
        if ( isdefined( s_bgb_machine.script_index ) )
        {
            continue;
        }
        
        if ( isdefined( s_bgb_machine.mdl_bgb_machine ) && !is_inside_enabled_zone( s_bgb_machine.mdl_bgb_machine.origin ) )
        {
            s_bgb_machine.mdl_bgb_machine notify( #"death" );
            s_bgb_machine.mdl_bgb_machine freescriptable();
        }
    }
    
    foreach ( s_crafting_table in level.a_s_crafting_tables )
    {
        if ( isdefined( s_crafting_table.script_index ) )
        {
            continue;
        }
        
        if ( isent( s_crafting_table.var_7fac639c5e7fd54 ) && !is_inside_enabled_zone( s_crafting_table.var_7fac639c5e7fd54.origin ) )
        {
            s_crafting_table.var_7fac639c5e7fd54 delete();
        }
    }
    
    a_s_fasttravel_triggers = utility::getstructarray( "fasttravel_trigger", "targetname" );
    
    foreach ( s_fasttravel_trigger in a_s_fasttravel_triggers )
    {
        if ( isdefined( s_fasttravel_trigger.fasttravel_scr ) )
        {
            s_fasttravel_trigger.fasttravel_scr utility::function_7c10ea82c1e305b8( "icon", "idle" );
        }
    }
    
    var_49d6c64734275078 = utility::getstructarray( "zm_fasttravel", "targetname" );
    
    foreach ( s_fasttravel_trigger in var_49d6c64734275078 )
    {
        if ( isdefined( s_fasttravel_trigger.fasttravel_scr ) )
        {
            s_fasttravel_trigger.fasttravel_scr utility::function_7c10ea82c1e305b8( "icon", "idle" );
            s_fasttravel_trigger.fasttravel_scr freescriptable();
        }
    }
    
    a_jumppads = getentitylessscriptablearray( "zm_jumppad", #targetname );
    
    foreach ( jumppad in a_jumppads )
    {
        jumppad utility::function_7c10ea82c1e305b8( "ping", "off" );
    }
    
    foreach ( var_349a0723ed9ac19c in level.var_1bbb5557537e2c0c )
    {
        if ( isdefined( var_349a0723ed9ac19c.script_index ) )
        {
            continue;
        }
        
        if ( isent( var_349a0723ed9ac19c.mdl_magicbox ) && !is_inside_enabled_zone( var_349a0723ed9ac19c.mdl_magicbox.origin ) )
        {
            var_349a0723ed9ac19c.mdl_magicbox delete();
        }
    }
    
    var_a95a46535e73530d = [];
    
    for ( i = 0; i < level.var_1bbb5557537e2c0c.size ; i++ )
    {
        if ( level.var_1bbb5557537e2c0c[ i ].mdl_magicbox )
        {
            var_a95a46535e73530d[ var_a95a46535e73530d.size ] = level.var_1bbb5557537e2c0c[ i ];
        }
    }
    
    level.var_1bbb5557537e2c0c = var_a95a46535e73530d;
    
    if ( level.var_1bbb5557537e2c0c.size )
    {
        level.var_e0e84452fe117b5f[ level.var_1bbb5557537e2c0c[ 0 ].var_93e4a0a8514ca47e ] = level.var_1bbb5557537e2c0c;
    }
    
    foreach ( s_pap_location in level.var_db52bcfd04d45a7a )
    {
        if ( isdefined( s_pap_location.script_index ) )
        {
            continue;
        }
        
        if ( isent( s_pap_location.var_370acb837a3a86c3 ) && !is_inside_enabled_zone( s_pap_location.var_370acb837a3a86c3.origin ) )
        {
            s_pap_location.var_370acb837a3a86c3 delete();
        }
    }
    
    foreach ( s_perk_machine in level.a_s_perk_machines )
    {
        if ( isdefined( s_perk_machine.script_index ) || s_perk_machine.is_wunderfizz )
        {
            continue;
        }
        
        if ( isdefined( s_perk_machine.mdl_perk_machine ) && ( isent( s_perk_machine.mdl_perk_machine ) || s_perk_machine.mdl_perk_machine isscriptableinstance() ) && !is_inside_enabled_zone( s_perk_machine.mdl_perk_machine.origin ) )
        {
            if ( isdefined( s_perk_machine.mdl_perk_machine.jingle_trigger ) )
            {
                s_perk_machine.mdl_perk_machine.jingle_trigger delete();
            }
            
            if ( isent( s_perk_machine.mdl_perk_machine ) )
            {
                s_perk_machine.mdl_perk_machine delete();
                continue;
            }
            
            s_perk_machine.mdl_perk_machine notify( #"death" );
            s_perk_machine.mdl_perk_machine freescriptable();
        }
    }
    
    foreach ( var_f5d93163bb80f7b in level.var_f301c0b95ea728e2 )
    {
        if ( isarray( var_f5d93163bb80f7b.a_switch_pos ) )
        {
            foreach ( s_trap_switch in var_f5d93163bb80f7b.a_switch_pos )
            {
                if ( isdefined( s_trap_switch.interact ) && !is_inside_enabled_zone( s_trap_switch.interact.origin ) )
                {
                    s_trap_switch.interact notify( #"death" );
                    s_trap_switch.interact freescriptable();
                    
                    if ( isdefined( var_f5d93163bb80f7b.my_generator ) )
                    {
                        var_f5d93163bb80f7b.my_generator notify( #"death" );
                        var_f5d93163bb80f7b.my_generator freescriptable();
                    }
                }
                
                if ( isdefined( s_trap_switch.switch_scriptable ) && !is_inside_enabled_zone( s_trap_switch.switch_scriptable.origin ) )
                {
                    s_trap_switch.switch_scriptable notify( #"death" );
                    s_trap_switch.switch_scriptable freescriptable();
                }
                
                if ( isdefined( s_trap_switch.child_scriptable ) && !is_inside_enabled_zone( s_trap_switch.child_scriptable.origin ) )
                {
                    s_trap_switch.child_scriptable notify( #"death" );
                    s_trap_switch.child_scriptable freescriptable();
                }
            }
        }
        
        if ( isarray( var_f5d93163bb80f7b.trap_positions ) )
        {
            foreach ( trap_position in var_f5d93163bb80f7b.trap_positions )
            {
                if ( isent( trap_position.trap_scriptable ) && !is_inside_enabled_zone( trap_position.trap_scriptable.origin ) )
                {
                    trap_position.trap_scriptable delete();
                }
            }
        }
        
        if ( isarray( var_f5d93163bb80f7b.var_8f7b30ae6520029c ) )
        {
            foreach ( minimap_icon in var_f5d93163bb80f7b.var_8f7b30ae6520029c )
            {
                if ( isdefined( minimap_icon ) && minimap_icon isscriptableinstance() && !is_inside_enabled_zone( minimap_icon.origin ) )
                {
                    minimap_icon notify( #"death" );
                    minimap_icon freescriptable();
                }
            }
        }
    }
    
    foreach ( s_wallbuy_location in level.var_caf65b937e9cbfaf )
    {
        if ( isdefined( s_wallbuy_location.script_index ) )
        {
            continue;
        }
        
        if ( isdefined( s_wallbuy_location.wallbuy_scriptable ) )
        {
            offset = ( 30, 0, 0 );
            var_d226408b94784d5d = s_wallbuy_location.wallbuy_scriptable.origin + offset;
            
            if ( !is_inside_enabled_zone( var_d226408b94784d5d ) )
            {
                s_wallbuy_location.wallbuy_scriptable notify( #"death" );
                s_wallbuy_location.wallbuy_scriptable freescriptable();
            }
        }
    }
    
    ascender_scriptables = getscriptablearray( "zm_forcefield_ziplines", #script_noteworthy );
    
    foreach ( ascender in ascender_scriptables )
    {
        utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", ascender, "icon", 0 );
        ascender utility::function_7c10ea82c1e305b8( "icon", "hide" );
    }
    
    ascenderarray = getentitylessscriptablearray( "scriptable_military_ascendertop_heavy_zm", #classname );
    
    foreach ( ascender in ascenderarray )
    {
        ascender setscriptablepartstate( "top", "off" );
    }
    
    logstring( "===ZM StartRoom Cleanup Unused Done" );
}

// Namespace zm_rb_startroom_sat
// Params 1, eflags: 0x4
// Checksum 0xbf807afa, Offset: 0x12e7
// Size: 0x58, Type: bool
function private is_inside_enabled_zone( v_origin )
{
    var_bdac635eb0c0d708 = zone_manager::function_65305a611c6226d9( v_origin );
    var_f8605bb88feff187 = getclosestpointonnavmesh( v_origin );
    var_6dc0e7f9e86600f7 = isdefined( var_f8605bb88feff187 ) && zone_manager::function_65305a611c6226d9( var_f8605bb88feff187 );
    
    if ( var_bdac635eb0c0d708 || var_6dc0e7f9e86600f7 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_rb_startroom_sat
// Params 0, eflags: 0x4
// Checksum 0x2ce13f35, Offset: 0x1348
// Size: 0x3, Type: bool
function private function_b045395aa92f278a()
{
    return false;
}

