package 
{
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class WhiteFade extends MenuEffect 
	{
		public function WhiteFade(game_:Game)
		{
			super(game_);
			sprite = new WhiteFadeSprite();
			game.addChild(sprite);
		}
		
		public function update()
		{
			if (sprite.currentFrame == sprite.totalFrames)
			{
				sprite.stop();
				markAsUnusedInArray();
			}
		}
	}
	
}