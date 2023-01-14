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

        enum MonsterType
        {
            None = 0,
            Slime = 1,
            Orc = 2,
            Skeleton = 3
        }

        struct Monster
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

        //몬스터생성
        static void CreateRandomMonster(out Monster monster)
        {
            Random rand = new Random();
            int randMonster = rand.Next(1, 4);
            switch (randMonster)
            {
                case (int)MonsterType.Slime:
                    Console.WriteLine("슬라임이 스폰되었습니다!");
                    monster.hp = 20;
                    monster.attack = 2;
                    break;
                case (int)MonsterType.Orc:
                    Console.WriteLine("오크가 스폰되었습니다!");
                    monster.hp = 40;
                    monster.attack = 4;
                    break;
                case (int)MonsterType.Skeleton:
                    Console.WriteLine("스켈레톤이 스폰되었습니다!");
                    monster.hp = 30;
                    monster.attack = 3;
                    break;
                default:
                    monster.hp = 0;
                    monster.attack = 0;
                    break;
            }
        }

        //필드입장
        static void EnterField()
        {
            Console.WriteLine("필드에 접속했습니다!");

            //몬스터 생성
            //랜덤으로 1~3 몬스터 중 하나를 리스폰
            Monster monster;
            CreateRandomMonster(out monster);

            Console.WriteLine("[1] 전투 모드로 돌입");
            Console.WriteLine("[2] 일정 확률로 마을로 도망");
        }

        //게임입장
        static void EnterGame()
        {
            while (true)
            {
                Console.WriteLine("게임에 접속했습니다!");
                Console.WriteLine("[1] 필드로 나간다");
                Console.WriteLine("[2] 로비로 돌아간다");

                string input = Console.ReadLine();
                if(input == "1")
                {
                    EnterField();
                }
                else if(input == "2")
                {
                    break;
                }
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

                    EnterGame();
                }
            }
        }
    }
}

