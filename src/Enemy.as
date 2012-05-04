package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class Enemy extends IdTrackedPlayfieldObject
	{
		protected var velocity;
		protected var player:Player;
		
		public var health:Number;
		
		public function Enemy(game_:Game, id_:Number, sprite_:MovieClip, health_:Number, position_:Vec, player_:Player) 
		{
			super(game_, id_, sprite_, position_);
			player = player_;
			health = health_;
		}
		
		protected function aim(target:Vec):Number
		{
			return Math.atan2(target.y - position.y, target.x - position.x);
		}
		
		public override function update()
		{
			if (health <= 0)
			{
				die();
			}
			super.update();
		}
		
		public function die()
		{
			
		}
		
	}
	
}