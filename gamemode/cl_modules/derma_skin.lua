--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

local surface = surface
local draw = draw
local math = math
local Color = Color

SKIN 						 	 = {}
SKIN.CustomColor1 				 = Color(40, 40, 40, 255)

SKIN.PrintName 					 =  "Perp Skin"
SKIN.Author 		 			 =  "G-Force"
SKIN.DermaVersion	 			 =  1
SKIN.GwenTexture				 = Material( "gwenskin/GModDefault.png" )

SKIN.bg_color 					 =  Color(22, 22, 22, 200)--Color(100, 100, 100, 186)
SKIN.bg_color_sleep 			 =  Color(70, 70, 70, 200)--Color(80, 80, 80, 186)
SKIN.bg_color_dark				 =  Color(40, 40, 40, 200)--Color(60, 60, 60, 186)
SKIN.bg_color_bright			 =  Color(80, 80, 80, 200)--Color(120, 120, 120, 186)

SKIN.fontFrame					 =  "Verdana"

SKIN.control_color 				 =  Color(60, 60, 60, 200)
SKIN.control_color_highlight	 =  Color(80, 80, 80, 200)
SKIN.control_color_active 		 =  Color(70, 70, 70, 200)
SKIN.control_color_bright 		 =  Color(100, 100, 100, 180)
SKIN.control_color_dark 		 =  Color(25, 25, 25, 180)

SKIN.bg_alt1 					 =  Color(255, 50, 50, 200)
SKIN.bg_alt2 					 =  Color(255, 55, 55, 200)

SKIN.listview_hover				 =  Color(40, 40, 40, 200)
SKIN.listview_selected			 =  Color(70, 70, 100, 200)

SKIN.text_bright				 =  Color(103, 212, 250, 200) --Color(255, 255, 255, 200)
SKIN.text_normal				 =  Color(220, 220, 220, 200) --Color(200, 200, 200, 200)
SKIN.text_dark					 =  Color(200, 200, 200, 200) --Color(80, 80, 80, 200)
SKIN.text_highlight				 =  Color(255, 255, 255, 200) --Color(255, 20, 20, 200)

SKIN.texGradientUp				 =  Material("gui/gradient_up")
SKIN.texGradientDown			 =  Material("gui/gradient_down")

SKIN.combobox_selected			 =  SKIN.listview_selected

SKIN.panel_transback			 =  Color( 255, 255, 255, 50 )
SKIN.tooltip					 =  Color( 255, 252, 0, 255 )

SKIN.colPropertySheet 			 =  Color(50, 50, 50, 255)--Color(230, 230, 230, 200)
SKIN.colTab			 			 =  Color(103, 212, 250, 255) --Color(255, 255, 255, 255)
SKIN.colTabInactive				 =  Color(34, 34, 34, 200)
SKIN.colTabShadow				 =  Color(20, 20, 20, 255)
SKIN.colTabText		 			 =  Color(255, 255, 255, 225)
SKIN.colTabTextInactive			 =  Color(150, 150, 150, 155)
SKIN.fontTab					 =  "Verdana"

SKIN.colCollapsibleCategory		 =  Color(100, 100, 100, 100)

SKIN.colCategoryText			 =  Color(200, 200, 186, 225)
SKIN.colCategoryTextInactive	 =  Color(100, 100, 120, 155)
SKIN.fontCategoryHeader			 =  "Verdana"

SKIN.colNumberWangBG			 =  Color(255, 186, 150, 200)
SKIN.colTextEntryBG				 =  Color(255, 255, 255, 200)
SKIN.colTextEntryBorder			 =  Color(127, 157, 185, 200)
SKIN.colTextEntryText			 =  Color(0, 0, 0, 200)
SKIN.colTextEntryTextHighlight	 =  Color(100, 100, 100, 200)

SKIN.colMenuBG					 =  Color(201, 182, 112, 200)
SKIN.colMenuBorder				 =  Color(55, 55, 55, 255)

SKIN.colButtonText				 =  Color(255, 255, 255, 255)
SKIN.colButtonTextDisabled		 =  Color(170, 170, 170, 200)
SKIN.colButtonBorder			 =  Color(40, 40, 40, 255)
SKIN.colButtonBorderHighlight	 =  Color(60, 60, 60, 255)
SKIN.colButtonBorderShadow		 =  Color(0, 0, 0, 0)
SKIN.fontButton					 =  "Verdana"

SKIN.tex = {}

SKIN.tex.Selection		 			= GWEN.CreateTextureBorder( 384, 32, 31, 31, 4, 4, 4, 4 );

SKIN.tex.Panels = {}
SKIN.tex.Panels.Normal				= GWEN.CreateTextureBorder( 256,		0,	63,	63,	16,	16,		16,	16 )
SKIN.tex.Panels.Bright				= GWEN.CreateTextureBorder( 256+64,	0,	63,	63,	16,	16,		16,	16 )
SKIN.tex.Panels.Dark				= GWEN.CreateTextureBorder( 256,		64,	63,	63,	16,	16,		16,	16 )
SKIN.tex.Panels.Highlight			= GWEN.CreateTextureBorder( 256+64,	64,	63,	63,	16,	16,		16,	16 )

SKIN.tex.Button						= GWEN.CreateTextureBorder( 480, 0,	31,		31,		8,	8,		8,	8 )
SKIN.tex.Button_Hovered				= GWEN.CreateTextureBorder( 480, 32,	31,		31,		8,	8,		8,	8 )
SKIN.tex.Button_Dead				= GWEN.CreateTextureBorder( 480, 64,	31,		31,		8,	8,		8,	8 )
SKIN.tex.Button_Down				= GWEN.CreateTextureBorder( 480, 96,	31,		31,		8,	8,		8,	8 )
SKIN.tex.Shadow						= GWEN.CreateTextureBorder( 448, 0,	31,		31,		8,	8,		8,	8 )

SKIN.tex.Tree						= GWEN.CreateTextureBorder( 256, 128, 127,	127,	16,	16,		16,	16 )
SKIN.tex.Checkbox_Checked			= GWEN.CreateTextureNormal( 448, 32, 15, 15 )
SKIN.tex.Checkbox					= GWEN.CreateTextureNormal( 464, 32, 15, 15 )
SKIN.tex.CheckboxD_Checked			= GWEN.CreateTextureNormal( 448, 48, 15, 15 )
SKIN.tex.CheckboxD					= GWEN.CreateTextureNormal( 464, 48, 15, 15 )
--SKIN.tex.RadioButton_Checked		= GWEN.CreateTextureNormal( 448, 64, 15, 15 )
--SKIN.tex.RadioButton				= GWEN.CreateTextureNormal( 464, 64, 15, 15 )
--SKIN.tex.RadioButtonD_Checked		= GWEN.CreateTextureNormal( 448, 80, 15, 15 )
--SKIN.tex.RadioButtonD				= GWEN.CreateTextureNormal( 464, 80, 15, 15 )
SKIN.tex.TreePlus					= GWEN.CreateTextureNormal( 448, 96, 15, 15 )
SKIN.tex.TreeMinus					= GWEN.CreateTextureNormal( 464, 96, 15, 15 )
--SKIN.tex.Menu_Strip				= GWEN.CreateTextureBorder( 0, 128, 127, 21, 1, 1, 1, 1 )
SKIN.tex.TextBox					= GWEN.CreateTextureBorder( 0, 150, 127, 21,		4,	4,		4,	4 )
SKIN.tex.TextBox_Focus				= GWEN.CreateTextureBorder( 0, 172, 127, 21,		4,	4,		4,	4 )
SKIN.tex.TextBox_Disabled			= GWEN.CreateTextureBorder( 0, 193, 127, 21,		4,	4,		4,	4 )
SKIN.tex.MenuBG_Column				= GWEN.CreateTextureBorder( 128, 128, 127, 63,		24, 8, 8, 8 )
SKIN.tex.MenuBG						= GWEN.CreateTextureBorder( 128, 192, 127, 63,		8, 8, 8, 8 )
SKIN.tex.MenuBG_Hover				= GWEN.CreateTextureBorder( 128, 256, 127, 31,		8, 8, 8, 8 )
SKIN.tex.MenuBG_Spacer				= GWEN.CreateTextureNormal( 128, 288, 127, 3 )
SKIN.tex.Menu_Strip					= GWEN.CreateTextureBorder( 0, 128, 127, 21,		8, 8, 8, 8)
SKIN.tex.Menu_Check					= GWEN.CreateTextureNormal( 448, 112, 15, 15 )
SKIN.tex.Tab_Control				= GWEN.CreateTextureBorder( 0, 256, 127, 127, 8, 8, 8, 8 )
SKIN.tex.TabB_Active				= GWEN.CreateTextureBorder( 0,		416, 63, 31, 8, 8, 8, 8 )
SKIN.tex.TabB_Inactive				= GWEN.CreateTextureBorder( 0+128,	416, 63, 31, 8, 8, 8, 8 )
SKIN.tex.TabT_Active				= GWEN.CreateTextureBorder( 0,		384, 63, 31, 8, 8, 8, 8 )
SKIN.tex.TabT_Inactive				= GWEN.CreateTextureBorder( 0+128,	384, 63, 31, 8, 8, 8, 8 )
SKIN.tex.TabL_Active				= GWEN.CreateTextureBorder( 64,		384, 31, 63, 8, 8, 8, 8 )
SKIN.tex.TabL_Inactive				= GWEN.CreateTextureBorder( 64+128,	384, 31, 63, 8, 8, 8, 8 )
SKIN.tex.TabR_Active				= GWEN.CreateTextureBorder( 96,		384, 31, 63, 8, 8, 8, 8 )
SKIN.tex.TabR_Inactive				= GWEN.CreateTextureBorder( 96+128,	384, 31, 63, 8, 8, 8, 8 )
SKIN.tex.Tab_Bar					= GWEN.CreateTextureBorder( 128, 352, 127, 31, 4, 4, 4, 4 )

SKIN.tex.Window = {}

SKIN.tex.Window.Normal				= GWEN.CreateTextureBorder( 0,	0,	127,	127,	8,	32,		8,	8 )
SKIN.tex.Window.Inactive			= GWEN.CreateTextureBorder( 128,	0,	127,	127,	8,	32,		8,	8 )

SKIN.tex.Window.Close				= GWEN.CreateTextureNormal( 32, 448, 31, 31 );
SKIN.tex.Window.Close_Hover			= GWEN.CreateTextureNormal( 64, 448, 31, 31 );
SKIN.tex.Window.Close_Down			= GWEN.CreateTextureNormal( 96, 448, 31, 31 );

SKIN.tex.Window.Maxi				= GWEN.CreateTextureNormal( 32 + 96*2, 448, 31, 31 );
SKIN.tex.Window.Maxi_Hover			= GWEN.CreateTextureNormal( 64 + 96*2, 448, 31, 31 );
SKIN.tex.Window.Maxi_Down			= GWEN.CreateTextureNormal( 96 + 96*2, 448, 31, 31 );

SKIN.tex.Window.Restore				= GWEN.CreateTextureNormal( 32 + 96*2, 448+32, 31, 31 );
SKIN.tex.Window.Restore_Hover		= GWEN.CreateTextureNormal( 64 + 96*2, 448+32, 31, 31 );
SKIN.tex.Window.Restore_Down		= GWEN.CreateTextureNormal( 96 + 96*2, 448+32, 31, 31 );

SKIN.tex.Window.Mini				= GWEN.CreateTextureNormal( 32 + 96, 448, 31, 31 );
SKIN.tex.Window.Mini_Hover			= GWEN.CreateTextureNormal( 64 + 96, 448, 31, 31 );
SKIN.tex.Window.Mini_Down			= GWEN.CreateTextureNormal( 96 + 96, 448, 31, 31 );

SKIN.tex.Scroller = {}
SKIN.tex.Scroller.TrackV				= GWEN.CreateTextureBorder( 384,				208, 15, 127, 4, 4, 4, 4 );
SKIN.tex.Scroller.ButtonV_Normal		= GWEN.CreateTextureBorder( 384 + 16,		208, 15, 127, 4, 4, 4, 4 );
SKIN.tex.Scroller.ButtonV_Hover			= GWEN.CreateTextureBorder( 384 + 32,		208, 15, 127, 4, 4, 4, 4 );
SKIN.tex.Scroller.ButtonV_Down			= GWEN.CreateTextureBorder( 384 + 48,		208, 15, 127, 4, 4, 4, 4 );
SKIN.tex.Scroller.ButtonV_Disabled		= GWEN.CreateTextureBorder( 384 + 64,		208, 15, 127, 4, 4, 4, 4 );

SKIN.tex.Scroller.TrackH				= GWEN.CreateTextureBorder( 384,	128,		127, 15, 4, 4, 4, 4 );
SKIN.tex.Scroller.ButtonH_Normal		= GWEN.CreateTextureBorder( 384,	128 + 16,	127, 15, 4, 4, 4, 4 );
SKIN.tex.Scroller.ButtonH_Hover			= GWEN.CreateTextureBorder( 384,	128 + 32,	127, 15, 4, 4, 4, 4 );
SKIN.tex.Scroller.ButtonH_Down			= GWEN.CreateTextureBorder( 384,	128 + 48,	127, 15, 4, 4, 4, 4 );
SKIN.tex.Scroller.ButtonH_Disabled		= GWEN.CreateTextureBorder( 384,	128 + 64,	127, 15, 4, 4, 4, 4 );

SKIN.tex.Scroller.LeftButton_Normal		= GWEN.CreateTextureBorder( 464,			208,	15, 15, 2, 2, 2, 2 );
SKIN.tex.Scroller.LeftButton_Hover		= GWEN.CreateTextureBorder( 480,			208,	15, 15, 2, 2, 2, 2 );
SKIN.tex.Scroller.LeftButton_Down		= GWEN.CreateTextureBorder( 464,			272,	15, 15, 2, 2, 2, 2 );
SKIN.tex.Scroller.LeftButton_Disabled	= GWEN.CreateTextureBorder( 480 + 48,	272,	15, 15, 2, 2, 2, 2 );

SKIN.tex.Scroller.UpButton_Normal		= GWEN.CreateTextureBorder( 464,			208 + 16,	15, 15, 2, 2, 2, 2 );
SKIN.tex.Scroller.UpButton_Hover		= GWEN.CreateTextureBorder( 480,			208 + 16,	15, 15, 2, 2, 2, 2 );
SKIN.tex.Scroller.UpButton_Down			= GWEN.CreateTextureBorder( 464,			272 + 16,	15, 15, 2, 2, 2, 2 );
SKIN.tex.Scroller.UpButton_Disabled		= GWEN.CreateTextureBorder( 480 + 48,	272 + 16,	15, 15, 2, 2, 2, 2 );

SKIN.tex.Scroller.RightButton_Normal	= GWEN.CreateTextureBorder( 464,			208 + 32,	15, 15, 2, 2, 2, 2 );
SKIN.tex.Scroller.RightButton_Hover		= GWEN.CreateTextureBorder( 480,			208 + 32,	15, 15, 2, 2, 2, 2 );
SKIN.tex.Scroller.RightButton_Down		= GWEN.CreateTextureBorder( 464,			272 + 32,	15, 15, 2, 2, 2, 2 );
SKIN.tex.Scroller.RightButton_Disabled	= GWEN.CreateTextureBorder( 480 + 48,	272 + 32,	15, 15, 2, 2, 2, 2 );

SKIN.tex.Scroller.DownButton_Normal		= GWEN.CreateTextureBorder( 464,			208 + 48,	15, 15, 2, 2, 2, 2 );
SKIN.tex.Scroller.DownButton_Hover		= GWEN.CreateTextureBorder( 480,			208 + 48,	15, 15, 2, 2, 2, 2 );
SKIN.tex.Scroller.DownButton_Down		= GWEN.CreateTextureBorder( 464,			272 + 48,	15, 15, 2, 2, 2, 2 );
SKIN.tex.Scroller.DownButton_Disabled	= GWEN.CreateTextureBorder( 480 + 48,	272 + 48,	15, 15, 2, 2, 2, 2 );

SKIN.tex.Menu = {}
SKIN.tex.Menu.RightArrow				= GWEN.CreateTextureNormal( 464, 112, 15, 15 );

SKIN.tex.Input = {}

SKIN.tex.Input.ComboBox = {}
SKIN.tex.Input.ComboBox.Normal			= GWEN.CreateTextureBorder( 384,	336,	127, 31, 8, 8, 32, 8 );
SKIN.tex.Input.ComboBox.Hover			= GWEN.CreateTextureBorder( 384,	336+32, 127, 31, 8, 8, 32, 8 );
SKIN.tex.Input.ComboBox.Down			= GWEN.CreateTextureBorder( 384,	336+64, 127, 31, 8, 8, 32, 8 );
SKIN.tex.Input.ComboBox.Disabled		= GWEN.CreateTextureBorder( 384,	336+96, 127, 31, 8, 8, 32, 8 );

SKIN.tex.Input.ComboBox.Button = {}
SKIN.tex.Input.ComboBox.Button.Normal		 = GWEN.CreateTextureNormal( 496,	272,	15, 15 );
SKIN.tex.Input.ComboBox.Button.Hover		 = GWEN.CreateTextureNormal( 496,	272+16, 15, 15 );
SKIN.tex.Input.ComboBox.Button.Down			 = GWEN.CreateTextureNormal( 496,	272+32, 15, 15 );
SKIN.tex.Input.ComboBox.Button.Disabled		 = GWEN.CreateTextureNormal( 496,	272+48, 15, 15 );

SKIN.tex.Input.UpDown = {}
SKIN.tex.Input.UpDown.Up = {}
SKIN.tex.Input.UpDown.Up.Normal				= GWEN.CreateTextureCentered( 384,		112,	7, 7 );
SKIN.tex.Input.UpDown.Up.Hover				= GWEN.CreateTextureCentered( 384+8,	112,	7, 7 );
SKIN.tex.Input.UpDown.Up.Down				= GWEN.CreateTextureCentered( 384+16,	112,	7, 7 );
SKIN.tex.Input.UpDown.Up.Disabled			= GWEN.CreateTextureCentered( 384+24,	112,	7, 7 );

SKIN.tex.Input.UpDown.Down = {}
SKIN.tex.Input.UpDown.Down.Normal			= GWEN.CreateTextureCentered( 384,		120,	7, 7 );
SKIN.tex.Input.UpDown.Down.Hover			= GWEN.CreateTextureCentered( 384+8,	120,	7, 7 );
SKIN.tex.Input.UpDown.Down.Down				= GWEN.CreateTextureCentered( 384+16,	120,	7, 7 );
SKIN.tex.Input.UpDown.Down.Disabled			= GWEN.CreateTextureCentered( 384+24,	120,	7, 7 );

SKIN.tex.Input.Slider = {}
SKIN.tex.Input.Slider.H = {}
SKIN.tex.Input.Slider.H.Normal			= GWEN.CreateTextureNormal( 416,	32,	15, 15 );
SKIN.tex.Input.Slider.H.Hover			= GWEN.CreateTextureNormal( 416,	32+16, 15, 15 );
SKIN.tex.Input.Slider.H.Down			= GWEN.CreateTextureNormal( 416,	32+32, 15, 15 );
SKIN.tex.Input.Slider.H.Disabled		= GWEN.CreateTextureNormal( 416,	32+48, 15, 15 );

SKIN.tex.Input.Slider.V = {}
SKIN.tex.Input.Slider.V.Normal			= GWEN.CreateTextureNormal( 416+16,	32,	15, 15 );
SKIN.tex.Input.Slider.V.Hover			= GWEN.CreateTextureNormal( 416+16,	32+16, 15, 15 );
SKIN.tex.Input.Slider.V.Down			= GWEN.CreateTextureNormal( 416+16,	32+32, 15, 15 );
SKIN.tex.Input.Slider.V.Disabled		= GWEN.CreateTextureNormal( 416+16,	32+48, 15, 15 );

SKIN.tex.Input.ListBox = {}
SKIN.tex.Input.ListBox.Background		= GWEN.CreateTextureBorder( 256,	256, 63, 127, 8, 8, 8, 8 );
SKIN.tex.Input.ListBox.Hovered			= GWEN.CreateTextureBorder( 320,	320, 31, 31, 8, 8, 8, 8 );
SKIN.tex.Input.ListBox.EvenLine			= GWEN.CreateTextureBorder( 352,  256, 31, 31, 8, 8, 8, 8 );
SKIN.tex.Input.ListBox.OddLine			= GWEN.CreateTextureBorder( 352,  288, 31, 31, 8, 8, 8, 8 );
SKIN.tex.Input.ListBox.EvenLineSelected			= GWEN.CreateTextureBorder( 320,	270, 31, 31, 8, 8, 8, 8 );
SKIN.tex.Input.ListBox.OddLineSelected			= GWEN.CreateTextureBorder( 320,	288, 31, 31, 8, 8, 8, 8 );

SKIN.tex.ProgressBar = {}
SKIN.tex.ProgressBar.Back		= GWEN.CreateTextureBorder( 384,	0, 31, 31, 8, 8, 8, 8 );
SKIN.tex.ProgressBar.Front		= GWEN.CreateTextureBorder( 384+32,	0, 31, 31, 8, 8, 8, 8 );


SKIN.tex.CategoryList = {}
SKIN.tex.CategoryList.Outer		= GWEN.CreateTextureBorder( 256,		384, 63, 63, 8, 8, 8, 8 );
SKIN.tex.CategoryList.Inner		= GWEN.CreateTextureBorder( 256 + 64,	384, 63, 63, 8, 21, 8, 8 );
SKIN.tex.CategoryList.Header	= GWEN.CreateTextureBorder( 320,			352, 63, 31, 8, 8, 8, 8 );

SKIN.tex.Tooltip		= GWEN.CreateTextureBorder( 384,	64, 31, 31, 8, 8, 8, 8 );

SKIN.Colours = {}

SKIN.Colours.Window = {}
SKIN.Colours.Window.TitleActive			= GWEN.TextureColor( 4 + 8 * 0, 508 );
SKIN.Colours.Window.TitleInactive		= GWEN.TextureColor( 4 + 8 * 1, 508 );

SKIN.Colours.Button = {}
SKIN.Colours.Button.Normal				= GWEN.TextureColor( 4 + 8 * 2, 508 );
SKIN.Colours.Button.Hover				= GWEN.TextureColor( 4 + 8 * 3, 508 );
SKIN.Colours.Button.Down				= GWEN.TextureColor( 4 + 8 * 2, 500 );
SKIN.Colours.Button.Disabled			= GWEN.TextureColor( 4 + 8 * 3, 500 );

SKIN.Colours.Tab = {}
SKIN.Colours.Tab.Active = {}
SKIN.Colours.Tab.Active.Normal			= GWEN.TextureColor( 4 + 8 * 4, 508 );
SKIN.Colours.Tab.Active.Hover			= GWEN.TextureColor( 4 + 8 * 5, 508 );
SKIN.Colours.Tab.Active.Down			= GWEN.TextureColor( 4 + 8 * 4, 500 );
SKIN.Colours.Tab.Active.Disabled		= GWEN.TextureColor( 4 + 8 * 5, 500 );

SKIN.Colours.Tab.Inactive = {}
SKIN.Colours.Tab.Inactive.Normal		= GWEN.TextureColor( 4 + 8 * 6, 508 );
SKIN.Colours.Tab.Inactive.Hover			= GWEN.TextureColor( 4 + 8 * 7, 508 );
SKIN.Colours.Tab.Inactive.Down			= GWEN.TextureColor( 4 + 8 * 6, 500 );
SKIN.Colours.Tab.Inactive.Disabled		= GWEN.TextureColor( 4 + 8 * 7, 500 );

SKIN.Colours.Label = {}
SKIN.Colours.Label.Default				= GWEN.TextureColor( 4 + 8 * 8, 508 );
SKIN.Colours.Label.Bright				= GWEN.TextureColor( 4 + 8 * 9, 508 );
SKIN.Colours.Label.Dark					= GWEN.TextureColor( 4 + 8 * 8, 500 );
SKIN.Colours.Label.Highlight			= GWEN.TextureColor( 4 + 8 * 9, 500 );

SKIN.Colours.Tree = {}
SKIN.Colours.Tree.Lines					= GWEN.TextureColor( 4 + 8 * 10, 508 );		---- !!!
SKIN.Colours.Tree.Normal				= GWEN.TextureColor( 4 + 8 * 11, 508 );
SKIN.Colours.Tree.Hover					= GWEN.TextureColor( 4 + 8 * 10, 500 );
SKIN.Colours.Tree.Selected				= GWEN.TextureColor( 4 + 8 * 11, 500 );

SKIN.Colours.Properties = {}
SKIN.Colours.Properties.Line_Normal			= GWEN.TextureColor( 4 + 8 * 12, 508 );
SKIN.Colours.Properties.Line_Selected		= GWEN.TextureColor( 4 + 8 * 13, 508 );
SKIN.Colours.Properties.Line_Hover			= GWEN.TextureColor( 4 + 8 * 12, 500 );
SKIN.Colours.Properties.Title				= GWEN.TextureColor( 4 + 8 * 13, 500 );
SKIN.Colours.Properties.Column_Normal		= GWEN.TextureColor( 4 + 8 * 14, 508 );
SKIN.Colours.Properties.Column_Selected		= GWEN.TextureColor( 4 + 8 * 15, 508 );
SKIN.Colours.Properties.Column_Hover		= GWEN.TextureColor( 4 + 8 * 14, 500 );
SKIN.Colours.Properties.Border				= GWEN.TextureColor( 4 + 8 * 15, 500 );
SKIN.Colours.Properties.Label_Normal		= GWEN.TextureColor( 4 + 8 * 16, 508 );
SKIN.Colours.Properties.Label_Selected		= GWEN.TextureColor( 4 + 8 * 17, 508 );
SKIN.Colours.Properties.Label_Hover			= GWEN.TextureColor( 4 + 8 * 16, 500 );

SKIN.Colours.Category = {}
SKIN.Colours.Category.Header				= GWEN.TextureColor( 4 + 8 * 18, 500 );
SKIN.Colours.Category.Header_Closed			= GWEN.TextureColor( 4 + 8 * 19, 500 );
SKIN.Colours.Category.Line = {}
SKIN.Colours.Category.Line.Text				= GWEN.TextureColor( 4 + 8 * 20, 508 );
SKIN.Colours.Category.Line.Text_Hover		= GWEN.TextureColor( 4 + 8 * 21, 508 );
SKIN.Colours.Category.Line.Text_Selected	= GWEN.TextureColor( 4 + 8 * 20, 500 );
SKIN.Colours.Category.Line.Button			= GWEN.TextureColor( 4 + 8 * 21, 500 );
SKIN.Colours.Category.Line.Button_Hover		= GWEN.TextureColor( 4 + 8 * 22, 508 );
SKIN.Colours.Category.Line.Button_Selected	= GWEN.TextureColor( 4 + 8 * 23, 508 );
SKIN.Colours.Category.LineAlt = {}
SKIN.Colours.Category.LineAlt.Text				= GWEN.TextureColor( 4 + 8 * 22, 500 );
SKIN.Colours.Category.LineAlt.Text_Hover		= GWEN.TextureColor( 4 + 8 * 23, 500 );
SKIN.Colours.Category.LineAlt.Text_Selected		= GWEN.TextureColor( 4 + 8 * 24, 508 );
SKIN.Colours.Category.LineAlt.Button			= GWEN.TextureColor( 4 + 8 * 25, 508 );
SKIN.Colours.Category.LineAlt.Button_Hover		= GWEN.TextureColor( 4 + 8 * 24, 500 );
SKIN.Colours.Category.LineAlt.Button_Selected	= GWEN.TextureColor( 4 + 8 * 25, 500 );

SKIN.Colours.TooltipText	= GWEN.TextureColor( 4 + 8 * 26, 500 );

local iNewHUD = surface.GetTextureID("pulsareffect/inventory/inv_background")
local iTexGradient = surface.GetTextureID("gui/gradient_up")
--

/*---------------------------------------------------------
   DrawGenericBackground
--------------------------------------------------------- */
function SKIN:DrawGenericBackground(x, y, w, h, color)

	draw.RoundedBox(4, x, y, w, h, color)

end

/*---------------------------------------------------------
   DrawButtonBorder
--------------------------------------------------------- */
function SKIN:DrawButtonBorder(x, y, w, h, depressed)

	if(!depressed) then

		--Highlight
		surface.SetDrawColor(self.colButtonBorderHighlight)
		surface.DrawRect(x + 1, y + 1, w - 2, 1)
		surface.DrawRect(x + 1, y + 1, 1, h - 2)

		--Corner
		surface.DrawRect(x + 2, y + 2, 1, 1)

		--Shadow
		surface.SetDrawColor(self.colButtonBorderShadow)
		surface.DrawRect(w - 2, y + 2, 1, h - 2)
		surface.DrawRect(x + 2, h - 2, w - 2, 1)

	else

		local col = self.colButtonBorderShadow

		for i = 1, 5 do

			surface.SetDrawColor(col.r, col.g, col.b, (255 - i * (255/5)))
			surface.DrawOutlinedRect(i, i, w - i, h - i)

		end

	end

	surface.SetDrawColor(self.colButtonBorder)
	surface.DrawOutlinedRect(x, y, w, h)

end

/*---------------------------------------------------------
   DrawDisabledButtonBorder
--------------------------------------------------------- */
function SKIN:DrawDisabledButtonBorder(x, y, w, h, depressed)

	surface.SetDrawColor(0, 0, 0, 150)
	surface.DrawOutlinedRect(x, y, w, h)

end


/*---------------------------------------------------------
	Frame
--------------------------------------------------------- */
function SKIN:PaintFrame( panel, w , h )
	draw.RoundedBox(8, 0, 0, w, panel:GetTall(), Color(3, 3, 3, 180))
	surface.SetTexture(iNewHUD)
	surface.SetDrawColor(Color(200, 200, 200, 255))
	surface.DrawTexturedRectUV(2, 2, w - 4, panel:GetTall() - 4, 128, 128, 128, 128)

	surface.SetTexture(iTexGradient)
	surface.SetDrawColor(0, 0, 0, 220)
	surface.DrawTexturedRect(0, -panel:GetTall() * 0.3, w, panel:GetTall() * 1.3, 90)
end

function SKIN:LayoutFrame(panel)

	panel.lblTitle:SetFont(self.fontFrame)

	panel.btnClose:SetPos(panel:GetWide() - 22, 4)
	panel.btnClose:SetSize(18, 18)

	panel.lblTitle:SetPos(8, 2)
	panel.lblTitle:SetSize(panel:GetWide() - 25, 20)

end


/*---------------------------------------------------------
	Button
--------------------------------------------------------- */
local textcolor1 = Color( 150, 150, 150, 200 )
local texthightlight = Color( 0, 191, 255, 200 )
local textcolor = Color( 255, 255, 255, 200 )
function SKIN:PaintButton(panel)

	local w, h = panel:GetSize()

	if(panel.m_bBackground) then

		local col = self.control_color

		if(panel:GetDisabled()) then
			col = self.control_color_dark
			panel:SetTextColor( textcolor1 )
		elseif(panel.Depressed || panel:IsSelected() || panel:GetToggle()) then
			col = self.control_color_active
		elseif(panel.Hovered) then
			col = self.control_color_highlight
			panel:SetTextColor( texthightlight )
		else
			panel:SetTextColor( textcolor )
		end

		surface.SetDrawColor( col )
		panel:DrawFilledRect()

	end

end
function SKIN:PaintOverButton(panel)

	local w, h = panel:GetSize()

	if(panel.m_bBorder) then
		if(panel:GetDisabled()) then
			self:DrawDisabledButtonBorder(0, 0, w, h)
		else
			self:DrawButtonBorder(0, 0, w, h, panel.Depressed or panel:GetSelected())
		end
	end

end


function SKIN:SchemeButton(panel)

	panel:SetFont(self.fontButton)

	if(panel:GetDisabled()) then
		panel:SetTextColor(self.colButtonTextDisabled)
	else
		panel:SetTextColor(self.colButtonText)
	end

	DLabel.ApplySchemeSettings(panel)

end

/*---------------------------------------------------------
	SysButton
--------------------------------------------------------- */
function SKIN:PaintPanel(panel)

	if(panel.m_bPaintBackground) then

		local w, h = panel:GetSize()
		self:DrawGenericBackground(0, 0, w, h, self.panel_transback)

	end

end

/*---------------------------------------------------------
	SysButton
--------------------------------------------------------- */
function SKIN:PaintSysButton(panel)

	self:PaintButton(panel)
	self:PaintOverButton(panel) --Border

end

function SKIN:SchemeSysButton(panel)

	panel:SetFont("Verdana")
	DLabel.ApplySchemeSettings(panel)

end


/*---------------------------------------------------------
	ImageButton
--------------------------------------------------------- */
function SKIN:PaintImageButton(panel)

	self:PaintButton(panel)

end

/*---------------------------------------------------------
	ImageButton
--------------------------------------------------------- */
function SKIN:PaintOverImageButton(panel)

	self:PaintOverButton(panel)

end
function SKIN:LayoutImageButton(panel)

	if(panel.m_bBorder) then
		panel.m_Image:SetPos(1, 1)
		panel.m_Image:SetSize(panel:GetWide() - 2, panel:GetTall() - 2)
	else
		panel.m_Image:SetPos(0, 0)
		panel.m_Image:SetSize(panel:GetWide(), panel:GetTall())
	end

end

/*---------------------------------------------------------
	PanelList
--------------------------------------------------------- */
function SKIN:PaintPanelList(panel)
	if(panel.m_bBackground) then
		draw.RoundedBox(4, 0, 0, panel:GetWide(), panel:GetTall(), self.CustomColor1)
	end

end

/*---------------------------------------------------------
	ScrollBar
--------------------------------------------------------- */
function SKIN:PaintVScrollBar(panel)
	local color = self.bg_color
	surface.SetDrawColor(Color(100, 100, 100, 255))
	surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())

end
function SKIN:LayoutVScrollBar(panel)

	local Wide = panel:GetWide()
	local Scroll = panel:GetScroll() / panel.CanvasSize
	local BarSize = panel:BarScale() * (panel:GetTall() - (Wide * 2))
	local Track = panel:GetTall() - (Wide * 2) - BarSize
	Track = Track + 1

	Scroll = Scroll * Track

	panel.btnGrip:SetPos(0, Wide + Scroll)
	panel.btnGrip:SetSize(Wide, BarSize)

	panel.btnUp:SetPos(0, 0, Wide, Wide)
	panel.btnUp:SetSize(Wide, Wide)

	panel.btnDown:SetPos(0, panel:GetTall() - Wide, Wide, Wide)
	panel.btnDown:SetSize(Wide, Wide)

end

/*---------------------------------------------------------
	ScrollBarGrip
--------------------------------------------------------- */
function SKIN:PaintScrollBarGrip(panel)

	surface.SetDrawColor(self.control_color.r, self.control_color.g, self.control_color.b, self.control_color.a)
	surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())

	self:DrawButtonBorder(0, 0, panel:GetWide(), panel:GetTall())

end


/*---------------------------------------------------------
	ScrollBar
--------------------------------------------------------- */
function SKIN:PaintMenu(panel)

	surface.SetDrawColor(self.colMenuBG)
	panel:DrawFilledRect(0, 0, w, h)

end
function SKIN:PaintOverMenu(panel)

	surface.SetDrawColor(self.colMenuBorder)
	panel:DrawOutlinedRect(0, 0, w, h)

end
function SKIN:LayoutMenu(panel)

end

/*---------------------------------------------------------
	ScrollBar
--------------------------------------------------------- */
function SKIN:PaintMenuOption(panel)

	if(panel.m_bBackground and panel.Hovered) then

		local col = nil

		if(panel.Depressed) then
			col = self.control_color_bright
		else
			col = self.control_color_active
		end

		surface.SetDrawColor(col.r, col.g, col.b, col.a)
		surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())

	end

end
function SKIN:LayoutMenuOption(panel)

	--This is totally messy. :/

	panel:SizeToContents()

	panel:SetWide(panel:GetWide() + 30)

	local w = math.max(panel:GetParent():GetWide(), panel:GetWide())

	panel:SetSize(w, 18)

	if(panel.SubMenuArrow) then

		panel.SubMenuArrow:SetSize(panel:GetTall(), panel:GetTall())
		panel.SubMenuArrow:CenterVertical()
		panel.SubMenuArrow:AlignRight()

	end

end
function SKIN:SchemeMenuOption(panel)

	panel:SetFGColor(40, 40, 40, 255)

end

/*---------------------------------------------------------
	TextEntry
--------------------------------------------------------- */
function SKIN:PaintTextEntry(panel)

	if(panel.m_bBackground) then

		surface.SetDrawColor(self.colTextEntryBG)
		surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())

	end

	panel:DrawTextEntryText(panel.m_colText, panel.m_colHighlight, panel.m_colCursor)

	if(panel.m_bBorder) then

		surface.SetDrawColor(self.colTextEntryBorder)
		surface.DrawOutlinedRect(0, 0, panel:GetWide(), panel:GetTall())

	end


end
function SKIN:SchemeTextEntry(panel)

	panel:SetTextColor(self.colTextEntryText)
	panel:SetHighlightColor(self.colTextEntryTextHighlight)
	panel:SetCursorColor(Color(0, 0, 100, 255))

end

/*---------------------------------------------------------
	Label
--------------------------------------------------------- */
function SKIN:PaintLabel(panel)
	return false
end

function SKIN:SchemeLabel(panel)

	local col = nil

	if(panel.Hovered and panel:GetTextColorHovered()) then
		col = panel:GetTextColorHovered()
	else
		col = panel:GetTextColor()
	end

	if(col) then
		panel:SetFGColor(col.r, col.g, col.b, col.a)
	else
		panel:SetFGColor(200, 200, 200, 255)
	end

end

function SKIN:LayoutLabel(panel)

	panel:ApplySchemeSettings()

	if(panel.m_bAutoStretchVertical) then
		panel:SizeToContentsY()
	end

end

/*---------------------------------------------------------
	CategoryHeader
--------------------------------------------------------- */
function SKIN:PaintCategoryHeader(panel)

end

function SKIN:SchemeCategoryHeader(panel)

	panel:SetTextInset(5)
	panel:SetFont(self.fontCategoryHeader)

	if(panel:GetParent():GetExpanded()) then
		panel:SetTextColor(self.colCategoryText)
	else
		panel:SetTextColor(self.colCategoryTextInactive)
	end

end

/*---------------------------------------------------------
	CategoryHeader
--------------------------------------------------------- */
function SKIN:PaintCollapsibleCategory(panel)

	draw.RoundedBox(4, 0, 0, panel:GetWide(), panel:GetTall(), self.colCollapsibleCategory)

end

/*---------------------------------------------------------
	Tab
--------------------------------------------------------- */
function SKIN:PaintTab(panel)

	--This adds a little shadow to the right which helps define the tab shape ..
	draw.RoundedBox(4, 0, 0, panel:GetWide(), panel:GetTall() + 8, self.colTabShadow)

	if(panel:GetPropertySheet():GetActiveTab() == panel) then
		draw.RoundedBox(4, 1, 0, panel:GetWide() - 2, panel:GetTall() + 8, self.colTab)
	else
		draw.RoundedBox(4, 0, 0, panel:GetWide() - 1, panel:GetTall() + 8, self.colTabInactive)
	end

end
function SKIN:SchemeTab(panel)

	panel:SetFont(self.fontTab)

	local ExtraInset = 10

	if(panel.Image) then
		ExtraInset = ExtraInset + panel.Image:GetWide()
	end

	panel:SetTextInset(ExtraInset)
	panel:SizeToContents()
	panel:SetSize(panel:GetWide() + 10, panel:GetTall() + 8)

	local Active = panel:GetPropertySheet():GetActiveTab() == panel

	if(Active) then
		panel:SetTextColor(self.colTabText)
	else
		panel:SetTextColor(self.colTabTextInactive)
	end

	panel.BaseClass.ApplySchemeSettings(panel)

end

function SKIN:LayoutTab(panel)

	panel:SetTall(22)

	if(panel.Image) then

		local Active = panel:GetPropertySheet():GetActiveTab() == panel

		local Diff = panel:GetTall() - panel.Image:GetTall()
		panel.Image:SetPos(7, Diff * 0.6)

		if(!Active) then
			panel.Image:SetImageColor(Color(170, 170, 170, 155))
		else
			panel.Image:SetImageColor(Color(255, 255, 255, 255))
		end

	end

end



/*---------------------------------------------------------
	PropertySheet
--------------------------------------------------------- */
function SKIN:PaintPropertySheet(panel)

	local ActiveTab = panel:GetActiveTab()
	local Offset = 0
	if(ActiveTab) then Offset = ActiveTab:GetTall() end

	--This adds a little shadow to the right which helps define the tab shape ..
	draw.RoundedBox(4, 0, Offset, panel:GetWide(), panel:GetTall() - Offset, self.colPropertySheet)

end


/*---------------------------------------------------------
	ListViewLine
--------------------------------------------------------- */
function SKIN:PaintListViewLine(panel)

	local Col = nil

	if(panel:IsSelected()) then

		Col = self.listview_selected

	elseif(panel.Hovered) then

		Col = self.listview_hover

	elseif(panel.m_bAlt) then

		Col = self.bg_alt2

	else

		return

	end

	surface.SetDrawColor(Col.r, Col.g, Col.b, Col.a)
	surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall())

end

/*---------------------------------------------------------
	Form
--------------------------------------------------------- */
function SKIN:PaintForm(panel)

	local color = self.bg_color_sleep
	self:DrawGenericBackground(0, 9, panel:GetWide(), panel:GetTall() - 9, SKIN.CustomColor1)

end
function SKIN:SchemeForm(panel)

	panel.Label:SetFont("TabLarge")
	panel.Label:SetTextColor(Color(255, 255, 255, 255))

end
function SKIN:LayoutForm(panel)

end


/*---------------------------------------------------------
	MultiChoice
--------------------------------------------------------- */
function SKIN:LayoutMultiChoice(panel)

	panel.TextEntry:SetSize(panel:GetWide(), panel:GetTall())

	panel.DropButton:SetSize(panel:GetTall(), panel:GetTall())
	panel.DropButton:SetPos(panel:GetWide() - panel:GetTall(), 0)

	panel.DropButton:SetZPos(1)
	panel.DropButton:SetDrawBackground(false)
	panel.DropButton:SetDrawBorder(false)

	panel.DropButton:SetTextColor(Color(30, 100, 200, 255))
	panel.DropButton:SetTextColorHovered(Color(50, 150, 255, 255))

end


/*
NumberWangIndicator
*/

function SKIN:DrawNumberWangIndicatorText(panel, wang, x, y, number, alpha)

	local alpha = math.Clamp(alpha ^ 0.5, 0, 1) * 255
	local col = self.text_dark

	--Highlight round numbers
	local dec = (wang:GetDecimals() + 1) * 10
	if(number / dec == math.ceil(number / dec)) then
		col = self.text_highlight
	end

	draw.SimpleText(number, "Default", x, y, Color(col.r, col.g, col.b, alpha))

end



function SKIN:PaintNumberWangIndicator(panel)

	/*

		Please excuse the crudeness of this code.

	*/

	if(panel.m_bTop) then
		surface.SetMaterial(self.texGradientUp)
	else
		surface.SetMaterial(self.texGradientDown)
	end

	surface.SetDrawColor(self.colNumberWangBG)
	surface.DrawTexturedRect(0, 0, panel:GetWide(), panel:GetTall())

	local wang = panel:GetWang()
	local CurNum = math.floor(wang:GetFloatValue())
	local Diff = CurNum - wang:GetFloatValue()

	local InsetX = 3
	local InsetY = 5
	local Increment = wang:GetTall()
	local Offset = Diff * Increment
	local EndPoint = panel:GetTall()
	local Num = CurNum
	local NumInc = 1

	if(panel.m_bTop) then

		local Min = wang:GetMin()
		local Start = panel:GetTall() + Offset
		local End = Increment * - 1

		CurNum = CurNum + NumInc
		for y = Start, Increment * - 1, End do

			CurNum = CurNum - NumInc
			if(CurNum < Min) then break end

			self:DrawNumberWangIndicatorText(panel, wang, InsetX, y + InsetY, CurNum, y / panel:GetTall())

		end

	else

		local Max = wang:GetMax()

		for y = Offset - Increment, panel:GetTall(), Increment do

			self:DrawNumberWangIndicatorText(panel, wang, InsetX, y + InsetY, CurNum, 1 - ((y + Increment) / panel:GetTall()))

			CurNum = CurNum + NumInc
			if(CurNum > Max) then break end

		end

	end


end

function SKIN:LayoutNumberWangIndicator(panel)

	panel.Height = 200

	local wang = panel:GetWang()
	local x, y = wang:LocalToScreen(0, wang:GetTall())

	if(panel.m_bTop) then
		y = y - panel.Height - wang:GetTall()
	end

	panel:SetPos(x, y)
	panel:SetSize(wang:GetWide() - wang.Wanger:GetWide(), panel.Height)

end


/*---------------------------------------------------------
	Slider
--------------------------------------------------------- */
function SKIN:PaintSlider(panel)

end


/*---------------------------------------------------------
	NumSlider
--------------------------------------------------------- */
function SKIN:PaintNumSlider(panel)

	local w, h = panel:GetSize()

	self:DrawGenericBackground(0, 0, w, h, Color(255, 255, 255, 20))

	surface.SetDrawColor(0, 0, 0, 200)
	surface.DrawRect(3, h/2, w - 6, 1)

end


/*---------------------------------------------------------
	NumSlider
--------------------------------------------------------- */
function SKIN:PaintComboBoxItem(panel)

	if(panel:GetSelected()) then
		local col = self.combobox_selected
		surface.SetDrawColor(col.r, col.g, col.b, col.a)
		panel:DrawFilledRect()
	end

end

function SKIN:SchemeComboBoxItem(panel)
	panel:SetTextColor(Color(0, 0, 0, 255))
end

/*---------------------------------------------------------
	ComboBox
--------------------------------------------------------- */
function SKIN:PaintComboBox(panel)

	surface.SetDrawColor(255, 255, 255, 255)
	panel:DrawFilledRect()

	surface.SetDrawColor(0, 0, 0, 255)
	panel:DrawOutlinedRect()

end

/*---------------------------------------------------------
	ScrollBar
--------------------------------------------------------- */
function SKIN:PaintBevel(panel)

	local w, h = panel:GetSize()

	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawOutlinedRect(0, 0, w - 1, h - 1)

	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawOutlinedRect(1, 1, w - 1, h - 1)

end


/*---------------------------------------------------------
	Tree
--------------------------------------------------------- */
function SKIN:PaintTree(panel)
	local color = self.bg_color_bright
	if(panel.m_bBackground) then
		surface.SetDrawColor(SKIN.CustomColor1)
		panel:DrawFilledRect()
	end

end



/*---------------------------------------------------------
	TinyButton
--------------------------------------------------------- */
function SKIN:PaintTinyButton(panel)

	if(panel.m_bBackground) then

		surface.SetDrawColor(255, 255, 255, 255)
		panel:DrawFilledRect()

	end

	if(panel.m_bBorder) then

		surface.SetDrawColor(0, 0, 0, 255)
		panel:DrawOutlinedRect()

	end

end

function SKIN:SchemeTinyButton(panel)

	panel:SetFont("Default")

	if(panel:GetDisabled()) then
		panel:SetTextColor(Color(0, 0, 0, 50))
	else
		panel:SetTextColor(Color(0, 0, 0, 255))
	end

	DLabel.ApplySchemeSettings(panel)

	panel:SetFont("DefaultSmall")

end

/*---------------------------------------------------------
	TinyButton
--------------------------------------------------------- */
function SKIN:PaintTreeNodeButton(panel)

	if(panel.m_bSelected) then

		surface.SetDrawColor(50, 200, 255, 150)
		panel:DrawFilledRect()

	elseif(panel.Hovered) then

		surface.SetDrawColor(255, 255, 255, 100)
		panel:DrawFilledRect()

	end



end

function SKIN:SchemeTreeNodeButton(panel)

	DLabel.ApplySchemeSettings(panel)

end

/*---------------------------------------------------------
	Tooltip
--------------------------------------------------------- */
function SKIN:PaintTooltip(panel, w, h)

	self.tex.Tooltip( 0, 0, w, h )

end
derma.DefineSkin( "perp2", "PERP", SKIN )

SKIN.fontLabel = "Verdana"
SKIN.fontLargeLabel = "DefaultLarge"

function cutLength( str, pW, font )
	surface.SetFont(font)

	local sW = pW - 40

	for i = 1, string.len(str) do
		local sStr = string.sub(str, 1, i)
		local w, h = surface.GetTextSize(sStr)

		if(w > pW or (w > sW and string.sub(str, i, i) == " ")) then
			local cutRet = cutLength(string.sub(str, i + 1), pW, font)

			local returnTable = {sStr}

			for k, v in pairs(cutRet) do
				returnTable[#returnTable+1] = v
			end

			return returnTable
		end
	end

	return {str}
end

SKIN.fontLabel 					= "Verdana"
SKIN.fontLargeLabel 			= "Verdana"

derma.RefreshSkins()

PERP2_SKIN = SKIN
