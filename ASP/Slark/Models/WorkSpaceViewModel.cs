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


    public class LoginRegisterViewMode
    {
        public string userid { get; set; }
        public string Email { get; set; }
        public string username { get; set; }
        public List<WorkSpaceViewModel> WorkSpaces { get; set; }
        
    }






    public class WorkSpaceViewModel
    {
        public string Id { get; set; }
        public string WsName { get; set; }
        public bool Ismine { get; set; }
        public List<SpaceViewModel> spaces { get; set; }


    }
    public class SpaceViewModel
    {
        public string Id { get; set; }
        public string Name { get; set; }

    }

    public class HomeViewModel
    {
        public List<UserListViewModel> recentChat { get; set; }
        public List<ProjectsViewModel> Projects { get; set; }
        public List<SpaceViewModel> spaces { get; set; }
    }


   
    public class ProjectsViewModel
    {
        public string id { get; set; }
        public string Name { get; set; }
        public string Percentage { get; set; }
        public string CreationDate { get; set; }
    }
    public class UserListViewModel
    {
        public string id { get; set; }
        public string Email { get; set; }
    }

    public class TeamViewModel  
    {
        public string id { get; set; }
        public string Name { get; set; }
        public List<MemberViewModel> members { get; set; }
    }

    public class MemberViewModel
    {
        public string id { get; set; }
        public string userid { get; set; }
        public string Name { get; set; }
        public string isTeamLeader { get; set; }
    }
    public class messagerespViewModel
    {
        public string msg { get; set; }
      
    }

    public class PrivateMessageUserViewModel
    {
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

    public class MemberListViewModel
    {
        public string userid { get; set; }
        public string Name { get; set; }
    }

    public class AddteamviewModel
    {
        public string wksid { get; set; }
        public string teamname { get; set; }
        public List<string> membid { get; set; }
        public string leadid { get; set; }
    }

    public class crit
    {
        public string name { get; set; }
        public string estart { get; set; }
        public string efinish { get; set; }
        public string lstart { get; set; }
        public string lfinish { get; set; }
        public string critical { get; set; }
    }

    public class ProjectsListViewModel
    {
        public string id { get; set; }
        public string Name { get; set; }
    }
    public class ProjectsDetailsViewModel
    {
        public string id { get; set; }
        public string Name { get; set; }
        public string Percentage { get; set; }
        public string CreationDate { get; set; }
        public List<TaskViewModel>tasks { get; set; }
    }
    public class TaskViewModel
    {
        public string taskname { get; set; }
        public System.DateTime TaskEndDate { get; set; }
        public double DonePrecentage { get; set; }
        public string username { get; set; }
    }
}