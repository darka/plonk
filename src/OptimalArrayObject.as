package 
{
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class OptimalArrayObject extends GameObject
	{
		private var unusedInArray:Boolean;
		public function OptimalArrayObject(game_:Game)
		{
			super(game_);
			unusedInArray = false;
		}
		
		public function isUnusedInArray():Boolean
		{
			return unusedInArray;
		}
		
		public function markAsUnusedInArray()
		{
			if (!unusedInArray)
			{
				unusedCleanUp();
				unusedInArray = true;
			}
		}
		
		public function unusedCleanUp()
		{
			
		}
	}
	
}