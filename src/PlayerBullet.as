package 
{
	
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerBullet extends IdTrackedPlayfieldObject 
	{
		protected var direction;
		private const speed = 6;
		public function PlayerBullet(game_:Game, id_:Number, position_:Vec, direction_:Vec)
		{
			super(game_, id_, new PlayerBulletSprite(), position_);
			makeColidable(10);
			
			direction = direction_;
		}

		public override function update()
		{
			position = position.add(direction.mult(speed));
			super.update();
		}
	}
	
}