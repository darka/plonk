package 
{
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class Level extends GameObject
	{
		public var playfield:Playfield;
		public var name:String;
		public var outline:String;
		public function Level(game_:Game)
		{
			super(game_);
			playfield = game.getPlayfield();
			name = "FAEN";
			outline = "faen";

		}
		
		public function start()
		{
			
		}
		
		public function is_finished():Boolean
		{
			return true;
		}
	}
	
}