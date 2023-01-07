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

PROPERTY.ID = 97;

PROPERTY.Name = "Suburbs Lake House #3";
PROPERTY.Category = "House";
PROPERTY.Description = "A small house near the lake.";
PROPERTY.Image = "lakehouse2";

PROPERTY.Cost = 2200;

PROPERTY.HUDBlip = Vector( 11692, -8882, 1015 )

PROPERTY.Doors = 	{
	{Vector(11630, -9018, 404), 'models/props_doors/doormain01_small.mdl'},
	{Vector(11518, -9006, 404), 'models/props_doors/doormain01_small.mdl'},
	{Vector(11454, -8806, 404), 'models/props_doors/doormain01_small.mdl'},
	{Vector(11534, -8902, 540), 'models/props_doors/doormain01_small.mdl'},
	{Vector(11326, -8902, 540), 'models/props_doors/doormain01_small.mdl'},
	{Vector(12158, -8944, 404.25), 'models/props_doors/doormain01_small.mdl'},
	{Vector(12158, -8848, 404.25), 'models/props_doors/doormain01_small.mdl'},
	{Vector(11266, -8658, 404), 'models/props_doors/doormain01_small.mdl'},
};


PROPERTY.Furniture = {}


PROPERTY.Furniture[ "Living Room" ] = {
	{ Model = Model("models/props_c17/furnituretable001a.mdl"), Pos = Vector( 11972.85546875, -8849.1513671875, 370.31741333008 ), Angle = Angle( -0.022629717364907, 93.729629516602, -0.057586669921875) },
	{ Model = Model("models/props_junk/garbage_glassbottle003a.mdl"), Pos = Vector( 11973.185546875, -8851.7041015625, 391.26284790039 ), Angle = Angle( -22.567420959473, 9.1572790145874, 90.018486022949) },
	{ Model = Model("models/props_interiors/furniture_chair01a.mdl"), Pos = Vector( 11937.469726563, -8855.185546875, 373.42678833008 ), Angle = Angle( -0.027041343972087, 1.1612389087677, -0.15585327148438) },
	{ Model = Model("models/props_interiors/furniture_chair01a.mdl"), Pos = Vector( 11974.557617188, -8881.0361328125, 373.40579223633 ), Angle = Angle( -0.0125135127455, 94.467277526855, -0.02734375) },
	{ Model = Model("models/props_interiors/furniture_chair01a.mdl"), Pos = Vector( 12008.915039063, -8844.904296875, 373.35922241211 ), Angle = Angle( 0.0016319701680914, -175.79637145996, -3.0517578125e-005) },
	{ Model = Model("models/props_interiors/furniture_chair01a.mdl"), Pos = Vector( 11974.189453125, -8816.080078125, 373.24459838867 ), Angle = Angle( -0.032741654664278, -97.873947143555, 0.0056462152861059) },
	{ Model = Model("models/props_c17/furniturecouch001a.mdl"), Pos = Vector( 11880.133789063, -8606.8427734375, 369.35971069336 ), Angle = Angle( 0.0059178839437664, -90.004814147949, -0.39376831054688) },
	{ Model = Model("models/props_c17/furnituretable002a.mdl"), Pos = Vector( 11979.84375, -8604.361328125, 370.64984130859 ), Angle = Angle( -0.0077305384911597, -90.018402099609, -0.000732421875) },
	{ Model = Model("models/props_c17/furniturecouch001a.mdl"), Pos = Vector( 12083.540039063, -8606.8466796875, 369.07174682617 ), Angle = Angle( 0.0020680455490947, -89.999313354492, -0.052886962890625) },
	{ Model = Model("models/props_interiors/furniture_lamp01a.mdl"), Pos = Vector( 12143.284179688, -8596.599609375, 385.8791809082 ), Angle = Angle( -0.054848905652761, -111.77220153809, 0.804363489151) },
	{ Model = Model("models/props_interiors/furniture_lamp01a.mdl"), Pos = Vector( 11786.522460938, -8594.1865234375, 385.86181640625 ), Angle = Angle( -0.5799423456192, -43.473415374756, -0.31625366210938) },
}

PROPERTY.Furniture[ "Office" ] = {
	{ Model = Model("models/props_wasteland/controlroom_filecabinet002a.mdl"), Pos = Vector( 11297.07421875, -9039.8603515625, 387.23873901367 ), Angle = Angle( -0.0071079297922552, -90.007850646973, -0.04193115234375) },
	{ Model = Model("models/props_wasteland/controlroom_filecabinet002a.mdl"), Pos = Vector( 11320.255859375, -9039.7939453125, 387.32534790039 ), Angle = Angle( 0.010657018981874, -89.993980407715, -0.052825927734375) },
	{ Model = Model("models/props_lab/frame002a.mdl"), Pos = Vector( 11348.484375, -9037.6611328125, 391.9169921875 ), Angle = Angle( -0.29410490393639, -62.645980834961, 0.0076816510409117) },
	{ Model = Model("models/props_interiors/furniture_desk01a.mdl"), Pos = Vector( 11372.282226563, -9042.2587890625, 371.953125 ), Angle = Angle( -0.17929908633232, -90.013214111328, 0.090889066457748) },
	{ Model = Model("models/props/cs_office/computer.mdl"), Pos = Vector( 11373.0546875, -9043.0078125, 391.95175170898 ), Angle = Angle( -0.4139102101326, -89.900947570801, 0.27561649680138) },
	{ Model = Model("models/props_interiors/furniture_desk01a.mdl"), Pos = Vector( 11372.282226563, -9042.2587890625, 371.953125 ), Angle = Angle( -0.17929908633232, -90.013214111328, 0.090889066457748) },
	{ Model = Model("models/props_combine/breenchair.mdl"), Pos = Vector( 11373.1484375, -9077.0888671875, 352.36312866211 ), Angle = Angle( 0.0036971089430153, 90.023483276367, -0.05645751953125) },
	{ Model = Model("models/props/cs_office/computer_caseb.mdl"), Pos = Vector( 11412.420898438, -9037.68359375, 352.44677734375 ), Angle = Angle( 0.18728625774384, -90.079734802246, 0.52186596393585) },
	{ Model = Model("models/props_wasteland/kitchen_shelf001a.mdl"), Pos = Vector( 11456.213867188, -9040.1181640625, 352.46450805664 ), Angle = Angle( 0.064664267003536, -0.37436720728874, 1.1525236914167e-005) },
	{ Model = Model("models/props_c17/furnitureradiator001a.mdl"), Pos = Vector( 11601.359375, -9203.0322265625, 370.66006469727 ), Angle = Angle( 0.13690793514252, 88.339027404785, 0.0033939143177122) },
}

PROPERTY.Furniture[ "TV Room" ] = {
	{ Model = Model("models/props/cs_office/trash_can.mdl"), Pos = Vector( 11621.017578125, -8694.0888671875, 488.40692138672 ), Angle = Angle( -0.027462333440781, -179.93132019043, 0.048508308827877) },
	{ Model = Model("models/props/cs_militia/couch.mdl"), Pos = Vector( 11622.162109375, -8758.916015625, 487.8125 ), Angle = Angle( 0.37206292152405, 90.01505279541, -0.12493896484375) },
	{ Model = Model("models/props/cs_office/table_coffee.mdl"), Pos = Vector( 11480.75390625, -8762.396484375, 488.44659423828 ), Angle = Angle( -0.27629017829895, 0.026993803679943, -0.023529052734375) },
	{ Model = Model("models/props/cs_office/tv_plasma.mdl"), Pos = Vector( 11471.763671875, -8761.6435546875, 536.13757324219 ), Angle = Angle( 3.3238703167626e-007, -2.5277804155399e-011, 0) },
	{ Model = Model("models/props_c17/furnituredrawer001a.mdl"), Pos = Vector( 11489.232421875, -8881.7978515625, 508.38616943359 ), Angle = Angle( -0.018937403336167, 90.059944152832, -0.024322509765625) },
}

PROPERTY.Furniture[ "Upstairs Bedroom" ] = {
	{ Model = Model("models/props_lab/harddrive02.mdl"), Pos = Vector( 11448.330078125, -8869.7060546875, 535.48291015625 ), Angle = Angle( 0.0093456618487835, 96.185523986816, 0.1655367910862) },
	{ Model = Model("models/props/cs_office/computer.mdl"), Pos = Vector( 11426.500976563, -8875.1533203125, 525.76440429688 ), Angle = Angle( 0.059276837855577, 94.175682067871, -0.03753662109375) },
	{ Model = Model("models/props_lab/desklamp01.mdl"), Pos = Vector( 11396.885742188, -8875.208984375, 534.67761230469 ), Angle = Angle( 1.1350256204605, 64.737060546875, -1.1841735839844) },
	{ Model = Model("models/props_wasteland/controlroom_chair001a.mdl"), Pos = Vector( 11421.356445313, -8831.7734375, 509.095703125 ), Angle = Angle( 1.2010742877697e-012, -90, -2.1010525870224e-006) },
	{ Model = Model("models/props_c17/furnituretable002a.mdl"), Pos = Vector( 11418.091796875, -8875.7666015625, 506.61413574219 ), Angle = Angle( 0.056443333625793, 90.079086303711, -0.04168701171875) },
	{ Model = Model("models/props_interiors/furniture_shelf01a.mdl"), Pos = Vector( 11281.814453125, -8815.830078125, 531.72576904297 ), Angle = Angle( 0.34749433398247, 0.054695341736078, -0.013580322265625) },
	{ Model = Model("models/props_interiors/furniture_shelf01a.mdl"), Pos = Vector( 11281.865234375, -8764.1806640625, 531.71520996094 ), Angle = Angle( 0.40035617351532, -0.038637228310108, 0.0028644271660596) },
	{ Model = Model("models/props_c17/furniturecupboard001a.mdl"), Pos = Vector( 11283.216796875, -8705.0654296875, 493.93930053711 ), Angle = Angle( -0.01568865403533, -0.0084735779091716, 0.0019453673157841) },
	{ Model = Model("models/props_c17/furnituremattress001a.mdl"), Pos = Vector( 11433.607421875, -8702.111328125, 504.12976074219 ), Angle = Angle( 0, 0, 0) },
	{ Model = Model("models/props_c17/furniturebed001a.mdl"), Pos = Vector( 11434.447265625, -8700.7001953125, 506.5569152832 ), Angle = Angle( -0.0029548797756433, -89.325569152832, 0.016599401831627) },
}

GAMEMODE:RegisterProperty(PROPERTY);
