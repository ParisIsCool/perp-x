--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]


PROPERTY = {};

PROPERTY.ID = 98;

PROPERTY.Name = "Suburbs Lake House #2";
PROPERTY.Category = "House";
PROPERTY.Description = "A small house near the lake.";
PROPERTY.Image = "lakehouse1";

PROPERTY.Cost = 1750;

PROPERTY.HUDBlip = Vector( 12307, -5429, 1191 )

PROPERTY.Doors = 	{
	{Vector(12798, -5552, 404.25), 'models/props_doors/doormain01_small.mdl'},
	{Vector(12798, -5456, 404.25), 'models/props_doors/doormain01_small.mdl'},
	{Vector(12270, -5626, 404), 'models/props_doors/doormain01_small.mdl'},
	{Vector(12158, -5614, 404), 'models/props_doors/doormain01_small.mdl'},
	{Vector(12094, -5414, 404), 'models/props_doors/doormain01_small.mdl'},
	{Vector(12174, -5510, 540), 'models/props_doors/doormain01_small.mdl'},
	{Vector(11906, -5266, 404), 'models/props_doors/doormain01_small.mdl'},
	{Vector(11966, -5510, 540), 'models/props_doors/doormain01_small.mdl'},
};

PROPERTY.Furniture = {}


PROPERTY.Furniture[ "Living Room" ] = {
	{ Model = Model("models/props_interiors/furniture_couch02a.mdl"), Pos = Vector( 12768.456054688, -5213.5908203125, 374.16586303711 ), Angle = Angle( -0.19081541895866, -132.50390625, -1.0625915527344) },
	{ Model = Model("models/props_junk/bicycle01a.mdl"), Pos = Vector( 12781.7890625, -5332.2958984375, 374.57537841797 ), Angle = Angle( -0.026456013321877, -102.92833709717, -12.982604980469) },
	{ Model = Model("models/props/cs_italy/it_mkt_table2.mdl"), Pos = Vector( 12583.842773438, -5320.5883789063, 352.27764892578 ), Angle = Angle( 0.00015949887165334, -90.012870788574, 0.0032729064114392) },
	{ Model = Model("models/props/cs_italy/orange.mdl"), Pos = Vector( 12588.442382813, -5330.0170898438, 390.93011474609 ), Angle = Angle( 35.242710113525, 38.773265838623, 45.032085418701) },
	{ Model = Model("models/props/cs_italy/bananna_bunch.mdl"), Pos = Vector( 12612.2109375, -5311.1142578125, 390.63143920898 ), Angle = Angle( -13.897311210632, 5.5612287521362, 17.262842178345) },
	{ Model = Model("models/props/cs_militia/couch.mdl"), Pos = Vector( 12683.80859375, -5798.0854492188, 351.55895996094 ), Angle = Angle( -9.0302173703094e-006, -0.00015919002180453, 0.00024775948259048) },
	{ Model = Model("models/props/cs_militia/couch.mdl"), Pos = Vector( 12774.140625, -5707.2807617188, 352.26266479492 ), Angle = Angle( 0.054045926779509, 90.005752563477, -0.0382080078125) },
	{ Model = Model("models/props_c17/furnituredrawer002a.mdl"), Pos = Vector( 12765.578125, -5793.111328125, 369.09271240234 ), Angle = Angle( 5.3763715186506e-006, 141.84107971191, -0.00836181640625) },
	{ Model = Model("models/props_combine/breenclock.mdl"), Pos = Vector( 12764.659179688, -5794.4033203125, 390.28924560547 ), Angle = Angle( 1.1970043182373, 143.42695617676, 0.087184064090252) },
	{ Model = Model("models/props_c17/furniturefireplace001a.mdl"), Pos = Vector( 12373.14453125, -5688.9497070313, 394.30032348633 ), Angle = Angle( 2.573098897934, -0.95187342166901, 0.045694012194872) },
	{ Model = Model("models/props_interiors/furniture_desk01a.mdl"), Pos = Vector( 12374.009765625, -5458.1259765625, 371.9873046875 ), Angle = Angle( 3.7415575206978e-006, -89.980102539063, -0.025238037109375) },
}

PROPERTY.Furniture[ "Kitchen" ] = {
	{ Model = Model("models/props_trainstation/trainstation_clock001.mdl"), Pos = Vector( 12344.42578125, -5429.5307617188, 424.88299560547 ), Angle = Angle( 0.0020237516146153, 90.055320739746, -0.022369384765625) },
	{ Model = Model("models/props/cs_militia/shelves.mdl"), Pos = Vector( 12256.948242188, -5431.7568359375, 424.69058227539 ), Angle = Angle( 1.8695257147927e-011, 3.2955756523734e-006, -2.0935262909916e-006) },
	{ Model = Model("models/props/cs_militia/shelves.mdl"), Pos = Vector( 12174.146484375, -5431.5263671875, 424.77194213867 ), Angle = Angle( -1.5838222680031e-005, 1.9302717646497e-006, 2.9751709007542e-005) },
	{ Model = Model("models/props/cs_office/microwave.mdl"), Pos = Vector( 12108.150390625, -5249.7045898438, 390.38980102539 ), Angle = Angle( 6.410974310711e-005, -89.975593566895, -0.002471923828125) },
	{ Model = Model("models/props_junk/garbage_glassbottle001a.mdl"), Pos = Vector( 12327.666015625, -5202.984375, 398.90313720703 ), Angle = Angle( -3.3208922900485e-007, -90.000015258789, -0.074951171875) },
	{ Model = Model("models/props/cs_militia/oldphone01.mdl"), Pos = Vector( 12350.233398438, -5192.2827148438, 413.77886962891 ), Angle = Angle( 9.9270029750187e-005, -90.000793457031, 0.001479075406678) },
	{ Model = Model("models/props_junk/garbage_milkcarton001a.mdl"), Pos = Vector( 12368.473632813, -5207.6489257813, 398.39505004883 ), Angle = Angle( 0.16452494263649, -113.29023742676, 0.49258115887642) },
	{ Model = Model("models/props_lab/cactus.mdl"), Pos = Vector( 12401.098632813, -5206.8471679688, 395.40551757813 ), Angle = Angle( -0.65250813961029, 116.66891479492, 0.19430296123028) },
	{ Model = Model("models/props_interiors/pot02a.mdl"), Pos = Vector( 12397.916015625, -5288.0952148438, 392.986328125 ), Angle = Angle( -0.046112935990095, 161.49555969238, 0.026673119515181) },
}

PROPERTY.Furniture[ "Upstairs Bedroom" ] = {
	{ Model = Model("models/props/cs_militia/couch.mdl"), Pos = Vector( 12262.235351563, -5450.2172851563, 487.49493408203 ), Angle = Angle( 0.065559864044189, 89.99072265625, -0.10205078125) },
	{ Model = Model("models/props_furniture/cupboard1.mdl"), Pos = Vector( 12268.829101563, -5391.8193359375, 490.80349731445 ), Angle = Angle( -4.9149484766531e-006, 180, 0.19405724108219) },
	{ Model = Model("models/props_lab/frame002a.mdl"), Pos = Vector( 12270.83203125, -5380.4750976563, 514.74163818359 ), Angle = Angle( -3.2290792262302e-009, -179.99996948242, -2.0936306555086e-006) },
	{ Model = Model("models/props_interiors/corkboardverticle01.mdl"), Pos = Vector( 12279.298828125, -5379.0380859375, 560.73413085938 ), Angle = Angle( 0.002130712615326, -179.78219604492, -0.5611572265625) },
	{ Model = Model("models/props/cs_office/tv_plasma.mdl"), Pos = Vector( 12104.516601563, -5412.22265625, 531.65698242188 ), Angle = Angle( -0.16882254183292, 0.12508499622345, -0.0125732421875) },
}

PROPERTY.Furniture[ "Master Office" ] = {
	{ Model = Model("models/props_combine/breendesk.mdl"), Pos = Vector( 12042.715820313, -5718.4697265625, 352.44152832031 ), Angle = Angle( -0.046540051698685, -0.10369369387627, 0.037703145295382) },
	{ Model = Model("models/props/cs_office/computer_keyboard.mdl"), Pos = Vector( 12029.923828125, -5718.9409179688, 383.93008422852 ), Angle = Angle( 0.3229855298996, 179.90856933594, -0.041778564453125) },
	{ Model = Model("models/props/cs_office/computer_mouse.mdl"), Pos = Vector( 12030.28515625, -5735.4267578125, 383.92364501953 ), Angle = Angle( 0.30749291181564, -176.33485412598, 0.043101333081722) },
	{ Model = Model("models/props/cs_office/phone.mdl"), Pos = Vector( 12031.48046875, -5747.8413085938, 383.89300537109 ), Angle = Angle( 0.47258979082108, 169.07843017578, 0.023585889488459) },
	{ Model = Model("models/props/cs_office/computer_monitor.mdl"), Pos = Vector( 12037.736328125, -5690.90625, 383.93798828125 ), Angle = Angle( 0.11749237775803, -134.92039489746, 0.20532712340355) },
	{ Model = Model("models/props_interiors/furniture_chair03a.mdl"), Pos = Vector( 12002.3359375, -5716.7426757813, 371.75033569336 ), Angle = Angle( 0.011798684485257, -1.552117228508, -0.016876220703125) },
	{ Model = Model("models/props_wasteland/controlroom_filecabinet002a.mdl"), Pos = Vector( 11989.051757813, -5647.90625, 387.29415893555 ), Angle = Angle( -0.0067907958291471, -90.057800292969, 0.044120233505964) },
	{ Model = Model("models/props_wasteland/controlroom_filecabinet002a.mdl"), Pos = Vector( 11965.624023438, -5647.8178710938, 387.23379516602 ), Angle = Angle( 0.041326157748699, -89.983200073242, -0.13442993164063) },
	{ Model = Model("models/props_wasteland/controlroom_filecabinet002a.mdl"), Pos = Vector( 11942.349609375, -5647.8706054688, 387.23699951172 ), Angle = Angle( -0.028774650767446, -90.000137329102, 0.022436490282416) },
	{ Model = Model("models/props/cs_office/trash_can.mdl"), Pos = Vector( 12028.620117188, -5661.3642578125, 353.20101928711 ), Angle = Angle( 3.8947698044467e-007, 1.0772918358271e-005, -1.8910094468083e-006) },
	{ Model = Model("models/props_c17/clock01.mdl"), Pos = Vector( 12044.879882813, -5632.4482421875, 438.08676147461 ), Angle = Angle( 90, 90.000328063965, 180) },
	{ Model = Model("models/props/cs_office/offcorkboarda.mdl"), Pos = Vector( 11973.122070313, -5815.568359375, 424.81661987305 ), Angle = Angle( 0.22716300189495, 0.043514870107174, -0.14093017578125) },
	{ Model = Model("models/props/de_nuke/file_cabinet1_group.mdl"), Pos = Vector( 12265.801757813, -5781.6791992188, 352.36804199219 ), Angle = Angle( -0.019710563123226, -179.95881652832, 0.063701204955578) },
}

PROPERTY.Furniture[ "Bar Room" ] = {
	{ Model = Model("models/props/cs_militia/couch.mdl"), Pos = Vector( 11965.5390625, -5414.2158203125, 351.83480834961 ), Angle = Angle( -0.38800546526909, -0.077592626214027, -0.277099609375) },
	{ Model = Model("models/props/cs_militia/bar01.mdl"), Pos = Vector( 12012.942382813, -5231.2739257813, 352.48583984375 ), Angle = Angle( 0.016709316521883, -134.89407348633, -0.023529052734375) },
	{ Model = Model("models/props_junk/garbage_glassbottle003a.mdl"), Pos = Vector( 12070.959960938, -5226.8686523438, 405.19918823242 ), Angle = Angle( 0.42966106534004, 161.17359924316, -0.00042724609375) },
}

PROPERTY.Furniture[ "Fencing" ] = {
	{ Model = Model("models/props_c17/fence01a.mdl"), Pos = Vector( 11825.08984375, -5802.0830078125, 374.55340576172 ), Angle = Angle( 0.17573913931847, -93.473327636719, 0.0099837249144912) },
	{ Model = Model("models/props_c17/fence01a.mdl"), Pos = Vector( 11691.732421875, -5795.5224609375, 376.54110717773 ), Angle = Angle( -4.1279940605164, -92.271774291992, -0.7958984375) },
	{ Model = Model("models/props_c17/fence01a.mdl"), Pos = Vector( 11562.823242188, -5797.13671875, 379.44973754883 ), Angle = Angle( -1.2182712554932, -92.241424560547, -1.7698669433594) },
	{ Model = Model("models/props_c17/fence01a.mdl"), Pos = Vector( 11488.487304688, -5733.890625, 381.83270263672 ), Angle = Angle( 0.082590341567993, -176.13415527344, -0.24179077148438) },
	{ Model = Model("models/props_c17/fence01a.mdl"), Pos = Vector( 11486.130859375, -5602.3505859375, 382.92172241211 ), Angle = Angle( -0.25061416625977, 177.40077209473, -0.53390502929688) },
	{ Model = Model("models/props_c17/fence03a.mdl"), Pos = Vector( 11502.046875, -5407.4135742188, 386.46795654297 ), Angle = Angle( -0.18033711612225, 174.44635009766, -0.22283935546875) },
	{ Model = Model("models/props_c17/fence01b.mdl"), Pos = Vector( 11515.885742188, -5240.427734375, 387.05133056641 ), Angle = Angle( 0.59096419811249, -176.50894165039, -0.69580078125) },
	{ Model = Model("models/props_c17/fence01b.mdl"), Pos = Vector( 11491.244140625, -5180.0400390625, 388.78533935547 ), Angle = Angle( -2.5807602405548, -172.78091430664, -0.83694458007813) },
	{ Model = Model("models/props_c17/fence01b.mdl"), Pos = Vector( 11484.09375, -5104.5693359375, 389.0432434082 ), Angle = Angle( -2.580760717392, -175.39671325684, -0.83694458007813) },
	{ Model = Model("models/props_c17/fence01b.mdl"), Pos = Vector( 11475.766601563, -5028.806640625, 390.26724243164 ), Angle = Angle( -2.5807604789734, -176.07321166992, -0.83694458007813) },
	{ Model = Model("models/props_c17/fence01b.mdl"), Pos = Vector( 11459.53125, -4956.5341796875, 392.03720092773 ), Angle = Angle( -2.580760717392, -154.92132568359, -0.83694458007813) },
	{ Model = Model("models/props_c17/fence01b.mdl"), Pos = Vector( 11422.282226563, -4888.1962890625, 394.81723022461 ), Angle = Angle( -2.580760717392, -147.07391357422, -0.83694458007813) },
	{ Model = Model("models/props_c17/fence01b.mdl"), Pos = Vector( 11378.001953125, -4824.7265625, 399.37631225586 ), Angle = Angle( -2.580760717392, -144.36790466309, -0.83694458007813) },
	{ Model = Model("models/props_c17/fence01b.mdl"), Pos = Vector( 11320.478515625, -4775.482421875, 405.07312011719 ), Angle = Angle( -2.5807604789734, -123.3512878418, -0.83694458007813) },
	{ Model = Model("models/props_c17/fence01a.mdl"), Pos = Vector( 11220.301757813, -4766.0913085938, 415.09799194336 ), Angle = Angle( -0.21577432751656, -80.501487731934, -3.77294921875) },
	{ Model = Model("models/props_c17/fence01b.mdl"), Pos = Vector( 11117.291992188, -4783.1694335938, 424.67852783203 ), Angle = Angle( -1.3254783153534, -80.568878173828, -4.3567504882813) },
}


GAMEMODE:RegisterProperty(PROPERTY);
