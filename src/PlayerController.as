package  
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class PlayerController extends GameObject
	{
		private var player:Player;
		public function PlayerController(game_:Game, player_:Player) 
		{
			super(game_);
			player = player_;
			game.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			game.stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			game.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			game.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			game.stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		}
		
		public function keyDown(event:KeyboardEvent)
		{
			trace("FU", getTimer());
			if (event.keyCode == Keyboard.LEFT || event.charCode == 65 || event.charCode == 97)
			{
				trace("moving left");
				player.startMovingLeft();
				
			}
			else if (event.keyCode == Keyboard.RIGHT || event.charCode == 68 || event.charCode == 100)
			{
				trace("moving right");
				player.startMovingRight();
				
			}
			if (event.keyCode == Keyboard.UP || event.charCode == 87 || event.charCode == 119)
			{
				trace("moving up");
				player.startMovingUp();
				
			}
			else if (event.keyCode == Keyboard.DOWN || event.charCode == 83 || event.charCode == 115)
			{
				trace("moving down");
				player.startMovingDown();
				
			}
		}

		public function keyUp(event:KeyboardEvent)
		{
			
			if (event.keyCode == Keyboard.LEFT || event.charCode == 65 || event.charCode == 97)
			{
				
				player.stopMovingLeft();
			}
			else if (event.keyCode == Keyboard.RIGHT || event.charCode == 68 || event.charCode == 100)
			{
				player.stopMovingRight();
			}
			if (event.keyCode == Keyboard.UP || event.charCode == 87 || event.charCode == 119)
			{
				player.stopMovingUp();
			}
			else if (event.keyCode == Keyboard.DOWN || event.charCode == 83 || event.charCode == 115)
			{
				player.stopMovingDown();
			}
		}
		
		public function mouseMove(event:MouseEvent)
		{
			player.adjustGun(new Vec(event.stageX, event.stageY));
		}

		public function mouseDown(event:MouseEvent)
		{
			player.startShooting();
		}
		
		public function mouseUp(event:MouseEvent)
		{
			player.stopShooting();
		}
		
	}
	
}