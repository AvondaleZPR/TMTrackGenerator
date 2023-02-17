void Begin()
{
	uint64 before = Time::get_Now();

	//preparing
	auto app = cast<CTrackMania>(GetApp());
	if (app is null) {
		return;
	}
		
	auto editor = cast<CGameCtnEditorFree>(app.Editor);
	if (editor is null) {
		UI::ShowNotification("editor is not opened!");
		warn("editor is not opened!");
		return;
	}
	
	auto map = cast<CGameEditorPluginMap>(editor.PluginMapType);
	if (map is null) {
		return;
	}
	
	map.RemoveAllBlocks();	
	if(IsMultipleBlockTypesSelected())
	{
		RandomBlocks();
	}
	
	seedDouble = ConvertSeed(seedText);
	//--
	
	TGprint("\\$0f0\\$sGenerating new track!");
	
	//variables
	auto dir = RandomDirection();
	auto point = RandomPoint();
	auto prevDir = dir;
	auto prevPrevDir = dir;
	auto prevPoint = point;
	auto prevPrevPoint = point;
	auto connectPoint = int3(0,0,0);
	string blockType = CURR_BLOCKS;
	string prevBlockType = CURR_BLOCKS;
	bool wasBlockTypeSwitched = false;
	int blocksPlacedAfterCP = 0;
	//--
	
	//start block
	PlaceBlock(map, RD_START, dir, point);
	TGprint("Created START block, at " + tostring(point) + ", pointing " + tostring(dir));
	auto prevBlock = map.GetBlock(point);
	map.SetBlockSkin(prevBlock, BANNER_LINK);
	point = point.opAdd(MoveDir(dir));
	//--
	
	int blockCantBePlacedCount = 0;

	for	(int blockIndex = 1; blockIndex <= st_maxBlocks; blockIndex++)
	{
		if(blockCantBePlacedCount >= 50)
		{
			TGprint("\\$f00cant continue the track atfter " + tostring(blockIndex) + " blocks placed :(");
			break;
		}
		
		if(randomcolors)
		{
			map.NextMapElemColor = RandomColor();
		}
		
		blockType = CURR_BLOCKS;
		bool wasBlockTypeSwitchedLocal = false;
	
		string block = RandomBlock();
		auto dirCopy = dir;
		auto pointCopy = point;
		int turn = MathRand(1,3);
		bool blockPlaced = false;
		bool techConnect = false;
		
		if(st_useCpBlocks)
		{
			blocksPlacedAfterCP++;
			if(blocksPlacedAfterCP >= st_cpBlocks)
			{
				block = RD_CP;
			}
		}
		
		//special block check before
		if((block == RD_STRAIGHT && point.y == 9 && MathRand(1,8) == 4))
		{
			block = RD_END;
			dir = TurnDirLeft(dir);
			dir = TurnDirLeft(dir);
		}
		else if(block == RD_TURN1 || block == RD_TURN2 || block == RD_TURN3 || block == RD_TURN4)
		{
			if(block == RD_TURN2)
			{
				if (turn == 1)
				{
					TGprint("Turn Right");
					dir = TurnDirRight(dir);
					if(dir == DIR_EAST)
					{
						point = point.opAdd(MoveDir(dir));
					}
					else if(dir == DIR_WEST)
					{
						point = point.opAdd(MoveDir(TurnDirLeft(dir)));
					}
					else if(dir == DIR_SOUTH)
					{
						point = point.opAdd(MoveDir(dir)).opAdd(MoveDir(TurnDirLeft(dir)));
					}
				}
				else
				{
					TGprint("Turn Left");
					dir = TurnDirLeft(dir);
					dir = TurnDirLeft(dir);
					if(dir == DIR_EAST)
					{
						point = point.opAdd(MoveDir(TurnDirRight(dir)));
					}
					else if(dir == DIR_WEST)
					{
						point = point.opAdd(MoveDir(TurnDirRight(TurnDirRight(dir))));
					}
					else if(dir == DIR_NORTH)
					{
						point = point.opAdd(MoveDir(TurnDirRight(dir))).opAdd(MoveDir(TurnDirRight(TurnDirRight(dir))));
					}
				}
			}
			else
			{
				switch(turn)
				{	
					case 1:
						TGprint("Turn Right");
						dir = TurnDirRight(dir);
						break;
					case 2: 
						TGprint("Turn Left");
						dir = TurnDirLeft(dir);
						dir = TurnDirLeft(dir);
				}
			}
		}
		else if(block == RD_UP1 || block == RD_UP2)
		{
			if(point.y >= MAX_Y)
			{
				TGprint("WAYTOOHIGH");
				block = RD_STRAIGHT;
			}
			else if(turn == 2 && point.y >= 12)
			{
				dir = TurnDirLeft(dir);
				dir = TurnDirLeft(dir);
				if(block == RD_UP1)
				{
					point = point.opAdd(int3(0,-1,0));
				}
				else
				{
					point = point.opAdd(int3(0,-2,0));
				}
			}
		}
		else if(block == RD_CONNECT)
		{
			if(CURR_BLOCKS == "TechBlocks" || CURR_BLOCKS == "WaterBlocks") 
			{
				techConnect = true;
				block = RD_STRAIGHT;
			}
			if(CanPlaceBlock(map, block, dir, point.opAdd(MoveDir(dir))) && CanPlaceBlock(map, block, dir, point.opAdd(MoveDir(dir)).opAdd(MoveDir(dir))))
			{
				TGprint("Switch Block Type");
				if(CURR_BLOCKS != "OpenTechRoadBlocks" && CURR_BLOCKS != "OpenDirtRoadBlocks" && CURR_BLOCKS != "OpenIceRoadBlocks" && CURR_BLOCKS != "OpenGrassRoadBlocks" && CURR_BLOCKS != "PlatformTechBlocks" && CURR_BLOCKS != "PlatformDirtBlocks" && CURR_BLOCKS != "PlatformIceBlocks" && CURR_BLOCKS != "PlatformGrassBlocks" && CURR_BLOCKS != "PlasticBlocks")
				{
					dir = TurnDirLeft(dir);
					dir = TurnDirLeft(dir);
				}
				wasBlockTypeSwitchedLocal = true;
			}
			else 
			{
				techConnect = false;
				block = RD_STRAIGHT;
			}
		}
		else if(block == RD_BOOSTER1 || block == RD_BOOSTER2)
		{
			if (turn > 1)
			{
				dir = TurnDirLeft(dir);
				dir = TurnDirLeft(dir);
			}
		}
		//--
		
		//placing block
		if(CanPlaceBlock(map, block, dir, point))
		{
			PlaceBlock(map, block, dir, point);
			blockPlaced = true;
		}
		//--	

		if(blockPlaced)
		{
			//special block check after
			if(block == RD_END)
			{
				dir = dirCopy;
				point = point.opAdd(MoveDir(dir));
				if(MathRand(1,3) == 2)
				{
					if (CanPlaceBlock(map, block, dir, point.opAdd(MoveDir(dir))))
					{
						point = point.opAdd(MoveDir(dir));
					}
				}
				PlaceBlock(map, block, dir, point);
			}
			else if(block == RD_TURN1)
			{
				if(turn == 2)
				{
					dir = dirCopy;
					dir = TurnDirLeft(dir);
				}
			}
			else if(block == RD_TURN2)
			{
				if (turn == 1)
				{
					point = pointCopy.opAdd(MoveDir(dirCopy));
					dir = TurnDirRight(dirCopy);
					point = point.opAdd(MoveDir(dir));
				}
				else
				{
					point = pointCopy.opAdd(MoveDir(dirCopy));
					dir = TurnDirLeft(dirCopy);
					point = point.opAdd(MoveDir(dir));
				}
			}
			else if(block == RD_UP1 || block == RD_UP2)
			{
				if(turn == 2 && point.y >= 12)
				{
					dir = dirCopy;
				}
				else
				{
					if(block == RD_UP1)
					{
						point = point.opAdd(int3(0,1,0));
					}
					else
					{
						point = point.opAdd(int3(0,2,0));
					}
				}
			}
			else if(block == RD_CONNECT || techConnect)
			{
				dir = dirCopy;
				RandomBlocks();				
				
				point = point.opAdd(MoveDir(dir));
				
				if(CURR_BLOCKS == "OpenTechRoadBlocks" || CURR_BLOCKS == "OpenDirtRoadBlocks" || CURR_BLOCKS == "OpenIceRoadBlocks" || CURR_BLOCKS == "OpenGrassRoadBlocks" || CURR_BLOCKS == "PlatformTechBlocks" || CURR_BLOCKS == "PlatformDirtBlocks" || CURR_BLOCKS == "PlatformIceBlocks" || CURR_BLOCKS == "PlatformGrassBlocks" || CURR_BLOCKS == "PlasticBlocks")
				{
					dir = TurnDirLeft(dir);
					dir = TurnDirLeft(dir);					
				}
				
				if (CURR_BLOCKS != "TechBlocks" && CURR_BLOCKS != "WaterBlocks")
				{	
					PlaceBlock(map, RD_CONNECT, dir, point);
				}
				else
				{
					PlaceBlock(map, RD_STRAIGHT, dir, point);
				}
				connectPoint = point;
				TGprint("placed connect point at " + tostring(connectPoint));
				
				if(CURR_BLOCKS == "OpenTechRoadBlocks" || CURR_BLOCKS == "OpenDirtRoadBlocks" || CURR_BLOCKS == "OpenIceRoadBlocks" || CURR_BLOCKS == "OpenGrassRoadBlocks" || CURR_BLOCKS == "PlatformTechBlocks" || CURR_BLOCKS == "PlatformDirtBlocks" || CURR_BLOCKS == "PlatformIceBlocks" || CURR_BLOCKS == "PlatformGrassBlocks" || CURR_BLOCKS == "PlasticBlocks")
				{
					dir = dirCopy;
				}
			}
			else if(block == RD_CP)
			{
				auto checkpoint = map.GetBlock(point);
				map.SetBlockSkin(checkpoint, BANNER_LINK);
			}
			else if(block == RD_BOOSTER1 || block == RD_BOOSTER2)
			{
				dir = dirCopy;
			}
			//--
			
			//set point to the next block
			point = point.opAdd(MoveDir(dir));
			//--
		}	
		
		//check for the next 2 blocks
		if (!blockPlaced || !CanPlaceBlock(map, RD_STRAIGHT, dir, point) || !CanPlaceBlock(map, RD_STRAIGHT, dir, point.opAdd(MoveDir(dir))))
		{
			TGprint(block + " block cannot be placed at " + tostring(point) +", canceling previous one");
			map.RemoveBlock(prevPoint);

			if(st_useCpBlocks && block == RD_CP)
			{
				blocksPlacedAfterCP = blocksPlacedAfterCP-2;
			}

			if(wasBlockTypeSwitched)
			{
				TGprint("removing connect point from " + tostring(connectPoint));

				map.RemoveBlock(connectPoint);
				prevDir = prevPrevDir;
				prevPoint = prevPrevPoint;
				wasBlockTypeSwitchedLocal = false;
			}
			SetBlockType(prevBlockType);
			point = prevPoint;
			dir = prevDir;
			
			blockIndex--;
			blockCantBePlacedCount++;
			continue;
		}
		//--
		
		if(st_useCpBlocks && block == RD_CP)
		{
			blocksPlacedAfterCP = 0;
		}
		
		wasBlockTypeSwitched = wasBlockTypeSwitchedLocal;
		
		TGprint("Placed " + block + " block, at " + tostring(prevPoint));
		@prevBlock = map.GetBlock(prevPoint);	
		prevDir = dir;
		prevPrevDir = dir;
		prevPrevPoint = prevPoint;
		prevPoint = point;
		prevBlockType = blockType;
		blockCantBePlacedCount = 0;
	}
	
	//finish block
	bool finishPlaced = true;
	if (!PlaceBlock(map, RD_FINISH, dir, point))
	{	
		finishPlaced = false;
		for(int blockTypeIndex = 1; blockTypeIndex <= 4; blockTypeIndex++)
		{
			SetBlockType(blockTypeIndex);
			if (PlaceBlock(map, RD_FINISH, dir, point))
			{
				finishPlaced = true;
				break;
			}
		}
	}	
	if(!finishPlaced) 
	{ 
		warn("cant place finish");
		return; 
	}
	@prevBlock = map.GetBlock(point);
	map.SetBlockSkin(prevBlock, BANNER_LINK);
	TGprint("Created FINISH block at " + tostring(point));
	//--
	
	print("\\$0f0\\$sTrack generated in "+ tostring(Time::get_Now() - before) + " milliseconds!");
}

void Preload()
{
	uint64 before = Time::get_Now();
	auto app = cast<CTrackMania>(GetApp());
	if (app is null) {
		return;
	}
		
	auto editor = cast<CGameCtnEditorFree>(app.Editor);
	if (editor is null) {
		UI::ShowNotification("editor is not opened!");
		warn("editor is not opened!");
		return;
	}
	
	auto map = cast<CGameEditorPluginMap>(editor.PluginMapType);
	if (map is null) {
		return;
	}
	
	map.PreloadAllBlocks();
	preloaded = true;
	
	print("\\$080\\$sAll block preloaded in "+ tostring(Time::get_Now() - before) + " milliseconds!");
}

void Undo()
{
	auto app = cast<CTrackMania>(GetApp());
	if (app is null) {
		return;
	}
		
	auto editor = cast<CGameCtnEditorFree>(app.Editor);
	if (editor is null) {
		UI::ShowNotification("editor is not opened!");
		warn("editor is not opened!");
		return;
	}
	
	auto map = cast<CGameEditorPluginMap>(editor.PluginMapType);
	if (map is null) {
		return;
	}
	
	map.RemoveAllBlocks();
}