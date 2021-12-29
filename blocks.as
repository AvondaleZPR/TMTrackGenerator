string CURR_BLOCKS = "";
string RD_STRAIGHT = "";
string RD_START = "";
string RD_FINISH = "";
string RD_TURN1 = "";
string RD_TURN2 = "";
string RD_TURN3 = "";
string RD_TURN4 = "";
string RD_TURN5 = "";
string RD_UP1 = "";
string RD_UP2 = "";
string RD_TURBO1 = "";
string RD_TURBO2 = "";
string RD_CP = "";
string RD_END = "";
string RD_CONNECT = "";
string RD_BOOSTER1 = "";
string RD_BOOSTER2 = "";
string RD_NOENGINE = "";
string RD_SLOWMOTION = "";
string RD_FRAGILE = "";
string RD_NOSTEER = "";
string RD_RESET = "";

bool roadblocks = true, dirtblocks = false, iceblocks = false, sausageblocks = false;
bool turbo1 = true, turbo2 = false, booster1 = false, booster2 = false, noengine = false, slowmotion = false, fragile = false, nosteer = false, reset = false;

void TechBlocks()
{
	CURR_BLOCKS = "TechBlocks";
	RD_STRAIGHT = "RoadTechStraight";
	RD_START = "RoadTechStart";
	RD_FINISH = "RoadTechFinish";
	RD_TURN1 = "RoadTechCurve1";
	RD_TURN2 = "RoadTechCurve2";
	RD_TURN3 = "RoadTechCurve3";
	RD_TURN4 = "RoadTechCurve4";
	RD_TURN5 = "RoadTechCurve5";
	RD_UP1 = "RoadTechSlopeBase";
	RD_UP2 = "RoadTechSlopeBase2";
	RD_TURBO1 = "RoadTechSpecialTurbo";
	RD_TURBO2 = "RoadTechSpecialTurbo2";
	RD_CP = "RoadTechCheckpoint";
	RD_END = "TrackWallToRoadTech";
	RD_CONNECT = "RoadTechToRoadTechKEKW";
	RD_BOOSTER1 = "RoadTechSpecialBoost";
	RD_NOENGINE = "RoadTechSpecialNoEngine";
	RD_SLOWMOTION = "RoadTechSpecialSlowMotion";
	RD_FRAGILE = "RoadTechSpecialFragile";
	RD_NOSTEER = "RoadTechSpecialNoSteering";	
	RD_RESET = "RoadTechSpecialReset";
}

void DirtBlocks()
{
	CURR_BLOCKS = "DirtBlocks";
	RD_STRAIGHT = "RoadDirtStraight";
	RD_START = "RoadDirtStart";
	RD_FINISH = "RoadDirtFinish";
	RD_TURN1 = "RoadDirtCurve1";
	RD_TURN2 = "RoadDirtCurve2";
	RD_TURN3 = "RoadDirtCurve3";
	RD_TURN4 = "RoadDirtCurve4";
	RD_TURN5 = "RoadDirtCurve5";
	RD_UP1 = "RoadDirtSlopeBase";
	RD_UP2 = "RoadDirtSlopeBase2";
	RD_TURBO1 = "RoadDirtSpecialTurbo";
	RD_TURBO2 = "RoadDirtSpecialTurbo2";
	RD_CP = "RoadDirtCheckpoint";
	RD_END = "TrackWallToRoadDirt";
	RD_CONNECT = "RoadTechToRoadDirt";
	RD_BOOSTER1 = "RoadDirtSpecialBoost";
	RD_NOENGINE = "RoadDirtSpecialNoEngine";
	RD_SLOWMOTION = "RoadDirtSpecialSlowMotion";
	RD_FRAGILE = "RoadDirtSpecialFragile";
	RD_NOSTEER = "RoadDirtSpecialNoSteering";	
	RD_RESET = "RoadDirtSpecialReset";	
}

void IceBlocks()
{
	CURR_BLOCKS = "IceBlocks";
	RD_STRAIGHT = "RoadIceStraight";
	RD_START = "RoadIceStart";
	RD_FINISH = "RoadIceFinish";
	RD_TURN1 = "RoadIceCurve1";
	RD_TURN2 = "RoadIceCurve2";
	RD_TURN3 = "RoadIceCurve3";
	RD_TURN4 = "RoadIceCurve4";
	RD_TURN5 = "RoadIceCurve5";
	RD_UP1 = "RoadIceSlopeBase";
	RD_UP2 = "RoadIceSlopeBase2";
	RD_TURBO1 = "RoadIceSpecialTurbo";
	RD_TURBO2 = "RoadIceSpecialTurbo2";
	RD_CP = "RoadIceCheckpoint";
	RD_END = "TrackWallToRoadIce";
	RD_CONNECT = "RoadTechToRoadIce";
	RD_BOOSTER1 = "RoadIceSpecialBoost";
	RD_NOENGINE = "RoadIceSpecialNoEngine";
	RD_SLOWMOTION = "RoadIceSpecialSlowMotion";
	RD_FRAGILE = "RoadIceSpecialFragile";
	RD_NOSTEER = "RoadIceSpecialNoSteering";	
	RD_RESET = "RoadIceSpecialReset";	
}

void SausageBlocks()
{
	CURR_BLOCKS = "SausageBlocks";
	RD_STRAIGHT = "RoadBumpStraight";
	RD_START = "RoadBumpStart";
	RD_FINISH = "RoadBumpFinish";
	RD_TURN1 = "RoadBumpCurve1";
	RD_TURN2 = "RoadBumpCurve2";
	RD_TURN3 = "RoadBumpCurve3";
	RD_TURN4 = "RoadBumpCurve4";
	RD_TURN5 = "RoadBumpCurve5";
	RD_UP1 = "RoadBumpSlopeBase";
	RD_UP2 = "RoadBumpSlopeBase2";
	RD_TURBO1 = "RoadBumpSpecialTurbo";
	RD_TURBO2 = "RoadBumpSpecialTurbo2";
	RD_CP = "RoadBumpCheckpoint";
	RD_END = "TrackWallToRoadBump";
	RD_CONNECT = "RoadTechToRoadBump";
	RD_BOOSTER1 = "RoadBumpSpecialBoost";
	RD_NOENGINE = "RoadBumpSpecialNoEngine";
	RD_SLOWMOTION = "RoadBumpSpecialSlowMotion";
	RD_FRAGILE = "RoadBumpSpecialFragile";
	RD_NOSTEER = "RoadBumpSpecialNoSteering";	
	RD_RESET = "RoadBumpSpecialReset";	
}

bool IsMultipleBlockTypesSelected()
{
	int count = 0;
	if (roadblocks) { count++;}
	if (dirtblocks) { count++;}
	if (iceblocks) { count++;}
	if (sausageblocks) { count++;}
	return count > 1;
}

bool SetBlockType(int id)
{
	if (id == 1 && roadblocks && CURR_BLOCKS != "TechBlocks") 
	{
		TechBlocks();
		return true;
	}
	else if(id == 2 && dirtblocks && CURR_BLOCKS != "DirtBlocks")
	{
		DirtBlocks();
		return true;		
	}
	else if(id == 3 && iceblocks && CURR_BLOCKS != "IceBlocks")
	{
		IceBlocks();
		return true;		
	}
	else if(id == 4 && sausageblocks && CURR_BLOCKS != "SausageBlocks")
	{
		SausageBlocks();
		return true;		
	}	
	
	return false;
}

void SetBlockType(string type)
{
	if(type == "TechBlocks") {TechBlocks();}
	if(type == "DirtBlocks") {DirtBlocks();}
	if(type == "IceBlocks") {IceBlocks();}
	if(type == "SausageBlocks") {SausageBlocks();}
}