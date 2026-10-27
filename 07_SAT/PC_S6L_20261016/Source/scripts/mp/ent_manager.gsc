// scripts\mp\ent_manager.gsc  (hash_32ea5666970ea249.gscc) (size: 2819 Bytes / 0xb03 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x13c58b09 (331713289)
// size ...... 2819 (0xb03)
// includes .. 0   (offset: 0xaa3)
// strings ... 0   (offset: 0xaa3)
// dev strs .. 8   (offset: 0xaa3)
// exports ... 9   (offset: 0x7a3)
// cseg ...... 0x58 + 0x74b (0x7a3)
// imports ... 13  (offset: 0x90b)
// animtree1 . 0   (offset: 0xb03)
// animtree2 . 0   (offset: 0xb03)
#namespace ent_manager;

// Namespace ent_manager
// Params 0
// Checksum 0x5519e3e6, Offset: 0x76
// Size: 0x8a
function init()
{
    level.entbudgetused = 0;
    level.var_6120a4e67fa8822 = 0;
    level.entbudget = getdvarint( @"hash_3e029cf0de92274b", 200 );
    level.budgetedents = [];
    level.var_42353f51a3bffe46 = 1000;
    
    if ( level.entbudget < 10 )
    {
        level.entbudget = 10;
        assertmsg( "<dev string:x24>" + 10 );
    }
    
    /#
        if ( getdvarint( @"hash_59d5109d6df33a4e", 0 ) )
        {
            level thread function_c9c1693194b68697();
        }
    #/
}

/#

    // Namespace ent_manager
    // Params 0, eflags: 0x4
    // Checksum 0xdfd63d40, Offset: 0x108
    // Size: 0x101, Type: dev
    function private function_c9c1693194b68697()
    {
        while ( true )
        {
            countedcount = 0;
            keys = getarraykeys( level.budgetedents );
            
            foreach ( key in keys )
            {
                ent = level.budgetedents[ key ];
                countedcount += ent.var_1d5418aa1b4de756.entcount ?? 0;
            }
            
            countedcount += level.var_6120a4e67fa8822;
            assert( level.entbudgetused == countedcount );
            
            if ( level.entbudgetused != countedcount )
            {
                wait 2;
            }
            
            waitframe();
        }
    }

#/

// Namespace ent_manager
// Params 1
// Checksum 0xedfe2fa9, Offset: 0x211
// Size: 0x70
function registerspawncount( entcount )
{
    assert( !isdefined( self.var_1d5418aa1b4de756 ) );
    self.var_1d5418aa1b4de756 = { #var_dc241468aee0fac6:1, #entcount:entcount };
    level.entbudgetused += entcount;
    level.var_6120a4e67fa8822 += entcount;
    updatebudget();
}

// Namespace ent_manager
// Params 0
// Checksum 0xe583913f, Offset: 0x289
// Size: 0x16e
function deregisterspawn()
{
    if ( self.var_1d5418aa1b4de756.entcount && !self.var_1d5418aa1b4de756.deregistered )
    {
        level.entbudgetused -= self.var_1d5418aa1b4de756.entcount;
        
        if ( self.var_1d5418aa1b4de756.var_dc241468aee0fac6 )
        {
            level.var_6120a4e67fa8822 -= self.var_1d5418aa1b4de756.entcount;
        }
        
        self.var_1d5418aa1b4de756.entcount = undefined;
        self.var_1d5418aa1b4de756.deregistered = 1;
        
        if ( level.entbudgetused < 0 )
        {
            assertmsg( "<dev string:x51>" );
            level.entbudgetused = 0;
        }
        
        if ( level.var_6120a4e67fa8822 < 0 )
        {
            assertmsg( "<dev string:x81>" );
            level.var_6120a4e67fa8822 = 0;
        }
    }
    
    if ( self.var_1d5418aa1b4de756.entdeletefunc )
    {
        var_e4eefe2a464b6eb4 = self.var_1d5418aa1b4de756.var_1c46d16c818077e9;
        
        if ( var_e4eefe2a464b6eb4 )
        {
            level.budgetedents[ var_e4eefe2a464b6eb4 ] = undefined;
        }
        else
        {
            assertmsg( "<dev string:xb7>" );
        }
        
        self.var_1d5418aa1b4de756.entdeletefunc = undefined;
    }
}

// Namespace ent_manager
// Params 2
// Checksum 0xf972f2bb, Offset: 0x3ff
// Size: 0xa3
function registerspawn( entcount, entdeletefunc )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    assert( !isdefined( self.var_1d5418aa1b4de756 ) );
    var_1c46d16c818077e9 = level.var_42353f51a3bffe46;
    self.var_1d5418aa1b4de756 = { #var_1c46d16c818077e9:var_1c46d16c818077e9, #entdeletefunc:entdeletefunc, #entcount:entcount };
    level.entbudgetused += entcount;
    level.var_42353f51a3bffe46++;
    level.budgetedents[ var_1c46d16c818077e9 ] = self;
    updatebudget();
}

// Namespace ent_manager
// Params 0, eflags: 0x4
// Checksum 0x40db470c, Offset: 0x4aa
// Size: 0x17e
function private updatebudget()
{
    profilestart();
    
    if ( level.entbudgetused > level.entbudget )
    {
        if ( function_6b3644165a072576( level.budgetedents ) )
        {
            function_d181115ea926247c( function_f943bef551ff028c( level.budgetedents ) );
            profilestop();
            return;
        }
        
        firstkey = getfirstarraykey( level.budgetedents );
        
        if ( firstkey )
        {
            oldent = level.budgetedents[ firstkey ];
            var_1d5418aa1b4de756 = oldent.var_1d5418aa1b4de756;
            
            if ( var_1d5418aa1b4de756.entcount && !var_1d5418aa1b4de756.deregistered )
            {
                var_1d5418aa1b4de756.deregistered = 1;
                level.entbudgetused -= var_1d5418aa1b4de756.entcount;
                var_1d5418aa1b4de756.entcount = undefined;
                
                if ( level.entbudgetused < 0 )
                {
                    assertmsg( "<dev string:xce>" );
                    level.entbudgetused = 0;
                }
            }
            
            if ( var_1d5418aa1b4de756.entdeletefunc )
            {
                oldent [[ var_1d5418aa1b4de756.entdeletefunc ]]();
                var_1d5418aa1b4de756.entdeletefunc = undefined;
            }
            else
            {
                assertmsg( "<dev string:xec>" );
            }
            
            level.budgetedents[ firstkey ] = undefined;
        }
        else if ( level.var_6120a4e67fa8822 > level.entbudget )
        {
            assertmsg( "<dev string:x118>" );
        }
        else
        {
            assertmsg( "<dev string:x17b>" );
        }
    }
    
    profilestop();
}

// Namespace ent_manager
// Params 1, eflags: 0x4
// Checksum 0x19fc2546, Offset: 0x630
// Size: 0xb6
function private function_d181115ea926247c( var_8756315aa6f920a6 )
{
    profilestart();
    entbudgetused = 0;
    
    foreach ( ent in var_8756315aa6f920a6 )
    {
        entbudgetused += ent.var_1d5418aa1b4de756.entcount ?? 0;
    }
    
    level.entbudgetused = entbudgetused;
    level.budgetedents = var_8756315aa6f920a6;
    profilestop();
}

/#

    // Namespace ent_manager
    // Params 0
    // Checksum 0xbb4273ca, Offset: 0x6ee
    // Size: 0xb5, Type: dev
    function function_83d7500b56501ebf()
    {
        if ( isdefined( level.budgetedents ) )
        {
            foreach ( ent in level.budgetedents )
            {
                if ( isdefined( ent.var_1d5418aa1b4de756.entdeletefunc ) )
                {
                    ent [[ ent.var_1d5418aa1b4de756.entdeletefunc ]]();
                }
            }
        }
    }

#/
