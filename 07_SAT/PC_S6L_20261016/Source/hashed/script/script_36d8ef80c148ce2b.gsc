// script_36d8ef80c148ce2b  (hash_36d8ef80c148ce2b.gscc) (size: 2082 Bytes / 0x822 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7ace4141 (2060337473)
// size ...... 2082 (0x822)
// includes .. 4   (offset: 0x7da)
// strings ... 3   (offset: 0x7fa)
// dev strs .. 0   (offset: 0x822)
// exports ... 8   (offset: 0x442)
// cseg ...... 0x93 + 0x3af (0x442)
// imports ... 21  (offset: 0x582)
// animtree1 . 0   (offset: 0x822)
// animtree2 . 0   (offset: 0x822)
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\mp\common\utility\player;

#namespace specialty_enemy_ads_awareness;

// Namespace specialty_enemy_ads_awareness
// Params 0, eflags: 0x1
// Checksum 0xfeaa87bc, Offset: 0xb1
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_enemy_ads_awareness
// Params 1
// Checksum 0xaec83dc4, Offset: 0xd1
// Size: 0x3f
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_enemy_ads_awareness", &function_7e3b4c09ceae411, &function_df1bcd09d983f932, [], &function_27e82ae3479d5013 );
    }
}

// Namespace specialty_enemy_ads_awareness
// Params 0
// Checksum 0x4cc5b72, Offset: 0x118
// Size: 0x2a
function function_7e3b4c09ceae411()
{
    if ( !arraycontains( level.var_686a654fd0e67211, self ) )
    {
        level.var_686a654fd0e67211[ level.var_686a654fd0e67211.size ] = self;
    }
}

// Namespace specialty_enemy_ads_awareness
// Params 0
// Checksum 0xc2d6926d, Offset: 0x14a
// Size: 0x4c
function function_df1bcd09d983f932()
{
    if ( arraycontains( level.var_686a654fd0e67211, self ) )
    {
        level.var_686a654fd0e67211 = arrayremove( level.var_686a654fd0e67211, self );
    }
    
    self notify( #"hash_f0f87689f99e4826" );
    self setclientomnvar( "ui_edge_glow", 0 );
    self.var_a092fe8c52d848ba = undefined;
}

// Namespace specialty_enemy_ads_awareness
// Params 0
// Checksum 0x54305a33, Offset: 0x19e
// Size: 0x13
function function_27e82ae3479d5013()
{
    level.var_686a654fd0e67211 = [];
    thread function_292f0ed5b36e3323();
}

// Namespace specialty_enemy_ads_awareness
// Params 0
// Checksum 0xa5ad3820, Offset: 0x1b9
// Size: 0x9a
function function_292f0ed5b36e3323()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( player in level.var_686a654fd0e67211 )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            player function_ccae2c16772427f7();
        }
        
        waitframe();
    }
}

// Namespace specialty_enemy_ads_awareness
// Params 0
// Checksum 0x5b74fa1b, Offset: 0x25b
// Size: 0x1e7
function function_ccae2c16772427f7()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_f0f87689f99e4826" );
    var_2762c09bfb4abecf = 0;
    var_617571e1319b4db4 = self getplayerssightingme();
    
    if ( var_617571e1319b4db4.size > 0 )
    {
        foreach ( viewingplayer in var_617571e1319b4db4 )
        {
            if ( !isdefined( viewingplayer ) || viewingplayer.var_36a00ee4342585a9 )
            {
                continue;
            }
            
            if ( viewingplayer.team != self.team && viewingplayer player::isplayerads() )
            {
                playerdistance = distance( viewingplayer.origin, self.origin );
                startpos = viewingplayer geteye();
                endpos = startpos + anglestoforward( viewingplayer getplayerangles() ) * ( playerdistance + 100 );
                spherecenter = self.origin + ( 0, 0, 35 );
                sphereradius = 40;
                
                if ( math::segmentvssphere( startpos, endpos, spherecenter, sphereradius ) )
                {
                    rtrace = trace::ray_trace( startpos, endpos, [ viewingplayer ] );
                    
                    if ( rtrace[ "entity" ] == self )
                    {
                        var_2762c09bfb4abecf = 1;
                        self.var_7c63335769f9511f[ viewingplayer getentitynumber() ] = gettime();
                        break;
                    }
                }
            }
        }
    }
    
    omnvarval = 0;
    
    if ( var_2762c09bfb4abecf )
    {
        omnvarval = 237;
    }
    
    self setclientomnvar( "ui_edge_glow", omnvarval );
    self.var_a092fe8c52d848ba = var_2762c09bfb4abecf;
}

