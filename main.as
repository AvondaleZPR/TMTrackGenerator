//vars
bool display = false, preloaded = false;
int st_maxBlocks = 45;
//--

void Main()
{
	TechBlocks();
	
	auto app = cast<CTrackMania>(GetApp());
	if(app is null)
	{
		return;
	}
	CGamePlayerInfo@ playerInfo = cast<CTrackManiaNetwork@>(app.Network).PlayerInfo;
	if(playerInfo is null)
	{
		return;
	}
	seedText = playerInfo.Name;
	seedText = seedText.ToUpper();
}

void TGprint(string str)
{
	if(st_debug)
	{
		print(str);
	}
}

void RenderMenu()
{
	if (UI::MenuItem("\\$f00" + Icons::Random + "\\$fff Track Generator")) {	
		if (cast<CGameCtnEditorFree>(cast<CTrackMania>(GetApp()).Editor) is null) {
			warn("editor is not opened!");
			return;
		}
		
		display = !display;
	}
}

void RenderInterface()
{
	if(!display)
	{
		return;
	}
	
	UI::SetNextWindowSize(666, 490);
	UI::SetNextWindowPos(300, 300, UI::Cond::Once);
	
	UI::Begin("Track Generator", display, UI::WindowFlags::NoResize);	
	if (UI::Button(Icons::Random + " Generate Random Track")) {
		Begin();
	}
	UI::SameLine();
	if (UI::Button(Icons::Download + " Preload Blocks")) {
		Preload();
	}
	UI::SameLine();
	if (UI::Button(Icons::Trash + " Clear Map")) {
		Undo();
	}
	if(!preloaded) {UI::Text("\\$ff0\\$s" + Icons::ExclamationCircle +" It is recommended to preload the blocks before generating a track.");}
	
	UI::Separator();
	UI::Markdown("**Block Count**");
	st_maxBlocks = UI::SliderInt("(excluding start and finish)", st_maxBlocks, 5, 125);
	
	UI::Separator();
	UI::Markdown("**Block Style**");
	roadblocks = UI::Checkbox("Tech", roadblocks);
	if (roadblocks) {TechBlocks();}
	UI::SameLine();
	dirtblocks = UI::Checkbox("Dirt", dirtblocks);
	if (dirtblocks) {DirtBlocks();}
	UI::SameLine();
	iceblocks = UI::Checkbox("Ice", iceblocks);
	if (iceblocks) {IceBlocks();}
	UI::SameLine();
	sausageblocks = UI::Checkbox("Sausage", sausageblocks);
	if (sausageblocks) {SausageBlocks();}
	if(IsMultipleBlockTypesSelected()) {
		UI::Text("\\$ff0\\$s" + Icons::ExclamationTriangle +" Using  multiple styles will sometimes (like 1/20) cause Generator to get stuck at building the track.");
		UI::Text("\\$ff0\\$sHopefully i will figure out the reasons and fix it in the next versions.");
	}
	
	UI::Separator();
	UI::Markdown("**Seed**");
	UI::Text("\\$sTrack will be generated from this text. Same text with same settings will generate same track every time.");
	UI::Text("\\$ff0\\$s" + Icons::ExclamationCircle + " Max 10 characters!");
	seedEnabled = UI::Checkbox("Enable", seedEnabled); UI::SameLine();
	bool changed = false;
	UI::Text("\\$080\\$s" + Icons::Key + " Seed:"); UI::SameLine();
	seedText = UI::InputText("", seedText, changed, UI::InputTextFlags::CharsUppercase);
	seedText = seedText.SubStr(0, 10);
	if (changed && seedEnabled) {
		if(seedText.get_Length() > 0)
		{
			seedDouble = ConvertSeed(seedText);
		}
		else
		{
			seedEnabled = false;
		}
	}
	UI::Separator();
	
	UI::Markdown("**Special Blocks**");
	UI::Text("\\$ff0\\$s" + Icons::ExclamationCircle + " Some of those blocks can make track unbeatable.");
	turbo1 = UI::Checkbox("Turbo", turbo1); UI::SameLine();
	turbo2 = UI::Checkbox("Super Turbo", turbo2); UI::SameLine();
	booster1 = UI::Checkbox("Reactor Boost", booster1); UI::SameLine();
	noengine = UI::Checkbox("\\$ff0Engine Off", noengine); 
	reset = UI::Checkbox("Reset Block", reset); UI::SameLine();
	slowmotion = UI::Checkbox("Riolu Block", slowmotion); UI::SameLine();	
	fragile = UI::Checkbox("Fragile", fragile); UI::SameLine();	
	nosteer = UI::Checkbox("\\$ff0No Steering", nosteer); 
	UI::Separator();
	
	UI::Text("\\$999\\$sversion " + Meta::GetPluginFromSiteID(156).get_Version() + " by AvondaleZPR");
	UI::End();
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

void Begin()
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
	
	map.RemoveAllBlocks();	
	if(IsMultipleBlockTypesSelected())
	{
		RandomBlocks();
	}
	
	seedDouble = ConvertSeed(seedText);
	
	TGprint("\\$0f0\\$sGenerating new track!");
	
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
	
	PlaceBlock(map, RD_START, dir, point);
	TGprint("Created START block, at " + tostring(point) + ", pointing " + tostring(dir));
	auto prevBlock = map.GetBlock(point);
	map.SetBlockSkin(prevBlock, BANNER_LINK);
	point = point.opAdd(MoveDir(dir));
	
	int blockCantBePlacedCount = 0;

	for	(int blockIndex = 1; blockIndex <= st_maxBlocks; blockIndex++)
	{
		if(blockCantBePlacedCount >= 50)
		{
			TGprint("\\$f00cant continue the track atfter " + tostring(blockIndex) + " blocks placed :(");
			break;
		}
		
		blockType = CURR_BLOCKS;
		
		string block = RandomBlock();
		auto dirCopy = dir;
		auto pointCopy = point;
		int turn = MathRand(1,3);
		bool blockPlaced = false;
		bool techConnect = false;
		
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
			if(turn == 2 && point.y >= 12)
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
			if(CURR_BLOCKS == "TechBlocks") 
			{
				techConnect = true;
				block = RD_STRAIGHT;
			}
			if(CanPlaceBlock(map, block, dir, point.opAdd(MoveDir(dir))) && CanPlaceBlock(map, block, dir, point.opAdd(MoveDir(dir)).opAdd(MoveDir(dir))))
			{
				TGprint("Switch Block Type");
				dir = TurnDirLeft(dir);
				dir = TurnDirLeft(dir);
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
				if (CURR_BLOCKS != "TechBlocks")
				{	
					PlaceBlock(map, RD_CONNECT, dir, point);
				}
				else
				{
					PlaceBlock(map, RD_STRAIGHT, dir, point);
				}
				connectPoint = point;
				TGprint("placed connect point at " + tostring(connectPoint));
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

			if(wasBlockTypeSwitched || block == RD_CONNECT || techConnect)
			{
				TGprint("removing connect point from " + tostring(connectPoint));

				map.RemoveBlock(connectPoint);
				prevDir = prevPrevDir;
				prevPoint = prevPrevPoint;
			}
			SetBlockType(prevBlockType);
			point = prevPoint;
			dir = prevDir;
			
			blockIndex--;
			blockCantBePlacedCount++;
			continue;
		}
		//--
		
		wasBlockTypeSwitched = false;
		if(block == RD_CONNECT || techConnect)
		{
			wasBlockTypeSwitched = true;
		}
		
		TGprint("Placed " + block + " block, at " + tostring(prevPoint));
		@prevBlock = map.GetBlock(prevPoint);	
		prevDir = dir;
		prevPrevDir = dir;
		prevPrevPoint = prevPoint;
		prevPoint = point;
		prevBlockType = blockType;
		blockCantBePlacedCount = 0;
	}
	
	if (!PlaceBlock(map, RD_FINISH, dir, point))
	{
		warn("cant place finish");
		return;
	}	
	@prevBlock = map.GetBlock(point);
	map.SetBlockSkin(prevBlock, BANNER_LINK);
	TGprint("Created FINISH block at " + tostring(point));
	
	TGprint("\\$0f0\\$sTrack generated in "+ tostring(Time::get_Now() - before) + " milliseconds!");
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

//Block Placement
bool PlaceBlock(CGameEditorPluginMap@ map, string blockName, CGameEditorPluginMap::ECardinalDirections dir, int3 point)
{
    auto info = map.GetBlockModelFromName(blockName);

    while (!map.IsEditorReadyForRequest) {
        yield();
    }

    return map.PlaceBlock(info, point, dir);
}

bool CanPlaceBlock(CGameEditorPluginMap@ map, string blockName, CGameEditorPluginMap::ECardinalDirections dir, int3 point)
{
	auto info = map.GetBlockModelFromName(blockName);

    while (!map.IsEditorReadyForRequest) {
        yield();
    }

    return map.CanPlaceBlock(info, point, dir, true, 0);
}

CGameEditorPluginMapConnectResults@ ConnectBlocks(CGameEditorPluginMap@ map, CGameCtnBlock@ eBlock, string nBlock)
{
	try
    {
		auto info = map.GetBlockModelFromName(nBlock);

		while (!map.IsEditorReadyForRequest) {
			yield();
		}
		map.GetConnectResults(eBlock, info);
		
		while (!map.IsEditorReadyForRequest) {
			yield();
		}
		
		if (map.ConnectResults.Length > 0 && !(map.ConnectResults[map.ConnectResults.Length-1] is null))
		{
			return map.ConnectResults[map.ConnectResults.Length-1];
		}
		return null;
    }
    catch
    {
		return null;
    }
}
//--

//direction shit
int3 MoveDir(CGameEditorPluginMap::ECardinalDirections dir)
{
	switch(dir)
	{
		case CGameEditorPluginMap::ECardinalDirections::North:
			return int3(0,0,1);
		case CGameEditorPluginMap::ECardinalDirections::East:
			return int3(-1,0,0);
		case CGameEditorPluginMap::ECardinalDirections::South:
			return int3(0,0,-1);
		case CGameEditorPluginMap::ECardinalDirections::West:
			return int3(1,0,0);			
	}
	
	return int3(1,0,1);
}

CGameEditorPluginMap::ECardinalDirections TurnDirLeft(CGameEditorPluginMap::ECardinalDirections dir)
{
	switch(dir)
	{
		case CGameEditorPluginMap::ECardinalDirections::North:
			return CGameEditorPluginMap::ECardinalDirections::West;
		case CGameEditorPluginMap::ECardinalDirections::East:
			return CGameEditorPluginMap::ECardinalDirections::North;
		case CGameEditorPluginMap::ECardinalDirections::South:
			return CGameEditorPluginMap::ECardinalDirections::East;
		case CGameEditorPluginMap::ECardinalDirections::West:
			return CGameEditorPluginMap::ECardinalDirections::South;			
	}
	
	return CGameEditorPluginMap::ECardinalDirections::North;
}

CGameEditorPluginMap::ECardinalDirections TurnDirRight(CGameEditorPluginMap::ECardinalDirections dir)
{
	switch(dir)
	{
		case CGameEditorPluginMap::ECardinalDirections::North:
			return CGameEditorPluginMap::ECardinalDirections::East;
		case CGameEditorPluginMap::ECardinalDirections::East:
			return CGameEditorPluginMap::ECardinalDirections::South;
		case CGameEditorPluginMap::ECardinalDirections::South:
			return CGameEditorPluginMap::ECardinalDirections::West;
		case CGameEditorPluginMap::ECardinalDirections::West:
			CGameEditorPluginMap::ECardinalDirections::North;
	}
	
	return CGameEditorPluginMap::ECardinalDirections::North;
}

CGameEditorPluginMap::ECardinalDirections ConvertDir(CGameEditorPluginMapConnectResults::ECardinalDirections dir)
{
	switch(dir)
	{
		case CGameEditorPluginMapConnectResults::ECardinalDirections::North:
			return CGameEditorPluginMap::ECardinalDirections::North;	
		case CGameEditorPluginMapConnectResults::ECardinalDirections::East:
			return CGameEditorPluginMap::ECardinalDirections::East;
		case CGameEditorPluginMapConnectResults::ECardinalDirections::South:
			return CGameEditorPluginMap::ECardinalDirections::South;
		case CGameEditorPluginMapConnectResults::ECardinalDirections::West:
			return CGameEditorPluginMap::ECardinalDirections::West;
	}
	
	return CGameEditorPluginMap::ECardinalDirections::North;
}
//--