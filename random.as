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
	return int3(MathRand(20,40),9,MathRand(20,40)).opAdd(int3(0, MathRand(0,7)*MathRand(0,4), 0));
}

string RandomBlock()
{
	int randomInt = MathRand(1, 101);
	if (randomInt <= 6 && IsMultipleBlockTypesSelected())
	{
		return RD_CONNECT;
	}
	else if (randomInt <= 47)
	{
		return RD_STRAIGHT;
	}
	else if(randomInt <= 55) // special blocks
	{
		if(randomInt <= 48)
		{	
			if(!fragile) {return RD_STRAIGHT;}
			return RD_FRAGILE;
		}
		else if(randomInt <= 49)
		{
			if(!nosteer) {return RD_STRAIGHT;}
			return RD_NOSTEER;
		}
		else if(randomInt <= 50)
		{
			if(!slowmotion) {return RD_STRAIGHT;}
			return RD_SLOWMOTION;
		}	
		else if(randomInt <= 51 && noengine)
		{
			return RD_NOENGINE;
		}			
		else if(randomInt <= 52 && booster1)
		{
			return RD_BOOSTER1;
		}			
		else if(randomInt <= 53 && turbo2)
		{
			return RD_TURBO2;
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
			ready = SetBlockType(MathRand(1,5));
		}
	}
}