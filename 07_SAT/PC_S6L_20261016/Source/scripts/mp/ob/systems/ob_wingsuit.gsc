// scripts\mp\ob\systems\ob_wingsuit.gsc  (hash_248f49bfbbb572b5.gscc) (size: 2343 Bytes / 0x927 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdf1c50d (233948429)
// size ...... 2343 (0x927)
// includes .. 1   (offset: 0x913)
// strings ... 1   (offset: 0x91b)
// dev strs .. 0   (offset: 0x927)
// exports ... 7   (offset: 0x5bb)
// cseg ...... 0x5f + 0x55c (0x5bb)
// imports ... 19  (offset: 0x6d3)
// animtree1 . 0   (offset: 0x927)
// animtree2 . 0   (offset: 0x927)
#using scripts\common\callbacks;

#namespace ob_wingsuit;

// Namespace ob_wingsuit
// Params 0, eflags: 0x1
// Checksum 0x47e5f712, Offset: 0x7d
// Size: 0x2c
function autoexec main()
{
    callback::add( #"wingsuit_begin", &function_e2fae79dd7381628 );
    callback::add( #"wingsuit_end", &on_wingsuit_end );
}

// Namespace ob_wingsuit
// Params 1, eflags: 0x4
// Checksum 0xa0ca7449, Offset: 0xb1
// Size: 0x9c
function private function_e2fae79dd7381628( params )
{
    player = params.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    wingsuit_data = get_wingsuit_data();
    player setscriptablepartstate( wingsuit_data.scriptable_part, wingsuit_data.deployed_state, 0 );
    player thread function_72a6aef55b26d9b7();
    player thread function_ffdbc003152ea0e7( wingsuit_data.var_45657119ec010a35, wingsuit_data.var_32a86ede978f45b5, wingsuit_data.post_fx_bundle );
    player notify( #"wingsuit_begin" );
}

// Namespace ob_wingsuit
// Params 0, eflags: 0x4
// Checksum 0xd1e19fc9, Offset: 0x155
// Size: 0xf5
function private get_wingsuit_data()
{
    data = { #deployed_state:level.var_bb86f77304f193c4.wingsuitdata.var_f5aa4014b0fe262c, #impact_state:level.var_bb86f77304f193c4.wingsuitdata.var_d9b624e3ffbd5fd0, #scriptable_part:level.var_bb86f77304f193c4.wingsuitdata.scriptablepart, #post_fx_bundle:level.var_bb86f77304f193c4.wingsuitdata.pbgpostfxbundle, #var_32a86ede978f45b5:level.var_bb86f77304f193c4.wingsuitdata.var_9393229b393bf561, #var_45657119ec010a35:level.var_bb86f77304f193c4.wingsuitdata.var_f5ccfddeed0b90f1 };
    return data;
}

// Namespace ob_wingsuit
// Params 1, eflags: 0x4
// Checksum 0x6d4bda90, Offset: 0x253
// Size: 0x1d7
function private on_wingsuit_end( params )
{
    player = params.player;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    wingsuit_data = get_wingsuit_data();
    
    if ( player.var_88e8ffcc17c3cb7c )
    {
        pbgpostfxbundleend( player, wingsuit_data.post_fx_bundle );
        player.var_88e8ffcc17c3cb7c = undefined;
    }
    
    player setscriptablepartstate( wingsuit_data.scriptable_part, "off", 0 );
    
    if ( player isonground() && !player.var_59d95ba89a817f5a )
    {
        player setscriptablepartstate( wingsuit_data.scriptable_part, wingsuit_data.impact_state, 0 );
    }
    
    player notify( #"wingsuit_end" );
    player.var_9be15e9050f368b6 = gettime();
    curorigin = player getorigin();
    delta = distance( curorigin, player.var_21bb80b3ef1005e );
    player.var_7950b2c08c578846 += delta;
    var_837a5d335e745ed = player.var_7950b2c08c578846;
    
    if ( !var_837a5d335e745ed || var_837a5d335e745ed <= 0 )
    {
        return;
    }
    
    level callback::callback( #"hash_4551d65bc8e0606f", { #var_e42bba4b7b58eff:var_837a5d335e745ed, #traversaltype:#"wingsuit", #player:player } );
    distancemeter = int( 0.0254 * var_837a5d335e745ed );
    
    if ( !distancemeter || distancemeter <= 0 )
    {
        return;
    }
    
    level callback::callback( #"hash_6c71d319dc089c27", { #distancemeter:distancemeter, #player:player, #event:#"hash_5a10347d25f1082c" } );
}

// Namespace ob_wingsuit
// Params 3, eflags: 0x4
// Checksum 0xd0036d5, Offset: 0x432
// Size: 0xdc
function private function_ffdbc003152ea0e7( var_45657119ec010a35, var_32a86ede978f45b5, post_fx_bundle )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"skydive_end" );
    self endon( #"last_stand_enter" );
    self.fx_active = 0;
    
    while ( self iswingsuitdeployed() )
    {
        speed = length( self getvelocity() );
        speed_mph = speed * 0.056818;
        
        if ( speed_mph >= var_45657119ec010a35 && !self.var_88e8ffcc17c3cb7c )
        {
            pbgpostfxbundlestart( self, post_fx_bundle );
            self.var_88e8ffcc17c3cb7c = 1;
        }
        else if ( speed_mph < var_32a86ede978f45b5 && self.var_88e8ffcc17c3cb7c )
        {
            pbgpostfxbundleend( self, post_fx_bundle );
            self.var_88e8ffcc17c3cb7c = undefined;
        }
        
        waitframe();
    }
}

// Namespace ob_wingsuit
// Params 0, eflags: 0x4
// Checksum 0x977fbb63, Offset: 0x516
// Size: 0xa5
function private function_72a6aef55b26d9b7()
{
    level endon( #"game_ended" );
    self endon( #"skydive_end" );
    self endon( #"last_stand_enter" );
    self endon( #"death_or_disconnect" );
    self.var_7950b2c08c578846 = 0;
    self.var_21bb80b3ef1005e = self getorigin();
    
    while ( self iswingsuitdeployed() )
    {
        curorigin = self getorigin();
        delta = distance( curorigin, self.var_21bb80b3ef1005e );
        self.var_7950b2c08c578846 += delta;
        self.var_21bb80b3ef1005e = curorigin;
        wait 0.5;
    }
}

