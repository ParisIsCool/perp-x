--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

MIXTURE_DATABASE = MIXTURE_DATABASE or {}

local combineSound = Sound("buttons/button19.wav");

function GM:RegisterMixture( MixtureTable )
	
	if not MixtureTable.ID then return end 
	MixtureTable.Name = MixtureTable.Results

	if not MIXTURE_DATABASE[ MixtureTable.ID ] then
		--Msg( "\t-> Loaded " .. MixtureTable.Name .. "\n" )
	end
	
	MixtureTable.IngredientRefs = MixtureTable.Ingredients
	MixtureTable.Ingredients = {}
	
	for _, ref in pairs( MixtureTable.IngredientRefs ) do
		for id, item in pairs( ITEM_DATABASE ) do
			if item.Reference == ref then
				table.insert( MixtureTable.Ingredients, id )
			end
		end
	end
	MixtureTable.IngredientRefs = nil
	
	MixtureTable.ResultsRef = MixtureTable.Results
	MixtureTable.Results = nil
	
	for id, item in pairs( ITEM_DATABASE ) do
		if item.Reference == MixtureTable.ResultsRef then
			MixtureTable.Results = id
			MixtureTable.Name = item.Name
			break
		end
	end
	MixtureTable.ResultsRef = nil
		
	if not MixtureTable.Results then
		return Error( Format( "Mixture ID #%i %s missing result ID\n", MixtureTable.ID, MixtureTable.Name or "N/A" ) )
	end

	MIXTURE_DATABASE[ MixtureTable.ID ] = MixtureTable
end

function PLAYER:HasMixture( MixtureID )
	if MIXTURE_DATABASE[ MixtureID ].Free then return true end
	
	return util.tobool( string.find( self:GetPNWVar( "mixtures", "" ), tostring( MixtureID ) .. "-" ) )
end