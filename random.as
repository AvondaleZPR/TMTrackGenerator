bool seedEnabled = false;
string seedText = "OPENPLANET";
double seedDouble = 0;

int MathRand(int a, int b)
{
	if (seedEnabled)
	{
		return RandomFromSeed(a, b);
	}
	
	return Math::Rand(a, b);
}

string RandomSeed(int length)
{
	string result = "";
	string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
	
	for(int i = 0; i < length; i++)
	{
		result = result.opAdd(chars.SubStr(Math::Rand(0, chars.Length), 1));
	}
	
	return result;
}

double ConvertSeed(string seed)
{
	string newSeed = "";
	
	int length = seed.get_Length();
	if (length > 10) {length = 10;}
	for(int i = 0; i < length; i++)
	{
		newSeed = newSeed + tostring(seed[i]);
	}
	
	return Text::ParseDouble(newSeed + ".0000");
}

int RandomFromSeed(int min, int max)
{
	return int(Math::Floor(rnd_Next() * (max-min) + min));
}

float rnd_A = 45.0001;
float rnd_LEET = 1337.0000;
float rnd_M = 69.9999;
float rnd_Next()
{
	seedDouble = (rnd_A * seedDouble + rnd_LEET) % rnd_M; 
	return seedDouble % 1;
}

CGameEditorPluginMap::ECardinalDirections RandomDirection()
{
	switch(MathRand(1,5))
	{
		case 1:
			return DIR_NORTH;
		case 2:
			return DIR_EAST;
		case 3:
			return DIR_SOUTH;
		case 4:
			return DIR_WEST;		
	}
	return DIR_NORTH;
}

int3 RandomPoint()
{
	return int3(MAX_X / 2 + MathRand(-(MAX_X / 2 - (MAX_X / 2 / 6)), (MAX_X / 2 - (MAX_X / 2 / 6))), (Math::Floor(MAX_Y / 4)), MAX_Z / 2 + MathRand(-(MAX_Z / 2 - (MAX_Z / 2 / 6)), (MAX_Z / 2 - (MAX_Z / 2 / 6)))).opAdd(int3(0, MathRand(0,7)*MathRand(0,4), 0));
}

string RandomBlock()
{
	int randomInt = MathRand(1, 101);
	if (randomInt <= 6 && IsMultipleBlockTypesSelected())
	{
		return RD_CONNECT;
	}
	else if (randomInt <= 7 && coolblocks)
	{
		return RD_COOL1;
	}
	else if (randomInt <= 8 && coolblocks)
	{
		return RD_COOL2;
	}
	
	else if (randomInt <= 43)
	{
		return RD_STRAIGHT;
	}
	else if(randomInt <= 55) // special blocks
	{
		if(randomInt <= 44)
		{	
			if(!nobrake) {return RD_STRAIGHT;}
			return RD_NOBRAKE;
		}
		else if(randomInt <= 45)
		{
			if(!cruise) {return RD_STRAIGHT;}
			return RD_CRUISE;
		}
		else if(randomInt <= 46)
		{	
			if(!fragile) {return RD_STRAIGHT;}
			return RD_FRAGILE;
		}
		else if(randomInt <= 47)
		{
			if(!nosteer) {return RD_STRAIGHT;}
			return RD_NOSTEER;
		}
		else if(randomInt <= 48)
		{
			if(!slowmotion) {return RD_STRAIGHT;}
			return RD_SLOWMOTION;
		}	
		else if(randomInt <= 49)
		{
			if(!noengine) {return RD_STRAIGHT;}
			return RD_NOENGINE;
		}			
		else if(randomInt <= 50)
		{
			if(!booster1) {return RD_STRAIGHT;}
			return RD_BOOSTER1;
		}		
		else if(randomInt <= 51 && booster2)
		{
			return RD_BOOSTER2;
		}				
		else if(randomInt <= 52 && turbo2)
		{
			return RD_TURBO2;
		}	
		else if(randomInt <= 53 && turbor)
		{
			return RD_TURBOR;
		}		
		else if(randomInt <= 54 && reset)
		{
			return RD_RESET;
		}
		else if(turbo1)
		{
			return RD_TURBO1;
		}			
		else 
		{
			return RD_STRAIGHT;
		}
	}
	else if(randomInt <= 60)
	{
		if(st_useCpBlocks)
		{
			return RD_STRAIGHT;
		}
	
		return RD_CP;
	}
	else if(randomInt <= 70)
	{
		return RD_UP1;
	}
	else if(randomInt <= 77)
	{
		return RD_UP2;
	}
	else if(randomInt <= 92)
	{
		return RD_TURN2;
	}
	else
	{
		return RD_TURN1;
	}
}

void RandomBlocks()
{
	if (IsMultipleBlockTypesSelected())
	{
		bool ready = false;
		while(!ready)
		{
			ready = SetBlockType(MathRand(1,11));
		}
	}
}

CGameEditorPluginMap::EMapElemColor RandomColor()
{
	int randomInt = Math::Rand(1,7);
	if(randomInt == 1)
	{
		return CGameEditorPluginMap::EMapElemColor::Default;
	}
	else if(randomInt == 2)
	{
		return CGameEditorPluginMap::EMapElemColor::White;
	}
	else if(randomInt == 3)
	{
		return CGameEditorPluginMap::EMapElemColor::Green;
	}
	else if(randomInt == 4)
	{
		return CGameEditorPluginMap::EMapElemColor::Blue;
	}
	else if(randomInt == 5)
	{
		return CGameEditorPluginMap::EMapElemColor::Red;
	}
	else if(randomInt == 6)
	{
		return CGameEditorPluginMap::EMapElemColor::Black;
	}	
	
	return CGameEditorPluginMap::EMapElemColor::Default;
}

string RandomSceneryBlock()
{
	return SCENERY_BLOCKS[Math::Rand(0, SCENERY_BLOCKS.Length)];
}