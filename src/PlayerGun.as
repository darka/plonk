package  
{
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class PlayerGun extends PlayfieldObject
	{
		private var mousePosition:Vec;
		
		public var angle:Number;
		
		public function PlayerGun(game_:Game)
		{
			super(game_, new PlayerGunSprite(), new Vec(0, 0));
			mousePosition = new Vec(0, 0);
			angle = 0;
		}
		
		private function adjustGun()
		{
			var diff:Vec = mousePosition.sub(position);
			angle = Math.atan2(diff.y, diff.x);
			//sprite.rotation = (angle + Math.PI) * 180 / Math.PI - 90;
			sprite.rotation = 180 * angle / Math.PI + 90;
		}
		
		public function trackMouse(mousePosition_:Vec)
		{
			mousePosition = mousePosition_;
		}
		
		public override function update()
		{
			super.update();
			adjustGun();
		}
	}
	
}