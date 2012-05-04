package  
{
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class Vec 
	{
		public var x:Number;	
		public var y:Number;

		public function Vec(x_:Number, y_:Number) 
		{
			x = x_;
			y = y_;
		}
		
		public function add(other:Vec):Vec
		{
			return new Vec(x + other.x, y + other.y);
		}
		
		public function sub(other:Vec):Vec
		{
			return new Vec(x - other.x, y - other.y);
		}
		
		public function dot(other:Vec):int
		{
			return x*other.x + y*other.y;
		}
		
		public function mult(n:Number):Vec
		{
			return new Vec(x * n, y * n);
		}
		
		public function length():Number
		{
			return Math.sqrt(x * x + y * y);
		}
		
		public function normal():Vec
		{
			return this.mult(1.0 / length());
		}
		
		public function copy():Vec
		{
			return new Vec(x, y);
		}
		
	}
	
}