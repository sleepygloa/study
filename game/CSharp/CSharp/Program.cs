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
                    choice = ClassType.Knight;
                    break;
                case "3":
                    choice = ClassType.Knight;
                    break;
            }

            return choice;
        }

        static void Main(String[] args){

            while (true)
            {
                ClassType choice = ChooseClass();
                if (choice != ClassType.None)
                    break;
            }
        }
    }
}

