// script_370eb1ae58a9adf5  (hash_370eb1ae58a9adf5.gscc) (size: 1411 Bytes / 0x583 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2e69b995 (778680725)
// size ...... 1411 (0x583)
// includes .. 2   (offset: 0x55b)
// strings ... 2   (offset: 0x56b)
// dev strs .. 0   (offset: 0x583)
// exports ... 5   (offset: 0x3c7)
// cseg ...... 0x76 + 0x351 (0x3c7)
// imports ... 7   (offset: 0x48f)
// animtree1 . 0   (offset: 0x583)
// animtree2 . 0   (offset: 0x583)
#using scripts\common\callbacks;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace specialty_hardline;

// Namespace specialty_hardline
// Params 0, eflags: 0x1
// Checksum 0xec90d729, Offset: 0x94
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_perk", &registerspecialty );
}

// Namespace specialty_hardline
// Params 1
// Checksum 0xbf2a9c2f, Offset: 0xb4
// Size: 0x3a
function registerspecialty( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_hardline", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_hardline
// Params 0
// Checksum 0x130abc18, Offset: 0xf6
// Size: 0x27f
function setspecialty()
{
    self.var_1c0d67e0aa4bb8fb = self.var_9842326056fd7207.var_1c0d67e0aa4bb8fb ?? 1;
    self.var_90f68a970fd3963f = self.var_9842326056fd7207.var_90f68a970fd3963f ?? 125;
    self.var_c81ed234731dd25a = [ "nuke" ];
    self.var_a336e68c123b86b2 = [];
    self.var_897084b42d897956 = [];
    
    if ( isdefined( self.var_9842326056fd7207.var_c81ed234731dd25a ) )
    {
        foreach ( index, entry in self.var_9842326056fd7207.var_c81ed234731dd25a )
        {
            self.var_c81ed234731dd25a[ entry.streakref ] = 1;
        }
    }
    
    self.var_a336e68c123b86b2 = [];
    
    if ( isdefined( self.var_9842326056fd7207.var_a336e68c123b86b2 ) )
    {
        foreach ( index, entry in self.var_9842326056fd7207.var_a336e68c123b86b2 )
        {
            self.var_a336e68c123b86b2[ entry.streakname ] = entry.cost;
        }
    }
    
    self.var_897084b42d897956 = [];
    
    if ( isdefined( self.var_9842326056fd7207.var_897084b42d897956 ) )
    {
        foreach ( index, entry in self.var_9842326056fd7207.var_897084b42d897956 )
        {
            self.var_897084b42d897956[ entry.streakname ] = entry.cost;
        }
    }
    
    killstreaks::updatestreakcosts();
    thread killstreaks::function_f1923f85651597e9( self.streakpoints );
}

// Namespace specialty_hardline
// Params 0
// Checksum 0x2a9148ed, Offset: 0x37d
// Size: 0x4a
function unsetspecialty()
{
    self.var_1c0d67e0aa4bb8fb = undefined;
    self.var_90f68a970fd3963f = undefined;
    self.var_c81ed234731dd25a = undefined;
    self.var_a336e68c123b86b2 = undefined;
    self.var_897084b42d897956 = undefined;
    self.hardlineactive = undefined;
    self notify( #"hash_1dddc211e7c80a43" );
}

