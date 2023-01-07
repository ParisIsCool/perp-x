--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

if CLIENT then
	Material( "tools/toolsblack" ):SetInt( "$alpha", 0 )

	hook.Add( "InitPostEntity", "FixTooManyVertexes", function()
		RunConsoleCommand( "con_filter_text_out", "vertex" )
		RunConsoleCommand( "con_filter_enable", "1" )
	end )
end

InnerCity = {
	{ Vector( -9911.4697, -13291.6055, 1680.3978 ), Vector( -3028.1880, -3869.2109, -1001.8713 ) },
}



policeDoors = {
						{Vector(3282, -4523.009765625, -142.75), 'models/props_c17/door01_left.mdl'},
						{Vector(3376, -4523.009765625, -142.75), 'models/props_c17/door01_left.mdl'},
						{Vector(4100, -4387.009765625, -142.75), 'models/props_c17/door01_left.mdl'},
						{Vector(4006, -4387.009765625, -142.75), 'models/props_c17/door01_left.mdl'},
						{Vector(4109, -4717.009765625, -142.75), 'models/props_c17/door01_left.mdl'},
						{Vector(3655, -4319.009765625, 1904.25), 'models/props_c17/door01_left.mdl'},
						{Vector(3561, -4319.009765625, 1904.25), 'models/props_c17/door01_left.mdl'},
						{Vector(4109, -4577.009765625, 1904.25), 'models/props_c17/door01_left.mdl'},
						{Vector(4109, -4717.009765625, 1904.25), 'models/props_c17/door01_left.mdl'},
						{Vector(4341, -4641.509765625, -1413.5), '*75'},
						{Vector(4341, -4774.509765625, -1413.5), '*74'},
						{Vector(3906, -4387.009765625, -1422.7199707031), 'models/props_c17/door01_left.mdl'},
						{Vector(3354, -4387.009765625, -1422.7199707031), 'models/props_c17/door01_left.mdl'},
						{Vector(3362, -4523.009765625, -1422.7199707031), 'models/props_c17/door01_left.mdl'},
						{Vector(4110, -4050, -1815), '*164'},
						{Vector(4110, -3932, -1815), '*165'},
						{Vector(4110, -4306, -1815), '*166'},
						{Vector(4110, -4188, -1815), '*167'},
						{Vector(-7515, -9169, 518.28100585938), 'models/props_c17/door01_left.mdl'},
						{Vector(-6963, -9169, 518.28100585938), 'models/props_c17/door01_left.mdl'},
						{Vector(-6528, -9556.5, 527.5), '*218'},
						{Vector(-6528, -9423.5, 527.5), '*219'},
						{Vector(-7432, -9099, 1798), 'models/props_c17/door01_left.mdl'},
						{Vector(-7432, -8975, 1798), 'models/props_c17/door01_left.mdl'},
						{Vector(-7060, -8975, 1798), 'models/props_c17/door01_left.mdl'},
						{Vector(-7060, -9099, 1798), 'models/props_c17/door01_left.mdl'},
						{Vector(-7308, -9101, 3845.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-7214, -9101, 3845.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-6760, -9359, 3845.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-6760, -9499, 3845.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-7125, -8798, -377.75), 'models/props_c17/door03_left.mdl'},
						{Vector(-7389, -9272, -377.75), 'models/props_c17/door03_left.mdl'},
						{Vector(-3816, -8232, 290), '*113'},
						{Vector(-3816, -7944, 290), '*111'},
						{Vector(-3816, -7656, 290), '*112'},
						{Vector(-3804, -7572.009765625, 248), '*115'},
						{Vector(-3684, -7572.009765625, 248), '*114'},
						{Vector(-3828, -7122, 252.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-3828, -7306.990234375, 252.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-3828, -7370.990234375, 252.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-3659, -7317, 252.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-3659, -7381, 252.25), 'models/props_c17/door01_left.mdl'},
                        {Vector(-9383, 9044, 126.281), 'models/props_c17/door03_left.mdl'},
                        {Vector(-9768, 9097, 126.281), 'models/props_c17/door03_left.mdl'},
                        {Vector(-9880, 9334, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-9880, 9240, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10256, 9020, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10015, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10121, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10529, 9231, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10623, 9231, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10609, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
						{Vector(-10703, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
						{Vector(3480, -4490.009765625, -2318.75), 'models/props_c17/door03_left.mdl'},
						{Vector(3744, -4016.0100097656, -2318.75), 'models/props_c17/door03_left.mdl'},
						{Vector(4054, -4103.009765625, -2318.75), 'models/props_c17/door03_left.mdl'},
						{Vector(4101, -4204.009765625, -2318.75), 'models/props_c17/door03_left.mdl'},
}

civilDoors = {

	{ Vector(1312, 4603, 144), '*159' },
	{ Vector(1084, 4603, 144), '*160' },
	{ Vector(937, 4220, 136), '*165' },
	{ Vector(937, 4101, 136), '*166' },
	{ Vector( -3816, -8232, 290 ), "*113" },
	{ Vector( -3816, -7944, 290 ), "*111" },
	{ Vector( -3816, -7656, 290 ), "*112" },
	{ Vector( -3804, -7572.009765625, 248 ), "*115" },
	{ Vector( -3684, -7572.009765625, 248 ), "*114" },
	{ Vector( -3828, -7122, 252.25 ), "models/props_c17/door01_left.mdl" },
	{ Vector( -3828, -7306.990234375, 252.25 ), "models/props_c17/door01_left.mdl" },
	{ Vector( -3828, -7370.990234375, 252.25 ), "models/props_c17/door01_left.mdl" },
	{ Vector( -3659, -7317, 252.25 ), "models/props_c17/door01_left.mdl" },
	{ Vector( -3659, -7381, 252.25 ), "models/props_c17/door01_left.mdl" },
	{ Vector( -9383, 9044, 126.281 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -9768, 9097, 126.281 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -9880, 9334, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -9880, 9240, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -10256, 9020, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -10015, 9495, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -10121, 9495, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -10529, 9231, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -10623, 9231, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -10609, 9495, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -10703, 9495, 126.25 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -6758, -10521, -124.5 ), "*145" },
	{ Vector( -3804, -7572, 248 ), "*62" },
	{ Vector( -3684, -7572, 248 ), "*61" },
	{ Vector( -3816, -7656, 290 ), "*59" },
	{ Vector( -3816, -7944, 290 ), "*58" },
	{ Vector( -3816, -8232, 290 ), "*60" },
	{ Vector( -10904, 9333, 135 ), "*241" },
{Vector(7210, -2800.0100097656, -1688.75), 'models/props_c17/door01_left.mdl'},
{Vector(7210, -2864.0100097656, -1688.75), 'models/props_c17/door01_left.mdl'},
{Vector(7185, -3055.0100097656, -1693), '*11'},
{Vector(7065, -3055.0100097656, -1693), '*12'},
{Vector(7041, -2854, -1688.75), 'models/props_c17/door01_left.mdl'},
{Vector(7041, -2790, -1688.75), 'models/props_c17/door01_left.mdl'},
{Vector(7041, -2605.0100097656, -1688.75), 'models/props_c17/door01_left.mdl'},
{Vector(6876.5, -2575.0100097656, -1680), '*9'},
{Vector(6876.5, -2515.0100097656, -1680), '*10'},

}

GasShopDoor = {
	{Vector(3373, 830, -1806), '*85'},
	{Vector(3373, 708, -1806), '*86'},
	{Vector(-7949, 5225, 1435), '*174'},
	{Vector(-7685, 5225, 1435), '*175'},
}

clubDoors = {
	{Vector(-6967, -12459, 135), '*244'},
	{Vector(-7089, -12459, 135), '*245'},
}

RealtorOfficeDoors = {
	--{Vector(1689, -2283, -1763), '*168'},
	--{Vector(1689, -2165, -1763), '*169'},
	--{Vector(1062, -2557, -1763), '*170'},
	--{Vector(929, -2606, -1763), '*171'},
	--{ Vector( -7092, -7786, 135 ), "*171" },
	--{ Vector( -7092, -7664, 135 ), "*172" },
	--{ Vector( -10904.5, 9393, 135 ), "*240" },
}

GeneralStoreDoors = {
	{ Vector( 5341, 883.98999023438, -1814.75 ), "models/props_c17/door01_left.mdl" },
}

BankDoors = {
	{ Vector( 1689, -2283, -1763 ), "*168" },
	{ Vector( 1689, -2165, -1763 ), "*169" },
	{ Vector( 1062, -2557, -1763 ), "*170" },
	{ Vector( 929, -2606, -1763 ), "*171" },
}

BPShopDoors = {
	{ Vector( -7348, -6349, 135 ), "*170" },
	{ Vector( -7348, -6227, 135 ), "*169" },
	{ Vector( 10524, 13380, 121.5 ), "*175" },
	{ Vector( 10260, 13380, 121.5 ), "*176" },
}

FCStoreDoors = {
	{ Vector( 5686, -1686, -1806 ), "*91" },
	{ Vector( 5564, -1686, -1806 ), "*92" },
}

TidesHotelDoors = {
	{ Vector( -11099, -1325, -2073 ), "*104" },
	{ Vector( -11159, -1325, -2073 ), "*105" },
	{ Vector( -10851, -1325, -2073 ), "*106" },
	{ Vector( -10911, -1325, -2073 ), "*107" },
	{ Vector( -11065, 725, -1946 ), "*109" },
	{ Vector( -10945, 725, -1946 ), "*110" },
}

ShopsDoors = {
	{ Vector( -6454, -10258, 127.5 ), "*64" },
	{ Vector( -5255, -6945, 135 ), "*182" },
	{ Vector( -5377, -6945, 135 ), "*183" },
}

CarDealerDoors = {
	{ Vector( 1419, -6133, -1814 ), "*102" },
}

HospitalDoors = {
	{ Vector( 7969, -743, -1743 ), "models/joebloom/millwork/door_commercial01.mdl" },
	{ Vector( 7969, -865, -1743 ), "models/joebloom/millwork/door_commercial01.mdl" },
	{ Vector( 8409, -756, -1691 ), "models/props_doors/doormainmetalwindowsmall01.mdl" },
	{ Vector( 8409, -852, -1691 ), "models/props_doors/doormainmetalwindowsmall01.mdl" },
	{ Vector( 7917, -485, -1691 ), "models/props_doors/doormain01.mdl" },
	{ Vector( 8509, -936, -1691 ), "models/props_doors/doormain01.mdl" },
	{ Vector( 8629, -936, -1691 ), "models/props_doors/doormain01.mdl" },
	{ Vector( 9085, -756, -1691 ), "models/props_doors/doormainmetalwindowsmall01.mdl" },
	{ Vector( 9085, -852, -1691 ), "models/props_doors/doormainmetalwindowsmall01.mdl" },
	{ Vector( 8785, -516, -1691 ), "models/props_doors/doormain01.mdl" },
	{ Vector( 8785, -396, -1691 ), "models/props_doors/doormain01.mdl" },
	{ Vector( 9219, -936, -1691 ), "models/props_doors/doormainmetalwindowsmall01.mdl" },
	{ Vector( 9123, -936, -1691 ), "models/props_doors/doormainmetalwindowsmall01.mdl" },
	{ Vector( 9208, -672, -1691 ), "models/props_doors/doormainmetalwindowsmall01.mdl" },
	{ Vector( 9112, -672, -1691 ), "models/props_doors/doormainmetalwindowsmall01.mdl" },
	{ Vector( 9433, -865, -1743 ), "models/joebloom/millwork/door_commercial01.mdl" },
	{ Vector( 9433, -743, -1743 ), "models/joebloom/millwork/door_commercial01.mdl" },
	{ Vector( 9016, -1172, -1691 ), "models/props_doors/doormain01.mdl" },
}

GovermentCenterDoors = {
	{ Vector( -6760, -8712.625, 134 ), "*140" },
	{ Vector( -6760, -8809.34375, 134 ), "*63" },
	{ Vector( -6760, -8992.625, 134 ), "*142" },
	{ Vector( -6760, -9089.34375, 134 ), "*141" },
	{ Vector( -7782, -10415, -170.79219055176 ), "*65" },
	{ Vector( -6892, -10160, -88 ), "*68" },
	{ Vector( -6758, -10521, -124.5 ), "*145" },
}

JailsDoors = {
	{ Vector( -7027, -9253, -372 ), "*78" },
	{ Vector( -7482, -9844, -372 ), "*71" },
	{ Vector( -7479.1875, -10369.375, -372 ), "*87" },
	{ Vector( -8066, -9825, -377.75 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -7972, -9825, -377.75 ), "models/props_c17/door03_left.mdl" },
	{ Vector( -7580, -10331, -381 ), "*76" },
	{ Vector( -7580, -10203, -381 ), "*74" },
	{ Vector( -7580, -10075, -381 ), "*72" },
	{ Vector( -7580, -9947, -381 ), "*69" },
	{ Vector( -7381, -9947, -381 ), "*82" },
	{ Vector( -7381, -10075, -381 ), "*81" },
	{ Vector( -7381, -10203, -381 ), "*80" },
	{ Vector( -7381, -10331, -381 ), "*79" },
}

ApartmentsDoors = {
	{Vector(1386, -4086, -1815), '*157'},
    {Vector(1513, -3959, -1815), '*156'},
    {Vector(265,-5107,-1687), 'models/joebloom/doors/door_interior01.mdl'},
	{Vector(1563, -4460, -1623), '*158'},
	{Vector(1563, -4460, -1623), '*158'},
	{Vector(1563, -4461, -1534), 'models/joebloom/doors/door_interior01.mdl'},
	{Vector(1563, -4460, -1335), '*162'},
	{Vector(1696, -4453, -1678), 'models/joebloom/doors/door_interior01.mdl'},
	{Vector(1696, -4453, -1534), 'models/joebloom/doors/door_interior01.mdl'},
	{Vector(1696, -4453, -1390), 'models/joebloom/doors/door_interior01.mdl'},
}

RoadCrewDoors = {
	{ Vector( 694, 4067, 136 ), "*161" },
	{ Vector( 694, 3955, 136 ), "*162" },
	{ Vector( 694, 3851, 136 ), "*164" },
	{ Vector( 694, 3739, 136 ), "*163" },
	{ Vector( 743, 4093, 126.25 ), "models/props_c17/door01_left.mdl" },
	{ Vector( 845, 4528, 126.25 ), "models/props_c17/door01_left.mdl" },
	{ Vector( 845, 4592, 126.25 ), "models/props_c17/door01_left.mdl" },
	{ Vector( 937, 4101, 136 ), "*166" },
	{ Vector( 937, 4220, 136 ), "*165" },
	{ Vector( 1312, 4603, 144 ), "*159" },
	{ Vector( 1084, 4603, 144 ), "*160" },
}

CasinoDoors = {
	{ Vector( -3992, -6441, 252.25 ), "models/props_c17/door01_left.mdl" }
}

CityFurniture = {}

CityFurniture[ "Speed Trap" ] = {
	{ Model = Model( "models/phxtended/tri1x1x1solid.mdl" ), Pos = Vector( -6003.5698, -3387.2551, 64.425), Angle = Angle( -0.0048, 179.9958, -0.0005) },

}
