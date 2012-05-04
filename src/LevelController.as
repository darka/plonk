package  
{
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class LevelController extends GameMode
	{
		public var background:SpriteWidget;
		public var playfield:Playfield;
		private var playerController:PlayerController;
		private var controlsInfoDialog:SpriteWidget;
		private var gameInterface:GameInterface;
		
		private var inGameMeny:InGameMenu;
		
		private var level:Level;
		
		public function LevelController(game_:Game) 
		{
			super(game_);
		}
		
		public override function start()
		{
			background = new SpriteWidget(game, new BlueBackgroundSprite(), new Vec( -100, 0));
			playfield = new Playfield(game);
			playerController = new PlayerController(game, playfield.player);
		
			//game.registerTimer(50, 1, function()
			//{
				controlsInfoDialog = new SpriteWidget(game, new ControlsInfoDialogSprite(), 
				                                      new Vec(game.windowWidth / 2, game.windowHeight / 2 - 30));
				controlsInfoDialog.fadeIn();
				game.registerTimer(250, 1, controlsInfoDialog.fadeOut);
				game.registerTimer(500, 1, function() { controlsInfoDialog.unregister(); controlsInfoDialog = null; } );
			//});
			
			gameInterface = new GameInterface(game);
			loadLevel(new LevelOne(game));
			
		}
		
		public override function update()
		{
			if (controlsInfoDialog) controlsInfoDialog.bringToFront();
			if (playfield)
			{
				if (!playfield.destroyed && playfield.player.dead)
				{
					playfield.destroy();
				}
				playfield.update();
			}
			gameInterface.update();
		}
		
		public function loadLevel(level_:Level)
		{
			level = level_;
			game.registerTimer(450, 1, function() { gameInterface.showLevelText(level.name, level.outline) });
		}
	}
	
}