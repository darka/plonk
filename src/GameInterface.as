package 
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class GameInterface 
	{
		private var game:Game;
		private var player:Player;
		private var background:SpriteWidget;
		private var healthDisplay:TextField;
		private var scoreDisplay:TextField;
		
		private var levelTitleDisplay:TextField;
		private var levelOutlineDisplay:TextField;
		
		private var fpsDisplay:TextField;
		private var frames:Number;
		private var fps:Number;
		private var nextTick:Number;
		
		public function GameInterface(game_:Game)
		{
			game = game_;
			player = game.getPlayfield().player;
			background = new SpriteWidget(game, new InterfaceBackgroundSprite(), new Vec(0, 0));
			background.fadeIn();
			
			healthDisplay = new TextField();
			scoreDisplay = new TextField();
			
			var healthDisplayFormat:TextFormat = new TextFormat();
			healthDisplayFormat.font = "Tahoma";
			healthDisplayFormat.color = 0xCB3333;
			healthDisplayFormat.bold = true;
			healthDisplayFormat.size = 25;
			healthDisplayFormat.align = "center";
			
			healthDisplay.defaultTextFormat = healthDisplayFormat;
			healthDisplay.alpha = 1.0;
			healthDisplay.x = 67;
			healthDisplay.y = 414;
			
			healthDisplay.width = 56;
			healthDisplay.mouseEnabled = false;
			healthDisplay.text = String(100);
			
			
			var scoreDisplayFormat:TextFormat = new TextFormat();
			scoreDisplayFormat.font = "Tahoma";
			scoreDisplayFormat.color = 0x112244;
			scoreDisplayFormat.bold = true;
			scoreDisplayFormat.size = 25;
			scoreDisplayFormat.align = "right";
			
			scoreDisplay.defaultTextFormat = scoreDisplayFormat;
			scoreDisplay.alpha = 0.4;
			scoreDisplay.x = 435;
			scoreDisplay.y = healthDisplay.y;
			scoreDisplay.width = 177;
			scoreDisplay.text = "0";
			scoreDisplay.mouseEnabled = false;

			
			Fading.fadeIn(game, healthDisplay, 0.7);
			Fading.fadeIn(game, scoreDisplay, 0.4);
			game.addChild(healthDisplay);
			game.addChild(scoreDisplay);
			
			// FPS CODE
			
			fpsDisplay = new TextField();
			var fpsDisplayFormat:TextFormat = new TextFormat();
			fpsDisplayFormat.font = "Tahoma";
			fpsDisplayFormat.color = 0xFFFFFF;
			fpsDisplayFormat.size = 12;
			fpsDisplayFormat.align = "left";
			
			fpsDisplay.defaultTextFormat = fpsDisplayFormat;
			fpsDisplay.x = 0;
			fpsDisplay.y = 0;
			game.addChild(fpsDisplay);
			
			frames = 0;
			fps = 0;
			nextTick = 0;
		}
		
		
		public function update()
		{
			background.bringToFront();
			game.setChildIndex(healthDisplay, game.numChildren - 1);
			game.setChildIndex(scoreDisplay, game.numChildren - 1);
			healthDisplay.text = String(player.health);
			scoreDisplay.text = String(game.score);
			background.update();
			
			// FPS CODE PROBABLY SHOULDN'T BE HERE SO FU
			frames += 1;
			var time:int = getTimer();
			if (time >= nextTick)
			{
				fps = frames;
				frames = 0;
				nextTick += 1000;
			}
			fpsDisplay.text = "FPS: ".concat(String(fps));
			game.setChildIndex(fpsDisplay, game.numChildren - 1);
			
			if (levelTitleDisplay) game.setChildIndex(levelTitleDisplay, game.numChildren - 1);
			if (levelOutlineDisplay) game.setChildIndex(levelOutlineDisplay, game.numChildren - 1);
			
		}
		
		public function showLevelText(levelTitle:String, levelOutline:String)
		{
			const scaleFactor = 3;
			levelTitleDisplay = new TextField();
			var levelTitleDisplayFormat:TextFormat = new TextFormat();
			levelTitleDisplayFormat.font = "Tahoma";
			levelTitleDisplayFormat.color = 0xFFFFFF;
			levelTitleDisplayFormat.bold = true;
			levelTitleDisplayFormat.size = 25;
			levelTitleDisplayFormat.align = "center";
			
			levelTitleDisplay.defaultTextFormat = levelTitleDisplayFormat;
			//levelTitleDisplay.alpha = 0.6;
			levelTitleDisplay.x = 0;
			levelTitleDisplay.y = 20;
			levelTitleDisplay.width = game.windowWidth/scaleFactor;
			levelTitleDisplay.text = levelTitle;
			//levelTitleDisplay.selectable = false;
			levelTitleDisplay.sharpness = -399;
			levelTitleDisplay.mouseEnabled = false;
			
			levelTitleDisplay.scaleX *= scaleFactor;
			levelTitleDisplay.scaleY *= scaleFactor;
			
			game.addChild(levelTitleDisplay);
		
			levelOutlineDisplay = new TextField();
			var levelOutlineDisplayFormat:TextFormat = new TextFormat();
			levelOutlineDisplayFormat.font = "Tahoma";
			levelOutlineDisplayFormat.color = 0xFFFFFF;
			levelOutlineDisplayFormat.bold = true;
			levelOutlineDisplayFormat.size = 7;
			levelOutlineDisplayFormat.align = "center";
			
			levelOutlineDisplay.defaultTextFormat = levelOutlineDisplayFormat;
			levelOutlineDisplay.alpha = 0;
			levelOutlineDisplay.x = 0;
			levelOutlineDisplay.y = 110;
			levelOutlineDisplay.width = game.windowWidth / scaleFactor;
			levelOutlineDisplay.text = levelOutline;
			//levelOutlineDisplay.selectable = false;
			levelOutlineDisplay.mouseEnabled = false;
			
			
			levelOutlineDisplay.scaleX *= scaleFactor;
			levelOutlineDisplay.scaleY *= scaleFactor;
			
			game.addChild(levelOutlineDisplay);
			
			Fading.fadeIn(game, levelTitleDisplay, 0.6, 0.1);
			game.registerTimer(100, 1, function() { Fading.fadeIn(game, levelOutlineDisplay, 0.6, 0.1); } );
			game.registerTimer(250, 1, function() 
			{ 
				Fading.fadeOut(game, levelTitleDisplay); 
				Fading.fadeOut(game, levelOutlineDisplay);
			});
			game.registerTimer(300, 1, function() 
			{ 
				game.removeChild(levelTitleDisplay);
				game.removeChild(levelOutlineDisplay);
				levelTitleDisplay = null;
				levelOutlineDisplay = null;
			});
		}
	}
	
}