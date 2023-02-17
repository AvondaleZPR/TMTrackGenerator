//block blanks
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
string RD_TURBOR = "";
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
string RD_CRUISE = "";
string RD_NOBRAKE = "";
string RD_COOL1 = "";
string RD_COOL2 = "";
//--

//enabled blocks
bool roadblocks = true, dirtblocks = false, iceblocks = false, icewallblocks = false, sausageblocks = false, opentechroadblocks = false, opendirtroadblocks = false, openiceroadblocks = false, opengrassroadblocks = false, waterblocks = false, platformtechblocks = false, platformdirtblocks = false, platformiceblocks = false, platformgrassblocks = false, plasticblocks = false;
bool turbo1 = true, turbo2 = false, booster1 = false, booster2 = false, noengine = false, slowmotion = false, fragile = false, nosteer = false, reset = false, cruise = false, nobrake = false, turbor = false;
bool coolblocks = true, randomcolors = false;
//--

//walls
string WALL_STRAIGHT = "TrackWallStraightPillar";
string WALL_FULL = "DecoWallBasePillar";
//--

//items
string ITEM_PILLAR1 = "ObstaclePillar2m";
string ITEM_TURNSTILE4_1 = "ObstacleTurnstile4mTripleRightLevel0";
string ITEM_FLAG1 = "Flag8m";
//--

//scenery blocks array
string[] SCENERY_BLOCKS = {
"DecoHillSlope2Straight", "DecoHillSlope2StraightX2", "DecoHillSlope2Curve1In", "DecoHillSlope2Curve1Out", "DecoPlatformBase",
"DecoHillSlope2Straight", "DecoHillSlope2StraightX2", "DecoHillSlope2Curve1In", "DecoHillSlope2Curve1Out", "DecoPlatformBase",
"DecoHillDirtSlope2Straight", "DecoHillDirtSlope2StraightX2", "DecoHillDirtSlope2Curve1In", "DecoHillDirtSlope2Curve1Out", "DecoPlatformDirtBase",
"DecoHillIceSlope2Straight", "DecoHillIceSlope2StraightX2", "DecoHillIceSlope2Curve1In", "DecoHillIceSlope2Curve1Out", "DecoPlatformIceBase",
"DecoHillSlope2Straight", "DecoHillSlope2StraightX2", "DecoHillSlope2Curve1In", "DecoHillSlope2Curve1Out", "DecoPlatformBase",
"DecoHillSlope2Straight", "DecoHillSlope2StraightX2", "DecoHillSlope2Curve1In", "DecoHillSlope2Curve1Out", "DecoPlatformBase",
"DecoHillDirtSlope2Straight", "DecoHillDirtSlope2StraightX2", "DecoHillDirtSlope2Curve1In", "DecoHillDirtSlope2Curve1Out", "DecoPlatformDirtBase",
"DecoHillIceSlope2Straight", "DecoHillIceSlope2StraightX2", "DecoHillIceSlope2Curve1In", "DecoHillIceSlope2Curve1Out", "DecoPlatformIceBase",
"StructureSupportCorner", "StructureSupportStraight", "StructureSupportCross", "StructureCross",
"DecoWallLoopStart3x6Center", "DecoWallLoopEnd3x6Center", "PlatformTechLoopStart", "PlatformPlasticLoopStart",
"WaterWallCorner", "WaterWallCross", "WaterWallStraight",
"GateSpecialReset", "TechnicsScreen1x1Straight",
"StageTechnicsLightDeadend", "StageTechnicsLightDeadend", "StageTechnicsLightDeadend",
"CanopyCenterFlatBase", "StageCurve1In", "StandStraight",
"CanopyCenterFlatBase", "StageCurve1In", "StandStraight",
};
//--

bool IsMultipleBlockTypesSelected()
{
	int count = 0;
	if (roadblocks) { count++; }
	if (dirtblocks) { count++; }
	if (iceblocks) { count++; }
	if (icewallblocks) { count++; }
	if (sausageblocks) { count++; }
	if (opentechroadblocks) { count++; }
	if (opendirtroadblocks) { count++; }
	if (openiceroadblocks) { count++; }
	if (opengrassroadblocks) { count++; }
	if (waterblocks) { count++; }
	if (platformtechblocks) { count++; }
	if (platformdirtblocks) { count++; }
	if (platformiceblocks) { count++; }
	if (platformgrassblocks) { count++; }
	if (plasticblocks) { count++; }
	return count > 1;
}

bool SetBlockType(int id)
{
	if (id == 1 && roadblocks && CURR_BLOCKS != "TechBlocks") 
	{
		blocks::TechBlocks();
		return true;
	}
	else if(id == 2 && dirtblocks && CURR_BLOCKS != "DirtBlocks")
	{
		blocks::DirtBlocks();
		return true;		
	}
	else if(id == 3 && iceblocks && CURR_BLOCKS != "IceBlocks")
	{
		blocks::IceBlocks();
		return true;		
	}
	else if(id == 4 && sausageblocks && CURR_BLOCKS != "SausageBlocks")
	{
		blocks::SausageBlocks();
		return true;		
	}
	else if(id == 5 && icewallblocks && CURR_BLOCKS != "IceWallBlocks")
	{
		blocks::IceWallBlocks();
		return true;
	}
	else if(id == 6 && opentechroadblocks && CURR_BLOCKS != "OpenTechRoadBlocks")
	{
		blocks::OpenTechRoadBlocks();
		return true;
	}
	else if(id == 7 && opendirtroadblocks && CURR_BLOCKS != "OpenDirtRoadBlocks")
	{
		blocks::OpenDirtRoadBlocks();
		return true;
	}
	else if(id == 8 && openiceroadblocks && CURR_BLOCKS != "OpenIceRoadBlocks")
	{
		blocks::OpenIceRoadBlocks();
		return true;
	}
	else if(id == 9 && opengrassroadblocks && CURR_BLOCKS != "OpenGrassRoadBlocks")
	{
		blocks::OpenGrassRoadBlocks();
		return true;
	}	
	else if(id == 10 && waterblocks && CURR_BLOCKS != "WaterBlocks")
	{
		blocks::WaterBlocks();
		return true;
	}
	else if(id == 11 && platformtechblocks && CURR_BLOCKS != "PlatformTechBlocks")
	{
		blocks::PlatformTechBlocks();
		return true;
	}
	else if(id == 12 && platformdirtblocks && CURR_BLOCKS != "PlatformDirtBlocks")
	{
		blocks::PlatformDirtBlocks();
		return true;
	}
	else if(id == 13 && platformiceblocks && CURR_BLOCKS != "PlatformIceBlocks")
	{
		blocks::PlatformIceBlocks();
		return true;
	}
	else if(id == 14 && platformgrassblocks && CURR_BLOCKS != "PlatformGrassBlocks")
	{
		blocks::PlatformGrassBlocks();
		return true;
	}	
	else if(id >= 15 && plasticblocks && CURR_BLOCKS != "PlasticBlocks")
	{
		blocks::PlasticBlocks();
		return true;
	}
	
	return false;
}

void SetBlockType(const string type)
{
	if(type == "TechBlocks") {blocks::TechBlocks();}
	if(type == "DirtBlocks") {blocks::DirtBlocks();}
	if(type == "IceBlocks") {blocks::IceBlocks();}
	if(type == "SausageBlocks") {blocks::SausageBlocks();}
	if(type == "IceWallBlocks") {blocks::IceWallBlocks();}
	if(type == "OpenTechRoadBlocks") {blocks::OpenTechRoadBlocks();}
	if(type == "OpenDirtRoadBlocks") {blocks::OpenDirtRoadBlocks();}
	if(type == "OpenIceRoadBlocks") {blocks::OpenIceRoadBlocks();}
	if(type == "OpenGrassRoadBlocks") {blocks::OpenGrassRoadBlocks();}
	if(type == "WaterBlocks") {blocks::WaterBlocks();}
	if(type == "PlatformTechBlocks") {blocks::PlatformTechBlocks();}
	if(type == "PlatformDirtBlocks") {blocks::PlatformDirtBlocks();}
	if(type == "PlatformIceBlocks") {blocks::PlatformIceBlocks();}
	if(type == "PlatformGrassBlocks") {blocks::PlatformGrassBlocks();}
	if(type == "PlasticBlocks") {blocks::PlasticBlocks();}
}

//block blanks fillers
namespace blocks
{
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
	RD_TURBOR = "RoadTechSpecialTurboRoulette";
	RD_CP = "RoadTechCheckpoint";
	RD_END = "TrackWallToRoadTech";
	RD_CONNECT = "RoadTechToRoadTechKEKW";
	RD_BOOSTER1 = "RoadTechSpecialBoost";
	RD_BOOSTER2 = "RoadTechSpecialBoost2";
	RD_NOENGINE = "RoadTechSpecialNoEngine";
	RD_SLOWMOTION = "RoadTechSpecialSlowMotion";
	RD_FRAGILE = "RoadTechSpecialFragile";
	RD_NOSTEER = "RoadTechSpecialNoSteering";	
	RD_RESET = "RoadTechSpecialReset";
	RD_CRUISE = "RoadTechSpecialCruise";
	RD_NOBRAKE = "RoadTechSpecialNoBrake";
	RD_COOL1 = "RoadTechRampLow";
	RD_COOL2 = "RoadTechRampMed";
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
	RD_TURBOR = "RoadDirtSpecialTurboRoulette";	
	RD_CP = "RoadDirtCheckpoint";
	RD_END = "TrackWallToRoadDirt";
	RD_CONNECT = "RoadTechToRoadDirt";
	RD_BOOSTER1 = "RoadDirtSpecialBoost";
	RD_BOOSTER2 = "RoadDirtSpecialBoost2";
	RD_NOENGINE = "RoadDirtSpecialNoEngine";
	RD_SLOWMOTION = "RoadDirtSpecialSlowMotion";
	RD_FRAGILE = "RoadDirtSpecialFragile";
	RD_NOSTEER = "RoadDirtSpecialNoSteering";	
	RD_RESET = "RoadDirtSpecialReset";	
	RD_CRUISE = "RoadDirtSpecialCruise";
	RD_NOBRAKE = "RoadDirtSpecialNoBrake";	
	RD_COOL1 = "RoadDirtWave2X";
	RD_COOL2 = "RoadDirtWave2X";	
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
	RD_TURBOR = "RoadIceSpecialTurboRoulette";
	RD_CP = "RoadIceCheckpoint";
	RD_END = "TrackWallToRoadIce";
	RD_CONNECT = "RoadTechToRoadIce";
	RD_BOOSTER1 = "RoadIceSpecialBoost";
	RD_BOOSTER2 = "RoadIceSpecialBoost2";
	RD_NOENGINE = "RoadIceSpecialNoEngine";
	RD_SLOWMOTION = "RoadIceSpecialSlowMotion";
	RD_FRAGILE = "RoadIceSpecialFragile";
	RD_NOSTEER = "RoadIceSpecialNoSteering";	
	RD_RESET = "RoadIceSpecialReset";	
	RD_CRUISE = "RoadIceSpecialCruise";
	RD_NOBRAKE = "RoadIceSpecialNoBrake";
	RD_COOL1 = "RoadIceWithWallStraight";
	RD_COOL2 = "RoadIceWithWallStraight";		
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
	RD_TURBOR = "RoadBumpSpecialTurboRoulette";
	RD_CP = "RoadBumpCheckpoint";
	RD_END = "TrackWallToRoadBump";
	RD_CONNECT = "RoadTechToRoadBump";
	RD_BOOSTER1 = "RoadBumpSpecialBoost";
	RD_BOOSTER2 = "RoadBumpSpecialBoost2";
	RD_NOENGINE = "RoadBumpSpecialNoEngine";
	RD_SLOWMOTION = "RoadBumpSpecialSlowMotion";
	RD_FRAGILE = "RoadBumpSpecialFragile";
	RD_NOSTEER = "RoadBumpSpecialNoSteering";	
	RD_RESET = "RoadBumpSpecialReset";	
	RD_CRUISE = "RoadBumpSpecialCruise";
	RD_NOBRAKE = "RoadBumpSpecialNoBrake";	
	RD_COOL1 = "RoadBumpNarrowCenter";
	RD_COOL2 = "RoadBumpNarrowSide";		
}

void IceWallBlocks()
{
	CURR_BLOCKS = "IceWallBlocks";
	RD_STRAIGHT = "RoadIceWithWallStraight";
	RD_START = "RoadIceWithWallMultilapLeft";
	RD_FINISH = "RoadIceFinish";
	RD_TURN1 = "RoadIceWithWallCurve1";
	RD_TURN2 = "RoadIceWithWallCurve2";
	RD_TURN3 = "RoadIceWithWallCurve3";
	RD_TURN4 = "RoadIceWithWallCurve4";
	RD_TURN5 = "RoadIceWithWallCurve5";
	RD_UP1 = "RoadIceSlopeBase";
	RD_UP2 = "RoadIceSlopeBase2";
	RD_TURBO1 = "RoadIceSpecialTurbo";
	RD_TURBO2 = "RoadIceSpecialTurbo2";
	RD_TURBOR = "RoadIceSpecialTurboRoulette";
	RD_CP = "RoadIceWithWallCheckpointLeft";
	RD_END = "TrackWallToRoadIce";
	RD_CONNECT = "RoadTechToRoadIce";
	RD_BOOSTER1 = "RoadIceSpecialBoost";
	RD_BOOSTER2 = "RoadIceSpecialBoost2";
	RD_NOENGINE = "RoadIceSpecialNoEngine";
	RD_SLOWMOTION = "RoadIceSpecialSlowMotion";
	RD_FRAGILE = "RoadIceSpecialFragile";
	RD_NOSTEER = "RoadIceSpecialNoSteering";	
	RD_RESET = "RoadIceSpecialReset";	
	RD_CRUISE = "RoadIceSpecialCruise";
	RD_NOBRAKE = "RoadIceSpecialNoBrake";
	RD_COOL1 = "RoadIceToRoadIceWithWallSwitchLeftRight";
	RD_COOL2 = "RoadIceToRoadIceWithWallSwitchRightLeft";		
}

void OpenTechRoadBlocks()
{
	CURR_BLOCKS = "OpenTechRoadBlocks";
	RD_STRAIGHT = "OpenTechRoadStraight";
	RD_START = "PlatformTechStart";
	RD_FINISH = "PlatformTechFinish";
	RD_TURN1 = "OpenTechRoadCurve1";
	RD_TURN2 = "OpenTechRoadCurve2";
	RD_TURN3 = "OpenTechRoadCurve3";
	RD_TURN4 = "OpenTechRoadCurve4";
	RD_TURN5 = "OpenTechRoadCurve5";
	RD_UP1 = "OpenTechRoadSlopeBase";
	RD_UP2 = "OpenTechRoadSlope2Base";
	RD_TURBO1 = "PlatformTechSpecialTurbo";
	RD_TURBO2 = "PlatformTechSpecialTurbo2";
	RD_TURBOR = "PlatformTechSpecialTurboRoulette";
	RD_CP = "OpenTechRoadCheckpoint";
	RD_END = "PlatformTechToDecoWall";
	RD_CONNECT = "PlatformTechToRoadTech";
	RD_BOOSTER1 = "OpenTechRoadSpecialBoost";
	RD_BOOSTER2 = "OpenTechRoadSpecialBoost2";
	RD_NOENGINE = "OpenTechRoadSpecialNoEngine";
	RD_SLOWMOTION = "OpenTechRoadSpecialSlowMotion";
	RD_FRAGILE = "OpenTechRoadSpecialFragile";
	RD_NOSTEER = "OpenTechRoadSpecialNoSteering";	
	RD_RESET = "OpenTechRoadSpecialReset";
	RD_CRUISE = "OpenTechRoadSpecialCruise";
	RD_NOBRAKE = "OpenTechRoadSpecialNoBrake";
	RD_COOL1 = "DecoPlatformBase";
	RD_COOL2 = "OpenTechZoneBase5";
}

void OpenDirtRoadBlocks()
{
	CURR_BLOCKS = "OpenDirtRoadBlocks";
	RD_STRAIGHT = "OpenDirtRoadStraight";
	RD_START = "PlatformDirtStart";
	RD_FINISH = "PlatformDirtFinish";
	RD_TURN1 = "OpenDirtRoadCurve1";
	RD_TURN2 = "OpenDirtRoadCurve2";
	RD_TURN3 = "OpenDirtRoadCurve3";
	RD_TURN4 = "OpenDirtRoadCurve4";
	RD_TURN5 = "OpenDirtRoadCurve5";
	RD_UP1 = "OpenDirtRoadSlopeBase";
	RD_UP2 = "OpenDirtRoadSlope2Base";
	RD_TURBO1 = "PlatformDirtSpecialTurbo";
	RD_TURBO2 = "PlatformDirtSpecialTurbo2";
	RD_TURBOR = "PlatformDirtSpecialTurboRoulette";
	RD_CP = "OpenDirtRoadCheckpoint";
	RD_END = "PlatformDirtToDecoWall";
	RD_CONNECT = "PlatformDirtToRoadTech";
	RD_BOOSTER1 = "OpenDirtRoadSpecialBoost";
	RD_BOOSTER2 = "OpenDirtRoadSpecialBoost2";
	RD_NOENGINE = "OpenDirtRoadSpecialNoEngine";
	RD_SLOWMOTION = "OpenDirtRoadSpecialSlowMotion";
	RD_FRAGILE = "OpenDirtRoadSpecialFragile";
	RD_NOSTEER = "OpenDirtRoadSpecialNoSteering";	
	RD_RESET = "OpenDirtRoadSpecialReset";
	RD_CRUISE = "OpenDirtRoadSpecialCruise";
	RD_NOBRAKE = "OpenDirtRoadSpecialNoBrake";
	RD_COOL1 = "DecoPlatformDirtBase";
	RD_COOL2 = "OpenDirtZoneBase5";
}

void OpenIceRoadBlocks()
{
	CURR_BLOCKS = "OpenIceRoadBlocks";
	RD_STRAIGHT = "OpenIceRoadStraight";
	RD_START = "PlatformIceStart";
	RD_FINISH = "PlatformIceFinish";
	RD_TURN1 = "OpenIceRoadCurve1";
	RD_TURN2 = "OpenIceRoadCurve2";
	RD_TURN3 = "OpenIceRoadCurve3";
	RD_TURN4 = "OpenIceRoadCurve4";
	RD_TURN5 = "OpenIceRoadCurve5";
	RD_UP1 = "OpenIceRoadSlopeBase";
	RD_UP2 = "OpenIceRoadSlope2Base";
	RD_TURBO1 = "PlatformIceSpecialTurbo";
	RD_TURBO2 = "PlatformIceSpecialTurbo2";
	RD_TURBOR = "PlatformIceSpecialTurboRoulette";
	RD_CP = "OpenIceRoadCheckpoint";
	RD_END = "PlatformIceToDecoWall";
	RD_CONNECT = "PlatformIceToRoadTech";
	RD_BOOSTER1 = "OpenIceRoadSpecialBoost";
	RD_BOOSTER2 = "OpenIceRoadSpecialBoost2";
	RD_NOENGINE = "OpenIceRoadSpecialNoEngine";
	RD_SLOWMOTION = "OpenIceRoadSpecialSlowMotion";
	RD_FRAGILE = "OpenIceRoadSpecialFragile";
	RD_NOSTEER = "OpenIceRoadSpecialNoSteering";	
	RD_RESET = "OpenIceRoadSpecialReset";
	RD_CRUISE = "OpenIceRoadSpecialCruise";
	RD_NOBRAKE = "OpenIceRoadSpecialNoBrake";
	RD_COOL1 = "DecoPlatformIceBase";
	RD_COOL2 = "OpenIceZoneBase5";
}

void OpenGrassRoadBlocks()
{
	CURR_BLOCKS = "OpenGrassRoadBlocks";
	RD_STRAIGHT = "OpenGrassRoadStraight";
	RD_START = "PlatformGrassStart";
	RD_FINISH = "PlatformGrassFinish";
	RD_TURN1 = "OpenGrassRoadCurve1";
	RD_TURN2 = "OpenGrassRoadCurve2";
	RD_TURN3 = "OpenGrassRoadCurve3";
	RD_TURN4 = "OpenGrassRoadCurve4";
	RD_TURN5 = "OpenGrassRoadCurve5";
	RD_UP1 = "OpenGrassRoadSlopeBase";
	RD_UP2 = "OpenGrassRoadSlope2Base";
	RD_TURBO1 = "PlatformGrassSpecialTurbo";
	RD_TURBO2 = "PlatformGrassSpecialTurbo2";
	RD_TURBOR = "PlatformGrassSpecialTurboRoulette";
	RD_CP = "OpenGrassRoadCheckpoint";
	RD_END = "PlatformGrassToDecoWall";
	RD_CONNECT = "PlatformGrassToRoadTech";
	RD_BOOSTER1 = "OpenGrassRoadSpecialBoost";
	RD_BOOSTER2 = "OpenGrassRoadSpecialBoost2";
	RD_NOENGINE = "OpenGrassRoadSpecialNoEngine";
	RD_SLOWMOTION = "OpenGrassRoadSpecialSlowMotion";
	RD_FRAGILE = "OpenGrassRoadSpecialFragile";
	RD_NOSTEER = "OpenGrassRoadSpecialNoSteering";	
	RD_RESET = "OpenGrassRoadSpecialReset";
	RD_CRUISE = "OpenGrassRoadSpecialCruise";
	RD_NOBRAKE = "OpenGrassRoadSpecialNoBrake";
	RD_COOL1 = "DecoPlatformBase";
	RD_COOL2 = "OpenGrassZoneBase5";
}

void WaterBlocks()
{
	CURR_BLOCKS = "WaterBlocks";
	RD_STRAIGHT = "RoadWaterStraight";
	RD_START = "RoadWaterStart";
	RD_FINISH = "RoadWaterFinish";
	RD_TURN1 = "RoadWaterCurve1";
	RD_TURN2 = "RoadWaterCurve2";
	RD_TURN3 = "RoadWaterCurve3";
	RD_TURN4 = "RoadWaterCurve4";
	RD_TURN5 = "RoadWaterCurve5";
	RD_UP1 = "RoadTechSlopeBase";
	RD_UP2 = "RoadTechSlopeBase2";
	RD_TURBO1 = "RoadWaterSpecialTurbo";
	RD_TURBO2 = "RoadWaterSpecialTurbo2";
	RD_TURBOR = "RoadTechSpecialTurboRoulette";
	RD_CP = "RoadWaterCheckpoint";
	RD_END = "TrackWallToRoadTech";
	RD_CONNECT = "RoadTechToRoadTechKEKW";
	RD_BOOSTER1 = "RoadWaterSpecialBoost";
	RD_BOOSTER2 = "RoadWaterSpecialBoost2";
	RD_NOENGINE = "RoadWaterSpecialNoEngine";
	RD_SLOWMOTION = "RoadWaterSpecialSlowMotion";
	RD_FRAGILE = "RoadWaterSpecialFragile";
	RD_NOSTEER = "RoadWaterhSpecialNoSteering";	
	RD_RESET = "RoadWaterSpecialReset";
	RD_CRUISE = "RoadWaterSpecialCruise";
	RD_NOBRAKE = "RoadWaterSpecialNoBrake";
	RD_COOL1 = "RoadWaterBranchCross";
	RD_COOL2 = "RoadTechRampLow";
}

void PlatformTechBlocks()
{
	CURR_BLOCKS = "PlatformTechBlocks";
	RD_STRAIGHT = "PlatformTechBase";
	RD_START = "PlatformTechStart";
	RD_FINISH = "PlatformTechFinish";
	RD_TURN1 = "PlatformTechCurve1";
	RD_TURN2 = "PlatformTechCurve2";
	RD_TURN3 = "PlatformTechCurve3";
	RD_TURN4 = "PlatformTechCurve4";
	RD_TURN5 = "PlatformTechCurve5";
	RD_UP1 = "PlatformTechSlopeBase";
	RD_UP2 = "PlatformTechSlopeBase2";
	RD_TURBO1 = "PlatformTechSpecialTurbo";
	RD_TURBO2 = "PlatformTechSpecialTurbo2";
	RD_TURBOR = "PlatformTechSpecialTurboRoulette";
	RD_CP = "PlatformTechCheckpoint";
	RD_END = "PlatformTechToDecoWall";
	RD_CONNECT = "PlatformTechToRoadTech";
	RD_BOOSTER1 = "PlatformTechSpecialBoost";
	RD_BOOSTER2 = "PlatformTechSpecialBoost2";
	RD_NOENGINE = "PlatformTechSpecialNoEngine";
	RD_SLOWMOTION = "PlatformTechSpecialSlowMotion";
	RD_FRAGILE = "PlatformTechSpecialFragile";
	RD_NOSTEER = "PlatformTechSpecialNoSteering";	
	RD_RESET = "PlatformTechSpecialReset";
	RD_CRUISE = "PlatformTechSpecialCruise";
	RD_NOBRAKE = "PlatformTechSpecialNoBrake";
	RD_COOL1 = "PlatformTechBaseWithHole24m";
	RD_COOL2 = "PlatformTechSlope2Start";
}	

void PlatformDirtBlocks()
{
	CURR_BLOCKS = "PlatformDirtBlocks";
	RD_STRAIGHT = "PlatformDirtBase";
	RD_START = "PlatformDirtStart";
	RD_FINISH = "PlatformDirtFinish";
	RD_TURN1 = "PlatformDirtCurve1";
	RD_TURN2 = "PlatformDirtCurve2";
	RD_TURN3 = "PlatformDirtCurve3";
	RD_TURN4 = "PlatformDirtCurve4";
	RD_TURN5 = "PlatformDirtCurve5";
	RD_UP1 = "PlatformDirtSlopeBase";
	RD_UP2 = "PlatformDirtSlopeBase2";
	RD_TURBO1 = "PlatformDirtSpecialTurbo";
	RD_TURBO2 = "PlatformDirtSpecialTurbo2";
	RD_TURBOR = "PlatformDirtSpecialTurboRoulette";
	RD_CP = "PlatformDirtCheckpoint";
	RD_END = "PlatformDirtToDecoWall";
	RD_CONNECT = "PlatformDirtToRoadTech";
	RD_BOOSTER1 = "PlatformDirtSpecialBoost";
	RD_BOOSTER2 = "PlatformDirtSpecialBoost2";
	RD_NOENGINE = "PlatformDirtSpecialNoEngine";
	RD_SLOWMOTION = "PlatformDirtSpecialSlowMotion";
	RD_FRAGILE = "PlatformDirtSpecialFragile";
	RD_NOSTEER = "PlatformDirtSpecialNoSteering";	
	RD_RESET = "PlatformDirtSpecialReset";
	RD_CRUISE = "PlatformDirtSpecialCruise";
	RD_NOBRAKE = "PlatformDirtSpecialNoBrake";
	RD_COOL1 = "PlatformDirtBaseWithHole24m";
	RD_COOL2 = "PlatformDirtSlope2Start";
}	

void PlatformIceBlocks()
{
	CURR_BLOCKS = "PlatformIceBlocks";
	RD_STRAIGHT = "PlatformIceBase";
	RD_START = "PlatformIceStart";
	RD_FINISH = "PlatformIceFinish";
	RD_TURN1 = "PlatformIceCurve1";
	RD_TURN2 = "PlatformIceCurve2";
	RD_TURN3 = "PlatformIceCurve3";
	RD_TURN4 = "PlatformIceCurve4";
	RD_TURN5 = "PlatformIceCurve5";
	RD_UP1 = "PlatformIceSlopeBase";
	RD_UP2 = "PlatformIceSlopeBase2";
	RD_TURBO1 = "PlatformIceSpecialTurbo";
	RD_TURBO2 = "PlatformIceSpecialTurbo2";
	RD_TURBOR = "PlatformIceSpecialTurboRoulette";
	RD_CP = "PlatformIceCheckpoint";
	RD_END = "PlatformIceToDecoWall";
	RD_CONNECT = "PlatformIceToRoadTech";
	RD_BOOSTER1 = "PlatformIceSpecialBoost";
	RD_BOOSTER2 = "PlatformIceSpecialBoost2";
	RD_NOENGINE = "PlatformIceSpecialNoEngine";
	RD_SLOWMOTION = "PlatformIceSpecialSlowMotion";
	RD_FRAGILE = "PlatformIceSpecialFragile";
	RD_NOSTEER = "PlatformIceSpecialNoSteering";	
	RD_RESET = "PlatformIceSpecialReset";
	RD_CRUISE = "PlatformIceSpecialCruise";
	RD_NOBRAKE = "PlatformIceSpecialNoBrake";
	RD_COOL1 = "PlatformIceBaseWithHole24m";
	RD_COOL2 = "PlatformIceSlope2Start";
}	

void PlatformGrassBlocks()
{
	CURR_BLOCKS = "PlatformGrassBlocks";
	RD_STRAIGHT = "PlatformGrassBase";
	RD_START = "PlatformGrassStart";
	RD_FINISH = "PlatformGrassFinish";
	RD_TURN1 = "PlatformGrassCurve1";
	RD_TURN2 = "PlatformGrassCurve2";
	RD_TURN3 = "PlatformGrassCurve3";
	RD_TURN4 = "PlatformGrassCurve4";
	RD_TURN5 = "PlatformGrassCurve5";
	RD_UP1 = "PlatformGrassSlopeBase";
	RD_UP2 = "PlatformGrassSlopeBase2";
	RD_TURBO1 = "PlatformGrassSpecialTurbo";
	RD_TURBO2 = "PlatformGrassSpecialTurbo2";
	RD_TURBOR = "PlatformGrassSpecialTurboRoulette";
	RD_CP = "PlatformGrassCheckpoint";
	RD_END = "PlatformGrassToDecoWall";
	RD_CONNECT = "PlatformGrassToRoadTech";
	RD_BOOSTER1 = "PlatformGrassSpecialBoost";
	RD_BOOSTER2 = "PlatformGrassSpecialBoost2";
	RD_NOENGINE = "PlatformGrassSpecialNoEngine";
	RD_SLOWMOTION = "PlatformGrassSpecialSlowMotion";
	RD_FRAGILE = "PlatformGrassSpecialFragile";
	RD_NOSTEER = "PlatformGrassSpecialNoSteering";	
	RD_RESET = "PlatformGrassSpecialReset";
	RD_CRUISE = "PlatformGrassSpecialCruise";
	RD_NOBRAKE = "PlatformGrassSpecialNoBrake";
	RD_COOL1 = "PlatformGrassBaseWithHole24m";
	RD_COOL2 = "PlatformGrassSlope2Start";
}	

void PlasticBlocks()
{
	CURR_BLOCKS = "PlasticBlocks";
	RD_STRAIGHT = "PlatformPlasticBase";
	RD_START = "PlatformPlasticStart";
	RD_FINISH = "PlatformPlasticFinish";
	RD_TURN1 = "PlatformPlasticCurve1";
	RD_TURN2 = "PlatformPlasticCurve2";
	RD_TURN3 = "PlatformPlasticCurve3";
	RD_TURN4 = "PlatformPlasticCurve4";
	RD_TURN5 = "PlatformPlasticCurve5";
	RD_UP1 = "PlatformPlasticSlopeBase";
	RD_UP2 = "PlatformPlasticSlopeBase2";
	RD_TURBO1 = "PlatformPlasticSpecialTurbo";
	RD_TURBO2 = "PlatformPlasticSpecialTurbo2";
	RD_TURBOR = "PlatformPlasticSpecialTurboRoulette";
	RD_CP = "PlatformPlasticCheckpoint";
	RD_END = "PlatformPlasticToDecoWall";
	RD_CONNECT = "PlatformPlasticToRoadTech";
	RD_BOOSTER1 = "PlatformPlasticSpecialBoost";
	RD_BOOSTER2 = "PlatformPlasticSpecialBoost2";
	RD_NOENGINE = "PlatformPlasticSpecialNoEngine";
	RD_SLOWMOTION = "PlatformPlasticSpecialSlowMotion";
	RD_FRAGILE = "PlatformPlasticSpecialFragile";
	RD_NOSTEER = "PlatformPlasticSpecialNoSteering";	
	RD_RESET = "PlatformPlasticSpecialReset";
	RD_CRUISE = "PlatformPlasticSpecialCruise";
	RD_NOBRAKE = "PlatformPlasticSpecialNoBrake";
	RD_COOL1 = "PlatformPlasticBaseWithHole24m";
	RD_COOL2 = "PlatformPlasticSlope2Start";
}	
}
//--