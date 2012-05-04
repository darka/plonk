package  
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class Button extends SpriteWidget
	{
		private var func:Function;
		private var playingForward:Boolean;
		private var playingBackward:Boolean;
		public function Button(game_:Game, sprite_:MovieClip, position_:Vec, func_:Function) 
		{
			super(game_, sprite_, position_);
			func = func_;
			game.stage.addEventListener(MouseEvent.MOUSE_DOWN, click);
			game.stage.addEventListener(MouseEvent.MOUSE_MOVE, checkMouseLocation);
			sprite_.gotoAndStop(0);
			playingForward = false;
			playingBackward = false;
		}
		
		public function click(event:MouseEvent)
		{
			if (mouseInside(event))
			{
				func();
			}
		}
		
		public function checkMouseLocation(event:MouseEvent)
		{
			if (mouseInside(event))
			{
				if (!playingForward)
				{
					playingBackward = false;
					playingForward = true;
				}
			}
			else
			{
				if (playingForward)
				{
					playingBackward = true;
					playingForward = false;
				}
			}
		}
		
		
		public override function update()
		{
			trace(playingForward);
			var sprite_:MovieClip;
			if (playingForward)
			{
				sprite_ = MovieClip(sprite);
				if (sprite_.currentFrame < sprite_.totalFrames - 1)
					sprite_.gotoAndStop(sprite_.currentFrame + 1);
			}
			else if (playingBackward)
			{
				sprite_ = MovieClip(sprite);
				if (sprite_.currentFrame > 0)
					sprite_.gotoAndStop(sprite_.currentFrame - 1);

			}
			super.update();
		}
		
		public function mouseInside(event:MouseEvent):Boolean
		{
			if (event.stageX > sprite.x && event.stageX < sprite.x + sprite.width &&
			    event.stageY > sprite.y && event.stageY < sprite.y + sprite.height)
			{
				return true;
			}
			return false;
		}
		
		public function unactivate()
		{
			game.stage.removeEventListener(MouseEvent.MOUSE_DOWN, click);
		}
	}
	
}