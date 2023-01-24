using System;
namespace CSharp
{
    public class Program
    {
        public Program()
        {
        }

        static void Main(string[] args)
        {
            Game game = new Game();
            while (true)
            {
                game.Process();
            }
        }
    }
}

