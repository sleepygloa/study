using System;
namespace CSharp
{
    public class Program
    {
        //직업코드
        enum ClassType
        {
            None = 0,
            Knight = 1,
            Acher = 2,
            Mage = 3
        }

        struct Player
        {
            public int hp;
            public int attack;
            //public ClassType type;
        }

        //직업선택
        static ClassType ChooseClass() {
            Console.WriteLine("직업을 선택하세요");
            Console.WriteLine("[1] 기사");
            Console.WriteLine("[2] 궁수");
            Console.WriteLine("[3] 법사");

            ClassType choice = ClassType.None;
            String input = Console.ReadLine();
            switch (input)
            {
                case "1":
                    choice = ClassType.Knight;
                    break;
                case "2":
                    choice = ClassType.Acher;
                    break;
                case "3":
                    choice = ClassType.Mage;
                    break;
            }

            return choice;
        }

        //캐릭터생성
        //기사(100/10), 궁수(75/12), 법사(50/15)
        static void CreatePlayer(ClassType choice, out Player player)
        {
            switch (choice)
            {
                case ClassType.Knight:
                    player.hp = 100;
                    player.attack = 10;
                    break;
                case ClassType.Acher:
                    player.hp = 75;
                    player.attack = 12;
                    break;
                case ClassType.Mage:
                    player.hp = 50;
                    player.attack = 15;
                    break;
                default:
                    player.hp = 0;
                    player.attack = 0;
                    break;
            }
        }

        static void Main(String[] args){

            while (true)
            {
                ClassType choice = ChooseClass();
                if (choice != ClassType.None)
                {
                    //캐릭터 생성
                    Player player;
                    CreatePlayer(choice, out player);

                    Console.WriteLine($"HP{player.hp} Attack{player.attack}");

                    //break;
                }
            }
        }
    }
}

