// scripts\mp\bots\bots_strategy.gsc  (hash_4145a7b3d8867dc9.gscc) (size: 14618 Bytes / 0x391a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x87c9bca4 (2278145188)
// size ...... 14618 (0x391a)
// includes .. 6   (offset: 0x35e6)
// strings ... 43  (offset: 0x3616)
// dev strs .. 10  (offset: 0x38a2)
// exports ... 18  (offset: 0x24da)
// cseg ...... 0x410 + 0x20ca (0x24da)
// imports ... 119 (offset: 0x27aa)
// animtree1 . 0   (offset: 0x391a)
// animtree2 . 0   (offset: 0x391a)
#using scripts\common\bots\bots_scripted_defense;
#using scripts\common\bots\bots_util;
#using scripts\common\equipment_common;
#using scripts\common\utility;
#using scripts\mp\bots\bots_util;
#using scripts\mp\common\gameobjects\gameobjects_common;

#namespace bots_strategy;

// Namespace bots_strategy
// Params 1
// Checksum 0xf34e31ae, Offset: 0x42e
// Size: 0x3e4
function function_c6152abaead059f6( var_4f1d38d46e8c3a00 )
{
    /#
        if ( getdvarint( @"bot_disableattack", 0 ) == 1 || self function_aaad5ae04c1e5224( "<dev string:x24>" ) == 1 )
        {
            return;
        }
        
        if ( getdvarint( @"hash_4e74c5e727aefee4", 0 ) == 1 )
        {
            return;
        }
    #/
    
    if ( self botgetdifficultysetting( "allowGrenades" ) == 0 )
    {
        return;
    }
    
    items = self getweaponslistall();
    useableitems = [];
    
    foreach ( item in items )
    {
        if ( item.inventorytype != "offhand" )
        {
            continue;
        }
        
        if ( self getweaponammoclip( item ) == 0 && self getweaponammostock( item ) == 0 )
        {
            continue;
        }
        
        useableitems[ useableitems.size ] = item;
    }
    
    if ( useableitems.size <= 0 )
    {
        return;
    }
    
    if ( !isarray( var_4f1d38d46e8c3a00 ) )
    {
        var_4f1d38d46e8c3a00 = [ var_4f1d38d46e8c3a00 ];
    }
    
    foreach ( purpose in var_4f1d38d46e8c3a00 )
    {
        foreach ( item in useableitems )
        {
            if ( bots_util::bot_item_matches_purpose( purpose, item ) )
            {
                result = spawnstruct();
                result.purpose = purpose;
                bot_lethal = self botfirstavailablegrenade( "lethal" );
                bot_tactical = self botfirstavailablegrenade( "tactical" );
                
                if ( !bot_lethal && !bot_tactical )
                {
                    continue;
                }
                
                if ( item == bot_lethal )
                {
                    result.item_action = "lethal";
                }
                else if ( item == bot_tactical )
                {
                    result.item_action = "tactical";
                }
                
                if ( !isdefined( result.item_action ) )
                {
                    assertmsg( "<dev string:x33>" + self.name + "<dev string:x39>" + item.basename + "<dev string:x5e>" );
                    continue;
                }
                
                switch ( item.var_5e3a1c87edc1edd5 )
                {
                    case #"c4":
                    case #"at_mine":
                    case #"shockstick_proximity":
                        result.placementtype = "throw";
                        break;
                    case #"hash_22d2079b97c4a1a4":
                        result.placementtype = "throw_forward";
                        break;
                }
                
                if ( !isdefined( result.placementtype ) )
                {
                    rootstring = getweaponrootstring( item );
                    
                    switch ( rootstring )
                    {
                        case #"hash_1cd346c1ee356308":
                        case #"hash_333525cef39d0c66":
                        case #"hash_4714926c2f3e2d15":
                        case #"hash_67182e3e0048056f":
                        case #"hash_f7d2b3d20ecdcc2c":
                            result.placementtype = "throw";
                            break;
                        case #"hash_36b7174a04de8799":
                            result.placementtype = "place";
                            break;
                    }
                }
                
                result.weap_ref = item;
                return result;
            }
        }
    }
}

// Namespace bots_strategy
// Params 5
// Checksum 0x1d8c482c, Offset: 0x81a
// Size: 0x66d, Type: bool
function bot_set_ambush_trap( trap_item, ambush_entrances, ambush_tacpoint, ambush_yaw, trap_tacpoint )
{
    self notify( #"bot_set_ambush_trap" );
    self endon( #"bot_set_ambush_trap" );
    assert( isdefined( trap_item ) );
    chosen_entrance = undefined;
    
    if ( !isdefined( trap_tacpoint ) && isdefined( ambush_entrances ) && ambush_entrances.size > 0 )
    {
        if ( !isdefined( ambush_tacpoint ) )
        {
            return false;
        }
        
        choose_set = [];
        fwd = undefined;
        
        if ( isdefined( ambush_yaw ) )
        {
            fwd = anglestoforward( ( 0, ambush_yaw, 0 ) );
        }
        
        foreach ( entrance in ambush_entrances )
        {
            if ( !isdefined( fwd ) )
            {
                choose_set[ choose_set.size ] = entrance;
                continue;
            }
            
            if ( distancesquared( entrance.groundpos, ambush_tacpoint.groundpos ) > 90000 )
            {
                var_a0a8a7294620c8da = self function_4a416cbec96dbbcf() || self function_40704e1fc9df1a06();
                
                if ( var_a0a8a7294620c8da || vectordot( fwd, vectornormalize( entrance.groundpos - ambush_tacpoint.groundpos ) ) < 0.4 )
                {
                    choose_set[ choose_set.size ] = entrance;
                }
            }
        }
        
        if ( choose_set.size > 0 )
        {
            chosen_entrance = utility::array_random( choose_set );
            trap_choices = function_a034a927128ada11( chosen_entrance.groundpos, 300, 50, 300 );
            tempchoices = [];
            
            foreach ( choice in trap_choices )
            {
                if ( !isdefined( choice.bot_ambush_end ) )
                {
                    tempchoices[ tempchoices.size ] = choice;
                }
            }
            
            trap_choices = tempchoices;
            trap_tacpoint = bots_util::function_ec1247a9311f67a4( "bot_set_ambush_trap -> tacpoint pick trap", trap_choices, min( trap_choices.size, 5 ), "trap", ambush_tacpoint, chosen_entrance );
        }
    }
    
    if ( isdefined( trap_tacpoint ) )
    {
        if ( self bothasscriptgoal() && self botgetscriptgoaltype() != "critical" && self botgetscriptgoaltype() != "tactical" )
        {
            self botclearscriptgoal();
        }
        
        assert( isdefined( trap_item.placementtype ) );
        assert( trap_item.placementtype == "<dev string:x60>" || trap_item.placementtype == "<dev string:x66>" || trap_item.placementtype == "<dev string:x74>" );
        
        if ( trap_item.placementtype == "throw" || trap_item.placementtype == "throw_forward" )
        {
            placeangles = vectortoangles( trap_tacpoint.origin - chosen_entrance.groundpos );
            goal_succeeded = self botsetscriptgoal( chosen_entrance, 0, "guard", placeangles[ 1 ] );
        }
        else if ( trap_item.placementtype == "place" )
        {
            goal_succeeded = self botsetscriptgoal( trap_tacpoint, 0, "guard" );
        }
        
        if ( goal_succeeded )
        {
            /#
                if ( getdvar( @"bot_drawdebugspecial" ) == "<dev string:x7a>" )
                {
                    time = 1000;
                    box( ambush_tacpoint.groundpos, 0, ( 0, 1, 0 ), 1, time );
                    box( trap_tacpoint.groundpos, 0, ( 1, 0, 0 ), 1, time );
                    box( chosen_entrance.groundpos, 0, ( 0, 0, 1 ), 1, time );
                }
            #/
            
            self botsetshorttermgoal( 1 );
            result = bots_util::bot_waittill_goal_or_fail();
            
            if ( result == "goal" )
            {
                thread bots_util::bot_force_stance_for_time( "stand", 4 );
                var_ee2eabd1fc8e9ed8 = self function_4a416cbec96dbbcf() || self function_40704e1fc9df1a06();
                
                if ( !isdefined( self.enemy ) || var_ee2eabd1fc8e9ed8 || !self botcanseeentity( self.enemy ) )
                {
                    thread bots_util::bot_disable_movement_for_time( 4 );
                    
                    if ( trap_item.placementtype == "place" )
                    {
                        self botlookatpoint( chosen_entrance.groundpos, 3, "script_forced" );
                    }
                    else if ( trap_item.placementtype == "throw" )
                    {
                        self botlookatpoint( trap_tacpoint.groundpos, 3, "script_forced" );
                    }
                    else if ( trap_item.placementtype == "throw_forward" )
                    {
                        self botlookatpoint( trap_tacpoint.groundpos + ( 0, 0, 58 ), 3, "script_forced" );
                    }
                    
                    wait 0.75;
                    assert( isdefined( trap_item ) );
                    assert( isdefined( trap_item.item_action ) );
                    bot_try_use_ambush_item( trap_item.item_action );
                    self.ambush_trap_ent = undefined;
                    thread bot_set_ambush_trap_wait_fire( "grenade_fire" );
                    thread bot_set_ambush_trap_wait_fire( "missile_fire" );
                    timetowait = trap_item.purpose == "tacticalinsertion" ? 6 : 3;
                    utility::waittill_any_timeout( timetowait, "missile_fire", "grenade_fire" );
                    wait 0.05;
                    self notify( #"ambush_trap_ent" );
                    
                    if ( isdefined( self.ambush_trap_ent ) && trap_item.purpose == "trap_activate" )
                    {
                        thread bot_watch_manual_detonate( self.ambush_trap_ent, 300 );
                    }
                    
                    self.ambush_trap_ent = undefined;
                    wait 0.5;
                    self notify( #"bot_force_stance_for_time" );
                    self botsetstance( "none" );
                    self switchtoweapon( "none" );
                    self notify( #"bot_disable_movement_for_time" );
                    self botsetflag( "disable_movement", 0 );
                    self botlookatpoint( undefined );
                }
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace bots_strategy
// Params 1
// Checksum 0x33103291, Offset: 0xe90
// Size: 0x47
function bot_try_use_ambush_item( button )
{
    assert( isdefined( button ) );
    assert( isstring( button ) );
    self endon( #"grenade_pullback" );
    
    while ( true )
    {
        self botpressbutton( button );
        wait 0.5;
    }
}

// Namespace bots_strategy
// Params 1
// Checksum 0x10793ec3, Offset: 0xedf
// Size: 0x59
function bot_set_ambush_trap_wait_fire( waitingfor )
{
    self endon( #"death_or_disconnect" );
    self endon( #"bot_set_ambush_trap" );
    self endon( #"ambush_trap_ent" );
    level endon( #"game_ended" );
    self waittill( waitingfor, ent );
    self.ambush_trap_ent = ent;
}

// Namespace bots_strategy
// Params 2
// Checksum 0x1b2d5417, Offset: 0xf40
// Size: 0xf3
function bot_watch_manual_detonate( grenade, range )
{
    self endon( #"death_or_disconnect" );
    grenade endon( #"death" );
    level endon( #"game_ended" );
    rangesq = range * range;
    
    while ( true )
    {
        if ( distancesquared( self.origin, grenade.origin ) > rangesq )
        {
            closestenemysq = self getclosestenemysqdist( grenade.origin, 1 );
            
            if ( closestenemysq < rangesq )
            {
                if ( equipment::function_c080e0b0ab2d9784( grenade.bundle ) )
                {
                    self botpressbutton( "use", 0.25 );
                    wait 0.35;
                    self botpressbutton( "use", 0.25 );
                }
                else
                {
                    self botpressbutton( "detonate_offhand" );
                    wait 1;
                }
            }
        }
        
        wait randomfloatrange( 0.25, 1 );
    }
}

// Namespace bots_strategy
// Params 1
// Checksum 0xfe173733, Offset: 0x103b
// Size: 0x1dd
function should_start_cautious_approach_default( firstcheck )
{
    var_c0f6db6802cec4f1 = 1500;
    var_f097ac34555c3be = var_c0f6db6802cec4f1 * var_c0f6db6802cec4f1;
    
    if ( firstcheck )
    {
        if ( self botgetdifficultysetting( "strategyLevel" ) == 0 )
        {
            return 0;
        }
        
        is_already_touching = 0;
        
        if ( self.bot_defending_type == "capture_zone" && isdefined( self.bot_defending_game_object ) )
        {
            if ( isent( self.bot_defending_game_object ) )
            {
                is_already_touching = self istouching( self.bot_defending_game_object );
            }
            else
            {
                is_already_touching = gameobjects_common::function_8a27a916a385b65c( self.bot_defending_game_object, self );
            }
        }
        
        if ( is_already_touching )
        {
            return 0;
        }
        
        return ( distancesquared( self.origin, self.bot_defending_center ) > var_f097ac34555c3be * 0.75 * 0.75 );
    }
    
    if ( self botpursuingscriptgoal() )
    {
        var_8bf13b3f974233fc = distancesquared( self.origin, self.bot_defending_center );
        
        if ( var_8bf13b3f974233fc < var_f097ac34555c3be )
        {
            return 1;
        }
        
        var_22ac62a0c977b624 = self botgetpathdist();
        
        if ( var_22ac62a0c977b624 >= 0 && var_22ac62a0c977b624 <= var_c0f6db6802cec4f1 )
        {
            return 1;
        }
        
        bot_path = self botgetpath();
        
        if ( bot_path && bot_path.size > 0 )
        {
            var_4028f5f6b729dfea = 0;
            
            foreach ( path_point in bot_path )
            {
                if ( path_point.type == "zoneNodePos" )
                {
                    var_4028f5f6b729dfea++;
                }
            }
            
            if ( var_4028f5f6b729dfea > 0 && var_4028f5f6b729dfea <= 3 )
            {
                return 1;
            }
        }
    }
    
    return 0;
}

// Namespace bots_strategy
// Params 2
// Checksum 0x6e748ade, Offset: 0x1220
// Size: 0x92
function setup_investigate_location( tacpoint, optional_origin )
{
    new_location = spawnstruct();
    assert( isdefined( tacpoint ), "<dev string:x88>" + new_location.origin + "<dev string:xa4>" );
    new_location.tacpoint = tacpoint;
    
    if ( isdefined( optional_origin ) )
    {
        new_location.origin = optional_origin;
    }
    else
    {
        new_location.origin = tacpoint.groundpos;
    }
    
    new_location.frames_visible = 0;
    return new_location;
}

// Namespace bots_strategy
// Params 0
// Checksum 0xfee6a9d7, Offset: 0x12bb
// Size: 0x782
function defense_cautious_approach()
{
    self notify( #"defense_cautious_approach" );
    self endon( #"defense_cautious_approach" );
    level endon( #"game_ended" );
    self endon( #"defend_force_goal_recalculation" );
    self endon( #"death_or_disconnect" );
    self endon( #"exit_autopilot" );
    self endon( #"hash_ee341639d000412d" );
    self endon( #"hash_6ee5ffa3cbacdfe" );
    
    if ( ![[ level.bot_funcs[ "should_start_cautious_approach" ] ]]( 1 ) )
    {
        return;
    }
    
    var_6afd6089b94323e9 = self botgetscriptgoal();
    var_d7626e3f6520bf60 = self function_2ce9558d679a85ff();
    
    /#
        if ( isdefined( var_d7626e3f6520bf60 ) )
        {
            assert( self.var_24c79f4f1d7b19ec == var_d7626e3f6520bf60 );
        }
        else
        {
            assert( isdefined( self.cur_defend_point_override ) );
            assert( bots_util_mp::bot_vectors_are_equal( var_6afd6089b94323e9, self.cur_defend_point_override ) );
        }
    #/
    
    should_continue_waiting = 1;
    var_17eec3d3f2392767 = 0.2;
    total_time_waited = 0;
    
    while ( should_continue_waiting )
    {
        wait 0.25;
        total_time_waited += 0.25;
        
        if ( !self bothasscriptgoal() )
        {
            return;
        }
        
        current_script_goal = self botgetscriptgoal();
        
        if ( !bots_util_mp::bot_vectors_are_equal( var_6afd6089b94323e9, current_script_goal ) )
        {
            return;
        }
        
        if ( total_time_waited >= 1 )
        {
            current_path = self botgetpath();
            
            if ( !current_path || current_path.size == 0 )
            {
                self botclearscriptgoal();
                return;
            }
        }
        
        var_17eec3d3f2392767 += 0.25;
        
        if ( var_17eec3d3f2392767 >= 0.5 )
        {
            var_17eec3d3f2392767 = 0;
            
            if ( [[ level.bot_funcs[ "should_start_cautious_approach" ] ]]( 0 ) )
            {
                should_continue_waiting = 0;
            }
        }
    }
    
    self botsetawareness( 1.8 );
    self botsetflag( "cautious", 1 );
    self.locations_to_investigate = [];
    radius_around_point = level.protect_radius ?? 1000;
    radius_around_point_sq = radius_around_point * radius_around_point;
    var_dc553676511e28cc = function_a034a927128ada11( self.bot_defending_center, radius_around_point, 0, 500 );
    
    if ( var_dc553676511e28cc.size <= 0 )
    {
        return;
    }
    
    var_dc553676511e28cc = bots_util::function_4eb61a3985ad712c( var_dc553676511e28cc );
    var_46147cde2ee09499 = 5 + self botgetdifficultysetting( "strategyLevel" ) * 2;
    var_8feba9104b0c7bc2 = int( min( var_46147cde2ee09499, var_dc553676511e28cc.size ) );
    var_cac9bd2ea70d91e1 = bots_util::function_75c1dc4534eb4f5d( "defense_cautious_approach -> tacpoint pick multiple protect", var_dc553676511e28cc, 15, var_8feba9104b0c7bc2, "protect", bots_scripted_defense::get_valid_center(), "ignore_occupancy" );
    
    foreach ( tacpoint in var_cac9bd2ea70d91e1 )
    {
        new_location = setup_investigate_location( tacpoint );
        self.locations_to_investigate[ self.locations_to_investigate.size ] = new_location;
    }
    
    killer_locations = botgetmemoryevents( 0, gettime() - 60000, 1, "death", 0, self );
    
    foreach ( location in killer_locations )
    {
        if ( distancesquared( location, self.bot_defending_center ) < radius_around_point_sq )
        {
            var_7c42a71c2ebeac55 = findclosesttacpointinsight( location );
            
            if ( isdefined( var_7c42a71c2ebeac55 ) )
            {
                new_location = setup_investigate_location( var_7c42a71c2ebeac55, location );
                self.locations_to_investigate[ self.locations_to_investigate.size ] = new_location;
            }
        }
    }
    
    if ( isdefined( self.defend_entrance_index ) )
    {
        var_361c954512198cd3 = bots_util::bot_get_entrances_for_stance_and_index( "stand", self.defend_entrance_index );
        
        foreach ( entrance in var_361c954512198cd3 )
        {
            new_location = setup_investigate_location( entrance );
            self.locations_to_investigate[ self.locations_to_investigate.size ] = new_location;
        }
    }
    
    if ( self.locations_to_investigate.size == 0 )
    {
        return;
    }
    
    childthread monitor_cautious_approach_dangerous_locations();
    goal_type = self botgetscriptgoaltype();
    final_goal_radius = self botgetscriptgoalradius();
    final_goal_yaw = self botgetscriptgoalyaw();
    waitframe();
    current_path_to_goal = self botgetpath();
    
    if ( !isdefined( current_path_to_goal ) || current_path_to_goal.size <= 1 )
    {
        return;
    }
    
    for ( current_path_index = 0; current_path_index < current_path_to_goal.size ; current_path_index++ )
    {
        path_point = current_path_to_goal[ current_path_index ];
        
        if ( path_point.type != "zoneNodePos" )
        {
            continue;
        }
        
        bots_util::bot_waittill_out_of_combat_or_time();
        potential_hide_tacpoints_with_visibility = bots_util::bot_queued_process_generic( "defense_cautious_approach -> find_potential_hide_tacpoints_with_visibility", "find_potential_hide_tacpoints_with_visibility", &find_potential_hide_tacpoints_with_visibility, path_point.zoneindex );
        
        if ( potential_hide_tacpoints_with_visibility.size == 0 )
        {
            continue;
        }
        
        hide_tacpoint = bots_util::function_ec1247a9311f67a4( "defense_cautious_approach -> tacpoint pick hide", potential_hide_tacpoints_with_visibility, 1 + potential_hide_tacpoints_with_visibility.size * 0.15, "hide" );
        
        if ( !isdefined( hide_tacpoint ) )
        {
            continue;
        }
        
        self botclearscriptgoal();
        self botsetscriptgoal( hide_tacpoint, 0, "critical" );
        childthread monitor_cautious_approach_early_out();
        result = bots_util::bot_waittill_goal_or_fail( undefined, "cautious_approach_early_out" );
        self notify( #"hash_d9047154d108abfa" );
        
        if ( result == "cautious_approach_early_out" )
        {
            break;
        }
        
        if ( result == "goal" )
        {
            var_7c25b0c915974679 = function_3ed7185c353b62d9( hide_tacpoint );
            
            foreach ( visible_location in var_7c25b0c915974679 )
            {
                if ( distance2dsquared( self.origin, visible_location.origin ) < 1600 )
                {
                    continue;
                }
                
                total_time_waited = 0;
                
                while ( visible_location.frames_visible < 18 && total_time_waited < 3.6 )
                {
                    self botlookatpoint( visible_location.origin + ( 0, 0, self getplayerviewheight() ), 0.25, "script_search" );
                    wait 0.25;
                    total_time_waited += 0.25;
                }
            }
        }
        
        if ( !isdefined( path_point.var_a4ecaa77502af1a7 ) )
        {
            path_point.var_a4ecaa77502af1a7 = 0;
        }
        
        path_point.var_a4ecaa77502af1a7++;
        
        if ( path_point.var_a4ecaa77502af1a7 <= 1 )
        {
            current_path_index--;
        }
        
        waitframe();
    }
    
    self notify( #"hash_f6289a110465ae78" );
    self botclearscriptgoal();
    
    if ( isdefined( var_d7626e3f6520bf60 ) )
    {
        radius = final_goal_radius == 16 ? 0 : final_goal_radius;
        self botsetscriptgoal( var_d7626e3f6520bf60, radius, goal_type, final_goal_yaw );
        return;
    }
    
    self botsetscriptgoal( self.cur_defend_point_override, final_goal_radius, goal_type, final_goal_yaw );
}

// Namespace bots_strategy
// Params 1
// Checksum 0x90fe74aa, Offset: 0x1a45
// Size: 0x16e
function find_potential_hide_tacpoints_with_visibility( zoneindex )
{
    potential_hide_tacpoints_with_visibility = [];
    var_1cb480a202330fb5 = getzonetacpoints( zoneindex );
    
    if ( var_1cb480a202330fb5.size > 0 )
    {
        var_1cb480a202330fb5 = function_7a2f256e52489a6( var_1cb480a202330fb5 );
        
        if ( var_1cb480a202330fb5.size > 0 )
        {
            origin = self.origin;
            player_angles = self getplayerangles();
            
            foreach ( potential_hide_tacpoint in var_1cb480a202330fb5 )
            {
                if ( withinfov( origin, player_angles, potential_hide_tacpoint.groundpos, 0 ) )
                {
                    foreach ( var_ac99c9bcc881c54f in self.locations_to_investigate )
                    {
                        if ( tacpointsvisible( var_ac99c9bcc881c54f.tacpoint, potential_hide_tacpoint ) )
                        {
                            potential_hide_tacpoints_with_visibility[ potential_hide_tacpoints_with_visibility.size ] = potential_hide_tacpoint;
                            break;
                        }
                    }
                }
            }
        }
    }
    
    return potential_hide_tacpoints_with_visibility;
}

// Namespace bots_strategy
// Params 1
// Checksum 0x7e97c42, Offset: 0x1bbc
// Size: 0xc5
function function_3ed7185c353b62d9( hide_tacpoint )
{
    var_7c25b0c915974679 = [];
    
    foreach ( var_ac99c9bcc881c54f in self.locations_to_investigate )
    {
        if ( tacpointsvisible( var_ac99c9bcc881c54f.tacpoint, hide_tacpoint ) )
        {
            if ( distance2dsquared( var_ac99c9bcc881c54f.origin, hide_tacpoint.groundpos ) > 3600 )
            {
                var_7c25b0c915974679[ var_7c25b0c915974679.size ] = var_ac99c9bcc881c54f;
            }
        }
    }
    
    return var_7c25b0c915974679;
}

// Namespace bots_strategy
// Params 0
// Checksum 0x9552c272, Offset: 0x1c8a
// Size: 0xab
function monitor_cautious_approach_early_out()
{
    self endon( #"cautious_approach_early_out" );
    self endon( #"hash_d9047154d108abfa" );
    capture_radius_sq = undefined;
    
    if ( isdefined( self.bot_defending_radius ) )
    {
        capture_radius_sq = self.bot_defending_radius * self.bot_defending_radius;
    }
    else if ( isdefined( self.bot_defending_tacpoints ) )
    {
        var_3d361c4c75080258 = bots_scripted_defense::function_a45d057831c7f3cf();
        capture_radius_sq = var_3d361c4c75080258 * var_3d361c4c75080258;
    }
    
    wait 0.05;
    
    while ( true )
    {
        if ( distancesquared( self.origin, self.bot_defending_center ) < capture_radius_sq )
        {
            self notify( #"cautious_approach_early_out" );
        }
        
        wait 0.05;
    }
}

// Namespace bots_strategy
// Params 0
// Checksum 0x80693625, Offset: 0x1d3d
// Size: 0x215
function monitor_cautious_approach_dangerous_locations()
{
    self endon( #"hash_f6289a110465ae78" );
    too_close_dist_sq = 10000;
    
    while ( true )
    {
        var_76127c52ea78e3a6 = self getnearesttacpoint();
        
        if ( isdefined( var_76127c52ea78e3a6 ) )
        {
            for ( i = 0; i < self.locations_to_investigate.size ; i++ )
            {
                /#
                    draw_debug = 0;
                    
                    if ( draw_debug )
                    {
                        frame_duration = getframeduration();
                        draw_frames = int( 50 / frame_duration );
                        line( self.origin + ( 0, 0, 20 ), self.locations_to_investigate[ i ].origin, ( 1, 0, 0 ), 1, 1, draw_frames );
                        bots_util_mp::bot_draw_cylinder( self.locations_to_investigate[ i ].origin, 10, 40, 0.05, undefined, ( 1, 0, 0 ), 1, 4 );
                    }
                #/
                
                if ( tacpointsvisible( var_76127c52ea78e3a6, self.locations_to_investigate[ i ].tacpoint ) )
                {
                    tacpoint_within_fov = self function_6c6e0a8bb89a022e( self.locations_to_investigate[ i ].origin );
                    
                    if ( distancesquared( self.origin, self.locations_to_investigate[ i ].origin ) < too_close_dist_sq )
                    {
                        tacpoint_within_fov = 1;
                        self.locations_to_investigate[ i ].frames_visible = 18;
                    }
                    
                    if ( tacpoint_within_fov )
                    {
                        self.locations_to_investigate[ i ].frames_visible++;
                        
                        if ( self.locations_to_investigate[ i ].frames_visible >= 18 )
                        {
                            self.locations_to_investigate[ i ] = self.locations_to_investigate[ self.locations_to_investigate.size - 1 ];
                            self.locations_to_investigate[ self.locations_to_investigate.size - 1 ] = undefined;
                            i--;
                        }
                    }
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace bots_strategy
// Params 0
// Checksum 0x24984577, Offset: 0x1f5a
// Size: 0x145, Type: bool
function bot_melee_tactical_insertion_check()
{
    now = gettime();
    
    if ( !isdefined( self.last_melee_ti_check ) || now - self.last_melee_ti_check > 1000 )
    {
        self.last_melee_ti_check = now;
        trap_item = function_c6152abaead059f6( "tacticalinsertion" );
        
        if ( !isdefined( trap_item ) )
        {
            return false;
        }
        
        if ( isdefined( self.enemy ) && self botcanseeentity( self.enemy ) )
        {
            return false;
        }
        
        mytacpoint = self getnearesttacpoint();
        
        if ( !isdefined( mytacpoint ) )
        {
            return false;
        }
        
        myzone = mytacpoint.navzoneindex;
        
        if ( !isdefined( myzone ) )
        {
            return false;
        }
        
        var_5bd4ceb6e5f55285 = botzonenearestcount( myzone, self.team, 1, "enemy_predict", ">", 0 );
        
        if ( !isdefined( var_5bd4ceb6e5f55285 ) )
        {
            return false;
        }
        
        var_d8d6d0142e017dda = function_a034a927128ada11( self.origin, 500, 0 );
        
        if ( var_d8d6d0142e017dda.size <= 0 )
        {
            return false;
        }
        
        place_tac = bots_util::function_ec1247a9311f67a4( "bot_melee_tactical_insertion_check -> tacpoint pick hide", var_d8d6d0142e017dda, var_d8d6d0142e017dda.size * 0.15, "hide" );
        
        if ( !isdefined( place_tac ) )
        {
            return false;
        }
        
        return bot_set_ambush_trap( trap_item, undefined, undefined, undefined, place_tac );
    }
    
    return false;
}

// Namespace bots_strategy
// Params 7
// Checksum 0xfe60f299, Offset: 0x20a8
// Size: 0x12f
function function_4b94dfba45ebf54c( position, radius, interactdist, interactoffset, interacttime, reachgoaltime, hacktrigger )
{
    self notify( #"hash_d44c34075497f6a8" );
    self endon( #"hash_d44c34075497f6a8" );
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( radius ) )
    {
        radius = 100;
    }
    
    if ( !isdefined( interactdist ) )
    {
        interactdist = 20;
    }
    
    if ( !isdefined( interactoffset ) )
    {
        interactoffset = ( 0, 0, 0 );
    }
    
    if ( !isdefined( interacttime ) )
    {
        interacttime = 1;
    }
    
    if ( !isdefined( reachgoaltime ) )
    {
        reachgoaltime = 10;
    }
    
    interactableobjs = bots_util_mp::function_b835a2f4a5581b50( position, radius, 1 );
    
    if ( interactableobjs.size == 0 )
    {
        return;
    }
    
    targetent = interactableobjs[ 0 ];
    interactpos = bots_util_mp::function_a55bf32f8c8ac4bb( targetent, interactdist, interactoffset );
    var_ebd8baaa0f282c1f = getclosestpointonnavmesh( interactpos );
    bots_scripted_defense::function_87e8deae08ce1a0();
    self botsetscriptgoal( var_ebd8baaa0f282c1f, interactdist - 10, "critical" );
    function_5bcd553ff10c08c3( targetent, interacttime, reachgoaltime, hacktrigger );
    return targetent;
}

// Namespace bots_strategy
// Params 4, eflags: 0x4
// Checksum 0x8e17835a, Offset: 0x21e0
// Size: 0xa8
function private function_5bcd553ff10c08c3( targetent, interacttime, reachgoaltime, hacktrigger )
{
    result = bots_util::bot_waittill_goal_or_fail( reachgoaltime );
    
    if ( result == "goal" )
    {
        bot_interact( targetent, interacttime, hacktrigger );
        return;
    }
    
    if ( arraycontains( [ "bad_path", "timeout" ], result ) && targetent && hacktrigger )
    {
        if ( targetent isscriptable() || targetent isscriptableinstance() )
        {
            targetent function_e3fcde595da2ca5f( self );
            return;
        }
        
        targetent notify( #"trigger", self );
    }
}

// Namespace bots_strategy
// Params 3
// Checksum 0x89d16a2a, Offset: 0x2290
// Size: 0xf9
function bot_interact( targetent, interacttime, hacktrigger )
{
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    var_5fa14b0984d67c48 = self function_aaad5ae04c1e5224( "disable_movement" );
    self botsetflag( "disable_movement", 1 );
    self botlookatpoint( targetent.origin, interacttime + 1, "script_forced" );
    wait 1;
    self botpressbutton( "use", interacttime );
    result = targetent utility::waittill_notify_or_timeout_return( "trigger", interacttime );
    
    if ( result == "timeout" && targetent && hacktrigger )
    {
        if ( targetent isscriptable() || targetent isscriptableinstance() )
        {
            targetent function_e3fcde595da2ca5f( self );
        }
        else
        {
            targetent notify( #"trigger", self );
        }
    }
    
    self botsetflag( "disable_movement", var_5fa14b0984d67c48 );
}

// Namespace bots_strategy
// Params 4
// Checksum 0x7f4facad, Offset: 0x2391
// Size: 0x149
function function_da9dba34334aaba( origin, radius, teams, timelimit )
{
    self endon( #"exit_autopilot" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    starttime = gettime();
    
    while ( getaiarrayinradius( origin, radius, teams ).size > 0 )
    {
        waittime = 20;
        
        if ( timelimit > 0 )
        {
            patroltime = ( gettime() - starttime ) / 1000;
            
            if ( patroltime >= timelimit )
            {
                break;
            }
            
            waittime = min( waittime, timelimit - patroltime );
        }
        
        bots_scripted_defense::patrol_area( origin, radius );
        wait waittime;
    }
    
    if ( timelimit > 0 )
    {
        aiarray = getaiarrayinradius( origin, radius, teams );
        
        foreach ( ai in aiarray )
        {
            if ( isalive( ai ) )
            {
                ai kill();
            }
        }
    }
}

