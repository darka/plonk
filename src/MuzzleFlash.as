package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	// TODO: this is the same as Explosion so make it so
	public class MuzzleFlash extends PlayfieldObject 
	{
		private var player;
		public function MuzzleFlash(game_:Game, player_:Player, rotation:Number)
		{
			player = player_;
			super(game_, new MuzzleFlashSprite(), player_.position);
			sprite.rotation = rotation;
		}
		
		public override function update()
		{
			position = player.position;
			super.update();
			if (sprite.currentFrame == sprite.totalFrames - 1)
			{
				sprite.stop();
				markAsUnusedInArray();
			}
			
		}
		
	}
	
}