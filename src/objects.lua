local self, base = {}, require(script.Parent:WaitForChild("BaseObject"));

return function(obj)
		
	if obj == "static" then
		print("static passed")
		base.properties.image = "";
		base("basics", "static");
		
	elseif obj == "sprite" then
		print("sprite passed")
		base({"basics", "layers"}, "sprite");
		
	elseif obj == "particles" then
		
		if obj then return error("For now, u can't use the particles object, instead use sprite to make particles"); end;
		
		base.properties.texture = "";
		base.properties.canCollide = false;
		base.properties.speed = 0;
		base.properties.angle = Vector2.new();
		base.properties.gravity = 0;
		base.properties.transparency = 0;
		base.properties.lightEmission = 0;
		base.properties.rate = 10;
		base.properties.enabled = true;
		base.properties.rotationSpeed = 0;
		
		base({"basics", "layers"}, "particles");
		
	elseif obj == "light" then
		print("light passed")
		base.properties.transparency = 0.5;
		base.properties.range = 5;
		base.properties.image = "rbxassetid://6904405933";
		base.properties.zIndex = 999999999;
		
		base({"basics", "light"}, "light");

	else
		
		return error("Invalid object!");
		
	end
	
	base.properties.size = Vector2.new(0.2,0.2);
	
	base.base = nil;
	
	return base;
	
end;