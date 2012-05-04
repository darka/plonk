package  
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class Fading 
	{
		public static function fadeIn(game:Game, sprite:DisplayObject, maxFade:Number, speed:Number = 0.05)
		{
			function partFade()
			{
				if (sprite.alpha + speed < maxFade)
					sprite.alpha += speed;
				else
					sprite.alpha = maxFade;
			}
			sprite.alpha = 0;
			game.registerTimer(5, 20, partFade);
		}

		public static function fadeOut(game:Game, sprite:DisplayObject)
		{
			function partFade()
			{
				if (sprite.alpha - 0.05 >= 0)
					sprite.alpha -= 0.05;
				else
					sprite.alpha = 0;
			}
			game.registerTimer(5, 20, partFade);
		}
		
		public static function quickFlash(game:Game, sprite:DisplayObject)
		{
			function flashOut()
			{
				sprite.alpha -= 0.25;
			}
			function flashIn()
			{
				sprite.alpha += 0.25;
			}
			game.registerTimer(1, 4, flashOut);
			game.registerTimer(4, 1, function() { game.registerTimer(1, 4, flashIn); } );
			game.registerTimer(8, 1, function() { game.registerTimer(1, 4, flashOut); } );
			game.registerTimer(12, 1, function() { game.registerTimer(1, 4, flashIn); } );
		}
	}
	
}