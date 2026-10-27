// scripts\common\ai\aitypes\zombie_viper_mini\zombie_viper_mini_audio.gsc  (hash_2504e76a9fdd60f9.gscc) (size: 3547 Bytes / 0xddb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x64ea340e (1693070350)
// size ...... 3547 (0xddb)
// includes .. 4   (offset: 0xccb)
// strings ... 14  (offset: 0xceb)
// dev strs .. 0   (offset: 0xddb)
// exports ... 10  (offset: 0x77b)
// cseg ...... 0x175 + 0x606 (0x77b)
// imports ... 32  (offset: 0x90b)
// animtree1 . 0   (offset: 0xddb)
// animtree2 . 0   (offset: 0xddb)
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_viper_mini_audio;

// Namespace zombie_viper_mini_audio
// Params 0
// Checksum 0xf447eefa, Offset: 0x193
// Size: 0xa4
function init_global()
{
    if ( utility::flag( "viper_mini_audio" ) )
    {
        return;
    }
    
    utility::flag_set( "viper_mini_audio" );
    zombie_vox::register_vox_state( "vox_taunt", "vox_taunt", "dx_zm_aiuk_adbt_klub_aikbtcmbcht", 2, 5200 );
    zombie_vox::register_vox_state( "vox_downs_player", "vox_downs_player", "dx_zm_aiuk_adbt_klub_aikbtdnpl", 3, 5300 );
    zombie_vox::register_vox_state( "vox_self_destruct", "vox_self_destruct", "dx_zm_aiuk_adbt_klub_aikbtsfdt", 3, 5900 );
    callback::get_template( self.animsetname ) callback::add( "killed_body_cloned", &function_7920cd06bcb55c15 );
    
    if ( !isdefined( level.var_76ee2d6ca72d307c ) )
    {
        level.var_76ee2d6ca72d307c = [];
    }
}

// Namespace zombie_viper_mini_audio
// Params 0
// Checksum 0x6d460236, Offset: 0x23f
// Size: 0x63
function init()
{
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.enablevo )
    {
        if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f5b742fa9be69b95 )
        {
            self.var_651f886e839b954e = &downed_player_callback;
            thread play_zombie_ambient_repeating();
        }
        
        zombie_vox::register_play_vox_fn( &play_zombie_vo );
    }
}

// Namespace zombie_viper_mini_audio
// Params 0
// Checksum 0xdbdf3c42, Offset: 0x2aa
// Size: 0xdf
function function_726ea9c78a3aeb64()
{
    if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.enablevo )
    {
        curr_time = gettime();
        cooldown_ms = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_f5b742fa9be69b95 ? 5000 : 10000;
        
        if ( !isdefined( level.var_76ee2d6ca72d307c[ "vox_self_destruct" ] ) || curr_time - level.var_76ee2d6ca72d307c[ "vox_self_destruct" ] > cooldown_ms )
        {
            level.var_76ee2d6ca72d307c[ "vox_self_destruct" ] = curr_time;
            var_41fd1f667b65256d = zombie_vox::function_60b4e7f5dcc09735();
            
            if ( function_9ab89894f4bcc56c( var_41fd1f667b65256d ) )
            {
                self stopsoundchannel( var_41fd1f667b65256d );
            }
            
            level play_zombie_vo( "vox_self_destruct", self, "vox_self_destruct", "dx_zm_aiuk_adbt_klub_aikbtsfdt", 3 );
        }
    }
}

// Namespace zombie_viper_mini_audio
// Params 6, eflags: 0x4
// Checksum 0x62dbcddd, Offset: 0x391
// Size: 0xca
function private play_zombie_vo( event, zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 )
{
    if ( !zombie val::get( "allow_vo" ) )
    {
        return;
    }
    
    switch ( event )
    {
        case #"hash_8f4226cc8eb98081":
            zombie zombie_vox::function_bb5be6a2c88bc5f4( utility::function_4b74c15943231980( 3 ), 1 );
            break;
        case #"hash_9eb589cf515a9ddc":
            zombie zombie_vox::function_bb5be6a2c88bc5f4( utility::function_4b74c15943231980( 3 ), 1 );
            zombie zombie_vox::function_bb5be6a2c88bc5f4( utility::function_4b74c15943231980( 3 ), 2 );
            break;
        default:
            break;
    }
    
    level thread zombie_vox::function_e7828eef0e4316d6( zombie, scriptable_state, alias, priority, var_9a3bc44f9b1e1618 );
}

// Namespace zombie_viper_mini_audio
// Params 1, eflags: 0x4
// Checksum 0xfc583aac, Offset: 0x463
// Size: 0x4d
function private function_7920cd06bcb55c15( params )
{
    if ( isdefined( self ) )
    {
        if ( self isscriptable() )
        {
            utility::function_7c10ea82c1e305b8( "sound_vo", "off" );
        }
        
        var_41fd1f667b65256d = zombie_vox::function_60b4e7f5dcc09735();
        
        if ( function_9ab89894f4bcc56c( var_41fd1f667b65256d ) )
        {
            self stopsoundchannel( var_41fd1f667b65256d );
        }
    }
}

// Namespace zombie_viper_mini_audio
// Params 1, eflags: 0x4
// Checksum 0x9c5db1f3, Offset: 0x4b8
// Size: 0x13
function private downed_player_callback( player )
{
    thread function_15ee0d5ebcf2c0c6();
}

// Namespace zombie_viper_mini_audio
// Params 1, eflags: 0x4
// Checksum 0x677478b2, Offset: 0x4d3
// Size: 0x75
function private function_15ee0d5ebcf2c0c6( player )
{
    self endon( #"death" );
    wait 4;
    
    if ( self isscriptable() )
    {
        utility::function_7c10ea82c1e305b8( "sound_vo", "off" );
    }
    
    var_41fd1f667b65256d = zombie_vox::function_60b4e7f5dcc09735();
    
    if ( function_9ab89894f4bcc56c( var_41fd1f667b65256d ) )
    {
        self stopsoundchannel( var_41fd1f667b65256d );
    }
    
    waitframe();
    level thread play_zombie_vo( "vox_downs_player", self, "vox_downs_player", "dx_zm_aiuk_adbt_klub_aikbtdnpl", 3, 5300 );
}

// Namespace zombie_viper_mini_audio
// Params 0
// Checksum 0xa9afb7c6, Offset: 0x550
// Size: 0x1c9
function play_zombie_ambient_repeating()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    waitframe();
    var_a50f94f03edff6b3 = 0;
    
    while ( true )
    {
        b_played_vo = 0;
        
        if ( val::get( "play_ambient_vo" ) && val::get( "allow_vo" ) && !utility::ent_flag( "playing_vo" ) && !self._blackboard.var_65f32caa86b87a2 && ( !isdefined( level.var_7538460147be1e93 ) || level.var_7538460147be1e93 < 3 ) )
        {
            params = get_ambient_params();
            curr_time = gettime();
            
            if ( params.var_dc8cb35f39318c8e > 0 && isdefined( params.var_a2ca231ce4d6b000 ) && ( utility::percent_chance( params.var_dc8cb35f39318c8e ) || var_a50f94f03edff6b3 >= 30 ) && ( !isdefined( level.var_76ee2d6ca72d307c[ params.var_a2ca231ce4d6b000 ] ) || curr_time - level.var_76ee2d6ca72d307c[ params.var_a2ca231ce4d6b000 ] > 5000 ) )
            {
                b_played_vo = 1;
                var_a50f94f03edff6b3 = 0;
                
                if ( !isdefined( level.var_7538460147be1e93 ) )
                {
                    level.var_7538460147be1e93 = 0;
                }
                
                level.var_7538460147be1e93++;
                level.var_76ee2d6ca72d307c[ params.var_a2ca231ce4d6b000 ] = curr_time;
                zombie_vox::function_5ac4bed4a907abf5( params.var_a2ca231ce4d6b000 );
                waitframe();
                utility::ent_flag_waitopen_any( "playing_vo" );
                level.var_7538460147be1e93--;
                
                if ( level.var_7538460147be1e93 < 0 )
                {
                    level.var_7538460147be1e93 = 0;
                }
            }
            else
            {
                var_a50f94f03edff6b3++;
            }
        }
        
        wait b_played_vo ? 10 : 1;
    }
}

// Namespace zombie_viper_mini_audio
// Params 0, eflags: 0x4
// Checksum 0x5e73904e, Offset: 0x721
// Size: 0x59
function private get_ambient_params()
{
    params = spawnstruct();
    
    if ( isdefined( self.enemy ) )
    {
        var_419305557a246c4c = [ "vox_taunt" ];
        params.var_a2ca231ce4d6b000 = var_419305557a246c4c[ randomintrange( 0, var_419305557a246c4c.size ) ];
        params.var_dc8cb35f39318c8e = 10;
    }
    
    return params;
}

