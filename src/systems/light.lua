local data = require(script.Parent.Parent:WaitForChild("data"));

return {

	setup = function(self)
		
		self:applySymmetry();

		self:on("changed", function(property)

			if property == "range" then
									
				wait()
				self.size = Vector2.new(self.range / 100, self.range / 100);
				
			elseif property:lower() == "zIndex" and self.zIndex ~= 999999999 then
				
				self.zIndex = 999999999;
				
			end

		end)
		
	end

}
