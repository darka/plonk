package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class Bubble extends PlayfieldObject
	{
		private var speed:Number = 2;
		private var acceleration:Number;
	
		public function Bubble(game_:Game, position_:Vec) 
		{
			super(game_, new BubbleSprite(), position_ );
			acceleration = Math.random() * 0.05;
			game.registerTimer(30 + Math.random() * 30, 1, markAsUnusedInArray);
		}
		
		public override function update()
		{
			position.y -= speed;
			speed += acceleration;
			super.update();
		}
	}
}