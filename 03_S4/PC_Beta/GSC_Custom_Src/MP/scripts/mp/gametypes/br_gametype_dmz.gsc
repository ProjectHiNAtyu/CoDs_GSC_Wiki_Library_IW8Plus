//><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><//
// Project HiNAtyu
//><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><//

//=================================================================//
// [ English ]
// Creator       : HiNAtyu
// Created date  : 2025/04/02
// Latest update : 2025/04/02
// ---------------
// [ Japanese ]
// 制作者         : HiNAtyu
// 作成日         : 2025/04/02
// 更新日         : 2025/04/02
// ---------------
// [ Social ]
// YouTube  : http://www.youtube.com/channel/UCmxJAnVPtkStQVKrvAVMZSw?sub_confirmation=1
// Twitter1 : https://x.com/KonataGIF
// Twitter2 : https://twitter.com/H1NAtyu
// Discord  : hinatapoko （ https://discordapp.com/users/239453096026046464 ）
//=================================================================//

//:::::::::::::::::::::::::::::::::::::::::::::::::://
// [ English ]
//   < CoD GSC (C++) syntax explanation >
//     @ level                    = modifier for the entire room
//     @ level.players[i]         = 1 player participating in the room
//     @ self                     = myself where the function is being executed
//     @ thread                   = Execute the specified function in a subthread
//     @ Endon( "event_name" )    = Terminates function processing when the specified event name is issued.
//     @ WaitTill( "event_name" ) = Waits until the specified event name is issued, and then resumes subsequent processing
//     @ Notify( "event_name" )   = Publish the specified event name
//     @ Destroy( )               = Delete the specified variable and its actual state
//     @ IsDefined( variable )    = Check if the specified variable has been created
//     @ ^0                       = Color code (Black)
//     @ ^1                       = Color code (Red)
//     @ ^2                       = Color code (Green)
//     @ ^3                       = Color code (Yellow)
//     @ ^4                       = Color code (Blue)
//     @ ^5                       = Color code (Cyan)
//     @ ^6                       = Color code (Pink)
//     @ ^7                       = Color code (White)
//     @ wait                     = Wait for the specified time
// ---------------------------------------------
// [ Japanese ]
//   < CoD GSC (C++) 構文解説 >
//     @ level                    = 部屋全体に対する修飾子
//     @ level.players[i]         = 部屋に参加しているプレイヤー1個人
//     @ self                     = 関数が実行されている自分自身
//     @ thread                   = 指定した関数をサブスレッドで実行する
//     @ Endon( "event_name" )    = 指定したイベント名が発行されたら、関数の処理を終了する
//     @ WaitTill( "event_name" ) = 指定したイベント名が発行されるまで待機し、イベントが発行されたら、以降の処理を再開する
//     @ Notify( "event_name" )   = 指定したイベント名を発行する
//     @ Destroy( )               = 指定した変数とその実態を削除する
//     @ IsDefined( variable )    = 指定した変数が作成されているか調べる
//     @ ^0                       = カラーコード (黒)
//     @ ^1                       = カラーコード (赤)
//     @ ^2                       = カラーコード (緑)
//     @ ^3                       = カラーコード (黄色)
//     @ ^4                       = カラーコード (青)
//     @ ^5                       = カラーコード (水色)
//     @ ^6                       = カラーコード (ピンク)
//     @ ^7                       = カラーコード (白)
//     @ wait                     = 指定した時間分待機する
//:::::::::::::::::::::::::::::::::::::::::::::::::://





// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : main process
// ja : メイン処理
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



//++++++++++++++++++++++++++++++
// en : returns the corresponding translation for the current language setting.
// ja : 現在の言語設定から対応する翻訳を返す
//++++++++++++++++++++++++++++++
getlangdata( cur , en , ja , cn , ru , de )
{
    switch ( cur )
    {
        case 0: return en;
        case 1: return ja;
        case 2: return cn;
        case 3: return ru;
        case 4: return de;
        default: return en;
    }
}



//++++++++++++++++++++++++++++++
// en : returns the corresponding translation from the current language and specified text id
// ja : 現在の言語と指定のテキストidから、該当する翻訳文を返す
//++++++++++++++++++++++++++++++
getmttext( selflang , textid , usegamepad )
{
    switch ( textid )
    {
        

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// button
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //


        case "buttonaction":           return "[{+action}]";
        case "buttonaction1":          return "[{+actionslot 1}]";
        case "buttonaction2":          return "[{+actionslot 2}]";
        case "buttonaction3":          return "[{+actionslot 3}]";
        case "buttonaction4":          return "[{+actionslot 4}]";
        case "buttonads":              return "[{+speed_throw}]";
        case "buttonattack":           return "[{+attack}]";
        case "buttonchangeseat":       return "[{+switchseat}]";
        case "buttonlethal":           return "[{+frag}]";
        case "buttontactical":         return "[{+smoke}]";
        case "buttonjump":             return "[{+gostand}]";
        case "buttonmelee":            return "[{+melee}]";
        case "buttonoffhandspecial":   return "[{+offhandspecial}]";
        case "buttonreload":           return "[{+usereload}]";
        case "buttonsprint":           return "[{+breath_sprint}]";
        case "buttonstance":           return "[{+stance}]";
        case "buttonuse":              return "[{+activate}]";
        case "buttonvehicleattack":    return "[{+vehicleattack}]";
        case "buttonvehiclemoveup":    return "[{+vehiclemoveup}]";
        case "buttonweaponswitch":     return "[{+weapnext_inventory}]";

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// welcome
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //

        case "projectname":
            return getlangdata( selflang ,
                "^3P^7roject ^5H^7iN^1A^7tyu" ,
                "^3プ^7ロジェクト ^5ひ^7な^1ち^7ゅ" ,
                "^5H^7iN^1A^7tyu ^7計畫" ,
                "^7проект ^5огонь^1На^7Чуу" ,
                "^3P^7rojekt ^5H^7iN^1A^7tyu" );


        case "welcometo":
            return getlangdata( selflang ,
                "^3Welcome to " ,
                "^3ようこそ、" ,
                "^3欢迎，" ,
                "^3добро пожаловать," ,
                "^3Willkommen bei" );


        case "welcometo_ver2":
            return getlangdata( selflang ,
                "Welcome to " ,
                "ようこそ、" ,
                "欢迎，" ,
                "добро пожаловать," ,
                "Willkommen bei" );

            
        case "moddedlobby":
            return getlangdata( selflang ,
                " ^3modded lobby." ,
                " ^3の改造部屋へ。" ,
                " ^3前往改造后的房间。" ,
                " ^3В отремонтированную комнату." ,
                " ^3modifizierte Lobby." );

            
        case "moddedlobby_ver2":
            return getlangdata( selflang ,
                " modded lobby." ,
                " の改造部屋へ。" ,
                " 前往改造后的房间。" ,
                " В отремонтированную комнату." ,
                " modifizierte Lobby." );
                
        case "created":
            return getlangdata( selflang ,
                " ^3Created " ,
                " ^3制作の " ,
                " ^3创建 " ,
                " ^3созданный " ,
                " ^3Produktion " );

        case "learngsc":
            return getlangdata( selflang ,
            	"^6Basic learning ^3& ^2Free version ^3GSC",
                "^6基礎学習 ^3& ^2フリー版 ^3GSC",
                "^6基础学习 ^3& ^2免费版 ^3GSC",
                "^6Базовое обучение ^3& ^2Бесплатная версия ^3GSC",
                "^6Grundlagenlernen ^3& ^2Kostenlose Version von ^3GSC" );

        case "yourmenustatus":
            return getlangdata( selflang ,
                "^3" + self.name + " status : " ,
                "^3" + self.name + "の権限階級 : " ,
                "^3" + self.name + " 地位 : " ,
                "^3" + self.name + " положение дел : " ,
                "^3" + self.name + " status : " );

            
        case "modmenuopendescription":
            return getlangdata( selflang ,
                "^3Open mod menu to press^1 "            + getmttext( selflang , "buttonads" ) + " + " + getmttext( selflang , "buttonmelee" ) + "^3." ,
                "^3モッドメニューは^1 "                   + getmttext( selflang , "buttonads" ) + " + " + getmttext( selflang , "buttonmelee" ) + " ^3で開けます。" ,
                "^3按^1 "                                + getmttext( selflang , "buttonads" ) + " + " + getmttext( selflang , "buttonmelee" ) + " ^3可以打开模组菜单。" ,
                "^3Меню мода можно открыть, нажав^1 "    + getmttext( selflang , "buttonads" ) + " + " + getmttext( selflang , "buttonmelee" ) + "." ,
                "^3Öffne das Mod-Menü, um zu drücken^1 " + getmttext( selflang , "buttonads" ) + " + " + getmttext( selflang , "buttonmelee" ) + "^3." );

        case "modmenucontroldescription":
            if ( usegamepad == true )
            {
                return getlangdata( selflang ,
                    "^3Scroll"       + getmttext( selflang , "buttonads" ) + getmttext( selflang , "buttonattack" ) + "^3|Decide" + getmttext( selflang , "buttonlethal" ) + getmttext( selflang , "buttonuse" ) + "^3|Back" + getmttext( selflang , "buttonlethal" ) + getmttext( selflang , "buttonmelee" ) ,
                    "^3スクロール"   + getmttext( selflang , "buttonads" ) + getmttext( selflang , "buttonattack" ) + "^3｜決定"   + getmttext( selflang , "buttonlethal" ) + getmttext( selflang , "buttonuse" ) + "^3｜戻る" + getmttext( selflang , "buttonlethal" ) + getmttext( selflang , "buttonmelee" ) ,
                    "^3滚动"         + getmttext( selflang , "buttonads" ) + getmttext( selflang , "buttonattack" ) + "^3｜决定"   + getmttext( selflang , "buttonlethal" ) + getmttext( selflang , "buttonuse" ) + "^3｜后退" + getmttext( selflang , "buttonlethal" ) + getmttext( selflang , "buttonmelee" ) ,
                    "^3Прокрутка"    + getmttext( selflang , "buttonads" ) + getmttext( selflang , "buttonattack" ) + "^3｜Решать" + getmttext( selflang , "buttonlethal" ) + getmttext( selflang , "buttonuse" ) + "^3｜Назад" + getmttext( selflang , "buttonlethal" ) + getmttext( selflang , "buttonmelee" ) ,
                    "^3Scrollen"    + getmttext( selflang , "buttonads" ) + getmttext( selflang , "buttonattack" ) + "3｜Entscheiden" + getmttext( selflang , "buttonlethal" ) getmttext( selflang , "buttonuse" ) + "^3｜Zurück" + getmttext( selflang , "buttonlethal" ) + getmttext( selflang , "buttonmelee" ) );
            }
            else
            {
                return getlangdata( selflang ,
                    "^3Scroll"       + getmttext( selflang , "buttontactical" ) + getmttext( selflang , "buttonuse" ) + "^3|Decide" + getmttext( selflang , "buttonads" ) + getmttext( selflang , "buttonuse" ) + "^3|Back" + getmttext( selflang , "buttonads" ) + getmttext( selflang , "buttonmelee" ) ,
                    "^3スクロール"   + getmttext( selflang , "buttontactical" ) + getmttext( selflang , "buttonuse" ) + "^3｜決定"   + getmttext( selflang , "buttonads" ) + getmttext( selflang , "buttonuse" ) + "^3｜戻る" + getmttext( selflang , "buttonads" ) + getmttext( selflang , "buttonmelee" ) ,
                    "^3滚动"         + getmttext( selflang , "buttontactical" ) + getmttext( selflang , "buttonuse" ) + "^3｜决定"   + getmttext( selflang , "buttonads" ) + getmttext( selflang , "buttonuse" ) + "^3｜后退" + getmttext( selflang , "buttonads" ) + getmttext( selflang , "buttonmelee" ) ,
                    "^3Прокрутка"    + getmttext( selflang , "buttontactical" ) + getmttext( selflang , "buttonuse" ) + "^3｜Решать" + getmttext( selflang , "buttonads" ) + getmttext( selflang , "buttonuse" ) + "^3｜Назад" + getmttext( selflang , "buttonads" ) + getmttext( selflang , "buttonmelee" ) ,
                    "^3Scrollen"    + getmttext( selflang , "buttontactical" ) + getmttext( selflang , "buttonuse" ) + "^3｜Entscheiden" + getmttext( selflang , "buttonads" ) + getmttext( selflang , "buttonuse" ) + "^3｜Zurück" + getmttext( selflang , "buttonads" ) + getmttext( selflang , "buttonmelee" ) );
            }

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// verification
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //

        case "host":
            return getlangdata( selflang ,
                "^7[^5Host^7]" ,
                "^7[^5ホスト^7]" ,
                "^7[^5主持人^7]" ,
                "^7[^5хозяин^7]" ,
                "^7[^5Gastgeber^7]" );

        case "cohost":
            return getlangdata( selflang ,
                "^7[^4Co-host^7]" ,
                "^7[^4副ホスト^7]" ,
                "^7[^4次要宿主^7]" ,
                "^7[^4вторичный хост^7]" ,
                "^7[^4Co-gastgeber^7]" );

        case "admin":
            return getlangdata( selflang ,
                "^7[^1Admin^7]" ,
                "^7[^1管理者^7]" ,
                "^7[^1行政人员^7]" ,
                "^7[^1администратор^7]" ,
                "^7[^1Verwaltung^7]" );

        case "vip":
            return getlangdata( selflang ,
                "^7[^2VIP^7]" ,
                "^7[^2要人^7]" ,
                "^7[^2重要的人^7]" ,
                "^7[^2важная личность^7]" ,
                "^7[^2VIP^7]" );

        case "verified":
            return getlangdata( selflang ,
                "^7[^6Verified^7]" ,
                "^7[^6承認者^7]" ,
                "^7[^6授权人^7]" ,
                "^7[^6Авторизирующий^7]" ,
                "^7[^6Verifiziert^7]" );

        case "unverified":
            return getlangdata( selflang ,
                "^7[^3Unverified^7]" ,
                "^7[^3未承認^7]" ,
                "^7[^3未批准^7]" ,
                "^7[^3Не одобрено^7]" ,
                "^7[^3Nicht verifiziert^7]" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// root menus
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //

        case "creditsmenu":
            return getlangdata( selflang ,
                "Credits" ,
                "スタッフロール" ,
                "制作人员" ,
                "Кредиты" ,
                "Credits" );

        case "mainmodsmenu":
            return getlangdata( selflang ,
                "Main mods menu" ,
                "主要なモッドメニュー" ,
                "主模组菜单" ,
                "Главное меню модов" ,
                "Hauptmenü der Mods" );

        case "languagesmenu":
            return getlangdata( selflang ,
                "Languages menu" ,
                "言語メニュー" ,
                "语言菜单" ,
                "языковое меню" ,
                "Sprachenmenü" );

        case "designmenu":
            return getlangdata( selflang ,
                "Design menu" ,
                "デザインメニュー" ,
                "设计菜单" ,
                "Дизайнерское меню" ,
                "Menü „Design“" );

        case "messagesmenu":
            return getlangdata( selflang ,
                "Messages menu" ,
                "会話メニュー" ,
                "消息菜单" ,
                "Меню сообщений" ,
                "Menü „Nachrichten“" );

        case "combatassistmenu":
            return getlangdata( selflang ,
                "Combat assist menu" ,
                "戦闘補助メニュー" ,
                "战斗辅助菜单" ,
                "Меню боевой помощи" ,
                "Kampfassistenzmenü" );

        case "perksmenu":
            return getlangdata( selflang ,
                "Perks menu" ,
                "パークメニュー" ,
                "福利菜单" ,
                "Меню привилегий" ,
                "Vergünstigungsmenü" );

        case "visionsmenu":
            return getlangdata( selflang ,
                "Visions menu" ,
                "画質メニュー" ,
                "愿景菜单" ,
                "Меню видений" ,
                "Visions-Menü" );

        case "funnymenu":
            return getlangdata( selflang ,
                "Funny menu" ,
                "面白いメニュー" ,
                "有趣的菜单" ,
                "Забавное меню" ,
                "Lustiges Menü" );

        case "modelsmenu":
            return getlangdata( selflang ,
                "Models menu" ,
                "3Dモデルメニュー" ,
                "型号菜单" ,
                "Меню моделей" ,
                "Modelle-Menü" );
                
        case "skinsmenu":
            return getlangdata( selflang ,  
                "Skin menu" ,  
                "スキンメニュー" ,  
                "皮肤菜单" ,  
                "Меню обликов" ,  
                "Hautmenü" );  

        case "weaponsmenu":
            return getlangdata( selflang ,
                "Weapons menu" ,
                "武器メニュー" ,
                "武器菜单" ,
                "Меню оружия" ,
                "Waffenmenü" );

        case "customweaponsmenu":
            return getlangdata( selflang ,
                "Custom weapons menu" ,
                "カスタム武器メニュー" ,
                "自定义武器菜单" ,
                "Меню пользовательского оружия" ,
                "Benutzerdefiniertes Waffenmenü" );

        case "bulletsmenu":
            return getlangdata( selflang ,
                "Bullets menu" ,
                "弾薬メニュー" ,
                "项目符号菜单" ,
                "маркированное меню" ,
                "Aufzählungsmenü" );

        case "popularmenu":
            return getlangdata( selflang ,
                "Popular menu" ,
                "汎用機能メニュー" ,
                "热门菜单" ,
                "Популярное меню" ,
                "Beliebtes Menü" );

        case "accountmenu":
            return getlangdata( selflang ,
                "Account menu" ,
                "アカウントメニュー" ,
                "帐户菜单" ,
                "Меню аккаунта" ,
                "Kontomenü" );

        case "killstreaksmenu":
            return getlangdata( selflang ,
                "Killstreaks menu" ,
                "キルストリークメニュー" ,
                "连杀记录菜单" ,
                "Меню убийств" ,
                "Killstreaks-Menü" );

        case "customkillstreaksmenu":
            return getlangdata( selflang ,
                "Custom killstreaks menu" ,
                "カスタムキルストリークメニュー" ,
                "自定义连杀菜单" ,
                "Пользовательское меню серий убийств" ,
                "Benutzerdefiniertes Killstreaks-Menü" );

        case "poweredmenu":
            return getlangdata( selflang ,
                "Powered menu" ,
                "超強力メニュー" ,
                "强大的菜单" ,
                "Мощное меню" ,
                "Powered-Menü" );

        case "aimbotsmenu":
            return getlangdata( selflang ,
                "Aimbots menu" ,
                "オートエイムメニュー" ,
                "自动瞄准菜单" ,
                "Меню автоматического прицеливания" ,
                "Aimbots-Menü" );

        case "vehiclesmenu":
            return getlangdata( selflang ,
                "Vehicles menu" ,
                "乗り物メニュー" ,
                "车辆菜单" ,
                "Меню транспортных средств" ,
                "Fahrzeuge-Menü" );

        case "spawnsmenu":
            return getlangdata( selflang ,
                "Spawns menu" ,
                "生成メニュー" ,
                "生成菜单" ,
                "Меню появления" ,
                "Spawns-Menü" );

        case "gamesettingsmenu":
            return getlangdata( selflang ,
                "Game settings menu" ,
                "ゲーム設定メニュー" ,
                "游戏设置菜单" ,
                "Меню настроек игры" ,
                "Spieleinstellungsmenü" );

        case "playersmenu":
            return getlangdata( selflang ,
                "Players menu" ,
                "プレイヤーメニュー" ,
                "播放器菜单" ,
                "меню плеера" ,
                "Spielermenü" );

        case "allplayersmenu":
            return getlangdata( selflang ,
                "All players menu" ,
                "全プレイヤーメニュー" ,
                "所有玩家菜单" ,
                "Меню всех игроков" ,
                "Menü „Alle Spieler“" );


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// basic system word
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //

        case "enabled":
            return getlangdata( selflang ,
                "^7[^2Enabled^7] " ,
                "^7[^2有効化^7] " ,
                "^7[^2激活^7] " ,
                "^7[^2активация^7] " ,
                "^7[^2Ermöglicht^7] " );

        case "disabled":
            return getlangdata( selflang ,
                "^7[^1Disabled^7] " ,
                "^7[^1無効化^7] " ,
                "^7[^1无效^7] " ,
                "^7[^1Аннулирование^7] " ,
                "^7[^1Deaktiviert^7] " );

        case "notice":
            return getlangdata( selflang ,
                "^7[^3Notice^7] " ,
                "^7[^3通知^7] " ,
                "^7[^3通知^7] " ,
                "^7[^3уведомление^7] " ,
                "^7[^3Beachten^7] " );

        case "warning":
            return getlangdata( selflang ,
                "^7[^6Warning^7] " ,
                "^7[^6警告^7] " ,
                "^7[^6警告^7] " ,
                "^7[^6Предупреждение^7] " ,
                "^7[^6Warnung^7] " );

        case "failed":
            return getlangdata( selflang ,
                "^7[^1Failed^7] " ,
                "^7[^1失敗^7] " ,
                "^7[^1失败的^7] " ,
                "^7[^1Неуспешный^7] " ,
                "^7[^1Fehlgeschlagen^7] " );

        case "success":
            return getlangdata( selflang ,
                "^7[^8Success^7] " ,  
                "^7[^8成功^7] " ,  
                "^7[^8成功^7] " ,  
                "^7[^8Успех^7] " ,  
                "^7[^8Erfolg^7] " );
      
        case "notfuncexec":
            return getlangdata( selflang ,
                "Function not executed" ,
                "機能が未実行です" ,
                "函数未执行" ,
                "Функция не выполнена" ,
                "Funktion nicht ausgeführt" );

        case "unimplementedfunction":
            return getlangdata( selflang ,
                "This function is not yet implemented." ,
                "この機能は未実装です。" ,
                "该功能尚未实现。" ,
                "Эта функция еще не реализована." ,
                "Diese Funktion ist derzeit noch nicht implementiert." );

        case "pleaseshooting":
            return getlangdata( selflang ,
                "Please specify the coordinates by shooting" ,
                "銃撃で座標指定してください" ,
                "拍下请注明坐标" ,
                "Пожалуйста, укажите координаты при съемке" ,
                "Bitte geben Sie die Koordinaten durch Aufnahme an" );

        case "requestlocation":
            return getlangdata( selflang ,
                "Request specified location" ,
                "指定座標に要請" ,
                "请求指定位置" ,
                "Запросить указанное местоположение" ,
                "Angegebenen Standort anfordern" );

        case "waitendfunction":
            return getlangdata( selflang ,
                "Please wait until the running function finishes" ,
                "実行中の機能が終了するまでお待ちください" ,
                "请等待运行函数完成" ,
                "Пожалуйста, подождите, пока работающая функция завершится." ,
                "Bitte warten Sie, bis die laufende Funktion beendet ist" );

        case "cannothost":
            return getlangdata( selflang ,
                "No operations can be performed on the host." ,
                "ホストに対して操作はできません。" ,
                "无法对主机进行任何操作。" ,
                "На хосте нельзя выполнять никакие операции." ,
                "Auf dem Host können keine Vorgänge ausgeführt werden." );

        case "cannotusedata":
            return getlangdata( selflang ,
                "This data is not available in the current map mode." ,
                "現在のマップ・モードではこのデータの使用ができません。" ,
                "此数据在当前地图模式下不可用。" ,
                "Эти данные недоступны в текущем режиме карты." ,
                "Diese Daten sind im aktuellen Kartenmodus nicht verfügbar." );
                
        case "changelanguage":
            return getlangdata( selflang ,
                "Language change",
                "言語変更",
                "语言更改",
                "Смена языка",
                "Sprachwechsel" );

        case "setmenustatus":
            return getlangdata( selflang ,
                "Set status" ,
                "権限階級の設定" ,
                "设置状态" ,
                "Установить статус" ,
                "Status festlegen" );

        case "---": return "----------";
        
        case "lang_en": return "EN: English";
        case "lang_ja": return "JA: 日本語";
        case "lang_cn": return "CN: 简体中文";
        case "lang_ru": return "RU: Русский";
        case "lang_de": return "DE: Deutsch";
        
        case "start":
            return getlangdata( selflang ,
                "START" ,
                "開始" ,
                "开始" ,
                "начинать" ,
                "START" );


        case "createobject":
            return getlangdata( selflang ,
                "Create object" ,
                "オブジェクト作成" ,
                "创建对象" ,
                "Создать объект" ,
                "Objekt erstellen" );

        case "failedbuildweapon":
            return getlangdata( selflang ,
                "Failed build weapon" ,
                "武器の生成に失敗" ,
                "打造武器失败" ,
                "Не удалось построить оружие" ,
                "Fehlgeschlagener Waffenbau" );

        case "failedspawnobject":
            return getlangdata( selflang ,
                "Failed to spawn object" ,
                "オブジェクトの作成に失敗" ,
                "无法生成对象" ,
                "Не удалось создать объект" ,
                "Objekt konnte nicht erzeugt werden" );

        case "getweapon":
            return getlangdata( selflang ,
                "Get weapon" ,
                "武器の入手" ,
                "获取武器" ,
                "Получить оружие" ,
                "Waffe holen" );

        case "nohaveweapon":
            return getlangdata( selflang ,
                "No have weapon" ,
                "武器の未所持" ,
                "没有武器" ,
                "нет оружия" ,
                "Keine Waffe" );

        case "alreadyhaveweapon":
            return getlangdata( selflang ,
                "Already have weapon" ,
                "武器の既所持" ,
                "已经拥有武器" ,
                "Оружие уже есть" ,
                "Habe bereits Waffe" );


        case "startcharge":
            return getlangdata( selflang ,
                "Start charging" ,
                "チャージ開始" ,
                "开始充电" ,
                "Начать зарядку" ,
                "Laden beginnen" );

        case "finishcharge":
            return getlangdata( selflang ,
                "Charge completed" ,
                "チャージ完了" ,
                "充电完成" ,
                "Заряд завершен" ,
                "Laden abgeschlossen" );

        case "readylaunch":
            return getlangdata( selflang ,
                "Ready to launch" ,
                "発射準備完了" ,
                "准备启动" ,
                "Готов к запуску" ,
                "Bereit zum Starten" );

        case "changeanimation":
            return getlangdata( selflang ,
                "Change animation" ,
                "アニメーション変更" ,
                "改变动画" ,
                "Изменить анимацию" ,
                "Animation ändern" );


        case "usetoride":
            return getlangdata( selflang ,
                getmttext( selflang , "buttonuse" ) + " to ride / " + getmttext( selflang , "buttonlethal" ) + " to get off" ,
                getmttext( selflang , "buttonuse" ) + " で乗車 / " + getmttext( selflang , "buttonlethal" ) + " で降車 できます" ,
                getmttext( selflang , "buttonuse" ) + " 乘车/ " + getmttext( selflang , "buttonlethal" ) + " 下车" ,
                getmttext( selflang , "buttonuse" ) + " — ехать / " + getmttext( selflang , "buttonlethal" ) + " — выходить" ,
                getmttext( selflang , "buttonuse" ) + " reiten / " + getmttext( selflang , "buttonlethal" ) + " aussteigen" );

        case "movetoviewpoint":
            return getlangdata( selflang ,
                "Move to viewpoint" ,
                "視点方向に移動" ,
                "向视点移动" ,
                "Двигайтесь к точке обзора" ,
                "Zum Standpunkt bewegen" );

        case "addbot":
            return getlangdata( selflang ,
                "Add bot" ,
                "botの追加" ,
                "添加机器人" ,
                "Добавить бота" ,
                "Bot hinzufügen" );

        case "kickbot":
            return getlangdata( selflang ,
                "Kick bot" ,
                "botのキック" ,
                "踢机器人" ,
                "Выгнать бота" ,
                "Bot kicken" );


        case "changeview":
            return getlangdata( selflang ,
                "Change view person" ,
                "視点変更" ,
                "观点改变" ,
                "Изменение перспективы" ,
                "Ansichtsperson ändern" );

        case "firstperson":
            return getlangdata( selflang ,
                "First person" ,
                "1人称視点" ,
                "第一人称视角" ,
                "вид от первого лица" ,
                "Erste Person" );

        case "ignorecollision":
            return getlangdata( selflang ,
                "Ignore collision" ,
                "コリジョン（衝突）の無視" ,
                "忽略碰撞" ,
                "Игнорировать столкновение" ,
                "Kollision ignorieren" );

        case "ignoreplayer":
            return getlangdata( selflang ,
                "Ignore player" ,
                "プレイヤーの無視" ,
                "忽略玩家" ,
                "Игнорировать игрока" ,
                "Spieler ignorieren" );

        case "ignoreentity":
            return getlangdata( selflang ,
                "Ignore entity" ,
                "エンティティ（オブジェクト）の無視" ,
                "忽略实体" ,
                "Игнорировать объект" ,
                "Objekt ignorieren" );

        case "default":
            return getlangdata( selflang ,
                "Default" ,
                "デフォルト" ,
                "默认" ,
                "По умолчанию" ,
                "Standard" );

        case "value_x":
            return getlangdata( selflang ,
                "x" ,
                "倍" ,
                "倍" ,
                " раза" ,
                "x" );

        case "tracelength":
            return getlangdata( selflang ,
                "Bullet trace length" ,
                "発射先への移動量" ,
                "子弹轨迹长度" ,
                "Длина следа пули" ,
                "Länge der Kugelspur" );

        case "spawnlength":
            return getlangdata( selflang ,
                "Spawn trace length" ,
                "生成先の距離" ,
                "生成轨迹长度" ,
                "Длина трассировки спауна" ,
                "Länge der Spawnspur" );

        case "getobject":
            return getlangdata( selflang ,
                "Get object" ,
                "オブジェクト取得" ,
                "获取对象" ,
                "Получить объект" ,
                "Objekt abrufen" );

        case "deleteobject":
            return getlangdata( selflang ,
                "Delete object" ,
                "オブジェクト削除" ,
                "删除对象" ,
                "Создать объект" ,
                "Objekt löschen" );

        case "rotatexaxis":
            return getlangdata( selflang ,
                "Rotate object X axis" ,
                "オブジェクトX軸回転" ,
                "旋转对象 X 轴" ,
                "Поворот объекта по оси X" ,
                "Objekt X-Achse drehen" );

        case "changespawnedmodel":
            return getlangdata( selflang ,
                "Change spawned model" ,
                "作成オブジェクト種類変更" ,
                "更改生成模型" ,
                "Изменить порожденную модель" ,
                "Gespawntes Modell ändern" );

        case "deletelastobject":
            return getlangdata( selflang ,
                "Delete the last spawned object" ,
                "最後に生成したオブジェクトの削除" ,
                "删除最后生成的对象" ,
                "Удалить последний созданный объект" ,
                "Zuletzt gespawntes Objekt löschen" );


        case "autolinkonspawn":
            return getlangdata( selflang ,
                "Auto link on spawned" ,
                "生成時に自動同期" ,
                "生成时自动链接" ,
                "Автоматическая ссылка при появлении" ,
                "Automatische Verknüpfung bei Spawn" );
                

        case "combineobject":
            return getlangdata( selflang ,
                "Combine object" ,
                "オブジェクト結合" ,
                "组合对象" ,
                "Объединить объект" ,
                "Objekt kombinieren" );


        case "acceleration":
            return getlangdata( selflang ,
                "Acceleration" ,
                "加速" ,
                "加速度" ,
                "ускорение" ,
                "Beschleunigung" );


        case "deceleration":
            return getlangdata( selflang ,
                "Deceleration" ,
                "減速" ,
                "减速" ,
                "замедление" ,
                "Verzögerung" );

        case "linkobject":
            return getlangdata( selflang ,
                "Link object" ,
                "オブジェクト同期" ,
                "链接对象" ,
                "Связать объект" ,
                "Objekt verknüpfen" );

        case "unlinkobject":
            return getlangdata( selflang ,
                "Unlink object" ,
                "オブジェクト同期解除" ,
                "取消链接对象" ,
                "Отсоединить объект" ,
                "Objektverknüpfung aufheben" );

        case "noobject":
            return getlangdata( selflang ,
                "No object" ,
                "オブジェクトがありません" ,
                "没有对象" ,
                "Нет объекта" ,
                "Kein Objekt" );

        case "movestop":
            return getlangdata( selflang ,
                "Move stop" ,
                "移動の停止" ,
                "移动停止" ,
                "Переместить остановку" ,
                "Bewegungsstopp" );

        case "moveup":
            return getlangdata( selflang ,
                "Move up" ,
                "上に移動" ,
                "上升" ,
                "Переместить вверх" ,
                "Nach oben bewegen" );

        case "movedown":
            return getlangdata( selflang ,
                "Move down" ,
                "下に移動" ,
                "下移" ,
                "Двигаться вниз" ,
                "Nach unten bewegen" );


        case "moveupdown":
            return getlangdata( selflang ,
                "Move up/down" ,
                "上下に移動" ,
                "上/下移动" ,
                "Двигаться вверх/вниз" ,
                "Nach oben/unten bewegen" );

        case "moveright":
            return getlangdata( selflang ,
                "Move right" ,
                "右に移動" ,
                "向右移" ,
                "Двигаться вправо" ,
                "Nach rechts bewegen" );

        case "moveleft":
            return getlangdata( selflang ,
                "Move left" ,
                "左に移動" ,
                "向左移动" ,
                "Двигай влево" ,
                "Nach links bewegen" );

        case "moverightleft":
            return getlangdata( selflang ,
                "Move right/left" ,
                "左右に移動" ,
                "向右/向左移动" ,
                "Двигаться вправо/влево" ,
                "Nach rechts/links bewegen" );

        case "moveforward":
            return getlangdata( selflang ,
                "Move forward" ,
                "前に移動" ,
                "前进" ,
                "Двигаться вперед" ,
                "Vorwärts bewegen" );

        case "moveback":
            return getlangdata( selflang ,
                "Move back" ,
                "後ろに移動" ,
                "向后移动" ,
                "Вернуться назад" ,
                "Zurück bewegen" );

        case "moveforwardback":
            return getlangdata( selflang ,
                "Move forward/back" ,
                "前後に移動" ,
                "向前/向后移动" ,
                "Двигаться вперед/назад" ,
                "Vorwärts/zurück bewegen" );

        case "spinyaw":
            return getlangdata( selflang ,
                "Spinning yaw" ,
                "ヨー回転" ,
                "旋转偏航" ,
                "Вращение рыскания" ,
                "Drehendes Gieren" );

        case "spinroll":
            return getlangdata( selflang ,
                "Spinning roll" ,
                "ロール回転" ,
                "纺纱辊" ,
                "Вращающийся рулон" ,
                "Drehendes Rollen" );

        case "spinpitch":
            return getlangdata( selflang ,
                "Spinning pitch" ,
                "ピッチ回転" ,
                "旋转节距" ,
                "Вращающееся поле" ,
                "Drehendes Nicken" );

        case "spinstop":
            return getlangdata( selflang ,
                "Spinning stop" ,
                "回転停止" ,
                "旋转停止" ,
                "Вращающаяся остановка" ,
                "Drehender Stopp" );

        case "movechange":
            return getlangdata( selflang ,
                "Movement change" ,
                "移動変更" ,
                "动作变化" ,
                "Изменение движения" ,
                "Bewegungsänderung" );

        case "randomsetting":
        case "changekamikazebomberrandom":
            return getlangdata( selflang ,
                "Random settings",
                "ランダム設定",
                "随机设置",
                "Случайные настройки",
                "Zufällige Einstellungen" );

        case "spinchange":
        case "changekamikazebomberspinning":
            return getlangdata( selflang ,
                "Spinning change" ,
                "回転変更" ,
                "纺纱变化" ,
                "Смена спиннинга" ,
                "Drehend ändern" );


        case "fromsetting":
            return getlangdata( selflang ,
                "from setting" ,
                "設定から" ,
                "从设置" ,
                "от установки" ,
                "von Einstellung" );


        case "frommemorized":
            return getlangdata( selflang ,
                "from memorized" ,
                "記憶データから" ,
                "从背下来的" ,
                "Из запомненных" ,
                "von gespeichert" );


        case "firedcreate":
            return getlangdata( selflang ,
                "Create object at launch destination" ,
                "発射先の座標にオブジェクト作成" ,
                "在启动目的地创建对象" ,
                "Создать объект в пункте назначения запуска" ,
                "Objekt am Startziel erstellen" );


        case "changespawnedtime":
            return getlangdata( selflang ,
                "Change object spawned interval" ,
                "オブジェクトの生成インターバル変更" ,
                "更改对象生成间隔" ,
                "Изменить интервал появления объекта" ,
                "Objekt-Erstellungsintervall ändern" );



// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// creditsmenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //

        case "credit_hinatyu":
            return "-----[ ^5H^7iN^1A^7tyu ]-----";

        case "credit_hinatyu_1":
            return getlangdata( selflang ,
                "Mod menu developer" ,
                "モッドメニューの開発" ,
                "Mod 菜单开发者" ,
                "Разработчик мод-меню" ,
                "Mod-Menüentwickler" );

        case "credit_hinatyu_2":
            return getlangdata( selflang ,  
                "Fully custom menu-based system" ,  
                "完全独自メニューベースシステム" ,  
                "完全自定义菜单基础系统" ,  
                "Полностью пользовательская система на основе меню" ,  
                "Vollständig benutzerdefiniertes menübasiertes System" );  

        case "credit_hinatyu_3":
            return getlangdata( selflang ,  
                "Analysis of CoD GSCBIN" ,  
                "CoD GSCBINの解析" ,  
                "CoD GSCBIN的分析" ,  
                "Анализ CoD GSCBIN" ,  
                "Analyse von CoD GSCBIN" );  

        case "credit_hinatyu_4":
            return getlangdata( selflang ,  
                "Implementation of various utility functions" ,  
                "各種汎用関数の実装" ,  
                "各种通用函数的实现" ,  
                "Реализация различных универсальных функций" ,  
                "Implementierung verschiedener Hilfsfunktionen" );


        case "horizontalscrollhmenu":
            return getlangdata( selflang ,  
                "Horizontal scroll menu" ,  
                "横スクロールメニュー" ,  
                "横向滚动菜单" ,  
                "Горизонтальное прокачиваемое меню" ,  
                "Horizontal scroll Menü" );

        case "customtextmenu":
            return getlangdata( selflang ,  
                "Custom text menu" ,  
                "カスタムテキストメニュー" ,  
                "自定义文本菜单" ,  
                "Меню пользовательского текста" ,  
                "Benutzerdefiniertes Textmenü" );
                

        case "modelanimationsystem":
            return getlangdata( selflang ,  
                "3D model animation system" ,  
                "3Dモデルアニメーションシステム" ,  
                "3D模型动画系统" ,  
                "Система анимации 3D-моделей" ,  
                "3D-Modell-Animationssystem" );
                
                
        case "multitranssystem":
            return getlangdata( selflang ,
                "Multilingual translation system" ,
                "多言語翻訳システム" ,
                "多语言翻译系统" ,
                "Многоязычная система перевода" ,
                "Mehrsprachiges Übersetzungssystem" );

        case "credit_wrekless":
            return getlangdata( selflang ,
                "WrekLess : Project leader & debug" ,
                "WrekLess : プロジェクトリーダー & デバッグ" ,
                "WrekLess : 项目负责人及调试" ,
                "WrekLess : Руководитель проекта и отладчик" ,
                "WrekLess : Projektleiter & Debug" );

        case "credit_kam":
            return "-----[ ^5Kam (BOCW)^7 ]-----";

        case "credit_kam_1":
            return getlangdata( selflang ,  
                "Tips for horizontal scroll menu" ,  
                "横スクロールメニューのヒント" ,  
                "横向滚动菜单的提示" ,  
                "Советы по горизонтальному прокачиваемому меню" ,  
                "Tipps für das horizontale Scroll-Menü" );  

        case "credit_m":
            return "-----[ ^6m^7 ]-----";


        case "credit_m_1":
            return getlangdata( selflang ,  
                "High-speed development client exclusively for IW8" ,  
                "IW8専用高速開発クライアント" ,  
                "IW8专用高速开发客户端" ,  
                "Высокоскоростной клиент разработки исключительно для IW8" ,  
                "Hochgeschwindigkeits-Entwicklungsklient ausschließlich für IW8" );  

        case "credit_ate47":
            return "-----[ ^2ATE47^7 ]-----";


        case "credit_ate47_1":
            return getlangdata( selflang ,
                "BOCW analysis" ,
                "BOCWのデータ解析" ,
                "BOCW分析" ,
                "BOCW-анализ" ,
                "BOCW-Analyse" );


        case "credit_ate47_2":
            return getlangdata( selflang ,
                "All axes advanced noclip" ,
                "全軸高度空中飛行" ,
                "所有轴高级 noclip" ,
                "Расширенный noclip для всех осей" ,
                "Alle Achsen erweitert, Noclip" );

        case "credit_extincts":
            return "-----[ ^3Extincts^7 ]-----";

        case "credit_extincts_1": //GBP & cocaine
            return getlangdata( selflang ,  
                "Reference for IW8 2023 menu-based system" ,  
                "IW8 2023 メニューベースの参考" ,  
                "IW8 2023 菜单基础的参考" ,  
                "Справка по меню-ориентированной системе IW8 2023" ,  
                "Referenz für das menübasierte System von IW8 2023" );  

        case "credit_extincts_2":
            return getmttext( selflang , "attractions" );

        case "credit_jydenx":
            return "-----[ ^8jydenx^7 ]-----";

        case "credit_jydenx_1":
            return getlangdata( selflang ,
                "Providing function information" ,
                "関数情報の提供" ,
                "提供功能信息" ,
                "Предоставление функциональной информации" ,
                "Funktionsinformationen bereitstellen" );

        case "credit_jydenx_2":
            return getlangdata( selflang ,  
                "Tips on custom text" ,  
                "カスタムテキストに関するヒント" ,  
                "关于自定义文本的提示" ,  
                "Советы по пользовательскому тексту" ,  
                "Hinweise zum benutzerdefinierten Text" );  

        case "credit_zeropoint":
            return "-----[ ^4zeropoint^7 ]-----";

        case "credit_zeropoint_1":
            return getlangdata( selflang ,
                "Weapons & Perks ID" ,
                "武器 & パーク ID" ,
                "武器和特权 ID" ,
                "Идентификатор оружия и перков" ,
                "Waffen- und Perks-ID" );

        case "credit_thejoker7880":
            return "-----[ ^5thejoker7880^7 ]-----";


        case "credit_thejoker7880_1":
            return getlangdata( selflang ,
                "All hidden perks ID" ,
                "全隠しパーク ID" ,
                "所有隐藏福利 ID" ,
                "Идентификатор всех скрытых льгот" ,
                "Alle versteckten Perks-IDs" );

        case "credit_dynamic":
            return "-----[ ^9Dynamic^7 ]-----";


        case "credit_dynamic_1":
            return getmttext( selflang , "rocketride" );

        case "credit_onedeepzay":
            return "-----[ ^1One Deep Zay^7 ]-----";


        case "credit_onedeepzay_1":
            return getlangdata( selflang ,  
                "Forge mode improvement tips" ,  
                "Forge modeの改修ヒント" ,  
                "Forge模式改进提示" ,  
                "Советы по улучшению режима Forge" ,  
                "Tipps zur Verbesserung des Forge-Modus" );

        case "credit_sku":
            return "-----[ ^2Sku-111^7 ]-----";


        case "credit_sku_1":
            return getlangdata( selflang ,  
                "Training on basic operations of IDA Pro" ,  
                "IDAProの基本操作の教育" ,  
                "IDA Pro基本操作培训" ,  
                "Обучение основным операциям в IDA Pro" ,  
                "Schulung zu den Grundfunktionen von IDA Pro" ); 

        case "credit_sku_2":
            return getlangdata( selflang ,  
                "IDA Pro Analysis Support" ,  
                "IDAProの解析サポート" ,  
                "IDA Pro 的分析支持" ,  
                "Поддержка анализа в IDA Pro" ,  
                "IDA Pro Analyseunterstützung" );

        case "credit_sku_3":
            return getlangdata( selflang ,  
                "Support for GSCBIN, GSC asset basic information" ,  
                "GSCBIN、GSCアセット基本情報のサポート" ,  
                "GSCBIN、GSC资源基本信息的支持" ,  
                "Поддержка GSCBIN, основной информации о ресурсах GSC" ,  
                "Unterstützung für GSCBIN, GSC-Asset-Grundinformationen" );

        case "credit_sku_4":
            return getlangdata( selflang ,  
                "Decrypting the GSC hash code of the retail version of MW19" ,  
                "製品版MW19のGSCハッシュコード解読" ,  
                "解密MW19正式版的GSC哈希代码" ,  
                "Расшифровка GSC-хеш-кода релизной версии MW19" ,  
                "Entschlüsselung des GSC-Hashcodes der Verkaufsversion von MW19" );  

        case "credit_brutal":
            return "-----[ ^4Brutal^7 ]-----";


        case "credit_brutal_1":
            return getlangdata( selflang ,  
                "Tips on developing DLL injection" ,  
                "dll Injectの開発に関するヒント" ,  
                "关于开发DLL注入的提示" ,  
                "Советы по разработке DLL-инъекций" ,  
                "Tipps zur Entwicklung von DLL-Injektionen" );  

        case "credit_bossam":
            return "-----[ ^3Bossam (BO2)^7 ]-----";


        case "credit_oldmods":
            return getlangdata( selflang ,  
                "Porting of old CoD Mods" ,  
                "旧CoD Modsの移植" ,  
                "旧CoD Mods的移植" ,  
                "Перенос старых модов CoD" ,  
                "Portierung alter CoD Mods" ); 

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// designmenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //

        case "changeopencloseanimation":
            return getlangdata( selflang ,
                "Change menu opening/closing animation" ,
                "メニューの開閉アニメーションの変更" ,
                "更改菜单打开/关闭动画" ,
                "Изменить анимацию открытия/закрытия меню" ,
                "Animation zum Öffnen/Schließen des Menüs ändern" );


        case "switchbackgroundanimation":
            return getlangdata( selflang ,
                "Color animation" ,
                "色彩アニメーション" ,
                "彩色动画" ,
                "Цветная анимация" ,
                "Farbige Animation" );


        case "changemenustyle":
            return getlangdata( selflang ,
                "Vertical menu" ,
                "縦型メニュー" ,
                "垂直菜单" ,
                "Вертикальное меню" ,
                "Vertikales Menü" );

        case "switchtextnumberline":
            return getlangdata( selflang ,
                "Hiding menu operation instructions" ,
                "メニューの操作説明の非表示化" ,
                "隐藏菜单操作说明" ,
                "Скрытие инструкций по работе с меню" ,
                "Bedienungsanweisungen des Menüs ausblenden" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// combatassistmenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //


        case "demigod":
            return getlangdata( selflang ,
                "Demigod" ,
                "体力増加" ,
                "体力增加" ,
                "Увеличение физической силы" ,
                "Halbgott" );

        case "infinityremainingammo":
            return getlangdata( selflang ,
                "Infinity remaining ammo" ,
                "残弾数無限" ,
                "剩余子弹数量无限" ,
                "Бесконечное количество оставшихся пуль" ,
                "Unendlich viele verbleibende Munition" );

        case "norecoil":
            return getlangdata( selflang ,
                "No recoil" ,
                "無反動" ,
                "无后坐力" ,
                "Без отдачи" ,
                "Kein Rückstoß" );

        case "suicide":
            return getlangdata( selflang ,
                "Suicide" ,
                "自殺" ,
                "自杀" ,
                "Самоубийство" ,
                "Selbstmord" );

        case "movementspeed1_25x":
            return getlangdata( selflang ,
                "Movement speed 1.25x" ,
                "移動速度 1.25倍" ,
                "移动速度 1.25倍" ,
                "Скорость движения 1,25x" ,
                "Bewegungsgeschwindigkeit 1,25x" );

        case "thirdperson":
            return getlangdata( selflang ,
                "3rd person" ,
                "3人称視点" ,
                "第三人称视角" ,
                "перспектива от третьего лица" ,
                "3. Person" );

        case "alwaysnormaluav":
            return getlangdata( selflang ,
                "Always normal UAV" ,
                "常時ノーマルUAV" ,
                "始终正常的无人机" ,
                "Всегда нормальный БПЛА" ,
                "Immer normales UAV" );


        case "freezeplayer":
            return getlangdata( selflang ,
                "Freeze movement" ,
                "移動のフリーズ" ,
                "冻结运动" ,
                "Заморозить движение" ,
                "Bewegung einfrieren" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// perksmenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //


        case "giveperk":
            return getlangdata( selflang ,
                "Give perk" ,
                "パークの取得" ,
                "给予额外津贴" ,
                "Дать перк" ,
                "Vorteil geben" );

        case "clearperk":
            return getlangdata( selflang ,
                "Clear perk" ,
                "パークの消去" ,
                "明确的福利" ,
                "Очистить перк" ,
                "Vorteil löschen" );

        case "setallperks":
            return getlangdata( selflang ,
                "Set all perks" ,
                "全パークの取得" ,
                "设置所有福利" ,
                "Установить все льготы" ,
                "Alle Vorzüge festlegen" );

        case "sethiddenperks":
            return getlangdata( selflang ,
                "Set hidden perks" ,
                "隠しパークの取得" ,
                "设置隐藏福利" ,
                "Установить скрытые льготы" ,
                "Versteckte Vorzüge festlegen" );

        case "clearallperks":
            return getlangdata( selflang ,
                "Clear all perks" ,
                "全パークの消去" ,
                "清除所有福利" ,
                "Отменить все льготы" ,
                "Alle Vorzüge löschen" );

        case "perk":
            return getlangdata( selflang ,
                "Perk" ,
                "パーク" ,
                "福利" ,
                "Перк" ,
                "Vorteil" );

        case "perk1": return getmttext( selflang , "perk" ) + " 1";
        case "perk2": return getmttext( selflang , "perk" ) + " 2";
        case "perk3": return getmttext( selflang , "perk" ) + " 3";

        case "perk_doubletime":
            return getlangdata( selflang ,
                "Double time" ,
                "ダブルタイム" ,
                "双倍时间" ,
                "Двойное время" ,
                "Doppelte Zeit" );


        case "perk_eod":
            return getlangdata( selflang ,
                "E.O.D." ,
                "E.O.D." ,
                "排爆" ,
                "Э.О.Д." ,
                "E.O.D." );


        case "perk_overkill":
            return getlangdata( selflang ,
                "Over kill" ,
                "オーバーキル" ,
                "矫枉过正" ,
                "Излишнее убийство" ,
                "Übermäßiges Töten" );


        case "perk_scavenger":
            return getlangdata( selflang ,
                "Scavenger" ,
                "スカベンジャー" ,
                "清道夫" ,
                "Мусорщик" ,
                "Plünderer" );


        case "perk_coldblood":
            return getlangdata( selflang ,
                "Cold blood" ,
                "コールドブラッド" ,
                "冷血" ,
                "Хладнокровие" ,
                "Kaltblütig" );


        case "perk_quickfix":
            return getlangdata( selflang ,
                "Quick fix" ,
                "クイックフィックス" ,
                "快速解决" ,
                "Быстрая починка" ,
                "Schnelle Lösung" );


        case "perk_restock":
            return getlangdata( selflang ,
                "Restock" ,
                "リストック" ,
                "补货" ,
                "Пополнение запасов" ,
                "Auffüllen" );


        case "perk_hardline":
            return getlangdata( selflang ,
                "Hard line" ,
                "ハードライン" ,
                "硬线" ,
                "Жесткая линия" ,
                "Harte Linie" );


        case "perk_highalert":
            return getlangdata( selflang ,
                "High alert" ,
                "ハイアラート" ,
                "高度戒备" ,
                "Высокий уровень тревоги" ,
                "Höchste Alarmstufe" );


        case "perk_ghost":
            return getlangdata( selflang ,
                "Ghost" ,
                "ゴースト" ,
                "鬼" ,
                "Призрак" ,
                "Geist" );


        case "perk_killchain":
            return getlangdata( selflang ,
                "Kill chain" ,
                "キルチェイン" ,
                "杀伤链" ,
                "цепочка убийств" ,
                "Killkette" );


        case "perk_pointman":
            return getlangdata( selflang ,
                "Point man" ,
                "ポイントマン" ,
                "点人" ,
                "Лидер" ,
                "Spitzenmann" );


        case "perk_tuneup":
            return getlangdata( selflang ,
                "Tune up" ,
                "チューンアップ" ,
                "调高" ,
                "Настроиться" ,
                "Optimieren" );


        case "perk_amp":
            return getlangdata( selflang ,
                "Amp" ,
                "アンプ" ,
                "放大器" ,
                "Усилитель" ,
                "Verstärker" );


        case "perk_shrapnel":
            return getlangdata( selflang ,
                "Shrapnel" ,
                "シュラプネル" ,
                "弹片" ,
                "шрапнель" ,
                "Schrapnell" );


        case "perk_battleharden":
            return getlangdata( selflang ,
                "Battle harden" ,
                "バトルハーデン" ,
                "战斗强化" ,
                "битва ожесточается" ,
                "Kampfhärte" );


        case "perk_spotter":
            return getlangdata( selflang ,
                "Spotter" ,
                "スポッター" ,
                "观察员" ,
                "Корректировщик" ,
                "Spotter" );


        case "perk_tracker":
            return getlangdata( selflang ,
                "Tracker" ,
                "トラッカー" ,
                "追踪器" ,
                "Трекер" ,
                "Tracker" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// visionsmenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //


        case "setvision":
            return getlangdata( selflang ,
                "Set vision" ,
                "画質の設定" ,
                "设定愿景" ,
                "Установить видение" ,
                "Sicht festlegen" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// funnymenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //

        case "outofmappossible":
            return getlangdata( selflang ,
                "Possible out of map" ,
                "マップ外警告の無効化" ,
                "可能超出地图范围" ,
                "Возможно вне карты" ,
                "Außerhalb der Karte möglich" );

        case "changeteam":
            return getlangdata( selflang ,
                "Change team" ,
                "チーム変更" ,
                "改变团队" ,
                "Сменить команду" ,
                "Team ändern" );

        case "cloneplayer":
            return getlangdata( selflang ,
                "Create clone player" ,
                "クローン人間の作成" ,
                "创建克隆玩家" ,
                "Создать клон плеера" ,
                "Klonspieler erstellen" );

        case "explodeddeadclone":
            return getlangdata( selflang ,
                "Exploded dead clone" ,
                "死亡クローンの爆破" ,
                "爆炸死亡克隆人" ,
                "Взорвавшийся мертвый клон" ,
                "Explodierter toter Klon" );

        case "ninjamode":
            return getlangdata( selflang ,
                "Ninja mode" ,
                "忍者モード" ,
                "忍者模式" ,
                "Режим ниндзя" ,
                "Ninja-Modus" );

        case "jetpack":
            return getlangdata( selflang ,
                "Jet pack" ,
                "ジェットパック" ,
                "喷气背包" ,
                "реактивный ранец" ,
                "Jetpack" );

        case "shieldman":
            return getlangdata( selflang ,
                "Shield man" ,
                "シールドマン" ,
                "盾人" ,
                "Человек со щитом" ,
                "Schildmann" );

        case "superslide":
            return getlangdata( selflang ,
                "Super slide" ,
                "超スライディング" ,
                "超滑" ,
                "Супер скольжение" ,
                "Superslide" );

        case "discocamo":
            return getlangdata( selflang ,
                "Disco camouflage" ,
                "ディスコ迷彩" ,
                "迪斯科迷彩" ,
                "Дискотека камуфляж" ,
                "Disco-Tarnung" );

        case "healthbar":
            return getlangdata( selflang ,
                "Health bar" ,
                "体力ゲージ" ,
                "生命条" ,
                "Полоса здоровья" ,
                "Gesundheitsbalken" );

        case "highradiationmode":
            return getlangdata( selflang ,  
                "High Radiation Mode" ,  
                "高放射線モード" ,  
                "高辐射模式" ,  
                "Режим высокой радиации" ,  
                "Hochstrahlungsmodus" );

        case "dogtagshoes":
            return getlangdata( selflang ,  
                "Dog Tag Shoes" ,  
                "ドッグタッグシューズ" ,  
                "军牌鞋" ,  
                "Ботинки с жетоном" ,  
                "Dog-Tag-Schuhe" );

        case "adventureball":
            return getlangdata( selflang ,  
                "Adventure Ball" ,  
                "アドベンチャーボール" ,  
                "冒险球" ,  
                "Приключенческий мяч" ,  
                "Abenteuerball" );

        case "earthquake":
            return getlangdata( selflang ,  
                "Earthquake" ,  
                "地震" ,  
                "地震" ,  
                "Землетрясение" ,  
                "Erdbeben" );


        case "earthquakeoccurrence":
            return getlangdata( selflang ,  
                "Earthquake occurrence!!" ,  
                "地震発生！！" ,  
                "地震发生！！" ,  
                "Землетрясение произошло!!" ,  
                "Erdbeben tritt auf!!" );

        case "saveloadlocation":
            return getlangdata( selflang ,
                "Save & load location" ,
                "座標のセーブ & ロード" ,
                "保存和加载位置" ,
                "Сохранить и загрузить местоположение" ,
                "Standort speichern und laden" );

        case "saveloadlocationdescription1": return getmttext( selflang , "buttontactical" ) + " ^3+ " + getmttext( selflang , "buttonjump" ) + " ^3" + getmttext( selflang , "savelocation" );
        case "saveloadlocationdescription2": return getmttext( selflang , "buttontactical" ) + " ^3+ " + getmttext( selflang , "buttonstance" ) + " ^3" + getmttext( selflang , "loadlocation" );

        case "savelocation":
            return getlangdata( selflang ,
                "Saved location" ,
                "座標の保存" ,
                "已保存位置" ,
                "Сохраненное местоположение" ,
                "Gespeicherter Ort" );


        case "loadlocation":
            return getlangdata( selflang ,
                "Loaded location" ,
                "座標の読み込み" ,
                "装载位置" ,
                "Место загрузки" ,
                "Geladener Ort" );

        case "deadopsarcade":
            return getlangdata( selflang ,
                "Dead Ops Arcade mode" ,
                "デッドオプスアーケード視点" ,
                "死亡行动街机 模式" ,
                "Режим Dead Ops Arcade" ,
                "Dead Ops Arcade-Modus" );


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// modelsmenu , mexicanwave , advancedforgemode
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //

        case "setmodel":
            return getlangdata( selflang ,
                "Set model" ,
                "モデルの設定" ,
                "设定型号" ,
                "Установить модель" ,
                "Modell festlegen" );

        case "synccenterbody":
            return getlangdata( selflang ,
                "Sync position to center" ,
                "中心に位置の同期" ,
                "将位置同步到中心" ,
                "Синхронизировать положение с центром" ,
                "Position mit Mitte synchronisieren" );

        case "changemodel":
        case "mexicanwave_modelid":
        case "changekamikazebombermodel":
            return getlangdata( selflang ,
                "Change model" ,
                "モデル変更" ,
                "改变型号" ,
                "Изменить модель" ,
                "Modell ändern" );

        case "packagemodels":
            return getlangdata( selflang ,
                "Package models" ,
                "パッケージモデル" ,
                "封装型号" ,
                "Модели упаковки" ,
                "Paketmodelle" );

        case "flagmodels":
            return getlangdata( selflang ,
                "Flag models" ,
                "旗モデル" ,
                "标记型号" ,
                "Модели флагов" ,
                "Flaggenmodelle" );

        case "dogtagmodels":
            return getlangdata( selflang ,
                "Dogtag models" ,
                "ドッグタッグモデル" ,
                "狗牌模型" ,
                "Модели жетонов" ,
                "Dogtag-Modelle" );

        case "vehiclesmodels":
            return getlangdata( selflang ,
                "Vehicle models" ,
                "乗り物モデル" ,
                "车型" ,
                "Модели автомобилей" ,
                "Fahrzeugmodelle" );

        case "propmodels":
            return getlangdata( selflang ,
                "Prop models" ,
                "小物モデル" ,
                "道具模型" ,
                "Модели реквизита" ,
                "Requisitenmodelle" );

        case "mapmodels":
            return getlangdata( selflang ,
                "On map models" ,
                "マップ限定モデル" ,
                "在地图模型上" ,
                "На моделях карт" ,
                "Modelle auf der Karte" );

        case "propanimals":
            return getlangdata( selflang ,
                "Animal models" ,
                "動物モデル" ,
                "动物模型" ,
                "Модели животных" ,
                "Tiermodelle" );

        case "propzombies":
            return getlangdata( selflang ,
                "Zombies models" ,
                "ゾンビモデル" ,
                "僵尸模型" ,
                "Модели зомби" ,
                "Zombiemodelle" );

        case "propdebugs":
            return getlangdata( selflang ,
                "Debug models" ,
                "デバッグモデル" ,
                "调试模型" ,
                "Отладка моделей" ,
                "Debug-Modelle" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// skinsmenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //

        case "randomskin":
            return getlangdata( selflang ,  
                "Random skin" ,  
                "ランダムスキン" ,  
                "随机皮肤" ,  
                "Случайный облик" ,  
                "Zufälliger Skin" );  
                
        case "stepupskin":
            return getlangdata( selflang ,  
                "Change skin stage" ,  
                "スキン段階変更" ,  
                "更改皮肤阶段" ,  
                "Изменить этап скина" ,  
                "Skin-Stufe ändern" );  
                
        case "alwaysskinupdater":
            return getlangdata( selflang ,  
                "Disco skin" ,  
                "ディスコスキン" ,  
                "迪斯科皮肤" ,  
                "Диско-облик" ,  
                "Disco-Skin" );

        case "changeskin":
            return getlangdata( selflang ,  
                "Skin change" ,  
                "スキンの変更" ,  
                "更改皮肤" ,  
                "Изменение скина" ,  
                "Änderung des Skins" );  

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// weaponsmenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //

        case "randomcamo":
            return getlangdata( selflang ,
                "Random camouflage" ,
                "ランダム迷彩" ,
                "随机伪装" ,
                "случайный камуфляж" ,
                "Zufällige Tarnung" );

        case "randomattachment":
            return getlangdata( selflang ,
                "Random attachment" ,
                "ランダムアタッチメント" ,
                "随机附件" ,
                "Случайное вложение" ,
                "Zufälliger Aufsatz" );


        case "blueprintweapon":
            return getlangdata( selflang ,
                "Blueprint weapon" ,
                "設計図武器" ,
                "蓝图武器" ,
                "Чертеж оружия" ,
                "Blaupause der Waffe" );

        case "giverandomcurbpweapon":
            return getlangdata( selflang ,
                "Give random blueprint from current weapon" ,
                "今の武器からランダム設計図の生成" ,
                "提供当前武器的随机蓝图" ,
                "Дать случайный чертеж текущего оружия" ,
                "Zufällige Blaupause der aktuellen Waffe geben" );


        case "giverandomt9bpweapon":
            return getlangdata( selflang ,
                "Give random blueprint from CW weapon" ,
                "CWの武器からランダム設計図の生成" ,
                "提供 CW 武器的随机蓝图" ,
                "Дайте случайный чертеж оружия CW" ,
                "Zufällige Blaupause der CW-Waffe geben" );


        case "giverandoms4bpweapon":
            return getlangdata( selflang ,
                "Give random blueprint from VG weapon" ,
                "VGの武器からランダム設計図の生成" ,
                "提供 VG 武器的随机蓝图" ,
                "Дайте случайный чертеж оружия VG" ,
                "Zufällige Blaupause der VG-Waffe geben" );

        case "dualweapon":
            return getlangdata( selflang ,
                "Set akimbo" ,
                "デュアル武器の設定" ,
                "设置双附件" ,
                "Установить двойное вложение" ,
                "In die Seite gesetzt" );

        case "giverandomweapon":
            return getlangdata( selflang ,
                "Give random weapon" ,
                "ランダム武器の取得" ,
                "给予随机武器" ,
                "Дайте случайное оружие" ,
                "Zufällige Waffe geben" );

        case "dropweapon":
            return getlangdata( selflang ,
                "Drop weapons" ,
                "武器のドロップ" ,
                "掉落武器" ,
                "Бросить оружие" ,
                "Waffen fallen lassen" );

        case "takedweapon":
            return getlangdata( selflang ,
                "Taked weapon" ,
                "武器の剥奪" ,
                "拿起武器" ,
                "Взятое оружие" ,
                "Waffe genommen" );

        case "takedallweapons":
            return getlangdata( selflang ,
                "Taked all weapons" ,
                "全武器の剥奪" ,
                "拿走了所有武器" ,
                "Взяли все оружие" ,
                "Alle Waffen genommen" );

        case "assaultrifles":
            return getlangdata( selflang ,
                "Assault Rifles" ,
                "アサルトライフル" ,
                "突击步枪" ,
                "Штурмовые винтовки" ,
                "Sturmgewehre" );

        case "submachineguns":
            return getlangdata( selflang ,
                "Submachine Guns" ,
                "サブマシンガン" ,
                "冲锋枪" ,
                "Пистолеты-пулеметы" ,
                "Maschinenpistolen" );

        case "lightmachineguns":
            return getlangdata( selflang ,
                "Light Machine Guns" ,
                "軽機関銃" ,
                "轻机枪" ,
                "Легкие пулеметы" ,
                "Leichte Maschinengewehre" );

        case "marksmanrifles":
            return getlangdata( selflang ,
                "Marksman Rifles" ,
                "マークスマンライフル" ,
                "神射手步枪" ,
                "Стрелковые винтовки" ,
                "Scharfschützengewehre" );

        case "sniperrifles":
            return getlangdata( selflang ,
                "Sniper Rifles" ,
                "狙撃銃" ,
                "狙击步枪" ,
                "Снайперские винтовки" ,
                "Präzisionsgewehre" );

        case "pistol":
            return getlangdata( selflang ,
                "Pistol" ,
                "拳銃" ,
                "手枪" ,
                "Пистолет" ,
                "Pistole" );

        case "shotguns":
            return getlangdata( selflang ,
                "Shotguns" ,
                "散弾銃" ,
                "霰弹枪" ,
                "Ружья" ,
                "Schrotflinten" );

        case "explosives":
            return getlangdata( selflang ,
                "Explosives" ,
                "爆発物" ,
                "炸药" ,
                "взрывчатые вещества" ,
                "Sprengstoff" );

        case "melee":
            return getlangdata( selflang ,
                "Melee" ,
                "近接" ,
                "近战" ,
                "ближний бой" ,
                "Nahkampf" );

        case "special":
            return getlangdata( selflang ,
                "Special" ,
                "スペシャル" ,
                "特别的" ,
                "Особенный" ,
                "Spezial" );

        case "zombies":
            return getlangdata( selflang ,
                "Zombies" ,
                "ゾンビ" ,
                "僵尸" ,
                "Зомби" ,
                "Zombies" );


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// customweaponsmenu , attractions
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //


        case "teleportgun":
            return getlangdata( selflang ,
                "Teleport gun" ,
                "テレポート銃" ,
                "传送枪" ,
                "Телепортирующая пушка" ,
                "Waffe teleportieren" );

        case "rocketride":
            return getlangdata( selflang ,
                "Rocket ride" ,
                "ミサイル乗り" ,
                "乘坐火箭" ,
                "Поездка на ракете" ,
                "Raketenfahrt" );

        case "walkingac130":
            return getlangdata( selflang ,
                "Walking AC-130" ,
                "歩行式AC-130" ,
                "行走AC-130" ,
                "Прогулочный АС-130" ,
                "Gehender AC-130" );

        case "realcarepackagegun":
            return getlangdata( selflang ,
                "Real carepackage gun" ,
                "本物のケアパッケージ銃" ,
                "真正的护理包枪" ,
                "Настоящий пистолет для ухода" ,
                "Echte Carepack-Waffe" );

        case "thundergun":
            return getlangdata( selflang ,
                "Thunder gun" ,
                "サンダーガン" ,
                "雷霆枪" ,
                "Громовая пушка" ,
                "Donnerkanone" );

        case "frameball":
        case "fireball":
            return getlangdata( selflang ,
                "Fire ball" ,
                "ファイアーボール" ,
                "火球" ,
                "Огненный шар" ,
                "Feuerball" );

        case "railgun":
            return getlangdata( selflang ,
                "Railgun" ,
                "超電磁砲（レベル5）" ,
                "磁轨炮" ,
                "Рейлган" ,
                "Railgun" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// bulletsmenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //


        case "moddedbullets":
            return getlangdata( selflang ,
                "Modded bullets" ,
                "改造弾" ,
                "修改后的子弹" ,
                "Модифицированная пуля" ,
                "Modifizierte Kugeln" );

        case "bullettype":
            return getlangdata( selflang ,
                "Change bullets type" ,
                "改造弾の種類変更" ,
                "修改子弹类型变化" ,
                "Изменено изменение типа пули" ,
                "Kugeltyp ändern" );

        case "moddedbulletsfiretrigger":
            return getlangdata( selflang ,
                "Use bullet fire trigger on WaitTill" ,
                "改造弾の発射トリガーにイベント待機処理の使用" ,
                "在 WaitTill 上使用子弹射击触发器" ,
                "Используйте триггер стрельбы пулей в режиме ожидания" ,
                "Kugelfeuerauslöser bei WaitTill verwenden" );

        case "moddedbulletsnum5":
            return getlangdata( selflang ,
                "Number of bullets fired is 5" ,
                "弾同時発射数が5発" ,
                "发射子弹数量为 5 发" ,
                "Количество выпущенных пуль - 5." ,
                "Anzahl der abgefeuerten Kugeln ist 5" );

        case "moddedgrenades":
            return getlangdata( selflang ,
                "Modded grenades" ,
                "改造手榴弾" ,
                "改装手榴弹" ,
                "Модифицированные гранаты" ,
                "Modifizierte Granaten" );

        case "grenadetype":
            return getlangdata( selflang ,
                "Change grenades type" ,
                "改造手榴弾の種類変更" ,
                "更改手榴弹类型" ,
                "Изменить тип гранаты" ,
                "Granatentyp ändern" );

        case "fullcustombullets":
            return getlangdata( selflang ,
                "Full customize bullets" ,
                "フルカスタマイズ弾" ,
                "完全自定义子弹" ,
                "Полная настройка маркера" ,
                "Kugeln vollständig anpassen" );

        case "earthquakeuponimpactpower":
            return getlangdata( selflang ,
                "Earthquake power upon impact" ,
                "着弾時の地震威力" ,
                "冲击时的地震力" ,
                "Сила землетрясения при ударе" ,
                "Erdbebenstärke beim Aufprall" );

        case "earthquakeuponimpacttime":
            return getlangdata( selflang ,
                "Earthquake time upon impact" ,
                "着弾時の地震時間" ,
                "地震发生时的影响时间" ,
                "Время землетрясения при ударе" ,
                "Erdbebenzeit beim Aufprall" );

        case "earthquakeuponimpactrange":
            return getlangdata( selflang ,
                "Earthquake range upon impact" ,
                "着弾時の地震範囲" ,
                "撞击时的地震范围" ,
                "Диапазон землетрясения при ударе" ,
                "Erdbebenreichweite beim Aufprall" );

        case "radiusdamageuponimpactpower":
            return getlangdata( selflang ,
                "Radius damage power upon impact" ,
                "着弾時の範囲ダメージ威力" ,
                "撞击时的半径伤害力" ,
                "Мощность урона по радиусу при ударе" ,
                "Radiusschadenstärke beim Aufprall" );

        case "radiusdamageuponimpactrange":
            return getlangdata( selflang ,
                "Radius damage range upon impact" ,
                "着弾時の範囲ダメージ距離" ,
                "撞击时的半径伤害范围" ,
                "Радиус урона при ударе" ,
                "Radiusschadenreichweite beim Aufprall" );

        case "changebulletsound":
            return getlangdata( selflang ,
                "Change bullet soundfx" ,
                "弾薬の音声エフェクト変更" ,
                "更改子弹音效" ,
                "Изменить звук пули" ,
                "Kugelsoundeffekte ändern" );

        case "changebulletmodel":
            return getlangdata( selflang ,
                "Change bullet model" ,
                "弾薬のモデル変更" ,
                "更改子弹型号" ,
                "Изменить модель пули" ,
                "Kugelmodell ändern" );

        case "changebulleteffect":
            return getlangdata( selflang ,
                "Change bullet effect" ,
                "弾薬のエフェクト変更" ,
                "更改子弹效果" ,
                "Изменить эффект маркера" ,
                "Kugeleffekt ändern" );


        case "changeeffectuponimpact":
            return getlangdata( selflang ,
                "Change effect upon impact" ,
                "着弾時のエフェクト変更" ,
                "影响时改变效果" ,
                "Эффект изменения при ударе" ,
                "Effekt beim Aufprall ändern" );

        case "changesounduponimpact":
            return getlangdata( selflang ,
                "Change soundfx upon impact" ,
                "着弾時のサウンドエフェクト変更" ,
                "改变撞击时的声音效果" ,
                "Изменение звуковых эффектов при ударе" ,
                "Soundeffekte beim Aufprall ändern" );

        case "objectdeletiondelaytime":
            return getlangdata( selflang ,
                "Object deletion delay time" ,
                "オブジェクト削除の遅延時間" ,
                "对象删除延迟时间" ,
                "Время задержки удаления объекта" ,
                "Verzögerungszeit für Objektlöschung" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// popularmenu , acecombat
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //

        case "infinityammo":
            return getlangdata( selflang ,
                "Infinity ammo" ,
                "弾無限" ,
                "无限子弹" ,
                "Бесконечные пули" ,
                "Unendlich Munition" );


        case "bindnoclip":
            return getlangdata( selflang ,
                "Bind noclip to "        + getmttext( selflang , "buttontactical" ) + " + " + getmttext( selflang , "buttonmelee" ) ,
                "空中飛行 は "           + getmttext( selflang , "buttontactical" ) + " + " + getmttext( selflang , "buttonmelee" ) + " で実行" ,
                "将 noclip 绑定到 "      + getmttext( selflang , "buttontactical" ) + " + " + getmttext( selflang , "buttonmelee" ) ,
                "Привязать noclip к "    + getmttext( selflang , "buttontactical" ) + " + " + getmttext( selflang , "buttonmelee" ) ,
                "Binden Sie noclip an "  + getmttext( selflang , "buttontactical" ) + " + " + getmttext( selflang , "buttonmelee" ) );


        case "bindnoclipdiscription":
            return getlangdata( selflang ,
                "^3Noclip to "  + getmttext( selflang , "buttontactical" ) + " ^3move + "       + getmttext( selflang , "buttonsprint" ) + " ^3| " + getmttext( selflang , "buttontactical" )   + " ^3acceleration" ,
                "^3空中飛行 は " + getmttext( selflang , "buttontactical" ) + " ^3で移動 + "     + getmttext( selflang , "buttonsprint" ) + " ^3| " + getmttext( selflang , "buttontactical" )    + " ^3で加速" ,
                "^3Noclip 到 "  + getmttext( selflang , "buttontactical" ) + " ^3移动 + "       + getmttext( selflang , "buttonsprint" ) + " ^3| " + getmttext( selflang , "buttontactical" )    + " ^3加速" ,
                "^3Noclip для " + getmttext( selflang , "buttontactical" ) + " ^3движения + "   + getmttext( selflang , "buttonsprint" ) + " ^3| " + getmttext( selflang , "buttontactical" )   + " ^3ускорения" ,
                "^3Noclip zu "  + getmttext( selflang , "buttontactical" ) + " ^3bewegen + "    + getmttext( selflang , "buttonsprint" ) + " ^3| " + getmttext( selflang , "buttontactical" )   + " ^3Beschleunigung" );

        case "changemovementspeed":
            return getlangdata( selflang ,
                "Change movement speed" ,
                "移動速度の変更" ,
                "改变移动速度" ,
                "Изменить скорость движения" ,
                "Bewegungsgeschwindigkeit ändern" );

        case "invisible":
            return getlangdata( selflang ,
                "Invisible" ,
                "透明人間" ,
                "透明度" ,
                "Прозрачность" ,
                "Unsichtbar" );

        case "alwaysadvanceduav":
            return getlangdata( selflang ,
                "Always advanced UAV" ,
                "常時アドバンスドUAV" ,
                "始终先进的无人机" ,
                "Всегда продвинутый БПЛА" ,
                "Immer erweitertes UAV" );

        case "esp":
            return getlangdata( selflang ,
                "ESP wall hack" ,
                "ESPウォールハック" ,
                "ESP墙破解" ,
                "Взлом стены ESP" ,
                "ESP-Wand-Hack" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// killstreaksmenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //


        case "givekillstreak":
            return getlangdata( selflang ,
                "Give killstreak" ,
                "キルストリークの取得" ,
                "给予连杀" ,
                "Дайте серию убийств" ,
                "Killstreak geben" );


        case "ks_personalradar":
            return getlangdata( selflang ,
                "Personal radar" ,
                "パーソナルレーダー" ,
                "个人雷达" ,
                "Персональный радар" ,
                "Persönliches Radar" );


        case "ks_shieldturret":
            return getlangdata( selflang ,
                "Shield turret" ,
                "シールドターレット" ,
                "盾牌炮塔" ,
                "Щитовая турель" ,
                "Schildturm" );


        case "ks_counteruav":
            return getlangdata( selflang ,
                "Counter UAV" ,
                "カウンターUAV" ,
                "反无人机" ,
                "Противодействие БПЛА" ,
                "Gegen-UAV" );


        case "ks_uav":
            return getlangdata( selflang ,
                "UAV" ,
                "UAV" ,
                "无人机" ,
                "БПЛА" ,
                "UAV" );


        case "ks_carepackage":
            return getlangdata( selflang ,
                "Care package" ,
                "ケアパッケージ" ,
                "护理套餐" ,
                "Пакет услуг по уходу" ,
                "Pflegepaket" );


        case "ks_clusterstrike":
            return getlangdata( selflang ,
                "Cluster strike" ,
                "クラスターストライク" ,
                "集群打击" ,
                "Кластерный удар" ,
                "Streuangriff" );


        case "ks_cruisemissile":
            return getlangdata( selflang ,
                "Cruise missile" ,
                "巡行ミサイル" ,
                "巡航导弹" ,
                "Крылатая ракета" ,
                "Marschflugkörper" );


        case "ks_airstrike":
            return getlangdata( selflang ,
                "Precision airstrike" ,
                "エアーストライク" ,
                "精确空袭" ,
                "Точный авиаудар" ,
                "Präzisionsluftangriff" );


        case "ks_infantryfightingvehicle":
            return getlangdata( selflang ,
                "Infantry assault vehicle" ,
                "歩兵戦闘車" ,
                "步兵突击车" ,
                "Штурмовая машина пехоты" ,
                "Infanterie-Angriffsfahrzeug" );


        case "ks_sentrygun":
            return getlangdata( selflang ,
                "Sentry turret" ,
                "セントリーガン" ,
                "哨兵炮塔" ,
                "Сторожевая турель" ,
                "Wachturm" );


        case "ks_wheelson":
            return getlangdata( selflang ,
                "Wheelson" ,
                "ウィールソン" ,
                "惠尔森" ,
                "Уилсон" ,
                "Wheelson" );


        case "ks_emergencyreliefsupplies":
            return getlangdata( selflang ,
                "Emergency airdrop" ,
                "緊急救援物資" ,
                "紧急空投" ,
                "Экстренный сброс с воздуха" ,
                "Notfallabwurf" );


        case "ks_vtol":
            return getlangdata( selflang ,
                "VTOL jet" ,
                "V.T.O.L" ,
                "垂直起降喷气机" ,
                "СВВП Джет" ,
                "VTOL-Jet" );


        case "ks_whitephosphorusbullet":
            return getlangdata( selflang ,
                "White phosphorus" ,
                "白リン弾" ,
                "白磷" ,
                "Белый фосфор" ,
                "Weißer Phosphor" );


        case "ks_heligunner":
            return getlangdata( selflang ,
                "Chopper gunner" ,
                "ヘリガンナー" ,
                "直升机炮手" ,
                "Наводчик вертолета" ,
                "Helikopterschütze" );


        case "ks_supportheli":
            return getlangdata( selflang ,
                "Support helo" ,
                "サポートヘリ" ,
                "支持直升机" ,
                "Поддержите привет" ,
                "Unterstützungshelikopter" );


        case "ks_gunship":
            return getlangdata( selflang ,
                "Gunship" ,
                "ガンシップ" ,
                "武装直升机" ,
                "Боевой корабль" ,
                "Kampfhubschrauber" );


        case "ks_advanceduav":
            return getlangdata( selflang ,
                "Advanced UAV" ,
                "アドバンスUAV" ,
                "先进无人机" ,
                "Усовершенствованный БПЛА" ,
                "Fortschrittliches UAV" );


        case "ks_juggernaut":
            return getlangdata( selflang ,
                "Juggernaut" ,
                "ジャガーノート" ,
                "主宰" ,
                "Джаггернаут" ,
                "Juggernaut" );


        case "ks_nuke":
            return getlangdata( selflang ,
                "Tactical nuke" ,
                "戦術核" ,
                "战术核武器" ,
                "Тактическое ядерное оружие" ,
                "Taktische Atombombe" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// customkillstreaksmenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //


        case "kamikazebomber":
            return getlangdata( selflang ,
                "Kamikaze bomber" ,
                "神風ボンバー" ,
                "神风特攻队炸弹" ,
                "бомба-камикадзе" ,
                "Kamikaze-Bomber" );

        case "vanguardairstrike":
            return getlangdata( selflang ,
                "Vanguard carpet bomblet" ,
                "Vanguard式絨毯爆撃" ,
                "先锋队地毯式轰炸" ,
                "Авангардные ковровые бомбардировки" ,
                "Vanguard-Teppichbomblet" );

        case "pokemonball":
            return getlangdata( selflang ,
                "Pokémon Ball" ,
                "ポケモンボール" ,
                "神奇宝贝球" ,
                "Покемон Болл" ,
                "Pokémon Ball" );
                
        case "flyingbomber":
            return getlangdata( selflang ,  
                "Circumferential Aerial Bombardment" ,  
                "円周航空爆撃" ,  
                "环周空中轰炸" ,  
                "Круговая воздушная бомбардировка" ,  
                "Umkreis-Luftbombardement" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// accountmenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //


        case "mustactivatexplobby":
            return getlangdata( selflang ,
                "Please enable XP Lobby beforehand." ,
                "経験値部屋が有効になっていません。" ,
                "请提前启用XP大厅。" ,
                "Пожалуйста, включите XP Lobby заранее." ,
                "Bitte vorher XP-Lobby aktivieren." );

        case "changestatususing":
            return getlangdata( selflang ,
                "Status change in use" ,
                "ステータス変更処理が実行中です" ,
                "使用状态更改" ,
                "Использование изменения статуса" ,
                "Statusänderung in Verwendung" );


        case "currentxp":
            return getlangdata( selflang ,
                "Current XP" ,
                "現在のXP" ,
                "当前经验值" ,
                "Текущий опыт" ,
                "Aktuelle XP" );


        case "uprank":
            return getlangdata( selflang ,
                "1 Level up" ,
                "1レベルアップ" ,
                "1等级提升" ,
                "повысить уровень" ,
                "1 Levelaufstieg" );


        case "maxrank":
            return getlangdata( selflang ,
                "Raise to maximum level" ,
                "最大レベルまで上げる" ,
                "提升至最高等级" ,
                "поднять до максимального уровня" ,
                "Auf maximales Level aufsteigen" );


        case "rankupcomplete":
            return getlangdata( selflang ,
                "Level up complete" ,
                "レベルアップ完了" ,
                "等级提升完成" ,
                "Повышение уровня завершено" ,
                "Levelaufstieg abgeschlossen" );


        case "t9weaponshardunlock":
            return getlangdata( selflang ,
                "CW weapon hard unlock (Steam only)",
                "CW武器ハードアンロック (Steamのみ)",
                "CW武器硬解锁（仅限Steam）",
                "Жёсткая разблокировка оружия CW (только Steam)",
                "CW-Waffen-Hard-Unlock (nur Steam)" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// poweredmenu , acecombat
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //

        case "godmode":
            return getlangdata( selflang ,
                "Godmode" ,
                "無敵" ,
                "无敌的" ,
                "непобедимый" ,
                "Gottmodus" );

        case "nohitmode":
            return getlangdata( selflang ,
                "No hit mode" ,
                "当たり判定無し" ,
                "无命中检测" ,
                "Нет обнаружения попадания" ,
                "Kein Treffermodus" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// aimbotsmenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //


        case "aimbot":
            return getlangdata( selflang ,
                "Aimbot" ,
                "オートエイム" ,
                "瞄准机器人" ,
                "Аимбот" ,
                "Aimbot" );


        case "attacktoforcekill":
            return getlangdata( selflang ,
                "Forced kill when attacking" ,
                "攻撃時に強制キル" ,
                "攻击时强行击杀" ,
                "Принудительное убийство при атаке" ,
                "Erzwungener Kill beim Angriff" );


        case "targettag":
            return getlangdata( selflang ,
                "Target area" ,
                "対象部位" ,
                "目标区域" ,
                "Целевая область" ,
                "Zielbereich" );


        case "aimingrequired":
            return getlangdata( selflang ,
                "Aiming required" ,
                "エイミング必須" ,
                "需要瞄准" ,
                "Требуется прицеливание" ,
                "Zielen erforderlich" );


        case "aimtracking":
            return getlangdata( selflang ,
                "Aim tracking" ,
                "エイム追跡" ,
                "目标追踪" ,
                "Отслеживание цели" ,
                "Zielverfolgung" );


        case "aimstealth":
            return getlangdata( selflang ,
                "Stealth aiming" ,
                "隠密性のエイム" ,
                "隐形瞄准" ,
                "Скрытное прицеливание" ,
                "Geheimes Zielen" );


        case "autokill":
            return getlangdata( selflang ,
                "Auto kill" ,
                "自動キル" ,
                "自动杀死" ,
                "Авто убийство" ,
                "Automatischer Kill" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// acecombat
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //


        case "acecombat":
            return getlangdata( selflang ,
                "ACE COMBAT" ,
                "エースコンバット" ,
                "王牌战斗" ,
                "ТУЗ БОЯ" ,
                "ACE COMBAT" );

        case "acecombatdescription1": return "^3" + getmttext( selflang , "usetoride" );
        case "acecombatdescription2": return getmttext( selflang , "buttonads" )        + " ^3" + getmttext( selflang , "movetoviewpoint" );
        case "acecombatdescription3": return getmttext( selflang , "buttontactical" )   + " ^3" + getmttext( selflang , "acceleration" );
        case "acecombatdescription4": return getmttext( selflang , "buttonmelee" )      + " ^3" + getmttext( selflang , "deceleration" );
        case "acecombatdescription5": return getmttext( selflang , "buttonstance" )     + " ^3" + getmttext( selflang , "changeview" );
        case "acecombatdescription6": return getmttext( selflang , "buttonattack" )     + " ^3" + getmttext( selflang , "missilefire" );
        case "acecombatdescription7": return getmttext( selflang , "buttonuse" )        + " ^3" + getmttext( selflang , "setmissiletype" );

        case "changeaircraft":
            return getlangdata( selflang ,
                "Change aircraft" ,
                "機体の変更" ,
                "更换飞机" ,
                "Сменить самолет" ,
                "Flugzeug wechseln" );


        case "changebasehelicopter":
            return getlangdata( selflang ,
                "Change base helicopter" ,
                "ベースヘリコプターの変更" ,
                "基于变化的直升机" ,
                "Изменить вертолет на базе" ,
                "Basishubschrauber wechseln" );

        case "cannotfirstperson":
            return getlangdata( selflang ,
                "This aircraft does not allow first-person view" ,
                "この機体では1人称視点にできません" ,
                "该飞机不允许第一人称视角" ,
                "Этот самолет не имеет вида от первого лица." ,
                "Dieses Flugzeug erlaubt keine Egoperspektive" );


        case "missilefire":
            return getlangdata( selflang ,
                "Missile launch" ,
                "ミサイル発射" ,
                "导弹发射" ,
                "запуск ракеты" ,
                "Raketenstart" );


        case "realmissilefire":
            return getlangdata( selflang ,
                "Realistic missile launch" ,
                "リアルなミサイルの発射" ,
                "真实的导弹发射" ,
                "реалистичный запуск ракеты" ,
                "Realistischer Raketenstart" );


        case "setmissiletype":
            return getlangdata( selflang ,
                "Set missile type" ,
                "ミサイルの種類の設定" ,
                "设置导弹类型" ,
                "Установить тип ракеты" ,
                "Raketentyp festlegen" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// spawnvehicles
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //

        case "spawnvehicles":
            return getlangdata( selflang ,
                "Spawn vehicle" ,
                "乗り物の生成" ,
                "生成车辆" ,
                "Создать автомобиль" ,
                "Spawn-Fahrzeug" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// advancedforgemode
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //


        case "advancedforgemode":
            return getlangdata( selflang ,
                "Advanced forge mode" ,
                "高度なオブジェクト作成" ,
                "高级锻造模式" ,
                "Расширенный режим кузницы" ,
                "Erweiterter Schmiedemodus" );

        case "forgemodedescription1":   return " " + getmttext( selflang , "buttonads" )      + " + " + getmttext( selflang , "buttonuse" )         + " " + getmttext( selflang , "getobject" );
        case "forgemodedescription2":   return " " + getmttext( selflang , "buttonads" )      + " + " + getmttext( selflang , "buttonlethal" )      + " " + getmttext( selflang , "deleteobject" );
        case "forgemodedescription3":
            if ( usegamepad == true ) { return " " + getmttext( selflang , "buttonuse" )      + " + " + getmttext( selflang , "buttontactical" )    + " " + getmttext( selflang , "createobject" ) + " " + getmttext( selflang , "fromsetting" ); }
            else                      { return " " + getmttext( selflang , "buttonuse" )      + " + " + getmttext( selflang , "buttontactical" )    + " " + getmttext( selflang , "createobject" ) + " " + getmttext( selflang , "fromsetting" ); }

        case "forgemodedescription4":   return " " + getmttext( selflang , "buttonuse" )      + " + " + getmttext( selflang , "buttonmelee" )       + " " + getmttext( selflang , "createobject" ) + " " + getmttext( selflang , "frommemorized" );
        case "forgemodedescription5":   return " " + getmttext( selflang , "buttonuse" )      + " + " + getmttext( selflang , "buttonlethal" )      + " " + getmttext( selflang , "changespawnedmodel" );
        case "forgemodedescription6":   return " " + getmttext( selflang , "buttonuse" )      + " + " + getmttext( selflang , "buttonjump" )        + " " + getmttext( selflang , "rotatexaxis" );
        case "forgemodedescription7":   return " " + getmttext( selflang , "buttonuse" )      + " + " + getmttext( selflang , "buttonattack" )      + " " + getmttext( selflang , "changespawnedtime" );
        case "forgemodedescription8":   return " " + getmttext( selflang , "buttonuse" )      + " + " + getmttext( selflang , "buttonstance" )      + " " + getmttext( selflang , "firedcreate" );
        case "forgemodedescription9":   return " " + getmttext( selflang , "buttonmelee" )    + " + " + getmttext( selflang , "buttonjump" )        + " " + getmttext( selflang , "deletelastobject" );
        case "forgemodedescription10":  return " " + getmttext( selflang , "buttonmelee" )    + " + " + getmttext( selflang , "buttonstance" )      + " " + getmttext( selflang , "autolinkonspawn" );
        case "forgemodedescription11":  return " " + getmttext( selflang , "buttonmelee" )    + " + " + getmttext( selflang , "buttonlethal" )      + " " + getmttext( selflang , "tracelength" );
        case "forgemodedescription12":  return " " + getmttext( selflang , "buttontactical" ) + " + " + getmttext( selflang , "buttonjump" )        + " " + getmttext( selflang , "combineobject" );
        case "forgemodedescription13":  return " " + getmttext( selflang , "buttontactical" ) + " + " + getmttext( selflang , "buttonstance" )      + " " + getmttext( selflang , "spinchange" );
        case "forgemodedescription14":  return " " + getmttext( selflang , "buttontactical" ) + " + " + getmttext( selflang , "buttonlethal" )      + " " + getmttext( selflang , "movechange" );


// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// spawnsmenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //


        case "spawnturret":
            return getlangdata( selflang ,
                "Spawn turret" ,
                "ターレット（砲塔）の生成" ,
                "生成炮塔" ,
                "Спаун турель" ,
                "Spawn-Geschützturm" );



        case "mexicanwave":
            return getlangdata( selflang ,
                "Mexican wave" ,
                "メキシカン・ウェーブ" ,
                "墨西哥浪潮" ,
                "Мексиканская волна" ,
                "Mexikanische Welle" );


        case "spindancer":
            return getlangdata( selflang ,
                "Spinning dancer" ,
                "高速回転ダンサー" ,
                "旋转舞者" ,
                "вращающаяся танцовщица" ,
                "Drehender Tänzer" );


        case "teleportflags":
            return getlangdata( selflang ,
                "Teleporter flags" ,
                "テレポーター旗" ,
                "传送器旗帜" ,
                "Флаги телепорта" ,
                "Teleporter-Flaggen" );

        case "tornado":
            return getlangdata( selflang ,
                "Tornado" ,
                "台風" ,
                "龙卷风" ,
                "Торнадо" ,
                "Tornado" );


        case "stacker":
            return getlangdata( selflang ,
                "3D stacker" ,
                "3Dスタッカー" ,
                "3D堆垛机" ,
                "3D штабелер" ,
                "3D-Stapler" );


        case "skyplazaver2":
            return getlangdata( selflang ,
                "Sky plaza Version 2" ,
                "スカイプラザ バージョン2" ,
                "天空广场第二版" ,
                "Скай Плаза Версия 2" ,
                "Sky Plaza Version 2" );


        case "giantrobot":
            return getlangdata( selflang ,
                "Giant robot" ,
                "巨像鉄身AC-130" ,
                "巨型机器人" ,
                "Гигантский робот" ,
                "Riesenroboter" );


        case "spinrobot":
            return getlangdata( selflang ,
                "Spinning robot" ,
                "回転式ロボット" ,
                "纺纱机器人" ,
                "Вращающийся робот" ,
                "Drehender Roboter" );

        case "spawnzombies_onlyzai":
            return getlangdata( selflang ,  
                "Zombie spawning (ZAI mode only)" ,  
                "ゾンビの生成 (zaiモード限定)" ,  
                "僵尸生成（仅限ZAI模式）" ,  
                "Создание зомби (только для режима ZAI)" ,  
                "Zombie-Erstellung (nur im ZAI-Modus)" );

        case "discodancer":
            return getlangdata( selflang ,  
                "Disco Dancer" ,  
                "ディスコダンサー" ,  
                "迪斯科舞者" ,  
                "Диско-танцор" ,  
                "Disco-Tänzer" );

        case "soccerball":
            return getlangdata( selflang ,
                "Soccer ball (Physics enabled)",
                "サッカーボール (物理有効)",
                "足球（启用物理）",
                "Футбольный мяч (физика включена)",
                "Fußball (Physik aktiviert)" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// attractions
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //

        case "attractions":
            return getlangdata( selflang ,
                "Attractions" ,
                "アトラクション" ,
                "景点" ,
                "аттракцион" ,
                "Attraktionen" );

        case "theclaw":
            return getlangdata( selflang ,
                "The claw" ,
                "ザ・クロー" ,
                "利爪" ,
                "Коготь" ,
                "Die Klaue" );


        case "rollercoaster":
            return getlangdata( selflang ,
                "Roller coaster" ,
                "ローラー・コースター" ,
                "过山车" ,
                "Американские горки" ,
                "Achterbahn" );


        case "ferriswheel":
            return getlangdata( selflang ,
                "Ferris wheel" ,
                "観覧車" ,
                "摩天轮" ,
                "колесо обозрения" ,
                "Riesenrad" );


        case "changespeedferriswheel":
            return getlangdata( selflang ,
                "Change ferris wheel rotate speed" ,
                "観覧車の回転速度の変更" ,
                "更改摩天轮转速" ,
                "Изменить скорость вращения колеса обозрения" ,
                "Riesenradrotation ändern Geschwindigkeit" );


        case "merrygoround":
            return getlangdata( selflang ,
                "Merry-go-round" ,
                "メリーゴーランド" ,
                "旋转木马" ,
                "карусель" ,
                "Karussell" );


        case "changespeedmerrygoround":
            return getlangdata( selflang ,
                "Change merry-go-round rotate speed" ,
                "メリーゴーランドの回転速度の変更" ,
                "更改旋转木马转速" ,
                "Изменение скорости вращения карусели" ,
                "Drehgeschwindigkeit des Karussells ändern" );


        case "centrox":
            return getlangdata( selflang ,
                "Centrox" ,
                "セントロックス" ,
                "森特克斯" ,
                "Центрокс" ,
                "Centrox" );


        case "vertigo":
            return getlangdata( selflang ,
                "Vertigo" ,
                "ヴァーティゴ" ,
                "眩晕" ,
                "головокружение" ,
                "Vertigo" );


        case "twister":
            return getlangdata( selflang ,
                "Twister" ,
                "ツイスター" ,
                "龙卷风" ,
                "Твистер" ,
                "Twister" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// playersmenu , allplayersmenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //

        case "removeauth":
            return getlangdata( selflang ,
                "Remove auth : " ,
                "権限剥奪 : " ,
                "剥夺权力：" ,
                "Лишение полномочий : " ,
                "Authentifizierung entfernen : " );

        case "giveauth":
            return getlangdata( selflang ,
                "Give auth : " ,
                "権限付与 : " ,
                "授权 : " ,
                "Авторизация : " ,
                "Authentifizierung erteilen : " );

        case "setunverified":   return getmttext( selflang , "removeauth" ) + getmttext( selflang , "unverified" );
        case "setverified":     return getmttext( selflang , "giveauth" )   + getmttext( selflang , "verified" );
        case "setvip":          return getmttext( selflang , "giveauth" )   + getmttext( selflang , "vip" );
        case "setadmin":        return getmttext( selflang , "giveauth" )   + getmttext( selflang , "admin" );
        case "setcohost":       return getmttext( selflang , "giveauth" )   + getmttext( selflang , "cohost" );

        case "teleporttome":
            return getlangdata( selflang ,
                "Teleport to me" ,
                "自分の場所にテレポートさせる" ,
                "传送到我身边" ,
                "Телепортируйся ко мне" ,
                "Zu mir teleportieren" );

        case "teleporttohim":
            return getlangdata( selflang ,
                "Teleport to him" ,
                "相手の場所にテレポート" ,
                "传送到他身边" ,
                "Телепортироваться к нему" ,
                "Zu ihm teleportieren" );

        case "kick":
            return getlangdata( selflang ,
                "Kick from the lobby" ,
                "ロビーからキックする" ,
                "从大厅踢出" ,
                "Выйти из вестибюля" ,
                "Kick aus der Lobby" );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// messagesmenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //


        case "doheart":
            return getlangdata( selflang ,
                "Do Heart" ,
                "アニメーションテキスト" ,
                "动画文本" ,
                "Анимационный текст" ,
                "Animationstext" );

        case "sendmessageloop":
            return getlangdata( selflang ,
                "Show loop message to everyone" ,
                "全員にループメッセージ表示" ,
                "向所有人显示循环消息" ,
                "Показать сообщение цикла всем" ,
                "Loop-Nachricht allen anzeigen" );

        case "updatemessagetext":
            return getlangdata( selflang ,
                "Update message text" ,
                "メッセージ文章の更新" ,
                "更新消息文本" ,
                "Обновить текст сообщения" ,
                "Nachrichtentext aktualisieren" );

        case "yourpromotion":
            return getlangdata( selflang ,
                "HiNAtyu promotion" ,
                "HiNAtyu の宣伝" ,
                "HiNAtyu 晋升" ,
                "HiNAtyu Повышение" ,
                "HiNAtyu-Werbung" );

        case "yourpromotion2":
            return getlangdata( selflang ,
                "HiNAtyu promotion type 2" ,
                "HiNAtyu の宣伝 タイプ2" ,
                "HiNAtyu 晋升 2型" ,
                "HiNAtyu Повышение тип 2" ,
                "HiNAtyu-Werbeaktion Typ 2" );

        case "yourpromotionmessage": return getmttext( selflang , "projectname" ) + " ^7: ^2https://www.youtube.com/channel/UCmxJAnVPtkStQVKrvAVMZSw";
        case "yourpromotionmessage2": return "[{shg}] ^3Discord ID ^7: ^2hinatapoko ^7[{shg}] ^1YouTube ^7: ^5HiNAtyu Studio ^7[{shg}]";

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// gamesettingsmenu
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



        case "superjump":
            return getlangdata( selflang ,
                "Super jump" ,
                "スーパージャンプ" ,
                "超级跳跃" ,
                "Супер прыжок" ,
                "Super Sprung" );

        case "speedhack":
            return getlangdata( selflang ,
                "Speed hack" ,
                "スピードハック" ,
                "速度黑客" ,
                "Спид-хак" ,
                "Geschwindigkeits-Hack" );

                

                
        case "autogivecohost":
            return getlangdata( selflang ,  
                "Automatically grant Co-Host" ,  
                "自動的にCo-Hostを与える" ,  
                "自动授予Co-Host" ,  
                "Автоматически назначать со-хоста" ,  
                "Co-Host automatisch zuweisen" );


        case "forcerespawnpoint":
            return getlangdata( selflang ,
                "Force respawn point" ,
                "強制リスポーン地点" ,
                "强制重生点" ,
                "Точка возрождения силы" ,
                "Erzwungener Respawn-Punkt" );


        case "xplobby":
            return getlangdata( selflang ,
                "XP Lobby" ,
                "経験値部屋" ,
                "XP 大厅" ,
                "XP-лобби" ,
                "XP-Lobby" );


        case "fastrestrat":
            return getlangdata( selflang ,
                "Fast restrat" ,
                "瞬時に試合リスタート" ,
                "快速重启" ,
                "Быстрый перезапуск" ,
                "Schnelle Wiederherstellung" );


        case "pausetimer":
            return getlangdata( selflang ,
                "Pause timer" ,
                "タイムリミットの一時停止" ,
                "暂停定时器" ,
                "Таймер паузы" ,
                "Timer pausieren" );

        case "endgame":
            return getlangdata( selflang ,
                "End game" ,
                "ゲームロビーの終了" ,
                "结束游戏" ,
                "Конец игры" ,
                "Spiel beenden" );

        case "ending":
            return getlangdata( selflang ,  
                "Ending" ,  
                "エンディング" ,  
                "结局" ,  
                "Конец" ,  
                "Ende" );

        case "changejumpheight":
            return getlangdata( selflang ,
                "Change jump height" ,
                "ジャンプ力の高さの変更" ,
                "更改跳跃高度" ,
                "Изменить высоту прыжка" ,
                "Sprunghöhe ändern" );

        case "changespeedscale":
            return getlangdata( selflang ,
                "Change movement speed scale" ,
                "移動速度の変更" ,
                "更改移动速度比例" ,
                "Изменить шкалу скорости движения" ,
                "Bewegungsgeschwindigkeitsskala ändern" );
                
        case "nofalldamage":
            return getlangdata( selflang ,
                "Fall damage height" ,
                "落下ダメージの高さ" ,
                "掉落伤害高度" ,
                "Высота урона от падения" ,
                "Fall-Schadenshöhe" );
                
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// michaelmyers
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //


                
        case "quickscopelobby":
            return getlangdata( selflang ,  
                "Quick Scope Lobby" ,  
                "スナイパー限定ロビー" ,  
                "快瞄大厅" ,  
                "Лобби для быстрого прицеливания" ,  
                "Quick-Scope-Lobby" );
                
        case "welcomequickscopelobby":
            return getlangdata( selflang ,
                " ^6Quick Scope Lobby." ,  
                " ^6のスナイパー限定ロビーへ。" ,  
                " ^6快瞄大厅。" ,  
                " ^6Лобби для быстрого прицеливания." ,  
                " ^6Quick-Scope-Lobby." );
                
        case "quickscopelobbydescription1":
            return getlangdata( selflang ,  
                "Only sniper quick shots are allowed in this lobby" ,  
                "このロビーではスナイパーのクイックショットのみが許可されます" ,  
                "此大厅仅允许狙击枪快射" ,  
                "В этом лобби разрешены только быстрые выстрелы из снайперской винтовки" ,  
                "In dieser Lobby sind nur schnelle Schüsse mit dem Scharfschützengewehr erlaubt" ); 
                
        case "quickscopelobbydescription2":
            return getlangdata( selflang ,  
                "Camping is also impossible. Enjoy a pure sniper battle!" ,  
                "芋プレイも不可能です、純粋なスナイパーバトルを楽しもう！" ,  
                "蹲守也不可能。享受纯粹的狙击战！" ,  
                "Кемперство также невозможно. Наслаждайтесь чистой снайперской битвой!" ,  
                "Campen ist ebenfalls unmöglich. Genieße ein reines Scharfschützen-Duell!" );  
                
        case "longscopedetected":
            return getlangdata( selflang ,  
                "^1Long scope detected!" ,  
                "^1ロングスコープを検出しました！" ,  
                "^1检测到长镜瞄！" ,  
                "^1Обнаружен длинный прицел!" ,  
                "^1Langes Zielfernrohr erkannt!" );  
                
        case "camperdetected":
            return getlangdata( selflang ,  
                "^1Camper behavior detected!" ,  
                "^1キャンパー行為を検出しました！" ,  
                "^1检测到蹲守行为！" ,  
                "^1Обнаружено кемперство!" ,  
                "^1Camper-Verhalten erkannt!" ); 
                
        case "violationpunished":
            return getlangdata( selflang ,  
                "Violation punished." ,  
                "違反行為を処罰しました。" ,  
                "违规行为已处罚。" ,  
                "Нарушение наказано." ,  
                "Verstoß geahndet." );

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// michaelmyers
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //


        case "michaelmyers":
            return getlangdata( selflang ,
                "Michael Myers" ,
                "マイケル・マイヤーズ" ,
                "迈克尔·迈尔斯" ,
                "МАЙКЛ МАЙЕРС" ,
                "Michael Myers" );


        case "michaelmyersmsg1":
            return getlangdata( selflang ,
                "^7Welcome to '^4Michael Myers' ^7gamemode." ,
                "^7ゲームモード「^4マイケル・マイヤーズ^7」へようこそ。" ,
                "^7欢迎来到“^4迈克尔·迈尔斯^7”游戏模式。" ,
                "^7Добро пожаловать в игровой режим «^4Майкл Майерс^7»." ,
                "^7Willkommen bei '^4Michael Myers' ^7Spielmodus." );


        case "michaelmyersmsg2":
            return getlangdata( selflang ,
                "Only one enemy will be selected" ,
                "敵が1人だけ選ばれます" ,
                "只会选择一名敌人" ,
                "Будет выбран только один враг" ,
                "Es wird nur ein Feind ausgewählt" );


        case "michaelmyersmsg3":
            return getlangdata( selflang ,
                "Allies cannot carry weapons and must run away from the enemy." ,
                "味方は武器が持てず、敵から逃げないといけません" ,
                "盟友不能携带武器，必须逃离敌人。" ,
                "Союзники не могут носить оружие и должны убегать от противника." ,
                "Verbündete dürfen keine Waffen tragen und müssen vor dem Feind davonlaufen." );


        case "michaelmyersmsg4":
            return getlangdata( selflang ,
                "When there is only one ally left, a weapon will be given to you." ,
                "味方が最後の1人になると、武器が渡されます" ,
                "当只剩下一个盟友时，就会给你一件武器。" ,
                "Когда останется только один союзник, вам дадут оружие." ,
                "Wenn nur noch ein Verbündeter übrig ist, wird Ihnen eine Waffe gegeben." );


        case "michaelmyersmsg5":
            return getlangdata( selflang ,
                "This time the enemy is ^1" + level.lvlStat["MichaelMyers"].enemy.name ,
                "今回の敵は ^1" + level.lvlStat["MichaelMyers"].enemy.name + " です"  ,
                "这次的敌人是 ^1" + level.lvlStat["MichaelMyers"].enemy.name ,
                "На этот раз враг — ^1" + level.lvlStat["MichaelMyers"].enemy.name ,
                "Diesmal ist der Feind ^1" + level.lvlStat["MichaelMyers"].enemy.name );


        case "michaelmyersmsg6":
            return getlangdata( selflang ,
                "This is the start of a survival game for survival." ,
                "生き残りのかけたサバイバルゲームの開始です" ,
                "这是一场生存游戏的开始。" ,
                "Это начало игры на выживание." ,
                "" );


        case "michaelmyersmsg7":
            return getlangdata( selflang ,
                "You can hide for 10 seconds from now." ,
                "今から10秒間だけ隠れられます" ,
                "从现在开始你可以隐藏 10 秒。" ,
                "Теперь вы можете спрятаться на 10 секунд." ,
                "Du kannst dich ab jetzt 10 Sekunden lang verstecken." );


        case "michaelmyersmsg8":
            return getlangdata( selflang ,
                "You are the last survivor, please resist." ,
                "最後の生き残りです、抗ってください" ,
                "你是最后的幸存者，请抵抗。" ,
                "Вы последний выживший, пожалуйста, сопротивляйтесь." ,
                "Du bist der letzte Überlebende, bitte leiste Widerstand." );


        case "michaelmyersmsgwinenemy":
            return getlangdata( selflang ,
                "^2" + level.lvlStat["MichaelMyers"].enemy.name + " ^7won" ,
                "^2" + level.lvlStat["MichaelMyers"].enemy.name + " ^7は勝利しました" ,
                "^2" + level.lvlStat["MichaelMyers"].enemy.name + " ^7韩元" ,
                "^2" + level.lvlStat["MichaelMyers"].enemy.name + " ^7выиграл" ,
                "^2" + level.lvlStat["MichaelMyers"].enemy.name + " ^7won" );


        case "michaelmyersmsgloseenemy":
            return getlangdata( selflang ,
                "^1" + level.lvlStat["MichaelMyers"].enemy.name + " ^7lost" ,
                "^1" + level.lvlStat["MichaelMyers"].enemy.name + " ^7は負けました" ,
                "^1" + level.lvlStat["MichaelMyers"].enemy.name + " ^7输了" ,
                "^1" + level.lvlStat["MichaelMyers"].enemy.name + " ^7проиграл" ,
                "^1" + level.lvlStat["MichaelMyers"].enemy.name + " ^7verloren" );


        case "michaelmyersmsgwinally":
            return getlangdata( selflang ,
                "^2you guys managed to survive" ,
                "^2あなたたちは生き残ることに成功しました" ,
                "^2你们设法生存下来" ,
                "^2вам, ребята, удалось выжить" ,
                "^2ihr habt es geschafft zu überleben" );


        case "michaelmyersmsgloseally":
            return getlangdata( selflang ,
                "^1you were wiped out" ,
                "^1あなたたちは全滅しました" ,
                "^1你被消灭了" ,
                "^1тебя стерли с лица земли" ,
                "^1du wurdest ausgelöscht" );

        default:
            if ( !isdefined( textid ) ) textid = "";
            return textid;
    }
    
    if ( !isdefined( textid ) ) textid = "";
    return textid;
}




































































































































// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// en : The original GSC function (emptied to avoid DEV ERROR when called from an external class)
// ja : 元GSCの関数（外部クラスからのコール時のDEV ERROR回避用に空にする）
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ //



init(){}
_id_825A(){}
_id_33B3(){}
_id_33C4(){}
_id_107DB(){}
_id_107DC(){}
_id_385C(){}
_id_AB50( var_0 ){}
_id_AB34( var_0 ){}
_id_B80E( var_0 ){}
_id_E2F5( var_0 ){}
_id_69D7(){}
_id_F431(){}
_id_2ECA(){}
_id_5ABD(){}
_id_5AE8(){}
_id_AB5D( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 ){}
_id_2BC7( var_0 ){}
_id_B755(){}
_id_B79D( var_0 ){}
_id_FD06(){}
_id_58A8( var_0, var_1 ){}
_id_D882(){}
_id_6A09(){}
_id_99D9(){}
_id_D883(){}
_id_6994(){}
_id_DCA3( var_0 ){}
_id_78DE( var_0 ){}
_id_4E64(){}
_id_D703( var_0 ){}
_id_8A79( var_0 ){}
_id_2B84(){}
_id_7424(){}
_id_D8B0(){}
_id_398F( var_0 ){}
_id_D8AE(){}
_id_D70C( var_0, var_1 ){}
_id_6DB8( var_0 ){}
_id_3FD1( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9 ){}
_id_6DB7( var_0 ){}
_id_6DA8( var_0 ){}
_id_68DA( var_0 ){}
_id_E035( var_0, var_1 ){}
_id_733F( var_0, var_1 ){}
_id_7356( var_0, var_1 ){}
_id_B95C(){}
_id_1EFA( var_0 ){}
_id_AD5F(){}
_id_B164(){}
_id_6C6B( var_0 ){}
_id_DCE3( var_0 ){}
_id_DCE5( var_0, var_1 ){}
_id_DCE4( var_0, var_1 ){}
_id_F629( var_0 ){}
_id_FD57( var_0 ){}
_id_4CD5( var_0, var_1 ){}
_id_6FEE( var_0 ){}
_id_B68A( var_0, var_1 ){}
_id_AB6A(){}
_id_5032( var_0, var_1 ){}
_id_696B(){}
_id_6E7B(){}
_id_B7DF( var_0 ){}
_id_EF64( var_0 ){}
_id_EF98( var_0 ){}
_id_7B46(){}
_id_5010( var_0 ){}
_id_3E65(){}
_id_2EC4( var_0, var_1, var_2 ){}
_id_2EC3( var_0 ){}
_id_77C8( var_0, var_1 ){}
_id_774D(){}
_id_77CD(){}
_id_7750( var_0 ){}
_id_777C( var_0 ){}
_id_7751( var_0 ){}
_id_7785(){}
_id_E2F7( var_0, var_1, var_2, var_3 ){}
_id_E35E( var_0 ){}
_id_7780(){}
_id_774F(){}
_id_7798( var_0 ){}
_id_777D(){}
_id_777A( var_0 ){}
_id_7419(){}
_id_2F1A( var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12 ){}
_id_77A7(){}
_id_777F( var_0, var_1 ){}
_id_54CE(){}
_id_7781(){}
_id_7782(){}
_id_F3C6( var_0 ){}
_id_F3C8( var_0, var_1, var_2 ){}
_id_77CF(){}
_id_8174(){}
_id_3FA9( var_0 ){}
_id_A0F9(){}
_id_E2E1( var_0 ){}
_id_57D8( var_0 ){}
_id_DCA4(){}
_id_57D6(){}
_id_57D7(){}
_id_1EF7( var_0 ){}
_id_9F85( var_0 ){}
_id_7467( var_0 ){}
_id_FD58( var_0, var_1, var_2 ){}
_id_FCB3(){}
_id_FC2B( var_0, var_1, var_2 ){}
_id_FCB2( var_0, var_1, var_2, var_3 ){}
_id_6B04( var_0, var_1, var_2 ){}
_id_10E7( var_0 ){}
_id_C4F6( var_0 ){}
_id_10B38( var_0 ){}
_id_10E6( var_0, var_1 ){}
_id_FC5C( var_0 ){}
_id_C4F5( var_0 ){}
_id_32DE(){}
_id_32DF(){}
_id_32DD(){}
_id_ADB9( var_0 ){}
_id_ADB6(){}
_id_B700(){}
_id_FCB1( var_0 ){}
_id_1179( var_0 ){}
_id_4B5A( var_0, var_1 ){}
_id_0BDE( var_0, var_1, var_2 ){}
_id_B9AD( var_0, var_1, var_2 ){}
_id_0BE2( var_0, var_1 ){}
_id_5ADA( var_0 ){}
_id_E70A(){}
_id_CA60(){}
_id_CA2B(){}
_id_3FCA(){}
_id_F233(){}
_id_4018( var_0, var_1, var_2 ){}
_id_A238( var_0 ){}
_id_DCD9( var_0 ){}
_id_DCD8( var_0 ){}
_id_78F9( var_0 ){}
_id_4768(){}
_id_E67E( var_0 ){}
_id_D53A(){}
_id_DCA2( var_0 ){}
_id_E739( var_0 ){}
_id_C4DF(){}
_id_E6A5(){}
_id_B7BB( var_0, var_1 ){}
_id_581E(){}
_id_77A9(){}
_id_7797( var_0 ){}
_id_760A(){}
_id_F3C7( var_0 ){}
_id_5AC4( var_0, var_1 ){}
_id_A704( var_0 ){}
_id_F62B( var_0, var_1, var_2 ){}
_id_6AA0(){}
_id_ABAD(){}
_id_2594(){}
_id_7404(){}
_id_B7BA(){}
_id_551A(){}
_id_8170(){}
_id_F60C(){}
_id_52C6(){}
_id_68EC( var_0 ){}
_id_B874( var_0, var_1 ){}
_id_BCFD(){}
_id_8166(){}
_id_10BC8( var_0 ){}
