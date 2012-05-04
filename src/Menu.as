package 
{
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class Menu extends GameMode
	{
		private var widgets:Array;
		
		private var menuOrbPadStartPos:Vec = new Vec(660, -40);
		private var menuOrbStartPos = new Vec(-550, 16);
		private var menuButtonStartPos:Vec = new Vec(1032, 152);
		
		private var menu:WidgetContainer;
		private var menuOrbPad:SpriteWidget;
		private var menuOrb:SpriteWidget
		private var menuButton:Button;
		
		public function Menu(game_:Game)
		{
			super(game_);
			widgets = new Array();
		}
		
		public override function start()
		{
			showMainMenu();
		}
		
		public function showMainMenu()
		{
			var background:SpriteWidget = new SpriteWidget(game, new BlueBackgroundSprite(), new Vec( -100, 0));
			widgets.push(background);
			game.registerTimer(60, 1, showGreyBackground);

		}
		
		public function showGreyBackground()
		{
			menu = new WidgetContainer(game);
			
			menuOrbPad = new SpriteWidget(game, new OrbPadSprite(), menuOrbPadStartPos);
			//var menuPlonkLogo:SpriteWidget = new SpriteWidget(game, new PlonkLogoSprite(), new Vec(1025, 80));
			var plonkLogo = new SpriteWidget(game, new PlonkLogoSprite(), menuButtonStartPos.sub(new Vec(-10, 60)));
			menuButton = new Button(game, new MenuButtonBigSprite(), menuButtonStartPos, hideGreyBackground);
			//menu.addWidget(menuPlonkLogo);
			menu.addWidget(menuOrbPad);
			menu.addWidget(menuButton);
			menu.addWidget(plonkLogo);
			
			menu.arriveWithSlowDown(new Vec(-1.0, 0.0), 1.1, 21, 0.957);
			
			menuOrb = new SpriteWidget(game, new OrbSprite(), menuOrbStartPos);
			menuOrb.arriveWithSlowDown(new Vec(1.0, 0.0), 1.1, 20, 0.8);
			
			widgets.push(menuOrb);
			widgets.push(menu);
		}
		
		public function hideGreyBackground()
		{
			menu.arriveWithSlowDown(new Vec( 1.0, 0.0), 1.1, 30, 0.957);
			menuOrb.arriveWithSlowDown(new Vec( -1.0, 0.0), 1.1, 20, 0.8);
			menuButton.unactivate();
			game.registerTimer(50, 1, prepareForGame);
		}
		
		public function prepareForGame()
		{
			game.startPlaying();
			unregisterWidgets();
		}
		
		public override function update()
		{
			for (var i = 0; i < widgets.length; ++i)
			{
				widgets[i].update();
			}
		}
		
		public function unregisterWidgets()
		{
			for (var i = 0; i < widgets.length; ++i)
			{
				widgets[i].unregister();
			}
		}

	}
	
}