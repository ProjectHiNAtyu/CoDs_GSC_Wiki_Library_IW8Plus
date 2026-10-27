// scripts\mp\bots\bots_gametype_conf.gsc  (hash_3cbfa0cc4eebcc73.gscc) (size: 9493 Bytes / 0x2515 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdb9ef32b (3684627243)
// size ...... 9493 (0x2515)
// includes .. 8   (offset: 0x23e1)
// strings ... 14  (offset: 0x2421)
// dev strs .. 3   (offset: 0x24d9)
// exports ... 21  (offset: 0x1861)
// cseg ...... 0x137 + 0x172a (0x1861)
// imports ... 68  (offset: 0x1ba9)
// animtree1 . 0   (offset: 0x2515)
// animtree2 . 0   (offset: 0x2515)
#using scripts\common\bots\bots_tactical_goals;
#using scripts\common\bots\bots_util;
#using scripts\common\weapon;
#using scripts\mp\autopilot;
#using scripts\mp\bots\bots_personality;
#using scripts\mp\bots\bots_util;
#using scripts\mp\class;
#using scripts\mp\gameobjects;

#namespace bots_gametype_conf;

// Namespace bots_gametype_conf
// Params 0
// Checksum 0xa686aea2, Offset: 0x155
// Size: 0x10
function main()
{
    setup_callbacks();
    setup_bot_conf();
}

// Namespace bots_gametype_conf
// Params 0
// Checksum 0x7803c14c, Offset: 0x16d
// Size: 0x33
function setup_callbacks()
{
    level.bot_funcs[ "gametype_think" ] = &bot_conf_think;
    autopilot::initialize( undefined, undefined, [ "bot_conf_think", "clear_script_goal_on" ] );
}

// Namespace bots_gametype_conf
// Params 0
// Checksum 0x9248ea2c, Offset: 0x1a8
// Size: 0x22
function setup_bot_conf()
{
    level.bot_tag_obj_radius = 200;
    level.bot_tag_allowable_jump_height = 38;
    
    /#
        thread function_9c6405dc99cc4646();
    #/
}

/#

    // Namespace bots_gametype_conf
    // Params 0
    // Checksum 0x57384817, Offset: 0x1d2
    // Size: 0x4a0, Type: dev
    function function_9c6405dc99cc4646()
    {
        bots_util::bot_waittill_bots_enabled();
        setdevdvarifuninitialized( @"hash_242f40f6d99b93e9", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_934b83a4466df87a", "<dev string:x24>" );
        
        while ( true )
        {
            if ( getdvarint( @"bot_drawdebuggametype" ) == 1 )
            {
                if ( getdvarint( @"hash_242f40f6d99b93e9" ) == 0 )
                {
                    foreach ( tag in level.dogtags )
                    {
                        if ( tag bot_can_tag_interact_with( "<dev string:x26>" ) || tag bot_can_tag_interact_with( "<dev string:x2d>" ) )
                        {
                            bots_util_mp::bot_draw_circle( tag.curorigin, level.bot_tag_obj_radius, ( 1, 0, 0 ), 0, 16 );
                        }
                    }
                }
                else
                {
                    foreach ( tag in level.dogtags )
                    {
                        if ( tag bot_can_tag_interact_with( "<dev string:x26>" ) || tag bot_can_tag_interact_with( "<dev string:x2d>" ) )
                        {
                            bots_util_mp::bot_draw_circle( tag.curorigin, 10, ( 0, 1, 0 ), 1, 16 );
                        }
                    }
                    
                    foreach ( player in level.participants )
                    {
                        if ( !isdefined( player.team ) )
                        {
                            continue;
                        }
                        
                        if ( isalive( player ) && isdefined( player.tags_seen ) )
                        {
                            foreach ( tag in player.tags_seen )
                            {
                                if ( tag.tag bot_can_tag_interact_with( player.team ) )
                                {
                                    linecolor = undefined;
                                    
                                    if ( player.team != tag.tag.victim.team )
                                    {
                                        linecolor = ( 1, 0, 0 );
                                    }
                                    else
                                    {
                                        linecolor = ( 0, 0, 1 );
                                    }
                                    
                                    line( tag.tag.curorigin, player.origin + ( 0, 0, 20 ), linecolor, 1, 1 );
                                }
                            }
                        }
                    }
                }
            }
            
            if ( getdvarint( @"hash_934b83a4466df87a" ) == 1 )
            {
                foreach ( tag in level.dogtags )
                {
                    if ( tag bot_can_tag_interact_with( "<dev string:x26>" ) || tag bot_can_tag_interact_with( "<dev string:x2d>" ) )
                    {
                        if ( isdefined( tag.nearest_tacpoint ) )
                        {
                            bots_util_mp::bot_draw_cylinder( tag.nearest_tacpoint.groundpos, 10, 10, 0.05, undefined, ( 0, 0, 1 ), 1, 4 );
                            line( tag.curorigin, tag.nearest_tacpoint.groundpos, ( 0, 0, 1 ), 1, 1 );
                        }
                    }
                }
            }
            
            wait 0.05;
        }
    }

#/

// Namespace bots_gametype_conf
// Params 0
// Checksum 0xb725df1b, Offset: 0x67a
// Size: 0x4c5
function bot_conf_think()
{
    self notify( #"bot_conf_think" );
    self endon( #"bot_conf_think" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self.next_time_check_tags = gettime() + 500;
    self.tags_seen = [];
    childthread bot_watch_new_tags();
    
    if ( self.personality == "camper" )
    {
        self.conf_camper_camp_tags = randomint( 100 ) < 70;
        
        if ( !isdefined( self.conf_camping_tag ) )
        {
            self.conf_camping_tag = 0;
        }
    }
    
    while ( true )
    {
        if ( self function_bece775663e54d92() )
        {
            wait 1;
            continue;
        }
        
        var_e684562e1a7bb7c0 = isdefined( self.tag_getting );
        var_e3d7d9be2c1ccea6 = 0;
        
        if ( var_e684562e1a7bb7c0 && self bothasscriptgoal() )
        {
            script_goal = self botgetscriptgoal();
            
            if ( bots_util_mp::bot_vectors_are_equal( self.tag_getting.ground_pos, script_goal ) )
            {
                if ( self botpursuingscriptgoal() )
                {
                    var_e3d7d9be2c1ccea6 = 1;
                }
            }
            else if ( bots_tactical_goals::has_tactical_goal( "kill_tag" ) && self.tag_getting bot_can_tag_interact_with( self.team ) )
            {
                self.tag_getting = undefined;
                var_e684562e1a7bb7c0 = 0;
            }
        }
        
        self botsetflag( "force_sprint", var_e3d7d9be2c1ccea6 );
        self.tags_seen = bot_remove_invalid_tags( self.tags_seen );
        best_tag = bot_find_best_tag_from_array( self.tags_seen, 1 );
        var_255bfc05d16a6c8 = isdefined( best_tag );
        
        if ( var_e684562e1a7bb7c0 && !var_255bfc05d16a6c8 || !var_e684562e1a7bb7c0 && var_255bfc05d16a6c8 || var_e684562e1a7bb7c0 && var_255bfc05d16a6c8 && self.tag_getting != best_tag )
        {
            self.tag_getting = best_tag;
            self botclearscriptgoal();
            self notify( #"hash_e936cf932f4308e2" );
            bots_personality::clear_camper_data();
            bots_tactical_goals::abort_tactical_goal( "kill_tag" );
        }
        
        if ( isdefined( self.tag_getting ) )
        {
            self.conf_camping_tag = 0;
            
            if ( self.personality == "camper" && self.conf_camper_camp_tags )
            {
                var_1fe66d3ef9596bfd = 1;
                currentweapon = self getcurrentprimaryweapon();
                
                if ( !isweapon( currentweapon ) || weapon::isfistweapon( currentweapon ) || class::ismeleeweapon( currentweapon ) )
                {
                    var_1fe66d3ef9596bfd = 0;
                }
                
                if ( var_1fe66d3ef9596bfd )
                {
                    self.conf_camping_tag = 1;
                    
                    if ( bots_personality::should_select_new_ambush_point() )
                    {
                        if ( bots_personality::find_ambush_tacpoint( self.tag_getting.ground_pos, 1000 ) )
                        {
                            childthread bot_camp_tag( self.tag_getting, "camp" );
                        }
                        else
                        {
                            self.conf_camping_tag = 0;
                        }
                    }
                }
            }
            
            if ( !self.conf_camping_tag )
            {
                if ( !bots_tactical_goals::has_tactical_goal( "kill_tag" ) )
                {
                    extra_params = spawnstruct();
                    extra_params.script_goal_type = "objective";
                    extra_params.objective_radius = level.bot_tag_obj_radius;
                    extra_params.short_term_goal = 1;
                    bots_tactical_goals::new_tactical_goal( "kill_tag", self.tag_getting.ground_pos, 25, extra_params );
                }
            }
        }
        
        var_1b63e2d182bb9748 = 0;
        
        if ( isdefined( self.additional_tactical_logic_func ) )
        {
            var_1b63e2d182bb9748 = self [[ self.additional_tactical_logic_func ]]();
        }
        
        if ( !isdefined( self.tag_getting ) )
        {
            if ( !var_1b63e2d182bb9748 )
            {
                self [[ self.personality_update_function ]]();
            }
        }
        
        if ( gettime() > self.next_time_check_tags )
        {
            self.next_time_check_tags = gettime() + 500;
            new_visible_tags = bot_find_visible_tags();
            self.tags_seen = bot_combine_tag_seen_arrays( new_visible_tags, self.tags_seen );
        }
        
        /#
            if ( getdvarint( @"bot_drawdebuggametype" ) == 1 && getdvarint( @"hash_242f40f6d99b93e9" ) == 0 )
            {
                if ( isdefined( self.tag_getting ) && self.health > 0 )
                {
                    color = ( 0.5, 0, 0.5 );
                    
                    if ( self.team == "<dev string:x26>" )
                    {
                        color = ( 1, 0, 1 );
                    }
                    
                    if ( self.conf_camper_camp_tags )
                    {
                        color = ( 1, 0, 0 );
                    }
                    
                    line( self.origin + ( 0, 0, 40 ), self.tag_getting.curorigin + ( 0, 0, 10 ), color, 1, 1, 1 );
                }
            }
        #/
        
        wait 0.05;
    }
}

// Namespace bots_gametype_conf
// Params 1
// Checksum 0xe553c71f, Offset: 0xb47
// Size: 0x14
function bot_can_tag_interact_with( team )
{
    return gameobjects::caninteractwith( team );
}

// Namespace bots_gametype_conf
// Params 1
// Checksum 0x82a7be7f, Offset: 0xb64
// Size: 0xda, Type: bool
function bot_check_tag_above_head( tag )
{
    if ( tag.on_navmesh )
    {
        self_eye_pos = self.origin + ( 0, 0, 55 );
        
        if ( distance2dsquared( tag.curorigin, self_eye_pos ) < 144 )
        {
            var_d224eee05dcdd4c4 = tag.curorigin[ 2 ] - self_eye_pos[ 2 ];
            
            if ( var_d224eee05dcdd4c4 > 0 )
            {
                if ( var_d224eee05dcdd4c4 < level.bot_tag_allowable_jump_height )
                {
                    if ( !isdefined( self.last_time_jumped_for_tag ) )
                    {
                        self.last_time_jumped_for_tag = 0;
                    }
                    
                    if ( gettime() - self.last_time_jumped_for_tag > 3000 )
                    {
                        self.last_time_jumped_for_tag = gettime();
                        thread bot_jump_for_tag();
                    }
                }
                else
                {
                    tag.on_navmesh = 0;
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace bots_gametype_conf
// Params 0
// Checksum 0x27f7dbfd, Offset: 0xc47
// Size: 0x3b
function bot_jump_for_tag()
{
    self endon( #"death_or_disconnect" );
    self botsetstance( "stand" );
    wait 1;
    self botpressbutton( "jump" );
    wait 1;
    self botsetstance( "none" );
}

// Namespace bots_gametype_conf
// Params 0
// Checksum 0xef735dd6, Offset: 0xc8a
// Size: 0x60
function bot_watch_new_tags()
{
    while ( true )
    {
        if ( isdefined( level.collectiblesettings ) )
        {
            level waittill( #"hash_89391d390b578c05", newcollectible );
            level thread function_cca68727458cd14c( self, newcollectible );
            continue;
        }
        
        level waittill( #"new_tag_spawned", newtag );
        level thread function_cca68727458cd14c( self, newtag );
    }
}

// Namespace bots_gametype_conf
// Params 1
// Checksum 0x98988ad6, Offset: 0xcf2
// Size: 0x3f, Type: bool
function function_2a921d2771b99df4( tag_testing )
{
    if ( isdefined( tag_testing.on_navmesh ) )
    {
        return false;
    }
    
    if ( tag_testing.calculations_in_progress )
    {
        return false;
    }
    
    if ( tag_testing.tag_moving )
    {
        return false;
    }
    
    return true;
}

// Namespace bots_gametype_conf
// Params 2
// Checksum 0xffb62c28, Offset: 0xd3a
// Size: 0xeb
function function_cca68727458cd14c( bot, newtag )
{
    bot.next_time_check_tags = -1;
    
    if ( isdefined( newtag ) )
    {
        if ( newtag.owner == bot || newtag.victim == bot || newtag.attacker == bot )
        {
            if ( function_2a921d2771b99df4( newtag ) )
            {
                thread function_22060d6b0e45b330( newtag );
                function_21311ed64055b55b( newtag );
                
                if ( newtag.on_navmesh )
                {
                    new_tag_struct = spawnstruct();
                    new_tag_struct.origin = newtag.curorigin;
                    new_tag_struct.tag = newtag;
                    var_3df76df80cadd7a3[ 0 ] = new_tag_struct;
                    bot.tags_seen = bot_combine_tag_seen_arrays( var_3df76df80cadd7a3, bot.tags_seen );
                }
            }
        }
    }
}

// Namespace bots_gametype_conf
// Params 2
// Checksum 0xf4e00521, Offset: 0xe2d
// Size: 0x14c
function bot_combine_tag_seen_arrays( var_36283f9a84ffc7f5, var_1e3c3cca4e0c8458 )
{
    new_array = var_1e3c3cca4e0c8458;
    
    foreach ( new_tag in var_36283f9a84ffc7f5 )
    {
        var_da06c42f5ee251c8 = 0;
        
        foreach ( old_tag in var_1e3c3cca4e0c8458 )
        {
            if ( new_tag.tag == old_tag.tag && bots_util_mp::bot_vectors_are_equal( new_tag.origin, old_tag.origin ) )
            {
                var_da06c42f5ee251c8 = 1;
                break;
            }
        }
        
        if ( !var_da06c42f5ee251c8 )
        {
            new_array[ new_array.size ] = new_tag;
        }
    }
    
    return new_array;
}

// Namespace bots_gametype_conf
// Params 2
// Checksum 0x6954f764, Offset: 0xf82
// Size: 0x103, Type: bool
function bot_is_tag_visible( tag, nearest_tacpoint_self )
{
    if ( function_2a921d2771b99df4( tag ) )
    {
        thread function_22060d6b0e45b330( tag );
    }
    
    if ( isdefined( tag.calculations_in_progress ) )
    {
        return false;
    }
    
    if ( !tag.on_navmesh )
    {
        return false;
    }
    
    if ( !tag.calculated_nearest_tacpoint )
    {
        tag.nearest_tacpoint = findclosesttacpointinsight( tag.curorigin );
        tag.calculated_nearest_tacpoint = 1;
    }
    
    var_8e3ad9939348b676 = tag.nearest_tacpoint;
    var_a81cd529caed79d4 = !isdefined( tag.on_navmesh );
    
    if ( isdefined( var_8e3ad9939348b676 ) && ( var_a81cd529caed79d4 || tag.on_navmesh ) )
    {
        tacpoint_visible = var_8e3ad9939348b676 == nearest_tacpoint_self || tacpointsvisible( var_8e3ad9939348b676, nearest_tacpoint_self, 1 );
        
        if ( tacpoint_visible )
        {
            if ( self function_6c6e0a8bb89a022e( tag.curorigin ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace bots_gametype_conf
// Params 0
// Checksum 0xbaf834a7, Offset: 0x108e
// Size: 0x2a9
function bot_find_visible_tags()
{
    nearest_tacpoint_self = self getnearesttacpoint();
    visible_tags = [];
    
    if ( isdefined( nearest_tacpoint_self ) && isdefined( level.dogtags ) )
    {
        foreach ( tag in level.dogtags )
        {
            if ( tag bot_can_tag_interact_with( self.team ) )
            {
                add_tag = 0;
                
                if ( tag.attacker == self || tag.victim == self )
                {
                    if ( function_2a921d2771b99df4( tag ) )
                    {
                        level thread function_22060d6b0e45b330( tag );
                        function_21311ed64055b55b( tag );
                        add_tag = tag.on_navmesh;
                    }
                }
                else if ( bot_is_tag_visible( tag, nearest_tacpoint_self ) )
                {
                    add_tag = 1;
                }
                
                if ( add_tag )
                {
                    new_tag_struct = spawnstruct();
                    new_tag_struct.origin = tag.curorigin;
                    new_tag_struct.tag = tag;
                    visible_tags[ visible_tags.size ] = new_tag_struct;
                }
            }
        }
    }
    
    if ( isdefined( level.collectiblesettings ) )
    {
        if ( isdefined( nearest_tacpoint_self ) && isdefined( level.collectibles ) )
        {
            foreach ( collectible in level.collectibles )
            {
                if ( collectible bot_can_tag_interact_with( self.team ) )
                {
                    add_tag = 0;
                    
                    if ( collectible.attacker == self || collectible.owner == self )
                    {
                        if ( function_2a921d2771b99df4( collectible ) )
                        {
                            level thread function_22060d6b0e45b330( collectible );
                            function_21311ed64055b55b( collectible );
                            add_collectible = collectible.on_navmesh;
                        }
                    }
                    else if ( bot_is_tag_visible( collectible, nearest_tacpoint_self ) )
                    {
                        add_collectible = 1;
                    }
                    
                    if ( add_collectible )
                    {
                        var_a739f0652646fb33 = spawnstruct();
                        var_a739f0652646fb33.origin = collectible.origin;
                        var_a739f0652646fb33.collectible = collectible;
                        visible_tags[ visible_tags.size ] = var_a739f0652646fb33;
                    }
                }
            }
        }
    }
    
    return visible_tags;
}

// Namespace bots_gametype_conf
// Params 1
// Checksum 0x857551d2, Offset: 0x1340
// Size: 0xa9
function function_22060d6b0e45b330( tag )
{
    tag endon( #"reset" );
    tag.calculations_in_progress = 1;
    tag.on_navmesh = bots_util::function_443e66298844a5a( tag.curorigin, 16, level.bot_tag_allowable_jump_height + 55 );
    
    if ( tag.on_navmesh )
    {
        tag.ground_pos = getgroundposition( tag.curorigin, 0, 256, 32 );
        
        if ( !isdefined( tag.ground_pos ) )
        {
            tag.on_navmesh = 0;
        }
    }
    
    tag.calculations_in_progress = undefined;
}

// Namespace bots_gametype_conf
// Params 1
// Checksum 0x6bb19723, Offset: 0x13f1
// Size: 0x25
function function_21311ed64055b55b( tag )
{
    while ( !isdefined( tag.on_navmesh ) )
    {
        wait 0.05;
    }
}

// Namespace bots_gametype_conf
// Params 2
// Checksum 0x2e1c6c9e, Offset: 0x141e
// Size: 0x114
function bot_find_best_tag_from_array( tag_array, var_ac99dbd403290005 )
{
    best_tag = undefined;
    
    if ( tag_array.size > 0 )
    {
        best_tag_dist_sq = 9999800001;
        
        foreach ( tag_struct in tag_array )
        {
            num_allies_getting_tag = get_num_allies_getting_tag( tag_struct.tag );
            
            if ( !var_ac99dbd403290005 || num_allies_getting_tag < 2 )
            {
                var_be5e39729ed388c9 = distancesquared( tag_struct.tag.ground_pos, self.origin );
                
                if ( var_be5e39729ed388c9 < best_tag_dist_sq )
                {
                    best_tag = tag_struct.tag;
                    best_tag_dist_sq = var_be5e39729ed388c9;
                }
            }
        }
    }
    
    return best_tag;
}

// Namespace bots_gametype_conf
// Params 1
// Checksum 0xa5c10a1d, Offset: 0x153b
// Size: 0x11d
function bot_remove_invalid_tags( tags )
{
    valid_tags = [];
    
    foreach ( tag_struct in tags )
    {
        if ( !isdefined( tag_struct.tag.on_navmesh ) )
        {
            continue;
        }
        
        if ( tag_struct.tag.is_collected )
        {
            continue;
        }
        
        if ( tag_struct.tag bot_can_tag_interact_with( self.team ) && bots_util_mp::bot_vectors_are_equal( tag_struct.tag.curorigin, tag_struct.origin ) )
        {
            if ( !bot_check_tag_above_head( tag_struct.tag ) )
            {
                valid_tags[ valid_tags.size ] = tag_struct;
            }
        }
    }
    
    return valid_tags;
}

// Namespace bots_gametype_conf
// Params 1
// Checksum 0xd18d599d, Offset: 0x1661
// Size: 0x102
function get_num_allies_getting_tag( tag )
{
    num = 0;
    
    foreach ( player in level.participants )
    {
        if ( !isdefined( player.team ) )
        {
            continue;
        }
        
        if ( player.team == self.team && player != self )
        {
            if ( isai( player ) )
            {
                if ( player.tag_getting == tag )
                {
                    num++;
                }
                
                continue;
            }
            
            if ( distancesquared( player.origin, tag.curorigin ) < 160000 )
            {
                num++;
            }
        }
    }
    
    return num;
}

// Namespace bots_gametype_conf
// Params 3
// Checksum 0x512835b3, Offset: 0x176c
// Size: 0xf5
function bot_camp_tag( tag, goal_type, optional_endon )
{
    self notify( #"bot_camp_tag" );
    self endon( #"bot_camp_tag" );
    self endon( #"hash_e936cf932f4308e2" );
    
    if ( isdefined( optional_endon ) )
    {
        self endon( optional_endon );
    }
    
    self botsetscriptgoal( self.var_624c9f3d7225954, 0, goal_type, self.ambush_yaw );
    result = bots_util::bot_waittill_goal_or_fail();
    
    if ( result == "goal" )
    {
        var_8e3ad9939348b676 = tag.nearest_tacpoint;
        
        if ( isdefined( var_8e3ad9939348b676 ) )
        {
            var_ee2b73b69a2b2e6f = self getnearesttacpoint();
            
            if ( isdefined( var_ee2b73b69a2b2e6f ) )
            {
                var_75ed9ce4d5888c0f = bots_util::function_f3e86dad4d2f79dc( "bot_camp_tag -> tacpoint nearest bot", var_ee2b73b69a2b2e6f );
            }
            else
            {
                var_75ed9ce4d5888c0f = bots_util::function_f3e86dad4d2f79dc( "bot_camp_tag -> self origin", self.origin );
            }
            
            var_75ed9ce4d5888c0f[ var_75ed9ce4d5888c0f.size ] = var_8e3ad9939348b676;
            childthread bots_util_mp::bot_watch_tacpoints( var_75ed9ce4d5888c0f );
        }
    }
}

