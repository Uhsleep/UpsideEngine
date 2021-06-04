local self = setmetatable({}, {});

local internal = require(script.Parent.Internal);

-- arrays, variables and others

self.space = {};
self.robloxSpace = {};
self.workspace = setmetatable({}, {});

-- methods

function self.getMetaData(this)

	local metaData = {};

	function metaData.__index(_, index)
				
		return this.base and this or this.properties[index]
			or this.functions[index]
			or this.methods[index]
			or this[index]
			or nil;

	end

	function metaData.__newindex(_, index, val)
				
		local currentVal = this.functions[index] or this.properties[index] or nil;
		
		this.fire("changed", index);
		
		if index == "name" and typeof(val) ~= "string" then
			
			return error("The object name must be a string.");
			
		elseif index == "name" and self.workspace[val] then
							
			return error("There's already another object with this name! You must specify a name that has no other object.");
							
		elseif index == "name" then
				
			self.workspace[this.properties.name] = nil;
			
			self.workspace[val] = self.space[this.index];
			
		end
		
		if currentVal and typeof(currentVal) ~= typeof(val) then

			return error(string.format("%s must be a %s", index, typeof(currentVal)));

		end
		
		spawn(pcall(function()
			
			if not this.loaded and this.on then this.on('loaded'):wait(); end
						
			local obj, i = self.robloxSpace[this.index], index:sub(1,1);
			i = i:upper() .. index:sub(2, string.len(index));

			if obj and obj[i] then

				local v = val;			

				if typeof(v) == "Vector2" then

					v = UDim2.new(v.X, 0, v.Y, 0);

				end

				obj[i] = val;
				
			end
			
		end))
		
		if this.base then
			
			this[index] = val;
			
		elseif typeof(val) == "function" then

			this.functions[index] = val;

		else

			this.properties[index] = val;

		end
		
		if (index == "position" or index == "size") and this.canCollide then
			
			spawn(internal.updateSpace(this))

		end
		
	end

	function metaData:__len()

		return error("Expected identifier when parsing expression, got '#'");

	end

	function metaData:__tostring(this)
		
		local inherited = "; inherited from: ";
		
		table.foreachi(this.inherited, function(index, element)
			
			inherited ..= (index == 1 and "" or ", ") .. element;
			
		end)
		
		return this.class .. inherited .. ".";

	end

	function metaData.__call(__this, generic, newClass)
		
		if not this.modules then
			
			this.modules = typeof(generic) == "table" and generic or {generic};
			
		else
			
			for _, val in pairs(generic) do
				
				this.modules[#this.modules + 1] = val; 
				
			end
			
		end
		
		this.inherited[#this.inherited + 1] = this.class ~= newClass and newClass or "";
		
		this.class = typeof(newClass) == "string" and newClass or this.class;

		require(script.Parent.systems)(__this, generic);
		
	end
	
	return metaData;
	
end;

return self;