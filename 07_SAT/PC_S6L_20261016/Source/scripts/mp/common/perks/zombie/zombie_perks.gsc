// scripts\mp\common\perks\zombie\zombie_perks.gsc  (hash_25a8fa2ac8997425.gscc) (size: 23232 Bytes / 0x5ac0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5476f8a9 (1417083049)
// size ...... 23232 (0x5ac0)
// includes .. 10  (offset: 0x56d8)
// strings ... 31  (offset: 0x5728)
// dev strs .. 27  (offset: 0x5950)
// exports ... 51  (offset: 0x3e94)
// cseg ...... 0x331 + 0x3b63 (0x3e94)
// imports ... 124 (offset: 0x468c)
// animtree1 . 0   (offset: 0x5ac0)
// animtree2 . 0   (offset: 0x5ac0)
#using scripts\anim\utility;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\hud_message;

#namespace zombie_perks;

// Namespace zombie_perks
// Params 0, eflags: 0x5
// Checksum 0x6a426801, Offset: 0x34f
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_e7a7d049d5f06935", undefined, &__init__, undefined );
}

// Namespace zombie_perks
// Params 0
// Checksum 0x5c6658a0, Offset: 0x370
// Size: 0xa
function __init__()
{
    level thread function_a7f55ef03fd9e872();
}

// Namespace zombie_perks
// Params 0
// Checksum 0xae74155c, Offset: 0x382
// Size: 0x1ec
function function_a7f55ef03fd9e872()
{
    if ( !level.zombie_perks_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    level._custom_perks = [];
    level.var_f72357c3d3ad7cfe = [];
    level.var_c56bbb377ee1e7fc = [];
    var_21c674d734b113dd = 1;
    
    foreach ( ref, bundle in level.perkbundles )
    {
        if ( bundle.zombiesperk )
        {
            level.var_c56bbb377ee1e7fc[ ref ] = var_21c674d734b113dd;
            var_21c674d734b113dd++;
        }
    }
    
    level.has_perk_decay = 1;
    utility::registersharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", &has_perk );
    utility::registersharedfunc( #"hash_e7a7d049d5f06935", #"hash_899320e73bb1d103", &take_perk );
    utility::registersharedfunc( #"loot_perks", #"hash_ab5f9559e80fdb52", &grab_and_use_perk );
    utility::registersharedfunc( #"loot_perks", #"hash_2041bc8577e77110", &has_perk );
    utility::registersharedfunc( #"loot_perks", #"hash_d60bebeaed508539", &give_perk );
    callback::add( #"player_connect", &on_player_connect_perks );
    callback::add( #"player_spawned", &on_player_spawned_perks );
    callback::add( #"player_laststand_revived", &on_player_revived_perks );
    callback::add( #"player_laststand", &on_player_laststand_perks );
    level function_a08d7c9af61a2dcc();
    level utility::flag_set( "zombie_perks_init_complete" );
}

// Namespace zombie_perks
// Params 1
// Checksum 0x4078e546, Offset: 0x576
// Size: 0x335
function function_c1932de316c8f0be( perk_basic_info )
{
    if ( !isdefined( perk_basic_info ) )
    {
        return;
    }
    
    assert( isdefined( perk_basic_info.str_perk ), "<dev string:x24>" );
    assert( isdefined( perk_basic_info.var_7c0c0569bf2695fb ), "<dev string:x62>" );
    assert( isdefined( perk_basic_info.str_name ), "<dev string:xa3>" );
    assert( isdefined( perk_basic_info.var_ed466fad37317edc ), "<dev string:xe1>" );
    assert( isdefined( perk_basic_info.var_1009baca629198b2 ), "<dev string:x126>" );
    assert( isdefined( perk_basic_info.str_scriptable ), "<dev string:x170>" );
    assert( isdefined( perk_basic_info.str_perk_root ), "<dev string:x1b4>" );
    str_perk = perk_basic_info.str_perk;
    function_e9e75691f2e27376( str_perk );
    
    if ( !isdefined( level.var_d942db4d2fbe72cd ) )
    {
        level.var_d942db4d2fbe72cd = [];
    }
    
    level._custom_perks[ str_perk ].cost = perk_basic_info.var_7c0c0569bf2695fb;
    level._custom_perks[ str_perk ].icon = perk_basic_info.perk_icon;
    level._custom_perks[ str_perk ].hint_name = perk_basic_info.str_name;
    level._custom_perks[ str_perk ].hint_description = perk_basic_info.var_ed466fad37317edc;
    level._custom_perks[ str_perk ].perk_bottle_weapon = perk_basic_info.var_1009baca629198b2;
    level._custom_perks[ str_perk ].str_scriptable = perk_basic_info.str_scriptable;
    level._custom_perks[ str_perk ].str_perk_root = perk_basic_info.str_perk_root;
    level._custom_perks[ str_perk ].str_override_model = perk_basic_info.str_override_model;
    level._custom_perks[ str_perk ].var_e3df6d7fa3297958 = perk_basic_info.var_e3df6d7fa3297958;
    level._custom_perks[ str_perk ].var_f318fc61c4702480 = perk_basic_info.var_f318fc61c4702480;
    level._custom_perks[ str_perk ].hint_old = perk_basic_info.old_interact;
    level._custom_perks[ str_perk ].buy_description = perk_basic_info.buy_description;
    level._custom_perks[ str_perk ].var_1d1a3ad5cd2c2ea2 = perk_basic_info.var_1d1a3ad5cd2c2ea2;
    level._custom_perks[ str_perk ].machine_radius = perk_basic_info.machine_radius;
    level.var_d942db4d2fbe72cd[ level.var_d942db4d2fbe72cd.size ] = str_perk;
    
    if ( !isdefined( level.var_5a33ebad6fe41239 ) )
    {
        level.var_5a33ebad6fe41239 = [];
    }
    
    level.var_5a33ebad6fe41239 = arraycombineunique( level.var_5a33ebad6fe41239, [ str_perk ] );
    
    if ( !isdefined( level.var_a9f48d085f4e545e ) )
    {
        level.var_a9f48d085f4e545e = [];
    }
}

// Namespace zombie_perks
// Params 3
// Checksum 0xf72e151b, Offset: 0x8b3
// Size: 0x77
function function_4d7b4235bcf3f0de( str_perk, var_95541001c4600ddd, var_3edddfa4fd90f1f3 )
{
    assert( isdefined( str_perk ), "<dev string:x1f7>" );
    assert( isdefined( var_95541001c4600ddd ), "<dev string:x232>" );
    function_e9e75691f2e27376( str_perk );
    level._custom_perks[ str_perk ].var_4814a425403617fc = var_95541001c4600ddd;
    level._custom_perks[ str_perk ].var_ea841983b8ea39f6 = var_3edddfa4fd90f1f3;
}

// Namespace zombie_perks
// Params 7
// Checksum 0xf6ea9642, Offset: 0x932
// Size: 0x24d
function enable_perk_for_level( perk_root_name, str_currency, var_fcb7626c79b3c98f, var_95541001c4600ddd, var_3edddfa4fd90f1f3, var_e3df6d7fa3297958, var_f318fc61c4702480 )
{
    utility::flag_wait( "StartGameTypeCallbackFinished" );
    assert( isarray( level.perkbundles ), "<dev string:x27a>" );
    perkbundle = level.perkbundles[ perk_root_name ];
    var_cc3b8b2986475e0b = perk_root_name;
    
    if ( str_currency == #"essence" )
    {
        str_name = perkbundle.name;
        var_ed466fad37317edc = perkbundle.description;
    }
    else
    {
        str_name = perkbundle.var_4f05ecd6a02ee78c;
        var_ed466fad37317edc = perkbundle.var_4f05ecd6a02ee78c;
    }
    
    var_105ea7ecea7528fb = perkbundle.var_ccd5d2ff97067631 ?? undefined;
    reg_n_perk_cost = var_fcb7626c79b3c98f ?? perkbundle.var_1562b134ce48852e;
    var_5624a876249a6137 = var_e3df6d7fa3297958 ?? 1;
    var_16105cfc620b99b9 = perkbundle.var_8cded1959bcc76fd ?? undefined;
    perk_basic_info = { #machine_radius:perkbundle.var_667beab25a3a0de2, #var_1d1a3ad5cd2c2ea2:var_16105cfc620b99b9, #buy_description:perkbundle.var_e77b4be2fc4d857f, #old_interact:perkbundle.var_4f05ecd6a02ee78c, #var_f318fc61c4702480:var_f318fc61c4702480, #var_e3df6d7fa3297958:var_5624a876249a6137, #str_override_model:var_105ea7ecea7528fb, #str_perk_root:var_cc3b8b2986475e0b, #str_scriptable:perkbundle.var_1677a2204cef6d98, #var_1009baca629198b2:perkbundle.var_1a348a17b394fca6, #var_ed466fad37317edc:var_ed466fad37317edc, #str_name:str_name, #var_7c0c0569bf2695fb:reg_n_perk_cost, #perk_icon:perkbundle.var_69153ceadb17e6a3, #var_a21f9b61147c35b6:perkbundle.var_cc0131d8a5bbd88e, #str_perk:var_cc3b8b2986475e0b };
    function_c1932de316c8f0be( perk_basic_info );
    function_4d7b4235bcf3f0de( var_cc3b8b2986475e0b, var_95541001c4600ddd, var_3edddfa4fd90f1f3 );
}

// Namespace zombie_perks
// Params 1
// Checksum 0xb17344e7, Offset: 0xb87
// Size: 0x42
function function_e9e75691f2e27376( str_perk )
{
    if ( !isdefined( level._custom_perks ) )
    {
        level._custom_perks = [];
    }
    
    if ( !isdefined( level._custom_perks[ str_perk ] ) )
    {
        level._custom_perks[ str_perk ] = spawnstruct();
    }
}

// Namespace zombie_perks
// Params 1
// Checksum 0x299e4523, Offset: 0xbd1
// Size: 0x4f
function on_player_connect_perks( params )
{
    self.perks_active = [];
    self.var_a0c63f8db21c605b = [];
    self.var_f1650ed763b03141 = [];
    self.var_95fc78a1af2f14a7 = 0;
    
    if ( !level.zombie_perks_in_use )
    {
        return;
    }
    
    j = 0;
}

// Namespace zombie_perks
// Params 1
// Checksum 0x194884f7, Offset: 0xc28
// Size: 0x235
function on_player_spawned_perks( params )
{
    /#
        if ( level._custom_perks.size && !level._custom_perks_ignore )
        {
            self endon( #"death" );
            str_player_name = self.name;
            keys = getarraykeys( level._custom_perks );
            
            foreach ( key in keys )
            {
                devgui::function_9082edeb5db93280( "<dev string:x2b4>" + str_player_name + "<dev string:x2c1>" );
                devgui::function_cd4e263c1f3018ae( "<dev string:x2c3>" + key, "<dev string:x2ce>" + key + "<dev string:x2df>" + str_player_name, &debug_give_perk );
                devgui::function_cd4e263c1f3018ae( "<dev string:x2e1>" + key, "<dev string:x2f2>" + key + "<dev string:x2df>" + str_player_name, &function_ae286557a70cd886 );
                devgui::function_cd4e263c1f3018ae( "<dev string:x309>" + key, "<dev string:x314>" + key + "<dev string:x2df>" + str_player_name, &debug_take_perk );
                devgui::function_77df7fe7dd273e10();
            }
            
            devgui::function_9082edeb5db93280( "<dev string:x2b4>" + str_player_name + "<dev string:x2c1>" );
            devgui::function_cd4e263c1f3018ae( "<dev string:x325>", "<dev string:x33e>" + str_player_name + "<dev string:x2df>", &function_5388c0b3dbbbc79d );
            devgui::function_cd4e263c1f3018ae( "<dev string:x354>", "<dev string:x36d>" + str_player_name + "<dev string:x2df>", &function_37e0f84be7459e57 );
            devgui::function_77df7fe7dd273e10();
        }
    #/
    
    if ( isdefined( self.perma_perks ) )
    {
        foreach ( perk in self.perma_perks )
        {
            give_perk( perk, 0, 0, undefined );
        }
    }
}

// Namespace zombie_perks
// Params 7
// Checksum 0xfe0c9cae, Offset: 0xe65
// Size: 0x370
function give_perk( perk, var_e90472a83f1bd909, var_b12dc3d14c271171, var_27055d4be790cd0, bpermanent, is_item_perk = 0, is_special_returned = 0 )
{
    if ( !level.zombie_perks_in_use )
    {
        return;
    }
    
    if ( !val::get( "allow_zm_perks" ) )
    {
        return;
    }
    
    if ( perk == "specialty_random" )
    {
        self playlocalsound( #"hash_24f1f16447d642b2" );
        function_ab9b4123275d6153( undefined, 1, is_item_perk );
        return;
    }
    
    if ( !isdefined( self.var_468836e5e67e15b4 ) )
    {
        self.var_468836e5e67e15b4 = 0;
    }
    
    self.var_468836e5e67e15b4++;
    self.var_298fe7dcdb17fe4f[ perk ] = 1;
    
    if ( var_e90472a83f1bd909 )
    {
        if ( !isdefined( self.perkspurchased ) )
        {
            self.perkspurchased = [];
        }
        
        self.perkspurchased[ perk ] = 1;
        self notify( #"perk_bought", perk );
        
        if ( !isdefined( level.total_purchased_perks ) )
        {
            level.total_purchased_perks = 0;
        }
        
        level.total_purchased_perks += 1;
        level.total_purchased_perks = clamp( level.total_purchased_perks, 0, 75 );
    }
    
    var_f318fc61c4702480 = isdefined( level._custom_perks[ perk ] ) && level._custom_perks[ perk ].var_f318fc61c4702480;
    self setperk( perk, var_f318fc61c4702480 );
    
    if ( isdefined( level._custom_perks[ perk ] ) && isdefined( level._custom_perks[ perk ].var_4814a425403617fc ) )
    {
        self thread [[ level._custom_perks[ perk ].var_4814a425403617fc ]]();
    }
    
    if ( !isdefined( self.perks_active ) )
    {
        self.perks_active = [];
    }
    
    if ( perk == "specialty_quickrevive" )
    {
        arrayinsert( self.perks_active, perk, 0 );
    }
    else if ( perk == "specialty_w_mod" )
    {
        if ( self.perks_active.size > 0 && self.perks_active[ 0 ] == "specialty_quickrevive" )
        {
            arrayinsert( self.perks_active, perk, 1 );
        }
        else
        {
            arrayinsert( self.perks_active, perk, 0 );
        }
    }
    else if ( var_27055d4be790cd0 )
    {
        arrayinsert( self.perks_active, perk, var_27055d4be790cd0 );
    }
    else
    {
        self.perks_active[ self.perks_active.size ] = perk;
    }
    
    if ( bpermanent )
    {
        if ( !isdefined( self.perma_perks ) )
        {
            self.perma_perks = [];
        }
        
        self.perma_perks[ self.perma_perks.size ] = perk;
    }
    
    if ( level.zm_mode_modifiers.var_89fa68db4cdb1044 )
    {
        utility::callsharedfunc( #"zm_mode_modifiers", #"hash_6843c64da905f4f8", perk, var_e90472a83f1bd909, is_item_perk, is_special_returned );
    }
    
    function_c11ba4bb3d0a676b();
    self notify( #"perk_acquired" );
    params = spawnstruct();
    params.var_ffc1674def575bfa = perk;
    params.var_e90472a83f1bd909 = var_e90472a83f1bd909;
    params.var_b12dc3d14c271171 = var_b12dc3d14c271171;
    callback::callback( "zm_perk_obtained", params );
    
    if ( level.has_perk_decay && self.var_468836e5e67e15b4 <= 3 )
    {
        thread function_92b3c546a3829338( perk );
        return;
    }
    
    thread perk_think( perk );
}

// Namespace zombie_perks
// Params 1
// Checksum 0x8b73c33, Offset: 0x11dd
// Size: 0x19a
function perk_think( perk )
{
    self endon( #"disconnect" );
    var_127234c5fdc9f8ae = perk + "_stop";
    result = utility::waittill_any_return( "fake_death", "death", var_127234c5fdc9f8ae );
    var_f318fc61c4702480 = isdefined( level._custom_perks[ perk ] ) && level._custom_perks[ perk ].var_f318fc61c4702480;
    self unsetperk( perk, var_f318fc61c4702480 );
    self.var_468836e5e67e15b4--;
    self.var_298fe7dcdb17fe4f[ perk ] = undefined;
    active_perks = [];
    
    for ( i = 0; i < self.perks_active.size ; i++ )
    {
        if ( perk == self.perks_active[ i ] )
        {
            continue;
        }
        
        active_perks[ active_perks.size ] = self.perks_active[ i ];
    }
    
    self.perks_active = active_perks;
    
    if ( isdefined( level._custom_perks[ perk ] ) && isdefined( level._custom_perks[ perk ].var_ea841983b8ea39f6 ) )
    {
        self thread [[ level._custom_perks[ perk ].var_ea841983b8ea39f6 ]]( 0, var_127234c5fdc9f8ae, result, -1 );
    }
    
    if ( isdefined( level.var_aeb53133cc76c390 ) )
    {
        self [[ level.var_aeb53133cc76c390 ]]( perk );
    }
    
    self notify( #"extra_perk_lost" );
    params = spawnstruct();
    params.var_ffc1674def575bfa = perk;
    callback::callback( "zm_perk_lost", params );
    function_c11ba4bb3d0a676b( 1 );
}

// Namespace zombie_perks
// Params 1
// Checksum 0xd56a23e7, Offset: 0x137f
// Size: 0x1a9
function function_92b3c546a3829338( perk )
{
    self endon( #"disconnect" );
    var_127234c5fdc9f8ae = perk + "_stop";
    utility::waittill_any_return( "fake_death", "death", var_127234c5fdc9f8ae );
    
    for ( i = 0; function_e4c9e826f4da942( perk ) ; i++ )
    {
        self waittill( var_127234c5fdc9f8ae );
    }
    
    waitframe();
    var_f318fc61c4702480 = isdefined( level._custom_perks[ perk ] ) && level._custom_perks[ perk ].var_f318fc61c4702480;
    self unsetperk( perk, var_f318fc61c4702480 );
    self.var_468836e5e67e15b4--;
    self.var_298fe7dcdb17fe4f[ perk ] = undefined;
    active_perks = [];
    
    for ( i = 0; i < self.perks_active.size ; i++ )
    {
        if ( perk == self.perks_active[ i ] )
        {
            continue;
        }
        
        active_perks[ active_perks.size ] = self.perks_active[ i ];
    }
    
    self.perks_active = active_perks;
    function_c11ba4bb3d0a676b();
    
    if ( isdefined( level._custom_perks[ perk ] ) && isdefined( level._custom_perks[ perk ].var_ea841983b8ea39f6 ) )
    {
        self thread [[ level._custom_perks[ perk ].var_ea841983b8ea39f6 ]]( 0, var_127234c5fdc9f8ae, -1 );
    }
    
    if ( isdefined( level.var_aeb53133cc76c390 ) )
    {
        self [[ level.var_aeb53133cc76c390 ]]( perk );
    }
    
    self notify( #"extra_perk_lost" );
    params = spawnstruct();
    params.var_ffc1674def575bfa = perk;
    callback::callback( "zm_perk_lost", params );
}

// Namespace zombie_perks
// Params 1
// Checksum 0x3809d64f, Offset: 0x1530
// Size: 0x45, Type: bool
function has_perk( perkname )
{
    if ( !level.zombie_perks_in_use )
    {
        return false;
    }
    
    perks = self.var_298fe7dcdb17fe4f;
    
    if ( !isdefined( perks ) )
    {
        return false;
    }
    
    if ( isdefined( perks[ perkname ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zombie_perks
// Params 1
// Checksum 0xd84f982a, Offset: 0x157e
// Size: 0x32, Type: bool
function has_permanent_perk( perkname )
{
    if ( !isdefined( self.perma_perks ) )
    {
        return false;
    }
    
    if ( arraycontains( self.perma_perks, perkname ) )
    {
        return true;
    }
    
    return false;
}

// Namespace zombie_perks
// Params 4
// Checksum 0x8386d75e, Offset: 0x15b9
// Size: 0x4ed
function function_ab9b4123275d6153( var_7ece0a0b1e5c66c0, var_7948bd2a3d3b3d6a = 0, is_item_perk = 0, is_bought )
{
    if ( !val::get( "allow_zm_perks" ) )
    {
        return;
    }
    
    valid_perks = get_perks_str_array();
    active_perks = get_active_perks_str_array();
    
    if ( isarray( active_perks ) )
    {
        valid_perks = arrayremove( valid_perks, active_perks );
    }
    
    if ( isarray( var_7ece0a0b1e5c66c0 ) )
    {
        valid_perks = arrayremove( valid_perks, var_7ece0a0b1e5c66c0 );
    }
    
    if ( self.disallow_zombie_perks.size > 0 )
    {
        valid_perks = arrayremove( valid_perks, self.disallow_zombie_perks );
    }
    
    var_b6154af149900248 = function_cda78d45986a51a0();
    
    if ( level.zm_mode_modifiers.var_89fa68db4cdb1044 )
    {
        var_b6154af149900248 = function_cda78d45986a51a0() || utility::callsharedfunc( #"zm_mode_modifiers", #"perk_limit_reached" );
    }
    
    if ( var_b6154af149900248 && var_7948bd2a3d3b3d6a )
    {
        if ( isarray( active_perks ) )
        {
            non_perma_perks = get_active_perks_str_array();
            
            if ( isdefined( self.perma_perks ) )
            {
                non_perma_perks = arrayremove( non_perma_perks, self.perma_perks );
                
                if ( non_perma_perks.size <= 0 || level.var_6891dd100da9df37 && level.var_6891dd100da9df37 != 1 )
                {
                    return;
                }
            }
            
            perma_perk = get_random_perk_str( non_perma_perks );
            zmperk_id = level.var_c56bbb377ee1e7fc[ perma_perk ];
            
            if ( isdefined( zmperk_id ) )
            {
                setomnvar( "ui_last_drank_perk", zmperk_id );
            }
            
            if ( !isdefined( self.perma_perks ) )
            {
                self.perma_perks = [];
            }
            
            self.perma_perks[ self.perma_perks.size ] = perma_perk;
            
            if ( isdefined( perma_perk ) )
            {
                copy_array = [];
                
                if ( has_perk( "specialty_quickrevive" ) && perma_perk != "specialty_quickrevive" )
                {
                    copy_array[ copy_array.size ] = "specialty_quickrevive";
                }
                
                copy_array[ copy_array.size ] = perma_perk;
                
                foreach ( perk in self.perks_active )
                {
                    if ( perk != "specialty_quickrevive" && perk != perma_perk )
                    {
                        copy_array[ copy_array.size ] = perk;
                    }
                }
                
                self.perks_active = copy_array;
                function_c11ba4bb3d0a676b();
                
                if ( !self.var_b81f9863e6afcd00 )
                {
                    self.var_b81f9863e6afcd00 = 1;
                    thread hud_message::showsplash( "sat_zm_permanent_perk", 0 );
                    gesture = level._custom_perks[ perma_perk ].perk_bottle_weapon ?? "cer_zm_vm_ges_001";
                    thread function_13cc8b1c31dda8c4( gesture );
                }
                else
                {
                    thread function_d0e24785e021e9ce( 5 );
                }
                
                callback::callback( #"hash_7432621eb6a7f04", { #perk:perma_perk } );
            }
        }
    }
    
    if ( level.zm_mode_modifiers.var_89fa68db4cdb1044 )
    {
        var_b6154af149900248 = utility::callsharedfunc( #"zm_mode_modifiers", #"perk_limit_reached" );
        
        if ( var_b6154af149900248 )
        {
            return;
        }
    }
    
    var_7a862765f0952522 = get_random_perk_str( valid_perks );
    
    if ( isdefined( var_7a862765f0952522 ) )
    {
        gesture = level._custom_perks[ var_7a862765f0952522 ].perk_bottle_weapon ?? "cer_zm_vm_ges_001";
        thread function_13cc8b1c31dda8c4( gesture );
        give_perk( var_7a862765f0952522, is_bought, 1, undefined, undefined, is_item_perk );
        
        if ( level.var_6891dd100da9df37 && var_7948bd2a3d3b3d6a && is_bought )
        {
            zmperk_id = level.var_c56bbb377ee1e7fc[ var_7a862765f0952522 ];
            
            if ( isdefined( zmperk_id ) )
            {
                setomnvar( "ui_last_drank_perk", zmperk_id );
            }
            
            if ( !isdefined( self.perma_perks ) )
            {
                self.perma_perks = [];
            }
            
            self.perma_perks[ self.perma_perks.size ] = var_7a862765f0952522;
            
            if ( isdefined( var_7a862765f0952522 ) )
            {
                copy_array = [];
                
                if ( has_perk( "specialty_quickrevive" ) && var_7a862765f0952522 != "specialty_quickrevive" )
                {
                    copy_array[ copy_array.size ] = "specialty_quickrevive";
                }
                
                copy_array[ copy_array.size ] = var_7a862765f0952522;
                
                foreach ( perk in self.perks_active )
                {
                    if ( perk != "specialty_quickrevive" && perk != var_7a862765f0952522 )
                    {
                        copy_array[ copy_array.size ] = perk;
                    }
                }
                
                self.perks_active = copy_array;
                function_c11ba4bb3d0a676b();
                callback::callback( #"hash_7432621eb6a7f04", { #perk:var_7a862765f0952522 } );
            }
        }
        
        return var_7a862765f0952522;
    }
}

// Namespace zombie_perks
// Params 1
// Checksum 0xc854db8d, Offset: 0x1aaf
// Size: 0x19
function function_d0e24785e021e9ce( delay )
{
    wait delay;
    self.var_b81f9863e6afcd00 = undefined;
}

// Namespace zombie_perks
// Params 1
// Checksum 0x6ef769a1, Offset: 0x1ad0
// Size: 0x1a6
function function_3c5c75cec72d90aa( perma_perk )
{
    active_perks = get_active_perks_str_array();
    
    if ( isarray( active_perks ) )
    {
        non_perma_perks = get_active_perks_str_array();
        
        if ( isdefined( self.perma_perks ) )
        {
            non_perma_perks = arrayremove( non_perma_perks, self.perma_perks );
            
            if ( non_perma_perks.size <= 0 )
            {
                return;
            }
        }
        
        zmperk_id = level.var_c56bbb377ee1e7fc[ perma_perk ];
        
        if ( isdefined( zmperk_id ) )
        {
            setomnvar( "ui_last_drank_perk", zmperk_id );
        }
        
        if ( !isdefined( self.perma_perks ) )
        {
            self.perma_perks = [];
        }
        
        self.perma_perks[ self.perma_perks.size ] = perma_perk;
        
        if ( isdefined( perma_perk ) )
        {
            copy_array = [];
            
            if ( has_perk( "specialty_quickrevive" ) && perma_perk != "specialty_quickrevive" )
            {
                copy_array[ copy_array.size ] = "specialty_quickrevive";
            }
            
            copy_array[ copy_array.size ] = perma_perk;
            
            foreach ( perk in self.perks_active )
            {
                if ( perk != "specialty_quickrevive" && perk != perma_perk )
                {
                    copy_array[ copy_array.size ] = perk;
                }
            }
            
            self.perks_active = copy_array;
            function_c11ba4bb3d0a676b();
            callback::callback( #"hash_7432621eb6a7f04", { #perk:perma_perk } );
        }
    }
}

// Namespace zombie_perks
// Params 1
// Checksum 0xca47ce1f, Offset: 0x1c7e
// Size: 0x5b
function function_13cc8b1c31dda8c4( gesture )
{
    self endon( #"death_or_disconnect" );
    
    while ( self isswitchingweapon() )
    {
        waitframe();
    }
    
    if ( weapon::iskillstreakweapon( self getcurrentweapon() ) )
    {
        self enableoffhandweapons();
        waitframe();
        thread utility::function_72b6372d2d8c997( gesture, 1, 1 );
        waitframe();
        self disableoffhandweapons();
        return;
    }
    
    utility::function_72b6372d2d8c997( gesture, 1, 1 );
}

// Namespace zombie_perks
// Params 0
// Checksum 0xfbc3cc0d, Offset: 0x1ce1
// Size: 0x9b
function get_perks_str_array()
{
    perks_str_array = [];
    
    foreach ( key, perk in level._custom_perks )
    {
        if ( key != "specialty_choice" )
        {
            perks_str_array[ perks_str_array.size ] = perk.str_perk_root;
        }
    }
    
    return perks_str_array;
}

// Namespace zombie_perks
// Params 1
// Checksum 0xd26c3c19, Offset: 0x1d85
// Size: 0x3e
function get_random_perk_str( perks_str_array )
{
    assert( isarray( perks_str_array ), "<dev string:x383>" );
    
    if ( perks_str_array.size == 0 )
    {
        return;
    }
    
    perk = utility::array_random( perks_str_array );
    return perk;
}

// Namespace zombie_perks
// Params 0
// Checksum 0x4363b66d, Offset: 0x1dcc
// Size: 0x59
function get_active_perks_str_array()
{
    perks_str_array = [];
    
    for ( i = 0; i < self.perks_active.size ; i++ )
    {
        if ( self.perks_active[ i ] != "specialty_choice" )
        {
            perks_str_array[ perks_str_array.size ] = self.perks_active[ i ];
        }
    }
    
    return perks_str_array;
}

// Namespace zombie_perks
// Params 1
// Checksum 0x3f4333e0, Offset: 0x1e2e
// Size: 0xb2
function function_5d65c3d58cc084ec( str_root_perk )
{
    bundle = level.perkbundles[ str_root_perk ];
    var_5f1434e27ebffc62 = bundle.zombiesextraperks;
    
    foreach ( perk in var_5f1434e27ebffc62 )
    {
        perk::giveperk( perk.extraperk );
    }
}

// Namespace zombie_perks
// Params 1
// Checksum 0x9ef8a18f, Offset: 0x1ee8
// Size: 0xb2
function function_25539251d02082( str_root_perk )
{
    bundle = level.perkbundles[ str_root_perk ];
    var_5f1434e27ebffc62 = bundle.zombiesextraperks;
    
    foreach ( perk in var_5f1434e27ebffc62 )
    {
        perk::removeperk( perk.extraperk );
    }
}

// Namespace zombie_perks
// Params 0
// Checksum 0x95c9c8f4, Offset: 0x1fa2
// Size: 0x194
function function_77331fd62580dd0a()
{
    cost = level.gametypebundle.var_f5273c76b4c7b437;
    
    if ( level.var_6891dd100da9df37 && level.var_ea5fb2ecb092a34e )
    {
        cost = 5000;
    }
    
    if ( level.zm_mode_modifiers.var_3bacdb0dd3796c03 )
    {
        var_8f68a9361af56566 = level.total_purchased_perks;
        
        if ( !isdefined( var_8f68a9361af56566 ) )
        {
            var_8f68a9361af56566 = 0;
        }
        
        if ( var_8f68a9361af56566 >= 1 )
        {
            cost += var_8f68a9361af56566 * level.gametypebundle.var_2137b6b66219eb66;
        }
    }
    else
    {
        scalingperks = level.gamemodebundle.var_3b240d29a248ead1 ? self.perkspurchased : self.perks_active;
        
        if ( !isdefined( scalingperks ) )
        {
            scalingperks = [];
        }
        
        if ( scalingperks.size >= 1 )
        {
            cost += scalingperks.size * level.gametypebundle.var_2137b6b66219eb66;
        }
    }
    
    if ( isdefined( self.perks[ "specialty_exfil_perk_percent_reward" ] ) )
    {
        cost = int( cost * level.perkbundles[ "specialty_exfil_perk_percent_reward" ].var_39741b35981bd148 );
    }
    
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_z_mod", #"z_mod_kick_back" ) )
    {
        perkdiscount = level.zombie_augments[ #"z_mod_kick_back" ].var_106ebee3bbbdc702 ?? 1000;
        cost -= perkdiscount;
        
        if ( cost < 0 )
        {
            cost = 1;
        }
    }
    
    return cost;
}

// Namespace zombie_perks
// Params 1
// Checksum 0xf5faaa18, Offset: 0x213f
// Size: 0x23
function function_c9046bccce2a4ac8( var_a89b5e340fffb0d1 )
{
    level.var_f72357c3d3ad7cfe[ level.var_f72357c3d3ad7cfe.size ] = var_a89b5e340fffb0d1;
}

// Namespace zombie_perks
// Params 1
// Checksum 0x9b8f68b3, Offset: 0x216a
// Size: 0x97, Type: bool
function function_e4c9e826f4da942( perk )
{
    if ( !player::isinlaststand( self ) )
    {
        return false;
    }
    
    foreach ( func_lost_perk_override in level.var_f72357c3d3ad7cfe )
    {
        if ( self [[ func_lost_perk_override ]]( perk ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_perks
// Params 1
// Checksum 0x831886ef, Offset: 0x220a
// Size: 0x3cf
function function_c11ba4bb3d0a676b( force )
{
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( self.perks_active ) )
    {
        packeddata = [];
        omnvarbits = [];
        
        for ( index = 0; index < 4 ; index++ )
        {
            packeddata[ index ] = 0;
            omnvarbits[ index ] = 0;
        }
        
        if ( force == 1 )
        {
            for ( index = 0; index < 4 ; index++ )
            {
                self setclientomnvar( "ui_active_perks_" + index + 1, packeddata[ index ] );
            }
            
            waitframe();
        }
        
        var_4fa92a817739db97 = 31;
        var_dc4d48b351cb4d62 = 1;
        var_82784bdb36789995 = 1;
        var_f004aa9ddf7b1444 = 7;
        var_1eb96d3466aabd66 = [];
        
        if ( self.num_perks_decay > 0 )
        {
            for ( i = self.perks_active.size; i > 0 ; i-- )
            {
                var_762c623db3e7ddd6 = i - 1;
                perk = self.perks_active[ var_762c623db3e7ddd6 ];
                can_decay = 0;
                
                if ( var_1eb96d3466aabd66.size < 3 )
                {
                    can_decay = 1;
                    
                    for ( perm_index = 0; perm_index < self.perma_perks.size ; perm_index++ )
                    {
                        if ( perk == self.perma_perks[ perm_index ] )
                        {
                            can_decay = 0;
                            break;
                        }
                    }
                    
                    if ( can_decay )
                    {
                        arrayinsert( var_1eb96d3466aabd66, var_762c623db3e7ddd6, 0 );
                    }
                }
                
                if ( var_1eb96d3466aabd66.size >= 3 )
                {
                    break;
                }
            }
        }
        
        for ( i = 0; i < self.perks_active.size ; i++ )
        {
            perk = self.perks_active[ i ];
            zmperk_id = level.var_c56bbb377ee1e7fc[ perk ];
            
            if ( !isdefined( zmperk_id ) || !isdefined( var_4fa92a817739db97 ) || !isdefined( omnvarbits ) || !isdefined( packeddata ) )
            {
                continue;
            }
            
            omnvarindex = int( i / floor( 32 / var_f004aa9ddf7b1444 ) );
            
            if ( !isdefined( omnvarindex ) || !isdefined( omnvarbits[ omnvarindex ] ) || !isdefined( packeddata[ omnvarindex ] ) )
            {
                continue;
            }
            
            is_perm = 0;
            
            for ( perm_index = 0; perm_index < self.perma_perks.size ; perm_index++ )
            {
                if ( perk == self.perma_perks[ perm_index ] )
                {
                    is_perm = 1;
                    break;
                }
            }
            
            is_decayed = 0;
            
            if ( self.num_perks_decay > 0 )
            {
                if ( var_1eb96d3466aabd66.size > 0 && !is_perm && arraycontains( var_1eb96d3466aabd66, i ) )
                {
                    var_9e1b5071471ea29d = 0;
                    
                    for ( decay_index = 3; decay_index > 0 ; decay_index-- )
                    {
                        decay_perk = self.perks_active[ var_1eb96d3466aabd66[ var_9e1b5071471ea29d ] ];
                        
                        if ( perk == decay_perk )
                        {
                            is_decayed = decay_index <= self.num_perks_decay;
                            break;
                        }
                        
                        var_9e1b5071471ea29d++;
                    }
                }
            }
            
            packeddata[ omnvarindex ] += ( zmperk_id & var_4fa92a817739db97 ) << omnvarbits[ omnvarindex ];
            omnvarbits[ omnvarindex ] += 5;
            packeddata[ omnvarindex ] += ( int( is_perm ) & var_dc4d48b351cb4d62 ) << omnvarbits[ omnvarindex ];
            omnvarbits[ omnvarindex ] += 1;
            packeddata[ omnvarindex ] += ( int( is_decayed ) & var_82784bdb36789995 ) << omnvarbits[ omnvarindex ];
            omnvarbits[ omnvarindex ] += 1;
        }
        
        if ( isplayer( self ) && isdefined( packeddata ) )
        {
            for ( index = 0; index < 4 ; index++ )
            {
                self setclientomnvar( "ui_active_perks_" + index + 1, packeddata[ index ] );
            }
        }
    }
    
    if ( isdefined( self.perkspurchased ) )
    {
        self setclientomnvar( "ui_purchased_perks_count", self.perkspurchased.size );
    }
    
    if ( !isdefined( level.total_purchased_perks ) )
    {
        level.total_purchased_perks = 0;
    }
    
    self setclientomnvar( "ui_total_purchased_perks_count", level.total_purchased_perks );
}

// Namespace zombie_perks
// Params 0
// Checksum 0x4abab904, Offset: 0x25e1
// Size: 0x28e
function function_c19849e6dea8f3()
{
    packeddata = [];
    omnvarbits = [];
    
    for ( index = 0; index < 1 ; index++ )
    {
        packeddata[ index ] = 0;
        omnvarbits[ index ] = 0;
    }
    
    if ( self.perks_active.size > 0 )
    {
        var_4fa92a817739db97 = 31;
        var_dc4d48b351cb4d62 = 1;
        var_82784bdb36789995 = 1;
        var_f004aa9ddf7b1444 = 7;
        var_1eb96d3466aabd66 = [];
        
        for ( i = self.perks_active.size; i > 0 ; i-- )
        {
            var_762c623db3e7ddd6 = i - 1;
            perk = self.perks_active[ var_762c623db3e7ddd6 ];
            var_85f0aa0cbd9472b6 = 0;
            
            if ( var_1eb96d3466aabd66.size < 3 )
            {
                var_85f0aa0cbd9472b6 = 1;
                
                for ( perm_index = 0; perm_index < self.perma_perks.size ; perm_index++ )
                {
                    if ( perk == self.perma_perks[ perm_index ] )
                    {
                        var_85f0aa0cbd9472b6 = 0;
                        break;
                    }
                }
                
                if ( var_85f0aa0cbd9472b6 )
                {
                    arrayinsert( var_1eb96d3466aabd66, var_762c623db3e7ddd6, 0 );
                }
            }
            
            if ( var_1eb96d3466aabd66.size >= 3 )
            {
                break;
            }
        }
        
        var_9e1b5071471ea29d = 0;
        
        if ( var_1eb96d3466aabd66.size > 0 )
        {
            for ( decay_index = 3; decay_index > 0 ; decay_index-- )
            {
                perk = self.perks_active[ var_1eb96d3466aabd66[ var_9e1b5071471ea29d ] ];
                is_perm = 0;
                is_decayed = 0;
                zmperk_id = 0;
                
                if ( isdefined( perk ) )
                {
                    zmperk_id = level.var_c56bbb377ee1e7fc[ perk ] ?? 0;
                    
                    if ( self.num_perks_decay > 0 )
                    {
                        is_decayed = !is_perm && decay_index <= self.num_perks_decay;
                    }
                }
                
                omnvarindex = int( var_9e1b5071471ea29d / floor( 32 / var_f004aa9ddf7b1444 ) );
                packeddata[ omnvarindex ] += ( zmperk_id & var_4fa92a817739db97 ) << omnvarbits[ omnvarindex ];
                omnvarbits[ omnvarindex ] += 5;
                packeddata[ omnvarindex ] += ( int( is_perm ) & var_dc4d48b351cb4d62 ) << omnvarbits[ omnvarindex ];
                omnvarbits[ omnvarindex ] += 1;
                packeddata[ omnvarindex ] += ( int( is_decayed ) & var_82784bdb36789995 ) << omnvarbits[ omnvarindex ];
                omnvarbits[ omnvarindex ] += 1;
                var_9e1b5071471ea29d += 1;
            }
        }
    }
    
    if ( isplayer( self ) && isdefined( packeddata ) )
    {
        for ( index = 0; index < 1 ; index++ )
        {
            self setclientomnvar( "ui_decaying_perks_" + index + 1, packeddata[ index ] );
        }
    }
}

// Namespace zombie_perks
// Params 0
// Checksum 0x4d50d37e, Offset: 0x2877
// Size: 0x5e
function function_a8a355e526c9a906()
{
    for ( index = 0; index < 4 ; index++ )
    {
        self setclientomnvar( "ui_active_perks_" + index + 1, 0 );
    }
    
    self setclientomnvar( "ui_purchased_perks_count", 0 );
    
    for ( index = 0; index < 1 ; index++ )
    {
        self setclientomnvar( "ui_decaying_perks_" + index + 1, 0 );
    }
}

// Namespace zombie_perks
// Params 1
// Checksum 0x4b72f809, Offset: 0x28dd
// Size: 0x11c
function function_7b00ed093e6457ca( params )
{
    if ( isdefined( params.progress ) )
    {
        self setclientomnvar( "ui_bleedout_progress", params.progress );
        
        if ( level.gametypebundle.var_8a9e094f5cfd9af5 )
        {
            if ( params.progress < 0.25 )
            {
                if ( self.num_perks_decay != 3 )
                {
                    self.num_perks_decay = 3;
                    function_34dce6aaf9a54c85( 1 );
                    function_c11ba4bb3d0a676b();
                    function_c19849e6dea8f3();
                }
                
                return;
            }
            
            if ( params.progress < 0.5 )
            {
                if ( self.num_perks_decay != 2 )
                {
                    self.num_perks_decay = 2;
                    function_34dce6aaf9a54c85( 2 );
                    function_c11ba4bb3d0a676b();
                    function_c19849e6dea8f3();
                }
                
                return;
            }
            
            if ( params.progress < 0.75 )
            {
                if ( self.num_perks_decay != 1 )
                {
                    self.num_perks_decay = 1;
                    function_34dce6aaf9a54c85( 3 );
                    function_c11ba4bb3d0a676b();
                    function_c19849e6dea8f3();
                }
            }
        }
    }
}

// Namespace zombie_perks
// Params 1
// Checksum 0xd60fae8c, Offset: 0x2a01
// Size: 0x42
function function_34dce6aaf9a54c85( var_656c20102c45b8dd )
{
    perks = get_active_perks_str_array();
    var_468836e5e67e15b4 = perks.size;
    
    if ( perks.size >= var_656c20102c45b8dd )
    {
        self playlocalsound( "uin_zmb_perk_decay_" + var_656c20102c45b8dd );
    }
}

// Namespace zombie_perks
// Params 1
// Checksum 0xa3003b68, Offset: 0x2a4b
// Size: 0x101
function function_b8f9a54f659050e5( params )
{
    self endon( #"disconnect" );
    
    if ( level.gametypebundle.var_8a9e094f5cfd9af5 && !isdefined( self.bgb_enabled[ "aftertaste" ] ) )
    {
        perks = get_active_perks_str_array();
        
        if ( isdefined( self.perma_perks ) )
        {
            perks = arrayremove( perks, self.perma_perks );
        }
        
        if ( perks.size > 0 && perks.size <= 3 )
        {
            n_index = perks.size - 1;
            take_perk( perks[ n_index ] );
        }
        
        if ( perks.size > 0 && perks.size > 3 )
        {
            for ( i = perks.size; i > 3 ; i-- )
            {
                take_perk( perks[ i - 1 ] );
            }
        }
        
        self.num_perks_decay = 0;
    }
    
    waitframe();
    function_c11ba4bb3d0a676b();
    function_c19849e6dea8f3();
    self setclientomnvar( "ui_laststand_visibility", 1 );
}

// Namespace zombie_perks
// Params 1
// Checksum 0x84db0eb3, Offset: 0x2b54
// Size: 0x48d
function function_330055386ab626b9( params )
{
    self endon( #"death_or_disconnect" );
    self setclientomnvar( "ui_laststand_visibility", 0 );
    
    if ( level.gametypebundle.var_8a9e094f5cfd9af5 )
    {
        decayed_perk_count = self.num_perks_decay;
        self.num_perks_decay = 0;
        function_c11ba4bb3d0a676b();
        
        if ( isplayer( params.reviver ) && isdefined( params.reason ) && params.reason == "last_stand_revived_healing_aura" )
        {
            if ( params.reviver utility::callsharedfunc( #"zombie", #"player_has_augment", #"healingaura_keep_perks" ) )
            {
                return;
            }
        }
        
        if ( isplayer( params.reviver ) && params.reviver utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_quickrevive", #"quick_revive_precision_surgery" ) || isplayer( self ) && utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_quickrevive", #"quick_revive_precision_surgery" ) )
        {
            bleedout_perks = get_active_perks_str_array();
            lost_perks = self.var_a0c63f8db21c605b;
            lost_purchased_perks = self.var_f1650ed763b03141;
            var_e3077a702a449f55 = [];
            
            if ( lost_perks.size > 2 )
            {
                for ( i = 0; i < 2 ; i++ )
                {
                    var_e3077a702a449f55[ i ] = lost_perks[ i ];
                }
            }
            
            all_perks = arraycombine( bleedout_perks, var_e3077a702a449f55 );
            take_all_perks();
            waitframe();
            
            foreach ( perk in all_perks )
            {
                if ( !has_perk( perk ) )
                {
                    var_f5b73cb40aba92fc = arraycontains( lost_purchased_perks, perk );
                    give_perk( perk, var_f5b73cb40aba92fc );
                    waitframe();
                }
            }
            
            return;
        }
        
        if ( params.reason === "last_stand_bgb" )
        {
            return;
        }
        
        if ( params.reviver == self && params.reason == "last_stand_revived_quick_revive_augment" && utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_quickrevive", #"quick_revive_last_chance" ) || params.reason == "last_stand_revived_w_mod_savior" && utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_w_mod", #"w_mod_savior" ) || self.var_287f29fa987acd1c )
        {
            n_wait_time = 1000;
            last_time_wait = gettime();
            
            while ( isdefined( self.laststandweaponobj ) )
            {
                if ( gettime() - last_time_wait > n_wait_time )
                {
                    break;
                }
                
                waitframe();
            }
            
            bleedout_perks = get_active_perks_str_array();
            lost_perks = self.var_a0c63f8db21c605b;
            lost_purchased_perks = self.var_f1650ed763b03141;
            all_perks = arraycombine( bleedout_perks, lost_perks );
            
            foreach ( perk in all_perks )
            {
                if ( !has_perk( perk ) )
                {
                    var_f5b73cb40aba92fc = arraycontains( lost_purchased_perks, perk );
                    give_perk( perk, var_f5b73cb40aba92fc, undefined, undefined, undefined, undefined, 1 );
                    waitframe();
                }
            }
            
            if ( params.reason == "last_stand_revived_w_mod_savior" && utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_w_mod", #"w_mod_savior" ) )
            {
                take_perk( "specialty_w_mod" );
            }
            
            return;
        }
        
        if ( decayed_perk_count > 0 )
        {
            perks = get_active_perks_str_array();
            var_468836e5e67e15b4 = perks.size;
            var_7fc0c0c6159c3771 = 3 - decayed_perk_count;
            
            for ( i = var_468836e5e67e15b4; i > var_7fc0c0c6159c3771 ; i-- )
            {
                take_perk( perks[ i - 1 ] );
            }
        }
    }
}

// Namespace zombie_perks
// Params 1
// Checksum 0xaa346880, Offset: 0x2fe9
// Size: 0x1f
function function_b5e65ebcfb34d0ce( params )
{
    function_a8a355e526c9a906();
    self setclientomnvar( "ui_laststand_visibility", 0 );
}

// Namespace zombie_perks
// Params 0
// Checksum 0x233e45e3, Offset: 0x3010
// Size: 0x56
function function_a08d7c9af61a2dcc()
{
    callback::add( #"player_laststand", &function_b8f9a54f659050e5 );
    callback::add( #"player_laststand_revived", &function_330055386ab626b9 );
    callback::add( #"player_death", &function_b5e65ebcfb34d0ce );
    callback::add( #"hash_34d8a133c38aed30", &function_7b00ed093e6457ca );
}

// Namespace zombie_perks
// Params 2
// Checksum 0xeafd808, Offset: 0x306e
// Size: 0x153, Type: bool
function take_perk( str_perk, ignore_perma = undefined )
{
    if ( !level.zombie_perks_in_use )
    {
        return false;
    }
    
    if ( isdefined( self.perma_perks ) && arraycontains( self.perma_perks, str_perk ) && !ignore_perma )
    {
        return false;
    }
    
    var_332f8b58377eacb4 = 0;
    
    if ( self.perkspurchased[ str_perk ] )
    {
        var_332f8b58377eacb4 = 1;
        new_perks = [];
        
        foreach ( index, perk in self.perkspurchased )
        {
            if ( index != str_perk )
            {
                new_perks[ index ] = 1;
            }
        }
        
        self.perkspurchased = new_perks;
    }
    
    str_notify = str_perk + "_stop";
    self notify( str_notify );
    self.var_a0c63f8db21c605b[ self.var_a0c63f8db21c605b.size ] = str_perk;
    
    if ( var_332f8b58377eacb4 )
    {
        self.var_f1650ed763b03141[ self.var_f1650ed763b03141.size ] = str_perk;
    }
    
    return true;
}

// Namespace zombie_perks
// Params 4
// Checksum 0x2e083c55, Offset: 0x31ca
// Size: 0xf1, Type: bool
function grab_and_use_perk( str_perk, var_4eade8b4558610e = 0, is_item_perk = 0, bpermanent = 0 )
{
    self endon( #"death_or_disconnect" );
    
    if ( !level.zombie_perks_in_use )
    {
        return false;
    }
    
    if ( !val::get( "allow_zm_perks" ) )
    {
        return false;
    }
    
    if ( !bpermanent && has_perk( str_perk ) || bpermanent && has_permanent_perk( str_perk ) )
    {
        return false;
    }
    
    if ( bpermanent && has_perk( str_perk ) )
    {
        take_perk( str_perk );
        waitframe();
    }
    
    gesture = level._custom_perks[ str_perk ].perk_bottle_weapon ?? "cer_zm_vm_ges_001";
    thread function_13cc8b1c31dda8c4( gesture );
    give_perk( str_perk, var_4eade8b4558610e, 1, undefined, bpermanent, is_item_perk );
    return true;
}

// Namespace zombie_perks
// Params 1
// Checksum 0xac14c73c, Offset: 0x32c4
// Size: 0xc3
function function_a0329bb1c47eda09( var_faeafe2f616ce83b )
{
    keys = getarraykeys( level._custom_perks );
    
    foreach ( key in keys )
    {
        if ( !val::get( "allow_zm_perks" ) )
        {
            continue;
        }
        
        if ( has_perk( key ) || key == "specialty_choice" )
        {
            continue;
        }
        
        give_perk( key, 0 );
        waitframe();
    }
}

// Namespace zombie_perks
// Params 1
// Checksum 0xf6917338, Offset: 0x338f
// Size: 0xb8
function take_all_perks( ignore_perma = undefined )
{
    keys = getarraykeys( level._custom_perks );
    
    foreach ( key in keys )
    {
        if ( key == "specialty_choice" )
        {
            continue;
        }
        
        if ( has_perk( key ) )
        {
            take_perk( key, ignore_perma );
        }
        
        waitframe();
    }
}

// Namespace zombie_perks
// Params 0
// Checksum 0x47e9b71d, Offset: 0x344f
// Size: 0x9e, Type: bool
function function_cda78d45986a51a0()
{
    keys = getarraykeys( level._custom_perks );
    
    foreach ( key in keys )
    {
        if ( !has_perk( key ) && key != "specialty_choice" )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zombie_perks
// Params 4
// Checksum 0x23a00a4f, Offset: 0x34f6
// Size: 0x116
function function_a040bb411a7c8142( notify_endon = "end_speed_line_watcher", b_supersprint = 0, var_2a8c57a9b2ee46cb = 0, postfxbundlename )
{
    self endon( #"death_or_disconnect" );
    self endon( notify_endon );
    
    while ( isalive( self ) )
    {
        if ( self issupersprinting() && b_supersprint || self issprinting() && !b_supersprint )
        {
            if ( var_2a8c57a9b2ee46cb )
            {
                pbgpostfxbundlestart( self, postfxbundlename );
            }
            else if ( self getscriptablehaspart( #"speed_line_camera" ) )
            {
                state = self getscriptablepartstate( #"speed_line_camera" );
                
                if ( state != #"speed_line_on" )
                {
                    self setscriptablepartstate( "speed_line_camera", #"speed_line_on", 0 );
                }
            }
        }
        else if ( var_2a8c57a9b2ee46cb )
        {
            pbgpostfxbundleend( self, postfxbundlename );
        }
        else if ( self getscriptablehaspart( #"speed_line_camera" ) )
        {
            self setscriptablepartstate( "speed_line_camera", #"speed_line_off", 0 );
        }
        
        waitframe();
    }
}

// Namespace zombie_perks
// Params 1
// Checksum 0xb8b009a0, Offset: 0x3614
// Size: 0x14c
function on_player_revived_perks( params )
{
    if ( !isarray( level.a_lost_perk_override_func ) )
    {
        return;
    }
    
    b_return_perk = 0;
    
    foreach ( func in level.a_lost_perk_override_func )
    {
        if ( self [[ func ]]( params ) )
        {
            b_return_perk = 1;
            break;
        }
    }
    
    if ( b_return_perk )
    {
        foreach ( perk in self.var_a0c63f8db21c605b )
        {
            var_f5b73cb40aba92fc = arraycontains( self.var_f1650ed763b03141, perk );
            
            if ( !has_perk( perk ) )
            {
                give_perk( perk, var_f5b73cb40aba92fc );
            }
        }
    }
}

// Namespace zombie_perks
// Params 1
// Checksum 0x83ec8597, Offset: 0x3768
// Size: 0x41
function on_player_laststand_perks( params )
{
    self.var_a0c63f8db21c605b = [];
    self.var_f1650ed763b03141 = [];
    waitframe();
    
    if ( isplayer( self ) && isalive( self ) )
    {
        self.bleedout_perks = get_active_perks_str_array();
    }
}

/#

    // Namespace zombie_perks
    // Params 2
    // Checksum 0xeb41277e, Offset: 0x37b1
    // Size: 0x251, Type: dev
    function function_ae286557a70cd886( a_params, var_fd4c6387bd05a92c )
    {
        if ( !isdefined( var_fd4c6387bd05a92c ) )
        {
            var_fd4c6387bd05a92c = 1;
        }
        
        str_perk = a_params[ 0 ];
        player = function_fdfae7e5048bf698( a_params[ 1 ] );
        
        if ( player has_perk( str_perk ) )
        {
            active_perks = player get_active_perks_str_array();
            
            if ( isarray( active_perks ) )
            {
                non_perma_perks = player get_active_perks_str_array();
                
                if ( isdefined( player.perma_perks ) )
                {
                    non_perma_perks = arrayremove( non_perma_perks, player.perma_perks );
                    
                    if ( non_perma_perks.size <= 0 )
                    {
                        return;
                    }
                }
                
                perma_perk = str_perk;
                
                if ( !isdefined( player.perma_perks ) )
                {
                    player.perma_perks = [];
                }
                
                player.perma_perks[ player.perma_perks.size ] = perma_perk;
                
                if ( isdefined( perma_perk ) )
                {
                    copy_array = [];
                    
                    if ( player has_perk( "<dev string:x3a0>" ) && perma_perk != "<dev string:x3a0>" )
                    {
                        copy_array[ copy_array.size ] = "<dev string:x3a0>";
                    }
                    
                    copy_array[ copy_array.size ] = perma_perk;
                    
                    foreach ( perk in player.perks_active )
                    {
                        if ( perk != "<dev string:x3a0>" && perk != perma_perk )
                        {
                            copy_array[ copy_array.size ] = perk;
                        }
                    }
                    
                    player.perks_active = copy_array;
                    player function_c11ba4bb3d0a676b();
                }
            }
            
            return;
        }
        
        if ( var_fd4c6387bd05a92c )
        {
            player thread function_13cc8b1c31dda8c4( level._custom_perks[ str_perk ].perk_bottle_weapon );
        }
        
        if ( utility::issharedfuncdefined( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb" ) && player utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "<dev string:x3a0>" ) )
        {
            player give_perk( str_perk, 0, var_fd4c6387bd05a92c, 1, 1 );
            return;
        }
        
        player give_perk( str_perk, 0, var_fd4c6387bd05a92c, 0, 1 );
    }

    // Namespace zombie_perks
    // Params 2
    // Checksum 0x897edd28, Offset: 0x3a0a
    // Size: 0x82, Type: dev
    function debug_give_perk( a_params, var_fd4c6387bd05a92c )
    {
        if ( !isdefined( var_fd4c6387bd05a92c ) )
        {
            var_fd4c6387bd05a92c = 1;
        }
        
        str_perk = a_params[ 0 ];
        player = function_fdfae7e5048bf698( a_params[ 1 ] );
        
        if ( player has_perk( str_perk ) )
        {
            return;
        }
        
        if ( var_fd4c6387bd05a92c )
        {
            player thread function_13cc8b1c31dda8c4( level._custom_perks[ str_perk ].perk_bottle_weapon );
        }
        
        player give_perk( str_perk, 0, var_fd4c6387bd05a92c );
    }

    // Namespace zombie_perks
    // Params 1
    // Checksum 0x2f146e58, Offset: 0x3a94
    // Size: 0xf1, Type: dev
    function debug_take_perk( a_params )
    {
        str_perk = a_params[ 0 ];
        str_notify = str_perk + "<dev string:x3b6>";
        player = function_fdfae7e5048bf698( a_params[ 1 ] );
        player notify( str_notify );
        
        if ( player.perkspurchased[ str_perk ] )
        {
            new_perks = [];
            
            foreach ( index, perk in player.perkspurchased )
            {
                if ( index != str_perk )
                {
                    new_perks[ index ] = 1;
                }
            }
            
            player.perkspurchased = new_perks;
        }
    }

    // Namespace zombie_perks
    // Params 1
    // Checksum 0x478e819f, Offset: 0x3b8d
    // Size: 0xc9, Type: dev
    function function_5388c0b3dbbbc79d( a_params )
    {
        player = function_fdfae7e5048bf698( a_params[ 0 ] );
        keys = getarraykeys( level._custom_perks );
        
        foreach ( key in keys )
        {
            if ( player has_perk( key ) || key == "<dev string:x3bc>" )
            {
                continue;
            }
            
            player give_perk( key, 0 );
            waitframe();
        }
    }

    // Namespace zombie_perks
    // Params 1
    // Checksum 0x4368669f, Offset: 0x3c5e
    // Size: 0x161, Type: dev
    function function_37e0f84be7459e57( a_params )
    {
        player = function_fdfae7e5048bf698( a_params[ 0 ] );
        keys = getarraykeys( level._custom_perks );
        
        foreach ( key in keys )
        {
            str_notify = key + "<dev string:x3b6>";
            player notify( str_notify );
            
            if ( player.perkspurchased[ key ] )
            {
                new_perks = [];
                
                foreach ( index, perk in player.perkspurchased )
                {
                    if ( index != key )
                    {
                        new_perks[ index ] = 1;
                    }
                }
                
                player.perkspurchased = new_perks;
            }
        }
    }

    // Namespace zombie_perks
    // Params 1
    // Checksum 0xeffa77d6, Offset: 0x3dc7
    // Size: 0xf, Type: dev
    function function_73ce2ab4650f41ef( a_params )
    {
        
    }

    // Namespace zombie_perks
    // Params 1
    // Checksum 0xcbbf93bd, Offset: 0x3dde
    // Size: 0xb6, Type: dev
    function function_fdfae7e5048bf698( str_name )
    {
        foreach ( player in level.players )
        {
            if ( player.name == str_name )
            {
                return player;
            }
            
            if ( isbot( player ) )
            {
                if ( issubstr( player.name, str_name ) )
                {
                    return player;
                }
            }
        }
    }

#/
