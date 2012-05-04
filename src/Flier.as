package 
{
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class Flier extends Enemy 
	{
		private const velocityCoef:Number = 3.0;
		public function Flier(game_:Game, id_:Number, position_:Vec, player_:Player)
		{
			super(game_, id_, new FlierSprite(), 20, position_, player_);
			
			var angle:Number = aim(player.position);
			sprite.rotation = 90 + angle * 180.0 / Math.PI;
			velocity = new Vec(Math.cos(angle), Math.sin(angle));
			velocity = velocity.mult(velocityCoef);
			
			makeColidable(16);
			
		}
		
		public override function update()
		{
			position = position.add(velocity);
			super.update();
			spawnBubblesAroundMaybe();
		}
		
		public override function handlePlayerCollision()
		{
			health -= 20;
			player.health -= 10;
			Fading.quickFlash(game, player.sprite);
		}
		
		public override function die()
		{
			game.getPlayfield().addExplosion(position);
			markAsUnusedInArray();
		}
		
		public function handleBulletCollision(bullet:PlayerBullet)
		{
			health -= 20;
			bullet.markAsUnusedInArray();
			game.score += 10;
		}
		
	}
}