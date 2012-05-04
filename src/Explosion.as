package 
{
	import flash.media.Sound;
	/**
	 * ...
	 * @author ...
	 */
	public class Explosion extends PlayfieldObject 
	{
		private var sound:Sound;
		public function Explosion(game_:Game, position_:Vec)
		{
			super(game_, new ExplosionSprite(), position_);
			sound = new ExplosionSound();
			sound.play();
		}
		
		public override function update()
		{
			if (sprite.currentFrame == sprite.totalFrames - 1)
			{
				sprite.stop();
				markAsUnusedInArray();
			}
			super.update();
		}
		
	}
	
}