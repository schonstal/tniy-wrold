package 
{
  import org.flixel.*;

  public class LargeEnemySprite extends EnemySprite 
  {
    public static const WEINER:Number = 8008135;

    public function LargeEnemySprite() {
      super();
      loadGraphic(Assets.Fatty, true, true, 32, 32, false);
      walkSpeed = 10;
      minSize = 8;
      maxSize = 12;
      lowVelocity = -150;
      baseAngular = 100;
      shakeAmount = 0.2;
      create();
    }
  }
}
