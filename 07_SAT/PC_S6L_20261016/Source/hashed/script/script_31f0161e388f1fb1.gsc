// script_31f0161e388f1fb1  (hash_31f0161e388f1fb1.gscc) (size: 5709 Bytes / 0x164d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x82f526fa (2197104378)
// size ...... 5709 (0x164d)
// includes .. 5   (offset: 0x158d)
// strings ... 11  (offset: 0x15b5)
// dev strs .. 0   (offset: 0x164d)
// exports ... 17  (offset: 0xd79)
// cseg ...... 0x152 + 0xc27 (0xd79)
// imports ... 47  (offset: 0x1021)
// animtree1 . 0   (offset: 0x164d)
// animtree2 . 0   (offset: 0x164d)
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\player;

#namespace specialty_ads_ping;

// Namespace specialty_ads_ping
// Params 0, eflags: 0x1
// Checksum 0xa2a89fa6, Offset: 0x170
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &function_98cc7aabacb728b4 );
}

// Namespace specialty_ads_ping
// Params 1
// Checksum 0xa9eaef91, Offset: 0x190
// Size: 0x62
function function_98cc7aabacb728b4( params )
{
    bundle = level.perkbundles[ "specialty_ads_ping" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_ads_ping", &set_ads_ping, &function_8c663a0613753ea3, [], &init_ads_ping );
    }
}

// Namespace specialty_ads_ping
// Params 0
// Checksum 0xd996e48d, Offset: 0x1fa
// Size: 0x2
function init_ads_ping()
{
    
}

// Namespace specialty_ads_ping
// Params 0
// Checksum 0xab34fbff, Offset: 0x204
// Size: 0xeb
function set_ads_ping()
{
    perkbundle = self.var_9842326056fd7207;
    self.var_b1b1e850707df235 = perkbundle.var_956afcd03bbdd42f ?? 0;
    self.var_54e8b826aad2074 = perkbundle.var_6833bc29a05a3ae8 ?? 0;
    self.var_8eede960124dc770 = perkbundle.var_dc86b7210d715b08 ?? 0;
    self.var_614b246a84cfe16f = perkbundle.var_1ebbb153535957d6 ?? 0;
    self.var_60c9ae5be316cdc4 = perkbundle.var_e5fad88f7de681f7 ?? 1;
    self.var_45755e37ea378df0 = perkbundle.var_c68ade979a952c15 ?? 0;
    self.var_21f68bd83f0533eb = perkbundle.var_b72c9f437fb91622 ?? 0;
    self.var_c8e6ad834a1ad9f4 = perkbundle.var_5faabb2b03e9287 ?? 100000;
    thread function_5250b7cdf45c7fc9();
}

// Namespace specialty_ads_ping
// Params 0
// Checksum 0x70fd292, Offset: 0x2f7
// Size: 0xe
function function_8c663a0613753ea3()
{
    self notify( #"unset_perk_ads_ping" );
}

// Namespace specialty_ads_ping
// Params 0, eflags: 0x4
// Checksum 0xc75ccff1, Offset: 0x30d
// Size: 0x1be
function private function_5250b7cdf45c7fc9()
{
    self endon( #"death_or_disconnect" );
    self endon( #"unset_perk_ads_ping" );
    level endon( #"game_ended" );
    bundle = level.perkbundles[ "specialty_ads_ping" ];
    self.var_3dfccd5c28b3df4f = undefined;
    self.var_c1d0bb65a3d70984 = 0;
    self.var_3f0584387611eb0a = 0;
    
    while ( true )
    {
        if ( self playerads() > self.var_b1b1e850707df235 && !self.var_3f0584387611eb0a )
        {
            self.var_3f0584387611eb0a = 1;
            currtime = gettime();
            
            if ( self.var_c1d0bb65a3d70984 > currtime )
            {
                wait utility::function_6f5d2e1f1ff70482( self.var_c1d0bb65a3d70984 - currtime );
                continue;
            }
            
            potentialtargets = function_c99e326e55847065();
            
            if ( !potentialtargets.var_48fe3edd9ec21247 )
            {
                besttarget = function_ea6947afd8d15a2e( potentialtargets.list );
                
                if ( isdefined( besttarget ) && !self function_52f6e3ae185d4603( besttarget getentitynumber() ) )
                {
                    thread function_a94645d5c8b881ad( besttarget );
                    besttarget thread function_a94645d5c8b881ad( besttarget );
                    thread function_cecae89cfbe5f2e8( besttarget );
                }
            }
            
            foreach ( checkedtarget in potentialtargets.list )
            {
                checkedtarget.var_5493da71c8fb3773 = 0;
            }
        }
        
        wait 0.2;
        self.var_3f0584387611eb0a = 0;
    }
}

// Namespace specialty_ads_ping
// Params 0, eflags: 0x4
// Checksum 0xfee203b5, Offset: 0x4d3
// Size: 0xb9
function private function_c99e326e55847065()
{
    potentialtargets = { #var_48fe3edd9ec21247:0, #list:[] };
    
    if ( self.var_60c9ae5be316cdc4 )
    {
        function_148e30fd6d7ef6fe( potentialtargets, level.players );
    }
    
    if ( self.var_45755e37ea378df0 )
    {
        agentlist = getaiarrayinradius( self.origin, self.var_c8e6ad834a1ad9f4 );
        function_148e30fd6d7ef6fe( potentialtargets, agentlist );
    }
    
    if ( self.var_21f68bd83f0533eb )
    {
        vehicleslist = getentarrayinradius( "script_vehicle", "classname", self.origin, self.var_c8e6ad834a1ad9f4 );
        function_148e30fd6d7ef6fe( potentialtargets, vehicleslist );
    }
    
    return potentialtargets;
}

// Namespace specialty_ads_ping
// Params 2, eflags: 0x4
// Checksum 0x808246cc, Offset: 0x595
// Size: 0x176
function private function_148e30fd6d7ef6fe( potentialtargets, targetlist )
{
    foreach ( potentialtarget in targetlist )
    {
        if ( !potentialtarget )
        {
            continue;
        }
        
        if ( !self.var_614b246a84cfe16f && isdefined( potentialtarget.perks[ "specialty_noscopeoutline" ] ) )
        {
            continue;
        }
        
        if ( level.teambased && isdefined( potentialtarget.team ) && isdefined( self.team ) && potentialtarget.team == self.team )
        {
            continue;
        }
        
        if ( potentialtarget.var_5493da71c8fb3773 )
        {
            potentialtargets.var_48fe3edd9ec21247 = 1;
            break;
        }
        
        potentialtarget.var_5493da71c8fb3773 = 1;
        targetentitynum = potentialtarget getentitynumber();
        istargetvalid = function_ed0ed1f36f9e361( potentialtarget );
        
        if ( potentialtarget )
        {
            if ( istargetvalid )
            {
                potentialtargets.list[ potentialtargets.list.size ] = potentialtarget;
                continue;
            }
            
            potentialtarget.var_5493da71c8fb3773 = 0;
        }
    }
}

// Namespace specialty_ads_ping
// Params 1, eflags: 0x4
// Checksum 0xb321b9c9, Offset: 0x713
// Size: 0x195
function private function_ea6947afd8d15a2e( potentialtargetarray )
{
    besttarget = undefined;
    
    if ( potentialtargetarray.size == 1 )
    {
        besttarget = potentialtargetarray[ 0 ];
    }
    else
    {
        playereye = self geteye();
        playerlookdir = anglestoforward( self getplayerangles() );
        contentsoverride = trace::create_contents( 1, 0, 0, 0, 1, 1, 0, 0, 1 );
        trace = trace::ray_trace_ents( playereye, playereye + playerlookdir * 10000, potentialtargetarray, contentsoverride, undefined, undefined, 1 );
        
        if ( isplayer( trace[ "entity" ] ) )
        {
            besttarget = trace[ "entity" ];
        }
        else
        {
            bestdot = -1;
            
            foreach ( potentialtarget in potentialtargetarray )
            {
                var_a8218bd80e7d5644 = vectornormalize( potentialtarget.origin - playereye );
                var_3e148dd02639db0d = vectornormalize( potentialtarget geteye() - playereye );
                var_e338d0ac38403e8b = vectordot( playerlookdir, var_a8218bd80e7d5644 );
                var_58ee7dd2debe6c80 = vectordot( playerlookdir, var_3e148dd02639db0d );
                potentialdot = var_e338d0ac38403e8b > var_58ee7dd2debe6c80 ? var_e338d0ac38403e8b : var_58ee7dd2debe6c80;
                
                if ( potentialdot > bestdot )
                {
                    besttarget = potentialtarget;
                    bestdot = potentialdot;
                }
            }
        }
    }
    
    return besttarget;
}

// Namespace specialty_ads_ping
// Params 2, eflags: 0x4
// Checksum 0x6367dbbf, Offset: 0x8b1
// Size: 0x31, Type: bool
function private function_db6a5b207ce92709( target, castresult )
{
    return isdefined( castresult ) && ( castresult.size == 0 || castresult[ 0 ][ "entity" ] == target );
}

// Namespace specialty_ads_ping
// Params 3, eflags: 0x4
// Checksum 0xb2655d21, Offset: 0x8eb
// Size: 0x51, Type: bool
function private function_aa8bae7794240c2a( target, targetpoint, contents )
{
    playereye = self geteye();
    castresult = physics_raycast( playereye, targetpoint, contents, undefined, 0, "physicsquery_closest" );
    return function_db6a5b207ce92709( target, castresult );
}

// Namespace specialty_ads_ping
// Params 1, eflags: 0x4
// Checksum 0xd4ef69d, Offset: 0x945
// Size: 0x19b, Type: bool
function private function_ed0ed1f36f9e361( target )
{
    self endon( #"death_or_disconnect" );
    self endon( #"unset_perk_ads_ping" );
    level endon( #"game_ended" );
    
    if ( !isdefined( target.origin ) )
    {
        return false;
    }
    
    if ( !issentient( target ) )
    {
        return false;
    }
    
    dist = distance( target.origin, self.origin );
    var_f2c7a71843bf05ad = 0;
    
    if ( dist != 0 )
    {
        var_f2c7a71843bf05ad = 10000 / dist;
    }
    
    targeteye = target geteye();
    
    if ( level.teambased && isdefined( target.team ) && isdefined( self.team ) && target.team == self.team )
    {
        return false;
    }
    
    if ( self worldpointinreticle_circle( target.origin + ( 0, 0, 24 ), 90, var_f2c7a71843bf05ad ) || self worldpointinreticle_circle( targeteye, 90, var_f2c7a71843bf05ad ) )
    {
        physicscontentslist = function_5838042260038477( target );
        contents = physics_createcontents( physicscontentslist );
        
        if ( contents == 0 )
        {
            return true;
        }
        
        targetpoint = targeteye;
        
        if ( function_aa8bae7794240c2a( target, targetpoint, contents ) )
        {
            return true;
        }
        
        waitframe();
        
        if ( !isdefined( target.origin ) )
        {
            return false;
        }
        
        targetpoint = target.origin + ( 0, 0, 24 );
        
        if ( function_aa8bae7794240c2a( target, targetpoint, contents ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace specialty_ads_ping
// Params 1, eflags: 0x4
// Checksum 0xaddedbaf, Offset: 0xae9
// Size: 0x1f3
function private function_cecae89cfbe5f2e8( var_23187a3aebf42293 )
{
    var_23187a3aebf42293 endon( #"death_or_disconnect" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"unset_perk_ads_ping" );
    outlineid = undefined;
    var_b27453ce5942e852 = utility::function_4b74c15943231980( self.var_8eede960124dc770 ?? 0 );
    
    if ( isdefined( self.perks[ "specialty_improved_target_mark" ] ) )
    {
        self.var_54e8b826aad2074 *= getdvarfloat( @"perk_faster_target_mark_rate" );
    }
    
    self.var_3dfccd5c28b3df4f = var_23187a3aebf42293;
    self.var_c1d0bb65a3d70984 = gettime() + var_b27453ce5942e852 + utility::function_4b74c15943231980( self.var_54e8b826aad2074 );
    wait self.var_54e8b826aad2074;
    
    if ( self playerads() > self.var_b1b1e850707df235 && function_ed0ed1f36f9e361( var_23187a3aebf42293 ) )
    {
        if ( !var_23187a3aebf42293 player::isreallyalive() )
        {
            self.var_3dfccd5c28b3df4f = undefined;
            self.var_c1d0bb65a3d70984 = 0;
            return;
        }
        
        targetentitynum = var_23187a3aebf42293 getentitynumber();
        self notify( #"ADSPing_MarkTarget" );
        var_23187a3aebf42293.var_96ea52dc3dbcbb6e[ self.team ] = gettime();
        assetid = var_23187a3aebf42293.classname != "script_vehicle" ? 5 : undefined;
        pingindex = calloutmarkerping::createcallout( assetid, undefined, targetentitynum, undefined, undefined, undefined );
        
        if ( isdefined( pingindex ) )
        {
            thread calloutmarkerping::predicted_timeout( pingindex );
            
            if ( function_3a7f8c70163b10f8() )
            {
                thread calloutmarkerping::function_3c501da3379eca0a( self, pingindex, undefined, [ "ADSPing_MarkTarget" ] );
            }
        }
        
        if ( soundexists( #"uin_ping_enemy" ) )
        {
            self playsoundtoplayer( #"uin_ping_enemy", self, var_23187a3aebf42293 );
        }
    }
    else
    {
        self.var_3dfccd5c28b3df4f = undefined;
        self.var_c1d0bb65a3d70984 = 0;
    }
    
    var_23187a3aebf42293.var_5493da71c8fb3773 = 0;
}

// Namespace specialty_ads_ping
// Params 1, eflags: 0x4
// Checksum 0x2272e6d9, Offset: 0xce4
// Size: 0x30
function private function_a94645d5c8b881ad( target )
{
    utility::waittill_any( "unset_perk_ads_ping", "death_or_disconnect" );
    
    if ( isdefined( target ) )
    {
        target.var_5493da71c8fb3773 = 0;
    }
}

// Namespace specialty_ads_ping
// Params 1, eflags: 0x4
// Checksum 0xe5d8cfa7, Offset: 0xd1c
// Size: 0x36
function private function_5838042260038477( target )
{
    if ( isdefined( self.var_6c5652205888d74 ) && [[ self.var_6c5652205888d74 ]]( target ) )
    {
        return [];
    }
    
    return [ "physicscontents_playernosight" ];
}

// Namespace specialty_ads_ping
// Params 0, eflags: 0x4
// Checksum 0x33425230, Offset: 0xd5b
// Size: 0x1d
function private function_3a7f8c70163b10f8()
{
    if ( isdefined( self.var_c008b0c65e668f56 ) )
    {
        return [[ self.var_c008b0c65e668f56 ]]();
    }
    
    return 1;
}

