package 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class IdTrackedPlayfieldObject extends PlayfieldObject
	{
		public var id:Number; // the id is used to determine the position of playfield objects
		                      // in their respective specialized arrays (bullets for Bullet,
							  // enemies for Enemy, for example)
							  // In this way we can check for collision while iterating only
							  // the important elements
		
		public function IdTrackedPlayfieldObject(game_:Game, id_:Number, sprite_:MovieClip, position_:Vec)
		{
			super(game_, sprite_, position_);
			id = id_;
		}
	}
	
}