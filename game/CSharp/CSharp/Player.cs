using System;
namespace CSharp
{
    public enum PlayerType {
            None = 0,
            Knight = 1,
            Archer = 2,
            Mage = 3
    }
    class Player : Creature
    {
        protected PlayerType _type = PlayerType.None;

        public Player(PlayerType type) : base(CreatureType.Player)
        {
            this._type = type;
        }

        public PlayerType GetPlayerType()
        {
            return _type;
        }
    }
    class Knight : Player
    {
        public Knight() : base(PlayerType.Knight)
        {
            SetInfo(100, 10);
        }
    }
    class Mage : Player
    {
        public Mage() : base(PlayerType.Mage)
        {
            SetInfo(75, 12);
        }
    }
    class Archer : Player
    {
        public Archer() : base(PlayerType.Archer)
        {
            SetInfo(50, 15);
        }
    }
}

