package 
{
	
	/**
	 * ...
	 * @author Darius Ščerbavičius
	 */
	public class Seeker extends Enemy 
	{
		private const velocityCoef:Number = 2.0;
		
		public function Seeker(game_:Game, id_:Number, position_:Vec, player_:Player)
		{
			super(game_, id_, new HomingShipSprite(), 20, position_, player_);

			makeColidable(16);
			aimAtPlayer();
			
		}
		
		public function aimAtPlayer()
		{
			var angle:Number = aim(player.position);
			velocity = new Vec(velocityCoef * Math.cos(angle),
		                       velocityCoef * Math.sin(angle));
			sprite.rotation = 90 + angle * 180.0 / Math.PI;
		}
		
		public override function update()
		{
			if (!player.dead)
			{
				aimAtPlayer();
			}
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