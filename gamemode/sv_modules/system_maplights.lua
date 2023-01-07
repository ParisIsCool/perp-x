if SERVER and game.GetMap() == "rp_evocity_v4b1" then
	-- add night lights.
	local function checkNightLight( ent , key , val )
		-- check if its a light.
		if ( !string.find( ent:GetClass( ) , 'light' ) ) then return end

		-- define table.
		GAMEMODE.nightlights = GAMEMODE.nightlights or { }

		if ( key == 'nightlight' ) then
			local name = ent:GetClass( ) .. '_nightlight' .. ent:EntIndex( )
	--		ent:SetKeyValue( 'targetname' , name )
			table.insert( GAMEMODE.nightlights , { ent = ent , style = val } )
			ent:Fire( 'TurnOn' , '' , 0 )
		end
	end

	hook.Add( 'EntityKeyValue' , 'GM:checkNightLight' , function( ent , key , val ) checkNightLight( ent , key , val ) end )

	-- lights on bitch!
	local function lightsOn( )
		-- no lights? bail.
		if ( !GAMEMODE.nightlights ) then return end

		-- macro function for making the lights flicker.
		local function flicker( ent )
			-- pattern.
			local new_pattern

			-- randomize it.
			if ( math.random( 1 , 2 ) == 1 ) then
				new_pattern = 'az'
			else
				new_pattern = 'za'
			end

			-- random delay.
			local delay = math.random( 0 , 400 ) * 0.01

			-- flicker the light on.
			ent:Fire( 'SetPattern' , new_pattern , delay )
			ent:Fire( 'TurnOn' , '' , delay )

			-- delay the sound.
			timer.Simple( delay , function( ) ent:EmitSound( 'buttons/button1.wav' , math.random( 70 , 80 ) , math.random( 95 , 105 ) ) end )

			-- delay for solid pattern.
			delay = delay + math.random( 10 , 50 ) * 0.01

			-- set solid pattern.
			ent:Fire( 'SetPattern' , 'z' , delay )
		end

		-- loop through lights and turn um on.
		local light
		for _ , light in pairs( GAMEMODE.nightlights ) do
			flicker( light.ent )
		end
	end


	-- lights out!
	local function lightsOff( )
		-- no lights?
		if ( !GAMEMODE.nightlights ) then return end

		-- loop through lights and turn um off.
		local light
		for _ , light in pairs( GAMEMODE.nightlights ) do
			light.ent:Fire( 'TurnOff' , '' , 0 )
		end
	end

	local stage = 0
	timer.Create( "LightsCheck", 30, 0, function()
		if stage == 0 and daynight:IsNight() then
			stage = 1
			lightsOn()
		elseif stage == 1 and not daynight:IsNight() then
			stage = 0
			lightsOff()
		end
	end )

end