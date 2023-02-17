bool HAS_ADVANCED_EDITOR = false;

//vars
bool display = false, preloaded = false;
bool st_useCpBlocks = false;
bool tabTrack = true, tabScenery = false;
int st_maxBlocks = 45, st_cpBlocks = 10;
//--

void RenderMenu()
{
	HAS_ADVANCED_EDITOR = Permissions::OpenAdvancedMapEditor();

	if (UI::MenuItem("\\$f00" + Icons::Random + "\\$fff Track Generator") && CanDisplay()) {	
		
		display = !display;
	}
}

void RenderInterface()
{
	if(!display)
	{
		return;
	}
	
	UI::SetNextWindowSize(686, 733);
	UI::SetNextWindowPos(300, 300, UI::Cond::Once);
	
	UI::Begin("Track Generator", display, UI::WindowFlags::NoResize);	
	UI::BeginTabBar("yep", UI::TabBarFlags::None);
	
		UI::PushStyleColor(UI::Col::Tab, vec4(0.7f, 0.0f, 0.0f, 1) * vec4(0.5f, 0.5f, 0.5f, 0.75f));
		UI::PushStyleColor(UI::Col::TabHovered, vec4(0.7f, 0.0f, 0.0f, 1) * vec4(1.2f, 1.2f, 1.2f, 0.85f));
		UI::PushStyleColor(UI::Col::TabActive, vec4(0.7f, 0.0f, 0.0f, 1));	
		if(UI::BeginTabItem("Track Generator", tabTrack, UI::TabItemFlags::NoCloseWithMiddleMouseButton))
		{
			UI::BeginChild("Tab");
			RenderTrackGenerator();
			UI::EndChild();
			UI::EndTabItem();
		}
		UI::PopStyleColor(3);
		
		UI::PushStyleColor(UI::Col::Tab, vec4(0.0f, 0.7f, 0.0f, 1) * vec4(0.5f, 0.5f, 0.5f, 0.75f));
		UI::PushStyleColor(UI::Col::TabHovered, vec4(0.0f, 0.7f, 0.0f, 1) * vec4(1.2f, 1.2f, 1.2f, 0.85f));
		UI::PushStyleColor(UI::Col::TabActive, vec4(0.0f, 0.7f, 0.0f, 1));	
		if(UI::BeginTabItem("Scenery Generator", tabScenery, UI::TabItemFlags::None))
		{
			UI::BeginChild("Tab");
			RenderSceneryGenerator();
			UI::EndChild();
			UI::EndTabItem();
		}
		UI::PopStyleColor(3);
	
	UI::EndTabBar();
	UI::End();
}

void RenderTrackGenerator()
{
	if (UI::Button(Icons::Random + " Generate Random Track")) {
		Begin();
	}
	/*
	UI::SameLine();
	if (UI::Button(Icons::Download + " Preload Blocks")) {
		Preload();
	}
	*/
	UI::SameLine();
	if (UI::Button(Icons::Trash + " Clear Map")) {
		Undo();
	}
	//if(!preloaded) {UI::Text("\\$ff0\\$s" + Icons::ExclamationCircle +" It is recommended to preload the blocks before generating a track.");}
	if(!HAS_ADVANCED_EDITOR) {UI::Text("\\$f00\\$s" + Icons::ExclamationTriangle +" Some blocks and block styles are not available since you've only got a Starter Edition!");}
	
	UI::Separator();
	UI::Markdown("**Block Count**");
	st_maxBlocks = UI::SliderInt("\\$bbb(excluding start and finish)", st_maxBlocks, 5, MAX_X + MAX_Z + (MAX_X + MAX_Z) / 2);
	UI::Text("\\$ff0\\$s" + Icons::ExclamationCircle +" Generated track doesn't always has the exact number of blocks, because Track Generator");
	UI::Text("\\$ff0\\$sisn't perfect and it can get stuck. In that case Track Generator will just try to place the finish block.");
	
	UI::Separator();
	UI::Markdown("**Block Style**");
	roadblocks = UI::Checkbox("Tech Road", roadblocks);
	if (roadblocks) {blocks::TechBlocks();}
	UI::SameLine();
	dirtblocks = UI::Checkbox("Dirt Road", dirtblocks);
	if (dirtblocks) {blocks::DirtBlocks();}
	UI::SameLine();
	iceblocks = UI::Checkbox("Ice Road", iceblocks) && HAS_ADVANCED_EDITOR;
	if (iceblocks) {blocks::IceBlocks();}
	UI::SameLine();
	icewallblocks = UI::Checkbox("Ice Road With Wall", icewallblocks);
	if (icewallblocks) {blocks::IceWallBlocks();}
	UI::SameLine();
	sausageblocks = UI::Checkbox("Sausage Road", sausageblocks);
	if (sausageblocks) {blocks::SausageBlocks();}
	platformtechblocks = UI::Checkbox("Tech Platform", platformtechblocks) && HAS_ADVANCED_EDITOR;
	if (platformtechblocks) {blocks::PlatformTechBlocks();}	
	UI::SameLine();
	platformdirtblocks = UI::Checkbox("Dirt Platform", platformdirtblocks) && HAS_ADVANCED_EDITOR;
	if (platformdirtblocks) {blocks::PlatformDirtBlocks();}	
	UI::SameLine();
	platformiceblocks = UI::Checkbox("Ice Platform", platformiceblocks) && HAS_ADVANCED_EDITOR;
	if (platformiceblocks) {blocks::PlatformIceBlocks();}	
	UI::SameLine();
	platformgrassblocks = UI::Checkbox("Grass Platform", platformgrassblocks) && HAS_ADVANCED_EDITOR;
	if (platformgrassblocks) {blocks::PlatformGrassBlocks();}		
	UI::SameLine();
	plasticblocks = UI::Checkbox("Plastic Platform", plasticblocks) && HAS_ADVANCED_EDITOR;
	if (plasticblocks) {blocks::PlasticBlocks();}		
	opentechroadblocks = UI::Checkbox("Platform Tech Road", opentechroadblocks) && HAS_ADVANCED_EDITOR;
	if (opentechroadblocks) {blocks::OpenTechRoadBlocks();}
	UI::SameLine();
	opendirtroadblocks = UI::Checkbox("Platform Dirt Road", opendirtroadblocks) && HAS_ADVANCED_EDITOR;
	if (opendirtroadblocks) {blocks::OpenDirtRoadBlocks();}
	UI::SameLine();
	openiceroadblocks = UI::Checkbox("Platform Ice Road", openiceroadblocks) && HAS_ADVANCED_EDITOR;
	if (openiceroadblocks) {blocks::OpenIceRoadBlocks();}
	UI::SameLine();
	opengrassroadblocks = UI::Checkbox("Platform Grass Road", opengrassroadblocks) && HAS_ADVANCED_EDITOR;
	if (opengrassroadblocks) {blocks::OpenGrassRoadBlocks();}
	waterblocks = UI::Checkbox("Water Road", waterblocks) && HAS_ADVANCED_EDITOR;
	if (waterblocks) {blocks::WaterBlocks();}	
	
	/*
	if(IsMultipleBlockTypesSelected()) {
		UI::Text("\\$ff0\\$s" + Icons::ExclamationTriangle +" Using  multiple styles will sometimes (like 1/20) cause Generator to get stuck at building the track.");
		UI::Text("\\$ff0\\$sHopefully i will figure out the reasons and fix it in the next versions.");
	}
	*/
	
	UI::Separator();
	UI::Markdown("**Seed**");
	UI::Text("\\$sTrack will be generated from this text. Same text with same settings will generate same track every time.");
	UI::Text("\\$ff0\\$s" + Icons::ExclamationCircle + " Max 10 characters!");
	seedEnabled = UI::Checkbox("Enable", seedEnabled); UI::SameLine();
	bool changed = false;
	UI::Text("\\$080\\$s" + Icons::Key + " Seed:"); UI::SameLine();
	seedText = UI::InputText("##seedText", seedText, changed, UI::InputTextFlags::CharsUppercase); UI::SameLine();
	if (UI::Button(Icons::Random)) {
		seedText = RandomSeed(Math::Rand(1,10));
	}
	seedText = seedText.SubStr(0, 10);
	if (changed && seedEnabled) {
		if(seedText.Length > 0)
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
	turbo2 = UI::Checkbox("Super Turbo", turbo2) && HAS_ADVANCED_EDITOR; UI::SameLine();
	turbor = UI::Checkbox("Turbo R", turbor) && HAS_ADVANCED_EDITOR; UI::SameLine();
	booster1 = UI::Checkbox("Reactor Boost", booster1); UI::SameLine();
	booster2 = UI::Checkbox("Super Reactor Boost", booster2) && HAS_ADVANCED_EDITOR; UI::SameLine();
	noengine = UI::Checkbox("\\$ff0Engine Off", noengine); 
	reset = UI::Checkbox("Reset Block", reset); UI::SameLine();
	slowmotion = UI::Checkbox("Slow Motion", slowmotion); UI::SameLine();	
	fragile = UI::Checkbox("Fragile", fragile); UI::SameLine();
	cruise = UI::Checkbox("Cruise", cruise) && HAS_ADVANCED_EDITOR; UI::SameLine();
	nobrake = UI::Checkbox("No Brakes", nobrake) && HAS_ADVANCED_EDITOR; UI::SameLine();
	nosteer = UI::Checkbox("\\$ff0No Steering", nosteer); 
	UI::Separator();
	
	/*
	UI::Markdown("**Items**");
	UI::Separator();
	*/
	
	UI::Markdown("**Other Options**");
	coolblocks = UI::Checkbox("Use cool blocks \\$bbb(Tech Ramps, Dirt Bumps, etc)", coolblocks) && HAS_ADVANCED_EDITOR; 
	randomcolors = UI::Checkbox("Paint blocks with random colors \\$bbb(Doesn't get affected by seed)", randomcolors);
	
	st_useCpBlocks = UI::Checkbox("Place checkpoint after " + st_cpBlocks + " blocks", st_useCpBlocks); 
	st_cpBlocks = UI::SliderInt("\\$bbbBlocks between checkpoints", st_cpBlocks, 2, 30);
	
	UI::Separator();
	UI::Text("\\$999\\$sTrack Generator " + Meta::GetPluginFromSiteID(156).Version + " by \\$bbbAvondaleZPR \\$999" + Icons::Copyright);	
}

void RenderSceneryGenerator()
{
	if (UI::Button(Icons::Random + " Generate Random Scenery") && HAS_ADVANCED_EDITOR) {
		BeginScenery();
	}
	UI::SameLine();
	if (UI::Button(Icons::Trash + " Undo Last Scenery")) {
		CancelScenery();
	}
	UI::Separator();
	
	randomcolors = UI::Checkbox("Paint blocks with random colors \\$bbb", randomcolors);
	
	UI::Separator();
	UI::Text("\\$999\\$sTrack Generator " + Meta::GetPluginFromSiteID(156).Version + " by \\$bbbAvondaleZPR \\$999" + Icons::Copyright);
}

void Main()
{
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
	
	blocks::TechBlocks();
	
	MainThinker();
}

void MainThinker()
{
	if (display && !CanDisplay())
	{
		display = false;
	}
	
	if (display)
	{
		LoadMapSize();
	}
	
	sleep(1000);
	MainThinker();
}