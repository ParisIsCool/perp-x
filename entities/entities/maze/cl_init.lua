
include('shared.lua')

local sirenPos = {Vector( -4628.9575195313, -6121.1708984375, 256.03125 ), Vector( -3137.6687011719, -1168.8186035156, 276.70977783203 ), Vector( -9884.189453125, -1239.3572998047, 219.5177154541 ), Vector( -6498.662109375, 7103.6884765625, 184.48139953613 ), Vector( -13823.4296875, 2661.3203125, 447.04681396484 ), Vector( -2549.5744628906, 14358.581054688, 601.84698486328 ), Vector( 3576.4741210938, 4642.5649414063, 704.00695800781 ), Vector( 11349.615234375, 5982.353515625, 1915.8723144531 )};

function ENT:Draw()

end

function ENT:Think ( )
	if self.NextWindGust < CurTime() then
		self.NextWindGust = CurTime() + 2
		sound.Play('ambient/wind/windgust.wav', self:GetPos() + Vector(0, 0, 20), math.random(75, 100), 100);
	end
	
	if (self:GetNetworkedInt("size", 0) != 0 && !self.madeEffect) then
		local Effect = EffectData();
			Effect:SetEntity(self);
			Effect:SetScale(self:GetNetworkedInt("size", 0));
		util.Effect('tornado', Effect);
		--util.Effect('weathergod_strike', Effect);
		
		self.madeEffect = true;
	end
	
	if (self.nextThrowSirenSound < CurTime()) then
		for _, pos in pairs(sirenPos) do
			sound.Play('perp3.5/unknown.mp3', pos, 150, 100);
			self.nextThrowSirenSound = CurTime() + SoundDuration('perp2.5/tsiren.mp3');
		end
	end
end

function ENT:Initialize ( )	
	self:DrawShadow(false);
	
	self.NextWindGust = 0;
	
	self.nextThrowSirenSound = CurTime() + 5
end
