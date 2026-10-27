// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_intel.gsc  (hash_0d5975b0ee86e0f6.gscc) (size: 5087 Bytes / 0x13df / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x42907e15 (1116765717)
// size ...... 5087 (0x13df)
// includes .. 8   (offset: 0x1253)
// strings ... 24  (offset: 0x1293)
// dev strs .. 1   (offset: 0x13d3)
// exports ... 12  (offset: 0xaef)
// cseg ...... 0x294 + 0x85b (0xaef)
// imports ... 49  (offset: 0xccf)
// animtree1 . 0   (offset: 0x13df)
// animtree2 . 0   (offset: 0x13df)
#using scripts\common\callbacks;
#using scripts\common\intel;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\interaction;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zombie_intel;

#namespace zm_sat_hornet_intel;

// Namespace zm_sat_hornet_intel
// Params 0, eflags: 0x5
// Checksum 0x48504ad1, Offset: 0x2b2
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_7df2547849f0cba", undefined, &__init__, undefined );
}

// Namespace zm_sat_hornet_intel
// Params 0
// Checksum 0xc96c7620, Offset: 0x2d3
// Size: 0x1d
function __init__()
{
    if ( !getdvarint( @"hash_a848de4270c1778d", 0 ) )
    {
        return;
    }
    
    level thread intel_setup();
}

// Namespace zm_sat_hornet_intel
// Params 0
// Checksum 0xef191a94, Offset: 0x2f8
// Size: 0xdc
function intel_setup()
{
    level.hornet_intel = spawnstruct();
    level utility::flag_wait( "scriptables_ready" );
    level utility::flag_wait( "zm_sat_hornet_intel_create_script_completed" );
    zm_save::function_1f44a48caae2acbf();
    level.hornet_intel.scroll_stack = spawnscriptable( "zmintel_sat_scroll_stack", utility::getstruct( "hornet_scroll_stack" ).origin, utility::getstruct( "hornet_scroll_stack" ).angles );
    scriptable::scriptable_adddamagedcallback( &scrolls_shot );
    setup_barrel_interacts();
    level utility::flag_wait( "begin_round_logic" );
    
    if ( !intel::function_1ba3132f2aafe8cc( "zmintel_sat_hornet_audiolog_10" ) || !intel::function_1ba3132f2aafe8cc( "zmintel_sat_hornet_audiolog_11" ) )
    {
        level thread setup_pizza_watcher();
        level thread function_c9a98a40d5396bc9();
    }
    
    level callback::add( #"item_weapon_picked_up", &on_sword_picked_up );
}

// Namespace zm_sat_hornet_intel
// Params 0, eflags: 0x4
// Checksum 0xb43da35a, Offset: 0x3dc
// Size: 0x195
function private setup_pizza_watcher()
{
    level endon( #"game_ended" );
    var_1c28dc4b540b3d = utility::getstruct( "hornet_audiolog_10_landing", "targetname" );
    approached = 0;
    
    while ( approached == 0 )
    {
        foreach ( player in level.players )
        {
            if ( distance2dsquared( player.origin, var_1c28dc4b540b3d.origin ) < 40000 && approached == 0 )
            {
                approached = 1;
                pizza = intel::spawn_intel_at_location( undefined, undefined, var_1c28dc4b540b3d.origin + ( 0, 0, 50 ), var_1c28dc4b540b3d.angles, "zmintel_sat_hornet_audiolog_10", undefined, 1 );
                
                foreach ( pizza_mdl in pizza.a_mdl_intel )
                {
                    pizza_mdl thread pizza_fling( var_1c28dc4b540b3d );
                }
            }
        }
        
        wait 1;
    }
}

// Namespace zm_sat_hornet_intel
// Params 1, eflags: 0x4
// Checksum 0xf80be606, Offset: 0x579
// Size: 0xea
function private pizza_fling( var_1c28dc4b540b3d )
{
    pizza_mdl = self;
    v_offset = ( 0, 0, pizza_mdl.owningplayer getentitynumber() / 3 );
    pizza_mdl.pizza_mover = utility::spawn_model( "tag_origin", pizza_mdl.origin, pizza_mdl.angles );
    pizza_mdl utility::scriptable_setparententity( pizza_mdl.pizza_mover );
    pizza_mdl.pizza_mover moveto( var_1c28dc4b540b3d.origin + v_offset, 0.5, 0.5 );
    pizza_mdl.pizza_mover waittill( #"movedone" );
    pizza_mdl utility::scriptable_clearparententity();
    pizza_mdl.pizza_mover delete();
    pizza_mdl function_7653c765b6c7b815();
    pizza_mdl enablescriptableplayeruse( pizza_mdl.owningplayer );
}

// Namespace zm_sat_hornet_intel
// Params 0, eflags: 0x4
// Checksum 0x29176ae4, Offset: 0x66b
// Size: 0x5e
function private function_c9a98a40d5396bc9()
{
    level endon( #"game_ended" );
    
    for ( pizza_played = 0; !pizza_played ; pizza_played = 1 )
    {
        level waittill( #"intel_played", str_intel_name );
        
        if ( str_intel_name == "zmintel_sat_hornet_audiolog_10" )
        {
            intel::spawn_intel_at_location( undefined, "zmintel_sat_hornet_audiolog_11", undefined, undefined, "zmintel_sat_hornet_audiolog_11" );
        }
    }
}

// Namespace zm_sat_hornet_intel
// Params 11, eflags: 0x4
// Checksum 0x6e47e5c8, Offset: 0x6d1
// Size: 0xc1
function private scrolls_shot( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( isdefined( instance ) && instance getscriptablehaspart( "intel_paper_stack_base" ) )
    {
        if ( instance getscriptablepartstate( "intel_paper_stack_base" ) == "intact" )
        {
            instance setscriptablepartstate( "intel_paper_stack_base", "destroyed" );
            scriptable::function_dc174fecebb79952( &scrolls_shot );
            waitframe();
            intel::spawn_intel_at_location( undefined, "hornet_scroll_stack", undefined, undefined, "zmintel_sat_hornet_document_8" );
        }
    }
}

// Namespace zm_sat_hornet_intel
// Params 0, eflags: 0x4
// Checksum 0xd92e3be3, Offset: 0x79a
// Size: 0xfe
function private setup_barrel_interacts()
{
    var_18fc57057b665d50 = utility::getstructarray( "hornet_document6_interact" );
    level.hornet_intel.unchecked_interacts = var_18fc57057b665d50.size;
    
    foreach ( barrel_interact_struct in var_18fc57057b665d50 )
    {
        barrel_interact = spawnscriptable( "firefly_hay_bale_intel_interact", barrel_interact_struct.origin );
        
        if ( isdefined( barrel_interact_struct.script_noteworthy ) )
        {
            barrel_interact.s_landing = utility::getstruct( barrel_interact_struct.script_noteworthy );
        }
        
        barrel_interact = interaction::register_scriptable_interact( barrel_interact, &function_c7b131ba4dc3b573 );
        barrel_interact interaction::set_interact_hint_callback( &barrel_interact_hint );
    }
}

// Namespace zm_sat_hornet_intel
// Params 2, eflags: 0x4
// Checksum 0xc58c2add, Offset: 0x8a0
// Size: 0x40
function private barrel_interact_hint( usable, player )
{
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace zm_sat_hornet_intel
// Params 1, eflags: 0x4
// Checksum 0xc8a61278, Offset: 0x8e9
// Size: 0x19e
function private function_c7b131ba4dc3b573( player )
{
    self setscriptablepartstate( "base", "off" );
    playsoundatpos( self.origin, "evt_bloodstone_bookshelf_interact" );
    
    if ( level.hornet_intel.unchecked_interacts < 1 )
    {
        return;
    }
    
    if ( randomint( level.hornet_intel.unchecked_interacts ) == 0 )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        v_landing = isdefined( self.s_landing ) ? self.s_landing.origin : player.origin;
        s_intel = intel::spawn_intel_at_location( undefined, undefined, self.origin, self.angles, "zmintel_sat_hornet_document_6", v_landing );
        level.hornet_intel.unchecked_interacts = 0;
        wait 0.6;
        
        if ( isdefined( s_intel.mdl_intel ) && !isdefined( self.s_landing.origin ) )
        {
            v_ground = getgroundposition( s_intel.mdl_intel.origin, 8 );
            
            if ( !isdefined( v_ground ) )
            {
                v_ground = s_intel.mdl_intel.origin;
            }
            
            s_intel.mdl_intel.origin = v_ground + ( 0, 0, 2 );
        }
    }
    else
    {
        level.hornet_intel.unchecked_interacts--;
    }
    
    self freescriptable();
}

// Namespace zm_sat_hornet_intel
// Params 1, eflags: 0x4
// Checksum 0x52811886, Offset: 0xa8f
// Size: 0x60
function private on_sword_picked_up( params )
{
    if ( issubstr( params.item.customweaponname, "me_elnath" ) && params.loot_source != "magicbox" )
    {
        utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_hornet_artifact_6" );
    }
}

