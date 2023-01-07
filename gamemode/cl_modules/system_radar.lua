--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

-- Main content
paris = paris or {}
local paris = paris
steamworks.DownloadUGC( 2034472616, function( name, FileObject )
    if isstring(name) then
        game.MountGMA( name )
    end
end)

local testboxes = {
	{pos1=Vector(-195.5071105957,4543.96875,-101.18724060059),pos2=Vector(-2326.5354003906,5744.5346679688,2080.03125)},
	{pos1=Vector(895.96875,5567.2763671875,11.713272094727),pos2=Vector(1406.6550292969,4351.9682617188,847.43383789063)},
	{pos1=Vector(1792.0406494141,4608.0048828125,848.04125976563),pos2=Vector(1341.1844482422,5299.50390625,56.031234741211)},
	{pos1=Vector(1408.041015625,4351.93359375,526.67022705078),pos2=Vector(696.13781738281,3647.96875,-103.01007080078)},
	{pos1=Vector(696.32019042969,3456.03125,-102.95658874512),pos2=Vector(1342.9304199219,2367.9675292969,1039.5416259766)},
	{pos1=Vector(1344.9061279297,2688.1362304688,1040.03125),pos2=Vector(1663.4860839844,3459.0424804688,-103.96875)},
	{pos1=Vector(2303.3522949219,2367.2487792969,-103.96875762939),pos2=Vector(1658.7075195313,3455.5668945313,1040.03125)},
	{pos1=Vector(2559.4997558594,3456.5046386719,848.03125),pos2=Vector(1919.5328369141,4159.9487304688,-55.968742370605)},
	{pos1=Vector(1662.7332763672,4031.7700195313,-55.99723815918),pos2=Vector(1918.3220214844,3456.03125,854.28125)},
	{pos1=Vector(3455.6528320313,4351.966796875,718.58978271484),pos2=Vector(2175.3259277344,5761.2470703125,8.03125)},
	{pos1=Vector(2815.9782714844,5760.345703125,719.05090332031),pos2=Vector(3327.9575195313,6272.3115234375,8.03125)},
	{pos1=Vector(3455.1799316406,5760.0341796875,719.35504150391),pos2=Vector(3592.0317382813,5368.2504882813,-37.304885864258)},
	{pos1=Vector(3583.5424804688,4735.90234375,720.03125),pos2=Vector(3456.9609375,4351.96875,-52.674629211426)},
	{pos1=Vector(3584.6127929688,6272.1123046875,720.03125),pos2=Vector(4159.8559570313,7168.390625,128.03125)},
	{pos1=Vector(3585.5498046875,7167.9741210938,720.03125),pos2=Vector(2815.4028320313,6528.0400390625,8.03125)},
	{pos1=Vector(3071.9682617188,7168.02734375,717.61535644531),pos2=Vector(3456.7001953125,7423.96875,133.83828735352)},
	{pos1=Vector(3520.6193847656,7423.0751953125,128.03125),pos2=Vector(2815.96875,7934.314453125,79.354537963867)},
	{pos1=Vector(2815.96875,7935.2045898438,78.581634521484),pos2=Vector(3455.5234375,8830.755859375,1040.03125)},
	{pos1=Vector(3456.5776367188,8352.03125,1024.0209960938),pos2=Vector(3583.6423339844,7935.96875,128.26779174805)},
	{pos1=Vector(3712.2197265625,8638.650390625,784.03125),pos2=Vector(4479.96875,7806.5859375,130.54119873047)},
	{pos1=Vector(4223.78125,7424.4760742188,352.03125),pos2=Vector(3711.408203125,7819.390625,128.03125)},
	{pos1=Vector(4479.96875,7551.703125,382.39544677734),pos2=Vector(5328.328125,8656.134765625,128.03125)},
	{pos1=Vector(5311.6186523438,7679.96875,384.96694946289),pos2=Vector(4608.21875,8639.943359375,624.03125)},
	{pos1=Vector(5311.77734375,7552.03125,783.61657714844),pos2=Vector(4480.3662109375,7103.96875,128.33746337891)},
	{pos1=Vector(4352.0258789063,6912.0239257813,1040.03125),pos2=Vector(5328.03125,6272.0463867188,128.65425109863)},
	{pos1=Vector(4096.03125,3263.8754882813,655.57458496094),pos2=Vector(3455.96875,2304.4526367188,-103.29186248779)},
	{pos1=Vector(4095.7431640625,2111.2863769531,528.03125),pos2=Vector(3455.9255371094,1536.1572265625,-103.96875)},
	{pos1=Vector(3647.9155273438,1024,527.6044921875),pos2=Vector(4480.01953125,1727.9743652344,-103.96875)},
	{pos1=Vector(4607.9721679688,1343.9757080078,655.64447021484),pos2=Vector(5213.9072265625,1856.03125,-103.10500335693)},
	{pos1=Vector(5056.419921875,2047.96875,656.09753417969),pos2=Vector(4729.8237304688,1856.169921875,-103.96875)},
	{pos1=Vector(5311.48046875,2047.96875,846.19134521484),pos2=Vector(4610.9721679688,3269.6291503906,-52.968872070313)},
	{pos1=Vector(4352.4736328125,3264.03125,-54.52953338623),pos2=Vector(4609.0678710938,2270.5278320313,848.03125)},
	{pos1=Vector(5616.03125,4544.3291015625,511.74072265625),pos2=Vector(4735.9287109375,5759.7021484375,-55.968757629395)},
	{pos1=Vector(5616.03125,4863.1455078125,511.68542480469),pos2=Vector(6016.0717773438,5760.6215820313,128.03125)},
	{pos1=Vector(5823.7202148438,5567.7045898438,640),pos2=Vector(4927.9907226563,5055.3950195313,512.03125)},
	{pos1=Vector(6208.2866210938,4351.96875,831.16833496094),pos2=Vector(8128.4809570313,5759.6508789063,8.0154113769531)},
	{pos1=Vector(9024.064453125,4351.96875,575.05267333984),pos2=Vector(10688.03125,5004.2377929688,-77.117431640625)},
	{pos1=Vector(10239.267578125,4992.1323242188,640.03125),pos2=Vector(8991.47265625,5504.3876953125,-3.5874710083008)},
	{pos1=Vector(10238.311523438,5504.8271484375,640.03125),pos2=Vector(9423.96875,5886.7016601563,9.8296432495117)},
	{pos1=Vector(9853.4814453125,5888.6938476563,768.03125),pos2=Vector(9016,6655.2690429688,8.5939025878906)},
	{pos1=Vector(9854.9541015625,6656.03125,673.16760253906),pos2=Vector(9211.4189453125,6847.4658203125,8.03125)},
	{pos1=Vector(9854.8466796875,6844.4228515625,672.03125),pos2=Vector(8319.96875,7131.68359375,200.3380279541)},
	{pos1=Vector(8831.7421875,6844.3779296875,672.03125),pos2=Vector(8320.373046875,6623.8247070313,8.03125)},
	{pos1=Vector(8319.72265625,6655.96875,958.96813964844),pos2=Vector(7419.455078125,7680.3569335938,128.03125)},
	{pos1=Vector(9215.357421875,7167.96875,958.67327880859),pos2=Vector(7671.27734375,8967.4306640625,-30.923751831055)},
	{pos1=Vector(7670.5991210938,8127.96875,958.97418212891),pos2=Vector(6974.5068359375,8971.234375,128.03125)},
	{pos1=Vector(6973.0830078125,8575.96875,639.45721435547),pos2=Vector(6206.7470703125,9726.240234375,128.03126525879)},
	{pos1=Vector(6654.8569335938,9727.96875,887.79663085938),pos2=Vector(6099.2626953125,10862.5390625,284.02368164063)},
	{pos1=Vector(6115.6279296875,10109.651367188,888.03125),pos2=Vector(4983.9331054688,10906.029296875,696.03125)},
	{pos1=Vector(4991.96875,10109.184570313,887.01477050781),pos2=Vector(5824.03125,9904.6572265625,763.02319335938)},
	{pos1=Vector(5824.03125,9904.5166015625,887.03918457031),pos2=Vector(5439.96875,9729.4912109375,685.97637939453)},
	{pos1=Vector(4352.6923828125,9727.96875,695.60693359375),pos2=Vector(4991.2661132813,10562.470703125,226.77069091797)},
	{pos1=Vector(4096.03125,10111.844726563,449.27432250977),pos2=Vector(3455.0688476563,11007.015625,160.03123474121)},
	{pos1=Vector(3327.96875,10112.688476563,161.90490722656),pos2=Vector(3636.3525390625,10559.96875,444.62203979492)},
	{pos1=Vector(3327.96875,10557.984375,328.49838256836),pos2=Vector(3455.96875,10952.935546875,169.53218078613)},
	{pos1=Vector(1439.5487060547,10751.96875,350.81430053711),pos2=Vector(479.16455078125,11456.592773438,137.87414550781)},
	{pos1=Vector(576.14147949219,11392,415.11676025391),pos2=Vector(1342.4267578125,10812.625976563,352.03125)},
	{pos1=Vector(1278.6654052734,13823.9375,511.87579345703),pos2=Vector(64.242279052734,14980.9765625,145.03247070313)},
	{pos1=Vector(-769.15734863281,13304.887695313,357.26205444336),pos2=Vector(-1671.4194335938,14182.765625,160.03126525879)},
	{pos1=Vector(-1805.4987792969,13322.404296875,360.31292724609),pos2=Vector(-2688.9479980469,14128.944335938,160.63859558105)},
	{pos1=Vector(-3832.1545410156,13305.275390625,328.14459228516),pos2=Vector(-4736.03125,14027.536132813,128.39738464355)},
	{pos1=Vector(-4858.9331054688,13306.995117188,330.06060791016),pos2=Vector(-5742.8120117188,14238.065429688,168.03125)},
	{pos1=Vector(-5746.6240234375,13487.967773438,367.94445800781),pos2=Vector(-6910.177734375,14177.78125,122.40591430664)},
	{pos1=Vector(-5757.7939453125,11214.067382813,369.49938964844),pos2=Vector(-6901.7861328125,10486.987304688,161.01817321777)},
	{pos1=Vector(-5760.03125,11391.592773438,335.79614257813),pos2=Vector(-5379.74609375,10595.291992188,167.1637878418)},
	{pos1=Vector(-5376.03125,11406.978515625,430.28897094727),pos2=Vector(-4350.77734375,10617.830078125,93.820671081543)},
	{pos1=Vector(-4368.03125,11406.286132813,432.53686523438),pos2=Vector(-3711.96875,10625.01953125,129.20893859863)},
	{pos1=Vector(-2814.8640136719,10111.967773438,415.18890380859),pos2=Vector(-2304.0185546875,10894.173828125,128.03125)},
	{pos1=Vector(-2305.7392578125,10303.774414063,416.03125),pos2=Vector(-1788.0426025391,10884.857421875,128.03125)},
	{pos1=Vector(-1535.7216796875,10112.046875,416.03121948242),pos2=Vector(-387.57266235352,10752.874023438,128.03126525879)},
	{pos1=Vector(-928.08453369141,10112.725585938,416.03125),pos2=Vector(-543.96875,9856.5166015625,128.21899414063)},
	{pos1=Vector(-321.05227661133,11902.084960938,416.03128051758),pos2=Vector(-1022.8009643555,10879.96875,129.99963378906)},
	{pos1=Vector(-128.56755065918,10879.967773438,415.58065795898),pos2=Vector(-319.76971435547,11522.012695313,128.03125)},
	{pos1=Vector(1919.3677978516,8255.9736328125,713.82073974609),pos2=Vector(1342.6683349609,8839.0361328125,128.03125)},
	{pos1=Vector(1663.5654296875,8256.9267578125,720.03125),pos2=Vector(1151.6888427734,7807.369140625,64.03125)},
	{pos1=Vector(1280.1290283203,7806.7983398438,912.03125),pos2=Vector(1920.03125,6656.3896484375,10.231903076172)},
	{pos1=Vector(1281.6579589844,7039.2192382813,912.03125),pos2=Vector(1087.8408203125,7424.4428710938,64.03125)},
	{pos1=Vector(895.06744384766,6847.9711914063,783.51275634766),pos2=Vector(253.71939086914,8000.5961914063,128.03125)},
	{pos1=Vector(160.40158081055,7935.0087890625,768.03125),pos2=Vector(253.65585327148,7679.2490234375,128.03125)},
	{pos1=Vector(1343.8911132813,8255.96875,1023.434387207),pos2=Vector(1216.03125,8522.40625,192.77182006836)},
	{pos1=Vector(703.96520996094,8256.2578125,1039.5759277344),pos2=Vector(1216.03125,8834.6650390625,135.2181854248)},
	{pos1=Vector(1163.96875,8304.7880859375,1027.8970947266),pos2=Vector(1294.6739501953,8467.326171875,1168.03125)},
	{pos1=Vector(0.09669303894043,8705.4453125,716),pos2=Vector(432.69342041016,8191.7001953125,128.03118896484)},
	{pos1=Vector(575.19696044922,8192.228515625,720.03125),pos2=Vector(410.98147583008,8643.017578125,128.03125)},
	{pos1=Vector(100.07961273193,8705.3896484375,716),pos2=Vector(383.75555419922,8832.03125,129.40145874023)},
	{pos1=Vector(-0.68320846557617,8831.904296875,912.03125),pos2=Vector(-832.03125,7810.2197265625,64.626663208008)},
	{pos1=Vector(255.94012451172,7358.8803710938,784.03125),pos2=Vector(-191.07608032227,7103.8803710938,56.031234741211)},
	{pos1=Vector(-192.21176147461,6656.0063476563,1040.03125),pos2=Vector(-832.03125,7551.5522460938,48.946472167969)},
	{pos1=Vector(-2495.7465820313,5952,382.99765014648),pos2=Vector(-1839.96875,6911.572265625,24.473289489746)},
	{pos1=Vector(-2495.9367675781,6209.1782226563,384),pos2=Vector(-2683.5168457031,6916.0263671875,95.169616699219)},
	{pos1=Vector(-2688.3186035156,5951.96875,511.11996459961),pos2=Vector(-3076.59765625,6930.65234375,90.946075439453)},
	{pos1=Vector(-3070.2607421875,6911.96875,701.27185058594),pos2=Vector(-2555.7124023438,7422.80078125,537.78503417969)},
	{pos1=Vector(-2560.0104980469,7424.03125,960.01470947266),pos2=Vector(-1695.1706542969,6911.4643554688,7.2892303466797)},
	{pos1=Vector(-2176.0329589844,8400.03125,129.7216796875),pos2=Vector(-2950.7553710938,7424.03125,696.08056640625)},
	{pos1=Vector(-2711.6499023438,8240.423828125,832.31622314453),pos2=Vector(-2420.919921875,8569.693359375,128.03125)},
	{pos1=Vector(9023.96875,3455.7419433594,895.12249755859),pos2=Vector(10239.594726563,2559.96875,-103.05026245117)},
	{pos1=Vector(10367.870117188,2815.96875,638.83184814453),pos2=Vector(10624.595703125,2281.4523925781,89.867523193359)},
	{pos1=Vector(10621.84765625,768.26281738281,640.03125),pos2=Vector(9023.44921875,2304.4099121094,-103.96874237061)},
	{pos1=Vector(7999.462890625,383.96875,-104.19367218018),pos2=Vector(7168.263671875,2432.03125,-103.21199798584)},
	{pos1=Vector(6592.490234375,384.05541992188,1024.03125),pos2=Vector(7198.490234375,1022.2788696289,425.7282409668)},
	{pos1=Vector(6592,1024.1011962891,775.76483154297),pos2=Vector(7171.2993164063,1756.4697265625,-53.389465332031)},
	{pos1=Vector(6591.96875,1727.5611572266,126.72430419922),pos2=Vector(7165.728515625,2304.03125,-103.81815338135)},
	{pos1=Vector(6224.162109375,384.03125,639.59564208984),pos2=Vector(7232.8095703125,-129.33065795898,-103.96875762939)},
	{pos1=Vector(6207.96875,-1024.6794433594,319.86169433594),pos2=Vector(7233.7602539063,-2562.7888183594,-167.96875)},
	{pos1=Vector(5823.96875,-4097.9306640625,-127.32067871094),pos2=Vector(6720.6469726563,-4737.271484375,-320)},
	{pos1=Vector(766.95568847656,-5631.96875,-318.70587158203),pos2=Vector(-480.03125,-7167.53515625,104.69101715088)},
	{pos1=Vector(12309.478515625,-12227.966796875,-282.80767822266),pos2=Vector(12992.974609375,-14049.530273438,-664.99975585938)},
	{pos1=Vector(12417.127929688,-12800.03125,-287.02062988281),pos2=Vector(12864.030273438,-12352.088867188,-133.41580200195)},
	{pos1=Vector(12799.54296875,-12352,-133.02360534668),pos2=Vector(12483.458984375,-12733.840820313,-14.755773544312)},
	{pos1=Vector(12975.90625,-13280.212890625,-151.96873474121),pos2=Vector(12735.96875,-13615.360351563,-284.24633789063)},
	{pos1=Vector(12543.8828125,-13615.823242188,-151.96876525879),pos2=Vector(12304.306640625,-13279.969726563,-286.52856445313)},
	{pos1=Vector(5312.03125,1343.5910644531,-103.62471008301),pos2=Vector(4608.8696289063,639.96875,397.19879150391)},
	{pos1=Vector(5311.607421875,-128.03048706055,783.2763671875),pos2=Vector(4413.9208984375,512.25,-99.5458984375)},
	{pos1=Vector(4223.845703125,832.03302001953,1039.8742675781),pos2=Vector(3456,-321.37615966797,-100.17596435547)},
	{pos1=Vector(3681.6579589844,-1280.5004882813,-137.76121520996),pos2=Vector(2368.0490722656,-2304,256.3268737793)},
	{pos1=Vector(1919.7425537109,-1023.9702148438,334.18383789063),pos2=Vector(1024.7121582031,-2049.1120605469,-106.41226959229)},
	{pos1=Vector(1695.0661621094,-2304.0314941406,334.68011474609),pos2=Vector(1245.1716308594,-2048.03125,-107.62802124023)},
	{pos1=Vector(-224.87380981445,-1183.96875,327.74960327148),pos2=Vector(-1760.0368652344,-2431.9926757813,-95.277954101563)},
	{pos1=Vector(-2911.939453125,-2112.03125,-93.83056640625),pos2=Vector(-3680.03125,-1088.2406005859,286.69885253906)},
	{pos1=Vector(-5897.3759765625,-3061.2600097656,-80.145240783691),pos2=Vector(-6652.302734375,-2569.7502441406,-320)},
	{pos1=Vector(-6647.1997070313,-3591.96875,-87.559585571289),pos2=Vector(-5895.966796875,-4087.9897460938,-310.41760253906)},
	{pos1=Vector(-7173.4418945313,-4088.03125,-123.44192504883),pos2=Vector(-7924.5180664063,-3590.109375,-319.99996948242)},
	{pos1=Vector(-7930.6801757813,-3064.03125,-86.543273925781),pos2=Vector(-7175.9692382813,-2570.1936035156,-312.39532470703)},
	{pos1=Vector(-7682.5317382813,1344.5611572266,-39.96875),pos2=Vector(-6661.1499023438,1852.333984375,192.03125)},
	{pos1=Vector(-6494.6625976563,1504.8818359375,270.51962280273),pos2=Vector(-6336.7431640625,1151.96875,-30.489776611328)},
	{pos1=Vector(-6338.6298828125,1150.7067871094,-32),pos2=Vector(-5532.126953125,1832.564453125,248.98486328125)},
	{pos1=Vector(-5119.5991210938,1856.03125,269.67608642578),pos2=Vector(-2943.96875,1139.8581542969,-101.33551025391)},
	{pos1=Vector(-2943.96875,1139.3552246094,-94.398315429688),pos2=Vector(-3665.3090820313,767.96875,248.47636413574)},
	{pos1=Vector(-3527.4665527344,-71.391540527344,200.52981567383),pos2=Vector(-2947.0935058594,449.98492431641,-96)},
	{pos1=Vector(-193.34600830078,-127.4846496582,528.03125),pos2=Vector(-832.97937011719,640.35278320313,-103.96876525879)},
	{pos1=Vector(-832.4716796875,320.42791748047,525.8154296875),pos2=Vector(-1025.1774902344,-131.89753723145,-103.96876525879)},
	{pos1=Vector(-1023.2177124023,-128.73779296875,-103.96876525879),pos2=Vector(-1663.970703125,640.03009033203,143.708984375)},
	{pos1=Vector(-176.14254760742,832,-102.9561920166),pos2=Vector(-1024.03125,1221.1666259766,719.8798828125)},
	{pos1=Vector(-1024.03125,1220.4523925781,719.84924316406),pos2=Vector(-304,1631.7927246094,-102.56732177734)},
	{pos1=Vector(-192.16369628906,1632.2061767578,720.03735351563),pos2=Vector(-1025.8081054688,2047.3602294922,-103.96875)},
	{pos1=Vector(-176,2048.3376464844,543.31695556641),pos2=Vector(-2056.3583984375,3463.6604003906,-103.96875762939)},
	{pos1=Vector(-2048.0534667969,2812.2856445313,544),pos2=Vector(-1280.4517822266,3456.0307617188,783.23699951172)},
	{pos1=Vector(-1507.0433349609,3284.0310058594,785.25665283203),pos2=Vector(-1768.03125,3116.5380859375,909.44494628906)},
	{pos1=Vector(-1279.96875,3264.1975097656,704.50561523438),pos2=Vector(-1152.03125,3070.6611328125,541.01910400391)},
	{pos1=Vector(-1152.1441650391,3263.8232421875,704.03125),pos2=Vector(-383.96875,2368.1245117188,533.41119384766)},
	{pos1=Vector(-2560.306640625,5248.03125,639.30432128906),pos2=Vector(-2687.0944824219,4671.96875,-87.841636657715)},
	{pos1=Vector(-2688,4351.7763671875,-105.52177429199),pos2=Vector(-3839.9411621094,5504.03125,639.28759765625)},
	{pos1=Vector(-3841.7797851563,3712,329.0696105957),pos2=Vector(-4093.1970214844,3069.5886230469,-22.884338378906)},
	{pos1=Vector(-4095.9577636719,2943.6013183594,-35.108901977539),pos2=Vector(-5248.03125,3967.0361328125,343.69842529297)},
	{pos1=Vector(-4099.6748046875,4227.4770507813,512.03125),pos2=Vector(-5246.3564453125,5140.6196289063,-14.177772521973)},
	{pos1=Vector(-3839.96875,5760.4965820313,511.36010742188),pos2=Vector(-4981.626953125,7168.7333984375,-24.55033493042)},
	{pos1=Vector(-3264.5678710938,6655.96875,639.42645263672),pos2=Vector(-3840.7414550781,7168.03125,128.96774291992)},
	{pos1=Vector(-3840.5979003906,7168.03125,1022.9105834961),pos2=Vector(-4477.828125,6655.96875,513.14080810547)},
	{pos1=Vector(-4991.6328125,7167.96875,767.32177734375),pos2=Vector(-4441.3471679688,7560.11328125,542.77947998047)},
	{pos1=Vector(-4479.96875,7359.1176757813,769.48175048828),pos2=Vector(-3648,7808.4248046875,128.82565307617)},
	{pos1=Vector(-4477.3090820313,8191.56640625,768.03125),pos2=Vector(-4095.96875,7808.0629882813,128.63903808594)},
	{pos1=Vector(-4478.826171875,8831.205078125,768.03125),pos2=Vector(-3647.0456542969,8191.708984375,128.03125)},
	{pos1=Vector(-9596.9853515625,768.03125,762.83953857422),pos2=Vector(-8575.0966796875,-126.87984466553,-39.96875)},
	{pos1=Vector(-9598.33203125,1599.6677246094,576.03125),pos2=Vector(-8893.0107421875,768.03125,-31.792724609375)},
	{pos1=Vector(-9600.3125,1601.40625,640.03125),pos2=Vector(-10239.7265625,2305.5732421875,0.03125)},
	{pos1=Vector(-10749.034179688,2049.2861328125,640.03125),pos2=Vector(-10364.669921875,3071.96875,4.0887680053711)},
	{pos1=Vector(-10239.83984375,2688.7333984375,640.03125),pos2=Vector(-9599.96875,3327.9482421875,448.11413574219)},
	{pos1=Vector(-9599.9296875,2943.96875,446.81582641602),pos2=Vector(-8703.3291015625,3585.5598144531,-39.96875)},
	{pos1=Vector(-8384.7958984375,2561.0864257813,768.03125),pos2=Vector(-8834.5390625,2943.96875,0.85574340820313)},
	{pos1=Vector(-8127.96875,2944.4118652344,767.77648925781),pos2=Vector(-8801.5869140625,3586.5900878906,-15.784164428711)},
	{pos1=Vector(-8703.96875,3586.3425292969,447.9104309082),pos2=Vector(-9718.1923828125,5070.7802734375,-284.69882202148)},
	{pos1=Vector(-8831.96875,3963.4155273438,456.24237060547),pos2=Vector(-6518.7841796875,7520.1337890625,45.98458480835)},
	{pos1=Vector(-6143.96875,3968.6901855469,669.92309570313),pos2=Vector(-7042.9028320313,5118.9184570313,576.03125)},
	{pos1=Vector(-6976.03125,2945.4582519531,767.99755859375),pos2=Vector(-6144,3584.4838867188,-35.160598754883)},
	{pos1=Vector(-6559.96875,3774.5317382813,767.76208496094),pos2=Vector(-6833.4877929688,3584.40234375,-39.96875)},
	{pos1=Vector(8127.59375,3455.1760253906,512.03125),pos2=Vector(7422.5366210938,2558.6032714844,-104)},
	{pos1=Vector(7295.5434570313,3454.9521484375,704.03125),pos2=Vector(6887.2202148438,2558.1789550781,-103.99996948242)},
	{pos1=Vector(6911.7666015625,3070.6022949219,704.03125),pos2=Vector(6663.5141601563,2553.5012207031,-104)},
	{pos1=Vector(6663.3217773438,2559.96875,702.25836181641),pos2=Vector(6205.2080078125,3263.9187011719,-55.974182128906)},
	{pos1=Vector(-12960.03125,-10495.881835938,127.56800842285),pos2=Vector(-11648.266601563,-9471.96875,-307.02108764648)},
}
local function fixvector(v1,v2)
    if v1.z > v2.z then
        v1.z = v1.z/2
        v2.z = 0
    else
        v2.z = v2.z/2
        v1.z = 0
    end
end
for k, v in pairs(testboxes) do
   fixvector(v.pos1,v.pos2)
end

for _, v in ipairs( testboxes ) do
	OrderVectors( v.pos1, v.pos2 )
end

local Blips = {}

paris.GlobalScale = 0.1

timer.Create("GtaHUDAutoRefresh", 0.25, 0, function()
    if paris.HUDMaps then
        for k, v in pairs(paris.HUDMaps) do
            if v.Map == game.GetMap() then
                if !v.UseZones or !IsValid(LocalPlayer()) then
                    if paris.Zone != k then
                        paris.Mat = Material(v.Material..".png","smooth 1")
                    end
                    paris.Zone = "*"
                    if v.Zoom then
                        paris.HUDZoom = v.Zoom
                    else
                        paris.HUDZoom = 1
                    end
                    paris.Scale = v.Scale
                    paris.ScaleX, paris.ScaleY = v.ScaleX, v.ScaleY
                    paris.Translate = v.Translate
                else
                    for k, v in pairs(v.Zones) do
                        if k != "MAIN" then
                            for _, vectors in pairs(v.InsideZones) do
                                if LocalPlayer():GetPos():WithinAABox(vectors[1],vectors[2]) then
                                    if paris.Zone != k then
                                        paris.Mat = Material(v.Material..".png","smooth 1")
                                    end
                                    paris.Zone = k
                                    if v.Zoom then
                                        paris.HUDZoom = v.Zoom
                                    else
                                        paris.HUDZoom = 1
                                    end
                                    paris.Scale = v.Scale
                                    paris.ScaleX, paris.ScaleY = v.ScaleX, v.ScaleY
                                    paris.Translate = v.Translate
                                    break
                                end
                            end
                        else
                            if paris.Zone != k then
                                paris.Mat = Material(v.Material..".png","smooth 1")
                            end
                            paris.Zone = k
                            if v.Zoom then
                                paris.HUDZoom = v.Zoom
                            else
                                paris.HUDZoom = 1
                            end
                            paris.Scale = v.Scale
                            paris.ScaleX, paris.ScaleY = v.ScaleX, v.ScaleY
                            paris.Translate = v.Translate
                        end
                    end
                end
            end
        end
    end
end)

function paris:LoadHUD()
    if IsValid(paris.HUDPanel) then paris.HUDPanel:Remove() end
    paris.HUDPanel = vgui.Create("DPanel")
    hook.Add("Think", "GTAHudPanelHider", function()
        if GAMEMODE.Options_DrawHUD:GetInt() == 0 or GAMEMODE.DoNotDrawHUD or GAMEMODE.Options_UseBasicHUD:GetInt() == 1 then 
            paris.HUDPanel:Hide()
        else
            paris.HUDPanel:Show()
        end
    end)
    paris.HUDPanel:SetSize(300,200)
    paris.HUDPanel:SetPos(25,ScrH()-25)
    local OutLine = Material("paris/hudoutlinehd.png")
    paris.HUDColor = Color(255,255,255,200)
    function paris.HUDPanel:Paint(w,h)
        
        if paris.Maximized then
            paris.HUDPanel:SetSize(600,600)
            paris.HUDPanel:SetPos(25,ScrH()-(600+25))
        else
            paris.HUDPanel:SetSize(300,200)
            paris.HUDPanel:SetPos(25,ScrH()-25)
        end

        local x, y = self:LocalToScreen( 0, 0 )

        local Fraction = 1.9 * (40/100)

        local matBlurScreen = Material( "pp/blurscreen" )
        surface.SetMaterial( matBlurScreen )
        surface.SetDrawColor( 255, 255, 255, 255 )

        for i=0.33, 1, 0.33 do
            matBlurScreen:SetFloat( "$blur", Fraction * 5 * i )
            matBlurScreen:Recompute()
            if ( render ) then render.UpdateScreenEffectTexture() end -- Todo: Make this available to menu Lua
            surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )
        end

        surface.SetDrawColor( 100, 100, 100, 0 )
        surface.DrawRect( x * -1, y * -1, ScrW(), ScrH() )

        local safezone = GAMEMODE.Options_SafeZone:GetInt()
        paris.HUDPanel:SetPos(safezone,ScrH()-(h+safezone))

        DisableClipping(true)
        surface.SetMaterial(OutLine)
        surface.SetDrawColor(0, 0, 0, 200)
        local x,y = 0,0
        local safezonex = (25*w)/300
        local safezoney = (25*h)/200
        surface.DrawTexturedRect((safezonex*-1), safezoney*-1, w+(safezonex*2), h+(safezoney*2))
        DisableClipping(false)

    end




    --[[                 LERP System                 ]]
    -- This interpolates when you enter/exit vehicles

    local CarLerpAng = 0
    local MainAngInfluence = 90
    local CamHeightLerp = 0
    local CamHeightInfluence = 5000
    local ForwardLerp = 100
    local ForwardLerpInfluence = 100
    local FOVLerp = 0
    local FOVLerpInfluence = 0
    local HudZoom = 1
    paris.HUDZoom = 1 -- This one is the influence
    local HealthAlphaLERP = 0
    local HealthAlphaLERPInfluence = 0

    -- 3d
    local lookang
    local campos
    local fov

    local mapmin,mapmax = game.GetWorld():GetModelBounds()
    local mapx = mapmax.x-mapmin.x
    local mapy = mapmax.y-mapmin.y

    hook.Add("PARIS_DamageTaken", "AddBloodStainToRadar", function(amount)
        HealthAlphaLERP = amount
    end)

    if IsValid(LocalPlayer()) and IsValid(LocalPlayer():GetVehicle()) then
        MainAngInfluence = 28
        CamHeightInfluence = 3000
        ForwardLerpInfluence = 400
    end

    function PlayerEnteredVehicle()
        MainAngInfluence = 28
        CamHeightInfluence = 3000
        ForwardLerpInfluence = 400
    end

    function PlayerLeaveVehicle()
        CamHeightInfluence = 5000
        ForwardLerpInfluence = 100
    end

    net.Receive("PlayerEnteredVehicle", PlayerEnteredVehicle)
    net.Receive("PlayerLeaveVehicle", PlayerLeaveVehicle)

    --[[                LOWER HUD                ]]
    --            The Health/Ammo Boxes

    local PointA = 100
    local PointB = 100
    local TimeSince = CurTime()
    hook.Add("PARIS_DamageTaken", "AddBloodStainToHealth", function(taken, healthbefore)
        PointA = healthbefore - taken
        PointB = healthbefore
        TimeSince = CurTime()
    end)


    paris.HUDPanelOverlay = vgui.Create("DPanel", paris.HUDPanel)
    paris.HUDPanelOverlay:SetSize(paris.HUDPanel:GetWide(),paris.HUDPanel:GetTall())
    paris.HUDPanelOverlay:SetPos(0,0)
    paris.HUDPanelOverlay.GradientRight = Material( "paris/gradient_right.png" )
    local BloodSplash = Material("paris/bloodinside.png")
    local BottomColor = Color(5,5,5,220)
    local HealthBackground = Color(47, 81, 51,255)
    local HealthColor = Color(85, 153, 79,255)
    local HealthLowBackground = Color(95, 9, 13,255)
    local ArmorBackground = Color(17, 53, 75,255)
    local ArmorColor = Color(109, 191, 227,255)
    local StaminaBackground = Color(185, 153, 70,50)
    local StaminaColor = Color(185, 153, 70,255)
    function paris.HUDPanelOverlay:Paint(w,h)

        self:SetSize(paris.HUDPanel:GetWide(),paris.HUDPanel:GetTall())
        // Bottom shit
        draw.RoundedBox(0, 0, h-23, w, 23, BottomColor)

        if IsValid(LocalPlayer()) then

            local health = math.Clamp(LocalPlayer():Health(), 0, 100)
            if health > 30 then
                draw.RoundedBox(0, 0, self:GetTall()-18, (w/2)-2, 10, HealthBackground)
                draw.RoundedBox(0, 0, self:GetTall()-18, ((w/2)-2) * (health/100), 10, HealthColor)
            else
                draw.RoundedBox(0, 0, self:GetTall()-18, (w/2)-2, 10, HealthLowBackground)
                draw.RoundedBox(0, 0, self:GetTall()-18, ((w/2)-2) * (health/100), 10, Color(165, 33, 44,255*math.abs(math.sin(CurTime()*5))))
            end

            surface.SetMaterial(paris.HUDPanelOverlay.GradientRight)
            surface.SetDrawColor(150, 20, 20, 255-((CurTime()-TimeSince)*255))
            surface.DrawTexturedRect(((w/2)-2) * (health/100), self:GetTall()-18, PointA-PointB, 10)

            surface.SetMaterial(BloodSplash)
            local HealthAlpha = (HealthAlphaLERP*-1)
            if HealthAlpha > 10 then
                HealthAlpha = 10
            end
            surface.SetDrawColor(255, 50, 50, (HealthAlpha*40))
            surface.DrawTexturedRect( 0, 0, w,h - 18 )

            local armor = math.Clamp(LocalPlayer():Armor(), 0, 100)
            draw.RoundedBox(0, (w/2)+2, h-18, (w/2)-2, 10, ArmorBackground)
            draw.RoundedBox(0, (w/2)+2, h-18, ((w/2)-2) * (armor/100), 10, ArmorColor)

            // Add Stamina-Support here
            local stamina = 0
            local supported = false
            if LocalPlayer().Stamina then // PERP Stamina
                stamina = math.Clamp(LocalPlayer().Stamina, 0, 100)
                supported = true
            end

            if supported then
                draw.RoundedBox(0, 2, self:GetTall()-5, (self:GetWide())-4, 3, StaminaBackground)
                draw.RoundedBox(0, 2, self:GetTall()-5, ((self:GetWide())-4) * (stamina/100), 3, StaminaColor)
            end

        end
    end



    --[[                BLIPS                ]]
    --       The entire system for blips

    if IsValid(paris.HUDBlipOverlay) then paris.HUDBlipOverlay:Remove() end
    paris.HUDBlipOverlay = vgui.Create("DPanel")
    paris.HUDBlipOverlay:SetSize(paris.HUDPanel:GetWide(),paris.HUDPanel:GetTall())
    paris.HUDBlipOverlay:SetPos(0,0)

    local halfcircle = Material("paris/blips/halfcircle.png")
    local Lerp = Lerp

    function paris.HUDBlipOverlay:Paint()

        if !IsValid(LocalPlayer()) then return end
        if GAMEMODE.Options_DrawHUD:GetInt() == 0 or GAMEMODE.Options_UseBasicHUD:GetInt() == 1 then return end
        if GAMEMODE.DoNotDrawHUD then return end

        local ScreenWide = ScrW()
    
        -- 2d
        local scrw,scrh = ScrW(), ScrH()
        local w,h = paris.HUDPanel:GetSize()
        h = h - 23
        local x,y = paris.HUDPanel:GetPos()
    
        if IsValid(LocalPlayer()) then
    
            if IsValid(LocalPlayer():GetVehicle()) then
                MainAngInfluence = 28
                CamHeightInfluence = 3000
                ForwardLerpInfluence = 400
            elseif not IsValid(LocalPlayer():GetVehicle()) then
                MainAngInfluence = 90
                CamHeightInfluence = 5000
                ForwardLerpInfluence = 100
            end
    
            -- Soo much LERP :I
    
            CarLerpAng = Lerp( 4 * FrameTime() , CarLerpAng , MainAngInfluence)
            CamHeightLerp = Lerp( 4 * FrameTime() , CamHeightLerp , CamHeightInfluence)
            ForwardLerp = Lerp( 4 * FrameTime() , ForwardLerp , ForwardLerpInfluence)
            FOVLerp = Lerp( 4 * FrameTime() , FOVLerp , FOVLerpInfluence)
            HealthAlphaLERP = Lerp( 4 * FrameTime() , HealthAlphaLERP , HealthAlphaLERPInfluence)
            HudZoom = Lerp( 4 * FrameTime() , HudZoom , paris.HUDZoom)
    
            fov = math.Clamp(60+FOVLerp, 0, 140 )
    
            local MaximizeZoom = 1
            if paris.Maximized then
                MaximizeZoom = 3
            end
    
    
            --[[     CAMERA CONTROLLER     ]]--
    
            local plypos = LocalPlayer():GetPos()
            local plyang = LocalPlayer():EyeAngles()
            local plyeyeang = LocalPlayer():EyeAngles()
    
            local OfficialLookAng = Angle(0,0,0)
            local CamPos = Vector(0,0,0)
    
            if LocalPlayer():InVehicle() then
    
                if LocalPlayer():InVehicle() then
                    plyang = plyang + LocalPlayer():GetAngles() + Angle(0,-90,0)
                    FOVLerpInfluence = (LocalPlayer():GetVehicle():GetVelocity():Length()/120)
                else
                    FOVLerpInfluence = math.abs(LocalPlayer():GetVelocity():Length()/60)
                end
    
                CamPos = (Vector(plypos.x,plypos.y,CamHeightLerp*HudZoom*MaximizeZoom)-(Angle(0,plyang.y,0):Forward()*ForwardLerp*HudZoom*MaximizeZoom*11))
            else
                FOVLerpInfluence = math.abs(LocalPlayer():GetVelocity():Length()/60)
                CamPos = ((Vector(plypos.x,plypos.y,CamHeightLerp*HudZoom*MaximizeZoom))+(Angle(0,plyang.y,0):Forward()*ForwardLerp*HudZoom*8))
            end
    
            OfficialLookAng = Angle(CarLerpAng,plyang.y,0) 
    
            lookang = OfficialLookAng
    
            campos = CamPos
    
        end
    
        cam.Start({
            x = x,
            y = y,
            w = w,
            h = h,
            type = "3D",
            origin = campos,
            angles = lookang,
            fov = fov,
            aspect = (w/h),
            subrect = true, -- Maybe idk
            zfar = 1000000,
        })
    
            for k, v in pairs(Blips or {}) do
                local initial = Vector(0,0,0)
                if isvector(v.VectorOrEntity) then
                    initial = v.VectorOrEntity
                elseif isentity(v.VectorOrEntity) and IsValid(v.VectorOrEntity) then
                    initial = v.VectorOrEntity:GetPos()
                end
                initial.z = 0 -- We don't want z value :P
                local Pos = LocalToWorld(initial, Angle(), Vector(0,0,0), Angle(0,0,0))
                local Output = Pos:ToScreen()
                if k == "LocalPlayer" then
                    Blips[k].x = ScreenWide/2
                else
                    Blips[k].x = Lerp( 120 * FrameTime() , Blips[k].x , Output.x)
                end
                Blips[k].y = Lerp( 120 * FrameTime() , Blips[k].y , Output.y)
            end
    
            if paris.Mat then
                render.SetMaterial(paris.Mat)
            end

            if not paris.Translate then
                paris.Translate = Vector(0,0,0)
            end

            render.DrawQuadEasy(Vector(0,0,0) + paris.Translate, Vector(0,0,1), mapx*(paris.Scale or 1)*(paris.ScaleX or 0), mapy*(paris.Scale or 1)*(paris.ScaleY or 0), paris.HUDColor, 90)

            render.SetColorMaterial()
            for k, v in pairs(testboxes or {}) do
                render.DrawBox(Vector(0,0,0) + paris.Translate, Angle(0,0,0), v.pos1*(paris.Scale or 1)*(paris.ScaleX or 0), v.pos2*(paris.Scale or 1)*(paris.ScaleY or 0), Color(85,85,85,255), 90)
            end
    
        cam.End3D()

        paris.HUDBlipOverlay:SetPos(x,y)
        paris.HUDBlipOverlay:SetSize(paris.HUDPanel:GetWide(),paris.HUDPanel:GetTall())

        for k, v in pairs(Blips) do

            if !isvector(v.VectorOrEntity) and !IsValid(v.VectorOrEntity) then 
                Blips[k] = nil
                return 
            end

            local function DrawBlip()

                if IsValid(v.VectorOrEntity) and (v.VectorOrEntity:IsPlayer()) then
                    v.FadeDist = 4000
                end
                if v.VectorOrEntity == LocalPlayer() then
                    v.FadeDist = nil
                end
                local DrawOthers = true
                if not DrawOthers and isentity(v.VectorOrEntity) and (v.VectorOrEntity:IsPlayer() or (v.VectorOrEntity.IsBot and v.VectorOrEntity:IsBot())) then 
                    if v.VectorOrEntity != LocalPlayer() then return end
                end

                if v.FadeDist then
                    local dist = 0
                    local OurVector = Vector(LocalPlayer():GetPos().x,LocalPlayer():GetPos().y,0)
                    if isvector(v.VectorOrEntity) then
                        dist = math.Distance(OurVector.x, OurVector.y, v.VectorOrEntity.x, v.VectorOrEntity.y)
                    elseif isentity(v.VectorOrEntity) then
                        dist = math.Distance(OurVector.x, OurVector.y, v.VectorOrEntity:GetPos().x, v.VectorOrEntity:GetPos().y)
                    end
                    v.LastDist = dist
                    surface.SetDrawColor(v.col.r,v.col.g,v.col.b, (v.FadeDist - dist))
                else
                    surface.SetDrawColor(v.col.r,v.col.g,v.col.b,v.col.a)
                end

                if (IsValid(v.VectorOrEntity) and v.VectorOrEntity:IsPlayer() or (v.VectorOrEntity.IsBot and v.VectorOrEntity:IsBot())) and v.VectorOrEntity:GetNWInt("WantedLevel") != 0 and v.VectorOrEntity != LocalPlayer() then
                    surface.SetDrawColor(240,0,0,v.col.a)
                end

                local RatX = v.x/ScrW()
                local RatY = v.y/ScrH()
                local x = (RatX*paris.HUDPanel:GetWide())
                if x > paris.HUDPanel:GetWide() then
                    x = paris.HUDPanel:GetWide()
                elseif x < 0 then
                    x = 0
                end
                local y = (RatY*(paris.HUDPanel:GetTall()-17))
                if y > paris.HUDPanel:GetTall() - (v.Scale) then
                    y = paris.HUDPanel:GetTall() - (v.Scale)
                elseif y < (v.Scale)*-0.1 then
                    y = (v.Scale)*-0.1
                end
    
                local Rot = 0
    
                if v.followang then
                    if IsValid(v.VectorOrEntity) and v.VectorOrEntity:IsPlayer() or (v.VectorOrEntity.IsBot and v.VectorOrEntity:IsBot()) then
                        if IsValid(v.VectorOrEntity:GetVehicle()) and v.VectorOrEntity != LocalPlayer() then
                            Rot = (LocalPlayer():EyeAngles().y*-1) + v.VectorOrEntity:GetVehicle():GetAngles().y + 90
                        elseif IsValid(v.VectorOrEntity:GetVehicle()) and v.VectorOrEntity == LocalPlayer() then
                            Rot = (LocalPlayer():EyeAngles().y*-1) + 90
                        elseif IsValid(LocalPlayer():GetVehicle()) then
                            Rot = v.VectorOrEntity:EyeAngles().y - LocalPlayer():EyeAngles().y - LocalPlayer():GetVehicle():GetAngles().y
                        else
                            Rot = v.VectorOrEntity:EyeAngles().y - LocalPlayer():EyeAngles().y
                        end
                    elseif (IsValid(v.VectorOrEntity)) then
                        if IsValid(LocalPlayer():GetVehicle()) then
                            Rot = v.VectorOrEntity:EyeAngles().y - LocalPlayer():EyeAngles().y - LocalPlayer():GetVehicle():GetAngles().y
                        else
                            Rot = v.VectorOrEntity:EyeAngles().y - LocalPlayer():EyeAngles().y
                        end
                    end
                end

                if v.Spinning then
                    Rot = CurTime()*540
                end

                local doDraw = true
                local drawCount = false
                local count = 1

                if (IsValid(v.VectorOrEntity) and v.VectorOrEntity:IsPlayer() or (v.VectorOrEntity.IsBot and v.VectorOrEntity:IsBot())) and v.VectorOrEntity:GetColor().a < 10 then return end

                if v.followang and IsValid(v.VectorOrEntity) and v.VectorOrEntity:IsPlayer() and IsValid(v.VectorOrEntity:GetVehicle()) and IsValid(v.VectorOrEntity:GetVehicle():GetParent()) then
					if not (IsValid(LocalPlayer():GetVehicle()) and LocalPlayer():GetVehicle() == v.VectorOrEntity:GetVehicle()) then
                    	-- There vehicle is a seat DO NOT DRAW IT, the main draws it
                    	doDraw = false
                    end
                elseif v.followang and IsValid(v.VectorOrEntity) and v.VectorOrEntity:IsPlayer() and IsValid(v.VectorOrEntity:GetVehicle()) then
                    -- First we check if the vehicle has seat children
                    if LocalPlayer() == v.VectorOrEntity then
                        drawCount = false
                    else
                        for _, child in pairs(v.VectorOrEntity:GetVehicle():GetChildren()) do
                            if IsValid(child) and child:IsVehicle() then
                                for _, ply in pairs(player.GetAll()) do
                                    if ply:GetVehicle() == child then
                                        if not (IsValid(LocalPlayer()) or IsValid(v.VectorOrEntity)) then return end
                                        drawCount = true
                                        Rot = v.VectorOrEntity:GetAngles().y - LocalPlayer():EyeAngles().y - LocalPlayer():GetVehicle():GetAngles().y
                                        count = count + 1
                                    end
                                end
                            end
                        end
                    end
                end
                -- the case if there is a car with no driver but passengers
                if v.followang and IsValid(v.VectorOrEntity) and v.VectorOrEntity:IsPlayer() and IsValid(v.VectorOrEntity:GetVehicle()) and IsValid(v.VectorOrEntity:GetVehicle():GetParent()) then
                    local veh = v.VectorOrEntity:GetVehicle():GetParent()
                    local driverValid = false
                    for _, ply in pairs(player.GetAll()) do
                        if ply:GetVehicle() == veh then -- if theres a driver then we stop
                            driverValid = true
                        end
                    end
                    if !driverValid then
                        doDraw = true
                    end
                end


                if doDraw then
                    DisableClipping(true)
                        local color = surface.GetDrawColor()
                        surface.SetDrawColor(51, 255, 238, color.a)
                        surface.SetMaterial(halfcircle)

                        if IsValid(v.VectorOrEntity) and isentity(v.VectorOrEntity) and v.VectorOrEntity:IsPlayer() and v.VectorOrEntity:GetFriendStatus() == "friend" and v.VectorOrEntity != LocalPlayer() then
                            surface.DrawTexturedRectRotated( x, y, v.Scale * 1.0, v.Scale * 1.0, 0 )
                        end

                        surface.SetDrawColor(color.r, color.g, color.b, color.a)
                        surface.SetMaterial(v.Mat)

                        surface.DrawTexturedRectRotated( x, y, v.Scale, v.Scale, Rot )
                        if drawCount then
                            draw.SimpleText(count, "DermaDefault", x, y - 1, Color(0,0,0,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                        end
                    DisableClipping(false)
                end

            end


            local DrawOnlySeen = true
            if IsValid(v.VectorOrEntity) and isentity(v.VectorOrEntity) and DrawOnlySeen and v.VectorOrEntity != LocalPlayer() and !v.AlwaysThruWalls then
                local trace = {}
                trace.start = LocalPlayer():GetShootPos()
                trace.endpos = v.VectorOrEntity:GetPos() + Vector(0,0,10)
                if v.VectorOrEntity:IsPlayer() or (v.VectorOrEntity.IsBot and v.VectorOrEntity:IsBot()) then
                    trace.endpos = v.VectorOrEntity:GetShootPos()
                end
                trace.filter = {LocalPlayer(), v.VectorOrEntity}
                if v.GetVehicle and IsValid(v:GetVehicle()) then 
                    table.insert(trace.filter, v.VectorOrEntity:GetVehicle()) 
                end
                if IsValid(LocalPlayer():GetVehicle()) then 
                    table.insert(trace.filter, LocalPlayer():GetVehicle()) 
                end
                local tr = util.TraceLine( trace )
                if (!tr.Hit) and (v.Zone=="*" or v.Zone==paris.Zone) then
                    DrawBlip()
                end
            elseif (v.Zone=="*" or v.Zone==paris.Zone) then
                DrawBlip()
            end
            if !IsValid(v.VectorOrEntity) and !isvector(v.VectorOrEntity) then Blips[k] = nil end
        end


    end

    function AddMapBlip(Mat,VectorOrEntity,ID,Scale,col,FadeDist,Zone,followang,AlwaysThruWalls,Spinning,MapConfigBlip)
        local x,y = 0,0
        if Blips[ID] and Blips[ID].x and Blips[ID].y then
            x,y = Blips[ID].x, Blips[ID].y
        end
        local matstr = Mat
        if not string.EndsWith(Mat, ".png") then
            matstr = Mat .. ".png"
        end
        Blips[ID] = {
            ID = ID,
            Mat = Material(matstr),
            VectorOrEntity = VectorOrEntity,
            Scale = Scale,
            col = col,
            followang = followang,
            FadeDist = FadeDist,
            Zone = Zone,
            AlwaysThruWalls = AlwaysThruWalls,
            x = x,
            y = y,
            MapConfigBlip = MapConfigBlip,
            Spinning = Spinning,
        }
        paris.Blips = Blips
        return Blips[ID]
    end

    for k, v in pairs(player.GetAll()) do
        if v != LocalPlayer() then
            AddMapBlip("paris/blips/playerblip.png",v,v:UniqueID(),25,color_white,4000,"*", true)
        end
    end

    hook.Add("Think", "PlayerZoneChanger", function()
        for _, blip in pairs(Blips) do
            if IsValid(blip.VectorOrEntity) and IsEntity(blip.VectorOrEntity) and blip.VectorOrEntity:IsPlayer() then
                for k, v in pairs(paris.HUDMaps or {}) do
                    if v.Map == game.GetMap() then
                        if not v.UseZones or not IsValid(LocalPlayer()) then
                            blip.Zone = "*"
                        else
                            for k, v in pairs(v.Zones) do
                                if k != "MAIN" then
                                    for _, vectors in pairs(v.InsideZones) do
                                        if blip.VectorOrEntity:GetPos():WithinAABox(vectors[1],vectors[2]) then
                                            blip.Zone = k
                                        end
                                    end
                                else
                                    blip.Zone = k
                                end
                            end
                        end
                    end
                end
            end
        end
    end)

    AddMapBlip("paris/blips/hudarrow.png",LocalPlayer(),"LocalPlayer", 25, color_white,true,"*", true, true)

    net.Receive("SendBlipsToClient", function()

        local tab = net.ReadTable()

        for k, v in pairs(tab) do // Set IDS
            tab[k].ID = k
        end

        paris.MapBlips = tab

        for k, v in pairs(Blips) do // Removes old ones
            if v.MapConfigBlip then
                Blips[k] = nil
            end
        end

        for k, v in pairs(tab) do // Adds the new config
            if !v.Scale then
                v.Scale = 30
            end
            AddMapBlip(v.Icon,Vector(v.Pos.x,v.Pos.y,v.Pos.z),k, v.Scale, v.Color or Color(255,255,255),v.FadeDistance,v.Zone or "*", false, true, false, true)
        end

        paris.Blips = Blips

    end)

    net.Receive("PARIS_AddBlipTOHUD", function()
        local data = net.ReadTable()
        local fadedist = 4000
        if data.FadeDist then
            fadedist = data.FadeDist
        end
        if data.VectorOrEntity == LocalPlayer() then return end
        if data.Mat == "_playerMaterial" then 
            data.Mat = "paris/blips/playerblip.png"
            data.Color = color_white
        end
        local blip = AddMapBlip(data.Mat,data.VectorOrEntity,data.ID, data.Scale, data.Color, fadedist,data.Zone, data.Follow)
        blip.TrueMat = data.Mat
    end)

    net.Receive("PARIS_RemoveBlipFROMHUD", function()
        local data = net.ReadTable()
        Blips[data.ID] = nil
    end)

    net.Start("RequestNewBlips")
    net.SendToServer()

    hook.Add("Think", "DeadDrawerThinker", function()
        for k, v in pairs(Blips or {}) do
            if IsValid(v.VectorOrEntity) and not v.VectorOrEntity:IsDormant() and isentity(v.VectorOrEntity) and v.VectorOrEntity:IsPlayer() or (IsValid(v.VectorOrEntity) and v.VectorOrEntity.IsBot and v.VectorOrEntity:IsBot()) then
                if v.VectorOrEntity:Alive() then
                    if v.OriginalMat then
                        v.Mat = v.OriginalMat
                        v.Scale = v.OriginalScale
                        v.OriginalMat = nil
                    end
                    if v.VectorOrEntity:GetPos().z - LocalPlayer():GetPos().z > 400 then
                        AddMapBlip("paris/blips/playerblip_higher",v.VectorOrEntity,"UpperLower"..v.VectorOrEntity:UniqueID(),25,color_white,4000,"*",false)
                        Blips["UpperLower"..v.VectorOrEntity:UniqueID()].x = Blips[v.VectorOrEntity:UniqueID()].x
                        Blips["UpperLower"..v.VectorOrEntity:UniqueID()].y = Blips[v.VectorOrEntity:UniqueID()].y
                    elseif v.VectorOrEntity:GetPos().z - LocalPlayer():GetPos().z < -400 then
                        AddMapBlip("paris/blips/playerblip_lower",v.VectorOrEntity,"UpperLower"..v.VectorOrEntity:UniqueID(),25,color_white,4000,"*",false)
                        Blips["UpperLower"..v.VectorOrEntity:UniqueID()].x = Blips[v.VectorOrEntity:UniqueID()].x
                        Blips["UpperLower"..v.VectorOrEntity:UniqueID()].y = Blips[v.VectorOrEntity:UniqueID()].y
                    else
                        Blips["UpperLower"..v.VectorOrEntity:UniqueID()] = nil
                    end
                else
                    if not v.OriginalMat then
                        v.OriginalMat = v.Mat
                        v.OriginalScale = v.Scale
                        v.Mat = Material("paris/blips/dead.png")
                        v.Scale = 16
                    end
                end
            end
        end
    end)

    --[[                FINISHED                ]]
    --       No, seriously thats everything

end

paris.Binds = {}

paris.Binds["MaximizeMap"] = {
    button = KEY_M,
    OnPush = function()
        paris.Maximized = true
    end,
    OnNotPush = function()
        paris.Maximized = false
    end
}

hook.Add("Think", "BindPressedCheck", function()
    if GAMEMODE.ChatBoxOpen then return end
    for k, v in pairs(paris.Binds) do
        if input.IsButtonDown(v.button) and !v.pressed and !gui.IsGameUIVisible() then
            v.pressed = true
            v.OnPush()
        elseif !input.IsButtonDown(v.button) and v.pressed then
            v.pressed = false
            v.OnNotPush()
        end
    end
end)

hook.Add("InitPostEntity", "LoadGTAHUD_Paris", function()
    
    local Health = LocalPlayer():Health()
    hook.Add("Think", "HealthDamageIsTaken", function()
        if LocalPlayer():Health() < Health then
            hook.Run("PARIS_DamageTaken", (LocalPlayer():Health() - Health), Health)
        end
        Health = LocalPlayer():Health()
    end)
    
    timer.Simple(5, function()
        paris:LoadHUD()
        paris.HUDLoadFromNowOn = true
    end)
end)

if paris.HUDLoadFromNowOn then
    paris:LoadHUD()
end