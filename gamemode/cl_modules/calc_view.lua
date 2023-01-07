--[[///////////////////////////
//         P E R P X         //
//        2008 - 2022        //
///>/</>>/////</>/////<</>/<///
//  Honourably preserved by  //
//   Paris, Wheaty, Brad,    //
//     the aSocket Team.     //
//>>>>>>>>>>>>><<<<<<<<<<<<<<//
///////////////////////////--]]

function lookForVT( Vehicle )
	if IsValid( Vehicle ) then
		if not Vehicle.vehicleTable then
			for k, v in pairs( VEHICLE_DATABASE ) do
				for _, PJ in pairs( v.PaintJobs or {} ) do
					if string.lower( PJ.model ) == string.lower( Vehicle:GetModel() ) then
						
						Vehicle.vehicleTable = v
						break
					end
				end
				
				if Vehicle.vehicleTable then break end
			end
		end
	end
	
	return Vehicle.vehicleTable
end

function GM:CalcVehicleThirdPersonView( Vehicle, ply, origin, angles, fov )

	local view = {}
	
	if Vehicle.vehicleTable && Vehicle.vehicleTable.ViewAdjustments_FirstPerson && Vehicle.vehicleTable.ViewAdjustments_FirstPerson == VIEW_LOCK then
		view.angles		= ply:GetAimVector():Angle();
	else
		view.angles = angles;
	end
	
	view.fov 		= fov
	
	if ( !Vehicle.CalcView ) then
	
		Vehicle.CalcView = {}
		
		// Try to work out the size
		local min, max = Vehicle:WorldSpaceAABB()
		local size = max - min
		
		Vehicle.CalcView.OffsetUp = size.z
		Vehicle.CalcView.OffsetOut = (size.x + size.y + size.z) * 0.33
	
	end
	
	// Offset the origin
	local Up = view.angles:Up() * Vehicle.CalcView.OffsetUp * 0.66
	local Offset = view.angles:Forward() * -Vehicle.CalcView.OffsetOut
	
	if Vehicle.vehicleTable && Vehicle.vehicleTable.ViewAdjustments_ThirdPerson then
		Up = Up + Vehicle.vehicleTable.ViewAdjustments_ThirdPerson;
	end
	
	// Trace back from the original eye position, so we don't clip through walls/objects
	local TargetOrigin = Vehicle:GetPos() + Up + Offset
	local distance = origin - TargetOrigin
	
	local Filter = ents.FindByClass('prop_vehicle_prisoner_pod');
	table.insert(Filter, Vehicle);
	
	local trace = {
					start = origin,
					endpos = TargetOrigin,
					filter = Filter
				}
				  
				  
	local tr = util.TraceLine( trace ) 
	
	view.origin = origin + tr.Normal * (distance:Length() - 10) * tr.Fraction
	
	
		
	return view

end