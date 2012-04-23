package
{
  import org.flixel.*;

  public class Assets
  {
    [Embed(source = "../data/letters.png")] public static var Letters:Class;
    [Embed(source = "../data/lettersBig.png")] public static var LettersBig:Class;
    [Embed(source = "../data/enemy.png")] public static var Enemy:Class;
    [Embed(source = "../data/enemyShadow.png")] public static var EnemyShadow:Class;
    [Embed(source = "../data/fatty.png")] public static var Fatty:Class;
    [Embed(source = "../data/fattyShadow.png")] public static var FattyShadow:Class;
    [Embed(source = "../data/background.png")] public static var Background:Class;
    [Embed(source = "../data/foreground.png")] public static var Foreground:Class;
    [Embed(source = "../data/gameOver.png")] public static var GameOver:Class;

    [Embed(source = "../data/music.swf", symbol="gameplayMusic")] public static var GameplayMusic:Class;
  }
}
