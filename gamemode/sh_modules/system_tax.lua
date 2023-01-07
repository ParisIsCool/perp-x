--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

function GM.GetTaxRate_Sales() return GetGNWVar( "tax_sales", 0 ) * 0.01 end
function GM.GetTaxRate_Income() return GetGNWVar( "tax_income", 0 ) * 0.01 end
function GM.GetTaxRate_Income_Text() return GetGNWVar( "tax_income", 0 ) .. "%" end
function GM.GetTaxRate_Sales_Text() return GetGNWVar( "tax_sales", 0 ) .. "%" end