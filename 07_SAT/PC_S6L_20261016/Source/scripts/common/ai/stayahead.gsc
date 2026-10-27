// scripts\common\ai\stayahead.gsc  (hash_33d04d8e3a926cb1.gscc) (size: 32459 Bytes / 0x7ecb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa440c65b (2755708507)
// size ...... 32459 (0x7ecb)
// includes .. 3   (offset: 0x777b)
// strings ... 84  (offset: 0x7793)
// dev strs .. 37  (offset: 0x7ccf)
// exports ... 49  (offset: 0x5d03)
// cseg ...... 0x88e + 0x5475 (0x5d03)
// imports ... 132 (offset: 0x64ab)
// animtree1 . 0   (offset: 0x7ecb)
// animtree2 . 0   (offset: 0x7ecb)
#using scripts\common\ai\ai_utility;
#using scripts\common\math;
#using scripts\common\utility;

#namespace stayahead;

// Namespace stayahead
// Params 1
// Checksum 0x9799cc1f, Offset: 0x8ac
// Size: 0x209f
function stayahead_thread( followent )
{
    self endon( #"death" );
    self endon( #"stop_stayahead" );
    
    if ( !isdefined( self.stayahead ) )
    {
        self.stayahead = spawnstruct();
    }
    
    if ( !utility::ent_flag_exist( "stayahead_pause" ) )
    {
        utility::ent_flag_init( "stayahead_pause" );
    }
    
    thread stayahead_watch_end();
    childthread pause_flag_monitor();
    dir = anglestoforward( self.angles );
    dir_prev = anglestoforward( self.angles );
    lastpos = "";
    prevpos = "";
    goalpos = get_goalpos();
    prevgoalpos = [ self.origin ];
    lastframeinfo = undefined;
    scriptedanim = undefined;
    self.stayahead.lookat_last = gettime();
    self.stayahead.exit_speed = undefined;
    self.stayahead.exit_finish_time = undefined;
    self.stayahead.exit_last_finish_time = undefined;
    self.stayahead.wait_node_radius = 400;
    self.stayahead.dir = anglestoforward( self.angles );
    
    if ( !isdefined( self.stayahead.p1 ) )
    {
        self.stayahead.p1 = [];
    }
    
    while ( true )
    {
        if ( isdefined( self.stayahead.team ) && !isdefined( self.stayahead.team_thinking ) )
        {
            thread stayahead_team_think();
        }
        
        lastgoalpos = goalpos;
        goalpos = get_goalpos();
        
        if ( lastgoalpos[ 0 ] != goalpos[ 0 ] )
        {
            prevgoalpos = lastgoalpos;
        }
        
        if ( isdefined( self.stayahead.turbo ) )
        {
            p1speed = self.stayahead.turbo;
            p2speed = self.stayahead.turbo;
            p3speed = self.stayahead.turbo;
            p4speed = self.stayahead.turbo;
            p1var = 0;
            p2var = 0;
            p3var = 0;
            p4var = 0;
        }
        else
        {
            p1speed = self.stayahead.p1[ "speed" ];
            p2speed = self.stayahead.p2[ "speed" ];
            p3speed = self.stayahead.p3[ "speed" ];
            p4speed = self.stayahead.p4[ "speed" ];
            p1var = self.stayahead.p1[ "variance" ] ?? 0.2;
            p2var = self.stayahead.p2[ "variance" ] ?? 0.2;
            p3var = self.stayahead.p3[ "variance" ] ?? 0.2;
            p4var = self.stayahead.p4[ "variance" ] ?? 0.2;
        }
        
        p1dist = self.stayahead.p1[ "distance" ];
        p2dist = self.stayahead.p2[ "distance" ];
        p3dist = self.stayahead.p3[ "distance" ];
        p4dist = self.stayahead.p4[ "distance" ];
        pwdist = undefined;
        pwspeed = undefined;
        pwbuffer = undefined;
        
        if ( isdefined( self.stayahead.pw ) )
        {
            pwdist = self.stayahead.pw[ "distance" ];
            pwspeed = self.stayahead.pw[ "speed" ];
            pwbuffer = self.stayahead.pw[ "buffer" ] ?? 1.5;
            pwbuffer *= 20;
        }
        
        /#
            if ( getdvarint( @"scr_debug_stayahead" ) )
            {
                if ( self.arriving )
                {
                    print3d_debug( self.origin + ( 0, 0, 16 ), "<dev string:x24>" + self.arriving, ( 0.9, 0.9, 0.9 ), 0.9, 0.3 );
                }
                
                if ( self._blackboard.var_5ee32e89826cf63f )
                {
                    print2d3d_debug( self.origin + ( 0, 0, 12 ), "<dev string:x2f>" + self._blackboard.var_5ee32e89826cf63f, ( 0.9, 0.9, 0.9 ), 0.9, 0.3, 1, 0, "<dev string:x43>", 5 );
                }
                
                thread create_2d_background();
                
                if ( utility::ent_flag( "<dev string:x49>" ) )
                {
                    level thread create_2d_text( "<dev string:x59>", ( 1, 0, 0 ), "<dev string:x6c>", 0, 1 );
                }
                else
                {
                    level thread create_2d_text( "<dev string:x71>", ( 0, 1, 1 ), "<dev string:x6c>", 0, 1 );
                }
                
                level thread create_2d_text( "<dev string:x78>", ( 0, 1, 1 ), "<dev string:x43>", 0, 1 );
                level thread create_2d_text( "<dev string:x7b>" + level.player getdemeanorviewmodel(), ( 0, 1, 1 ), "<dev string:x6c>", 1, 1 );
                level thread create_2d_text( "<dev string:x78>", ( 0, 1, 1 ), "<dev string:x6c>", 4, 1 );
                
                if ( isdefined( self.demeanoroverride ) )
                {
                    level thread create_2d_text( "<dev string:x7b>" + self.demeanoroverride, ( 0, 1, 1 ), "<dev string:x6c>", 5, 1 );
                }
                
                if ( isdefined( self.goalradius ) )
                {
                    level thread create_2d_text( "<dev string:x86>" + self.goalradius, ( 0, 1, 1 ), "<dev string:x6c>", 6, 1 );
                }
                
                if ( isdefined( level.player.movementstate ) )
                {
                    level thread create_2d_text( "<dev string:x93>" + level.player.movementstate, ( 0, 1, 1 ), "<dev string:x6c>", 2, 1 );
                }
                
                if ( isdefined( level.player.movespeedscale ) )
                {
                    level thread create_2d_text( "<dev string:xa4>" + level.player.movespeedscale, ( 0, 1, 1 ), "<dev string:x6c>", 3, 1 );
                }
            }
        #/
        
        fwdpos = utility::flat_origin( self getposonpath( 32 ) );
        goalpos2d = utility::flat_origin( goalpos[ 0 ] );
        prevgoalpos2d = utility::flat_origin( prevgoalpos[ 0 ] );
        origin2d = utility::flat_origin( self.origin );
        
        if ( self isinscriptedstate() )
        {
            if ( isdefined( self.stayahead.exit_speed ) && !isdefined( self.stayahead.exit_finish_time ) )
            {
                self.stayahead.exit_finish_time = gettime();
                self.stayahead.exit_last_finish_time = self.stayahead.exit_finish_time;
            }
            else
            {
                self.stayahead.exit_speed = undefined;
                self.stayahead.exit_finish_time = undefined;
            }
            
            print2d3d_debug( self.origin + ( 0, 0, 30 ), "dir: SCRIPTED ANIM: " + gettime(), ( 0.9, 0.9, 0.9 ), 0.9, 0.3, 1, 0, "right", 4 );
        }
        else if ( self.arriving || distancesquared( goalpos2d, origin2d ) < 1024 )
        {
            if ( isdefined( self.stayahead.exit_speed ) && !isdefined( self.stayahead.exit_finish_time ) )
            {
                self.stayahead.exit_finish_time = gettime();
                self.stayahead.exit_last_finish_time = self.stayahead.exit_finish_time;
            }
            else
            {
                self.stayahead.exit_speed = undefined;
                self.stayahead.exit_finish_time = undefined;
            }
            
            if ( isdefined( self.goalnode ) && self.goalnode.script_useangles )
            {
                print2d3d_debug( self.origin + ( 0, 0, 30 ), "dir: arriving/close USEANGLES OVERRIDE vector: " + gettime(), ( 0.9, 0.9, 0.9 ), 0.9, 0.3, 1, 0, "right", 4 );
                dir = lerp_plane_vector( dir, anglestoforward( self.goalnode.angles ) );
            }
            else if ( isdefined( goalpos[ 1 ] ) )
            {
                print2d3d_debug( self.origin + ( 0, 0, 30 ), "dir: arriving/close GOAL vector: " + gettime(), ( 0.9, 0.9, 0.9 ), 0.9, 0.3, 1, 0, "right", 4 );
                goalpos2d = utility::flat_origin( goalpos[ 1 ] );
                dir = lerp_plane_vector( dir, vectornormalize( goalpos2d - origin2d ) );
            }
            else
            {
                print2d3d_debug( self.origin + ( 0, 0, 30 ), "dir: arriving/close FWD vector: " + gettime(), ( 0.9, 0.9, 0.9 ), 0.9, 0.3, 1, 0, "right", 4 );
                dir = lerp_plane_vector( dir, anglestoforward( self.angles ) );
            }
        }
        else if ( self._blackboard.var_5ee32e89826cf63f || distancesquared( prevgoalpos2d, origin2d ) < 1024 )
        {
            if ( self._blackboard.var_5ee32e89826cf63f && !isdefined( self.stayahead.exit_speed ) )
            {
                self.stayahead.exit_speed = -1;
            }
            
            if ( isdefined( self.using_goto_node ) )
            {
                print2d3d_debug( self.origin + ( 0, 0, 30 ), "dir: exiting GOTO vector: " + gettime(), ( 0.9, 0.9, 0.9 ), 0.9, 0.3, 1, 0, "right", 4 );
                goalpos2d = utility::flat_origin( goalpos[ 0 ] );
                dir = lerp_plane_vector( dir, vectornormalize( goalpos2d - prevgoalpos2d ) );
            }
            else if ( isdefined( goalpos[ 1 ] ) )
            {
                print2d3d_debug( self.origin + ( 0, 0, 30 ), "dir: exiting GOAL vector: " + gettime(), ( 0.9, 0.9, 0.9 ), 0.9, 0.3, 1, 0, "right", 4 );
                goalpos2d = utility::flat_origin( goalpos[ 1 ] );
                dir = lerp_plane_vector( dir, vectornormalize( goalpos2d - prevgoalpos2d ) );
            }
            else
            {
                print2d3d_debug( self.origin + ( 0, 0, 30 ), "dir: exiting FWD vector: " + gettime(), ( 0.9, 0.9, 0.9 ), 0.9, 0.3, 1, 0, "right", 4 );
                dir = lerp_plane_vector( dir, anglestoforward( self.angles ) );
            }
        }
        else
        {
            if ( isdefined( self.stayahead.exit_speed ) && !isdefined( self.stayahead.exit_finish_time ) )
            {
                self.stayahead.exit_finish_time = gettime();
                self.stayahead.exit_last_finish_time = self.stayahead.exit_finish_time;
            }
            else
            {
                self.exit_speed = undefined;
                self.exit_finish_time = undefined;
            }
            
            print2d3d_debug( self.origin + ( 0, 0, 30 ), "dir: stopped or moving to new goal: " + gettime(), ( 0.9, 0.9, 0.9 ), 0.9, 0.3, 1, 0, "right", 4 );
            
            if ( distance( fwdpos, origin2d ) < 1 )
            {
                print_debug( "STAYAHEAD: segments are colliding! " + gettime() );
                dir = lerp_plane_vector( dir, vectornormalize( goalpos2d - fwdpos ) );
            }
            else
            {
                dir = lerp_plane_vector( dir, vectornormalize( fwdpos - origin2d ) );
            }
        }
        
        p2pos = self.origin + dir * p2dist;
        p3pos = self.origin + dir * p3dist;
        p4pos = self.origin + dir * p4dist;
        var_880c100eb386bbc5 = distance( p2pos, p3pos ) * 0.25;
        var_356a82bfe6546dda = distance( p2pos, p3pos ) * 0.6;
        var_924a63ac7d1efb16 = distance( p2pos, p3pos ) * 0.25;
        var_ed48465f90441895 = distance( p3pos, p4pos ) * 0.6;
        var_624310cc35ca9aeb = distance( p3pos, p4pos ) * 0.25;
        var_c332bcd25546be4 = distance( p3pos, p4pos ) * 0.6;
        dotp2 = vectordot( vectornormalize( followent.origin - p2pos ), dir );
        dotp3 = vectordot( vectornormalize( followent.origin - p3pos ), dir );
        dotp4 = vectordot( vectornormalize( followent.origin - p4pos ), dir );
        p1pos = undefined;
        dotp1 = undefined;
        var_deb8053cdb84ff00 = undefined;
        var_e6de791de1c6b33b = undefined;
        
        if ( isdefined( p1dist ) )
        {
            p1pos = self.origin + dir * p1dist;
            dotp1 = vectordot( vectornormalize( followent.origin - p1pos ), dir );
            var_deb8053cdb84ff00 = distance( p1pos, p2pos ) * 0.25;
            var_e6de791de1c6b33b = distance( p1pos, p2pos ) * 0.6;
            var_880c100eb386bbc5 = distance( p1pos, p2pos ) * 0.25;
        }
        
        pwpos = undefined;
        dotpw = undefined;
        
        if ( isdefined( pwdist ) )
        {
            pwpos = self.origin + dir * pwdist;
            dotpw = vectordot( vectornormalize( followent.origin - pwpos ), dir );
        }
        
        /#
            if ( getdvarint( @"scr_debug_stayahead" ) )
            {
                debugangles = vectortoangles( dir );
                debugright = anglestoright( debugangles );
                debugleft = debugright * -1;
                var_5b2520468abb2edc = p2pos + dir * var_880c100eb386bbc5;
                var_a1dc2d100517dbd0 = p2pos + dir * var_356a82bfe6546dda * -1;
                var_4b25ef98b884701f = p3pos + dir * var_924a63ac7d1efb16;
                var_2aac32939ea0e96d = p3pos + dir * var_ed48465f90441895 * -1;
                var_f8f942997ef2f9a4 = p4pos + dir * var_624310cc35ca9aeb;
                var_6a470c2222ac4798 = p4pos + dir * var_c332bcd25546be4 * -1;
                line_debug( self.origin, goalpos[ 0 ], ( 0.9, 0.9, 0.9 ) );
                print3d_debug( goalpos[ 0 ], "<dev string:xb5>", ( 0.9, 0.9, 0.9 ), 0.9, 0.3, 1, 1 );
                offsetorigin = self.origin + ( 0, 0, 5 );
                line_debug( offsetorigin, offsetorigin + dir * 80, ( 0, 0, 0.9 ) );
                
                if ( isdefined( goalpos[ 1 ] ) )
                {
                    line_debug( goalpos[ 0 ], goalpos[ 1 ], ( 0.9, 0, 0 ) );
                    print3d_debug( goalpos[ 1 ], "<dev string:xbc>", ( 1, 0, 1 ), 0.9, 0.3, 1, 1 );
                }
                
                line_debug( p2pos + debugright * 300, p2pos + debugleft * 300, ( 1, 0, 0 ) );
                line_debug( p3pos + debugright * 300, p3pos + debugleft * 300, ( 0, 1, 0 ) );
                line_debug( p4pos + debugright * 300, p4pos + debugleft * 300, ( 0, 0, 1 ) );
                line_debug( var_5b2520468abb2edc + debugright * 300, var_5b2520468abb2edc + debugleft * 300, ( 1, 0.8, 0.8 ) );
                line_debug( var_a1dc2d100517dbd0 + debugright * 300, var_a1dc2d100517dbd0 + debugleft * 300, ( 1, 0.8, 0.8 ) );
                line_debug( var_4b25ef98b884701f + debugright * 300, var_4b25ef98b884701f + debugleft * 300, ( 0.8, 1, 0.8 ) );
                line_debug( var_2aac32939ea0e96d + debugright * 300, var_2aac32939ea0e96d + debugleft * 300, ( 0.8, 1, 0.8 ) );
                line_debug( var_f8f942997ef2f9a4 + debugright * 300, var_f8f942997ef2f9a4 + debugleft * 300, ( 0.8, 0.8, 1 ) );
                line_debug( var_6a470c2222ac4798 + debugright * 300, var_6a470c2222ac4798 + debugleft * 300, ( 0.8, 0.8, 1 ) );
                print3d_debug( p2pos, p2speed, ( 1, 0.25, 0.25 ), 0.9, 0.3 );
                print3d_debug( p3pos, p3speed, ( 0.5, 1, 0.5 ), 0.9, 0.3 );
                print3d_debug( p4pos, p4speed, ( 0.25, 0.25, 1 ), 0.9, 0.3 );
                print3d_debug( p2pos + ( 0, 0, -4 ), p2var, ( 1, 0.25, 0.25 ), 0.9, 0.3 );
                print3d_debug( p3pos + ( 0, 0, -4 ), p3var, ( 0.5, 1, 0.5 ), 0.9, 0.3 );
                print3d_debug( p4pos + ( 0, 0, -4 ), p4var, ( 0.25, 0.25, 1 ), 0.9, 0.3 );
                
                if ( isdefined( p1pos ) )
                {
                    line_debug( p1pos + debugright * 300, p1pos + debugleft * 300, ( 1, 0, 1 ) );
                    print3d_debug( p1pos, p1speed, ( 1, 0.25, 1 ), 0.9, 0.3 );
                    print3d_debug( p1pos + ( 0, 0, -4 ), p1var, ( 1, 0.25, 1 ), 0.9, 0.3 );
                    var_d48588c475be7039 = p1pos + dir * var_deb8053cdb84ff00;
                    var_61de375ee121d997 = p1pos + dir * var_e6de791de1c6b33b * -1;
                    line_debug( var_d48588c475be7039 + debugright * 300, var_d48588c475be7039 + debugleft * 300, ( 1, 0.8, 1 ) );
                    line_debug( var_61de375ee121d997 + debugright * 300, var_61de375ee121d997 + debugleft * 300, ( 1, 0.8, 1 ) );
                }
                
                if ( isdefined( pwpos ) )
                {
                    line_debug( pwpos + debugright * 300, pwpos + debugleft * 300, ( 0, 1, 1 ) );
                    print3d_debug( pwpos, "<dev string:xd4>", ( 0.25, 1, 1 ), 0.9, 0.3 );
                }
                
                print2d3d_debug( self.origin + ( 0, 0, 20 ), "<dev string:xd9>" + distancesquared( goalpos[ 0 ], self.origin ), ( 0.9, 0.9, 0.9 ), 0.9, 0.3, 1, 0, "<dev string:x43>", 3 );
                thread display_goto_path( ( 0, 1, 1 ) );
            }
        #/
        
        if ( utility::ent_flag( "stayahead_pause" ) )
        {
            waitframe();
            continue;
        }
        
        if ( isdefined( dotpw ) )
        {
            if ( !isdefined( self.stayahead.pw_behind_buffer ) )
            {
                self.stayahead.pw_behind_buffer = 0;
            }
            
            if ( !isdefined( self.stayahead.pw_infront_buffer ) )
            {
                self.stayahead.pw_infront_buffer = 0;
            }
            
            if ( dotpw < 0 )
            {
                self.stayahead.pw_infront_buffer = 0;
                
                if ( !isdefined( self.stayahead.goalnode ) )
                {
                    if ( isdefined( self.using_goto_node ) )
                    {
                        print3d_debug( self.origin + ( 0, 0, 10 ), "pw using goto goalnode", ( 1, 0, 1 ), 1, 0.5, 500, 1 );
                        
                        if ( isdefined( self.patharray ) )
                        {
                            self.stayahead.goalnode = self.patharray[ self.patharray.size - 1 ];
                        }
                        else
                        {
                            print3d_debug( self.origin + ( 0, 0, 14 ), "BAAAAD!!!  USING GOTO NODE BUT PATHARRAY IS NO LONGER DEFINED.  MAYBE A RACE CONDITION!", ( 1, 0, 0 ), 1, 0.5, 500, 1 );
                        }
                    }
                    else if ( isdefined( self.goalnode ) )
                    {
                        self.stayahead.goalnode = self.goalnode;
                    }
                    else
                    {
                        print3d_debug( self.origin, "pw no goalnode, goalpos?", ( 1, 0, 0 ), 1, 0.5, 200, 1 );
                    }
                }
                
                if ( isdefined( self.stayahead.goalnode ) && !isdefined( self.stayahead.goalnode_pw ) && self.stayahead.pw_behind_buffer > pwbuffer )
                {
                    var_cb97c3084705a885 = get_wait_node();
                    
                    if ( isdefined( var_cb97c3084705a885 ) && distance( self.origin, var_cb97c3084705a885.origin ) <= self.stayahead.wait_node_radius && distance( self.origin, var_cb97c3084705a885.origin ) > 32 && stayahead_goal_is_far_enough( var_cb97c3084705a885 ) )
                    {
                        self.stayahead.goalnode_pw = var_cb97c3084705a885;
                        line_debug( self.origin, self.origin + dir * -100, ( 1, 1, 1 ), 1, 0, 500 );
                        line_debug( self.origin, var_cb97c3084705a885.origin, ( 1, 0, 0 ), 1, 0, 500 );
                        print3d_debug( self.origin, "going to pW node: " + distance( self.origin, var_cb97c3084705a885.origin ) + " GoalRadius: " + self.goalradius, ( 1, 1, 0 ), 1, 0.3, 500, 1 );
                        childthread stayahead_wait_set_goal_or_path();
                        childthread stayahead_set_goalnode( var_cb97c3084705a885, 1 );
                    }
                    else if ( !isdefined( var_cb97c3084705a885 ) )
                    {
                        print2d3d_debug( self.origin + ( 0, 0, 16 ), "pW fail no wait nodes", ( 1, 0, 0 ), 1, 0.3, 1, 0, "right", 6 );
                    }
                    else if ( distance( self.origin, var_cb97c3084705a885.origin ) >= self.stayahead.wait_node_radius )
                    {
                        line_debug( self.origin, var_cb97c3084705a885.origin, ( 1, 0, 0 ), 1, 0, 1 );
                        print2d3d_debug( self.origin + ( 0, 0, 16 ), "pW fail wait node too far: " + distance( self.origin, var_cb97c3084705a885.origin ), ( 1, 0, 0 ), 1, 0.3, 1, 0, "right", 6 );
                    }
                    else if ( distance( self.origin, var_cb97c3084705a885.origin ) < 32 )
                    {
                        line_debug( self.origin, var_cb97c3084705a885.origin, ( 1, 0, 0 ), 1, 0, 1 );
                        print2d3d_debug( self.origin + ( 0, 0, 16 ), "pW fail wait node too close: " + distance( self.origin, var_cb97c3084705a885.origin ), ( 1, 0, 0 ), 1, 0.3, 1, 0, "right", 6 );
                    }
                }
                else if ( !isdefined( self.stayahead.goalnode ) )
                {
                    print2d3d_debug( self.origin + ( 0, 0, 16 ), "pW fail no goalnode or goto", ( 1, 0, 0 ), 1, 0.3, 1, 0, "right", 6 );
                }
                else if ( isdefined( self.stayahead.goalnode_pw ) )
                {
                    print2d3d_debug( self.origin + ( 0, 0, 16 ), "pW fail already have wait node", ( 1, 0, 0 ), 1, 0.3, 1, 0, "right", 6 );
                }
                else if ( self.stayahead.pw_behind_buffer < pwbuffer )
                {
                    print2d3d_debug( self.origin + ( 0, 0, 16 ), "pW fail buffer too small", ( 1, 0, 0 ), 1, 0.3, 1, 0, "right", 6 );
                }
                else
                {
                    print2d3d_debug( self.origin + ( 0, 0, 16 ), "pW fail uh oh!", ( 1, 0, 0 ), 1, 0.3, 1, 0, "right", 6 );
                }
                
                self.stayahead.pw_behind_buffer += 1;
                
                if ( self.stayahead.pw_behind_buffer > pwbuffer )
                {
                    print2d3d_debug( self.origin + ( 0, 0, 12 ), "pW behind buffer: " + self.stayahead.pw_behind_buffer, ( 1, 0, 0 ), 1, 0.3, 1, 0, "right", 7 );
                }
                else
                {
                    print2d3d_debug( self.origin + ( 0, 0, 12 ), "pW behind buffer: " + self.stayahead.pw_behind_buffer, ( 0, 0, 1 ), 1, 0.3, 1, 0, "right", 7 );
                }
            }
            else if ( isdefined( self.stayahead.goalnode ) && isdefined( self.stayahead.goalnode_pw ) )
            {
                self.stayahead.pw_behind_buffer = 0;
                
                if ( dotp4 > 0 && self.stayahead.pw_infront_buffer > pwbuffer * 0.4 || dotp3 > 0 )
                {
                    print3d_debug( self.origin, "going to OG goal: " + distance( self.origin, self.stayahead.goalnode.origin ), ( 0, 1, 0 ), 1, 0.3, 500, 1 );
                    self.stayahead.goalnode_pw = undefined;
                    childthread stayahead_set_goalnode( self.stayahead.goalnode, 0 );
                    self.stayahead.goalnode = undefined;
                }
                
                self.stayahead.pw_infront_buffer += 1;
                print2d3d_debug( self.origin + ( 0, 0, 12 ), "pW infront buffer: " + self.stayahead.pw_infront_buffer, ( 0, 1, 0 ), 1, 0.3, 1, 0, "right", 7 );
            }
            else
            {
                self notify( #"stop_stayahead_wait_func" );
                self.stayahead.pw_behind_buffer = 0;
                print2d3d_debug( self.origin + ( 0, 0, 12 ), "pW failing???", ( 1, 0, 0 ), 1, 0.3, 1, 0, "right", 5 );
            }
        }
        
        if ( dotp1 > 0 )
        {
            if ( lastpos != "p1Front" )
            {
                prevpos = lastpos;
                lastpos = "p1Front";
            }
            
            stayahead_set_speed( 1, followent, p1dist + var_deb8053cdb84ff00, p1dist, dir, p1speed, p1speed + p1speed * p1var, 1 );
        }
        else if ( dotp2 > 0 )
        {
            if ( lastpos != "p2Front" )
            {
                prevpos = lastpos;
                lastpos = "p2Front";
            }
            
            if ( prevpos == "p3Front" || prevpos == "" )
            {
                stayahead_set_speed( 2, followent, p2dist + var_880c100eb386bbc5, p2dist, dir, p2speed, p2speed + p2speed * p2var );
            }
            else if ( isdefined( dotp1 ) )
            {
                stayahead_set_speed( 1, followent, p1dist, p1dist - var_e6de791de1c6b33b, dir, p1speed + p1speed * p1var * -1, p1speed, 1 );
            }
            else
            {
                stayahead_set_speed( 2, followent, p2dist + var_880c100eb386bbc5, p2dist, dir, p2speed, p2speed + p2speed * p2var );
            }
        }
        else if ( dotp3 > 0 )
        {
            if ( lastpos != "p3Front" )
            {
                prevpos = lastpos;
                lastpos = "p3Front";
                stayahead_lookat( followent );
            }
            
            if ( prevpos == "p4Front" || prevpos == "" )
            {
                stayahead_set_speed( 3, followent, p3dist + var_924a63ac7d1efb16, p3dist, dir, p3speed, p3speed + p3speed * p3var );
            }
            else
            {
                stayahead_set_speed( 2, followent, p2dist, p2dist - var_356a82bfe6546dda, dir, p2speed + p2speed * p2var * -1, p2speed );
            }
        }
        else if ( dotp4 > 0 )
        {
            if ( lastpos != "p4Front" )
            {
                prevpos = lastpos;
                lastpos = "p4Front";
                stayahead_lookat( followent );
            }
            
            if ( prevpos == "p4Back" || prevpos == "" )
            {
                stayahead_set_speed( 4, followent, p4dist + var_624310cc35ca9aeb, p4dist, dir, p4speed, p4speed + p4speed * p4var );
            }
            else
            {
                stayahead_set_speed( 3, followent, p3dist, p3dist - var_ed48465f90441895, dir, p3speed + p3speed * p3var * -1, p3speed );
            }
        }
        else if ( dotp4 < 0 )
        {
            if ( dotpw < 0 )
            {
            }
            
            if ( lastpos != "p4Back" )
            {
                prevpos = lastpos;
                lastpos = "p4Back";
                stayahead_lookat( followent );
            }
            
            stayahead_set_speed( "W", followent, p4dist, p4dist - var_c332bcd25546be4, dir, p4speed + p4speed * p4var * -1, p4speed );
        }
        else
        {
            print2d3d_debug( self.origin + ( 0, 0, 30 ), "uh oh!", ( 0.9, 0, 0 ), 0.9, 0.3, 250, 0, "right", 4 );
        }
        
        waitframe();
    }
}

// Namespace stayahead
// Params 1
// Checksum 0x8e8beec1, Offset: 0x2953
// Size: 0x13f
function stayahead_lookat( followent )
{
    if ( !self.stayahead.lookat_allowed )
    {
        return;
    }
    
    if ( self.lookingatent )
    {
        print3d_debug( self.origin + ( 0, 0, 50 ), "look skipped, already looking", ( 0.9, 0, 0 ), 0.9, 0.3, 250 );
        return;
    }
    
    if ( gettime() - self.stayahead.lookat_last < 3000 )
    {
        print3d_debug( self.origin + ( 0, 0, 50 ), "look skipped, too soon", ( 0.9, 0, 0 ), 0.9, 0.3, 250 );
        return;
    }
    
    self notify( #"stop_stayahead_lookat" );
    self endon( #"death" );
    self endon( #"stop_stayahead_lookat" );
    lookattime = 0.5;
    self.stayahead.lookat_last = gettime();
    childthread stayahead_lookat_debug( lookattime );
    utility::lookatentity( followent );
    utility::delaythread( lookattime, &utility::lookatentity );
    wait lookattime * 0.6;
}

// Namespace stayahead
// Params 1
// Checksum 0x49fb5d, Offset: 0x2a9a
// Size: 0x55
function stayahead_lookat_far( followent )
{
    self endon( #"death" );
    lookatdelay = randomfloatrange( 6000, 11000 );
    
    if ( gettime() > self.stayahead.lookat_last + lookatdelay )
    {
        stayahead_lookat( followent );
    }
}

// Namespace stayahead
// Params 1
// Checksum 0x260d682d, Offset: 0x2af7
// Size: 0x7d
function stayahead_lookat_debug( lookattime )
{
    /#
        if ( getdvarint( @"scr_debug_stayahead" ) )
        {
            starttime = gettime();
            
            while ( gettime() - starttime + lookattime * 1000 )
            {
                print3d_debug( self.origin + ( 0, 0, 60 ), "<dev string:xea>", ( 0.9, 0, 0 ), 0.9, 0.3 );
                waitframe();
            }
        }
    #/
}

// Namespace stayahead
// Params 8
// Checksum 0x168bf8d7, Offset: 0x2b7c
// Size: 0x4cc
function stayahead_set_speed( plane, followent, forwarddist, backdist, dir, minspeed, maxspeed, catchup )
{
    print2d3d_debug( self.origin, "Plane: " + plane, ( 0.9, 0.9, 0.9 ), 0.9, 0.3, 1, 0, "right", 1 );
    forwardpos = self.origin + dir * forwarddist;
    backpos = self.origin + dir * backdist;
    
    if ( distance( forwardpos, backpos ) < 1 )
    {
        print_debug( "segments are colliding, not setting speed! " + gettime() );
        return;
    }
    
    playerpos = pointonsegmentnearesttopoint( forwardpos, backpos, followent.origin );
    dist = distance( forwardpos, playerpos );
    totaldist = forwarddist - backdist;
    scale = 1 - math::lerp_fraction( 0, abs( totaldist ), dist );
    maxspeedclamp = 250;
    
    if ( isdefined( self.stayahead.turbo ) || catchup )
    {
        maxspeedclamp = 300;
    }
    
    if ( !isdefined( self.stayahead.exit_last_finish_time ) || gettime() > self.stayahead.exit_last_finish_time + 1000 )
    {
        speed = math::lerp( minspeed, maxspeed, scale );
        speed = clamp( speed, 23, maxspeedclamp );
        curspeed = self aigetdesiredspeed();
        diff = speed - curspeed;
        
        if ( catchup || diff > 50 )
        {
            if ( !catchup && !isdefined( self.stayahead.last_speed_set_time ) )
            {
                speed = curspeed + clamp( diff, -2, 2 );
                self.stayahead.last_speed_set_time = undefined;
                print3d_debug( self.origin + ( 0, 0, 32 ), "StayAhead STARTUP! plane: " + plane + " diff: " + diff + " curSpeed: " + curspeed + " speed: " + speed, ( 1, 1, 1 ), 1, 0.1, 100, 1 );
                print_console_debug( "StayAhead STARTUP! plane: " + plane + " diff: " + diff + " curSpeed: " + curspeed + " speed: " + speed );
            }
            else
            {
                speed = curspeed + clamp( diff, -10, 10 );
                self.stayahead.last_speed_set_time = gettime();
                print3d_debug( self.origin + ( 0, 0, 32 ), "StayAhead CATCHUP! plane: " + plane + " diff: " + diff + " curSpeed: " + curspeed + " speed: " + speed, ( 1, 1, 1 ), 1, 0.1, 100, 1 );
                print_console_debug( "StayAhead CATCHUP! plane: " + plane + " diff: " + diff + " curSpeed: " + curspeed + " speed: " + speed );
            }
        }
        else if ( isdefined( self.stayahead_accel ) )
        {
            speed = curspeed + clamp( diff, -1 * self.stayahead_accel, self.stayahead_accel );
            self.stayahead.last_speed_set_time = gettime();
        }
        else
        {
            speed = curspeed + clamp( diff, -3.5, 3.5 );
            self.stayahead.last_speed_set_time = gettime();
        }
        
        utility::set_movement_speed( speed );
        
        if ( self.stayahead.exit_speed == -1 )
        {
            self.stayahead.exit_speed = speed;
        }
        
        line_debug( followent.origin, playerpos );
        print2d3d_debug( self.origin + ( 0, 0, 8 ), "speed: " + speed, ( 0.9, 0.9, 0.9 ), 0.9, 0.3, 1, 0, "right", 2 );
        print3d_debug( playerpos + ( 0, 0, 8 ), speed, ( 0.9, 0.9, 0.9 ), 0.9, 0.3 );
        return;
    }
    
    print3d_debug( self.origin + ( 0, 0, 8 ), "IsExiting, not setting speed: " + gettime(), ( 0.9, 0, 0 ), 0.9, 0.3, 1 );
}

// Namespace stayahead
// Params 2
// Checksum 0x484474fb, Offset: 0x3050
// Size: 0x207
function get_best_goto_node( path, nodestocheck )
{
    dots = [];
    largestindex = 0;
    goodenough = undefined;
    
    for ( i = 0; i < nodestocheck ; i++ )
    {
        if ( !isdefined( path[ i ] ) )
        {
            break;
        }
        
        dots[ i ] = vectordot( vectornormalize( path[ i ].origin - self.origin ), self.stayahead.dir );
        
        if ( dots[ i ] < 0 )
        {
            nodestocheck += 1;
            continue;
        }
        
        if ( dots[ i ] > 0.5 )
        {
            print3d_debug( path[ i ].origin, "GOTO GOOD ENOUGH re-start: " + dots[ i ], ( 0, 1, 0 ), 1, 0.3, 200, 1 );
            goodenough = 1;
            largestindex = i;
            break;
        }
        
        if ( dots[ i ] > dots[ largestindex ] )
        {
            largestindex = i;
        }
    }
    
    /#
        if ( getdvarint( @"scr_debug_stayahead" ) )
        {
            foreach ( i, dot in dots )
            {
                if ( i == largestindex && !isdefined( goodenough ) )
                {
                    path[ i ] thread print3d_debug( path[ i ].origin, "<dev string:xf2>" + dot, ( 0, 1, 0 ), 1, 0.3, 200, 1 );
                    continue;
                }
                
                if ( i != largestindex )
                {
                    path[ i ] thread node_display_debug( path[ i ].origin, "<dev string:x102>" + dot, ( 1, 0, 0 ), 1, 0.3, 200, 1 );
                }
            }
        }
    #/
    
    return path[ largestindex ];
}

// Namespace stayahead
// Params 1
// Checksum 0x453e3ccf, Offset: 0x3260
// Size: 0x2c
function get_goto_nodes( nodes )
{
    if ( isdefined( self.patharray ) )
    {
        nodes = arraycombine( nodes, self.patharray );
    }
    
    return nodes;
}

// Namespace stayahead
// Params 0
// Checksum 0x44ba987b, Offset: 0x3295
// Size: 0xe8
function get_goalpos()
{
    goalpos = [];
    
    if ( isdefined( self.goalnode ) )
    {
        goalpos[ 0 ] = self.goalnode.origin;
        
        if ( isdefined( self.goalnode.target ) )
        {
            linkednode = self.goalnode get_node_or_struct();
            
            if ( isdefined( linkednode ) )
            {
                goalpos[ 1 ] = linkednode.origin;
            }
        }
        else if ( isdefined( self.stayahead.goalnode ) && self.goalnode == self.stayahead.goalnode_pw )
        {
            goalpos[ 1 ] = self.stayahead.goalnode.origin;
        }
    }
    else
    {
        goalpos[ 0 ] = self.scriptgoalpos;
    }
    
    return goalpos;
}

// Namespace stayahead
// Params 0
// Checksum 0x99af1773, Offset: 0x3386
// Size: 0x41
function get_node_or_struct()
{
    var_7237854e3be197ca = getnode( self.target, #targetname );
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    return utility::getstruct( self.target, "targetname" );
}

// Namespace stayahead
// Params 1
// Checksum 0x78e31c99, Offset: 0x33d0
// Size: 0x72e
function get_wait_node( dir )
{
    nodes = [];
    
    if ( isdefined( self.stayahead.wait_nodes ) )
    {
        nodes = self.stayahead.wait_nodes;
        nodes = sortbydistance( nodes, self.origin );
    }
    else if ( !isdefined( self.stayahead.use_goto_wait ) )
    {
        nodes = getnodesinradiussorted( self.origin, self.stayahead.wait_node_radius, 0, 64, "cover" );
    }
    
    if ( isdefined( self.using_goto_node ) && self.stayahead.use_goto_wait )
    {
        nodes = arraycombine( nodes, get_goto_nodes( nodes ) );
        nodes = sortbydistance( nodes, self.origin );
    }
    
    allowed_dot = 0.75;
    
    foreach ( i, node in nodes )
    {
        nodedot = vectordot( vectornormalize( node.origin - self.origin ), self.stayahead.dir );
        goalnodesafe = node == self.goalnode ? 0 : 1;
        goalpossafe = node.origin == self.goalpos ? 0 : 1;
        
        if ( !isdefined( node.stayahead_wait_used ) && !isdefined( node.script_dontremove ) && nodedot >= allowed_dot && goalnodesafe && goalpossafe )
        {
            if ( isdefined( self.script_forcecolor ) && isdefined( node.script_color_allies ) && issubstr( node.script_color_allies, self.script_forcecolor ) )
            {
                line_debug( self.origin, node.origin, ( 0, 1, 0 ), 1, 0, 1 );
                node thread node_display_debug( node.origin, node.script_color_allies, ( 0, 1, 0 ), 1, 0.2, 1000, 1 );
            }
            else if ( isdefined( self.script_forcecolor ) && !isdefined( self.stayahead.use_goto_wait ) )
            {
                if ( !isdefined( node.script_color_allies ) )
                {
                    if ( isdefined( self.stayahead.wait_nodes ) && !isdefined( function_f02c63b99c9614c9( self.stayahead.wait_nodes, node ) ) )
                    {
                        node thread node_display_debug( node.origin, "invalid: no color, removing", ( 1, 0, 1 ), 1, 0.2, 1000, 1 );
                        nodes = arrayremove( nodes, node );
                    }
                }
                else if ( !issubstr( node.script_color_allies, self.script_forcecolor ) )
                {
                    node thread node_display_debug( node.origin, "invalid: wrong color, removing", ( 1, 0, 1 ), 1, 0.2, 1000, 1 );
                    nodes = arrayremove( nodes, node );
                }
            }
            
            continue;
        }
        
        if ( !isdefined( node.script_dontremove ) )
        {
            if ( isdefined( node.stayahead_wait_used ) )
            {
                node thread node_display_debug( node.origin, "invalid: used", ( 1, 0, 1 ), 1, 0.2, 1000, 1 );
            }
            else if ( nodedot < 0 )
            {
                node thread node_display_debug( node.origin, "removed: behind", ( 0, 0, 1 ), 1, 0.2, 1000, 1 );
            }
            else if ( nodedot < allowed_dot )
            {
                node thread node_display_debug( node.origin, "removed: bad angle: " + nodedot, ( 1, 0, 0 ), 1, 0.2, 1000, 1 );
            }
            else if ( !goalnodesafe )
            {
                node thread node_display_debug( node.origin, "removed: IS goalNode", ( 1, 0, 0 ), 1, 0.2, 1000, 1 );
            }
            else if ( !goalpossafe )
            {
                node thread node_display_debug( node.origin, "removed: IS goalPos", ( 1, 0, 0 ), 1, 0.2, 1000, 1 );
            }
            else
            {
                node thread node_display_debug( node.origin, "invalid???", ( 1, 0, 1 ), 1, 0.2, 1000, 1 );
            }
            
            nodes = arrayremove( nodes, node );
        }
    }
    
    if ( getdvarint( @"scr_debug_stayahead" ) )
    {
        foreach ( i, node in nodes )
        {
            node thread node_display_debug( node.origin, "wait node: " + i, ( 0, 1, 0 ), 1, 0.2, 1000, 1 );
        }
    }
    
    var_cb97c3084705a885 = undefined;
    
    if ( nodes.size > 0 )
    {
        var_9c510ec653655ce8 = undefined;
        
        foreach ( node in nodes )
        {
            if ( isnode( node ) )
            {
                var_9c510ec653655ce8 = node;
                break;
            }
        }
        
        var_cb97c3084705a885 = nodes[ 0 ];
        
        if ( isstruct( nodes[ 0 ] ) && isdefined( var_9c510ec653655ce8 ) )
        {
            if ( distance( nodes[ 0 ].origin, var_9c510ec653655ce8.origin ) < 128 )
            {
                if ( node_within_fov( var_9c510ec653655ce8 ) )
                {
                    print3d_debug( var_9c510ec653655ce8.origin, "NEAREST NODE", ( 1, 1, 1 ), 1, 0.3, 1, 1 );
                    print3d_debug( self.origin, "STAYAHEAD: using closest 'node' bc it's not a struct!", ( 1, 1, 1 ), 1, 0.3, 100, 1 );
                    var_cb97c3084705a885 = var_9c510ec653655ce8;
                }
            }
        }
    }
    else
    {
        print3d_debug( self.origin, "STAYAHEAD: NO BEST WAIT NODE, RETURNING UNDEFINED!", ( 1, 0, 0 ), 1, 0.3, 100, 1 );
    }
    
    return var_cb97c3084705a885;
}

// Namespace stayahead
// Params 0
// Checksum 0x233e157d, Offset: 0x3b07
// Size: 0xaf
function pause_flag_monitor()
{
    while ( true )
    {
        utility::ent_flag_wait( "stayahead_pause" );
        print3d_debug( self.origin + ( 0, 0, 16 ), "PAUSING stayahead", ( 0, 1, 1 ), 1, 0.3, 1000, 1 );
        utility::ent_flag_waitopen_any( "stayahead_pause" );
        print3d_debug( self.origin + ( 0, 0, 16 ), "UNpausing stayahead", ( 0, 1, 1 ), 1, 0.3, 1000, 1 );
        self.stayahead.pw_behind_buffer = 0;
    }
}

// Namespace stayahead
// Params 2
// Checksum 0x68db5da4, Offset: 0x3bbe
// Size: 0x8e
function waitnode_trigger_think( node, trigger )
{
    thread delay_endon( 0.05, "goal_changed" );
    self waittill( #"goal" );
    thread stayahead_pause( 1 );
    childthread waitnode_trigger_debug( node, trigger );
    childthread waitnode_trigger_delay_speed_clear();
    msg = trigger utility::waittill_any_return( "trigger", "death" );
    thread stayahead_pause( 0 );
    childthread stayahead_set_goalnode( self.stayahead.goalnode, 0 );
}

// Namespace stayahead
// Params 0
// Checksum 0x18894e91, Offset: 0x3c54
// Size: 0x16
function waitnode_trigger_delay_speed_clear()
{
    waittillframeend();
    self.stayahead.last_speed_set_time = undefined;
}

// Namespace stayahead
// Params 2
// Checksum 0xefc4b64c, Offset: 0x3c72
// Size: 0xbf
function waitnode_trigger_debug( node, trigger )
{
    trigger endon( #"death" );
    trigger endon( #"trigger" );
    
    /#
        if ( getdvarint( @"scr_debug_stayahead" ) )
        {
            for ( ;; )
            {
                print3d_debug( trigger.origin, "<dev string:x111>", ( 0, 1, 0 ), 1, 0.3, 1, 1 );
                line_debug( node.origin, trigger.origin, ( 0, 1, 0 ), 1, 0, 1 );
                utility::draw_entity_bounds( trigger, 0.05, ( 0, 1, 0 ) );
                waitframe();
            }
        }
    #/
}

// Namespace stayahead
// Params 0
// Checksum 0xa38092c6, Offset: 0x3d39
// Size: 0xab
function stayahead_watch_end()
{
    self endon( #"death" );
    
    if ( !isdefined( self.stayahead ) )
    {
        self.stayahead = spawnstruct();
    }
    
    self.stayahead.active = 1;
    self waittill( #"stop_stayahead" );
    
    if ( isdefined( self.stayahead ) )
    {
        if ( isdefined( self.stayahead.active ) )
        {
            self.stayahead.active = undefined;
        }
        
        if ( isdefined( self.stayahead.team_thinking ) )
        {
            self.stayahead.team_thinking = undefined;
        }
    }
}

// Namespace stayahead
// Params 1
// Checksum 0x452fb2e5, Offset: 0x3dec
// Size: 0x6d
function stayahead_wait_func( node )
{
    self endon( #"death" );
    self endon( #"stop_stayahead" );
    self notify( #"stop_stayahead_wait_func" );
    self endon( #"stop_stayahead_wait_func" );
    thread delay_endon( 0.05, "goal_changed" );
    stayahead_at_waitnode( node );
    self [[ self.stayahead.wait_func ]]();
}

// Namespace stayahead
// Params 0
// Checksum 0x3e3dfdfc, Offset: 0x3e61
// Size: 0xe7
function stayahead_wait_set_goal_or_path()
{
    if ( isdefined( self.using_goto_node ) )
    {
        self.stayahead.goto_patharray = self.patharray;
        self.stayahead.using_goto_node = 1;
        
        for ( i = 0; i <= self.patharrayindex ; i++ )
        {
            if ( self.stayahead.goto_patharray.size > 1 )
            {
                print_console_debug( "Removing go_to_node num: " + i );
                self.stayahead.goto_patharray[ 0 ] = undefined;
                function_cdc669dbc8ea2101( self.stayahead.goto_patharray );
            }
        }
        
        return;
    }
    
    if ( isdefined( self.goalnode ) )
    {
        self.stayahead.goalnode = self.goalnode;
    }
}

// Namespace stayahead
// Params 1
// Checksum 0xb391f2a4, Offset: 0x3f50
// Size: 0x85
function stayahead_at_waitnode( node )
{
    thread delay_endon( 0.05, "goal_changed" );
    
    while ( distance2dsquared( self.origin, node.origin ) > 64 )
    {
        print3d_debug( self.origin, "distanceSQ to waitnode: " + distance2dsquared( self.origin, node.origin ), ( 1, 1, 1 ), 1, 0.3, 1, 1 );
        waitframe();
    }
}

// Namespace stayahead
// Params 1
// Checksum 0x9af29f88, Offset: 0x3fdd
// Size: 0x144, Type: bool
function stayahead_goal_is_far_enough( var_cb97c3084705a885 )
{
    if ( node_within_fov( self.stayahead.goalnode ) )
    {
        if ( distance( self.origin, self.stayahead.goalnode.origin ) - distance( self.origin, var_cb97c3084705a885.origin ) < 128 )
        {
            print2d3d_debug( self.origin + ( 0, 0, 16 ), "pW fail goalnode too close: " + distance( self.origin, self.stayahead.goalnode.origin ) + " Waitnode: " + distance( self.origin, var_cb97c3084705a885.origin ), ( 1, 0, 0 ), 1, 0.3, 1, 0, "right", 5 );
            return false;
        }
    }
    else
    {
        print2d3d_debug( self.origin + ( 0, 0, 16 ), "pW fail goalnode not within FOV.", ( 0, 1, 0 ), 1, 0.3, 1, 0, "right", 5 );
    }
    
    return true;
}

// Namespace stayahead
// Params 1
// Checksum 0x310c95b8, Offset: 0x412a
// Size: 0x99, Type: bool
function node_within_fov( node )
{
    if ( isdefined( self.stayahead ) && isdefined( self.stayahead.dir ) )
    {
        forward = self.stayahead.dir;
    }
    else
    {
        forward = anglestoforward( self.angles );
    }
    
    dot = vectordot( forward, vectornormalize( node.origin - self.origin ) );
    
    if ( dot >= 0.9 )
    {
        return true;
    }
    
    return false;
}

// Namespace stayahead
// Params 2
// Checksum 0x537d6b, Offset: 0x41cc
// Size: 0x1d
function delay_endon( delay, ender )
{
    wait delay;
    self endon( ender );
}

// Namespace stayahead
// Params 1
// Checksum 0x3c42a16c, Offset: 0x41f1
// Size: 0x87
function stayahead_goto_can_use_wait( wait_nodes )
{
    if ( isdefined( self.using_goto_node ) )
    {
        if ( isdefined( self.stayahead.goto_nextnode ) && distance( self.origin, self.stayahead.goto_nextnode.origin ) > distance( self.origin, wait_nodes[ 0 ].origin ) )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 1;
}

// Namespace stayahead
// Params 2
// Checksum 0xa1f385e8, Offset: 0x4280
// Size: 0x40e
function stayahead_set_goalnode( node, waitnode )
{
    if ( isdefined( self.stayahead.spawned_wait_node ) )
    {
        despawncovernode( self.stayahead.spawned_wait_node );
    }
    
    if ( !isdefined( node ) )
    {
        return;
    }
    
    if ( waitnode )
    {
        if ( isstruct( node ) )
        {
            structpos = node.origin;
            angles = vectortoangles( self.stayahead.dir );
            node = spawncovernode( structpos, angles, "Exposed", 1 );
            
            if ( !isdefined( node ) )
            {
                print3d_debug( structpos, "UNABLE TO SPAWN COVER NODE!  TRYING TO CREATE ONE CLOSER TO THE GROUND!", ( 1, 1, 0 ), 1, 0.3, 500, 1 );
                node = spawncovernode( getgroundposition( structpos, 32 ), angles, "Exposed", 1 );
                
                if ( isdefined( node ) )
                {
                    print3d_debug( node.origin + ( 0, 0, 4 ), "SUCCESS SPAWNING NODE CLOSER TO THE GROUND!", ( 1, 1, 0 ), 1, 0.3, 500, 1 );
                }
            }
            
            if ( !isdefined( node ) )
            {
                print3d_debug( structpos, "UNABLE TO SPAWN COVER NODE!", ( 1, 0, 0 ), 1, 0.3, 500, 1 );
                return;
            }
            
            self.stayahead.spawned_wait_node = node;
        }
        
        node.stayahead_wait_used = 1;
        self notify( #"hash_851188293d90b611" );
        self notify( #"stop_going_to_node" );
        ai_utility::set_goal_node( node );
        
        if ( isdefined( self.stayahead.goto_patharray ) && node == self.stayahead.goto_patharray[ self.stayahead.goto_patharray.size - 1 ] )
        {
            self.stayahead.goto_finished = 1;
        }
        
        if ( isdefined( self.stayahead.wait_func ) )
        {
            childthread stayahead_wait_func( node );
        }
        
        linked_ents = node utility::get_linked_ents();
        
        if ( linked_ents.size > 0 )
        {
            foreach ( ent in linked_ents )
            {
                if ( issubstr( ent.code_classname, "trigger" ) )
                {
                    childthread waitnode_trigger_think( node, ent );
                }
            }
        }
        
        return;
    }
    
    if ( isdefined( self.stayahead.using_goto_node ) )
    {
        self notify( #"stop_stayahead_wait_func" );
        self notify( #"hash_2e1b9ee9251c4b7b" );
        
        if ( self.stayahead.goto_finished )
        {
            print3d_debug( self.origin + ( 0, 0, 8 ), "last node wait node; go_to_node() path done!", ( 0, 1, 0 ), 1, 0.3, 500, 1 );
            self.stayahead.goto_finished = undefined;
            self notify( #"reached_path_end" );
        }
        else
        {
            print3d_debug( self.origin + ( 0, 0, 8 ), "going BACK to goto patharray", ( 0, 1, 0 ), 1, 0.3, 500, 1 );
            node = get_best_goto_node( self.stayahead.goto_patharray, 2 );
            thread ai_utility::go_to_node( node );
            self.stayahead.using_goto_node = 1;
        }
        
        return;
    }
    
    self notify( #"stop_stayahead_wait_func" );
    self notify( #"hash_2e1b9ee9251c4b7b" );
    self notify( #"stop_going_to_node" );
    ai_utility::set_goal_node( node );
}

// Namespace stayahead
// Params 0
// Checksum 0x2b0c636b, Offset: 0x4696
// Size: 0x4df
function stayahead_team_think()
{
    self.stayahead.team_thinking = 1;
    self endon( #"death" );
    self endon( #"stop_stayahead" );
    speedscale = 0.8;
    p1speed = self.stayahead.p1[ "speed" ];
    p2speed = self.stayahead.p2[ "speed" ];
    p3speed = self.stayahead.p3[ "speed" ];
    p4speed = self.stayahead.p4[ "speed" ];
    p1dist = self.stayahead.p1[ "distance" ];
    p2dist = self.stayahead.p2[ "distance" ];
    p3dist = self.stayahead.p3[ "distance" ];
    p4dist = self.stayahead.p4[ "distance" ];
    childthread stayahead_team_debug();
    
    while ( true )
    {
        foreach ( guy in self.stayahead.team )
        {
            if ( !isdefined( guy.stayahead.dynamic_frontdist ) )
            {
                guy.stayahead.dynamic_frontdist = 200;
            }
            
            if ( !isdefined( guy.stayahead.dynamic_middist ) )
            {
                guy.stayahead.dynamic_middist = 125;
            }
            
            if ( !isdefined( guy.stayahead.dynamic_backdist ) )
            {
                guy.stayahead.dynamic_backdist = 50;
            }
            
            guy childthread ai_utility::enable_dynamic_run_speed( self, p4speed * speedscale, p3speed * speedscale, p2speed * speedscale, guy.stayahead.dynamic_frontdist, guy.stayahead.dynamic_middist, guy.stayahead.dynamic_backdist );
            
            if ( !isdefined( guy.stayahead.dir ) )
            {
                guy.stayahead.dir = anglestoforward( self.angles );
            }
            
            if ( !isdefined( guy.stayahead.wait_node_radius ) )
            {
                guy.stayahead.wait_node_radius = self.stayahead.wait_node_radius;
            }
        }
        
        self waittill( #"hash_851188293d90b611" );
        
        foreach ( guy in self.stayahead.team )
        {
            guy childthread stayahead_wait_set_goal_or_path();
            guy ai_utility::disable_dynamic_run_speed( p4speed );
            var_cb97c3084705a885 = guy get_wait_node( vectortoangles( guy.angles ) );
            
            if ( isdefined( var_cb97c3084705a885 ) )
            {
                guy childthread stayahead_set_goalnode( var_cb97c3084705a885, 1 );
            }
        }
        
        self waittill( #"hash_2e1b9ee9251c4b7b" );
        
        foreach ( guy in self.stayahead.team )
        {
            guy.stayahead.dir = anglestoforward( guy.angles );
            guy.stayahead.using_goto_node = 1;
            guy childthread stayahead_set_goalnode( guy.stayahead.goto_patharray[ 0 ], 0 );
        }
    }
}

// Namespace stayahead
// Params 0
// Checksum 0x4375118a, Offset: 0x4b7d
// Size: 0xcf
function stayahead_team_debug()
{
    self endon( #"stop_stayahead" );
    
    for ( ;; )
    {
        foreach ( guy in self.stayahead.team )
        {
            guy thread display_goto_path( ( 1, 0, 1 ) );
            line_debug( self.origin, guy.origin, ( 1, 0, 1 ), 1, 0, 1 );
        }
        
        waitframe();
    }
}

// Namespace stayahead
// Params 2
// Checksum 0x70aff03c, Offset: 0x4c54
// Size: 0x5d
function lerp_plane_vector( dir_prev, dir_new )
{
    adjustment = 0.03;
    dir_adj = ( dir_new - dir_prev ) * adjustment;
    dir = dir_prev + dir_adj;
    self.stayahead.dir = dir;
    return dir;
}

// Namespace stayahead
// Params 1
// Checksum 0xc22d2876, Offset: 0x4cba
// Size: 0x26
function print_debug( string )
{
    /#
        if ( getdvarint( @"scr_debug_stayahead" ) )
        {
            iprintln( string );
        }
    #/
}

// Namespace stayahead
// Params 1
// Checksum 0xc3ef543, Offset: 0x4ce8
// Size: 0x26
function print_console_debug( string )
{
    /#
        if ( getdvarint( @"scr_debug_stayahead" ) )
        {
            println( string );
        }
    #/
}

// Namespace stayahead
// Params 7
// Checksum 0x71ffd919, Offset: 0x4d16
// Size: 0x75
function print3d_debug( origin, text, color, alpha, scale, duration, centered )
{
    /#
        if ( getdvarint( @"scr_debug_stayahead" ) )
        {
            if ( !isdefined( duration ) )
            {
                duration = 1;
            }
            
            if ( !isdefined( centered ) )
            {
                centered = 0;
            }
            
            print3d( origin, text, color, alpha, scale, duration, centered );
        }
    #/
}

// Namespace stayahead
// Params 9
// Checksum 0xe5dccfb6, Offset: 0x4d93
// Size: 0x87
function print2d3d_debug( origin, text, color, alpha, scale, duration, centered, side, line )
{
    /#
        if ( getdvarint( @"scr_debug_stayahead" ) )
        {
            if ( !isdefined( duration ) )
            {
                duration = 1;
            }
            
            if ( !isdefined( centered ) )
            {
                centered = 0;
            }
            
            level thread create_2d_text( text, color, side, line, duration );
        }
    #/
}

/#

    // Namespace stayahead
    // Params 0
    // Checksum 0x7e86d646, Offset: 0x4e22
    // Size: 0x17a, Type: dev
    function create_2d_background()
    {
        if ( getdvarint( @"scr_debug_stayahead" ) )
        {
            if ( !isdefined( self.stayahead.bg_2d ) )
            {
                self.stayahead.bg_2d = newhudelem();
            }
            else
            {
                return;
            }
            
            self.stayahead.bg_2d.alignx = "<dev string:x123>";
            self.stayahead.bg_2d.aligny = "<dev string:x12a>";
            self.stayahead.bg_2d.horzalign = "<dev string:x12e>";
            self.stayahead.bg_2d.vertalign = "<dev string:x12e>";
            self.stayahead.bg_2d.x = 310;
            self.stayahead.bg_2d.y = 70;
            self.stayahead.bg_2d.sort = -10;
            self.stayahead.bg_2d.alpha = 0.5;
            self.stayahead.bg_2d setshader( "<dev string:x139>", 160, 52 );
        }
    }

    // Namespace stayahead
    // Params 5
    // Checksum 0x5596d2e1, Offset: 0x4fa4
    // Size: 0x14c, Type: dev
    function create_2d_text( string, color, side, line, duration )
    {
        if ( getdvarint( @"scr_debug_stayahead" ) )
        {
            offset_x = 232;
            
            switch ( side )
            {
                case #"hash_96815ce4f2a3dbc5":
                    offset_x += 63;
                    break;
            }
            
            offset_y = 72;
            offset_y += 6 * line;
            text = newhudelem();
            text settext( string );
            text.fontscale = 0.5;
            text.alignx = "<dev string:x6c>";
            text.aligny = "<dev string:x12a>";
            text.horzalign = "<dev string:x12e>";
            text.vertalign = "<dev string:x12e>";
            text.x = offset_x;
            text.y = offset_y;
            text.sort = 100;
            text.color = color;
            text.alpha = 1;
            duration *= 0.05;
            wait duration;
            text destroy();
        }
    }

#/

// Namespace stayahead
// Params 6
// Checksum 0x21492269, Offset: 0x50f8
// Size: 0x87
function line_debug( start, end, color, alpha, depthtest, duration )
{
    /#
        if ( getdvarint( @"scr_debug_stayahead" ) )
        {
            if ( !isdefined( color ) )
            {
                color = ( 1, 1, 1 );
            }
            
            if ( !isdefined( alpha ) )
            {
                alpha = 1;
            }
            
            if ( !isdefined( depthtest ) )
            {
                depthtest = 0;
            }
            
            if ( !isdefined( duration ) )
            {
                duration = 1;
            }
            
            line( start, end, color, alpha, depthtest, duration );
        }
    #/
}

// Namespace stayahead
// Params 5
// Checksum 0x97321e31, Offset: 0x5187
// Size: 0x4f
function sphere_debug( origin, radius, color, depthtest, duration )
{
    /#
        if ( getdvarint( @"scr_debug_stayahead" ) )
        {
            sphere( origin, radius, color, depthtest, duration );
        }
    #/
}

// Namespace stayahead
// Params 8
// Checksum 0xbfe557c4, Offset: 0x51de
// Size: 0xd5
function node_display_debug( origin, text, color, alpha, scale, duration, centered, no_endon )
{
    if ( isstruct( self ) || isnode( self ) && isdefined( self.targetname ) && !isdefined( no_endon ) )
    {
        level notify( self.targetname );
        level endon( self.targetname );
    }
    
    for ( i = 0; i < duration ; i++ )
    {
        print3d_debug( origin + ( 0, 0, 6 ), text, color, alpha, scale, 1, centered );
        sphere_debug( origin, 6, color, 0, 1 );
        waitframe();
    }
}

// Namespace stayahead
// Params 1
// Checksum 0xfc8e3286, Offset: 0x52bb
// Size: 0x1bc
function display_goto_path( color )
{
    og_color = color;
    
    if ( getdvarint( @"scr_debug_stayahead" ) )
    {
        if ( isdefined( self.using_goto_node ) && isdefined( self.patharray ) )
        {
            foreach ( i, node in self.patharray )
            {
                if ( i < self.patharrayindex )
                {
                    color = ( 1, 0, 0 );
                }
                else
                {
                    color = og_color;
                }
                
                node thread node_display_debug( node.origin, "goto: " + i, color, 1, 0.2, 100, 1 );
                
                if ( isdefined( node.target ) )
                {
                    if ( isdefined( utility::getstruct( node.target, "targetname" ) ) )
                    {
                        line_debug( node.origin, utility::getstruct( node.target, "targetname" ).origin, color, 1, 0, 1 );
                        continue;
                    }
                    
                    if ( isdefined( getnode( node.target, #targetname ) ) )
                    {
                        line_debug( node.origin, getnode( node.target, #targetname ).origin, color, 1, 0, 1 );
                    }
                }
            }
        }
    }
}

// Namespace stayahead
// Params 1
// Checksum 0xc75d0276, Offset: 0x547f
// Size: 0x51
function enable_stayahead( followent )
{
    setdvarifuninitialized( @"scr_debug_stayahead", 0 );
    disable_stayahead( 0, 0 );
    waittillframeend();
    
    /#
        if ( getdvarint( @"scr_debug_stayahead" ) )
        {
            iprintln( "<dev string:x13f>" + self getentnum() );
        }
    #/
    
    thread stayahead_thread( followent );
}

// Namespace stayahead
// Params 2
// Checksum 0x27eb5e0a, Offset: 0x54d8
// Size: 0x1d8
function disable_stayahead( speed, reset )
{
    /#
        if ( getdvarint( @"scr_debug_stayahead" ) )
        {
            iprintln( "<dev string:x158>" + self getentnum() );
        }
    #/
    
    if ( isdefined( self.stayahead ) && isdefined( self.stayahead.using_goto_node ) )
    {
        print3d_debug( self.origin + ( 0, 0, 8 ), "Stayahead disabled, going back to go_to_node()", ( 0, 1, 0 ), 1, 0.3, 500, 1 );
        thread ai_utility::go_to_node( get_best_goto_node( self.stayahead.goto_patharray, 2 ) );
    }
    
    if ( isdefined( self.stayahead ) && isdefined( self.stayahead.bg_2d ) )
    {
        self.stayahead.bg_2d destroy();
    }
    
    if ( isdefined( self.stayahead ) && isdefined( self.stayahead.team ) )
    {
        foreach ( guy in self.stayahead.team )
        {
            guy ai_utility::disable_dynamic_run_speed( speed );
        }
    }
    
    if ( !isdefined( reset ) || reset )
    {
        self.stayahead = undefined;
    }
    
    if ( !isdefined( speed ) )
    {
        speed = 165;
    }
    
    self notify( #"stop_stayahead" );
    
    if ( speed )
    {
        utility::set_movement_speed( speed );
    }
}

// Namespace stayahead
// Params 4
// Checksum 0x6c7ac8eb, Offset: 0x56b8
// Size: 0x17d
function set_stayahead_values( plane, speed, distance, variance )
{
    assert( isdefined( plane ), "<dev string:x172>" );
    assert( isdefined( speed ), "<dev string:x190>" );
    assert( isdefined( distance ), "<dev string:x1a3>" );
    
    if ( !isdefined( self.stayahead ) )
    {
        self.stayahead = spawnstruct();
    }
    
    planevalues[ "speed" ] = speed;
    planevalues[ "distance" ] = distance;
    
    if ( isdefined( variance ) )
    {
        planevalues[ "variance" ] = variance;
    }
    
    switch ( plane )
    {
        case 1:
            self.stayahead.p1 = planevalues;
            break;
        case 2:
            self.stayahead.p2 = planevalues;
            break;
        case 3:
            self.stayahead.p3 = planevalues;
            break;
        case 4:
            self.stayahead.p4 = planevalues;
            break;
        case #"hash_bdf347744138cb00":
            self.stayahead.pw = planevalues;
            break;
        default:
            assertmsg( "<dev string:x1b9>" + plane );
            break;
    }
}

// Namespace stayahead
// Params 3
// Checksum 0x1a4c22e3, Offset: 0x583d
// Size: 0x65
function set_stayahead_wait_values( distance, buffer, var_fb123c84af4bd53 )
{
    set_stayahead_values( "wait", 0, distance, 0 );
    self.stayahead.pw[ "buffer" ] = buffer;
    
    if ( var_fb123c84af4bd53 )
    {
        self.stayahead.use_goto_wait = 1;
    }
}

// Namespace stayahead
// Params 0
// Checksum 0xaca1c5db, Offset: 0x58aa
// Size: 0xa8
function stayahead_disable_wait()
{
    if ( isdefined( self.stayahead ) )
    {
        /#
            if ( getdvarint( @"scr_debug_stayahead" ) )
            {
                iprintln( "<dev string:x1e7>" + self getentnum() );
            }
        #/
        
        if ( isdefined( self.stayahead.goalnode_pw ) )
        {
            goalnode = self.stayahead.goalnode ?? self.goalnode;
            childthread stayahead_set_goalnode( goalnode, 0 );
        }
        
        if ( isdefined( self.stayahead.pw ) )
        {
            self.stayahead.pw = undefined;
        }
    }
}

// Namespace stayahead
// Params 1
// Checksum 0xd6ed2161, Offset: 0x595a
// Size: 0x82
function enable_stayahead_turbo( speed )
{
    if ( !isdefined( self.stayahead ) )
    {
        return;
    }
    
    if ( isdefined( speed ) )
    {
        assert( speed > 0, "<dev string:x206>" );
    }
    
    /#
        if ( getdvarint( @"scr_debug_stayahead" ) )
        {
            print_speed = speed;
            
            if ( !isdefined( print_speed ) )
            {
                print_speed = "<dev string:x223>";
            }
            
            iprintln( "<dev string:x22d>" + print_speed );
        }
    #/
    
    self.stayahead.turbo = speed;
}

// Namespace stayahead
// Params 2
// Checksum 0xba1ae547, Offset: 0x59e4
// Size: 0x8a
function set_stayahead_wait_nodes( nodes, var_fb123c84af4bd53 )
{
    if ( !isdefined( self.stayahead ) )
    {
        self.stayahead = spawnstruct();
    }
    
    if ( isdefined( nodes ) )
    {
        assert( isarray( nodes ), "<dev string:x247>" );
        assert( nodes.size > 0, "<dev string:x262>" );
        self.stayahead.wait_nodes = nodes;
    }
    
    if ( var_fb123c84af4bd53 )
    {
        self.stayahead.use_goto_wait = 1;
    }
}

// Namespace stayahead
// Params 1
// Checksum 0xea25c19b, Offset: 0x5a76
// Size: 0x22
function set_stayahead_wait_func( func )
{
    self.stayahead.wait_func = func;
}

// Namespace stayahead
// Params 4
// Checksum 0x21d93fbb, Offset: 0x5aa0
// Size: 0x170
function stayahead_add_to_team( team, frontdist, middist, backdist )
{
    if ( !isdefined( self.stayahead.team ) )
    {
        self.stayahead.team = [];
    }
    
    array = [];
    
    if ( !isarray( team ) )
    {
        array[ 0 ] = team;
    }
    else
    {
        array = team;
    }
    
    foreach ( guy in array )
    {
        if ( !isdefined( guy.stayahead ) )
        {
            guy.stayahead = spawnstruct();
        }
        
        guy.stayahead.dynamic_frontdist = frontdist;
        guy.stayahead.dynamic_middist = middist;
        guy.stayahead.dynamic_backdist = backdist;
    }
    
    self.stayahead.team = arraycombine( self.stayahead.team, array );
}

// Namespace stayahead
// Params 1
// Checksum 0x3aea21f6, Offset: 0x5c18
// Size: 0x4a
function stayahead_pause( bool )
{
    if ( utility::ent_flag_exist( "stayahead_pause" ) )
    {
        if ( bool )
        {
            utility::ent_flag_set( "stayahead_pause" );
        }
        else
        {
            utility::ent_flag_clear( "stayahead_pause" );
        }
        
        return;
    }
    
    print( "<dev string:x277>" );
}

// Namespace stayahead
// Params 1
// Checksum 0xa7b38afc, Offset: 0x5c6a
// Size: 0x3b
function stayahead_set_wait_node_radius( radius )
{
    if ( !isdefined( self.stayahead ) )
    {
        self.stayahead = spawnstruct();
    }
    
    self.stayahead.wait_node_radius = radius;
}

// Namespace stayahead
// Params 1
// Checksum 0xd5766cfa, Offset: 0x5cad
// Size: 0x56
function stayahead_lookat_enabled( bool )
{
    if ( !isdefined( self.stayahead ) )
    {
        self.stayahead = spawnstruct();
    }
    
    if ( bool )
    {
        self.stayahead.lookat_allowed = 1;
        return;
    }
    
    self.stayahead.lookat_allowed = undefined;
}

