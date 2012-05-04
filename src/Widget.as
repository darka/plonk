package 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class Widget extends OptimalArrayObject
	{
		
		public var position:Vec;
		
		protected var velocity:Vec;
		protected var moving:Boolean;
		protected var accelerating:Boolean;
		protected var decelerating:Boolean;
		
		private var acceleration:Number;
		private var deceleration:Number;
		private var maxSpeed:Number;
		
		public function Widget(game_:Game)
		{
			super(game_);
			//moving = false;
			accelerating = false;
			decelerating = false;
		}
		/*public function arriveWithSlowDown(speed:Number, destination:Vec)
		{
			moving = true;
			velocity = destination.sub(position).normal().mult(speed);
			friction = 1.0 - 1.0 / ( (destination.sub(position).length()/speed) );
			trace(friction);
		}*/
		
		public function arriveWithSlowDown(direction:Vec, acceleration_:Number, maxSpeed_:Number, deceleration_:Number)
		// accelerates until it reaches maxSpeed, then decelerates using deceleration
		{
			moving = true;
			accelerating = true;
			acceleration = acceleration_;
			deceleration = deceleration_;
			maxSpeed = maxSpeed_;
			velocity = direction.normal();
			//friction = 1.0 - 1.0 / ( (destination.sub(position).length()/speed) );
			//trace(friction);
		}
		
		public function update()
		{
			if (moving)
			{
				if (accelerating)
				{
					velocity = velocity.mult(acceleration);
					if (velocity.length() > maxSpeed)
					{
						accelerating = false;
						decelerating = true;
					}
				}
				else if (decelerating)
				{
					velocity = velocity.mult(deceleration);
					if (velocity.length() < 0.1)
					{
						decelerating = false;
						moving = false;
					}
				}
				var newPosition = position.add(velocity);
				updatePosition(newPosition);
			}
		}
		
		public function updatePosition(newPosition:Vec)
		{
			position = newPosition;
		}
		
		public function unregister()
		{
			
		}
	}
}