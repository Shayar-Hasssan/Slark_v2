using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Slark.Models
{

    public class RegisterViewModels
    {
        public string Email { get; set; }
        public string Password { get; set; }
        public string Name { get; set; }


    }
  
    public class LoginViewModels
    {
        public string Email { get; set; }
        public string Password { get; set; }
    }

    public class WorkSpaceViewModel
    {
        public string Id { get; set; }
        public string WsName { get; set; }
        public bool Ismine { get; set; }

    }
    public class SpaceViewModel
    {
        public string Id { get; set; }
        public string Name { get; set; }

    }

   public class Activity
    {
        public string Name { get; set; }
        public int Duration { get; set; }
        public List<string> Dependencies { get; set; }
        public int EStart { get; set; }
        public int EFinish { get; set; }
        public int LStart { get; set; }
        public int LFinish { get; set; }
        private int steps = 0;

        public Activity(string name, int time)
        {
            EStart = -1;
            EFinish = 0;
            LStart = 0;
            LFinish = 0;
            Name = name;
            Duration = time;
            steps = time;
        }

        public void Step(int count)
        {
            EStart = (EStart == -1) ? count : EStart;
            if (--steps == 0) EFinish = count + 1;
        }

        public bool Done()
        {
            return steps == 0;
        }
    }
}